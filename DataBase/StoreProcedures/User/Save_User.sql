/*
================================================================================
File name          : SaveUser.sql
Description        : Save use store procedure
Autor              : Samir Diaz
Created date       : 2-10-2024
Last update        : 2-10-2024 by Samir Diaz
Vertion            : 1.0
Notes              : notes
================================================================================
*/
CREATE PROCEDURE [dbo].[Save_User]
  @Email VARCHAR(200) = NULL,
  @UserName VARCHAR(150) = NULL,
  @Password VARCHAR(200) = NULL,
  @ProfileId UNIQUEIDENTIFIER = NULL,
  @UserCreated UNIQUEIDENTIFIER = NULL,
  @ErrorCode INT OUT,
  @ErrorMessage VARCHAR(MAX) OUT,
  @UserId UNIQUEIDENTIFIER OUT
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @CurrentDate DATETIME = GETUTCDATE();

  IF @UserCreated IS NULL
  BEGIN
    SET @ErrorCode = 1;
    SET @ErrorMessage = 'Invalid parameter';
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

  IF EXISTS (SELECT [UserId] FROM [User] WHERE [Email] = @Email)
  BEGIN
    SET @ErrorCode = 5;
    SET @ErrorMessage = 'Invalid parameter';
    RETURN;
  END

  IF @ProfileId IS NOT NULL AND NOT EXISTS (SELECT [ProfileId] FROM [Profile] WHERE [ProfileId] = @ProfileId)
  BEGIN
    SET @ErrorCode = 6;
    SET @ErrorMessage = 'Invalid parameter';
    RETURN;
  END

  BEGIN TRANSACTION;
  BEGIN TRY
    SET @UserId = NEWID();

    INSERT INTO [User]
    (
      [UserId],
      [Email],
      [UserName],
      [Password],
      [ProfileId],
      [Created],
      [Updated],
      [UserCreated],
      [UserUpdated]
    )
    VALUES
   (
     @UserId,
     @Email,
     @UserName,
     @Password,
     @ProfileId,
     @CurrentDate,
     @CurrentDate,
     @UserCreated,
     @UserCreated
   );

   COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    SET @ErrorCode = ERROR_NUMBER();
    SET @ErrorMessage = ERROR_MESSAGE();

    ROLLBACK TRANSACTION;
  END CATCH
END