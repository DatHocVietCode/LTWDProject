using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    class ShopGuestViewModel : BaseViewModel
    {
        private Shop shop;
        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        private bool writeCommand = true;
        public ShopGuestViewModel(Shop shop, bool canWriteComment)
        {
            this.Shop = shop;
            this.Shop.Comments = DataProvider.Instance.DB.Shops.Where(p=>p.IDShop == this.Shop.IDShop).SelectMany(p => p.Comments).ToList();
            GetShopProduct();
            OrderByPriority(1);
            WriteCommand = canWriteComment;
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
            SetCbtoDefault();
            ReloadCommand = new BaseViewModelCommand(ExecuteReloadCommand);
            SeeCommentsDetail = new BaseViewModelCommand(ExecuteSeeCommentsDetail);
        }

        private void ExecuteSeeCommentsDetail(object obj)
        {
            var seecomment = new SeeComment(Shop);
            var parentWindow = obj as Window;
            seecomment.Owner = parentWindow;
            seecomment.ShowDialog();
        }

      

        private void ExecuteSeeDetailCommand(object obj)
        {
            var product = (Inventory)obj;
            product.Priority++;
            DataProvider.Instance.DB.SaveChanges();
            var detail = new detail_product(product);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }
        private void GetShopProduct()
        {
            var lst = Shop.Inventories.ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
        }
        public ShopGuestViewModel()
        {
        }
        public ICommand SeeDetailCommand { get; }
        public ICommand SeeCommentsDetail {  get; }
        public bool WriteCommand { get => writeCommand; set { writeCommand = value; OnPropertyChanged(nameof(WriteCommand)); } }
        #region Filter
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
        private float minPrice;
        private float maxPrice;
        private bool minMax = false;
        private bool maxMin = false;
        private string searchText;
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
            if (Types.Count == 0)
            {
                var lst = DataProvider.Instance.DB.Inventories.Include(p => p.IDShopNavigation).Include(p => p.ImageLinks).ToList();
                ProductList = new ObservableCollection<Inventory>(lst);
                return;
            }
            else
            {
                var lst = DataProvider.Instance.DB.Inventories.Include(p => p.IDShopNavigation).Include(p => p.ImageLinks).Where(p => Types.Contains(p.Type)).ToList();
                ProductList = new ObservableCollection<Inventory>(lst);
            }
        }
        private void SearchByName()
        {
            var lst = DataProvider.Instance.DB.Inventories.Include(p => p.IDShopNavigation).Include(p => p.ImageLinks)
                .Where(p => p.Name.ToLower().Contains(SearchText.ToLower())).ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
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
            if (MinPrice > maxPrice)
                return;
            var lst = DataProvider.Instance.DB.Inventories.Include(p => p.ImageLinks)
                .Include(p => p.IDShopNavigation).Where(p => p.CurrentPrice >= MinPrice && p.CurrentPrice <= maxPrice).ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
            OrderByPriority(1);
        }
        private void ExecuteReloadCommand(object obj)
        {
            SetCbtoDefault();
            MinPrice = 0;
            MaxPrice = 0;
            MinMax = false;
            MaxMin = false;
            var lst = DataProvider.Instance.DB.Inventories.Include(p => p.IDShopNavigation)
                .Include(p => p.ImageLinks).ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
            OrderByPriority(1);
        }
        private void SetCbtoDefault()
        {
            CbHealth = false;
            CbFashion = false;
            cbJewell = false;
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
