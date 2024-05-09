using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
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
        private Shop shop = new Shop();
      
        private bool isEdit = false;
        private bool isShow = true;
        private bool editVisibility = false;
        string relativePath;
        string absolutePath;
        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        public bool IsEdit { get => isEdit; set { isEdit = value; OnPropertyChanged(nameof(IsEdit)); } }
        public bool IsShow { get => isShow; set { isShow = value; OnPropertyChanged(nameof(IsShow)); } }
        public bool EditVisibility { get => editVisibility; set { editVisibility = value; OnPropertyChanged(nameof(EditVisibility)); } }
        public string NameShop { get => shop.NameShop; set { shop.NameShop = value; OnPropertyChanged(nameof(NameShop)); } }
        public string Address { get => shop.Address; set { shop.Address = value; OnPropertyChanged(nameof(Address)); } }
        public string PhoneNumber { get => shop.PhoneNumber; set { shop.PhoneNumber = value; OnPropertyChanged(nameof(PhoneNumber)); } }
        public string Email { get => shop.Email; set { shop.Email = value; OnPropertyChanged(nameof(Email)); } }
        public string Slogan { get => shop.Slogan; set { shop.Slogan = value; OnPropertyChanged(nameof(Slogan)); } }
        public string ShopAvatar { get => shop.ShopAvatar; set { shop.ShopAvatar = value; OnPropertyChanged(nameof(ShopAvatar)); } }
        public DateTime CreateDate { get => (DateTime)(shop.CreateDate)?.Date; }
        public ShopGuestViewModel(Shop shop, bool EditVisibility)
        {
            this.Shop = shop;
            this.Shop.Comments = DataProvider.Instance.DB.Shops.Where(p=>p.IDShop == this.Shop.IDShop).SelectMany(p => p.Comments).ToList();
            this.EditVisibility = EditVisibility;
            GetShopProduct();
            OrderByPriority(1);
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
            SetCbtoDefault();
            ReloadCommand = new BaseViewModelCommand(ExecuteReloadCommand);
            SeeCommentsDetail = new BaseViewModelCommand(ExecuteSeeCommentsDetail);
            EditCommand = new BaseViewModelCommand(ExecuteEditCommand);
            ChangeAvatar = new BaseViewModelCommand(ExecuteChangeAvatar);
            relativePath = @"ShopAvatar\" + CurrentApplicationStatus.CurrentID.ToString() + @"\";
            absolutePath = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin")) + relativePath;
            SaveCommand = new BaseViewModelCommand(ExecuteSaveCommand, CanExecuteSaveCommand);
        }

        private bool CanExecuteSaveCommand(object obj)
        {
            return CheckValidInfor();
        }

        private bool CheckValidInfor()
        {
            if (string.IsNullOrEmpty(PhoneNumber) || string.IsNullOrEmpty(Email))
                return false;
            return (PhoneNumber.Length == 10 && PhoneNumber[0] == '0' && Email.Contains("@gmail.com") && !string.IsNullOrEmpty(Slogan) 
                && !string.IsNullOrEmpty(NameShop));
        }

        private void ExecuteSaveCommand(object obj)
        {
            IsShow = true;
            IsEdit = false;
            DataProvider.Instance.DB.SaveChanges();
            new Custom_mb("Successfully edit your information!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
        }

        private void ExecuteChangeAvatar(object obj)
        {
            try
            {
                Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog();
                if (openFileDialog.ShowDialog() == true)
                {
                    if (openFileDialog.FileName != "")
                    {
                        if (!File.Exists(absolutePath))
                        {
                            Directory.CreateDirectory(absolutePath);
                        }
                        string sourceFilePath = openFileDialog.FileName;
                        string destinationFilePath = Path.Combine(absolutePath, Path.GetFileName(sourceFilePath));

                        File.Copy(sourceFilePath, destinationFilePath, true);
                        ShopAvatar = Path.Combine(relativePath, Path.GetFileName(sourceFilePath));
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error opening folder: " + ex.Message);
            }
        }

        private void ExecuteEditCommand(object obj)
        {
            IsEdit = true;
            IsShow = true;
            new Custom_mb("To save your works, please ensure you clicked save button!", Custom_mb.MessageType.Info, Custom_mb.MessageButtons.Ok).ShowDialog();
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
            Shop.Inventories = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == Shop.IDShop).SelectMany(p => p.Inventories).ToList();
            lst = Shop.Inventories.ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
        }
        public ShopGuestViewModel()
        {
        }
        public ICommand SeeDetailCommand { get; }
        public ICommand SeeCommentsDetail {  get; }
        public ICommand EditCommand { get; }
        public ICommand ChangeAvatar { get; }
        public ICommand SaveCommand {  get; }
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
