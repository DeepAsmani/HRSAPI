using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Models.Request;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
using Dapper;
using System.Linq;

namespace HotelBookingSystem.Controllers
{
    /// <summary>
    ///
    /// </summary>
    [ApiController]
    public class BookingController : ControllerBase
    {
        public MySqlConnection con = new MySqlConnection("Data Source=sql12.freemysqlhosting.net;Database=sql12602557;User Id=sql12602557;Password=yKkcKGu4mS");
        public MySqlCommand sda;
        private readonly IBookingService bookingService;
        public Procedure query;

        public BookingController(IBookingService bookingService, Procedure p)
        {
            this.bookingService = bookingService;
            query = p;
        }

        [HttpGet]
        [Route("api/booking/get")]
        /*public async Task<IEnumerable<Booking>> Get()
        {
            return ;
        }*/

        [HttpGet]
        [Route("api/booking/get/{id}")]
        public Booking Get(int id)
        {
            con.Open();
            string query = "SELECT RoomTypeId, RoomQuantity FROM BOOKINGROOMDETAILS WHERE @BookingId = BOOKINGROOMDETAILS.BookingId AND EXISTS(SELECT* FROM BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0) GROUP BY RoomTypeId, RoomQuantity;";
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            var result = con.QueryAsync<Booking>(query,param:parameters);
            con.Close();
            return result.Result.FirstOrDefault();
        }

        [HttpPost]
        [Route("api/booking/save")]
        public ActionsResults Save(Booking booking)
        {
            try
            {
                con.Open();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookingId", booking.BookingId);
                parameters.Add("@CustomerId", booking.CustomerId);
                parameters.Add("@CouponId", booking.CouponId);
                parameters.Add("@CheckinDate", booking.CheckinDate);
                parameters.Add("@CheckoutDate", booking.CheckoutDate);
                parameters.Add("@NumberofAdults", booking.NumberofAdults);
                parameters.Add("@NumberofChildren", booking.NumberofChildren);
                con.Close();
                var result = con.QueryAsync<ActionsResults>(query.BookingSave, param: parameters);
                return result.Result.FirstOrDefault();
            }
            catch (Exception e)
            {
                return new ActionsResults()
                {
                    Id = 0,
                    Message = e.Message
                };
            }
        }

        [HttpDelete]
        [Route("api/booking/delete/{id}")]
        public ActionsResults Remove(int id)
        {

            con.Open();
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            var result = con.QueryAsync<ActionsResults>(query.BookingDelete, param: parameters);
            con.Close();
            return result.Result.FirstOrDefault();
        }

        [HttpGet]
        [Route("api/booking/getListDate/{id}")]
        public IEnumerable<DateTime> GetListDate(int id)
        {
            return await bookingService.GetListDate(id);
        }
    }
}