using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.ViewModel;

namespace WPF_Market.CustomControl
{
    public class ProductUIViewModel
    {
        public ProductUIViewModel()
        {
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
        }

        private void ExecuteSeeDetailCommand(object obj)
        {
            System.Windows.Forms.MessageBox.Show("Test");
        }

        public ICommand SeeDetailCommand { get; }
        
    }
}
