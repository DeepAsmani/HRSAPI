using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface IFacilityApplyService
    {
        Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id);

        Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilityApply);

        Task<ActionsResult> Delete(int id);

        Task<ActionsResult> DeleteByRoomTypeId(int id);
    }
}