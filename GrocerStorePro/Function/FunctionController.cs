using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Models.EF;

namespace GrocerStorePro.Function
{
    public class FunctionController : Controller
    {
        EcommerceDataEntities db = new EcommerceDataEntities();
        // GET: Function
        public User CookieID()
        {
            HttpCookie cookie = System.Web.HttpContext.Current.Request.Cookies["user_id"];
            if(cookie == null)
            {
                return null;
            }
            try
            {
                User user = db.Users.Find(Int32.Parse(cookie.Value.ToString()));
                return user;
            }
            catch (Exception) { return null; }

        }
        public HttpCookie Cookie()
        {
            HttpCookie cookie = System.Web.HttpContext.Current.Request.Cookies["user_id"];
            return cookie;

        }

        public User CookieAdminID()
        {
            HttpCookie cookie = System.Web.HttpContext.Current.Request.Cookies["admin_id"];
            if (cookie == null)
            {
                return null;
            }
            try
            {
                User user = db.Users.Find(Int32.Parse(cookie.Value.ToString()));
                return user;
            }
            catch (Exception) { return null; }

        }
    }
}