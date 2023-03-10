﻿using WebApp.Models.Response;
using WebApp.Ultilities;
using System.Collections.Generic;
using System.Web.Mvc;

namespace WebApp.Controllers
{
    public class BookingRoomDetailsController : Controller
    {
        public JsonResult Display(int id)
        {
            List<BookingRoomDetails> result = ApiHelper<List<BookingRoomDetails>>.HttpGetAsync($"{Helper.ApiUrl}api/bookingRoomDetails_DisplayBookingRoomTypesByBookingId/get/{id}");
            return Json(new { result });
        }

        public JsonResult Get(int id)
        {
            List<BookingRoomDetails> result = ApiHelper<List<BookingRoomDetails>>.HttpGetAsync($"{Helper.ApiUrl}api/bookingRoomDetails/get/{id}");
            return Json(new { result });
        }

        public JsonResult Delete(int id)
        {
            ActionsResult result = ApiHelper<ActionsResult>.HttpGetAsync($"{Helper.ApiUrl}api/bookingRoomDetails/delete/{id}", "DELETE");
            return Json(new { result });
        }

        public JsonResult DeleteByBookingId(int id)
        {
            ActionsResult result = ApiHelper<ActionsResult>.HttpGetAsync($"{Helper.ApiUrl}api/bookingRoomDetails/detetebyBookingId/{id}", "DELETE");
            return Json(new { result });
        }

        /*public JsonResult Save([FromBody] BookingRoomDetails model)
        {
            ActionsResult result;
            result = ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/bookingRoomDetails/save", model);
            return Json(new { result });
        }*/
    }
}