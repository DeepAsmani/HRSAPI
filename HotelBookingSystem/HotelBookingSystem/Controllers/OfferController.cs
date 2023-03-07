using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using ActionsResult = HotelBookingSystem.Models.Response.ActionsResult;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class OfferController : ControllerBase
    {
        private readonly IOfferService couponService;

        public OfferController(IOfferService couponService)
        {
            this.couponService = couponService;
        }

        [HttpGet]
        [Route("api/coupon/getbyid/{id}")]
        public async Task<Offer> GetById(int id)
        {
            return await couponService.GetById(id);
        }

        [HttpGet]
        [Route("api/coupon/getall")]
        public async Task<IEnumerable<Offer>> GetAll()
        {
            return await couponService.GetAll();
        }

        [HttpPost]
        [Route("api/coupon/save")]
        public async Task<ActionsResult> Save(Offer coupon)
        {
            return await couponService.Save(coupon);
        }

        [HttpDelete]
        [Route("api/coupon/delete/{id}")]
        public async Task<ActionsResult> Delete(int id)
        {
            return await couponService.Delete(id);
        }

        [HttpGet]
        [Route("api/coupon/search/{id}")]
        public async Task<OfferSearchResult> Search(string id)
        {
            return await couponService.Search(id);
        }
    }
}