using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Media.Imaging;

namespace WPF_Market.ViewModel
{
    public class MyImageConverter : IValueConverter
    {
        public MyImageConverter()
        {
        }

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string path = (string)value;

            try
            {
                //ABSOLUTE
                if (path.Length > 0 && path[0] == System.IO.Path.DirectorySeparatorChar
                    || path.Length > 1 && path[1] == System.IO.Path.VolumeSeparatorChar)
                    return new BitmapImage(new Uri(path));

                //RELATIVE
                return new BitmapImage(new Uri(System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin")) + path)) ;
            }
            catch (Exception)
            {
                return new BitmapImage();
            }

        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
