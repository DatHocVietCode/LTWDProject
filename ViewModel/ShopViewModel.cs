using MaterialDesignThemes.Wpf;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    public class ShopViewModel : BaseViewModel
    {
      
        private int iDShop = CurrentApplicationStatus.CurrentID;
        private Shop shop = new Shop();
        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        public ShopViewModel()
        {
            GetProductFromDB();
            AddProductCommand = new BaseViewModelCommand(ExecuteAddProductCommand);
            DeleteProductCommand = new BaseViewModelCommand(ExecuteDeleteProductCommand);
            SeeProductDetail = new BaseViewModelCommand(ExecuteSeeDetailCommand);
            EditProductCommand = new BaseViewModelCommand(ExecuteEditProductCommand);
            SeeStatistical = new BaseViewModelCommand(ExecuteSeeStatistial, CanExecuteSeeStatistic);
            GuessView = new BaseViewModelCommand(ExecuteGuessView, CanExecuteGuessView);
            ReloadCommand = new BaseViewModelCommand(ExecuteReloadCommand);
        }

        private bool CanExecuteSeeStatistic(object obj)
        {
            return CheckValidInfor();
        }

        private bool CheckValidInfor()
        {
            if (ProductList.Count <= 0)
            {
               return false;
            }
            var sumVistPur = Shop.Visits + Shop.Purchases;
            float sumRevenue = 0;
            foreach (var product in ProductList)
            {
                sumRevenue += (float)product.Revenue;
            }
            if (sumRevenue > 0 && sumVistPur > 0)
                return true;
            return false;
        }

        private bool CanExecuteGuessView(object obj)
        {
            var yourShop = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == CurrentApplicationStatus.CurrentID).FirstOrDefault();
            if (yourShop != null)
            {
                return true;
            }
            return false;
        }

        private void ExecuteGuessView(object obj)
        {
            var currentShop = DataProvider.Instance.DB.Shops.Where(p=>p.IDShop == CurrentApplicationStatus.CurrentID).FirstOrDefault();
            var Guessview = new ShopUIGuest(currentShop, true);
            Guessview.Owner = CurrentApplicationStatus.MainBoardWindow;
            Guessview.ShowDialog();
        }

        private void ExecuteSeeStatistial(object obj)
        {

            var newWindow = new Statistic();
            newWindow.Owner = CurrentApplicationStatus.MainBoardWindow;
            newWindow.ShowDialog();
        }

        private void ExecuteEditProductCommand(object obj)
        {
            var inventory = (Inventory)obj;
            var detail = new Manage_Product(inventory);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        private void ExecuteSeeDetailCommand(object obj)
        {
            var inventory = (Inventory)obj;
            var detail = new detail_product(inventory);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        private void GetProductFromDB()
        {
            this.Shop = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == CurrentApplicationStatus.CurrentID).FirstOrDefault();
            Shop.Inventories = DataProvider.Instance.DB.Shops.Where(p=>p.IDShop == Shop.IDShop).SelectMany(p=>p.Inventories).Include(p=>p.ImageLinks).ToList();
            lst = Shop.Inventories.ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
        }
        private void ExecuteDeleteProductCommand(object obj)
        {
            try
            {
                var Product = obj as Inventory;
                var lstImage = DataProvider.Instance.DB.ImageLinks.Where(p => p.IDProduct == Product.IDProduct).ToList();
                foreach (var item in lstImage)
                {
                    DataProvider.Instance.DB.ImageLinks.Remove(item);
                }
                DataProvider.Instance.DB.SaveChanges();
                DataProvider.Instance.DB.Inventories.Remove(Product);
                DataProvider.Instance.DB.SaveChanges();
                ProductList.Remove(Product);
                new Custom_mb("Deleted!", Custom_mb.MessageType.Confirmation, Custom_mb.MessageButtons.Ok).ShowDialog();
            }
            catch (Exception)
            {

                new Custom_mb("The item can't be deleted because it is in using!", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();  
            }
          
        }

        private void ExecuteAddProductCommand(object obj)
        {
            var newWindow = new Manage_Product(null);
            newWindow.Owner = CurrentApplicationStatus.MainBoardWindow;
            newWindow.ShowDialog();
            GetProductFromDB();
        }
       
        public int IDShop { get => iDShop; set => iDShop = value; }
        public ICommand AddProductCommand { get; }
        public ICommand DeleteProductCommand { get; }
        public ICommand SeeProductDetail {  get; }
        public ICommand EditProductCommand { get; }
        public ICommand SeeStatistical {  get; }
        public ICommand GuessView {  get; }
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
}
