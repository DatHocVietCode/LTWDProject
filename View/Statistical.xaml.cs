
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using LiveCharts;
using LiveCharts.Wpf;

namespace WPF_Market.View
{
    /// <summary>
    /// Interaction logic for Statistical.xaml
    /// </summary>
    public partial class Statistical : Window
    {
        public Statistical()
        {
            InitializeComponent();

            Pointlable = ChartPoint => string.Format("{0}({1:P})", ChartPoint.Y, ChartPoint.Participation);
            DataContext = this;
        }
        public Func<ChartPoint, string> Pointlable {  get; set; }
        private void PieChart_DataClick(object sender, ChartPoint chartPoint)
        {
            var chart = (LiveCharts.Wpf.PieChart)chartPoint.ChartView;
            foreach (PieSeries series in chart.Series)
                series.PushOut = 0;
            var selected = (PieSeries)chartPoint.SeriesView;
            selected.PushOut = 8;
        }

        private void PieChart_Loaded(object sender, RoutedEventArgs e)
        {

        }
    }
}
