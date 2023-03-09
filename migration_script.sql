-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: hotelbooking
-- Source Schemata: hotelbooking
-- Created: Wed Mar  8 19:14:18 2023
-- Workbench Version: 8.0.32
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema hotelbooking
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `hotelbooking` ;
CREATE SCHEMA IF NOT EXISTS `hotelbooking` ;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.booking
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`booking` (
  `BookingId` INT(11) NOT NULL,
  `CustomerId` INT(11) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CheckinDate` DATETIME NULL DEFAULT NULL,
  `CheckoutDate` DATETIME NULL DEFAULT NULL,
  `NumberofAdults` INT(11) NULL DEFAULT NULL,
  `NumberofChildren` INT(11) NULL DEFAULT NULL,
  `ServiceAmount` DOUBLE NULL DEFAULT NULL,
  `RoomAmount` DOUBLE NULL DEFAULT NULL,
  `IsCanceled` BIT(1) NOT NULL,
  `CouponId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`BookingId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.bookingroomdetails
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`bookingroomdetails` (
  `BookingRoomDetailsId` INT(11) NOT NULL,
  `BookingId` INT(11) NOT NULL,
  `RoomTypeId` INT(11) NOT NULL,
  `RoomQuantity` INT(11) NOT NULL,
  `Date` DATETIME NOT NULL,
  `RoomPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`BookingRoomDetailsId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.bookingservicedetails
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`bookingservicedetails` (
  `BookingServiceDetailsId` INT(11) NOT NULL,
  `BookingId` INT(11) NOT NULL,
  `ServiceId` INT(11) NOT NULL,
  `ServiceQuantity` INT(11) NOT NULL,
  `ServicePrice` DOUBLE NOT NULL,
  PRIMARY KEY (`BookingServiceDetailsId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.coupon
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`coupon` (
  `CouponId` INT(11) NOT NULL,
  `CouponCode` VARCHAR(50) NOT NULL,
  `Remain` INT(11) NOT NULL,
  `Reduction` DOUBLE NOT NULL,
  `EndDate` DATE NOT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  PRIMARY KEY (`CouponId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.customer
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`customer` (
  `CustomerId` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `PhoneNumber` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.__efmigrationshistory
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.__efmigrationshistory` (
  `MigrationId` VARCHAR(150) NOT NULL,
  `ProductVersion` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`MigrationId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetroleclaims
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetroleclaims` (
  `Id` INT(11) NOT NULL,
  `RoleId` VARCHAR(450) NOT NULL,
  `ClaimType` LONGTEXT NULL DEFAULT NULL,
  `ClaimValue` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_AspNetRoleClaims_RoleId` (`RoleId`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetroles
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetroles` (
  `Id` VARCHAR(450) NOT NULL,
  `Name` VARCHAR(256) NULL DEFAULT NULL,
  `NormalizedName` VARCHAR(256) NULL DEFAULT NULL,
  `ConcurrencyStamp` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`(255)),
  UNIQUE INDEX `RoleNameIndex` (`NormalizedName`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetuserclaims
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetuserclaims` (
  `Id` INT(11) NOT NULL,
  `UserId` VARCHAR(450) NOT NULL,
  `ClaimType` LONGTEXT NULL DEFAULT NULL,
  `ClaimValue` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_AspNetUserClaims_UserId` (`UserId`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetuserlogins
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetuserlogins` (
  `LoginProvider` VARCHAR(450) NOT NULL,
  `ProviderKey` VARCHAR(450) NOT NULL,
  `ProviderDisplayName` LONGTEXT NULL DEFAULT NULL,
  `UserId` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`LoginProvider`(255), `ProviderKey`(255)),
  INDEX `IX_AspNetUserLogins_UserId` (`UserId`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetuserroles
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetuserroles` (
  `UserId` VARCHAR(450) NOT NULL,
  `RoleId` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`UserId`(255), `RoleId`(255)),
  INDEX `IX_AspNetUserRoles_RoleId` (`RoleId`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.aspnetusers
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.aspnetusers` (
  `Id` VARCHAR(450) NOT NULL,
  `UserName` VARCHAR(256) NULL DEFAULT NULL,
  `NormalizedUserName` VARCHAR(256) NULL DEFAULT NULL,
  `Email` VARCHAR(256) NULL DEFAULT NULL,
  `NormalizedEmail` VARCHAR(256) NULL DEFAULT NULL,
  `EmailConfirmed` BIT(1) NOT NULL,
  `PasswordHash` LONGTEXT NULL DEFAULT NULL,
  `SecurityStamp` LONGTEXT NULL DEFAULT NULL,
  `ConcurrencyStamp` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumberConfirmed` BIT(1) NOT NULL,
  `TwoFactorEnabled` BIT(1) NOT NULL,
  `LockoutEnd` CHAR(19) NULL DEFAULT NULL,
  `LockoutEnabled` BIT(1) NOT NULL,
  `AccessFailedCount` INT(11) NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Avatar` LONGTEXT NULL DEFAULT NULL,
  `Gender` INT(11) NOT NULL,
  `Address` LONGTEXT NULL DEFAULT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  PRIMARY KEY (`Id`(255)),
  UNIQUE INDEX `UserNameIndex` (`NormalizedUserName`(255) ASC),
  INDEX `EmailIndex` (`NormalizedEmail`(255) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.dbo.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`dbo.sysdiagrams` (
  `name` VARCHAR(128) NOT NULL,
  `principal_id` INT(11) NOT NULL,
  `diagram_id` INT(11) NOT NULL,
  `version` INT(11) NULL DEFAULT NULL,
  `definition` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.facilities
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`facilities` (
  `FacilityId` INT(11) NOT NULL,
  `FacilityName` VARCHAR(50) NOT NULL,
  `FacilityImage` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`FacilityId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.facilitiesapply
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`facilitiesapply` (
  `FacilitiesApplyId` INT(11) NOT NULL,
  `FacilityId` INT(11) NOT NULL,
  `RoomTypeId` INT(11) NOT NULL,
  PRIMARY KEY (`FacilitiesApplyId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.promotion
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`promotion` (
  `PromotionId` INT(11) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `DiscountRates` DOUBLE NOT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  `PromotionName` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`PromotionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.promotionapply
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`promotionapply` (
  `PromotionApplyId` INT(11) NOT NULL,
  `PromotionId` INT(11) NOT NULL,
  `RoomTypeId` INT(11) NOT NULL,
  PRIMARY KEY (`PromotionApplyId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.room
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`room` (
  `RoomNumber` INT(11) NOT NULL,
  `RoomTypeId` INT(11) NOT NULL,
  `IsOccupied` BIT(1) NOT NULL,
  PRIMARY KEY (`RoomNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.roomtype
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`roomtype` (
  `RoomTypeId` INT(11) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `DefaultPrice` INT(11) NOT NULL,
  `Quantity` INT(11) NOT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  `Description` LONGTEXT NULL DEFAULT NULL,
  `MaxAdult` INT(11) NOT NULL,
  `MaxChildren` INT(11) NOT NULL,
  `MaxPeople` INT(11) NOT NULL,
  PRIMARY KEY (`RoomTypeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.roomtypeimages
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`roomtypeimages` (
  `RoomTypeImageId` INT(11) NOT NULL,
  `ImageData` LONGTEXT NOT NULL,
  `RoomTypeId` INT(11) NOT NULL,
  PRIMARY KEY (`RoomTypeImageId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.service
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`service` (
  `ServiceId` INT(11) NOT NULL,
  `ServiceName` VARCHAR(50) NOT NULL,
  `Price` INT(11) NOT NULL,
  `IsDeleted` BIT(1) NOT NULL,
  `Description` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`ServiceId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table hotelbooking.serviceimages
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelbooking`.`serviceimages` (
  `ServiceImageId` INT(11) NOT NULL,
  `ImageData` LONGTEXT NOT NULL,
  `ServiceId` INT(11) NOT NULL,
  PRIMARY KEY (`ServiceImageId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_Delete`(
	-- Add the parameters for the stored procedure here
	IN p_BookingRoomDetailsId INT
)
BEGIN 
	DECLARE Message VARCHAR(200);
	SET Message = 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `BOOKINGROOMDETAILS`
		WHERE `BookingRoomDetailsId` = p_BookingRoomDetailsId;
		SET Message = 'Booking has been deleted successfully!';
		SELECT p_BookingRoomDetailsId AS Id, Message AS `Message`;
	END;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_DeletebyBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_DeletebyBookingId`(
	IN p_BookingId INT
)
BEGIN
	DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `BOOKINGROOMDETAILS`
		WHERE p_BookingId = BookingId;
		SET message = 'BookingRoomDetails has been deleted successfully!';
		SELECT p_BookingId AS Id, message AS `Message`;
	END;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_DisplayBookingRoomTypesByBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_DisplayBookingRoomTypesByBookingId`(
    -- Add the parameters for the stored procedure here
    IN BookingId INT
)
BEGIN
    SELECT RoomTypeId, RoomQuantity
    FROM BOOKINGROOMDETAILS
    WHERE BookingId = BookingId AND EXISTS(SELECT * FROM BOOKING WHERE BookingId = BookingId AND IsCanceled = 0)
    GROUP BY RoomTypeId, RoomQuantity;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_GetAll`()
BEGIN 
    SELECT *
    FROM BOOKINGROOMDETAILS;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_GetByBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_GetByBookingId`(
    IN BookingId INT
)
BEGIN
    SELECT *
    FROM BOOKINGROOMDETAILS
    WHERE BookingId = BookingId AND EXISTS(SELECT * FROM BOOKING WHERE BookingId = BookingId AND IsCanceled = 0);
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingRoomDetails_Save
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingRoomDetails_Save`(
	IN RoomTypeId INT,
	IN BookingId INT,
	IN RoomQuantity INT
)
BEGIN
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

	SET StartDate = (SELECT CheckinDate FROM BOOKING WHERE BookingId = BookingId);
	SET EndDate = (SELECT CheckoutDate FROM BOOKING WHERE BookingId = BookingId);
	SET Counter = 0;
	SET TotalCount = DATEDIFF(EndDate, StartDate) - 1;
	
	WHILE (Counter <= TotalCount) DO
		SET DateValue = DATE_ADD(StartDate, INTERVAL Counter DAY);

		SET DiscountRates = (
			SELECT MIN(DiscountRates) 
			FROM PROMOTION  
			INNER JOIN PROMOTIONAPPLY 
			ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
			WHERE PROMOTIONAPPLY.RoomTypeId = RoomTypeId 
			GROUP BY StartDate, EndDate
			HAVING DateValue >= StartDate AND DateValue <= EndDate
		);

		IF (DiscountRates <> 0) THEN
			SET RoomPrice = (
				SELECT DefaultPrice 
				FROM ROOMTYPE 
				WHERE ROOMTYPE.RoomTypeId = RoomTypeId
			) * (1 - DiscountRates) * RoomQuantity;
		ELSE
			SET RoomPrice = (
				SELECT DefaultPrice 
				FROM ROOMTYPE 
				WHERE ROOMTYPE.RoomTypeId = RoomTypeId
			) * RoomQuantity;
		END IF;

		INSERT INTO BOOKINGROOMDETAILS (
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingServiceDetails_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingServiceDetails_Delete`(
	IN `in_BookingServiceDetailsId` INT,
	OUT `out_Id` INT,
	OUT `out_Message` VARCHAR(200)
)
BEGIN
	DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
	BEGIN
		DELETE FROM `BOOKINGSERVICEDETAILS`
		WHERE `BookingServiceDetailsId` = in_BookingServiceDetailsId;
		SET out_Id = in_BookingServiceDetailsId;
		SET out_Message = 'BookingServiceDetails has been deleted successfully!';
	END;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingServiceDetails_DeletebyBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingServiceDetails_DeletebyBookingId`(
    -- Add the parameters for the stored procedure here
    IN BookingId INT
)
BEGIN 
    DECLARE Message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT BookingId AS Id, Message AS `Message`;
    END;

    BEGIN
        DELETE FROM `BOOKINGSERVICEDETAILS`
        WHERE BookingId = BookingId;
        SET Message = 'BookingServiceDetails has been deleted successfully!';
        SELECT BookingId AS Id, Message AS `Message`;
    END;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingServiceDetails_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingServiceDetails_GetAll`()
BEGIN
SELECT *
FROM `BOOKINGSERVICEDETAILS`;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingServiceDetails_GetByBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingServiceDetails_GetByBookingId`(
	IN `BookingId` INT
)
BEGIN 
	SELECT *
	FROM `BOOKINGSERVICEDETAILS`
	WHERE `BookingId` = `BOOKINGSERVICEDETAILS`.`BookingId` 
	AND EXISTS(SELECT * FROM `BOOKING` WHERE `BookingId` = `BOOKING`.`BookingId` AND `BOOKING`.`IsCanceled` = 0);
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.BookingServiceDetails_Save
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingServiceDetails_Save`(
    -- Add the parameters for the stored procedure here
    IN p_BookingId INT,
    IN p_ServiceId INT,
    IN p_ServiceQuantity INT
)
BEGIN
    DECLARE v_ServicePrice FLOAT;

    DECLARE v_Message VARCHAR(200) DEFAULT 'Something went wrong, please try again!';

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 0 AS Id, v_Message AS `Message`;
    END;

    -- Get the service price
    SET v_ServicePrice = (SELECT Price FROM `SERVICE` WHERE ServiceId = p_ServiceId) * p_ServiceQuantity;

    -- Insert the new record
    INSERT INTO `BOOKINGSERVICEDETAILS`
    (BookingId, ServiceId, ServiceQuantity, ServicePrice)
    VALUES
    (p_BookingId, p_ServiceId, p_ServiceQuantity, v_ServicePrice);

    -- Set success message and return the new ID
    SET v_Message = 'BookingServiceDetails has been created successfully!';
    SELECT p_ServiceId AS Id, v_Message AS `Message`;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Booking_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Booking_Delete`(
    -- Add the parameters for the stored procedure here
    IN BookingId INT
)
BEGIN
    DECLARE Message NVARCHAR(200);
    SET Message = 'Something went wrong, please try again';
    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            SELECT BookingId AS Id, Message AS `Message`;
        END;
        
        UPDATE BOOKING
        SET IsCanceled = 1
        WHERE BookingId = BookingId;
        
        SET Message = 'Service has been deleted successfully!';
        SELECT BookingId AS Id, Message AS `Message`;
    END;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Booking_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Booking_GetAll`()
BEGIN 
    SELECT *
    FROM BOOKING
    WHERE IsCanceled = 0;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Booking_GetByBookingId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Booking_GetByBookingId`(
	IN p_BookingId INT
)
BEGIN
	SELECT *
	FROM BOOKING
	WHERE IsCanceled = 0 AND p_BookingId = BookingId;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Booking_GetListDate
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Booking_GetListDate`(
    IN `p_BookingId` INT
)
BEGIN
    DECLARE startDate DATE;
    DECLARE endDate DATE;
    DECLARE currentDate DATE;
    DECLARE counter INT DEFAULT 0;
    DECLARE totalCount INT;
    
    SELECT CheckinDate INTO startDate FROM BOOKING WHERE BookingId = p_BookingId;
    SELECT CheckoutDate INTO endDate FROM BOOKING WHERE BookingId = p_BookingId;
    
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Booking_Save
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Booking_Save`(
	IN `BookingId` INT,
	IN `CustomerId` INT,
	IN `CouponId` INT,
	IN `CheckinDate` DATETIME,
	IN `CheckoutDate` DATETIME,
	IN `NumberofAdults` INT,
	IN `NumberofChildren` INT
)
BEGIN 
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
		IF(EXISTS(SELECT Reduction FROM COUPON WHERE (CouponId = CouponId) AND (Remain > 0) AND (CreateDate < EndDate) AND (IsDeleted = 0))) THEN
			BEGIN
				SET Reduction = (SELECT Reduction FROM COUPON WHERE (CouponId = CouponId) AND (Remain > 0) AND (CreateDate < EndDate) AND (IsDeleted = 0));
				SET RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = BookingId)*(1-Reduction);
				SET UpdateCouponId = CouponId;
			END;
		ELSE 
			BEGIN
				SET RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = BookingId);
			END;
		END IF;
		SET ServiceAmount = (SELECT SUM(ServicePrice) FROM BOOKINGSERVICEDETAILS WHERE BookingId = BookingId);
		IF (BookingId = 0 OR BookingId IS NULL) THEN
			BEGIN
			INSERT INTO `BOOKING`(
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
			UPDATE `BOOKING`
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Coupon_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Coupon_Delete`(
	IN CouponId INT
)
BEGIN
	DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';

	BEGIN
		UPDATE COUPON
		SET IsDeleted = 1
		WHERE CouponId = CouponId;

		IF ROW_COUNT() > 0 THEN
			SET Message = 'Coupon has been deleted successfully!';
		END IF;

		SELECT CouponId AS Id, Message AS Message;
	END;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Coupon_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Coupon_GetAll`()
BEGIN
  SELECT *
  FROM COUPON
  WHERE (IsDeleted = 0);
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Coupon_GetbyId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Coupon_GetbyId`(
  IN CouponId INT
)
BEGIN
  SELECT *
  FROM COUPON
  WHERE CouponId = CouponId AND IsDeleted = 0;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Coupon_Save
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Coupon_Save`(
	-- Add the parameters for the stored procedure here
	IN CouponId INT,
	IN CouponCode NVARCHAR(50),
	IN Remain INT,
	IN Reduction FLOAT,
	IN EndDate DATE
)
BEGIN
	DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again!';
	
	BEGIN
		IF (CouponId = 0 OR CouponId IS NULL) THEN -- Create new RoomType
			INSERT INTO COUPON
			(CouponCode, Remain, Reduction, EndDate, IsDeleted)
			VALUES
			(CouponCode, Remain, Reduction, EndDate, 0);
			
			SET CouponId = LAST_INSERT_ID();
			SET Message = 'Coupon has been created successfully!';
		ELSE
			UPDATE COUPON
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Coupon_Search
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Coupon_Search`(
    -- Add the parameters for the stored procedure here
    IN CouponCode NVARCHAR(50)
)
BEGIN
    DECLARE message NVARCHAR(100);
    SET message = 'Code does not exist or has expired please try again!';
    
    IF (EXISTS(SELECT CouponId FROM COUPON WHERE CouponCode = CouponCode AND (IsDeleted = 0) AND (NOW() < EndDate) AND (Remain <> 0)))
    THEN
        SELECT CouponId, Reduction, CONCAT('Valid coupon code, you get discount ', Reduction * 100, '%') AS `Message` FROM COUPON WHERE CouponCode = CouponCode AND (IsDeleted = 0) AND (NOW() < EndDate) AND (Remain <> 0);
    ELSE
        SELECT 0 AS CouponId, 0 AS Reduction, message AS `Message`;
    END IF;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Customer_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_Delete`(
    -- Add the parameters for the stored procedure here
    IN CustomerId INT
)
BEGIN 
    DECLARE Message NVARCHAR(200) DEFAULT 'Something went wrong, please try again';
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        UPDATE CUSTOMER
        SET IsDeleted = 1
        WHERE CustomerId = CustomerId;

        SET Message = 'Customer has been deleted successfully!';

        SELECT CustomerId AS Id, Message AS Message;
    END;
    
    
    BEGIN
        SELECT CustomerId AS Id, Message AS Message;
    END;
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Customer_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_GetAll`()
BEGIN
  SELECT *
  FROM CUSTOMER
  WHERE IsDeleted = 0;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Customer_GetByCustomerId
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_GetByCustomerId`(
	IN `CustomerId` INT
)
BEGIN
	SELECT *
	FROM `CUSTOMER`
	WHERE `IsDeleted` = 0 AND `CustomerId` = `CustomerId`;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Customer_GetByNameOrEmailOrPhone
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_GetByNameOrEmailOrPhone`(IN search VARCHAR(255))
BEGIN
    SELECT *
    FROM CUSTOMER
    WHERE IsDeleted = 0 AND (Name LIKE CONCAT('%', search, '%') OR Email LIKE CONCAT('%', search, '%') OR Phone LIKE CONCAT('%', search, '%'));
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Customer_Save
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_Save`(
    -- Add the parameters for the stored procedure here
    INOUT pCustomerId INT,
    IN pName NVARCHAR(50),
    IN pPhoneNumber NVARCHAR(50),
    IN pEmail NVARCHAR(50)
)
BEGIN 
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
            INSERT INTO `CUSTOMER`
            (`Name`, `PhoneNumber`, `Email`)
            VALUES
            (pName, pPhoneNumber, pEmail);
            
            SET pCustomerId = LAST_INSERT_ID();
            SET message = 'Customer has been created successfully!';
        ELSE
            UPDATE `CUSTOMER`
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.DateTable_Create
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DateTable_Create`(
    IN pStartDate DATETIME,
    IN pEndDate DATETIME
)
BEGIN 
    
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Facility_Delete
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Facility_Delete`(
    -- Add the parameters for the stored procedure here
    IN pFacilityId INT
)
BEGIN 
    DECLARE message VARCHAR(200) DEFAULT 'Something went wrong, please try again';
    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            SELECT pFacilityId AS Id, message AS `Message`;
        END;
        
        DELETE FROM FACILITIES
        WHERE FacilityId = pFacilityId;
        SET message = 'RoomType has been deleted successfully!';
        SELECT pFacilityId AS Id, message AS `Message`;
    END;
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Facility_GetAll
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Facility_GetAll`()
BEGIN
SELECT *
FROM FACILITIES;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.RoomCancellation
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RoomCancellation`(
	IN booking_id INT,
    IN room_id INT,
    OUT success BIT,
    OUT message VARCHAR(255)
)
BEGIN
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
			SELECT RoomPrice INTO room_price FROM BOOKINGROOMDETAILS WHERE BookingId = booking_id AND RoomId = room_id;
			
			IF room_price IS NULL THEN
				SET success = 0;
				SET message = 'Invalid room ID.';
			ELSE
				SELECT COUPON.CouponId, COUPON.Reduction INTO coupon_id, coupon_reduction FROM COUPON WHERE COUPON.Remain > 0 AND CURDATE() <= COUPON.EndDate AND COUPON.IsDeleted = 0 AND coupon_id = BOOKING.CouponId;
				
				IF coupon_id IS NOT NULL THEN
					SET total_price = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = booking_id) * (1-coupon_reduction);
					SET coupon_reduction = NULL;
				ELSE
					SET total_price = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = booking_id);
				END IF;
				
				SET service_total = (SELECT SUM(ServicePrice) FROM BOOKINGSERVICEDETAILS WHERE BookingId = booking_id);
				
				UPDATE BOOKING SET
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

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine hotelbooking.Fn_MinRemain
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `hotelbooking`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Fn_MinRemain`(`RoomTypeId` INT,
  `CheckInDate` DATE,
  `CheckOutDate` DATE
) RETURNS int(11)
BEGIN
  DECLARE Counter INT;
  DECLARE TotalCount INT;
  DECLARE DateValue DATETIME;
  DECLARE Result INT;
  DECLARE CurrentRemain INT;

  SET Counter = 0;
  SET TotalCount = DATEDIFF(CURDATE(), CheckInDate);
  SET Result = (SELECT Quantity FROM ROOMTYPE WHERE RoomTypeId = RoomTypeId);

  WHILE (Counter < TotalCount) DO
    SET DateValue = DATE_ADD(CheckInDate, INTERVAL Counter DAY);
    SET CurrentRemain = (SELECT Quantity FROM ROOMTYPE WHERE RoomTypeId = RoomTypeId) - (SELECT SUM(RoomQuantity) FROM BOOKINGROOMDETAILS WHERE Date = DateValue AND RoomTypeId = RoomTypeId);
    IF (CurrentRemain < Result) THEN
      SET Result = CurrentRemain;
    END IF;
    SET Counter = Counter + 1;
  END WHILE;

  RETURN Result;
END$$

DELIMITER ;
SET FOREIGN_KEY_CHECKS = 1;
