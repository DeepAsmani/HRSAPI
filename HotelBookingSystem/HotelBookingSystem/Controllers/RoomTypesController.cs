using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class RoomTypesController : ControllerBase
    {
        private readonly IRoomTypeService roomTypeService;

        public RoomTypesController(IRoomTypeService roomTypeService)
        {
            this.roomTypeService = roomTypeService;
        }

        [HttpGet]
        [Route("api/roomtypes/getall")]
        public async Task<IEnumerable<RoomType>> GetAll()
        {
            return await roomTypeService.GetAll();
        }

        [HttpGet]
        [Route("api/roomtypes/getallroomtypewithimages")]
        public async Task<IEnumerable<RoomType>> GetAllRoomTypeWithImages()
        {
            return await roomTypeService.GetAllRoomTypeWithImages();
        }

        [HttpGet]
        [Route("api/roomtypes/getallroomtypewithimagesandfacilities")]
        public async Task<IEnumerable<RoomType>> GetAllRoomTypeWithImagesAndFacilities()
        {
            return await roomTypeService.GetAllRoomTypeWithImagesAndFacilities();
        }
        //aa
        [HttpGet]
        [Route("api/roomtypes/getbyid/{id}")]
        public async Task<RoomType> GetById(int id)
        {
            return await roomTypeService.GetById(id);
        }

        [HttpGet]
        [Route("api/roomtypes/getbyidwithimagesandfacilities/{id}")]
        public async Task<RoomType> GetByIdWithImages(int id)
        {
            return await roomTypeService.GetByIdWithImagesAndFacilities(id);
        }

        [HttpPost]
        [Route("api/roomtypes/save")]
        public async Task<ActionsResult> Save(CreateRoomTypeRequest roomType)
        {
            return await roomTypeService.Save(roomType);
        }

        [HttpDelete]
        [Route("api/roomtypes/delete/{id}")]
        public async Task<ActionsResult> Remove(int id)
        {
            return await roomTypeService.Delete(id);
        }

        [HttpPost]
        [Route("api/roomtypes/search")]
        public async Task<IEnumerable<RoomTypeSearchResult>> Search(SearchModel request)
        {
            return await roomTypeService.Search(request);
        }
    }
}