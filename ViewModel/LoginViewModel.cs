using MaterialDesignThemes.Wpf;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client.NativeInterop;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using WPF_Market.Models;
using WPF_Market.View;
namespace WPF_Market.ViewModel
{
    public class LoginViewModel : BaseViewModel
    {
        private WPF_Market.Models.Account userAccount = new WPF_Market.Models.Account();
        public LoginViewModel()
        {
            LoginCommand = new BaseViewModelCommand(ExecuteLoginCommand, CanExecuteLoginCommand);
            CloseCommand = new BaseViewModelCommand(ExecuteCloseCommand);
            SignUpCommand = new BaseViewModelCommand(ExecuteSignUpCommand);
        }

        private void ExecuteSignUpCommand(object obj)
        {
            Window currentWindow = obj as Window;
            new Signup().Show();
            currentWindow.Close();
        }

        private void ExecuteCloseCommand(object obj)
        {
            Application.Current.Shutdown();
        }

        private bool CanExecuteLoginCommand(object obj)
        {
            if (Password is null || UserName is null)
                return false;
            if (Password.Length == 0 || string.IsNullOrEmpty(UserName))
                return false;
            return true;
        }

        private void ExecuteLoginCommand(object obj)
        {

            UserAccount = DataProvider.Instance.DB.Accounts.Where(p => p.UserName == UserAccount.UserName
            && p.Password == UserAccount.Password).FirstOrDefault();
            if (UserAccount != null)
            {
                new Custom_mb("Welcome back, " + UserName, Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
                new Main_Board().Show();
                CurrentApplicationStatus.CurrentID = UserAccount.ID;
                var currentWindow  = obj as Window;
                currentWindow.Close();
            }
            else
            {
                new Custom_mb("Your account does not exist!", Custom_mb.MessageType.Warning, Custom_mb.MessageButtons.Ok).ShowDialog();
            }
        }
        public WPF_Market.Models.Account UserAccount
        {
            get { return userAccount; }
            set
            {
                userAccount = value;
                OnPropertyChanged(nameof(UserAccount));
            }
        }
        public string UserName
        {
            get { return UserAccount?.UserName; }
            set
            {
                UserAccount.UserName = value;
                OnPropertyChanged(nameof(UserName));
            }
        }
        public SecureString Password
        {
            get { return SecureStringProcess.ConvertToSecureString(UserAccount?.Password); }
            set
            {
                if (UserAccount!=null) 
                {
                    UserAccount.Password = SecureStringProcess.ConvertToUnsecureString(value);
                    OnPropertyChanged(nameof(Password));
                }
                
            }
        }
        public ICommand LoginCommand { get; }
        public ICommand CloseCommand { get; }
        public ICommand SignUpCommand { get; }
    }
}
