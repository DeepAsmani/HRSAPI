using Dapper;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    public class RoomController : Controller
    {
        public BaseRepository conn = new BaseRepository();

        public RoomController()
        {
        }

        [HttpGet]
        [Route("api/room/getall")]
        public IEnumerable<Room> GetAll()
        {
            return SqlMapper.Query<Room>(conn.con, "Room_GetAll", commandType: CommandType.StoredProcedure);
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
        [Route("api/room/getbyid/{id}")]
        public Room GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return SqlMapper.QueryFirstOrDefaultAsync<Room>(cnn: conn.con, sql: "Room_GetbyId", param: parameters, commandType: CommandType.StoredProcedure).Result;
        }

        /*[HttpGet]
        [Route("api/roomtypes/getbyidwithimagesandfacilities/{id}")]
        public async Task<RoomType> GetByIdWithImages(int id)
        {
            return await roomTypeService.GetByIdWithImagesAndFacilities(id);
        }*/

        [HttpPost]
        [Route("api/room/save")]
        public ActionsResults Save(Room roomType)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@RoomNumber", roomType.RoomNumber);
                parameters.Add("@RoomTypeId", roomType.RoomTypeId);
                return SqlMapper.QueryFirstOrDefault<ActionsResults>(cnn: conn.con, sql: "Room_Save", param: parameters, commandType: CommandType.StoredProcedure);
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

        /*[HttpDelete]
        [Route("api/roomtypes/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return SqlMapper.QueryFirstOrDefault<ActionsResults>(cnn: conn.con, sql: "Room_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }
        */
        
    }
}
