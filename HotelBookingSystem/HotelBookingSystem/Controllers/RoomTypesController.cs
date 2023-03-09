using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using System;
using System.Data;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class RoomTypesController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();

        public RoomTypesController()
        {
        }

        [HttpGet]
        [Route("api/roomtypes/getall")]
        public IEnumerable<RoomType> GetAll()
        {
            return SqlMapper.QueryAsync<RoomType>(conn.con, "RoomType_GetAll", commandType: CommandType.StoredProcedure).Result;
        }

        /*[HttpGet]
        [Route("api/roomtypes/getallroomtypewithimages")]
        public IEnumerable<RoomType> GetAllRoomTypeWithImages()
        {
            return await roomTypeService.GetAllRoomTypeWithImages();
        }*/

        /*[HttpGet]
        [Route("api/roomtypes/getallroomtypewithimagesandfacilities")]
        public async Task<IEnumerable<RoomType>> GetAllRoomTypeWithImagesAndFacilities()
        {
            return await roomTypeService.GetAllRoomTypeWithImagesAndFacilities();
        }*/

        [HttpGet]
        [Route("api/roomtypes/getbyid/{id}")]
        public RoomType GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return SqlMapper.QueryFirstOrDefaultAsync<RoomType>(cnn: conn.con, sql: "RoomType_GetbyId", param: parameters, commandType: CommandType.StoredProcedure).Result;
        }

        /*[HttpGet]
        [Route("api/roomtypes/getbyidwithimagesandfacilities/{id}")]
        public async Task<RoomType> GetByIdWithImages(int id)
        {
            return await roomTypeService.GetByIdWithImagesAndFacilities(id);
        }*/

        [HttpPost]
        [Route("api/roomtypes/save")]
        public ActionsResults Save(CreateRoomTypeRequest roomType)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@RoomTypeId", roomType.RoomTypeId);
                parameters.Add("@Name", roomType.Name);
                parameters.Add("@DefaultPrice", roomType.DefaultPrice);
                parameters.Add("@MaxAdult", roomType.MaxAdult);
                parameters.Add("@MaxChildren", roomType.MaxChildren);
                parameters.Add("@MaxPeople", roomType.MaxPeople);
                parameters.Add("@Quantity", roomType.Quantity);
                parameters.Add("@Description", roomType.Description);
                return SqlMapper.QueryFirstOrDefaultAsync<ActionsResults>(cnn: conn.con, sql: "RoomType_Save", param: parameters, commandType: CommandType.StoredProcedure).Result;
            }
            catch (Exception)
            {
                return new ActionsResults()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!"
                };
            }
        }

        [HttpDelete]
        [Route("api/roomtypes/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return SqlMapper.QueryFirstOrDefaultAsync<ActionsResults>(cnn: conn.con, sql: "RoomType_Delete", param: parameters, commandType: CommandType.StoredProcedure).Result;
        }

        [HttpPost]
        [Route("api/roomtypes/search")]
        public IEnumerable<RoomTypeSearchResult> Search(SearchModel request)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Adult", request.NumberofAdults);
            parameters.Add("@Children", request.NumberofChildren);
            parameters.Add("@CheckInDate", request.CheckinDate);
            parameters.Add("@CheckOutDate", request.CheckoutDate);
            return SqlMapper.QueryAsync<RoomTypeSearchResult>(cnn: conn.con, sql: "RoomType_Search", param: parameters, commandType: CommandType.StoredProcedure).Result;
        }
    }
}