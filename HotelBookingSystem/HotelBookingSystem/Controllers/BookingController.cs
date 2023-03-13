using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Data;
using Dapper;
using System.Linq;
using System.Collections.Generic;

namespace HotelBookingSystem.Controllers
{
    /// <summary>
    ///
    /// </summary>
    [ApiController]
    public class BookingController : ControllerBase
    {
        public BaseRepository conn=new BaseRepository();
        
        public BookingController()
        {
            conn.con.Open();
        }

        [HttpGet]
        [Route("api/booking/get")]
        public IEnumerable<Booking> Get()
        {
            return conn.con.Query<Booking>(sql: "Booking_GetAll", commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/booking/get/{id}")]
        public Booking Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return conn.con.QueryFirstOrDefault<Booking>(sql: "Booking_GetByBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpPost]
        [Route("api/booking/save")]
        public ActionsResults Save(Booking booking)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookingId", booking.BookingId);
                parameters.Add("@CustomerId", booking.CustomerId);
                parameters.Add("@CouponId", booking.CouponId);
                parameters.Add("@CheckinDate", booking.CheckinDate);
                parameters.Add("@CheckoutDate", booking.CheckoutDate);
                parameters.Add("@NumberofAdults", booking.NumberofAdults);
                parameters.Add("@NumberofChildren", booking.NumberofChildren);
               
                return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "Booking_Save", param: parameters, commandType: CommandType.StoredProcedure);
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
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "Booking_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/booking/getListDate/{id}")]
        public IEnumerable<DateTime> GetListDate(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return conn.con.Query<DateTime>(sql: "Booking_GetListDate", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}