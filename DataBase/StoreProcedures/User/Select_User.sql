CREATE PROCEDURE [dbo].[Select_User]
  @Email VARCHAR(200) = NULL,
  @UserId UNIQUEIDENTIFIER = NULL
AS
BEGIN
  SET NOCOUNT ON;

  SELECT
    [UserId],
    [Email],
    [UserName],
    [Password],
    [Created],
    [Updated],
    [UserCreated],
    [UserUpdated],
    [IsActive]
  FROM [User]
  WHERE (@Email IS NOT NULL AND [Email] = @Email)
  OR (@UserId IS NOT NULL AND [UserId] = @UserId)
END
