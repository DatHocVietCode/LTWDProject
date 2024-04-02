using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.View;
using WPF_Market.ViewModel.CartsWrapper;

namespace WPF_Market.ViewModel
{
    public class ContextMenuViewModel 
    {
        public ContextMenuViewModel()
        {
            ShowDetailCommand = new BaseViewModelCommand(ExecuteShowDetailCommand);
        }

        private void ExecuteShowDetailCommand(object obj)
        {
            var cart = obj as CartWrapper;
            var detail = new detail_product(cart.Cart.IDProductNavigation);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        public ICommand ShowDetailCommand { get; } // ICommand cho việc hiển thị chi tiết
        // Các ICommand khác nếu cần
    }
}
