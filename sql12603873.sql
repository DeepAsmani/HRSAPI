-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql12.freemysqlhosting.net
-- Generation Time: Mar 14, 2023 at 05:33 AM
-- Server version: 5.5.62-0ubuntu0.14.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql12603873`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Admin_Delete` (IN `Id` INT)  BEGIN 
    DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        UPDATE admin
        SET IsDeleted = 1
        WHERE AdminId = Id;

        SET Message = 'Admin has been deleted successfully!';

        SELECT AdminId AS Id, Message AS Message;
    END;
    
    
    BEGIN
        SELECT Id AS Id, Message AS Message;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Admin_GetByCustomerId` (IN `Id1` INT)  BEGIN
	SELECT *
	FROM `admin`
	WHERE `IsDeleted` = 0 AND `AdminId` = `Id1`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Admin_Login` (IN `email1` VARCHAR(255), IN `password1` VARCHAR(255))  BEGIN
    DECLARE passwordHash VARCHAR(255);
    DECLARE adminId1 INT;
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
    SET adminId1 = 0;
    -- Get the customer's password hash based on their email
	SET adminId1 = (SELECT AdminId FROM admin WHERE Email = email1 AND Password = password1);
    
    IF adminId1 != 0 THEN
        -- Password matches, return the customer's ID and a success message        
        SET message = 'Login successful.';
    ELSE
        -- Password doesn't match or customer doesn't exist, return an error message
        SET adminId1 = 0;
        SET message = 'Invalid email or password.';
    END IF;
	SELECT customerId1 AS ID, message AS 'Message';
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Admin_Register` (IN `name` VARCHAR(255), IN `email1` VARCHAR(255), IN `password1` VARCHAR(255))  BEGIN
    DECLARE passwordHash VARCHAR(255);
    DECLARE adminId1 INT;
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
    
    -- Check if customer with same email already exists
    SELECT COUNT(*) INTO @emailCount
    FROM admin
    WHERE Email = email1;
    
    IF @emailCount = 0 THEN
        -- Email is available, create new customer
        -- SET passwordHash = SHA2(password, 256); -- Hash the password using SHA-256
        SET passwordHash = password1;
        INSERT INTO admin (Name, Email, Password)
        VALUES (name, email1, passwordHash);
        
        -- Return the new customer's ID and a success message
        SET adminId1 = LAST_INSERT_ID();
        SET message = 'Registration successful.';
    ELSE
        -- Email is already taken, return an error message
        SET adminId1 = 0;
        SET message = 'Email already in use.';
    END IF;
    SELECT adminId1 AS ID, message AS 'Message';
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_Delete` (IN `p_BookingRoomDetailsId` INT)  BEGIN 
	DECLARE Message VARCHAR(200);
	SET Message = 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `bookingroomdetails`
		WHERE `BookingRoomDetailsId` = p_BookingRoomDetailsId;
		SET Message = 'Booking has been deleted successfully!';
		SELECT p_BookingRoomDetailsId AS Id, Message AS `Message`;
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_DeletebyBookingId` (IN `p_BookingId` INT)  BEGIN
	DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `BookingRoomDetails`
		WHERE p_BookingId = BookingId;
		SET message = 'BookingRoomDetails has been deleted successfully!';
		SELECT p_BookingId AS Id, message AS `Message`;
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_DisplayBookingRoomTypesByBookingId` (IN `BookingId` INT)  BEGIN
    SELECT RoomTypeId, RoomQuantity
    FROM bookingroomdetails
    WHERE BookingId = BookingId AND EXISTS(SELECT * FROM booking WHERE BookingId = BookingId AND IsCanceled = 0)
    GROUP BY RoomTypeId, RoomQuantity;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_GetAll` ()  BEGIN 
    SELECT *
    FROM bookingroomdetails;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_GetByBookingId` (IN `BookingId` INT)  BEGIN
    SELECT *
    FROM bookingroomdetails
    WHERE BookingId = BookingId AND EXISTS(SELECT * FROM BOOKING WHERE BookingId = BookingId AND IsCanceled = 0);
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingRoomDetails_Save` (IN `RoomTypeId` INT, IN `BookingId` INT, IN `RoomQuantity` INT)  BEGIN
DECLARE Message NVARCHAR(200);
DECLARE StartDate DATETIME;
DECLARE EndDate DATETIME;
DECLARE Counter INT;
DECLARE TotalCount INT;

SET Message = 'Something went wrong, please try again!';

BEGIN
	DECLARE DateValue DATETIME;
	DECLARE RoomPrice FLOAT;
	DECLARE DiscountRates FLOAT;

	SET StartDate = (SELECT CheckinDate FROM booking WHERE BookingId = BookingId);
	SET EndDate = (SELECT CheckoutDate FROM booking WHERE BookingId = BookingId);
	SET Counter = 0;
	SET TotalCount = DATEDIFF(EndDate, StartDate) - 1;
	
	WHILE (Counter <= TotalCount) DO
		SET DateValue = DATE_ADD(StartDate, INTERVAL Counter DAY);

		SET DiscountRates =0; /*(
			SELECT MIN(DiscountRates) 
			FROM promotion  
			INNER JOIN promotionapply 
			ON promotion.PromotionId = promotionappy.PromotionId
			WHERE promotionapply.RoomTypeId = RoomTypeId 
			GROUP BY StartDate, EndDate
			HAVING DateValue >= StartDate AND DateValue <= EndDate
		);*/

		IF (DiscountRates <> 0) THEN
			SET RoomPrice = (
				SELECT DefaultPrice 
				FROM roomtype
				WHERE roomtype.RoomTypeId = RoomTypeId
			) * (1 - DiscountRates) * RoomQuantity;
		ELSE
			SET RoomPrice = (
				SELECT DefaultPrice 
				FROM roomtype
				WHERE roomtype.RoomTypeId = RoomTypeId
			) * RoomQuantity;
		END IF;

		INSERT INTO bookingroomdetails (
			RoomTypeId,
			BookingId,
			RoomQuantity,
			Date,
			RoomPrice
		) VALUES (
			RoomTypeId,
			BookingId,
			RoomQuantity,
			DateValue,
			RoomPrice
		);

		SET Counter = Counter + 1;
	END WHILE;

	SET Message = 'BookingRoomDetails has been created successfully!';
	SELECT RoomTypeId AS Id, Message AS `Message`;
END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingServiceDetails_Delete` (IN `in_BookingServiceDetailsId` INT, OUT `out_Id` INT, OUT `out_Message` VARCHAR(200))  BEGIN
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `bookingservicedetails`
		WHERE `BookingServiceDetailsId` = in_BookingServiceDetailsId;
		SET out_Id = in_BookingServiceDetailsId;
		SET out_Message = 'BookingServiceDetails has been deleted successfully!';
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingServiceDetails_DeletebyBookingId` (IN `BookingId` INT)  BEGIN 
    DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT BookingId AS Id, Message AS `Message`;
    END;

    BEGIN
        DELETE FROM `bookingservicedetails`
        WHERE BookingId = BookingId;
        SET Message = 'BookingServiceDetails has been deleted successfully!';
        SELECT BookingId AS Id, Message AS `Message`;
    END;

END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingServiceDetails_GetAll` ()  BEGIN
SELECT *
FROM `bookingservicedetails`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingServiceDetails_GetByBookingId` (IN `BookingId` INT)  BEGIN 
	SELECT *
	FROM `bookingservicedetails`
	WHERE `BookingId` = `bookingservicedetails`.`BookingId` 
	AND EXISTS(SELECT * FROM `booking` WHERE `BookingId` = `booking`.`BookingId` AND `booking`.`IsCanceled` = 0);
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `BookingServiceDetails_Save` (IN `p_BookingId` INT, IN `p_ServiceId` INT, IN `p_ServiceQuantity` INT)  BEGIN
    DECLARE v_ServicePrice FLOAT;

    DECLARE v_Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 0 AS Id, v_Message AS `Message`;
    END;

    -- Get the service price
    SET v_ServicePrice = (SELECT Price FROM `SERVICE` WHERE ServiceId = p_ServiceId) * p_ServiceQuantity;

    -- Insert the new record
    INSERT INTO `bookingservicedetails`
    (BookingId, ServiceId, ServiceQuantity, ServicePrice)
    VALUES
    (p_BookingId, p_ServiceId, p_ServiceQuantity, v_ServicePrice);

    -- Set success message and return the new ID
    SET v_Message = 'BookingServiceDetails has been created successfully!';
    SELECT p_ServiceId AS Id, v_Message AS `Message`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Booking_Delete` (IN `BookingId` INT)  BEGIN
    DECLARE Message NVARCHAR(200);
    SET Message = 'Something went wrong, please try again';
    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            SELECT BookingId AS Id, Message AS `Message`;
        END;
        
        UPDATE booking
        SET IsCanceled = 1
        WHERE BookingId = BookingId;
        
        SET Message = 'Service has been deleted successfully!';
        SELECT BookingId AS Id, Message AS `Message`;
    END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Booking_GetAll` ()  BEGIN 
    SELECT *
    FROM booking
    WHERE IsCanceled = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Booking_GetByBookingId` (IN `p_BookingId` INT)  BEGIN
	SELECT *
	FROM booking
	WHERE IsCanceled = 0 AND p_BookingId = BookingId;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Booking_GetListDate` (IN `p_BookingId` INT)  BEGIN
    DECLARE startDate DATE;
    DECLARE endDate DATE;
    DECLARE currentDate DATE;
    DECLARE counter INT DEFAULT 0;
    DECLARE totalCount INT;
    
    SELECT CheckinDate INTO startDate FROM booking WHERE BookingId = p_BookingId;
    SELECT CheckoutDate INTO endDate FROM booking WHERE BookingId = p_BookingId;
    
    SET totalCount = DATEDIFF(endDate, startDate);
    
    CREATE TEMPORARY TABLE tempDates (
        Dates DATE
    );
    
    WHILE (counter <= totalCount) DO
        SET currentDate = DATE_ADD(startDate, INTERVAL counter DAY);
        INSERT INTO tempDates(Dates) VALUES(currentDate);
        SET counter = counter + 1;
    END WHILE;
    
    SELECT * FROM tempDates;
    
    DROP TABLE tempDates;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Booking_Save` (IN `BookingId` INT, IN `CustomerId` INT, IN `CouponId` INT, IN `CheckinDate` DATETIME, IN `CheckoutDate` DATETIME, IN `NumberofAdults` INT, IN `NumberofChildren` INT)  BEGIN 
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
	DECLARE ServiceAmount FLOAT;
	DECLARE RoomAmount FLOAT;
	DECLARE Reduction FLOAT;
	DECLARE CreateDate DATE;
	DECLARE UpdateCouponId INT DEFAULT NULL;
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SET BookingId = 0;
			SELECT BookingId AS Id, Message AS `Message`;
		END;
		SET CreateDate = NOW();
		IF(EXISTS(SELECT Reduction FROM coupon WHERE (CouponId = CouponId) AND (Remain > 0) AND (CreateDate < EndDate) AND (IsDeleted = 0))) THEN
			BEGIN
				SET Reduction = (SELECT Reduction FROM coupon WHERE (CouponId = CouponId) AND (Remain > 0) AND (CreateDate < EndDate) AND (IsDeleted = 0));
				SET RoomAmount = (SELECT SUM(RoomPrice) FROM bookingroomdetails WHERE BookingId = BookingId)*(1-Reduction);
				SET UpdateCouponId = CouponId;
			END;
		ELSE 
			BEGIN
				SET RoomAmount = (SELECT SUM(RoomPrice) FROM bookingroomdetails WHERE BookingId = BookingId);
			END;
		END IF;
		SET ServiceAmount = (SELECT SUM(ServicePrice) FROM bookingservicedetails WHERE BookingId = BookingId);
		IF (BookingId = 0 OR BookingId IS NULL) THEN
			BEGIN
			INSERT INTO `booking`(
				`CustomerId`,
				`CreateDate`,
				`ServiceAmount`,
				`RoomAmount`,
				`CouponId`,
				`IsCanceled`,
				`CheckinDate`,
				`CheckoutDate`,
				`NumberofAdults`,
				`NumberofChildren`
			)
			VALUES(
				CustomerId,
				CreateDate,
				ServiceAmount,
				RoomAmount,
				UpdateCouponId,
				0,
				CheckinDate,
				CheckoutDate,
				NumberofAdults,
				NumberofChildren
			);
			
			SET BookingId = LAST_INSERT_ID();
			SET Message = 'Booking has been created successfully!';
            END;
		ELSE
			BEGIN
			UPDATE `booking`
			SET `CustomerId` = CustomerId,
				`ServiceAmount` = ServiceAmount,
				`RoomAmount` = RoomAmount,
				`CouponId` = UpdateCouponId,
				`CheckinDate` = CheckinDate,
				`CheckoutDate` = CheckoutDate,
				`NumberofAdults` = NumberofAdults,
				`NumberofChildren` = NumberofChildren
			WHERE BookingId = BookingId;
			
			SET Message = 'Booking has been updated successfully!';
            END;
		END IF;
		SELECT BookingId AS Id, Message AS `Message`;
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Coupon_Delete` (IN `CouponId` INT)  BEGIN
	DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';

	BEGIN
		UPDATE coupon
		SET IsDeleted = 1
		WHERE CouponId = CouponId;

		IF ROW_COUNT() > 0 THEN
			SET Message = 'Coupon has been deleted successfully!';
		END IF;

		SELECT CouponId AS Id, Message AS Message;
	END;

END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Coupon_GetAll` ()  BEGIN
  SELECT *
  FROM coupon
  WHERE (IsDeleted = 0);
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Coupon_GetbyId` (IN `CouponId` INT)  BEGIN
  SELECT *
  FROM coupon
  WHERE CouponId = CouponId AND IsDeleted = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Coupon_Save` (IN `CouponId` INT, IN `CouponCode` NVARCHAR(50), IN `Remain` INT, IN `Reduction` FLOAT, IN `EndDate` DATE)  BEGIN
	DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again!';
	
	BEGIN
		IF (CouponId = 0 OR CouponId IS NULL) THEN -- Create new RoomType
			INSERT INTO coupon
			(CouponCode, Remain, Reduction, EndDate, IsDeleted)
			VALUES
			(CouponCode, Remain, Reduction, EndDate, 0);
			
			SET CouponId = LAST_INSERT_ID();
			SET Message = 'Coupon has been created successfully!';
		ELSE
			UPDATE coupon
			SET CouponCode = CouponCode,
				Remain = Remain,
				Reduction = Reduction,
				EndDate = EndDate
			WHERE CouponId = CouponId;
			
			SET Message = 'Coupon has been updated successfully!';
		END IF;
		
		SELECT CouponId AS Id, Message AS `Message`;
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Coupon_Search` (IN `CouponCode` NVARCHAR(50))  BEGIN
    DECLARE message NVARCHAR(100);
    SET message = 'Code does not exist or has expired please try again!';
    
    IF (EXISTS(SELECT CouponId FROM coupon WHERE CouponCode = CouponCode AND (IsDeleted = 0) AND (NOW() < EndDate) AND (Remain <> 0)))
    THEN
        SELECT CouponId, Reduction, CONCAT('Valid coupon code, you get discount ', Reduction * 100, '%') AS `Message` FROM coupon WHERE CouponCode = CouponCode AND (IsDeleted = 0) AND (NOW() < EndDate) AND (Remain <> 0);
    ELSE
        SELECT 0 AS CouponId, 0 AS Reduction, message AS `Message`;
    END IF;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_Delete` (IN `CustomerId` INT)  BEGIN 
    DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        UPDATE customer
        SET IsDeleted = 1
        WHERE CustomerId = CustomerId;

        SET Message = 'Customer has been deleted successfully!';

        SELECT CustomerId AS Id, Message AS Message;
    END;
    
    
    BEGIN
        SELECT CustomerId AS Id, Message AS Message;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_GetAll` ()  BEGIN
  SELECT *
  FROM customer
  WHERE IsDeleted = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_GetByCustomerId` (IN `CustomerId1` INT)  BEGIN
	SELECT *
	FROM `customer`
	WHERE `IsDeleted` = 0 AND `CustomerId` = `CustomerId1`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_GetByNameOrEmailOrPhone` (IN `search` VARCHAR(255))  BEGIN
    SELECT *
    FROM customer
    WHERE IsDeleted = 0 AND (Name LIKE CONCAT('%', search, '%') OR Email LIKE CONCAT('%', search, '%') OR PhoneNumber LIKE CONCAT('%', search, '%'));
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_Login` (IN `email1` VARCHAR(255), IN `password1` VARCHAR(255))  BEGIN
    DECLARE passwordHash VARCHAR(255);
    DECLARE customerId1 INT;
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
    SET customerId1 = 0;
    -- Get the customer's password hash based on their email
	SET customerId1 = (SELECT CustomerId FROM customer WHERE Email = email1 AND Password = password1);
    
    IF customerId1 != 0 THEN
        -- Password matches, return the customer's ID and a success message        
        SET message = 'Login successful.';
    ELSE
        -- Password doesn't match or customer doesn't exist, return an error message
        SET customerId1 = 0;
        SET message = 'Invalid email or password.';
    END IF;
	SELECT customerId1 AS ID, message AS 'Message';
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `customer_Register` (IN `name` VARCHAR(255), IN `email1` VARCHAR(255), IN `password` VARCHAR(255))  BEGIN
    DECLARE passwordHash VARCHAR(255);
    DECLARE customerId1 INT;
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
        
    -- Check if customer with same email already exists
    SELECT COUNT(*) INTO @emailCount
    FROM customer
    WHERE Email = email1;
    
    IF @emailCount = 0 THEN
        -- Email is available, create new customer
        -- SET passwordHash = SHA2(password, 256); -- Hash the password using SHA-256
        SET passwordHash = password;
        INSERT INTO customer (Name, Email, Password)
        VALUES (name, email1, passwordHash);
        
        -- Return the new customer's ID and a success message
        SET customerId1 = LAST_INSERT_ID();
        SET message = 'Registration successful.';
    ELSE
        -- Email is already taken, return an error message
        SET customerId1 = 0;
        SET message = 'Email already in use.';
    END IF;
    SELECT customerId1 AS ID, message AS 'Message';
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Customer_Save` (INOUT `pCustomerId` INT, IN `pName` NVARCHAR(50), IN `pPhoneNumber` NVARCHAR(50), IN `pEmail` NVARCHAR(50))  BEGIN 
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SELECT 0 AS Id, message AS `Message`;
        END;
        
        START TRANSACTION;
        
        IF (pCustomerId = 0 OR pCustomerId IS NULL) THEN
            -- Create new customer
            INSERT INTO `customer`
            (`Name`, `PhoneNumber`, `Email`)
            VALUES
            (pName, pPhoneNumber, pEmail);
            
            SET pCustomerId = LAST_INSERT_ID();
            SET message = 'Customer has been created successfully!';
        ELSE
            UPDATE `customer`
            SET `Name` = pName,
            `PhoneNumber` = pPhoneNumber,
            `Email` = pEmail
            WHERE `CustomerId` = pCustomerId;
            
            SET message = 'Customer has been updated successfully!';
        END IF;
        
        COMMIT;
    END;
    
    SELECT pCustomerId AS Id, message AS `Message`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `DateTable_Create` (IN `pStartDate` DATETIME, IN `pEndDate` DATETIME)  BEGIN 
    
    DECLARE counter INT DEFAULT 0;
    DECLARE totalCount INT;
    DECLARE dateValue DATETIME;
    CREATE TEMPORARY TABLE tableDate (Dates DATE);
    
    SET totalCount = DATEDIFF(pEndDate, pStartDate);
  
    WHILE (counter <= totalCount) DO
        SET dateValue = DATE_ADD(pStartDate, INTERVAL counter DAY);
        INSERT INTO tableDate (Dates) VALUES (dateValue);
        SET counter = counter + 1;
    END WHILE;
    
    SELECT * FROM tableDate;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `FacilityApply_Delete` (IN `FacilitiesApplyId` INT, OUT `Id` INT, OUT `Message` NVARCHAR(200))  BEGIN
    SET Message = 'Something went wrong, please try again';
    
    BEGIN
        DELETE FROM facilitiesapply
        WHERE FacilitiesApplyId = FacilitiesApplyId;
        SET Id = FacilitiesApplyId;
        SET Message = 'Facility has been removed successfully!';
        SELECT Id, Message;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `FacilityApply_DeleteByRoomTypeId` (IN `RoomTypeId` INT, OUT `Id` INT, OUT `Message` NVARCHAR(200))  BEGIN
    SET Message = 'Something went wrong, please try again';
    
    BEGIN
        DELETE FROM facilitiesapply
        WHERE RoomTypeId = RoomTypeId;
        SET Id = RoomTypeId;
        SET Message = 'Facility has been removed successfully!';
        SELECT Id, Message;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `FacilityApply_GetByRoomTypeId` (IN `RoomTypeId` INT)  BEGIN
    SELECT * FROM facilitiesapply WHERE RoomTypeId = RoomTypeId;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `FacilityApply_Save` (IN `in_facility_id` INT, IN `in_room_type_id` INT, OUT `out_id` INT, OUT `out_message` VARCHAR(200))  BEGIN
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';

	BEGIN
		INSERT INTO `facilitiesapply`
			(`FacilityId`, `RoomTypeId`)
		VALUES
			(in_facility_id, in_room_type_id);

		SET out_id = LAST_INSERT_ID();
		SET Message = 'Facility has been added successfully!';
	END;

	SELECT out_id AS `Id`, Message AS `Message`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Facility_Delete` (IN `pFacilityId` INT)  BEGIN 
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            SELECT pFacilityId AS Id, message AS `Message`;
        END;
        
        DELETE FROM facilities
        WHERE FacilityId = pFacilityId;
        SET message = 'RoomType has been deleted successfully!';
        SELECT pFacilityId AS Id, message AS `Message`;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Facility_GetAll` ()  BEGIN
SELECT *
FROM facilities;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Facility_GetbyId` (IN `FacilityId` INT)  BEGIN
    SELECT *
    FROM facilities
    WHERE FacilityId = FacilityId;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Facility_Save` (IN `FacilityId` INT, IN `FacilityName` NVARCHAR(50), IN `FacilityImage` LONGTEXT, OUT `Id` INT, OUT `Message` NVARCHAR(200))  BEGIN
    SET Message = 'Something went wrong, please try again!';
    
    BEGIN
        IF (FacilityId = 0 OR FacilityId IS NULL) THEN
            INSERT INTO facilities (FacilityName, FacilityImage)
            VALUES (FacilityName, FacilityImage);
            SET Id = LAST_INSERT_ID();
            SET Message = 'Facility has been created successfully!';
        ELSE
            UPDATE facilities
            SET FacilityName = FacilityName,
                FacilityImage = FacilityImage
            WHERE FacilityId = FacilityId;
            SET Id = FacilityId;
            SET Message = 'Facility has been updated successfully!';
        END IF;
    END;
    
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomCancellation` (IN `booking_id` INT, IN `room_id` INT, OUT `success` BIT, OUT `message` VARCHAR(255))  BEGIN
	DECLARE room_price DECIMAL(10,2);
	DECLARE coupon_reduction DECIMAL(10,2);
	DECLARE coupon_id INT;
	DECLARE service_total DECIMAL(10,2);
	DECLARE total_price DECIMAL(10,2);
	DECLARE booking_count INT;
	DECLARE booking_date DATE;
	
	SELECT COUNT(*) INTO booking_count FROM BOOKING WHERE BookingId = booking_id;
	
	IF booking_count = 0 THEN
		SET success = 0;
		SET message = 'Invalid booking ID.';
	ELSE
		SELECT CheckinDate INTO booking_date FROM BOOKING WHERE BookingId = booking_id;
		
		IF booking_date <= CURDATE() THEN
			SET success = 0;
			SET message = 'Booking date has already passed. Cannot cancel room.';
		ELSE
			SELECT RoomPrice INTO room_price FROM BookinRoomDetails WHERE BookingId = booking_id AND RoomId = room_id;
			
			IF room_price IS NULL THEN
				SET success = 0;
				SET message = 'Invalid room ID.';
			ELSE
				SELECT coupon.CouponId, coupon.Reduction INTO coupon_id, coupon_reduction FROM coupon WHERE COUPON.Remain > 0 AND CURDATE() <= COUPON.EndDate AND COUPON.IsDeleted = 0 AND coupon_id = BOOKING.CouponId;
				
				IF coupon_id IS NOT NULL THEN
					SET total_price = (SELECT SUM(RoomPrice) FROM BookingRoomDetails WHERE BookingId = booking_id) * (1-coupon_reduction);
					SET coupon_reduction = NULL;
				ELSE
					SET total_price = (SELECT SUM(RoomPrice) FROM BookingRoomDetails WHERE BookingId = booking_id);
				END IF;
				
				SET service_total = (SELECT SUM(ServicePrice) FROM BookingRoomDetails WHERE BookingId = booking_id);
				
				UPDATE booking SET
					RoomAmount = RoomAmount - room_price,
					ServiceAmount = ServiceAmount - service_total,
					CouponId = coupon_id,
					IsCanceled = 1
				WHERE BookingId = booking_id;
				
				SET success = 1;
				SET message = 'Room cancellation successful.';
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomTypeImage_Delete` (IN `RoomTypeImageId` INT)  BEGIN
    DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';
    BEGIN
        DELETE FROM roomtypeimages
        WHERE RoomTypeImageId = RoomTypeImageId;
        SET Message = 'Image has been deleted successfully!';
    END;
    SELECT RoomTypeImageId AS Id, Message AS `Message`;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomTypeImage_GetByRoomTypeId` (IN `RoomTypeId` INT)  BEGIN
    SELECT * FROM roomtypeimages WHERE RoomTypeId = RoomTypeId;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomTypeImage_Save` (IN `RoomTypeId` INT, IN `ImageData` TEXT)  BEGIN
    DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
    
    INSERT INTO roomtypeimages (RoomTypeId, ImageData)
    VALUES (RoomTypeId, ImageData);
    
    IF ROW_COUNT() > 0 THEN
        SET Message = 'RoomType Image has been save successfully!';
        SELECT LAST_INSERT_ID() AS Id, Message AS `Message`;
    ELSE
        SELECT 0 AS Id, Message AS `Message`;
    END IF;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomType_Delete` (IN `RoomTypeId` INT)  BEGIN
  DECLARE Message VARCHAR(200);
  SET Message = 'Something went wrong, please try again';

  BEGIN
    UPDATE roomtype
    SET IsDeleted = 1
    WHERE RoomTypeId = RoomTypeId;
    SET Message = 'RoomType has been deleted successfully!';
    SELECT RoomTypeId AS Id, Message AS `Message`;
  END;
  
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomType_GetAll` ()  BEGIN
  SELECT *
  FROM roomtype
  WHERE IsDeleted = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomType_GetById` (IN `RoomTypeId1` INT)  BEGIN
  SELECT *
  FROM roomtype
  WHERE IsDeleted = 0 AND RoomTypeId = RoomTypeId1;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomType_Save` (INOUT `RoomTypeId` INT, IN `Name` NVARCHAR(50), IN `DefaultPrice` INT, IN `Quantity` INT, IN `Description` TEXT, IN `MaxAdult` INT, IN `MaxChildren` INT, IN `MaxPeople` INT, OUT `Message` NVARCHAR(200))  BEGIN
  DECLARE ErrorMessage NVARCHAR(200) DEFAULT 'Something went wrong, please try again!';
  
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      SET RoomTypeId = 0;
      SET Message = ErrorMessage;
    END;
    
    IF (RoomTypeId = 0 OR RoomTypeId IS NULL) THEN
      INSERT INTO roomtype (Name, DefaultPrice, Quantity, IsDeleted, Description, MaxAdult, MaxChildren, MaxPeople)
      VALUES (Name, DefaultPrice, Quantity, 0, Description, MaxAdult, MaxChildren, MaxPeople);
      SET RoomTypeId = LAST_INSERT_ID();
      SET Message = 'RoomType has been created successfully!';
    ELSE
      UPDATE roomtype
      SET Name = Name,
          DefaultPrice = DefaultPrice,
          Quantity = Quantity,
          Description = Description,
          MaxAdult = MaxAdult,
          MaxChildren = MaxChildren,
          MaxPeople = MaxPeople
      WHERE RoomTypeId = RoomTypeId;
      SET Message = 'RoomType has been updated successfully!';
    END IF;
    
    SELECT RoomTypeId AS Id, Message;
  END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `RoomType_Search` (IN `Adult` INT, IN `Children` INT, IN `CheckInDate` DATE, IN `CheckOutDate` DATE)  BEGIN
    SELECT RoomTypeId, Fn_MinRemain(RoomTypeId, CheckInDate, CheckOutDate) AS MinRemain
    FROM roomtype
    WHERE IsDeleted = 0
        AND MaxAdult >= Adult
        AND MaxChildren >= Children
        AND MaxPeople >= (Adult + Children)
        AND Fn_MinRemain(RoomTypeId, CheckInDate, CheckOutDate) > 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Room_GetAll` ()  BEGIN
    SELECT `RoomNumber`, `RoomTypeId`
    FROM `room`
    WHERE `IsOccupied` = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Room_GetByRoomNumber` (IN `Number` INT)  BEGIN
    SELECT RoomNumber, RoomTypeId
    FROM room
    WHERE IsOccupied = 0 AND RoomNumber = Number;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Room_GetByRoomTypeId` (IN `Id` INT)  BEGIN
    SELECT RoomNumber, RoomTypeId
    FROM room
    WHERE IsOccupied = 0 AND RoomTypeId = Id;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Room_Save` (IN `RoomNumber1` INT, IN `RoomTypeId` INT)  BEGIN 
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
	
	BEGIN
		IF NOT EXISTS(SELECT * FROM room WHERE RoomNumber1 = RoomNumber) THEN -- Create new RoomType
			INSERT INTO `room`
			(RoomTypeId, RoomNumber, IsOccupied)
			VALUES
			(RoomTypeId, RoomNumber1, 0);
			SET Message = 'Room has been created successfully!';
		ELSE
			UPDATE `room`
			SET RoomTypeId = RoomTypeId
			WHERE RoomNumber = RoomNumber1;
			SET Message = 'Room has been updated successfully!';
		END IF;
		
		SELECT RoomNumber1 AS Id, Message AS `Message`;
	END;
	
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `service_delete` (IN `service_id` INT)  BEGIN
	DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
	
	BEGIN
		UPDATE service SET is_deleted = 1 WHERE service_id = service_id;
		SET message = 'Service has been deleted successfully!';
		SELECT service_id AS id, message AS message;
	END;
	
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Service_GetAll` ()  BEGIN 
	SELECT *
	FROM `Service`
	WHERE IsDeleted = 0;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Service_Save` (IN `ServiceId` INT, IN `ServiceName` NVARCHAR(50), IN `Price` INT, IN `Description` NVARCHAR(500))  BEGIN
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';
	
	BEGIN
		IF (ServiceId = 0 OR ServiceId IS NULL) THEN -- Create new Service
			INSERT INTO `service`
			(`ServiceName`, `Price`, `IsDeleted`, `Description`)
			VALUES
			(ServiceName, Price, 0, Description);
			SET ServiceId = LAST_INSERT_ID();
			SET Message = 'Service has been created successfully!';
		ELSE
			UPDATE `Service`
			SET `ServiceName` = ServiceName,
				`Price` = Price
			WHERE `ServiceId` = ServiceId;
			SET Message = 'Service has been updated successfully!';
		END IF;
		SELECT ServiceId AS Id, Message AS `Message`;
	END;
END$$

CREATE DEFINER=`sql12603873`@`%` PROCEDURE `Service_Search` (IN `keyWord` NVARCHAR(50))  BEGIN
    SELECT *
    FROM `service`
    WHERE IsDeleted = 0 AND ServiceName LIKE CONCAT('%', keyWord, '%');
END$$

--
-- Functions
--
CREATE DEFINER=`sql12603873`@`%` FUNCTION `Fn_MinRemain` (`RoomTypeId` INT, `CheckInDate` DATE, `CheckOutDate` DATE) RETURNS INT(11) BEGIN
  DECLARE Counter INT;
  DECLARE TotalCount INT;
  DECLARE DateValue DATETIME;
  DECLARE Result INT;
  DECLARE CurrentRemain INT;

  SET Counter = 0;
  SET TotalCount = DATEDIFF(CURDATE(), CheckInDate);
  SET Result = (SELECT Quantity FROM roomtype WHERE RoomTypeId = RoomTypeId);

  WHILE (Counter < TotalCount) DO
    SET DateValue = DATE_ADD(CheckInDate, INTERVAL Counter DAY);
    SET CurrentRemain = (SELECT Quantity FROM roomtype WHERE RoomTypeId = RoomTypeId) - (SELECT SUM(RoomQuantity) FROM bookingroomdetails WHERE Date = DateValue AND RoomTypeId = RoomTypeId);
    IF (CurrentRemain < Result) THEN
      SET Result = CurrentRemain;
    END IF;
    SET Counter = Counter + 1;
  END WHILE;

  RETURN Result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminId` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `IsDeleted` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminId`, `Name`, `Email`, `Password`, `IsDeleted`) VALUES
(1, 'admin', 'admin@g.com', '123456', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `BookingId` int(11) NOT NULL,
  `CustomerId` int(11) NOT NULL,
  `CreateDate` datetime NOT NULL,
  `CheckinDate` datetime DEFAULT NULL,
  `CheckoutDate` datetime DEFAULT NULL,
  `NumberofAdults` int(11) DEFAULT NULL,
  `NumberofChildren` int(11) DEFAULT NULL,
  `ServiceAmount` double DEFAULT NULL,
  `RoomAmount` double DEFAULT NULL,
  `IsCanceled` bit(1) NOT NULL,
  `CouponId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`BookingId`, `CustomerId`, `CreateDate`, `CheckinDate`, `CheckoutDate`, `NumberofAdults`, `NumberofChildren`, `ServiceAmount`, `RoomAmount`, `IsCanceled`, `CouponId`) VALUES
