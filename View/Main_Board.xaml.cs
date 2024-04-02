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
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using WPF_Market.View;
using WPF_Market.ViewModel;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Main_Board.xaml
    /// </summary>
    public partial class Main_Board : Window
    {
        public Main_Board()
        {
           
            InitializeComponent();
            CurrentApplicationStatus.MainBoardWindow = Window.GetWindow(this);
      
        }


        private void btn_cart_Click(object sender, RoutedEventArgs e)
        {
           /* F_display.Content = new Cart();*/
        }

        private void btn_home_Click(object sender, RoutedEventArgs e)
        {
            Window parentWindow = Window.GetWindow(this);
            //F_display.Content = new product(parentWindow);
        }

        private void btn_shop_Click(object sender, RoutedEventArgs e)
        {
           /* F_display.Content = new ShopUI();*/
        }

        private void btn_acc_Click(object sender, RoutedEventArgs e)
        {
           /* F_display.Content = new Myinf();*/
        }

        private void MainBoardWindow_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
                this.DragMove();
        }
    }
    
}
