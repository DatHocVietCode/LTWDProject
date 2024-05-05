using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using System.Windows.Controls;
namespace WPF_Market.ViewModel
{
    
    public class DoubleValidationRule : ValidationRule
    {
        public override ValidationResult Validate(object value, CultureInfo cultureInfo)
        {
            string input = value as string;

            // Kiểm tra xem chuỗi có thể chuyển đổi thành số double không
            if (double.TryParse(input, out double result))
            {
                return ValidationResult.ValidResult;
            }
            else
            {
                return new ValidationResult(false, "Unvalid value!");
            }
        }
    }

}
