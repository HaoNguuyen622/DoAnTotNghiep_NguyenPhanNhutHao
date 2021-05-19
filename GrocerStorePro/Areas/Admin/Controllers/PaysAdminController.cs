using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Models.EF;

namespace GrocerStorePro.Areas.Admin.Controllers
{
    public class PaysAdminController : Controller
    {
        private EcommerceDataEntities db = new EcommerceDataEntities();

        // GET: Admin/PaysAdmin
        public ActionResult Index()
        {
            var pays = db.Pays.Include(p => p.User);
            return View(pays.OrderByDescending(n=>n.pay_date).ToList());
        }
        public ActionResult IndexNone()
        {
            var pays = db.Pays.Include(p => p.User);
            return View(pays.Where(n=>n.pay_status == Commons.CommonConstants.pay_status_chuaduyet).OrderByDescending(n => n.pay_date).ToList());
        }

        // GET: Admin/PaysAdmin/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pay pay = db.Pays.Find(id);
            if (pay == null)
            {
                return HttpNotFound();
            }
            return View(pay);
        }

        // GET: Admin/PaysAdmin/Create
        public ActionResult Create()
        {
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login");
            return View();
        }

        // POST: Admin/PaysAdmin/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,user_id,pay_sum,pay_date,pay_status,item_json,pay_form")] Pay pay)
        {
            if (ModelState.IsValid)
            {
                db.Pays.Add(pay);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", pay.user_id);
            return View(pay);
        }

        // GET: Admin/PaysAdmin/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pay pay = db.Pays.Find(id);
            if (pay == null)
            {
                return HttpNotFound();
            }
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", pay.user_id);
            return View(pay);
        }

        // POST: Admin/PaysAdmin/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,user_id,pay_sum,pay_date,pay_status,item_json,pay_form")] Pay pay)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pay).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.user_id = new SelectList(db.Users, "ID", "user_login", pay.user_id);
            return View(pay);
        }

        // GET: Admin/PaysAdmin/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pay pay = db.Pays.Find(id);
            if (pay == null)
            {
                return HttpNotFound();
            }
            db.Pays.Remove(pay);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // POST: Admin/PaysAdmin/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pay pay = db.Pays.Find(id);
            db.Pays.Remove(pay);
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
