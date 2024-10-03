/*
================================================================================
  File name          : Select_ProfileList.sql
  Description        : get profile list store procedure
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [dbo].[Select_ProfileList]
  @Page INT = 1,
  @RowsPerPage INT = 15,
  @Rows INT OUT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @Offset INT = (@Page - 1) * @RowsPerPage;
  SELECT @Rows = COUNT(*) FROM [Profile];

  SELECT
    [ProfileId],
    [ProfileName],
    [Created],
    [Updated],
    [UserCreated],
    [UserUpdated],
    [IsActive]
  FROM [Profile]
  ORDER BY [ProfileId]
  OFFSET @Offset ROWS
  FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO
