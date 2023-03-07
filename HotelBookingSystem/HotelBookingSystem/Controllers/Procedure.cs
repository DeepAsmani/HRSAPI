using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    public class Procedure
    {
        public Procedure() { }
        public string BookingSave = "CREATE PROCEDURE `Booking_Save`" +
                        "	-- Add the parameters for the stored procedure here" +
            "IN BookingId INT,	IN CustomerId INT,	IN CouponId INT, IN CheckinDate DATETIME, 	IN CheckoutDate DATETIME, " +
            "IN NumberofAdults INT, IN NumberofChildren INT, 	" +
            "OUT Id INT," +
            " OUT Message NVARCHAR(200) " +
            "BEGIN " +
            "   DECLARE ServiceAmount FLOAT; " +
            "   DECLARE RoomAmount FLOAT; " +
            "	DECLARE Reduction FLOAT; " +
            "	DECLARE CreateDate DATE; " +
            "	DECLARE UpdateCouponId INT DEFAULT NULL; " +
            "	SET Message = 'Something went wrong, please try again!'; " +
            "	BEGIN " +
            "   	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION " +
            "		BEGIN " +
            "			SET Id = 0;" +
            "			SELECT Id, Message;" +
            "			END;" +
            "			SET CreateDate = NOW();" +
            "			IF EXISTS(SELECT Reduction FROM COUPON WHERE CouponId = CouponId AND Remain > 0 AND CreateDate<EndDate AND IsDeleted = 0) THEN" +
            "			 BEGIN" +
            "				SET Reduction = (SELECT Reduction FROM COUPON WHERE CouponId = CouponId AND Remain > 0 AND CreateDate<EndDate AND IsDeleted = 0);" +
            "			SET RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = BookingId) *Reduction;" +
            "			SET UpdateCouponId = CouponId;" +
            "			END;" +
            "			ELSE" +
            "				BEGIN" +
            "				SET RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = BookingId);" +
            "			END;			END IF;" +
            "		SET ServiceAmount = (SELECT SUM(ServicePrice) FROM BOOKINGSERVICEDETAILS WHERE BookingId = BookingId);" +
            "		IF BookingId = 0 OR BookingId IS NULL THEN				BEGIN --Create new RoomType	INSERT INTO BOOKING(CustomerId, CreateDate, ServiceAmount, RoomAmount, CouponId, IsCanceled, CheckinDate, CheckoutDate, NumberofAdults, NumberofChildren) " +
            "				VALUES(CustomerId, CreateDate, 0, 0, UpdateCouponId, 0, CheckinDate, CheckoutDate, NumberofAdults, NumberofChildren); " +
            "			SET BookingId = LAST_INSERT_ID();" +
            "			SET Message = 'Booking has been created successfully!'; " +
            "			END; " +
            "			ELSE" +
            "				BEGIN" +
            "				UPDATE BOOKING				SET CustomerId = CustomerId, " +
            "			ServiceAmount = ServiceAmount," +
            "				RoomAmount = RoomAmount," +
            "				CouponId = UpdateCouponId," +
            "				CheckinDate = CheckinDate," +
            "				CheckoutDate = CheckoutDate," +
            "				NumberofAdults = NumberofAdults," +
            "				NumberofChildren = NumberofChildren" +
            "		WHERE BookingId = BookingId; " +
            "           			SET Message = 'Booking has been updated successfully!';" +
            "            END;" +
            "            ND IF; " +
            "			SET Id = BookingId;" +
            "			SELECT Id, Message;" +
            "			END;" +
            "			END;";




        public string BookingDelete = "CREATE PROCEDURE `Booking_Delete`(     -- Add the parameters for the stored procedure here     IN p_BookingId INT ) " +
                "                BEGIN " +
                "                    DECLARE v_Message VARCHAR(200) DEFAULT 'Something went wrong, please try again'; " +
                "            BEGIN " +
                "                DECLARE EXIT HANDLER FOR SQLEXCEPTION " +
                "        BEGIN " +
                "            SELECT p_BookingId AS Id, v_Message AS `Message`; " +
                "            END; " +
                "            UPDATE BOOKING" +
                "        SET IsCanceled = 1 " +
                "        WHERE BookingId = p_BookingId; " +
                "            SET v_Message = 'Service has been deleted successfully!'; " +
                "            SELECT p_BookingId AS Id, v_Message AS `Message`; " +
                "            END; " +
                "            END;";




        public string BookingDateGetList = "CREATE PROCEDURE `Booking_GetListDate`(IN `BookingId` INT) " +
            "BEGIN" +
            "  DECLARE StartDate DATETIME;" +
            "        DECLARE EndDate DATETIME;" +
            "  DECLARE Counter INT DEFAULT 0;" +
            "        DECLARE TotalCount INT;" +
            "  CREATE TEMPORARY TABLE tableDate(" +
            "    Dates DATE" +
            "  );" +
            "        SET StartDate = (SELECT CheckinDate FROM BOOKING WHERE BookingId = BookingId);" +
            "  SET EndDate = (SELECT CheckoutDate FROM BOOKING WHERE BookingId = BookingId);" +
            "  SET TotalCount = DATEDIFF(EndDate, StartDate);" +
            "        WHILE(Counter <= TotalCount) DO" +
            "         DECLARE DateValue DATETIME;" +
            "        SET DateValue = DATE_ADD(StartDate, INTERVAL Counter DAY);" +
            "        INSERT INTO tableDate(Dates) VALUES(DateValue);" +
            "        SET Counter = Counter + 1;" +
            "        END WHILE;" +
            "        SELECT* FROM tableDate;" +
            "END";
    }
}