(1, 1, '2023-03-10 00:00:00', '2023-03-20 00:00:00', '2023-03-21 00:00:00', 2, 1, NULL, NULL, b'0', 1),
(2, 123, '2023-03-10 00:00:00', '0003-04-23 00:00:00', '0005-04-23 00:00:00', 2, 2, NULL, NULL, b'0', 34);

-- --------------------------------------------------------

--
-- Table structure for table `bookingroomdetails`
--

CREATE TABLE `bookingroomdetails` (
  `BookingRoomDetailsId` int(11) NOT NULL,
  `BookingId` int(11) NOT NULL,
  `RoomTypeId` int(11) NOT NULL,
  `RoomQuantity` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `RoomPrice` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookingroomdetails`
--

INSERT INTO `bookingroomdetails` (`BookingRoomDetailsId`, `BookingId`, `RoomTypeId`, `RoomQuantity`, `Date`, `RoomPrice`) VALUES
(0, 1, 2, 1, '2023-03-20 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `bookingservicedetails`
--

CREATE TABLE `bookingservicedetails` (
  `BookingServiceDetailsId` int(11) NOT NULL,
  `BookingId` int(11) NOT NULL,
  `ServiceId` int(11) NOT NULL,
  `ServiceQuantity` int(11) NOT NULL,
  `ServicePrice` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `CouponId` int(11) NOT NULL,
  `CouponCode` varchar(50) NOT NULL,
  `Remain` int(11) NOT NULL,
  `Reduction` double NOT NULL,
  `EndDate` date NOT NULL,
  `IsDeleted` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`CouponId`, `CouponCode`, `Remain`, `Reduction`, `EndDate`, `IsDeleted`) VALUES
(1, 'abc123', 5, 500, '2023-03-25', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerId` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `IsDeleted` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerId`, `Name`, `PhoneNumber`, `Email`, `Password`, `IsDeleted`) VALUES
(1, 'Deep', '', 'asmanideeped@gmail.com', '123456', b'0'),
(2, 'Test', '8758588088', 'deep87585@gmail.com', '', b'0'),
(3, '123456', '', 'A123456@Gmail.com', 'Deep', b'0'),
(4, 'vraj', '', 'vraj123@gmail.com', '123456', b'0'),
(5, 'test', '', 'test@gmail.com', '123456', b'0'),
(6, 'Deep', '', 'test123@g.com', '123456', b'0'),
(7, 'Deep123', '', 'testdvb@g.com', '123456', b'0'),
(8, 'Deep123', '', 'test8b@g.com', '123456', b'0'),
(9, 'deep', '', 'test123@gm.com', '123456', b'0'),
(10, 'deep', '', 'test123@gma.com', '123456', b'0'),
(11, 'Deep', '', 'Deep@123.com', '123456', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `FacilityId` int(11) NOT NULL,
  `FacilityName` varchar(50) NOT NULL,
  `FacilityImage` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `facilitiesapply`
--

CREATE TABLE `facilitiesapply` (
  `FacilitiesApplyId` int(11) NOT NULL,
  `FacilityId` int(11) NOT NULL,
  `RoomTypeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `PromotionId` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `DiscountRates` double NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `PromotionName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `promotionapply`
--

CREATE TABLE `promotionapply` (
  `PromotionApplyId` int(11) NOT NULL,
  `PromotionId` int(11) NOT NULL,
  `RoomTypeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `RoomNumber` int(11) NOT NULL,
  `RoomTypeId` int(11) NOT NULL,
  `IsOccupied` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`RoomNumber`, `RoomTypeId`, `IsOccupied`) VALUES
