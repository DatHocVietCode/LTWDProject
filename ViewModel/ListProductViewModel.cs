using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using WPF_Market.Models;
using WPF_Market.View;
namespace WPF_Market.ViewModel
{
    public class ListProductViewModel : BaseViewModel
    {
        private ObservableCollection<Inventory> productList = new ObservableCollection<Inventory>();
        private IShowProductDetail showProductDetail;
   
        public ListProductViewModel()
        {
            GetProductDataFromDataBase();
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
        }  
        public ObservableCollection<Inventory> ProductList
        {
            get
            {
                return productList;
            }
            set
            {
                productList = value;
                OnPropertyChanged(nameof(productList)); 
            }
        }
        private void GetProductDataFromDataBase()
        {
            var lst = DataProvider.Instance.DB.Inventories.Include(p=>p.IDShopNavigation).Include(p=>p.ImageLinks).ToList();
            ProductList = new ObservableCollection<Inventory>(lst);
        }
        public ICommand SeeDetailCommand { get; }
        

        private void ExecuteSeeDetailCommand(object obj)
        {
            showProductDetail = new DisplayDetailProduct();
            showProductDetail.ShowProductDetail((Inventory)obj);
        }
    }
    public class DisplayDetailProduct : IShowProductDetail
    {
        private Window parentWindow;
        public DisplayDetailProduct()
        {

        }
        public Window ParentWindow { get => parentWindow; set => parentWindow = value; }

        public void ShowProductDetail(Inventory productModel)
        {
            detail_product product = new detail_product(productModel);          
            product.Owner = CurrentApplicationStatus.MainBoardWindow;
            CurrentApplicationStatus.MainBoardWindow.Hide();
            product.ShowDialog();
            CurrentApplicationStatus.MainBoardWindow.Show();
        }
    }
}
