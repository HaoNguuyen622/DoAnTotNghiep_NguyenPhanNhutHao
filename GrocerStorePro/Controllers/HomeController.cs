using GrocerStorePro.Function;
using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrocerStorePro.Controllers
{
    public class HomeController : Controller
    {
        EcommerceDataEntities db = new EcommerceDataEntities();
        FunctionController fucntion = new FunctionController();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public PartialViewResult NewProduct()
        {
            return PartialView(db.Products.Where(t => t.product_active == true).OrderByDescending(t => t.product_date).Take(12).ToList());
        }
        public PartialViewResult PromotionProduct()
        {
            return PartialView(db.Products.Where(t => t.product_active == true && t.product_percent > 0).OrderByDescending(t => t.product_date).Take(7).ToList());
        }
        public PartialViewResult Top3SlideProduct()
        {
            return PartialView();
        }
    }
}