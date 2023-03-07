using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class FacilitiesApplyController : ControllerBase
    {
        private readonly IFacilityApplyService facilityApplyService;

        public FacilitiesApplyController(IFacilityApplyService facilityApplyService)
        {
            this.facilityApplyService = facilityApplyService;
        }

        [HttpPost]
        [Route("api/facilityapply/save")]
        public async Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilityApply)
        {
            return await facilityApplyService.Save(facilityApply);
        }

        [HttpDelete]
        [Route("api/facilityapply/delete/{id}")]
        public async Task<ActionsResult> Remove(int id)
        {
            return await facilityApplyService.Delete(id);
        }

        [HttpDelete]
        [Route("api/facilityapply/deletebyroomtypeid/{id}")]
        public async Task<ActionsResult> RemoveByRoomTypeId(int id)
        {
            return await facilityApplyService.DeleteByRoomTypeId(id);
        }

        [HttpGet]
        [Route("api/facilityapply/getbyroomtypeid/{id}")]
        public async Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id)
        {
            return await facilityApplyService.GetByRoomTypeId(id);
        }
    }
}