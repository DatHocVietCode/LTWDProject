using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel
{
    public class BougthViewModel : BaseViewModel
    {
        ObservableCollection<Bought> boughts = new ObservableCollection<Bought>();
        public BougthViewModel()
        {
            GetData();
        }

        public ObservableCollection<Bought> Boughts { get => boughts; set { boughts = value; OnPropertyChanged(nameof(Boughts)); } }

        void GetData()
        {
            var lst = DataProvider.Instance.DB.Boughts.ToList();
            Boughts = new ObservableCollection<Bought>(lst);
        }
    }
}
