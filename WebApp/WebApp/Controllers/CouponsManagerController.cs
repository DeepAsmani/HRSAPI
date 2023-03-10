using WebApp.Models.Response;
using WebApp.Ultilities;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace WebApp.Controllers
{
    public class CouponsManagerController : Controller
    {
        public IActionResult Index()
        {
            Offer view = new Offer();
            return View(view);
        }

        public JsonResult Get(int id)
        {
            Offer result = ApiHelper<Offer>.HttpGetAsync($"{Helper.ApiUrl}api/coupon/getbyid/{id}");
            return Json(new { result });
        }

        public JsonResult GetAll()
        {
            List<Offer> result = ApiHelper<List<Offer>>.HttpGetAsync($"{Helper.ApiUrl}api/coupon/getall");
            return Json(new { result });
        }

        public JsonResult Delete(int id)
        {
            ActionsResult result = ApiHelper<ActionsResult>.HttpGetAsync($"{Helper.ApiUrl}api/coupon/delete/{id}", "DELETE");
            return Json(new { result });
        }

        public JsonResult Save([FromBody] Offer model)
        {
            ActionsResult result;
            result = ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/coupon/save", model);
            return Json(new { result });
        }
        public JsonResult Search(string id)
        {
            OfferSearchResult result = ApiHelper<OfferSearchResult>.HttpGetAsync($"{Helper.ApiUrl}api/coupon/search/{id}");
            return Json(new { result });
        }
    }
}