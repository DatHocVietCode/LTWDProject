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
        ObservableCollection<LstProduct> listItem = new ObservableCollection<LstProduct>();
        private float totalPrice = 0;
        public InvoiceViewModel(Bought bought)
        {
            DetailInvoice = bought;
            GetListItem();
            Comment = new BaseViewModelCommand(ExcuteComment);
        }

        private void ExcuteComment(object obj)
        {
            var item = obj as LstProduct;
            var shop = item.IDProductNavigation.IDShopNavigation;
            var cmt = new WriteComment(shop);

            cmt.Owner = CurrentApplicationStatus.MainBoardWindow;
            cmt.ShowDialog();
        }

        private void GetListItem()
        {
            var lst = DetailInvoice.LstProducts;
            ListItem = new ObservableCollection<LstProduct>(lst);
        }

        public Bought DetailInvoice { get => detailInvoice; set { detailInvoice = value; OnPropertyChanged(nameof(DetailInvoice)); } }

        public ObservableCollection<LstProduct> ListItem { get => listItem; set { listItem = value; OnPropertyChanged(nameof(ListItem)); } }

        public ICommand Comment {  get; }
    
    }
}
