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

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for confirmPass.xaml
    /// </summary>
    public partial class confirmPass : UserControl
    {
        public confirmPass()
        {
            InitializeComponent();
        }

        private void btn_cancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
        public void Close()
        {
            Window parentWindow = Window.GetWindow(this);
            if (parentWindow != null)
            {
                parentWindow.Close();
            }
        }
    }
}
