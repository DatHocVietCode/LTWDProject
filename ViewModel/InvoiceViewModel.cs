using MaterialDesignThemes.Wpf;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;
using Bought = WPF_Market.Models.Bought;

namespace WPF_Market.ViewModel
{
    class InvoiceViewModel : BaseViewModel
    {
        Bought detailInvoice = null;
        ObservableCollection<ProductInvoice.ProductInvoice> listItem = new ObservableCollection<ProductInvoice.ProductInvoice>();
        private float totalPrice = 0;
        public InvoiceViewModel(Bought bought)
        {
            DetailInvoice = bought;
            GetListItem();
            Comment = new BaseViewModelCommand(ExcuteComment);
        }

        private void ExcuteComment(object obj)
        {
            var item = obj as ProductInvoice.ProductInvoice;
           
            if (item.Inventory == null) 
            {
                new Custom_mb("Item has been deleted by owner!\nSorry for this inconvenient", Custom_mb.MessageType.Info, Custom_mb.MessageButtons.Ok).ShowDialog();
                return;
            }
            var shop = item.Inventory.IDShopNavigation;
            var cmt = new WriteComment(shop);

            cmt.Owner = CurrentApplicationStatus.MainBoardWindow;
            cmt.ShowDialog();
        }
        private void GetListItem()
        {
            var lst = DetailInvoice.LstProducts;
            var lstProduct = new List<ProductInvoice.ProductInvoice>();
            foreach (var item in lst)
            {
                var product = DataProvider.Instance.DB.Inventories.Where(p=>p.IDProduct == item.IDProduct).FirstOrDefault();
                var PI = new ProductInvoice.ProductInvoice(product, item);
                lstProduct.Add(PI);
            }
            ListItem = new ObservableCollection<ProductInvoice.ProductInvoice>(lstProduct);
        }
        public Bought DetailInvoice { get => detailInvoice; set { detailInvoice = value; OnPropertyChanged(nameof(DetailInvoice)); } }
        public ObservableCollection<ProductInvoice.ProductInvoice> ListItem { get => listItem; set { listItem = value; OnPropertyChanged(nameof(ListItem)); } }
        public ICommand Comment {  get; }
    
    }
}
