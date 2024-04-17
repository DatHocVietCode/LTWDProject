using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Effects;
using WPF_Market.Models;
using WPF_Market.View;
namespace WPF_Market.ViewModel
{
    class DetailProductViewModel: BaseViewModel
    {
        private Inventory _product;
        private string defaultImage;
        string tongQuan;
        string tTThem;
        string baoHanh;
        private double currentPrice;
        private int number = 1;
        private ObservableCollection<string>listImage = new ObservableCollection<string>();
        private ObservableCollection<Inventory> productList = new ObservableCollection<Inventory>();
        private bool isFaVProduct;
        private string DefaultPath;
        private System.Windows.Media.Brush color;

        public DetailProductViewModel()
        {

        }

        public DetailProductViewModel(Inventory productViewModel)
        {
            DefaultPath = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"));
            Product = productViewModel;
            ChangeColor();
            foreach (var item in Product.ImageLinks)
            {
                ListImage.Add(item.ImageLink1);
            }
            DefaultImage = Product.ImageLinks.FirstOrDefault().ImageLink1;
            ReadTongQuan(); 
            ReadTTThem();
            ReadTThientai();
            ChangePicture = new BaseViewModelCommand(SelectImageCommand);
            AddProduct = new BaseViewModelCommand(ExecuteAddProductCommand);
            IncreaseNumberButttonClick = new BaseViewModelCommand(ExecuteIncreaseNumberCommand);
            VisitShop = new BaseViewModelCommand(ExecuteVisitShop);
            DecreaseNumberButttonClick = new BaseViewModelCommand(ExecuteDecreaseNumberCommand, CanExecuteDecreaseNumberCommand);
            SetFaV = new BaseViewModelCommand(ExecuteSetFaV);
            var lst = DataProvider.Instance.DB.Inventories.Where(p=> p.Type == productViewModel.Type || p.IDShop == productViewModel.IDShop).Take(5).ToList();
            productList = new ObservableCollection<Inventory>(lst);
            
        }

        private void ExecuteVisitShop(object obj)
        {
            MessageBox.Show(Product.IDShopNavigation.NameShop + "'s UI is being under development");
        }

        private void ChangeColor()
        {
           
            if (Product.IDUsers.Contains(CurrentApplicationStatus.CurrentUser))
            {
                Color = new SolidColorBrush(Colors.OrangeRed);
            }
            else
            {
                Color = new SolidColorBrush(Colors.Wheat);
            }
        }
        private void ExecuteSetFaV(object obj)
        {
            if (Color is SolidColorBrush solidColorBrush && solidColorBrush.Color == Colors.OrangeRed)
            {
                RemoveFav();
            }
           else
           {
                AddFaV();
           }
        }

        private void AddFaV()
        {
            Product.IDUsers.Add(CurrentApplicationStatus.CurrentUser);
            DataProvider.Instance.DB.SaveChanges();
            ChangeColor();
        }

        private void RemoveFav()
        {
            
            Product.IDUsers.Remove(CurrentApplicationStatus.CurrentUser);
            DataProvider.Instance.DB.SaveChanges();
            ChangeColor();
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
        private void ExecuteDecreaseNumberCommand(object obj)
        {

            Number--;
        }

        private void ExecuteIncreaseNumberCommand(object obj)
        {
            Number++;
        }
        private bool CanExecuteDecreaseNumberCommand(object obj)
        {
            if (Number == 1)
            {
                return false;
            }
            return true;
        }
     

        private void ExecuteAddProductCommand(object obj)
        {
            var temp = DataProvider.Instance.DB.Carts.Where(p=> p.IDProduct == Product.IDProduct).FirstOrDefault();
            if (temp != null)
            {
                temp.NumberOfProduct += Number;
                DataProvider.Instance.DB.SaveChanges();
                new Custom_mb("Succesfully add to your cart!", Custom_mb.MessageType.Confirmation, Custom_mb.MessageButtons.Ok).ShowDialog();
                return;
            }
            DataProvider.Instance.DB.Carts.Add(new Models.Cart { IDProduct = Product.IDProduct,
                IDUser = CurrentApplicationStatus.CurrentID, 
                NumberOfProduct = Number });
            DataProvider.Instance.DB.SaveChanges();

            new Custom_mb("Succesfully add to your cart!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
        }

        private void SelectImageCommand(object obj)
        {
         
            string linkImage = (string)obj;
            DefaultImage = linkImage;
        }

        private void ReadTongQuan()
        {
            string filepath = DefaultPath + @"SanPham\" + Product.IDProduct.ToString().Trim() + "/Tongquansanpham.txt";
            StreamReader reader = new StreamReader(filepath);
            while (!reader.EndOfStream)
            {
                TongQuan = reader.ReadToEnd();
            }
            reader.Close();
        }
        private void ReadTTThem()
        {
            string filepath = DefaultPath + @"SanPham\" + Product.IDProduct.ToString().Trim() + "/Thongtinthem.txt";
            StreamReader reader = new StreamReader(filepath);
            while (!reader.EndOfStream)
            {
                TTThem = reader.ReadToEnd();
            }
            reader.Close();
        }
        private void ReadTThientai()
        {
            string filepath = DefaultPath + @"SanPham\" + Product.IDProduct.ToString().Trim() + "/Tinhtranghientai.txt";
            StreamReader reader = new StreamReader(filepath);
            while (!reader.EndOfStream)
            {
                BaoHanh = reader.ReadToEnd();
            }
            reader.Close();
           
        }   
        public Inventory Product
        {
            get { return _product; }
            set
            {
                _product = value;
                OnPropertyChanged(nameof(Product));
            }
        }
        public string TongQuan { get => tongQuan; set => tongQuan = value; }
        public string TTThem { get => tTThem; set => tTThem = value; }
        public string BaoHanh { get => baoHanh; set => baoHanh = value; }
        public System.Windows.Media.Brush Color { get => color; set { color = value; OnPropertyChanged(nameof(Color)); } }
        public ICommand ChangePicture {  get;}
        public ICommand AddProduct { get;}
        public string DefaultImage
        {
            get => defaultImage;
            set
            {
                defaultImage = value;
                OnPropertyChanged(nameof(DefaultImage));
            }
        }
        public double CurrentPrice { get => (double)(Product.CurrentPrice) ; set { currentPrice = value; OnPropertyChanged(nameof(CurrentPrice)); } }

        public ObservableCollection<string> ListImage { get => listImage; set => listImage = value; }
        public ICommand IncreaseNumberButttonClick { get; }
        public ICommand DecreaseNumberButttonClick { get; }
        public ICommand SetFaV {  get; }
        public ICommand VisitShop {  get; } 
        public int Number
        {
            get
            {
                return number;
            }
            set
            {
                number = value;
                OnPropertyChanged(nameof(number));
            }
        }

      
    }
}
