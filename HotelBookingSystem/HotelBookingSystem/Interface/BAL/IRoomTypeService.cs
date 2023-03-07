using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface IRoomTypeService
    {
        Task<IEnumerable<RoomType>> GetAll();

        Task<IEnumerable<RoomType>> GetAllRoomTypeWithImages();

        Task<IEnumerable<RoomType>> GetAllRoomTypeWithImagesAndFacilities();

        Task<RoomType> GetById(int id);

        Task<RoomType> GetByIdWithImagesAndFacilities(int id);

        Task<ActionsResult> Save(CreateRoomTypeRequest roomType);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<RoomTypeSearchResult>> Search(SearchModel request);
    }
}