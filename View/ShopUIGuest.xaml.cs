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
using System.Windows.Navigation;
using System.Windows.Shapes;
using WPF_Market.Models;
using WPF_Market.ViewModel;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for ShopUIGuest.xaml
    /// </summary>
    public partial class ShopUIGuest : Window
    {
        public ShopUIGuest(Shop shop, bool canWriteComnent)
        {
            InitializeComponent();
            this.DataContext = new ShopGuestViewModel(shop, canWriteComnent);
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
