using WebApp.Models.Response;
using WebApp.Ultilities;
using System;
using System.Collections.Generic;
//using System.Web.Mvc;
using Microsoft.AspNetCore.Mvc;

namespace WebApp.Controllers
{
    public class BookingsManagerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult BookingDetails(int id)
        {
            ViewBag.RoomType = GetAllRoomType();
            ViewBag.Coupon = GetAllCoupon();
            ViewBag.Service = GetAllService();
            return View(id);
        }

        public JsonResult Get(int id)
        {
            Booking result = ApiHelper<Booking>.HttpGetAsync($"{Helper.ApiUrl}api/booking/get/{id}");
            // ai đó =.=
            return Json(new { result });
        }

        public JsonResult GetAll()
        {
            List<Booking> result = ApiHelper<List<Booking>>.HttpGetAsync($"{Helper.ApiUrl}api/booking/get");
            return Json(new { result });
        }

        public JsonResult Delete(int id)
        {
            ActionsResult result = ApiHelper<ActionsResult>.HttpGetAsync($"{Helper.ApiUrl}api/booking/delete/{id}", "DELETE");
            return Json(new { result });
        }

        public JsonResult Save([FromBody] Booking model)
        {
            ActionsResult customerResult = ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/customer/save", model.BookingCustomer);
            model.CustomerId = customerResult.Id;
            ActionsResult result;
            result = ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/booking/save", model);
            foreach (var item in model.bookingServiceDetails)
            {
                item.BookingId = result.Id;
                ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/bookingServiceDetails/save", item);
            }
            foreach (var roomDetail in model.bookingRoomDetails)
            {
                roomDetail.BookingId = result.Id;
                ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/bookingRoomDetails/save", roomDetail);
            }
            model.BookingId = result.Id;
            ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/booking/save", model);
            return Json(new { result });
        }

        private List<Offer> GetAllCoupon()
        {
            return ApiHelper<List<Offer>>.HttpGetAsync($"{Helper.ApiUrl}api/coupon/getall");
        }

        private List<RoomType> GetAllRoomType()
        {
            return ApiHelper<List<RoomType>>.HttpGetAsync($"{Helper.ApiUrl}api/roomtypes/getall");
        }

        private List<Service> GetAllService()
        {
            return ApiHelper<List<Service>>.HttpGetAsync($"{Helper.ApiUrl}api/service/get");
        }

        private List<DateTime> GetListDate(int id)
        {
            return ApiHelper<List<DateTime>>.HttpGetAsync($"{Helper.ApiUrl}api/booking/getListDate/{id}");
        }
    }
}