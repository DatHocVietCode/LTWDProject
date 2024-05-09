using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using WPF_Market.Models;
using WPF_Market.View;
namespace WPF_Market.ViewModel
{
    public class ListProductViewModel : BaseViewModel
    {
     
       
        private ObservableCollection<Inventory> favProductList = new ObservableCollection<Inventory>();
        private IShowProductDetail showProductDetail;
        
        public ListProductViewModel()
        {
            GetProductDataFromDataBase();
            ReloadCommand = new BaseViewModelCommand(ExecuteReloadCommand);
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
        }
      
     
        public ObservableCollection<Inventory> FavProductList { get => favProductList; set { favProductList = value; OnPropertyChanged(nameof(FavProductList)); } }

        private void GetProductDataFromDataBase()
        {
            lst = DataProvider.Instance.DB.Inventories.Include(p=>p.IDShopNavigation).Include(p=>p.ImageLinks).Include(p=>p.IDUsers).Where(p=>p.IDShop!= CurrentApplicationStatus.CurrentID).ToList().OrderByDescending(p=>p.Priority).ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
            favlst = DataProvider.Instance.DB.Inventories.Include(p => p.IDUsers).Include(p => p.IDShopNavigation).Include(p => p.ImageLinks).Where(p => p.IDShop != CurrentApplicationStatus.CurrentID).Where(p=>p.IDUsers.Contains(CurrentApplicationStatus.CurrentUser)).OrderByDescending(p => p.Priority).ToList();
            FavProductList = new ObservableCollection<Inventory>(favlst);
        }
        public ICommand SeeDetailCommand { get; }

        private void ExecuteSeeDetailCommand(object obj)
        {
            var product = (Inventory)obj;
            var shop = product.IDShopNavigation;
            shop.Visits++;
            product.Priority++;
            DataProvider.Instance.DB.SaveChanges();
            showProductDetail = new DisplayDetailProduct();
            showProductDetail.ShowProductDetail((Inventory)obj);
        }
        #region Filter
        private List<Inventory> lst = new List<Inventory>();
        private List<Inventory> favlst = new List<Inventory>();
        List<string> types = new List<string>();
        private bool cbElect = false;
        private bool cbHealth = false;
        private bool cbFashion = false;
        private bool cbJewell = false;
        private bool cbHealthBeauty = false;
        private bool cbBooks = false;
        private bool cbKidsBaies = false;
        private bool cbSports = false;
        private bool cbHomeGarden = false;
        private float minPrice = 0;
        private float maxPrice = 0;
        private bool minMax = false;
        private bool maxMin = false;
        private string searchText = string.Empty;
        private ObservableCollection<Inventory> productList = new ObservableCollection<Inventory>();
        public bool CbHealth
        {
            get => cbHealth; set
            {
                cbHealth = value;
                OnPropertyChanged(nameof(CbHealth));
                if (cbHealth == true) { Types.Add("Health and Beauty"); } else Types.Remove("Health and Beauty");

            }
        }
        public bool CbFashion { get => cbFashion; set { cbFashion = value; OnPropertyChanged(nameof(CbFashion)); if (CbFashion == true) { Types.Add("Fashion and Clothing"); } else Types.Remove("Fashion and Clothing"); FilterByType(); } }
        public bool CbJewell { get => cbJewell; set { cbJewell = value; OnPropertyChanged(nameof(CbJewell)); if (CbJewell == true) { Types.Add("Jewellery"); } else Types.Remove("Jewellery"); FilterByType(); } }
        public bool CbHealthBeauty { get => cbHealthBeauty; set { cbHealthBeauty = value; OnPropertyChanged(nameof(CbHealthBeauty)); if (CbHealthBeauty == true) { Types.Add("Health and Beauty"); } else Types.Remove("Health and Beauty"); FilterByType(); } }
        public bool CbBooks { get => cbBooks; set { cbBooks = value; OnPropertyChanged(nameof(CbBooks)); if (CbBooks == true) { Types.Add("Books"); } else Types.Remove("Books"); FilterByType(); } }
        public bool CbKidsBaies { get => cbKidsBaies; set { cbKidsBaies = value; OnPropertyChanged(nameof(CbKidsBaies)); if (CbKidsBaies == true) { Types.Add("Kids and Babies"); } else Types.Remove("Kids and Babies"); FilterByType(); } }
        public bool CbSports { get => cbSports; set { cbSports = value; OnPropertyChanged(nameof(CbSports)); if (CbSports == true) { Types.Add("Sports"); } else Types.Remove("Sports"); FilterByType(); } }
        public bool CbHomeGarden { get => cbHomeGarden; set { cbHomeGarden = value; OnPropertyChanged(nameof(CbHomeGarden)); if (CbHomeGarden == true) { Types.Add("Home and Garden"); } else Types.Remove("Home and Garden"); FilterByType(); } }
        public bool CbElect { get => cbElect; set { cbElect = value; OnPropertyChanged(nameof(CbElect)); if (CbElect == true) { Types.Add("Electronics"); } else Types.Remove("Electronics"); FilterByType(); } }

