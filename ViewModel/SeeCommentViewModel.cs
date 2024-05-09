using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Xml.Linq;
using WPF_Market.Models;

namespace WPF_Market.ViewModel
{
    class SeeCommentViewModel : BaseViewModel
    {

        private ObservableCollection<Comment> seeComment = new ObservableCollection<Comment>();
        public SeeCommentViewModel(Shop Shop)
        {
            Shop.Comments = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == Shop.IDShop ).SelectMany(p=>p.Comments).Include(p=>p.LstImagesCMTs).OrderByDescending(p=>p.DataTimeCreate).Where(p=> p.Comment1 != null).ToList();
            SeeComment = new ObservableCollection<Comment>(Shop.Comments);
        }

     

        public ObservableCollection<Comment> SeeComment { get => seeComment; set { seeComment = value; OnPropertyChanged(nameof(SeeComment)); } }

    }
}
