using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Dapper;
using System.Data;
using System;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class FacilitiesApplyController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();

        public FacilitiesApplyController()
        {
        }

        [HttpPost]
        [Route("api/facilityapply/save")]
        public ActionsResults Save(CreateRoomTypeFacilitiesApplyRequest facilityApply)
        {
            try
            {
                var result = new ActionsResults();
                foreach (var facility in facilityApply.FacilitieIds)
                {
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@FacilityId", int.Parse(facility));
                    parameters.Add("@RoomTypeId", facilityApply.RoomTypeId);
                    result = conn.con.QueryFirstOrDefault<ActionsResults>(sql: "FacilityApply_Save", param: parameters, commandType: CommandType.StoredProcedure);
                }
                return result;
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
        [Route("api/facilityapply/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityApplyId", id);
            return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "FacilityApply_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpDelete]
        [Route("api/facilityapply/deletebyroomtypeid/{id}")]
        public ActionsResults RemoveByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "FacilityApply_DeleteByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/facilityapply/getbyroomtypeid/{id}")]
        public IEnumerable<FacilityApply> GetByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return SqlMapper.Query<FacilityApply>(cnn:conn.con,sql: "FacilityApply_GetByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}