using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel
{
    class SeeCommentViewModel : BaseViewModel
    {
        private ObservableCollection<Comment> seeComment = new ObservableCollection<Comment>();
        public SeeCommentViewModel(Shop Shop)
        {
            Shop.Comments = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == Shop.IDShop).SelectMany(p=>p.Comments).OrderByDescending(p=>p.DataTimeCreate).ToList();
           
            SeeComment = new ObservableCollection<Comment>(Shop.Comments);
        }

     

        public ObservableCollection<Comment> SeeComment { get => seeComment; set { seeComment = value; OnPropertyChanged(nameof(SeeComment)); } }
    }
}
