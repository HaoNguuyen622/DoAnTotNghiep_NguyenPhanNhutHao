using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GrocerStorePro.Models
{
    public class Cart
    {
        public int Id { get; set; }
        public string ProductName { get; set; }
        public float Price { get; set; }
        public int Amount { get; set; }
        public string Image { get; set; }
    }
}