using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows;
using System.Windows.Input;

namespace WPF_Market.ViewModel
{
    public static class ContextMenuBehavior
    {
        public static readonly DependencyProperty ShowDetailCommandProperty =
            DependencyProperty.RegisterAttached("ShowDetailCommand",
                typeof(ICommand),
                typeof(ContextMenuBehavior),
                new PropertyMetadata(null));
        public static ICommand GetShowDetailCommand(DependencyObject obj)
        {
            return (ICommand)obj.GetValue(ShowDetailCommandProperty);
        }
        public static void SetShowDetailCommand(DependencyObject obj, ICommand value)
        {
            obj.SetValue(ShowDetailCommandProperty, value);
        }
        public static readonly DependencyProperty DeleteItemCommandProperty =
        DependencyProperty.RegisterAttached("DeleteItemCommand",
        typeof(ICommand),
        typeof(ContextMenuBehavior),
        new PropertyMetadata(null));
        public static ICommand GetDeleteItemCommand(DependencyObject obj)
        {
            return (ICommand)obj.GetValue(DeleteItemCommandProperty);
        }
        public static void SetDeleteItemCommand(DependencyObject obj, ICommand value)
        {
            obj.SetValue(DeleteItemCommandProperty, value);
        }
        public static readonly DependencyProperty IsContextMenuEnabledProperty =
            DependencyProperty.RegisterAttached("IsContextMenuEnabled",
                typeof(bool),
                typeof(ContextMenuBehavior),
                new PropertyMetadata(false, OnIsContextMenuEnabledChanged));

        public static bool GetIsContextMenuEnabled(DependencyObject obj)
        {
            return (bool)obj.GetValue(IsContextMenuEnabledProperty);
        }

        public static void SetIsContextMenuEnabled(DependencyObject obj, bool value)
        {
            obj.SetValue(IsContextMenuEnabledProperty, value);
        }

        private static void OnIsContextMenuEnabledChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            var element = d as UIElement;
            if (element != null)
            {
                if ((bool)e.NewValue)
                {
                    element.PreviewMouseRightButtonDown += Element_PreviewMouseRightButtonDown;
                }
                else
                {
                    element.PreviewMouseRightButtonDown -= Element_PreviewMouseRightButtonDown;
                }
            }
        }

        private static void Element_PreviewMouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            var listViewItem = sender as ListViewItem;
            if (listViewItem != null)
            {
                var contextMenu = new ContextMenu();

                // MenuItem "Show detail"
                var menuItemShowDetail = new MenuItem { Header = "Show detail" };
                var showDetailCommand = GetShowDetailCommand(listViewItem);
                if (showDetailCommand != null)
                {
                    menuItemShowDetail.Command = showDetailCommand;
                    menuItemShowDetail.CommandParameter = listViewItem.DataContext;
                }
                contextMenu.Items.Add(menuItemShowDetail);

                // MenuItem "Delete item"
                var menuItemDeleteItem = new MenuItem { Header = "Delete item" };
                var deleteItemCommand = GetDeleteItemCommand(listViewItem);
                if (deleteItemCommand != null)
                {
                    menuItemDeleteItem.Command = deleteItemCommand;
                    menuItemDeleteItem.CommandParameter = listViewItem.DataContext;
                }
                contextMenu.Items.Add(menuItemDeleteItem);

                contextMenu.IsOpen = true;
                e.Handled = true;
            }
        }

    }
}
