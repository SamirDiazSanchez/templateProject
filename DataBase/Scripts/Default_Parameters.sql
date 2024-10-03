DECLARE @SysEmail VARCHAR(200) = 'sysadmin@admin.com';
DECLARE @SysUserName VARCHAR(150) = 'sysadmin';
DECLARE @Password VARCHAR(200) = 'Y2NkYjRlOGQ5NmU4NDY4YTU0NGFlMDhiNWZiMWE4YTc';
DECLARE @CurrentData DATETIME = GETUTCDATE();

IF NOT EXISTS (SELECT [UserId] FROM [User] WHERE [Email] = @SysEmail)
BEGIN
	DECLARE @UserId UNIQUEIDENTIFIER = NEWID();

	INSERT INTO [User] (
		[UserId],
		[Email],
		[UserName],
		[Password],
		[Created],
		[Updated],
		[UserCreated],
		[UserUpdated]
	)
	VALUES (
		@UserId,
		@SysEmail,
		@SysUserName,
		@Password,
		@CurrentData,
		@CurrentData,
		@UserId,
		@UserId
	);
END