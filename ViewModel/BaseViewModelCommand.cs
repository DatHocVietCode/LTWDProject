using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace WPF_Market.ViewModel
{
    public class BaseViewModelCommand : ICommand
    {
        // event
        public event EventHandler? CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        private readonly Action<object> _executeAction;
        private readonly Predicate<object> _canExecuteAction;

        public BaseViewModelCommand(Action<object> executeAction, Predicate<object> canExecuteAction)
        {
            _executeAction = executeAction;
            _canExecuteAction = canExecuteAction;
        }

        public BaseViewModelCommand(Action<object> executeAction)
        {
            _executeAction = executeAction;
        }


      
      
      
        // neu field canExecuteAction la null thi tra ve true vi chua thuc hien ham tien doan xem action thuc hien dc khong, nguoc lai thi tra ve mot delegate de xu ly no
        public bool CanExecute(object? parameter)
        {
            return _canExecuteAction==null?true: _canExecuteAction(parameter);
        }

        public void Execute(object? parameter)
        {
            _executeAction(parameter);
        }
    }
}
