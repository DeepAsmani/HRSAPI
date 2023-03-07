using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.BAL
{
    public class OfferService : IOfferService
    {
        private readonly IOfferRepository offerRepository;

        public OfferService(IOfferRepository offerRepository)
        {
            this.offerRepository = offerRepository;
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await offerRepository.Delete(id);
        }

        public async Task<IEnumerable<Offer>> GetAll()
        {
            return await offerRepository.GetAll();
        }

        public async Task<Offer> GetById(int id)
        {
            return await offerRepository.GetById(id);
        }

        public async Task<ActionsResult> Save(Offer offer)
        {
            return await offerRepository.Save(offer);
        }

        public async Task<OfferSearchResult> Search(string offerCode)
        {
            return await offerRepository.Search(offerCode);
        }
    }
}