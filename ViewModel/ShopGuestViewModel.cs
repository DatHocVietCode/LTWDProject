using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Documents;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    class ShopGuestViewModel : BaseViewModel
    {
        private Shop shop;
        private ObservableCollection<Inventory> productList = new ObservableCollection<Inventory>();
        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        private bool writeCommand = true;
        public ObservableCollection<Inventory> ProductList { get => productList; set { productList = value; OnPropertyChanged(nameof(ProductList)); } }

        public ShopGuestViewModel(Shop shop, bool canWriteComment)
        {
            this.Shop = shop;
            GetShopProduct();
            WriteCommand = canWriteComment;
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
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
        public bool WriteCommand { get => writeCommand; set { writeCommand = value; OnPropertyChanged(nameof(WriteCommand)); } }
    }
}
