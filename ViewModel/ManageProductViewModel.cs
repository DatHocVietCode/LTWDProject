using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using WPF_Market.View;
using WPF_Market.Models;
using System.Reflection;
using Microsoft.Build.Evaluation;
using System.Windows.Media.Imaging;
using System.Xml.Linq;
using System.Windows.Shapes;
using Path = System.IO.Path;
namespace WPF_Market.ViewModel
{
    public class ManageProductViewModel : BaseViewModel
    {
        private string nameProduct;
        private double originalPrice;
        private double currentPrice;
        private float newness;
        private string type;
        private string overview;
        private string configuration;
        private string additional;
        private string imageLinks="";
        private int number = 1;
        private int iDProduct;
        private Inventory inventory = new Inventory();
        public ObservableCollection<string> shortStringList;
        private bool isCompleteAddProduct = false;
        private DateTime dateBought = DateTime.Now;
        public ObservableCollection<string> ShortStringList
        {
            get { return shortStringList; }
            set
            {
                shortStringList = value;
                OnPropertyChanged(nameof(shortStringList));
            }
        }
        public ManageProductViewModel(int value)
        {

            ShortStringList = new ObservableCollection<string>
            {
                "Electronics",
                "Fashion and Clothing",
                "Jewellery",
                "Health and Beauty",
                "Books",
                "Kids and Babies",
                "Sports",
                "Fruit and veg",
                "Home and Graden",
                "Others"
            };
            IncreaseNumberButttonClick = new BaseViewModelCommand(ExecuteIncreaseNumberCommand);
            DecreaseNumberButttonClick = new BaseViewModelCommand(ExecuteDecreaseNumberCommand, CanExecuteDecreaseNumberCommand);
            var s = DataProvider.Instance.DB.Users.FirstOrDefault();
            
            if (value == 0)
            {
                SubmitCommand = new BaseViewModelCommand(ExecuteSubmitCommand, CanExecuteSubmitCommand);
                BtnImageClick = new BaseViewModelCommand(ExecuteImageClickCommand);
                CloseForm = new BaseViewModelCommand(ExecuteCloseFormAddCommand);
                Inventory = new Inventory { IDShop = CurrentApplicationStatus.CurrentID };
                DataProvider.Instance.DB.Inventories.Add(Inventory);
                DataProvider.Instance.DB.SaveChanges();
            }
        }

