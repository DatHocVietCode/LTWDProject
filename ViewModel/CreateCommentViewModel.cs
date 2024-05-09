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
        private Comment comment = new Comment();
        private ObservableCollection<string> listImageCMT = new ObservableCollection<string>();
        private float rate = 0;
        private DateTime timeCreate = DateTime.Now;
        public CreateCommentViewModel(Shop shop)
        {
            Comment.IDShop = shop.IDShop;
            Comment.IDUser = CurrentApplicationStatus.CurrentID;
            Comment.DataTimeCreate = timeCreate;
            DataProvider.Instance.DB.Add(Comment);
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
                string temp = @"ImageCmt\" + Comment.IDCmt.ToString().Trim();
                //MessageBox.Show(temp);
                string destinationDirectory = @Path.Combine(folderPath, temp);
                CopyImageToDirectory(destinationDirectory);
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
                    string temp = string.Format(@"ImageCmt\{0}\{1}", Comment.IDCmt.ToString().Trim(), Path.GetFileName(sourceFilePath));
                    ListImageCMT.Add(temp);
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
            new Custom_mb("You haven't been completed your comment!\nAll data will be deleted!", Custom_mb.MessageType.Warning, Custom_mb.MessageButtons.Ok).ShowDialog();
            DataProvider.Instance.DB.Comments.Remove(Comment);
            DataProvider.Instance.DB.SaveChanges();
            window.Close();
        }

        private bool CanExecuteCreateComment(object obj)
        {
            if (string.IsNullOrEmpty(commentText) || Rate==0 || ListImageCMT.Count==0) 
            {
                return false;
            }
            return true;
        }

        private void ExecuteCreateComment(object obj)
        {
            var window = (Window)obj;
            //var comment = new Comment();
            //comment1.Comment1 = CommentText;
            //comment1.Rate = (float)Rate;
            Comment.Comment1 = commentText;
            Comment.Rate = (float)Rate;
            foreach (var item in ListImageCMT)
            {
                 DataProvider.Instance.DB.LstImagesCMTs.Add(new LstImagesCMT { IDComment = Comment.IDCmt, ImageLink = item });
            }
            DataProvider.Instance.DB.SaveChanges();
            new Custom_mb("Thanks for your judge!\nHope to see you soon", Custom_mb.MessageType.Confirmation, Custom_mb.MessageButtons.Ok).ShowDialog();
            window.Close();
        }

        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        public string CommentText { get => commentText; set { commentText = value; OnPropertyChanged(nameof(CommentText)); } }
        public float Rate { get => rate; set { rate = value; OnPropertyChanged(nameof(Rate)); } }
        public int IDCmt { get => iDCmt; set { iDCmt = value; OnPropertyChanged(nameof(IDCmt)); } }
        public ICommand CreateComment {  get; }
        public ICommand CloseCommand {  get; }
        public ICommand BtnImageCMT { get; }
        public ObservableCollection<string> ListImageCMT { get => listImageCMT; set { listImageCMT = value; OnPropertyChanged(nameof(ListImageCMT)); } }

        public Comment Comment { get => comment; set { comment = value; OnPropertyChanged(nameof(Comment)); } }
    }
}
