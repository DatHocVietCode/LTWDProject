using MaterialDesignThemes.Wpf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Input;
using WPF_Market.View;
namespace WPF_Market.ViewModel
{
    public delegate void FilterProduct(List<string> types);
    public delegate void UpdateFilter(FilterProduct filterProduct);
    class MainBoardViewModel : BaseViewModel
    {
        // Fields
        FilterProduct filterProduct;
        List<string> types = new List<string>();
        // Constructor
        private Object currentContent;
        private bool cbElect = false;
        private bool cbHealth = false;
        private bool cbFashion = false;
        private bool cbJewell = false;
        private bool cbHealthBeauty = false;
        private bool cbBooks = false;
        private bool cbKidsBaies = false;
        private bool cbSports = false;
        private bool cbHomeGarden = false;
        public MainBoardViewModel()
        {
            HomeCommand = new BaseViewModelCommand(ExecuteHomeCommand);
            CartCommand = new BaseViewModelCommand(ExecuteCartCommand);
            ShopCommand = new BaseViewModelCommand(ExecuteShopCommand);
            CloseCommand = new BaseViewModelCommand(ExecuteCloseCommand);
            AccountCommand = new BaseViewModelCommand(ExecuteAccountCommand);
            BoughtCommand = new BaseViewModelCommand(ExecuteBoughtCommand);
            ExecuteHomeCommand(null);
        }
        private void UpdateFilterFromA(FilterProduct filter)
        {
            filterProduct = filter;
        }
        private void ExecuteBoughtCommand(object obj)
        {
            CloseDrawerHost(obj);
            CurrentContent = new Bought(); 
        }
        private void ExecuteCloseCommand(object obj)
        {
            App.Current.Shutdown();
        }

        private void ExecuteAccountCommand(object obj)
        {
            SetCbtoDefault();
            CloseDrawerHost(obj);
            CurrentContent = new Myinf();
        }

        private void ExecuteShopCommand(object obj)
        {
            SetCbtoDefault();
            CloseDrawerHost(obj);
            CurrentContent = new ShopUI();
        }

        private void CloseDrawerHost(object obj)
        {
            DrawerHost drawerHost = obj as DrawerHost;
            DrawerHost.CloseDrawerCommand.Execute(null, drawerHost);
        }
        private void ExecuteCartCommand(object obj)
        {
            SetCbtoDefault();
            CloseDrawerHost(obj);
            CurrentContent = new Cart();
        }

        private void ExecuteHomeCommand(object obj)
        {
            
            CloseDrawerHost(obj);
            UpdateFilter filterProduct = new UpdateFilter(UpdateFilterFromA);
            CurrentContent = new product(filterProduct);
            SetCbtoDefault();
        }
        // Commands
        public ICommand HomeCommand { get; }
        public ICommand CartCommand { get; }
        public ICommand ShopCommand { get; }
        public ICommand CloseCommand { get; }
        public ICommand AccountCommand { get; }
        public ICommand BoughtCommand { get; }
        public object CurrentContent
        {
            get { return currentContent; }
            set
            {
                if (currentContent != value)
                {
                    currentContent = value;
                    OnPropertyChanged(nameof(CurrentContent));
                }
            }
        }
        private void SetCbtoDefault()
        {
            CbHealth = false;
            CbFashion = false;
            cbJewell = false;
            CbHealthBeauty= false;
            CbBooks = false;
            CbKidsBaies = false;
            CbSports = false;
            CbHomeGarden = false;
            CbElect = false;
        }
        public bool CbHealth { get => cbHealth; set { cbHealth = value; 
                OnPropertyChanged(nameof(CbHealth));
                if (cbHealth == true) { types.Add("Health and Beauty"); } else types.Remove("Health and Beauty");
                filterProduct(types); } }
        public bool CbFashion { get => cbFashion; set { cbFashion = value; OnPropertyChanged(nameof(CbFashion)); if (CbFashion == true) { types.Add("Fashion and Clothing"); } else types.Remove("Fashion and Clothing"); filterProduct(types); } }
        public bool CbJewell { get => cbJewell; set { cbJewell = value; OnPropertyChanged(nameof(CbJewell)); if (CbJewell == true) { types.Add("Jewellery"); } else types.Remove("Jewellery"); filterProduct(types); } }
        public bool CbHealthBeauty { get => cbHealthBeauty; set { cbHealthBeauty = value; OnPropertyChanged(nameof(CbHealthBeauty)); if (CbHealthBeauty == true) { types.Add("Health and Beauty"); } else types.Remove("Health and Beauty"); filterProduct(types); } }
        public bool CbBooks { get => cbBooks; set { cbBooks = value; OnPropertyChanged(nameof(CbBooks)); if (CbBooks == true) { types.Add("Books"); } else types.Remove("Books"); filterProduct(types); } }
        public bool CbKidsBaies { get => cbKidsBaies; set { cbKidsBaies = value; OnPropertyChanged(nameof(CbKidsBaies)); if (CbKidsBaies == true) { types.Add("Kids and Babies"); } else types.Remove("Kids and Babies"); filterProduct(types); } }
        public bool CbSports { get => cbSports; set { cbSports = value; OnPropertyChanged(nameof(CbSports)); if (CbSports == true) { types.Add("Sports"); } else types.Remove("Sports"); filterProduct(types); } }
        public bool CbHomeGarden { get => cbHomeGarden; set { cbHomeGarden = value; OnPropertyChanged(nameof(CbHomeGarden)); if (CbHomeGarden == true) { types.Add("Home and Garden"); } else types.Remove("Home and Garden"); filterProduct(types); } }
        public bool CbElect { get => cbElect; set { cbElect = value; OnPropertyChanged(nameof(CbElect)); if (CbElect == true) { types.Add("Electronics"); } else types.Remove("Electronics"); filterProduct(types); } }
    }
}