        public List<string> Types { get => types; set { types = value; OnPropertyChanged(nameof(Types)); FilterByType(); } }
        public ObservableCollection<Inventory> ProductList { get => productList; set { productList = value; OnPropertyChanged(nameof(ProductList)); } }
        public float MinPrice { get => minPrice; set { minPrice = value; OnPropertyChanged(nameof(minPrice)); SearchByRangePrice(); } }
        public float MaxPrice { get => maxPrice; set { maxPrice = value; OnPropertyChanged(nameof(MaxPrice)); SearchByRangePrice(); } }

        public bool MinMax { get => minMax; set { minMax = value; OnPropertyChanged(nameof(MinMax)); ReOrder(0); } }
        public bool MaxMin { get => maxMin; set { maxMin = value; OnPropertyChanged(nameof(MaxMin)); ReOrder(1); } }

        public string SearchText { get => searchText; set { searchText = value; OnPropertyChanged(nameof(SearchText)); SearchByName(); } }
        public ICommand ReloadCommand { get; }
        private void FilterByType()
        {
            ProductList = new ObservableCollection<Inventory>(lst);
            var ItemToRemove = new ObservableCollection<Inventory>();
            if (!string.IsNullOrWhiteSpace(searchText))
            {
                foreach (var item in ProductList)
                {
                    if (!item.Name.ToLower().Contains(SearchText.ToLower()))
                    {
                        ItemToRemove.Add(item);
                    }
                }
            }
            RemoveItem(ItemToRemove);

            ItemToRemove = new ObservableCollection<Inventory>();
            if (Types.Count > 0)
            {
                foreach (var item in ProductList)
                {
                    if (!Types.Contains(item.Type))
                        ItemToRemove.Add(item);
                }
            }
            RemoveItem(ItemToRemove);

            ItemToRemove = new ObservableCollection<Inventory>();
            if (MinPrice != 0 && MaxPrice != 0)
            {
                foreach (var item in ProductList)
                {
                    if (item.CurrentPrice < MinPrice || item.CurrentPrice > MaxPrice)
                    {
                        ItemToRemove.Add(item);
                    }
                }
            }
            RemoveItem(ItemToRemove);
        }

        private void RemoveItem(ObservableCollection<Inventory> itemToRemove)
        {
            foreach (var item in itemToRemove)
            {
                ProductList.Remove(item);
            }
        }

        private void SearchByName()
        {
            FilterByType();
            OrderByPriority(1);
        }
        /// <summary>
        ///  0 nếu order tăng dần, 1 để order giảm dần, dùng ProductList hiện tại mà không lấy lại từ CSDL
        /// </summary>
        /// <param name="orderway"></param>
        private void OrderByPriority(int orderway)
        {
            if (orderway == 0)
                ProductList = new ObservableCollection<Inventory>(ProductList.OrderBy(p => p.Priority));
            else
                ProductList = new ObservableCollection<Inventory>(ProductList.OrderByDescending(p => p.Priority));
        }
        /// <summary>
        /// 0 nếu order tăng dần, 1 để order giảm dần, dùng ProductList hiện tại mà không lấy lại từ CSDL
        /// </summary>
        /// <param name="orderway"></param>
        private void ReOrder(int orderway)
        {
            if (orderway == 0)
                ProductList = new ObservableCollection<Inventory>(ProductList.OrderBy(p => p.CurrentPrice));
            else
                ProductList = new ObservableCollection<Inventory>(ProductList.OrderByDescending(p => p.CurrentPrice));
        }
        /// <summary>
        ///  order trong khoảng min tới max và tạo mới ProductList từ cơ sở dữ liệu
        /// </summary>
        private void SearchByRangePrice()
        {
            FilterByType();
            OrderByPriority(1);
        }
        private void ExecuteReloadCommand(object obj)
        {
            SetCbtoDefault();
            MinPrice = 0;
            MaxPrice = 0;
            MinMax = false;
            MaxMin = false;
            ProductList = new ObservableCollection<Inventory>(lst);
            OrderByPriority(1);
        }
        private void SetCbtoDefault()
        {
            CbHealth = false;
            CbFashion = false;
            CbJewell = false;
            CbHealthBeauty = false;
            CbBooks = false;
            CbKidsBaies = false;
            CbSports = false;
            CbHomeGarden = false;
            CbElect = false;
        }
        #endregion
    }
    public class DisplayDetailProduct : IShowProductDetail
    {
        private Window parentWindow;
        public DisplayDetailProduct()
        {

        }
        public Window ParentWindow { get => parentWindow; set => parentWindow = value; }

        public void ShowProductDetail(Inventory productModel)
        {
            detail_product product = new detail_product(productModel);          
            product.Owner = CurrentApplicationStatus.MainBoardWindow;
            CurrentApplicationStatus.MainBoardWindow.Hide();
            product.ShowDialog();
            CurrentApplicationStatus.MainBoardWindow.Show();
        }
    }
}
