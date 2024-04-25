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

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for WriteComment.xaml
    /// </summary>
    public partial class WriteComment : Window
    {
        public WriteComment()
        {
            InitializeComponent();
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void rate_TextChanged(object sender, TextChangedEventArgs e)
        {
            double n;
            if (txt_rate.Text.Length> 0)
            {
                if (double.TryParse(this.txt_rate.Text, out n))
                {
                    ReadOnlyRatingBar.Value = n;
                }
                else MessageBox.Show("nhap lai");
            }
            
        }
    }
}
