using GrocerStorePro.Function;
using GrocerStorePro.Models;
using Models.EF;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace GrocerStore.Controllers
{
    public class ProductController : Controller
    {
        EcommerceDataEntities db = new EcommerceDataEntities();
        FunctionController fucntion = new FunctionController();
        // GET: Product
        //Tất cả sản phẩm
        public ActionResult Index()
        {
            return View(db.Products.Where(t => t.product_active == true).ToList());
        }
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            //List<ViewInfoProduct> list = JsonConvert.DeserializeObject< List<ViewInfoProduct>(db.Pays.Select(t => t.item_json).ToList());
            return View(product);
        }
        //Phụ
        public PartialViewResult SearchHeader()
        {
            return PartialView();
        }
        public ActionResult GetProductByCategoryId(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            List<Product> products = db.Groups.Where(t => t.term_id == id).Select(t => t.Product).OrderByDescending(t => t.product_date).ToList();
            return View("ResultSearch", products);
        }

        public ActionResult GetProductByKey(string key)
        {
            List<Product> products = db.Products.Where(t => t.product_name.ToLower().Contains(key.ToLower()) || t.product_content.ToLower().Contains(key.ToLower())).OrderByDescending(t => t.product_date).ToList();
            return View("ResultSearch", products);
        }
        //Don hang dang cho duyet
        public ActionResult OderBrowsing()
        {
            if (fucntion.CookieID() == null)
            {
                return Redirect("/Account/Login");
            }
            return View();
        }
        public ActionResult OderYesBrowsing()
        {
            if (fucntion.CookieID() == null)
            {
                return Redirect("/Account/Login");
            }
            return View();
        }
        public ActionResult Bookmark(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            if(product.Collections.First(t => t.Product_Id == id) != null)
            {
                return HttpNotFound();
            }
            db.Collections.Add(new Collection()
            {
                Product_Id = id,
                User_Id = fucntion.CookieID().ID,
                DateAdd = DateTime.Now
            });
            db.SaveChanges();
            return RedirectToAction("MyCollection");
        }
        public ActionResult DeletedBookmark(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            var removeitem = product.Collections.First(t => t.Product_Id == id);
            db.Collections.Remove(removeitem);
            db.SaveChanges();
            return RedirectToAction("MyCollection");
        }
        public ActionResult MyCollection()
        {
            if(fucntion.CookieID() == null)
            {
                return Redirect("/Account/Login");
            }
            var user = fucntion.CookieID();
            return View(db.Collections.Where(t => t.User_Id == user.ID).ToList());
        }

        public ActionResult PromotionProduct()
        {
            var product = db.Products.Where(t => t.product_percent > 0).ToList();
            return View("ResultSearch", product);
        }
    }
}