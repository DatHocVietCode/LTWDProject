using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
    /// Interaction logic for detail_product.xaml
    /// </summary>
    public partial class detail_product : Window
    {
        private Inventory model = new Inventory();
        private bool isDragging = false;
        private Point startPoint;
        public detail_product()
        {
        }

        public detail_product(object productdetail)
        {
            InitializeComponent();
            model = (Inventory)productdetail;
            DetailProductViewModel viewModel = new DetailProductViewModel(model);    
            this.DataContext = viewModel;
        }
        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
                this.DragMove();
        }

        private void Window_MouseMove(object sender, MouseEventArgs e)
        {
            if (isDragging && e.LeftButton == MouseButtonState.Pressed)
            {
                Point endPoint = e.GetPosition(this);
                double dx = endPoint.X - startPoint.X;
                double dy = endPoint.Y - startPoint.Y;

                Left += dx;
                Top += dy;
            }
            else
            {
                isDragging = false;
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

     
    }
}
