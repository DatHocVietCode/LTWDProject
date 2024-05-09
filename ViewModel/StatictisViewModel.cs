using LiveCharts;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel
{
    class StatictisViewModel : BaseViewModel
    {
        private ChartValues<Inventory> productList = new ChartValues<Inventory>();
        private ChartValues<string> nameProducts = new ChartValues<string>();
        private ChartValues<int> revenue = new ChartValues<int>();
        private ChartValues<int> iD = new ChartValues<int>();
        private int maxRevenue = 0;
        private int totalRevenue = 0;
        private ChartValues<double> visits = new ChartValues<double>();
        private ChartValues<double> purchases = new ChartValues<double>();
        public StatictisViewModel()
        {
            ProductList = new ChartValues<Inventory>(DataProvider.Instance.DB.Inventories.Where(p=> p.IDShop == CurrentApplicationStatus.CurrentID).ToList());
            foreach (var item in ProductList)
            {
                NameProducts.Add(item.Name);            
                ID.Add(item.IDProduct);
                Revenue.Add((int)item.Revenue);
            }
            MaxRevenue = Revenue.Max();
            if (MaxRevenue == 0)
                MaxRevenue = 100;
            TotalRevenue = Revenue.Sum();
            var temp = (double)DataProvider.Instance.DB.Shops.Where(p=>p.IDShop == CurrentApplicationStatus.CurrentID).FirstOrDefault().Visits;
            Visits = new ChartValues<double> { temp };
            temp = (double)DataProvider.Instance.DB.Shops.Where(p => p.IDShop == CurrentApplicationStatus.CurrentID).FirstOrDefault().Purchases;
            Purchases = new ChartValues<double> { temp };
        }

        public ChartValues<Inventory> ProductList { get => productList; set { productList = value; OnPropertyChanged(nameof(ProductList)); } }

        public ChartValues<string> NameProducts { get => nameProducts; set { nameProducts = value; OnPropertyChanged(nameof(NameProducts)); } }

        public ChartValues<int> Revenue { get => revenue; set { revenue = value; OnPropertyChanged(nameof(Revenue)); } }

        public int MaxRevenue { get => maxRevenue; set { maxRevenue = value; OnPropertyChanged(nameof(MaxRevenue)); } }

        public int TotalRevenue { get => totalRevenue; set { totalRevenue = value; OnPropertyChanged(nameof(TotalRevenue)); } }
        public ChartValues<int> ID { get => iD; set { iD = value; OnPropertyChanged(nameof(ID)); } }

        public ChartValues<double> Visits { get => visits; set { visits = value; OnPropertyChanged(nameof(Visits)); }
    }
        public ChartValues<double> Purchases { get => purchases; set { purchases = value; OnPropertyChanged(nameof(Purchases)); } }
    }
}
