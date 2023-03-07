using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface IFacilityRepository
    {
        Task<IEnumerable<Facility>> GetAll();

        Task<Facility> GetById(int id);

        Task<ActionsResult> Save(Facility facility);

        Task<ActionsResult> Delete(int id);
    }
}