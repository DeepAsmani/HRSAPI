using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.BAL
{
    public class FacilityApplyService : IFacilityApplyService
    {
        private readonly IFacilityApplyRepository facilityApplyRepository;

        public FacilityApplyService(IFacilityApplyRepository facilityApplyRepository)
        {
            this.facilityApplyRepository = facilityApplyRepository;
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await facilityApplyRepository.Delete(id);
        }

        public async Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilityApply)
        {
            return await facilityApplyRepository.Save(facilityApply);
        }

        public async Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id)
        {
            return await facilityApplyRepository.GetByRoomTypeId(id);
        }

        public async Task<ActionsResult> DeleteByRoomTypeId(int id)
        {
            return await facilityApplyRepository.DeleteByRoomTypeId(id);
        }
    }
}