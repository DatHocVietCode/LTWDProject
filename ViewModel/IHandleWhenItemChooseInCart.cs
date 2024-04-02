using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.ViewModel.CartsWrapper;

namespace WPF_Market.ViewModel
{
    public interface IHandleWhenItemChooseInCart
    {
        public void ChangeSubTotal(CartWrapper cart);
    }
}
