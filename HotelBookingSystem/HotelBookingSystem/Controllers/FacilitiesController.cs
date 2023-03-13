using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using System.Data;
using Dapper;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class FacilitiesController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();

        public FacilitiesController() {    }

        [HttpGet]
        [Route("api/facilities/getall")]
        public IEnumerable<Facility> GetAll()
        {
            return SqlMapper.Query<Facility>(conn.con, "Facility_GetAll", commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/facilities/getbyid/{id}")]
        public Facility GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityId", id);
            return SqlMapper.QueryFirstOrDefault<Facility>(cnn: conn.con, sql: "Facility_GetbyId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpPost]
        [Route("api/facilities/save")]
        public ActionsResults Save(Facility facility)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@FacilityId", facility.FacilityId);
                parameters.Add("@FacilityName", facility.FacilityName);
                parameters.Add("@FacilityImage", facility.FacilityImage);
                return SqlMapper.QueryFirstOrDefault<ActionsResults>(cnn: conn.con, sql: "Facility_Save", param: parameters, commandType: CommandType.StoredProcedure);
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
        [Route("api/facilities/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityId", id);
            return SqlMapper.QueryFirstOrDefault<ActionsResults>(cnn: conn.con, sql: "Facility_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}