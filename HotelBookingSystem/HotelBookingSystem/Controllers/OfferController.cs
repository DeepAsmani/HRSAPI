using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using System.Data;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class OfferController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();

        public OfferController()
        {
        }

        [HttpGet]
        [Route("api/coupon/getbyid/{id}")]
        public Offer GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CouponId", id);
            return SqlMapper.QueryFirstOrDefault<Offer>(cnn: conn.con, sql: "Copuon_GetbyId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/coupon/getall")]
        public IEnumerable<Offer> GetAll()
        {
            return SqlMapper.Query<Offer>(conn.con, "Offer_GetAll", commandType: CommandType.StoredProcedure);
        }

        [HttpPost]
        [Route("api/coupon/save")]
        public ActionsResults Save(Offer coupon)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CouponId", coupon.OfferId);
            parameters.Add("@CouponCode", coupon.OfferCode);
            parameters.Add("@Reduction", coupon.Reduction);
            parameters.Add("@Remain", coupon.Remain);
            parameters.Add("@EndDate", coupon.EndDate);
            return SqlMapper.QueryFirstOrDefault<ActionsResults>(conn.con, sql: "Offer_Save", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpDelete]
        [Route("api/coupon/delete/{id}")]
        public ActionsResults Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@OfferId", id);
            return SqlMapper.QueryFirstOrDefault<ActionsResults>(cnn: conn.con, sql: "Offer_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        [HttpGet]
        [Route("api/coupon/search/{id}")]
        public OfferSearchResult Search(string couponCode)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CouponCode", couponCode);
            return SqlMapper.QueryFirstOrDefault<OfferSearchResult>(cnn: conn.con, sql: "Offer_Search", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}