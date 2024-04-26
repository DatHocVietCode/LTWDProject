using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    class CreateCommentViewModel : BaseViewModel
    {
        private Shop shop;
        private string commentText;
        private float rate = 0;
        public CreateCommentViewModel(Shop shop)
        {
            this.Shop = shop;
            CreateComment = new BaseViewModelCommand(ExecuteCreateComment, CanExecuteCreateComment);
            CloseCommand = new BaseViewModelCommand(ExecuteCloseCommand);
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
            var comment = new Comment();
            comment.IDShop = shop.IDShop;
            comment.IDUser = CurrentApplicationStatus.CurrentID;
            comment.DataTimeCreate = DateTime.Now;
            comment.Comment1 = CommentText;
            comment.Rate = (float)Rate;
            DataProvider.Instance.DB.Comments.Add(comment);
            DataProvider.Instance.DB.SaveChanges(); 
            new Custom_mb("Thanks for your judge!\nHope t see you soon", Custom_mb.MessageType.Confirmation, Custom_mb.MessageButtons.Ok).ShowDialog();
            ExecuteCloseCommand(obj);
        }

        public Shop Shop { get => shop; set { shop = value; OnPropertyChanged(nameof(Shop)); } }
        public string CommentText { get => commentText; set { commentText = value; OnPropertyChanged(nameof(CommentText)); } }
        public float Rate { get => rate; set { rate = value; OnPropertyChanged(nameof(Rate)); } }
        public ICommand CreateComment {  get; }
        public ICommand CloseCommand {  get; }
    }
}
