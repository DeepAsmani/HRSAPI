using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface IServiceService
    {
        Task<IEnumerable<Service>> Get();

        Task<Service> Get(int id);

        Task<ActionsResult> Save(CreateServiceRequest service);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<Service>> Search(string keyWord);

        Task<Service> GetByIdWithImages(int id);

        //Task<IEnumerable<Service>> GetAllWithImages();
    }
}