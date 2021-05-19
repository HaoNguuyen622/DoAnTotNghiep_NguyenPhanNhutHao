using GrocerStorePro.Function;
using GrocerStorePro.Models;
using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrocerStorePro.Areas.Admin.Controllers
{
    public class ViewAdminController : Controller
    {
        // GET: Admin/ViewAdmin
        EcommerceDataEntities db = new EcommerceDataEntities();
        FunctionController fucntion = new FunctionController();
        public PartialViewResult Menu(string menu)
        {
            ViewBag.Menu = menu;
            return PartialView();
        }
        public ActionResult Login()
        {
            if (fucntion.CookieAdminID() != null)
            {
                return Redirect("/Admin/HomeAdmin/Index");
            }
            return View();
        }
        [HttpPost]
        public ActionResult Login(ViewSignIn signIn)
        {
            var user = db.Users.FirstOrDefault(t => (t.user_email == signIn.UserName || t.user_login == signIn.UserName) && t.user_pass == signIn.Password);
            if (user != null && user.GroupRoles.FirstOrDefault(t => t.role_id == 2) != null)
            {
                HttpCookie cookie = new HttpCookie("admin_id", user.ID.ToString());
                cookie.Expires.AddDays(10);
                Response.Cookies.Set(cookie);
                return Redirect("/Admin/HomeAdmin/Index");
            }
            return View(signIn);
        }

        public ActionResult Logoff()
        {
            var cookie = Request.Cookies["admin_id"];
            cookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Set(cookie);
            return RedirectToAction("Login");
        }
    }
}