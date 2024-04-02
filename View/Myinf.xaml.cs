using MaterialDesignThemes.Wpf;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Myinf.xaml
    /// </summary>
    public partial class Myinf : UserControl
    {
        public Myinf()
        {
            InitializeComponent();
        }

        private void btn_change_Click(object sender, RoutedEventArgs e)
        {
            var newUserControl = new confirmPass();
            grid_showUC.Children.Clear();
            grid_showUC.Children.Add(newUserControl);
        }

        private void btn_changeAva_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Process.Start("explorer.exe", "D:/");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error opening folder: " + ex.Message);
            }
        }
    }
}
