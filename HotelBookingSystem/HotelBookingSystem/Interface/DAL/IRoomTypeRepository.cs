using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface IRoomTypeRepository
    {
        Task<IEnumerable<RoomType>> GetAll();

        Task<RoomType> GetById(int id);

        Task<ActionsResult> Save(RoomType roomType);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<RoomTypeSearchResult>> Search(SearchModel request);
    }
}