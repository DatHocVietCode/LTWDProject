using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
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
        private ObservableCollection<Inventory> favProductList = new ObservableCollection<Inventory>();
        private IShowProductDetail showProductDetail;
        
        public ListProductViewModel()
        {
            GetProductDataFromDataBase();
            
            SeeDetailCommand = new BaseViewModelCommand(ExecuteSeeDetailCommand);
        }
        public void FilterProductByCB(List<string> listTypes)
        {
           if(listTypes.Count > 0) {
                var lst = DataProvider.Instance.DB.Inventories.Include(p => p.IDShopNavigation).Include(p => p.ImageLinks).Where(p => listTypes.Contains(p.Type)).ToList().OrderByDescending(p => p.Priority);
                ProductList = new ObservableCollection<Inventory>(lst);
            }
            else
            {
                GetProductDataFromDataBase();
            }
            
          
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
        public ObservableCollection<Inventory> FavProductList { get => favProductList; set { favProductList = value; OnPropertyChanged(nameof(FavProductList)); } }

        private void GetProductDataFromDataBase()
        {
            var lst = DataProvider.Instance.DB.Inventories.Include(p=>p.IDShopNavigation).Include(p=>p.ImageLinks).Include(p=>p.IDUsers).ToList().OrderByDescending(p=>p.Priority);
            ProductList = new ObservableCollection<Inventory>(lst);
            var favlst = DataProvider.Instance.DB.Inventories.Include(p => p.IDUsers).Include(p => p.IDShopNavigation).Include(p => p.ImageLinks).Where(p=>p.IDUsers.Contains(CurrentApplicationStatus.CurrentUser)).ToList().OrderByDescending(p => p.Priority);
            FavProductList = new ObservableCollection<Inventory>(favlst);
        }
        public ICommand SeeDetailCommand { get; }

        private void ExecuteSeeDetailCommand(object obj)
        {
            var product = (Inventory)obj;
            product.Priority++;
            DataProvider.Instance.DB.SaveChanges();
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