(101, 1, b'0'),
(102, 1, b'0'),
(103, 1, b'0'),
(104, 1, b'0'),
(105, 1, b'0'),
(106, 1, b'0'),
(201, 2, b'0'),
(202, 2, b'0'),
(203, 2, b'0'),
(301, 3, b'0'),
(302, 3, b'0'),
(303, 3, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `roomtype`
--

CREATE TABLE `roomtype` (
  `RoomTypeId` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `DefaultPrice` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `Description` longtext,
  `MaxAdult` int(11) NOT NULL,
  `MaxChildren` int(11) NOT NULL,
  `MaxPeople` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`RoomTypeId`, `Name`, `DefaultPrice`, `Quantity`, `IsDeleted`, `Description`, `MaxAdult`, `MaxChildren`, `MaxPeople`) VALUES
(1, 'Deluxe', 4530, 6, b'0', 'These rooms are typically equipped for groups who need more space, like a couple or small family. Joint room: a joint room, sometimes called an adjoining room, refers to two rooms that share a common wall but no connecting door.', 2, 1, 3),
(2, 'Super Deluxe', 7530, 3, b'0', 'These rooms are typically equipped for groups who need more space, like a couple. Joint room: a joint room, sometimes called an adjoining room, refers to two rooms that share a common wall but no connecting door.', 2, 1, 3),
(3, 'Standard', 3530, 3, b'0', 'These rooms are typically equipped, like a couple. Joint room: a joint room, sometimes called an adjoining room, refers to two rooms that share a common wall but no connecting door.', 2, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `roomtypeimages`
--

CREATE TABLE `roomtypeimages` (
  `RoomTypeImageId` int(11) NOT NULL,
  `ImageData` longtext NOT NULL,
  `RoomTypeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `ServiceId` int(11) NOT NULL,
  `ServiceName` varchar(50) NOT NULL,
  `Price` int(11) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `Description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `serviceimages`
--

CREATE TABLE `serviceimages` (
  `ServiceImageId` int(11) NOT NULL,
  `ImageData` longtext NOT NULL,
  `ServiceId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminId`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`BookingId`);

--
-- Indexes for table `bookingroomdetails`
--
ALTER TABLE `bookingroomdetails`
  ADD PRIMARY KEY (`BookingRoomDetailsId`);

--
-- Indexes for table `bookingservicedetails`
--
ALTER TABLE `bookingservicedetails`
  ADD PRIMARY KEY (`BookingServiceDetailsId`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`CouponId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerId`);

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`FacilityId`);

--
-- Indexes for table `facilitiesapply`
--
ALTER TABLE `facilitiesapply`
  ADD PRIMARY KEY (`FacilitiesApplyId`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`PromotionId`);

--
-- Indexes for table `promotionapply`
--
ALTER TABLE `promotionapply`
  ADD PRIMARY KEY (`PromotionApplyId`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`RoomNumber`);

--
-- Indexes for table `roomtype`
--
ALTER TABLE `roomtype`
  ADD PRIMARY KEY (`RoomTypeId`);

--
-- Indexes for table `roomtypeimages`
--
ALTER TABLE `roomtypeimages`
  ADD PRIMARY KEY (`RoomTypeImageId`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`ServiceId`);

--
-- Indexes for table `serviceimages`
--
ALTER TABLE `serviceimages`
  ADD PRIMARY KEY (`ServiceImageId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `BookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `CouponId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `roomtype`
--
ALTER TABLE `roomtype`
  MODIFY `RoomTypeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
