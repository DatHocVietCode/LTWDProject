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
using System.Windows.Controls;
using WPF_Market.ViewModel.CartsWrapper;

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
        private int number = 1;
        private int iDProduct;
        private Inventory inventory = new Inventory();
        public ObservableCollection<string> shortStringList;
        private bool isCompleteAddProduct = false;
        private DateTime dateBought = DateTime.Now;
        private ObservableCollection<string> imageLinksGV = new ObservableCollection<string>();
        private string currentPriceStr;
        private string originalPriceStr;
        private string newnessStr;
        public ObservableCollection<string> ShortStringList
        {
            get { return shortStringList; }
            set
            {
                shortStringList = value;
                OnPropertyChanged(nameof(shortStringList));
            }
        }
        private void ExecuteShowDetailCommand(object obj)
        {
            System.Windows.Forms.MessageBox.Show("oke");
        }
        public ManageProductViewModel(Inventory item)
        {

            ShowDetailCommand = new BaseViewModelCommand(ExecuteShowDetailCommand);
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
                "Home and Garden",
                "Others"
            };
            IncreaseNumberButttonClick = new BaseViewModelCommand(ExecuteIncreaseNumberCommand);
            DecreaseNumberButttonClick = new BaseViewModelCommand(ExecuteDecreaseNumberCommand, CanExecuteDecreaseNumberCommand);

            BtnImageClick = new BaseViewModelCommand(ExecuteImageClickCommand);

            if (item == null)
            {
                DeleteItem = new BaseViewModelCommand(ExecuteDeleteItemAdd);
                SubmitCommand = new BaseViewModelCommand(ExecuteSubmitAddCommand, CanExecuteSubmitCommand);
                CloseForm = new BaseViewModelCommand(ExecuteCloseFormAddCommand);
                Inventory = new Inventory { IDShop = CurrentApplicationStatus.CurrentID };
                DataProvider.Instance.DB.Inventories.Add(Inventory);
                DataProvider.Instance.DB.SaveChanges();
            }
            else
            {
                DeleteItem = new BaseViewModelCommand(ExecuteDeleteItemEdit);
                SubmitCommand = new BaseViewModelCommand(ExecuteSubmitCommand, CanExecuteSubmitCommand);
                Inventory = item;
                UpdateAllValue(item);
                CloseForm = new BaseViewModelCommand(ExecuteCloseFormCommand);
            }
        }

        private void ExecuteDeleteItemEdit(object obj)
        {
            try
            {
                ImageLinksGV.Remove(obj as string);
                var image = DataProvider.Instance.DB.ImageLinks.Where(p => p.IDProduct == Inventory.IDProduct && p.ImageLink1 == obj as string).FirstOrDefault();
                DataProvider.Instance.DB.ImageLinks.Remove(image);
                DataProvider.Instance.DB.SaveChanges();
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void ExecuteSubmitCommand(object obj)
        {

            WriteToFile();
            Inventory.Name = NameProduct;
            Inventory.OriginalPrice = (float)OriginalPrice;
            Inventory.CurrentPrice = (float)CurrentPrice;
            Inventory.Save = (float)(1 - CurrentPrice / OriginalPrice) * 100;
            Inventory.Newness = Newness;
            Inventory.Type = Type;
            Inventory.NumberInput = Number;
            Inventory.NumberLeft = Number;
            Inventory.BoughtTime = DateBought;
            DataProvider.Instance.DB.SaveChanges();

            new Custom_mb("Succesfully edit item!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
            var currentWindow = obj as Window;
            currentWindow.Close();
        }

        private void UpdateAllValue(Inventory inventory)
        {
            NameProduct = inventory.Name;
            DateBought = (DateTime)inventory.BoughtTime;
            OriginalPrice = (float)inventory.OriginalPrice;

            CurrentPrice = (float)inventory.CurrentPrice;

            Newness = (float)inventory.Newness;
            Type = inventory.Type;
            Number = (int)inventory.NumberLeft;
            string pathOver = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
+ string.Format(@"SanPham\{0}\Tongquansanpham.txt", Inventory.IDProduct.ToString().Trim());
            string pathTinhtrang = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
+ string.Format(@"SanPham\{0}\Tinhtranghientai.txt", Inventory.IDProduct.ToString().Trim());
            string pathThem = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
                + string.Format(@"SanPham\{0}\Thongtinthem.txt", Inventory.IDProduct.ToString().Trim());
            Overview = ReadContextInfile(pathOver);
            Configuration = ReadContextInfile(pathTinhtrang);
            Additional = ReadContextInfile(pathThem);

            var lst = DataProvider.Instance.DB.ImageLinks.Where(p => p.IDProduct == Inventory.IDProduct).ToList();
            foreach (var item in lst)
            {
                ImageLinksGV.Add(item.ImageLink1);
            }
        }
        private string ReadContextInfile(string direction)
        {
            string text = string.Empty;
            StreamReader streamReader = new StreamReader(direction);
            text = streamReader.ReadToEnd();
            return text;
        }
        private void ExecuteDeleteItemAdd(object obj)
        {
            var imageLink = obj as string;
            ImageLinksGV.Remove(imageLink);
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
            var window = obj as Window;
            window.Close();
        }
        private bool CanExecuteDecreaseNumberCommand(object obj)
        {
            if (Number == 1)
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
            string path = Path.GetFullPath("SanPham");
            string folderPath = path.Substring(0, path.IndexOf("bin"));
            string temp = @"SanPham\" + Inventory.IDProduct.ToString().Trim() + @"\Images";
            
            string destinationDirectory = @Path.Combine(folderPath, temp);
            CopyImageToDirectory(destinationDirectory);
            string[] files = Directory.GetFiles(destinationDirectory);
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

                    ImageLinksGV.Add(@"SanPham\" + Inventory.IDProduct.ToString().Trim() + @"\Images\" + Path.GetFileName(sourceFilePath));
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
            if (ImageLinksGV.Count <= 0 || string.IsNullOrEmpty(type) ||
                string.IsNullOrEmpty(overview) || string.IsNullOrEmpty(Additional) ||
                string.IsNullOrEmpty(Configuration) || string.IsNullOrEmpty(NameProduct) ||
                string.IsNullOrEmpty(Newness.ToString()))
            {
                return false;
            }

            if (double.TryParse(CurrentPriceStr, out _) && double.TryParse(OriginalPriceStr, out _) && double.TryParse(NewnessStr, out _))
            {
                CurrentPrice = Convert.ToDouble(CurrentPriceStr);
                OriginalPrice = Convert.ToDouble(OriginalPriceStr);
                Newness = (float)Convert.ToDouble(NewnessStr);
                if (CurrentPrice<=OriginalPrice && (Newness<=100 && Newness>=0) && CurrentPrice!=0 && OriginalPrice!=0)
                    return true;
            }
            return false;
        }
        private bool WriteToFile()
        {
            string pathOver = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
                                + string.Format(@"SanPham\{0}\Tongquansanpham.txt", Inventory.IDProduct.ToString().Trim());
            string pathTinhtrang = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
                                + string.Format(@"SanPham\{0}\Tinhtranghientai.txt", Inventory.IDProduct.ToString().Trim());
            string pathThem = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin"))
                                + string.Format(@"SanPham\{0}\Thongtinthem.txt", Inventory.IDProduct.ToString().Trim());
            bool writeOverview = writeFile(pathOver, Overview);
            bool writeAdditional = writeFile(pathThem, Additional);
            bool writeConfiguration = writeFile(pathTinhtrang, Configuration);
            return writeOverview && writeAdditional && writeConfiguration;
        }
        private bool CheckLetter(string text)
        {
            string num = "0123456789";
            bool flag = false;
            foreach (var item in num)
            {
                if (text[text.Length - 1] == item)
                    flag = true;
            }
            return flag;
        }
        private void ExecuteSubmitAddCommand(object obj)
        {
            var x = (double.TryParse(CurrentPrice.ToString(), out var tempcurrentPrice) && double.TryParse(OriginalPrice.ToString(), out var originalPrice)
               && double.TryParse(Newness.ToString(), out var newness));
            if (WriteToFile())
            {
                //Inventory.IDShop = CurrentApplicationStatus.CurrentID;
                Inventory.Name = NameProduct;
                Inventory.OriginalPrice = (float)OriginalPrice;
                Inventory.CurrentPrice = (float)CurrentPrice;
                Inventory.Save = (float)(1 - CurrentPrice / OriginalPrice) * 100;
                Inventory.Newness = Newness;
                Inventory.Type = Type;
                Inventory.NumberInput = Number;
                Inventory.NumberLeft = Number;
                Inventory.BoughtTime = DateBought;
                DataProvider.Instance.DB.SaveChanges();
                foreach (string imageLink in ImageLinksGV)
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
        public ICommand DeleteItem { get; }
        public ICommand ShowDetailCommand { get; }
        public ICommand CloseForm { get; }
        public Inventory Inventory { get => inventory; set { inventory = value; OnPropertyChanged(nameof(Inventory)); } }

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

        public ObservableCollection<string> ImageLinksGV { get => imageLinksGV; set { imageLinksGV = value; OnPropertyChanged(nameof(ImageLinksGV)); } }
        public int IDShop { get => CurrentApplicationStatus.CurrentID; }
        public string CurrentPriceStr { get => currentPriceStr; set { currentPriceStr = value; OnPropertyChanged(nameof(CurrentPriceStr)); } }
        public string OriginalPriceStr { get => originalPriceStr; set { originalPriceStr = value; OnPropertyChanged(nameof(OriginalPriceStr)); } }
        public string NewnessStr { get => newnessStr; set { newnessStr = value; OnPropertyChanged(nameof(NewnessStr)); } }
    }
}
