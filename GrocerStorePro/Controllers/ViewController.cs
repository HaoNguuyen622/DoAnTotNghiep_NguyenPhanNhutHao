using GrocerStorePro.Function;
using GrocerStorePro.Models;
using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrocerStorePro.Controllers
{
    public class ViewController : Controller
    {
        FunctionController fucntion = new FunctionController();
        EcommerceDataEntities db = new EcommerceDataEntities();
        // GET: View
        public PartialViewResult Menu()
        {
            ViewBag.CountProduct = 0;
            ViewBag.TotalPrice = 0;
            ViewBag.CountCollection = 0;
            if(Session["cart"] != null)
            {
                List<Cart> cart = Session["cart"] as List<Cart>;
                ViewBag.CountProduct = cart.Count();
                ViewBag.TotalPrice = cart.Sum(t => (t.Amount * t.Price)).ToString("#,###");
            }
            if (fucntion.CookieID() != null)
            {
                var user = fucntion.CookieID();
                ViewBag.CountCollection = db.Collections.Where(t => t.User_Id == user.ID).Count();
            }
            return PartialView();
        }
    }
}