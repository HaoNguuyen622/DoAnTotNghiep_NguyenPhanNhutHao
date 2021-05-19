using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Models.EF;

namespace GrocerStorePro.Areas.Admin.Controllers
{
    public class ProductsAdminController : Controller
    {
        private EcommerceDataEntities db = new EcommerceDataEntities();

        // GET: Admin/ProductsAdmin
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.User);
            return View(products.OrderByDescending(n=>n.product_date).ToList());
        }
        public ActionResult IndexOutOfStock()
        {
            var products = db.Products.Include(p => p.User);
            return View(products.Where(n=>n.product_inventory < 1).ToList());
        }

        // GET: Admin/ProductsAdmin/Details/5
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
            return View(product);
        }

        // GET: Admin/ProductsAdmin/Create
        public ActionResult Create()
        {
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login");
            return View();
        }

        // POST: Admin/ProductsAdmin/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,user_id,product_date,product_update,product_name,product_guid,product_password,product_view,product_content,product_status,product_img,product_price,product_percent,product_active,product_inventory")] Product product, HttpPostedFileBase img)
        {
            if (ModelState.IsValid)
            {
                if(img != null)
                {
                    var code = Guid.NewGuid().ToString();
                    var fileimg = Path.GetFileName(img.FileName);
                    var pa = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Images/Product"), code + fileimg);
                    img.SaveAs(pa);
                    product.product_img = code + fileimg;
                }
                product.product_date = DateTime.Now;
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", product.user_id);
            return View(product);
        }

        // GET: Admin/ProductsAdmin/Edit/5
        public ActionResult Edit(int? id)
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
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", product.user_id);
            return View(product);
        }

        // POST: Admin/ProductsAdmin/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,user_id,product_date,product_update,product_name,product_guid,product_password,product_view,product_content,product_status,product_img,product_price,product_percent,product_active,product_inventory")] Product product, HttpPostedFileBase img)
        {
            if (ModelState.IsValid)
            {
                if (img != null)
                {
                    var code = Guid.NewGuid().ToString();
                    var fileimg = Path.GetFileName(img.FileName);
                    var pa = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Images/Product"), code + fileimg);
                    img.SaveAs(pa);
                    product.product_img = code + fileimg;
                }
                product.product_update = DateTime.Now;
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", product.user_id);
            return View(product);
        }

        // GET: Admin/ProductsAdmin/Delete/5
        public ActionResult Delete(int? id)
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
            foreach(var item in db.Groups.Where(t => t.product_id == id))
            {
                db.Groups.Remove(item);
            }
            foreach (var item in db.ProductDescriptions.Where(t => t.product_id == id))
            {
                db.ProductDescriptions.Remove(item);
            }
            foreach (var item in db.Collections.Where(t => t.Product_Id == id))
            {
                db.Collections.Remove(item);
            }
            db.SaveChanges();
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // POST: Admin/ProductsAdmin/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
