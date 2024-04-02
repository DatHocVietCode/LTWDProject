using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Market.Models
{
    class DataProvider
    {
        private static DataProvider instance;

        public static DataProvider Instance
        {
            get
            {
                if (instance == null)
                    instance = new DataProvider();
                return instance;
            }
            set
            {
                instance = value;
            }
        }
        public TraoDoiMuaBan DB { get; set; }
        private DataProvider()
        {
            DB = new TraoDoiMuaBan();
        }
    }
}
