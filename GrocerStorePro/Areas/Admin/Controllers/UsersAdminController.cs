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
    public class UsersAdminController : Controller
    {
        private EcommerceDataEntities db = new EcommerceDataEntities();

        // GET: Admin/UsersAdmin
        public ActionResult Index()
        {
            return View(db.Users.ToList());
        }
        public ActionResult IndexAdmin()
        {
            return View(db.Users.Where(t => t.GroupRoles.FirstOrDefault(x => x.role_id == 2) != null).ToList());
        }

        // GET: Admin/UsersAdmin/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Admin/UsersAdmin/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/UsersAdmin/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,user_login,user_pass,user_nicename,user_email,user_activation_key,user_status")] User user)
        {
            if (ModelState.IsValid)
            {
                if (db.Users.FirstOrDefault(t => t.user_email == user.user_email) == null)
                {
                    var code = Guid.NewGuid().ToString();
                    db.Users.Add(new User()
                    {
                        user_email = user.user_email,
                        user_pass = user.user_pass,
                        user_activation_key = code,
                        user_nicename = user.user_nicename,
                        user_status = 1
                    });
                    db.SaveChanges();

                    var user_id = db.Users.FirstOrDefault(t => t.user_activation_key == code).ID;
                    var content_id = db.Users.FirstOrDefault(t => t.user_activation_key == code);
                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "address",
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "phonenumber",
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "email",
                        meta_value = content_id.user_email
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "date",
                        meta_value = DateTime.Now.ToString()
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "date_login",
                        meta_value = DateTime.Now.ToString()
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "date_password",
                        meta_value = DateTime.Now.ToString()
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "zalo"
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "sex"
                    });

                    db.UserMetas.Add(new UserMeta()
                    {
                        user_id = user_id,
                        meta_key = "fb"
                    });

                    db.SaveChanges();


                    HttpCookie cookie = new HttpCookie("user_id", user_id.ToString());
                    cookie.Expires.AddDays(10);
                    Response.Cookies.Set(cookie);

                    return RedirectToAction("MyProfile");
                }
                ViewBag.Noti = "Email đã tồn tại!";
            }

            return View(user);
        }

        // GET: Admin/UsersAdmin/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Admin/UsersAdmin/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,user_login,user_pass,user_nicename,user_email,user_activation_key,user_status")] User user, string address, string phonenumber)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.UserMetas.FirstOrDefault(t => t.user_id == user.ID && t.meta_key == "address").meta_value = address;
                db.UserMetas.FirstOrDefault(t => t.user_id == user.ID && t.meta_key == "phonenumber").meta_value = phonenumber;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

        // GET: Admin/UsersAdmin/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            foreach(var item in db.Pays.Where(t => t.user_id == id))
            {
                db.Pays.Remove(item);
            }
            db.SaveChanges();
            foreach (var item in db.GroupRoles.Where(t => t.user_id == id))
            {
                db.GroupRoles.Remove(item);
            }
            db.SaveChanges();
            foreach (var item in db.UserMetas.Where(t => t.user_id == id))
            {
                db.UserMetas.Remove(item);
            }
            foreach (var item in db.Collections.Where(t => t.Product_Id == id))
            {
                db.Collections.Remove(item);
            }
            db.SaveChanges();
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // POST: Admin/UsersAdmin/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
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
