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
using DevExpress.Data.Mask.Internal;
using DevExpress.DirectX.NativeInterop.Direct2D.CCW;

namespace WPF_Market.ViewModel
{
    class CreateCommentViewModel : BaseViewModel
    {   
        
        private Shop shop;
        private int iDCmt;
        private string commentText;
        private Comment comment1 = new Comment();
        private ObservableCollection<string> listImageCMT = new ObservableCollection<string>();
        private float rate = 0;
        private DateTime timeCreate = DateTime.Now;
        private ObservableCollection<string> imageLinkCMT = new ObservableCollection<string>();
        public CreateCommentViewModel(Shop shop)
        {
            comment1.IDShop = shop.IDShop;
            comment1.IDUser = CurrentApplicationStatus.CurrentID;
            comment1.DataTimeCreate = timeCreate;
            DataProvider.Instance.DB.Add(comment1);
            DataProvider.Instance.DB.SaveChanges();
            this.Shop = shop;

            BtnImageCMT = new BaseViewModelCommand(ExcuteBtnImage);
            CreateComment = new BaseViewModelCommand(ExecuteCreateComment, CanExecuteCreateComment);
            CloseCommand = new BaseViewModelCommand(ExecuteCloseCommand);
        }

        private void ExcuteBtnImage(object obj)
        {
            try
            {
                string path = Path.GetFullPath("ImageCMT");
                string folderPath = path.Substring(0, path.IndexOf("bin"));
                string temp = @"ImageCmt\" + comment1.IDCmt.ToString().Trim();
                //MessageBox.Show(temp);
                string destinationDirectory = @Path.Combine(folderPath, temp);
                CopyImageToDirectory(destinationDirectory);
                string[] files = Directory.GetFiles(destinationDirectory);
                ListImageCMT.Clear();
                foreach (string file in files)
                {
                    ListImageCMT.Add(file);
                }
            }
            catch (Exception ex)
            {
                new Custom_mb("Select picture", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
            }
            
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

                    ImageLinkCMT.Add(@"ImageCmt\" + Comment1.IDCmt.ToString().Trim() + Path.GetFileName(sourceFilePath));
                    new Custom_mb("Operation successfully!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
                }
                catch (Exception ex)
                {
                    new Custom_mb("Operation failed!", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
                }
            }
        }

        private void ExecuteCloseCommand(object obj)
        {
            var window = (Window)obj;
            window.Close();
        }

        private bool CanExecuteCreateComment(object obj)
        {
            if (string.IsNullOrEmpty(commentText) || Rate==0) 
            {
                return false;
            }
            return true;
        }

        private void ExecuteCreateComment(object obj)
        {
            //var comment = new Comment();
            //comment1.Comment1 = CommentText;
            //comment1.Rate = (float)Rate;
            int t = comment1.IDCmt;
            //MessageBox.Show(t.ToString());
            var cmt = DataProvider.Instance.DB.Comments.FirstOrDefault(c => c.IDCmt == t);
            if (cmt != null)
            {
                comment1.Comment1 = commentText;
                comment1.Rate = (float)Rate;
                DataProvider.Instance.DB.SaveChanges();
            }
          
            new Custom_mb("Thanks for your judge!\nHope to see you soon", Custom_mb.MessageType.Confirmation, Custom_mb.MessageButtons.Ok).ShowDialog();
            ExecuteCloseCommand(obj);
        }

        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        public string CommentText { get => commentText; set { commentText = value; OnPropertyChanged(nameof(CommentText)); } }
        public float Rate { get => rate; set { rate = value; OnPropertyChanged(nameof(Rate)); } }
        public int IDCmt { get => iDCmt; set { iDCmt = value; OnPropertyChanged(nameof(IDCmt)); } }
        public ICommand CreateComment {  get; }
        public ICommand CloseCommand {  get; }
        public ICommand BtnImageCMT { get; }
        public Comment Comment1 { get => comment1; set { comment1 = value; OnPropertyChanged(nameof(Comment));} }
        public ObservableCollection<string> ImageLinkCMT { get => imageLinkCMT; set => imageLinkCMT = value; }
        public ObservableCollection<string> ListImageCMT { get => listImageCMT; set => listImageCMT = value; }
    }
}
