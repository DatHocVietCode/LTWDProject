using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Market.Models;

namespace WPF_Market.ViewModel.ProductInvoice
{
    public class ProductInvoice
    {
        private Inventory inventory;
        private LstProduct lstProduct;

        public ProductInvoice(Inventory inventory, LstProduct lstProduct)
        {
            this.inventory = inventory;
            this.lstProduct = lstProduct;
        }

        public Inventory Inventory { get => inventory; set => inventory = value; }
        public LstProduct LstProduct { get => lstProduct; set => lstProduct = value; }
    }
}
