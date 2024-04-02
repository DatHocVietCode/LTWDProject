using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Market.ViewModel
{
    public class Type_VM
    {
        public ObservableCollection<string> ShortStringList { get; set; }

        public Type_VM()
        {
            ShortStringList = new ObservableCollection<string>();
            ShortStringList.Add("Electronics");
            ShortStringList.Add("Fashion and Clothing");
            ShortStringList.Add("Jewellery");
            ShortStringList.Add("Health and Beauty");
            ShortStringList.Add("Books");
            ShortStringList.Add("Kids and Babies");
            ShortStringList.Add("Sports");
            ShortStringList.Add("Fruit and veg");
            ShortStringList.Add("Home and Graden");
            ShortStringList.Add("Others");
        }
    }
}
