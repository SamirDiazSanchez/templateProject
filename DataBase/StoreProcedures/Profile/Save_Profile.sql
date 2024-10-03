/*
================================================================================
  File name          : Save_Profile.sql
  Description        : save profile store procedure
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [dbo].[Save_Profile]
  @ProfileName VARCHAR(50) = NULL,
  @ModuleList Type_ModuleList READONLY,
  @UserCreated UNIQUEIDENTIFIER = NULL,
  @ErrorCode INT OUT,
  @ErrorMessage VARCHAR(MAX) OUT,
  @ProfileId UNIQUEIDENTIFIER OUT
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

  IF @ProfileName IS NULL
  BEGIN
    SET @ErrorCode = 2;
    SET @ErrorMessage = 'Invalid parameter';
    RETURN;
  END

  IF EXISTS (SELECT [ProfileId] FROM [Profile] WHERE [ProfileName] = @ProfileName)
  BEGIN
    SET @ErrorCode = 3;
    SET @ErrorMessage = 'Invalid parameter';
    RETURN;
  END

  IF EXISTS (SELECT [ModuleId] FROM @ModuleList WHERE [ModuleId] NOT IN (SELECT [ModuleId] FROM [Module]))
  BEGIN
    SET @ErrorCode = 4;
    SET @ErrorMessage = 'Invalid parameter';
    RETURN;
  END

  BEGIN TRANSACTION;
  BEGIN TRY
    SET @ProfileId = NEWID();

    INSERT INTO [Profile_Module] (
      [ProfileId],
      [ModuleId],
      [Created],
      [Updated],
      [UserCreated],
      [UserUpdated]
    )
    SELECT
      @ProfileId,
      [ModuleId],
      @CurrentDate,
      @CurrentDate,
      @UserCreated,
      @UserCreated
    FROM @ModuleList;

    INSERT INTO [Profile]
    (
      [ProfileId],
      [ProfileName],
      [Created],
      [Updated],
      [UserCreated],
      [UserUpdated]
    )
    VALUES
   (
     @ProfileId,
     @ProfileName,
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
GO