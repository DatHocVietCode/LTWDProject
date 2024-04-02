using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
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
using System.IO;
using Path = System.IO.Path;
using static MaterialDesignThemes.Wpf.Theme;
using System.Threading;
using WPF_Market.ViewModel;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Manage_Product.xaml
    /// </summary>
    public partial class Manage_Product : Window
    {
        public Manage_Product(int value)
        {
            InitializeComponent();
            this.DataContext = new ManageProductViewModel(value);   
        }
        private void Window_MouseEnter(object sender, MouseEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }

        }

      
    }
}
