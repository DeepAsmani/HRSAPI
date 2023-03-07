using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface IOfferService
    {
        Task<IEnumerable<Offer>> GetAll();

        Task<Offer> GetById(int id);

        Task<ActionsResult> Save(Offer offer);

        Task<ActionsResult> Delete(int id);

        Task<OfferSearchResult> Search(string offerCode);
    }
}