using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

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
        }

        private void GetListItem()
        {
            var lst = DetailInvoice.LstProducts;
            ListItem = new ObservableCollection<LstProduct>(lst);
        }

        public Bought DetailInvoice { get => detailInvoice; set { detailInvoice = value; OnPropertyChanged(nameof(DetailInvoice)); } }

        public ObservableCollection<LstProduct> ListItem { get => listItem; set { listItem = value; OnPropertyChanged(nameof(ListItem)); } }

    
    }
}
