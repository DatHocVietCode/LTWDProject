using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Windows;
using System.Collections.ObjectModel;

namespace WPF_Market.ViewModel
{
    public static class InputBindingBehavior
    {
        public static readonly DependencyProperty InputBindingsProperty =
            DependencyProperty.RegisterAttached("InputBindings",
                typeof(InputBindingCollection),
                typeof(InputBindingBehavior),
                new PropertyMetadata(null, OnInputBindingsChanged));

        public static InputBindingCollection GetInputBindings(DependencyObject obj)
        {
            return (InputBindingCollection)obj.GetValue(InputBindingsProperty);
        }

        public static void SetInputBindings(DependencyObject obj, InputBindingCollection value)
        {
            obj.SetValue(InputBindingsProperty, value);
        }

        private static void OnInputBindingsChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            var element = d as UIElement;
            if (element != null)
            {
                element.InputBindings.Clear();
                var inputBindings = e.NewValue as InputBindingCollection;
                if (inputBindings != null)
                {
                    foreach (var inputBinding in inputBindings)
                    {
                        element.InputBindings.Add((InputBinding)inputBinding);
                    }
                }
            }
        }
    }
}
