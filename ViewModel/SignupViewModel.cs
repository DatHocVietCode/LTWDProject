using Azure.Identity;
using System;
using System.Collections.Generic;
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
    class SignupViewModel : BaseViewModel
    {
        private string userName;
        private string email;
        private SecureString password;
        private SecureString repeatPassword;
        public SignupViewModel()
        {
            SignUpCommand = new BaseViewModelCommand(ExecuteSignUpCommand, CanExecuteSignUpCommand);
            LoginCommand = new BaseViewModelCommand(ExecuteLoginCommand);
            CloseCommand = new BaseViewModelCommand(ExecuteCloseCommand);
        }

        private void ExecuteCloseCommand(object obj)
        {
            Window window = obj as Window;
            window.Close();
        }

        private void ExecuteLoginCommand(object obj)
        {
            Window window = obj as Window;
            new Login_new().Show();
            window.Close();
        }

        private bool CanExecuteSignUpCommand(object obj)
        {
            if (UserName==null || Email==null
                || Password is null || RepeatPassword is null)
                return false;
            if (string.IsNullOrEmpty(UserName) || string.IsNullOrEmpty(email) || Password.Length == 0 || RepeatPassword.Length == 0)
                return false;
            return true;
        }

        private void ExecuteSignUpCommand(object obj)
        {
            // se bo sung them check dau vao tai khoan
            bool checkValidAccount = CheckValidAccount();
            if (!checkValidAccount)
            {
                new Custom_mb("Your account is invalid", Custom_mb.MessageType.Warning, Custom_mb.MessageButtons.Ok).ShowDialog();
                return;
            }
            var vaildData = DataProvider.Instance.DB.Accounts.Where(p=> UserName == p.UserName && SecureStringProcess.ConvertToUnsecureString(password)==p.Password).Count();   
            if (vaildData > 0)
            {
                new Custom_mb("Your account has already exist!", Custom_mb.MessageType.Warning, Custom_mb.MessageButtons.Ok).ShowDialog();
                return;
            }
            DataProvider.Instance.DB.Accounts.Add(new Account { Email = Email, UserName = userName, Password = SecureStringProcess.ConvertToUnsecureString(password) });
            DataProvider.Instance.DB.SaveChanges();
            new Custom_mb("Signup successfully! Back to Login!", Custom_mb.MessageType.Success, Custom_mb.MessageButtons.Ok).ShowDialog();
            Window window = obj as Window;
            new Login_new().Show();
            window.Close();
        }

        private bool CheckValidAccount()
        {
            // Sau nay them logic
            if (SecureStringProcess.ConvertToUnsecureString(Password) != SecureStringProcess.ConvertToUnsecureString(repeatPassword))
                return false;
            return true;
        }

        public string UserName
        {
            get { return userName; } 
            set 
            { 
                userName = value;
                OnPropertyChanged(nameof(UserName));
            }
        }
        public string Email { get => email; set { email = value; OnPropertyChanged(nameof(Email)); } }
        public SecureString Password { get => password; set { password = value; OnPropertyChanged(nameof(Password)); } }
        public SecureString RepeatPassword { get => repeatPassword; set { repeatPassword = value; OnPropertyChanged(nameof(RepeatPassword)); } }
        
        // Commands
        public ICommand SignUpCommand { get; }
        public ICommand LoginCommand { get; }
        public ICommand CloseCommand { get; }
    }
}
