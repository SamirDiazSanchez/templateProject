/*
================================================================================
  File name          : Update_User.sql
  Description        : update user store procedure
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [Update_User]
  @UserId UNIQUEIDENTIFIER = NULL,
  @Email VARCHAR(200) = NULL,
  @UserName VARCHAR(150) = NULL,
  @Password VARCHAR(200) = NULL,
	@ProfileId UNIQUEIDENTIFIER = NULL,
	@IsActive BIT = 1,
  @UserUpdated UNIQUEIDENTIFIER = NULL,
  @ErrorCode INT OUT,
  @ErrorMessage VARCHAR(MAX) OUT
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @CurrentDate DATETIME = GETUTCDATE();

	IF @UserId IS NULL
	BEGIN
		SET @ErrorCode = 1;
		SET @ErrorMessage = 'Invalid parameter';
		RETURN;
	END

  IF @UserUpdated IS NULL
  BEGIN
    SET @ErrorCode = 1;
    SET @ErrorMessage = 'Ivalid parameter';
    RETURN;
  END

  IF @Email IS NULL
	BEGIN
		SET @ErrorCode = 2;
		SET @ErrorMessage = 'Invalid parameter';
		RETURN;
	END

	IF @UserName IS NULL
	BEGIN
		SET @ErrorCode = 3;
		SET @ErrorMessage = 'Invalid parameter';
		RETURN;
	END

	IF @Password IS NULL
	BEGIN
		SET @ErrorCode = 4;
		SET @ErrorMessage = 'Invalid parameter';
		RETURN;
	END

	IF EXISTS (SELECT [UserId] FROM [User] WHERE [Email] = @Email AND [UserId] != @UserId)
	BEGIN
		SET @ErrorCode = 5;
		SET @ErrorMessage = 'Invalid parameter';
		RETURN;
	END

  BEGIN TRANSACTION;
  BEGIN TRY
    UPDATE [User]
    SET [Email] = @Email,
        [UserName] = @UserName,
				[Password] = @Password,
				[ProfileId] = @ProfileId,
				[IsActive] = @IsActive,
        [Updated] = @CurrentDate,
        [UserUpdated] = @UserUpdated
    WHERE [UserId] = @UserId

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    SET @ErrorCode = ERROR_NUMBER();
    SET @ErrorMessage = ERROR_MESSAGE();

    ROLLBACK TRANSACTION;
  END CATCH
END