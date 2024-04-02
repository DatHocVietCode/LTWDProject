using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Forms;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;
using WPF_Market.ViewModel.CartsWrapper;
namespace WPF_Market.ViewModel
{
    public class CartViewModel : BaseViewModel
    {
      
        private ObservableCollection<CartWrapper> carts;
        private double subTotal = 0;

        private double moneyToPay = 0;
        private bool isCheckedPickup = true;
        private bool isCheckedDelivery = false;
        private CartWrapper selectedChanged;
        public CartViewModel()
        {
            var lst = DataProvider.Instance.DB.Carts.Include(p=>p.IDProductNavigation.ImageLinks).Where(p=>p.IDUser == CurrentApplicationStatus.CurrentID).ToList();
            carts = new ObservableCollection<CartWrapper>();
            foreach (var item in lst)
            {
                carts.Add(new CartWrapper(item));
            }
            carts.CollectionChanged += Carts_CollectionChanged;
            Delivery = new BaseViewModelCommand(ExecuteDeliveryCommand);
            Pickup = new BaseViewModelCommand(ExecutePickupCommand);
            IsCheckedCommand = new BaseViewModelCommand(ExecuteIsCheckedCommand);
            ShowContextMenu = new BaseViewModelCommand(ExecuteShowContextMenu);
            ShowDetailCommand = new BaseViewModelCommand(ExecuteShowDetailCommand);
            DeleteProductCommand = new BaseViewModelCommand(ExecuteDeleteProductCommand);
            ProceedToCheckOutCommand = new BaseViewModelCommand(ExecuteProceedToCheckOutCommand, CanProceedToCheckOutCommand);
            OpenContextMenuFromButton = new BaseViewModelCommand(ExecuteOpenContextMenuFromButton);
        }

        private void ExecuteOpenContextMenuFromButton(object obj)
        {
            var contextMenu = new ContextMenu();
            var menuItemShowDetail = new MenuItem { Header = "Show detail" };
            menuItemShowDetail.Command = ShowDetailCommand;
            menuItemShowDetail.CommandParameter = obj as CartWrapper;
            contextMenu.Items.Add(menuItemShowDetail);
            var menuItemDeleteItem = new MenuItem { Header = "Delete item" };
            menuItemDeleteItem.Command = DeleteProductCommand;
            menuItemDeleteItem.CommandParameter = obj as CartWrapper;               
            contextMenu.Items.Add(menuItemDeleteItem);
            contextMenu.IsOpen = true;
        }

        private bool CanProceedToCheckOutCommand(object obj)
        {
            foreach (var item in carts)
            {
                if (item.CartWrapperIsChecked)
                    return true;
            }
            return false;
        }

        private void ExecuteProceedToCheckOutCommand(object obj)
        {
            var tempLst = carts.ToList();
            bool isbought = false;
            foreach (var item in tempLst)
            {
                if (item.CartWrapperIsChecked)
                {
                    if (item.Cart.IDProductNavigation.NumberLeft >= item.CartWrapperNumber)
                    {
                        item.Cart.IDProductNavigation.NumberLeft -= item.CartWrapperNumber;
                        //item.Cart.IDProductNavigation.NumberSold += item.CartWrapperNumber;
                        DataProvider.Instance.DB.Remove(item.Cart);
                        DataProvider.Instance.DB.SaveChanges();
                        carts.Remove(item);
                        isbought = true;
                    }
                    else
                    {
                        new Custom_mb("Something went wrong! Please try again", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
                        item.CartWrapperIsChecked = false;
                        break;
                    }
                }
                
            }
            if (isbought)
            {
                new Custom_mb("Thanks for your support! Hope to see you later!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
            }
            SubTotal = 0;
            MoneyToPay = 0;
            IsCheckedPickup = true;
            IsCheckedDelivery = false;        

            // Se bo sung xuat hoa don
        }

        private void ExecuteDeleteProductCommand(object obj)
        {
            var cart = obj as CartWrapper;
          
            if (cart.CartWrapperIsChecked)
            {
                SubTotal -= cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
                MoneyToPay -= cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
            }
            DataProvider.Instance.DB.Remove(cart.Cart);
            DataProvider.Instance.DB.SaveChanges();
            Carts.Remove(cart);
        }

        private void ExecuteShowDetailCommand(object obj)
        {
            var cart = obj as CartWrapper;
            var detail = new detail_product(cart.Cart.IDProductNavigation);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        private void ExecuteShowContextMenu(object obj)
        {
            throw new NotImplementedException();
        }

        private void ExecuteIsCheckedCommand(object obj)
        {
           ChangeSubTotal((CartWrapper)obj);
        }

        private void Carts_CollectionChanged(object? sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            return;
        }   
        private void ExecutePickupCommand(object obj)
        {
            if (IsCheckedDelivery == true)
            {
                MoneyToPay -= 15;
            }
            IsCheckedDelivery = false;
        }

        private void ExecuteDeliveryCommand(object obj)
        {

            if (IsCheckedPickup == true)
            {
                MoneyToPay += 15;
            }

            IsCheckedPickup = false;
           
        }

        public ObservableCollection<CartWrapper> Carts { get => carts; set { carts = value; 
                OnPropertyChanged(nameof(Carts)); } }

        public void ChangeSubTotal(CartWrapper cart)
        {
            if (cart.CartWrapperIsChecked == true)
            {
                SubTotal += cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
                MoneyToPay += cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
            }
            else
            {
                SubTotal -= cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
                MoneyToPay -= cart.CartWrapperCurrentPrice * cart.CartWrapperNumber;
            }
            return;
        }

        public double MoneyToPay { get => moneyToPay; set { moneyToPay = value; OnPropertyChanged(nameof(MoneyToPay)); } }
        public bool IsCheckedPickup { get => isCheckedPickup; set { isCheckedPickup = value; OnPropertyChanged(nameof(isCheckedPickup)); } }
        public bool IsCheckedDelivery { get => isCheckedDelivery; set { isCheckedDelivery = value; OnPropertyChanged(nameof(IsCheckedDelivery)); } }
        public double SubTotal { get => subTotal; set { subTotal = value; OnPropertyChanged(nameof(SubTotal)); } }
        public ICommand Delivery { get; }
        public ICommand Pickup { get; }
        public ICommand IsCheckedCommand { get; }
        public ICommand ShowContextMenu { get; }
        public ICommand ShowDetailCommand { get; }
        public ICommand DeleteProductCommand { get; }   
        public ICommand ProceedToCheckOutCommand { get; }
        public ICommand OpenContextMenuFromButton { get; }
        public CartWrapper SelectedChanged { get => selectedChanged; set { selectedChanged = value; OnPropertyChanged(nameof(SelectedChanged)); } }
      
    }

}
