using GrocerStorePro.Function;
using GrocerStorePro.Models;
using Models.EF;
using MoMo;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrocerStorePro.Controllers
{
    public class PayController : Controller
    {
        EcommerceDataEntities db = new EcommerceDataEntities();
        FunctionController fucntion = new FunctionController();
        // GET: Pay
        public ActionResult Cart()
        {
            List<Cart> cart = (List<Cart>)Session["cart"];
            if (Session["cart"] == null)
            {
                cart = new List<Cart>();
            }
            return View(cart);
        }
        
        public ActionResult AddItemToCart(int id, int amount)
        {
            if (Session["cart"] == null)
            {
                Session["cart"] = new List<Cart>();
            }
            List<Cart> cart = (List<Cart>)Session["cart"];
            if(cart.FirstOrDefault(t => t.Id == id) != null)
            {
                var itemCart = cart.FirstOrDefault(t => t.Id == id);
                itemCart.Amount += amount;
            }
            else
            {
                var product = db.Products.Find(id);
                cart.Add(new Cart()
                {
                    Id = id,
                    ProductName = product.product_name,
                    Amount = amount,
                    Image = product.product_img,
                    Price = (float)product.product_price * (float)(1 - ((float)product.product_percent / 100))
                });
            }
            return RedirectToAction("Cart");
        }
        [HttpPost]
        public ActionResult UpdateCart(List<Cart> carts)
        {
            List<Cart> CurrentCart = Session["cart"] as List<Cart>;
            foreach (var cart in carts)
            {
                CurrentCart.FirstOrDefault(t => t.Id == cart.Id).Amount = cart.Amount;
            }
            return RedirectToAction("Cart");
        }

        public ActionResult RemoveItemCart(int id)
        {
            List<Cart> cart = (List<Cart>)Session["cart"];
            var itemCart = cart.FirstOrDefault(t => t.Id == id);
            cart.Remove(itemCart);
            return RedirectToAction("Cart");
        }

        public ActionResult ConfirmOrder()
        {
            if (fucntion.CookieID() == null)
            {
                return Redirect("/Account/Login");
            }
            List<Cart> cart = (List<Cart>)Session["cart"];
            return View(cart);
        }
        [HttpPost]
        public ActionResult ConfirmOrder(string address, string phone, string name, bool typepay)
        {
            var coo = new FunctionController();
            var user = coo.CookieID();
            List<Cart> cart = (List<Cart>)Session["cart"];
            string json = "[";
            foreach (var item in cart)
            {
                json += "{" + "Product_Id:" + item.Id + ",Price:" + item.Price + ",Amount:" + item.Amount + "},";
            }
            json += "]";
            if (typepay)
            {
                var code = Guid.NewGuid().ToString();
                db.Pays.Add(new Pay()
                {
                    user_id = user.ID,
                    pay_guild = code,
                    pay_date = DateTime.Now,
                    pay_form = 1,
                    pay_status = 1,
                    pay_sum = (decimal)cart.Sum(t => (t.Amount * t.Price)),
                    item_json = json.ToString()
                });
                db.SaveChanges();
                return RedirectToAction("HistoryPay");
            }
            return RedirectToAction("PayMoMo");
        }
        public ActionResult PayMoMo()
        {
            var coo = new FunctionController();
            var user = coo.CookieID();
            List<Cart> cart = (List<Cart>)Session["cart"];

            var money = cart.Sum(t => (t.Amount * t.Price));

            //request params need to request to MoMo system
            string endpoint = "https://test-payment.momo.vn/gw_payment/transactionProcessor";
            string partnerCode = "MOMO5RGX20191128";
            string accessKey = "M8brj9K6E22vXoDB";
            string serectkey = "nqQiVSgDMy809JoPF6OzP5OdBUB550Y4";
            string orderInfo = "Thanh toán đơn hàng của " + user.user_nicename;
            string returnUrl = "https://localhost:44384//Pay/ReturnUrl";
            string notifyurl = "https://localhost:44350/Pay/NotifyUrl";

            string amount = money.ToString();
            string orderid = Guid.NewGuid().ToString();
            string requestId = Guid.NewGuid().ToString();
            string extraData = "";

            //Before sign HMAC SHA256 signature
            string rawHash = "partnerCode=" +
                partnerCode + "&accessKey=" +
                accessKey + "&requestId=" +
                requestId + "&amount=" +
                amount + "&orderId=" +
                orderid + "&orderInfo=" +
                orderInfo + "&returnUrl=" +
                returnUrl + "&notifyUrl=" +
                notifyurl + "&extraData=" +
                extraData;

            MoMoSecurity crypto = new MoMoSecurity();
            string signature = crypto.signSHA256(rawHash, serectkey);
            //build body json request
            JObject message = new JObject
                {
                    { "partnerCode", partnerCode },
                    { "accessKey", accessKey },
                    { "requestId", requestId },
                    { "amount", amount },
                    { "orderId", orderid },
                    { "orderInfo", orderInfo },
                    { "returnUrl", returnUrl },
                    { "notifyUrl", notifyurl },
                    { "extraData", extraData },
                    { "requestType", "captureMoMoWallet" },
                    { "signature", signature }

                };

            string responseFromMomo = PaymentRequest.sendPaymentRequest(endpoint, message.ToString());
            JObject jmessage = JObject.Parse(responseFromMomo);

            Session["tmpsession"] = Guid.NewGuid().ToString();

            return Redirect(jmessage.GetValue("payUrl").ToString());
        }
        public ActionResult ReturnUrl(int errorCode, int amount, string orderId)
        {
            if(Session["tmpsession"] == null)
            {
                return RedirectToAction("HistoryPay");
            }
            var coo = new FunctionController();
            var user = coo.CookieID();
            List<Cart> cart = (List<Cart>)Session["cart"];

            User us = db.Users.Find(user.ID);
            string json = "[";
            foreach (var item in cart)
            {
                json += "{" + "Product_Id:" + item.Id + ",Price:" + item.Price + ",Amount:" + item.Amount + "},";
            }
            json += "]";
            if (errorCode.Equals(0))
            {
                ViewBag.Note = "Thanh toán thành công";


                db.Pays.Add(new Pay()
                {
                    pay_date = DateTime.Now,
                    pay_status = 2,
                    pay_sum = (decimal)cart.Sum(t => (t.Amount * t.Price)),
                    user_id = user.ID,
                    pay_form = 2,
                    item_json = json.ToString(),
                });
                db.SaveChanges();

            }
            else
            {
                ViewBag.Note = "Thanh toán thất bại";

                db.Pays.Add(new Pay()
                {
                    pay_date = DateTime.Now,
                    pay_status = 2,
                    pay_sum = (decimal)cart.Sum(t => (t.Amount * t.Price)),
                    user_id = user.ID,
                    pay_form = 1,
                    item_json = json.ToString(),
                });
                db.SaveChanges();
            }
            Session["tmpsession"] = null;
            return RedirectToAction("HistoryPay");
        }

        public ActionResult HistoryPay()
        {
            if(fucntion.CookieID() == null)
            {
                return Redirect("/Account/Login");
            }
            var user = fucntion.CookieID();
            return View(db.Pays.Where(t => t.user_id == user.ID && t.pay_form == 2).ToList());
        }
    }
}