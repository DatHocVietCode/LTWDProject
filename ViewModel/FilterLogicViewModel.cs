using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel
{
    internal interface FilterLogicViewModel
    {
        void SearchByName(string name, ObservableCollection<Inventory> ProductList);
        void OrderByPriority(int orderway, ObservableCollection<Inventory> ProductList);
        void ReOrder(int orderway, ObservableCollection<Inventory> ProductList);
        void FilterByType();
    }
}
