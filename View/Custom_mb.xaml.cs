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
using static MaterialDesignThemes.Wpf.Theme;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Custom_mb.xaml
    /// </summary>
    public partial class Custom_mb : Window
    {
        public enum MessageType
        {
            Info,
            Confirmation,
            Success,
            Warning,
            Error,
        }
        public enum MessageButtons
        {
            OkCancel,
            YesNo,
            Ok,
        }
        public Custom_mb(string Message, MessageType Type, MessageButtons Buttons)
        {
            InitializeComponent();
            txtMessage.Text = Message;
            switch (Type)
            {

                case MessageType.Info:
                    change_backround_color(Colors.BlueViolet);
                    txtTitle.Text = "Info";
                    break;
                case MessageType.Confirmation:
                    change_backround_color(Colors.Purple);
                    txtTitle.Text = "Confirmation";
                    break;
                case MessageType.Success:
                    {
                        change_backround_color(Colors.Green);
                        txtTitle.Text = "Success";
                    }
                    break;
                case MessageType.Warning:
                    change_backround_color(Colors.Red);
                    txtTitle.Text = "Warning";
                    break;
                case MessageType.Error:
                    {
                        change_backround_color(Colors.Red);
                        txtTitle.Text = "Error";
                    }
                    break;
            }
            switch (Buttons)
            {
                case MessageButtons.OkCancel:
                    btnYes.Visibility = Visibility.Collapsed; btnNo.Visibility = Visibility.Collapsed;
                    break;
                case MessageButtons.YesNo:
                    btnOk.Visibility = Visibility.Collapsed; btnCancel.Visibility = Visibility.Collapsed;
                    break;
                case MessageButtons.Ok:
                    btnOk.Visibility = Visibility.Visible;
                    btnCancel.Visibility = Visibility.Collapsed;
                    btnYes.Visibility = Visibility.Collapsed; btnNo.Visibility = Visibility.Collapsed;
                    btnOk.HorizontalAlignment = HorizontalAlignment.Center;
                    break;
            }
        }
        private void change_backround_color(Color backround_color)
        {
            cardHeader.Background = new SolidColorBrush(backround_color);
           

        }
        private void btnYes_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
            this.Close();
        }

        private void btnOk_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
            this.Close();
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void btnNo_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
        }
    }
}
