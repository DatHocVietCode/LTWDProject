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
using Bought = WPF_Market.Models.Bought;

namespace WPF_Market.ViewModel
{
    public class BougthViewModel : BaseViewModel
    {
        ObservableCollection<Bought> boughts = new ObservableCollection<Bought>();
        public BougthViewModel()
        {
            GetData();
            CheckDetail = new BaseViewModelCommand(ExecuteCheckDetailCommand);
            DeleteDetail = new BaseViewModelCommand(ExecuteDeleteCommand);
        }

        private void ExecuteDeleteCommand(object obj)
        {
            var invoiceDele = obj as Bought;
            var lst = new ObservableCollection<LstProduct>(invoiceDele.LstProducts);
            foreach (var item in lst)
            {
                DataProvider.Instance.DB.LstProducts.Remove(item);
            }
            DataProvider.Instance.DB.SaveChanges();
            Boughts.Remove(invoiceDele);
            DataProvider.Instance.DB.Boughts.Remove(invoiceDele);
            DataProvider.Instance.DB.SaveChanges();
            new Custom_mb("Successfullly delete!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
        }

        private void ExecuteCheckDetailCommand(object obj)
        {
            var invoiceDetail = obj as Bought;
            var detail = new Invoice(invoiceDetail);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        public ObservableCollection<Bought> Boughts { get => boughts; set { boughts = value; OnPropertyChanged(nameof(Boughts)); } }

        void GetData()
        {
            var lst = DataProvider.Instance.DB.Boughts.Include(p=>p.LstProducts).Where(p=> p.IDUser == CurrentApplicationStatus.CurrentID).ToList();
            Boughts = new ObservableCollection<Bought>(lst);
        }
        // Commands
        public ICommand CheckDetail { get; }
        public ICommand DeleteDetail { get; }
    }
}