        private void ExecuteCloseFormAddCommand(object obj)
        {
            var currentWindow = obj as Window;
            if (!isCompleteAddProduct)
            {
                // Neu User thoat ra luc chua hoan thanh them san pham thi xoa
                DataProvider.Instance.DB.Inventories.Remove(Inventory);
                DataProvider.Instance.DB.SaveChanges();
                new Custom_mb("Your operation has not finished yet!\n          All data will be removed!", Custom_mb.MessageType.Warning, Custom_mb.MessageButtons.Ok).ShowDialog(); 
                currentWindow.Close();
                return;
            }
            currentWindow.Close();
            new Custom_mb("Successfully adding new product!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
        }

        public ManageProductViewModel()
        {
            SubmitCommand = new BaseViewModelCommand(ExecuteSubmitCommand, CanExecuteSubmitCommand);
            BtnImageClick = new BaseViewModelCommand(ExecuteImageClickCommand);
            IncreaseNumberButttonClick = new BaseViewModelCommand(ExecuteIncreaseNumberCommand);
            DecreaseNumberButttonClick = new BaseViewModelCommand(ExecuteDecreaseNumberCommand, CanExecuteDecreaseNumberCommand);
            CloseForm = new BaseViewModelCommand(ExecuteCloseFormCommand);
            ShortStringList = new ObservableCollection<string>
            {
                "Electronics",
                "Fashion and Clothing",
                "Jewellery",
                "Health and Beauty",
                "Books",
                "Kids and Babies",
                "Sports",
                "Fruit and veg",
                "Home and Graden",
                "Others"
            };
            // xu ly identity
            var newestID = DataProvider.Instance.DB.Inventories.Max(e => e.IDProduct);
            var item = DataProvider.Instance.DB.Inventories.Where(p => p.IDProduct == newestID).FirstOrDefault();
            IDProduct = item.IDProduct + 1;
        }

        private void ExecuteCloseFormCommand(object obj)
        {
            System.Windows.Forms.MessageBox.Show("Test");
        }
        private bool CanExecuteDecreaseNumberCommand(object obj)
        {
            if (Number==1)
            {
                return false;
            }
            return true;
        }

        private void ExecuteDecreaseNumberCommand(object obj)
        {
          
            Number--;
        }

        private void ExecuteIncreaseNumberCommand(object obj)
        {
            Number++;
        }

        private void ExecuteImageClickCommand(object obj)
        {
            //ImageLinks ="";
            string path = Path.GetFullPath("SanPham");
            string folderPath = path.Substring(0, path.IndexOf("bin"));
            string temp = @"SanPham\" + Inventory.IDProduct.ToString().Trim() + @"\Images";
            string destinationDirectory = @Path.Combine(folderPath, temp);
            CopyImageToDirectory(destinationDirectory);
            string[] files = Directory.GetFiles(destinationDirectory);
            /*foreach (string file in files)
            {
                ImageLinks += file + "\n";
            }*/
        }
        private void CopyImageToDirectory(string destinationDirectory)
        {
            //mo file
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image Files (*.jpg; *.jpeg; *.png; *.gif; *.bmp)|*.jpg; *.jpeg; *.png; *.gif; *.bmp|All files (*.*)|*.*";
            openFileDialog.Title = "Select one picture";
            if (openFileDialog.ShowDialog() == true)
            {
                try
                {    
                    if (!Directory.Exists(destinationDirectory))
                    {
                        Directory.CreateDirectory(destinationDirectory);
                    }
                    string sourceFilePath = openFileDialog.FileName;
                    string destinationFilePath = Path.Combine(destinationDirectory, Path.GetFileName(sourceFilePath));
                    File.Copy(sourceFilePath, destinationFilePath, true);
                    ImageLinks += @"SanPham\" + Inventory.IDProduct.ToString().Trim() + @"\Images\" + Path.GetFileName(sourceFilePath) +'\n';
                    new Custom_mb("Operation successfully!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
                }
                catch (Exception ex)
                {
                    new Custom_mb("Operation failed!", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
                }
            }
        }
        private bool CanExecuteSubmitCommand(object obj)
        {
            if (string.IsNullOrEmpty(imageLinks) || string.IsNullOrEmpty(type) ||
                string.IsNullOrEmpty(overview) || string.IsNullOrEmpty(Additional) ||
                string.IsNullOrEmpty(Configuration) || string.IsNullOrEmpty(NameProduct) ||
                string.IsNullOrEmpty(Newness.ToString()))
            {    
                return false; 
            }
            return true;
          
        }   
        private void ExecuteSubmitCommand(object obj)
        {
            string pathOver = string.Format(@"D:\LTWD\LTWD_FinalProject\SanPham\{0}\Tongquansanpham.txt", Inventory.IDProduct.ToString().Trim());
            string pathTinhtrang = string.Format(@"D:\LTWD\LTWD_FinalProject\SanPham\{0}\Tinhtranghientai.txt", Inventory.IDProduct.ToString().Trim());
            string pathThem = string.Format(@"D:\LTWD\LTWD_FinalProject\SanPham\{0}\Thongtinthem.txt", Inventory.IDProduct.ToString().Trim());
            bool writeOverview = writeFile(pathOver, Overview);
            bool writeAdditional = writeFile(pathThem, Additional);
            bool writeConfiguration = writeFile(pathTinhtrang, Configuration);
            if (writeOverview && writeAdditional && writeConfiguration)
            {
                
                //Inventory.IDShop = CurrentApplicationStatus.CurrentID;
                Inventory.Name = NameProduct;
                Inventory.OriginalPrice = (float)OriginalPrice;
                Inventory.CurrentPrice = (float)CurrentPrice;
                Inventory.Save = (float)(1 - CurrentPrice/OriginalPrice)*100;
                Inventory.Newness = Newness;
                Inventory.Type = Type;
                Inventory.NumberInput = Number;
                Inventory.NumberLeft = Number;
                Inventory.BoughtTime = DateBought;
                DataProvider.Instance.DB.SaveChanges();
                string[] ListImageLink = ImageLinks.Split('\n');
                foreach (string imageLink in ListImageLink)
                {
                    if (string.IsNullOrEmpty(imageLink)) continue;
                    DataProvider.Instance.DB.ImageLinks.Add(new ImageLink { IDProduct = Inventory.IDProduct, ImageLink1 = imageLink });
                }
                DataProvider.Instance.DB.SaveChanges();
                new Custom_mb("Succesfully add new item!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();

                var currentWindow = obj as Window;
                currentWindow.Close();
                isCompleteAddProduct = true;
                return;
            }
            new Custom_mb("Fail", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
        }
        private bool writeFile(string path, string content)
        {  
            try
            {
                if (!File.Exists(path))
                {
                    // Nếu không tồn tại, tạo mới tệp và ghi dữ liệu
                    using (StreamWriter writer = File.CreateText(path))
                    {
                        writer.WriteLine(content);
                    }
                }
                else
                {
                    // Nếu tệp đã tồn tại, ghi đè dữ liệu
                    using (StreamWriter writer = new StreamWriter(path))
                    {
                        writer.WriteLine(content);
                    }
                }
                return true;
            }
            catch
            {

            }
            return false;
        }

        public string NameProduct
        {
            get { return nameProduct; }
            set
            {
                nameProduct = value;
                OnPropertyChanged(nameof(nameProduct));
            }
        }
     
     
        public float Newness
        {
            get
            { return newness; }
            set
            {
                newness = value;
                OnPropertyChanged(nameof(newness));
            }
        }
        public string Type
        {
            get => type;
            set
            {
                type = value;
                OnPropertyChanged(nameof(type));
            }
        }
        public string Overview
        {
            get { return overview; }
            set
            {
                overview = value;
                OnPropertyChanged(nameof(overview));
            }
        }
        public string Configuration
        {
            get => configuration;
            set
            {
                configuration = value;
                OnPropertyChanged(nameof(configuration));
            }
        }
        public string Additional
        {
            get { return additional; }
            set
            {
                additional = value;
                OnPropertyChanged(nameof(additional));
            }
        }
        // Commands
        public ICommand SubmitCommand { get; }
        public ICommand BtnImageClick { get; }
        public ICommand IncreaseNumberButttonClick { get; }
        public ICommand DecreaseNumberButttonClick { get; }
        public ICommand CloseForm {  get; }
        public Inventory Inventory { get => inventory; set { inventory = value; OnPropertyChanged(nameof(Inventory)); } }
        public string ImageLinks
        {
            get { return imageLinks; }
            set
            {
                imageLinks = value;
                OnPropertyChanged(nameof(imageLinks));
            }
        }

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

      

        public int IDProduct { get => iDProduct; set { iDProduct = value; OnPropertyChanged(nameof(IDProduct)); } }

        public DateTime DateBought { get => dateBought; set { dateBought = value; OnPropertyChanged(nameof(DateBought)); } }

        public double CurrentPrice { get => currentPrice; set { currentPrice = value; OnPropertyChanged(nameof(CurrentPrice)); } }
        public double OriginalPrice { get => originalPrice; set { originalPrice = value; OnPropertyChanged(nameof(OriginalPrice)); } }
    }
}
