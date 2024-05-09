using ControlzEx.Standard;
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
using WPF_Market.Models;
using WPF_Market.ViewModel;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for WriteComment.xaml
    /// </summary>
    public partial class WriteComment : Window
    {
        public WriteComment(Shop shop)
        {
            InitializeComponent();
            this.DataContext = new CreateCommentViewModel(shop);
        }
        private void Window_MouseEnter(object sender, MouseEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
        }

        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
                this.DragMove();
        }
    }
}
