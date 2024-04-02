using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel.CartsWrapper
{
    public class CartWrapper : BaseViewModel
    {
        private Cart cart;
        private bool isCheck = false;
        public CartWrapper()
        {
        }
        public CartWrapper(Cart cart)
        {
            this.Cart = cart;
        }
        public Cart Cart { get => cart; set { cart = value; OnPropertyChanged(nameof(Cart)); } }
        public bool CartWrapperIsChecked { get => isCheck; set { isCheck = value;  OnPropertyChanged(nameof(CartWrapperIsChecked)); } }
        public double CartWrapperOrigingalPrice { get => (double)cart.IDProductNavigation.OriginalPrice; }
        public string CartWrapperName { get => cart.IDProductNavigation.Name; }
        public string CartWrapperIllustration { get => cart.IDProductNavigation.ImageLinks.FirstOrDefault().ImageLink1; }
        public double CartWrapperCurrentPrice { get => (double)cart.IDProductNavigation.CurrentPrice; }
        public int CartWrapperNumber { get => (int)cart.NumberOfProduct; }
        
    }
}
