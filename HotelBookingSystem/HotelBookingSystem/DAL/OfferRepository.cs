//using Dapper;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HotelBookingSystem.DAL
{
    public class OfferRepository : BaseRepository//, IOfferRepository
    {/*
        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@OfferId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Offer_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<Offer>> GetAll()
        {
            return await SqlMapper.QueryAsync<Offer>(conn, "Offer_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<Offer> GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@OfferId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<Offer>(cnn: conn, sql: "Offer_GetbyId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(Offer coupon)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@OfferId", coupon.OfferId);
            parameters.Add("@OfferCode", coupon.OfferCode);
            parameters.Add("@Reduction", coupon.Reduction);
            parameters.Add("@Remain", coupon.Remain);
            parameters.Add("@EndDate", coupon.EndDate);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Offer_Save", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<OfferSearchResult> Search(string couponCode)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@OfferCode", couponCode);
            return await SqlMapper.QueryFirstOrDefaultAsync<OfferSearchResult>(cnn: conn, sql: "Offer_Search", param: parameters, commandType: CommandType.StoredProcedure);
        }*/
    }
}