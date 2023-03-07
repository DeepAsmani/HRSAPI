using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface IFacilityApplyRepository
    {
        Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id);

        Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilitysApply);

        Task<ActionsResult> Delete(int id);

        Task<ActionsResult> DeleteByRoomTypeId(int id);
    }
}