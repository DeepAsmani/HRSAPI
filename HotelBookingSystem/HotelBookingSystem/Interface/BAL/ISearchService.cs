using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface ISearchService
    {
        Task<SearchResult> Search(SearchRequest request);
    }
}
