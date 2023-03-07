namespace HotelBookingSystem.Models.Request
{
    public class CreateRoomTypeFacilitiesApplyRequest
    {
        public int RoomTypeId { get; set; }
        public string[] FacilitieIds { get; set; }
    }
}