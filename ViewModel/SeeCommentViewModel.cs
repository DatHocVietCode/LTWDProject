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
        private ObservableCollection<string> listImageSeeCMT = new ObservableCollection<string>();

        private ObservableCollection<Comment> seeComment = new ObservableCollection<Comment>();
        public SeeCommentViewModel(Shop Shop)
        {
            Shop.Comments = DataProvider.Instance.DB.Shops.Where(p => p.IDShop == Shop.IDShop ).SelectMany(p=>p.Comments).OrderByDescending(p=>p.DataTimeCreate).Where(p=> p.Comment1 != null).ToList();
            
            SeeComment = new ObservableCollection<Comment>(Shop.Comments);
            int t = 21;
            string path = Path.GetFullPath("ImageCMT");
            string folderPath = path.Substring(0, path.IndexOf("bin"));
            string temp = @"ImageCmt\" + t.ToString().Trim();
            string destinationDirectory = @Path.Combine(folderPath, temp);
            string[] files = Directory.GetFiles(destinationDirectory);
            ListImageSeeCMT.Clear();
            foreach (string file in files)
            {
                ListImageSeeCMT.Add(file);
                //MessageBox.Show(file);
            }
        }

     

        public ObservableCollection<Comment> SeeComment { get => seeComment; set { seeComment = value; OnPropertyChanged(nameof(SeeComment)); } }

        public ObservableCollection<string> ListImageSeeCMT { get => listImageSeeCMT; set => listImageSeeCMT = value; }
    }
}
