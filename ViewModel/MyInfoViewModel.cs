using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;

namespace WPF_Market.ViewModel
{
    internal class MyInfoViewModel : BaseViewModel
    {
        private bool allowEdit = false;
        string relativePath;
        string absolutePath;
        public MyInfoViewModel()
        {
            relativePath = @"ImagesAvatar\" + CurrentApplicationStatus.CurrentID.ToString() + @"\";
            absolutePath = System.IO.Directory.GetCurrentDirectory().Substring(0, System.IO.Directory.GetCurrentDirectory().IndexOf("bin")) + relativePath;
            EditCommand = new BaseViewModelCommand(ExecuteEditCommand);
            ChangeCommand = new BaseViewModelCommand(ExecuteChangeCommand, CanExecuteChangeCommand);
            ChangeAvatar = new BaseViewModelCommand(ExecuteChangeAvatar, CanExecuteChangeAvatar);
        }

        private bool CanExecuteChangeAvatar(object obj)
        {
            return AllowEdit;
        }

        private void ExecuteChangeAvatar(object obj)
        {
            try
            {
                OpenFileDialog openFileDialog = new OpenFileDialog();
                if (openFileDialog.ShowDialog() == true)
                {
                    if (openFileDialog.FileName !="")
                    {
                        if (!File.Exists(absolutePath))
                        {
                            Directory.CreateDirectory(absolutePath);
                        }
                        string sourceFilePath = openFileDialog.FileName;
                        string destinationFilePath = Path.Combine(absolutePath, Path.GetFileName(sourceFilePath));
                      
                        File.Copy(sourceFilePath, destinationFilePath, true);
                        UserAvatar = Path.Combine(relativePath, Path.GetFileName(sourceFilePath));                        
                    }
                }
          
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error opening folder: " + ex.Message);
            }
        }
        private bool CanExecuteChangeCommand(object obj)
        {
            return AllowEdit;
        }

        private void ExecuteChangeCommand(object obj)
        {
            AllowEdit = false;
            if (CheckValidInfor())
            {
                new Custom_mb("Successfully edit your informations!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
                DataProvider.Instance.DB.SaveChanges();
                return;
            }
            else
            {
                new Custom_mb("Wrong information!\nAll your information wont be save!", Custom_mb.MessageType.Error, Custom_mb.MessageButtons.Ok).ShowDialog();
                return;
            }
        }
        private bool CheckValidInfor()
        {
           if (IdentifyNum != null && FullName != null && PhoneNumber != null &&
                Email != null)
            {
                if (PhoneNumber[0] == '0' && PhoneNumber.Length == 10 && Email.Contains('@'))
                    return true;
            }
           return false;
        }

        private void ExecuteEditCommand(object obj)
        {
            AllowEdit = true;
            new Custom_mb("To save your works, please ensure you clicked save button!", Custom_mb.MessageType.Info, Custom_mb.MessageButtons.Ok).ShowDialog();
        }

      
        public int IDAccount { get => CurrentApplicationStatus.CurrentID; }
        public string IdentifyNum { get => CurrentApplicationStatus.CurrentUser.IdentityNum; set { CurrentApplicationStatus.CurrentUser.IdentityNum = value; OnPropertyChanged(nameof(IdentifyNum)); } }
        public string FullName { get => CurrentApplicationStatus.CurrentUser.Name; set { CurrentApplicationStatus.CurrentUser.Name = value;
                OnPropertyChanged(nameof(FullName)); } }
        public DateTime DateOfBirth { get {
                if (CurrentApplicationStatus.CurrentUser.DoB!=null)
                {
                    return (DateTime)CurrentApplicationStatus.CurrentUser.DoB;
                }
                else
                {
                    CurrentApplicationStatus.CurrentUser.DoB = DateTime.Now;
                    DataProvider.Instance.DB.SaveChanges();
                    return DateTime.Now; }
            } set { CurrentApplicationStatus.CurrentUser.DoB = value;
                OnPropertyChanged(nameof(DateOfBirth)); } }
        public string PhoneNumber { get => CurrentApplicationStatus.CurrentUser.PhoneNumber; set { CurrentApplicationStatus.CurrentUser.PhoneNumber = value;
                OnPropertyChanged(nameof(PhoneNumber)); } }
        public string Email { get => CurrentApplicationStatus.CurrentUser.Email; set  { CurrentApplicationStatus.CurrentUser.Email = value; OnPropertyChanged(nameof(Email)); } }
        public string UserAvatar { get => CurrentApplicationStatus.CurrentUser.Avatar; set { CurrentApplicationStatus.CurrentUser.Avatar = value; OnPropertyChanged(nameof(UserAvatar)); } }
        public bool AllowEdit { get => allowEdit; set { allowEdit = value; OnPropertyChanged(nameof(AllowEdit)); } }
        public ICommand EditCommand { get; }
        public ICommand ChangeCommand { get; }
        public ICommand ChangeAvatar {  get; }

    }
}
