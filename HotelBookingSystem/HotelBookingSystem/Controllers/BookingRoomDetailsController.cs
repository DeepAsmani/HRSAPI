using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Dapper;
using System.Data;
using System;

namespace HotelBookingSystem.Controllers
{
    /// <summary>
    ///
    /// </summary>
    [ApiController]
    public class BookingRoomDetailsController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();
        public BookingRoomDetailsController()
        {
            
        }

        [HttpGet]
        [Route("api/bookingRoomDetails/bookingRoomDetails_DisplayBookingRoomTypesByBookingId/{id}")]
        public IEnumerable<BookingRoomDetails> Display(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return (IEnumerable<BookingRoomDetails>)conn.con.QueryAsync<BookingRoomDetails>(sql: "BookingRoomDetails_DisplayBookingRoomTypesByBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/bookingRoomDetails/get/{id}")]
        public IEnumerable<BookingRoomDetails> Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return (IEnumerable<BookingRoomDetails>)conn.con.QueryAsync<BookingRoomDetails>(sql: "BookingRoomDetails_GetByBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpPost]
        [Route("api/bookingRoomDetails/save")]
        public ActionsResults Save(BookingRoomDetails bookingRoomDetails)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookingId", bookingRoomDetails.BookingId);
                parameters.Add("@RoomTypeId", bookingRoomDetails.RoomTypeId);
                parameters.Add("@RoomQuantity", bookingRoomDetails.RoomQuantity);
                var result =conn.con.QueryFirstOrDefaultAsync<ActionsResults>(sql: "BookingRoomDetails_Save", param: parameters, commandType: CommandType.StoredProcedure);
                return result.Result;
            }
            catch (Exception)
            {
                return new ActionsResults()
                {
                    Id = 0,
                    Message = "Something Wrong...."
                };
            }
        }

        [HttpDelete]
        [Route("api/bookingRoomDetails/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingRoomDetailsId", id);
            var result= conn.con.QueryFirstOrDefaultAsync<ActionsResults>(sql: "BookingRoomDetails_Delete", param: parameters, commandType: CommandType.StoredProcedure);
            return result.Result;
        }

        [HttpDelete]
        [Route("api/bookingRoomDetails/detetebyBookingId/{id}")]
        public ActionsResults DeleteByBookingId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            var result = conn.con.QueryFirstOrDefaultAsync<ActionsResults>(sql: "BookingRoomDetails_DeletebyBookingId", param: parameters, commandType: CommandType.StoredProcedure);
            return result.Result;
        }
    }
}