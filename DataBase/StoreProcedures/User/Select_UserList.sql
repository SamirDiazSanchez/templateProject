CREATE PROCEDURE [dbo].[Select_UserList]
  @Page INT = 1,
  @RowsPerPage INT = 15,
  @Rows INT OUT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @Offset INT = (@Page - 1) * @RowsPerPage;
  SELECT @Rows = COUNT(*) FROM [User];
  
  SELECT
    [UserId],
    [Email],
    [UserName],
    [Created],
    [Updated],
    [UserCreated],
    [UserUpdated],
    [IsActive]
  FROM [User]
  ORDER BY [UserId]
  OFFSET @Offset ROWS
  FETCH NEXT @RowsPerPage ROWS ONLY
END
