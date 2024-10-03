/*
================================================================================
  File name          : Update_Profile.sql
  Description        : update profile store procedure
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [Update_Profile]
  @ProfileId UNIQUEIDENTIFIER = NULL,
  @ProfileName VARCHAR(150) = NULL,
  @ModuleList Type_ModuleList READONLY,
  @IsActive BIT = 1,
  @UserUpdated UNIQUEIDENTIFIER = NULL,
  @ErrorCode INT OUT,
  @ErrorMessage VARCHAR(MAX) OUT
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @CurrentDate DATETIME = GETUTCDATE();

  IF @ProfileId IS NULL
  BEGIN
    SET @ErrorCode = 1;
    SET @ErrorMessage = 'Ivalid parameter';
    RETURN;
  END

  IF @UserUpdated IS NULL
  BEGIN
    SET @ErrorCode = 2;
    SET @ErrorMessage = 'Ivalid parameter';
    RETURN;
  END

  IF EXISTS (SELECT [ProfileId] FROM [Profile] WHERE [ProfileName] = @ProfileName AND [ProfileId] != @ProfileId)
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
		UPDATE [Profile_Module]
		SET [IsActive] = 0
		WHERE [ProfileId] = @ProfileId
		AND [ModuleId] NOT IN (SELECT A.[ModuleId] FROM @ModuleList A)
 
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
      A.[ModuleId],
      @CurrentDate,
      @CurrentDate,
      @UserUpdated,
      @UserUpdated
		FROM @ModuleList A
		LEFT JOIN [Profile_Module] B ON A.[ModuleId] = B.[ModuleId] AND B.[ProfileId] = @ProfileId
		WHERE B.[ModuleId] IS NULL;

    UPDATE [Profile]
    SET [ProfileName] = @ProfileName,
				[IsActive] = @IsActive,
        [Updated] = @CurrentDate,
        [UserUpdated] = @UserUpdated
    WHERE [ProfileId] = @ProfileId

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    SET @ErrorCode = ERROR_NUMBER();
    SET @ErrorMessage = ERROR_MESSAGE();

    ROLLBACK TRANSACTION;
  END CATCH
END
GO