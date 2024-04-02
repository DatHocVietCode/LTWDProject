using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WPF_Market.ViewModel;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Frame_Home.xaml
    /// </summary>
    public partial class Frame_Home : UserControl
    {
        private void GetImage()
        {
            string imageLink = Frame_Home_DAO.GetImageLink();
            //MessageBox.Show(imageLink);
            Image image = new Image();
            BitmapImage bitmapImage = new BitmapImage();
            bitmapImage.BeginInit();
            bitmapImage.UriSource = new Uri(imageLink, UriKind.Relative);
            bitmapImage.EndInit();
            image.Stretch = Stretch.Fill;
            image.Source = bitmapImage;
          /*  Frame F_display = new Frame();
            Animation.Content= F_display;
            F_display.Content = image;*/
        }
        public Frame_Home()
        {
            InitializeComponent();
            Frame_Home_DAO.InitializedLinkedList();
            GetImage();
         
        }

        private void ButtonNext_Click(object sender, RoutedEventArgs e)
        {
            GetImage();
        }
    }
}
