USE [master]
GO
/****** Object:  Database [App1]    Script Date: 25/08/2020 12:00:58 ******/
CREATE DATABASE [App1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'App1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\App1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'App1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\App1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [App1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [App1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [App1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [App1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [App1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [App1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [App1] SET ARITHABORT OFF 
GO
ALTER DATABASE [App1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [App1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [App1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [App1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [App1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [App1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [App1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [App1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [App1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [App1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [App1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [App1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [App1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [App1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [App1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [App1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [App1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [App1] SET RECOVERY FULL 
GO
ALTER DATABASE [App1] SET  MULTI_USER 
GO
ALTER DATABASE [App1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [App1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [App1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [App1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [App1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'App1', N'ON'
GO
ALTER DATABASE [App1] SET QUERY_STORE = OFF
GO
USE [App1]
GO
/****** Object:  Table [dbo].[users]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NULL,
	[user] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[rol] [int] NULL,
	[connected] [int] NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[user_connected]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[user_connected]
AS
SELECT        id, name, [user], start_time
FROM            dbo.users
WHERE        (connected = 1)
GO
/****** Object:  Table [dbo].[users_rol]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_rol](
	[id] [int] NOT NULL,
	[rol] [varchar](50) NOT NULL,
	[description] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[users_view]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[users_view]
AS
SELECT        a.id, a.name, a.last_name, B.rol, a.connected, a.start_time, a.end_time
FROM            dbo.users AS a LEFT OUTER JOIN
                         dbo.users_rol AS B ON a.rol = B.id
GO
/****** Object:  Table [dbo].[users_connections]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_connections](
	[id] [numeric](18, 0) NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[users] ON 
GO
INSERT [dbo].[users] ([id], [name], [last_name], [user], [password], [rol], [connected], [start_time], [end_time]) VALUES (100, N'admin', N'admin', N'admin', N'Admin_123', 1, 0, CAST(N'2020-08-25T11:48:16.840' AS DateTime), CAST(N'2020-08-25T12:00:09.550' AS DateTime))
GO
INSERT [dbo].[users] ([id], [name], [last_name], [user], [password], [rol], [connected], [start_time], [end_time]) VALUES (109, N'johanna', N'correa', N'jcorrea', N'jc123', 2, 0, CAST(N'2020-08-25T11:37:08.880' AS DateTime), CAST(N'2020-08-25T11:37:12.257' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:08:27.603' AS DateTime), CAST(N'2020-08-25T11:09:20.487' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:19:58.720' AS DateTime), CAST(N'2020-08-25T11:20:05.330' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(109 AS Numeric(18, 0)), CAST(N'2020-08-25T11:26:31.260' AS DateTime), CAST(N'2020-08-25T11:26:52.153' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:27:07.163' AS DateTime), CAST(N'2020-08-25T11:27:17.160' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:28:47.767' AS DateTime), CAST(N'2020-08-25T11:28:52.573' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:31:39.680' AS DateTime), CAST(N'2020-08-25T11:31:42.933' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:36:48.490' AS DateTime), CAST(N'2020-08-25T11:36:52.680' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(109 AS Numeric(18, 0)), CAST(N'2020-08-25T11:37:08.880' AS DateTime), CAST(N'2020-08-25T11:37:12.257' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T11:48:16.840' AS DateTime), CAST(N'2020-08-25T12:00:09.550' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-24T22:33:22.303' AS DateTime), CAST(N'2020-08-24T22:35:13.090' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T09:43:28.583' AS DateTime), CAST(N'2020-08-25T09:43:42.940' AS DateTime))
GO
INSERT [dbo].[users_connections] ([id], [start_time], [end_time]) VALUES (CAST(100 AS Numeric(18, 0)), CAST(N'2020-08-25T10:22:33.053' AS DateTime), CAST(N'2020-08-25T10:24:29.673' AS DateTime))
GO
INSERT [dbo].[users_rol] ([id], [rol], [description]) VALUES (1, N'administrator', N'full control over all the app')
GO
INSERT [dbo].[users_rol] ([id], [rol], [description]) VALUES (2, N'managment', N'create and modify')
GO
INSERT [dbo].[users_rol] ([id], [rol], [description]) VALUES (3, N'client', N'generl view')
GO
/****** Object:  StoredProcedure [dbo].[SP_login_logout]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_login_logout]
	-- Add the parameters for the stored procedure here 
	@opt as varchar(250),
	@user as varchar(50),
	@pass as varchar(50),
	@rol as nvarchar(400) output,
	@mess as nvarchar(400) output
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @opt = 1  
		begin	
			select [user] 
			from [App1].dbo.[users] 
			where [user] = @user; 
		
			if @@rowcount > 0  
				begin
				-- actualiza el estado como conectado y la hora de conexion
					select [user] 
					from [App1].dbo.[users] 
					where [user] = @user 
					and [password] = @pass;
			
					if @@rowcount > 0  
						begin
							update [App1].dbo.[users]
							set connected = 1, start_time = current_timestamp, end_time = null
							where [user] = @user and [password] = @pass;
							set @mess = 'Connected';
							set @rol = (select [rol] from [App1].dbo.[users] where [user] = @user and [password] = @pass); 
						end
					else 
						begin
							set @mess = 'Wrong password';
						end
				end
			else 
					begin
						set @mess = 'Wrong user';
					end
		end
	if @opt = 0
		begin
			--actualiza el estado como desconectado y la hora de desconexion
			update [App1].dbo.[users]
			set connected= 0, end_time= current_timestamp
			where [user] = @user;

			--crea el registro de las conexiones
			insert into [App1].dbo.[users_connections]
			select id,start_time,end_time
			from [App1].dbo.[users]
			where [user] = @user;

			set @mess = 'User disconected';
		end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_User_administration]    Script Date: 25/08/2020 12:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_User_administration]
	-- Add the parameters for the stored procedure here 
	@opt as varchar(50),
	@name as varchar(250),
	@l_name as varchar(250),
	@user as varchar(250),
	@pass as varchar(250),
	@rol as varchar(250),
	@mess as nvarchar(400) output
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @opt = 1  --create user
		begin
			insert into App1.dbo.users ([name],[last_name],[user],[password],[rol]) values (@name,@l_name,@user,@pass,@rol);
			set @mess = 'User ' + @user + ' has benn saved';
		end
	--if @opt = 2 --alter user
		
	--if @opt = 3 -- delete user
		
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'user_connected'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'user_connected'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'users_view'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'users_view'
GO
USE [master]
GO
ALTER DATABASE [App1] SET  READ_WRITE 
GO
