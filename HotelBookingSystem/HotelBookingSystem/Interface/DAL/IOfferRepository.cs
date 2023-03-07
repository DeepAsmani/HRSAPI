using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface IOfferRepository
    {
        Task<IEnumerable<Offer>> GetAll();

        Task<ActionsResult> Save(Offer offer);

        Task<Offer> GetById(int id);

        Task<ActionsResult> Delete(int id);

        Task<OfferSearchResult> Search(string offerCode);
    }
}