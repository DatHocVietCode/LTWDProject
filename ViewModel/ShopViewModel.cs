using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    public class ShopViewModel : BaseViewModel
    {
        private ObservableCollection<Inventory> shopInventory;
        private int iDShop = CurrentApplicationStatus.CurrentID;
        public ShopViewModel()
        {
            GetProductFromDB();
            AddProductCommand = new BaseViewModelCommand(ExecuteAddProductCommand);
            DeleteProductCommand = new BaseViewModelCommand(ExecuteDeleteProductCommand);
            SeeProductDetail = new BaseViewModelCommand(ExecuteSeeDetailCommand);
            EditProductCommand = new BaseViewModelCommand(ExecuteEditProductCommand);
            SeeStatistical = new BaseViewModelCommand(ExecuteSeeStatistial);
        }

        private void ExecuteSeeStatistial(object obj)
        {
            var newWindow = new Statistical();
            newWindow.Owner = CurrentApplicationStatus.MainBoardWindow;
            newWindow.ShowDialog();
        }

        private void ExecuteEditProductCommand(object obj)
        {
            var inventory = (Inventory)obj;
            var detail = new Manage_Product(inventory);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        private void ExecuteSeeDetailCommand(object obj)
        {
            var inventory = (Inventory)obj;
            var detail = new detail_product(inventory);
            detail.Owner = CurrentApplicationStatus.MainBoardWindow;
            detail.ShowDialog();
        }

        private void GetProductFromDB()
        {
            ShopInventory = new ObservableCollection<Inventory>(DataProvider.Instance.DB.Inventories.Where(p => p.IDShop == CurrentApplicationStatus.CurrentID));
        }
        private void ExecuteDeleteProductCommand(object obj)
        {
            var Product = obj as Inventory;
            var lstImage = DataProvider.Instance.DB.ImageLinks.Where(p => p.IDProduct == Product.IDProduct).ToList();
            foreach (var item in lstImage)
            {
                DataProvider.Instance.DB.ImageLinks.Remove(item);
            }
            DataProvider.Instance.DB.SaveChanges();
            DataProvider.Instance.DB.Inventories.Remove(Product);
            ShopInventory.Remove(Product);
            DataProvider.Instance.DB.SaveChanges();
        }

        private void ExecuteAddProductCommand(object obj)
        {
            var newWindow = new Manage_Product(null);
            newWindow.Owner = CurrentApplicationStatus.MainBoardWindow;
            newWindow.ShowDialog();
            GetProductFromDB();
        }
        public ObservableCollection<Inventory> ShopInventory { get => shopInventory; set { shopInventory = value; OnPropertyChanged(nameof(ShopInventory)); } }
        public int IDShop { get => iDShop; set => iDShop = value; }
        public ICommand AddProductCommand { get; }
        public ICommand DeleteProductCommand { get; }
        public ICommand SeeProductDetail {  get; }
        public ICommand EditProductCommand { get; }
        public ICommand SeeStatistical {  get; }
    }
}
