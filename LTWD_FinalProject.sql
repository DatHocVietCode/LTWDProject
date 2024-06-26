USE [master]
GO
/****** Object:  Database [LTWD_Final_Project]    Script Date: 5/11/2024 10:28:12 PM ******/
CREATE DATABASE [LTWD_Final_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LTWD_Final_Project', FILENAME = N'C:\Users\LAPTOP\LTWD_Final_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LTWD_Final_Project_log', FILENAME = N'C:\Users\LAPTOP\LTWD_Final_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LTWD_Final_Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LTWD_Final_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LTWD_Final_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LTWD_Final_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LTWD_Final_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LTWD_Final_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LTWD_Final_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LTWD_Final_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LTWD_Final_Project] SET  MULTI_USER 
GO
ALTER DATABASE [LTWD_Final_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LTWD_Final_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LTWD_Final_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LTWD_Final_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LTWD_Final_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LTWD_Final_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LTWD_Final_Project] SET QUERY_STORE = OFF
GO
USE [LTWD_Final_Project]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Account_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bought]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bought](
	[IDInvoice] [int] IDENTITY(1,1) NOT NULL,
	[IDUser] [int] NOT NULL,
	[DateBought] [datetime] NOT NULL,
	[TotalPrice] [real] NOT NULL,
 CONSTRAINT [PK_Bought] PRIMARY KEY CLUSTERED 
(
	[IDInvoice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[IDUser] [int] NOT NULL,
	[IDProduct] [int] NOT NULL,
	[NumberOfProduct] [int] NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC,
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[IDShop] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[DataTimeCreate] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[Rate] [real] NULL,
	[IDCmt] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[IDCmt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FaVProduct]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaVProduct](
	[IDProduct] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC,
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImageLink]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageLink](
	[IDProduct] [int] NOT NULL,
	[ImageLink] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_ImageLink] PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC,
	[ImageLink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[IDProduct] [int] IDENTITY(1,1) NOT NULL,
	[IDShop] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[OriginalPrice] [real] NULL,
	[CurrentPrice] [real] NULL,
	[Save] [real] NULL,
	[Newness] [real] NULL,
	[Type] [nvarchar](50) NULL,
	[NumberInput] [int] NULL,
	[NumberLeft] [int] NULL,
	[BoughtTime] [datetime] NULL,
	[Priority] [int] NOT NULL,
	[Revenue] [real] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LstImagesCMT]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LstImagesCMT](
	[IDComment] [int] NOT NULL,
	[ImageLink] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_LstImagesCMT] PRIMARY KEY CLUSTERED 
(
	[IDComment] ASC,
	[ImageLink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LstProduct]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LstProduct](
	[IDInvoice] [int] NOT NULL,
	[IDProduct] [int] NOT NULL,
	[Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDInvoice] ASC,
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Priority]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Priority](
	[IDuser] [int] NOT NULL,
	[IDproduct] [int] NOT NULL,
	[NumPriority] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDuser] ASC,
	[IDproduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shop]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shop](
	[IDShop] [int] NOT NULL,
	[NameShop] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[ShopAvatar] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Rating] [real] NULL,
	[Slogan] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[Visits] [int] NOT NULL,
	[Purchases] [int] NOT NULL,
	[NumOfCusRate] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDShop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/11/2024 10:28:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] NOT NULL,
	[IdentityNum] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Sex] [nvarchar](50) NULL,
	[DoB] [datetime] NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[IDFavProduct] [nchar](10) NULL,
	[IDFavShop] [nchar](10) NULL,
	[Avatar] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [Email], [UserName], [Password]) VALUES (1, N'1@gmail.com', N'1', N'1')
INSERT [dbo].[Account] ([ID], [Email], [UserName], [Password]) VALUES (9, N'2@gmail.com', N'2', N'2')
INSERT [dbo].[Account] ([ID], [Email], [UserName], [Password]) VALUES (10, N'3@gmail.com', N'3', N'3')
INSERT [dbo].[Account] ([ID], [Email], [UserName], [Password]) VALUES (11, N'4@gmail.com', N'4', N'4')
INSERT [dbo].[Account] ([ID], [Email], [UserName], [Password]) VALUES (12, N'td13052004@gmail.com', N'dat', N'dat')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Bought] ON 

INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (6, 1, CAST(N'2024-04-16T14:12:27.877' AS DateTime), 150)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (7, 1, CAST(N'2024-04-16T14:19:40.087' AS DateTime), 190)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (8, 1, CAST(N'2024-04-16T14:30:36.190' AS DateTime), 100)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (11, 1, CAST(N'2024-05-03T21:11:10.427' AS DateTime), 615)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (20, 9, CAST(N'2024-05-03T22:51:30.327' AS DateTime), 250)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (25, 9, CAST(N'2024-05-03T23:00:15.780' AS DateTime), 250)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (27, 9, CAST(N'2024-05-03T23:02:46.097' AS DateTime), 350)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (28, 1, CAST(N'2024-05-05T16:15:08.977' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (29, 1, CAST(N'2024-05-05T16:29:01.867' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (30, 1, CAST(N'2024-05-05T16:29:10.310' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (31, 9, CAST(N'2024-05-09T13:55:25.203' AS DateTime), 450)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (32, 9, CAST(N'2024-05-09T13:58:28.093' AS DateTime), 90)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (33, 9, CAST(N'2024-05-09T14:11:28.950' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (34, 9, CAST(N'2024-05-09T14:20:38.523' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (35, 1, CAST(N'2024-05-09T14:47:02.713' AS DateTime), 66)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (36, 1, CAST(N'2024-05-09T14:52:49.520' AS DateTime), 132)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (37, 9, CAST(N'2024-05-09T16:46:56.953' AS DateTime), 250)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (38, 12, CAST(N'2024-05-10T10:57:12.483' AS DateTime), 483)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (39, 11, CAST(N'2024-05-10T11:00:01.870' AS DateTime), 8.88)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (40, 10, CAST(N'2024-05-10T11:27:05.387' AS DateTime), 400)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (41, 1, CAST(N'2024-05-10T13:23:33.730' AS DateTime), 400)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (42, 9, CAST(N'2024-05-10T13:35:57.707' AS DateTime), 1900)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (43, 1, CAST(N'2024-05-10T13:48:58.197' AS DateTime), 74.88)
SET IDENTITY_INSERT [dbo].[Bought] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (1, 9, CAST(N'2024-05-09T14:20:41.600' AS DateTime), N'dasdasd', 5, 9)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (1, 9, CAST(N'2024-05-09T16:47:01.853' AS DateTime), N'Trang sức rất đẹp', 5, 10)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (10, 11, CAST(N'2024-05-10T11:00:05.787' AS DateTime), N'Sách cực hay, xịn', 4, 15)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (9, 1, CAST(N'2024-05-10T11:10:33.797' AS DateTime), N'Tai nghe sử dụng dc', 5, 17)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (11, 10, CAST(N'2024-05-10T11:27:08.543' AS DateTime), N'lkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkadlkdhslkahdhajdajdhkjdhakjhdkjahkjhkjhdkjahdjkhdjkahdkjsahjkahdjkshdjkahdakjhdjkad', 5, 18)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (9, 1, CAST(N'2024-05-10T13:18:01.237' AS DateTime), N'kha khen', 5, 19)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (11, 1, CAST(N'2024-05-10T13:23:38.560' AS DateTime), N'hayyyyyyyyyyyyyyyyyyyyyyyyy', 5, 20)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (1, 9, CAST(N'2024-05-10T13:36:03.450' AS DateTime), N'viết được', 2, 21)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (1, 12)
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (217, 1)
GO
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (1, N'SanPham\1\Images\maytinh1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (1, N'SanPham\1\Images\maytinh2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (1, N'SanPham\1\Images\maytinh3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (1, N'SanPham\1\Images\maytinh4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (1, N'SanPham\1\Images\maytinh5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (2, N'SanPham\2\Images\maytinh1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (2, N'SanPham\2\Images\maytinh2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (2, N'SanPham\2\Images\maytinh3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (2, N'SanPham\2\Images\maytinh4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (2, N'SanPham\2\Images\maytinh5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (3, N'SanPham\3\Images\sach2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (3, N'SanPham\3\Images\sach3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (3, N'SanPham\3\Images\sach4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (3, N'SanPham\3\Images\sach5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (4, N'SanPham\4\Images\sach1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (4, N'SanPham\4\Images\sach2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (4, N'SanPham\4\Images\sach3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (4, N'SanPham\4\Images\sach4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (4, N'SanPham\4\Images\sach5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (5, N'SanPham\5\Images\ao1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (5, N'SanPham\5\Images\ao2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (5, N'SanPham\5\Images\ao3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (5, N'SanPham\5\Images\ao4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (5, N'SanPham\5\Images\ao5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (6, N'SanPham\6\Images\quanao1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (6, N'SanPham\6\Images\quanao2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (6, N'SanPham\6\Images\quanao3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (6, N'SanPham\6\Images\quanao4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (6, N'SanPham\6\Images\quanao5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (7, N'SanPham\7\Images\trangsuc1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (7, N'SanPham\7\Images\trangsuc2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (7, N'SanPham\7\Images\trangsuc3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (7, N'SanPham\7\Images\trangsuc4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (7, N'SanPham\7\Images\trangsuc5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (8, N'SanPham\8\Images\trangsuc1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (8, N'SanPham\8\Images\trangsuc2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (8, N'SanPham\8\Images\trangsuc3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (8, N'SanPham\8\Images\trangsuc4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (8, N'SanPham\8\Images\trangsuc5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (9, N'SanPham\9\Images\mypham1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (9, N'SanPham\9\Images\mypham2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (9, N'SanPham\9\Images\mypham3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (9, N'SanPham\9\Images\mypham4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (9, N'SanPham\9\Images\mypham5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (10, N'SanPham\9\Images\mypham1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (10, N'SanPham\9\Images\mypham2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (10, N'SanPham\9\Images\mypham3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (10, N'SanPham\9\Images\mypham4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (10, N'SanPham\9\Images\mypham5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (189, N'SanPham\189\Images\giao-trinh-giai-tich-2-0-367.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\279080907_1371406840002401_4488939180690898952_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\314609776_2031902947008913_2786826105604834965_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\436202551_936976241547630_6939853369895260708_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\437374859_937598354818752_5221166171599750066_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (197, N'SanPham\197\Images\306603826_1786113071732074_7050158773835884877_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (197, N'SanPham\197\Images\73539711_p0_master1200.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (197, N'SanPham\197\Images\alone_art_field_127230_3840x2400.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (197, N'SanPham\197\Images\z4060901955901_e7cc6587c00105d94ca3e8e389cc278f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (197, N'SanPham\197\Images\z4060901957809_d2589ced2abeb91cac6d8532ebcedea3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\05374a90b3344b1da1428ea18989cb6d.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\299abb498357ea70bffb5a468815c473.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\2f9fc434d2caa9283595a8415a7212b9.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\3410dbdec5959b179268c23cbdf8e29b.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\5d8cc525a314e90ccce288276e0d71b5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\6e63414d0b237e32bc7046f381f3bc10.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (217, N'SanPham\217\Images\8db8431c219129782f95fa50c86e69ee.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-17m29kyr2novf4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-1mzxqnyr2nov14.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-9g933lyr2nov6f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-j2kx1nyr2nov95.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-s1kx1nyr2nove5.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134201-23030-sc7xkoyr2nov48.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134207-7r98o-lusteanumvc568.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134207-7r98o-lusteanuo9wla7.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (220, N'SanPham\220\Images\vn-11134207-7r98o-lusteanupoh19c.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7qukw-liq12zg2t8sy47.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7qukw-liq12zg309n6e9.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7qukw-liq12zg31o7m2e.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7qukw-ljof66rxwfckf9.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7qukw-ljof66rxz8hgf1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7r98o-ltb4wklttl09cd.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7r98o-ltcjyrowk3wka3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (221, N'SanPham\221\Images\vn-11134207-7r98o-ltcjyrowlih097.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcck-ls103l5fli8i38.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcd8-ls103m9dz15f58.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcdk-ls103m1w9zo049.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcdx-ls103ldr9buof9.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcee-ls103mllh5us10.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rceo-ls103mycyi0j4b.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\sg-11134201-7rcew-ls103lsqnej823.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (222, N'SanPham\222\Images\vn-11134207-7r98o-lt4y33a8ly8pe9.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-ll9ewlw8bh6e11.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-ll9ewlw8fovq39.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-ll9ewlw8qx8od1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-lrzfnjv4kmv8c8.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-ltnb0wfah0ct43.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (223, N'SanPham\223\Images\vn-11134207-7r98o-luyi6i9yleed1f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (224, N'SanPham\224\Images\sg-11134201-7rbn8-lpumcg3m5yjq90.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (224, N'SanPham\224\Images\vn-11134207-7r98o-lstmhhgcgpfo80.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (224, N'SanPham\224\Images\vn-11134207-7r98o-ltc5lyj8yb4480.jpg')
GO
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (224, N'SanPham\224\Images\vn-11134207-7r98o-ltc5lyj8zpokae.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (224, N'SanPham\224\Images\vn-11134207-7r98o-ltens01m4yahae.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnrnia6f4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnrowum7a.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnrqbf273.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnso0gra3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnspf17c6.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnsqtln27.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnss863a7.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (225, N'SanPham\225\Images\vn-11134207-7r98o-lp9kqhnsz90b34.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7tlavifc.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7to40ec3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7tqx5a60.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7tsbpq6f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7ttqa61a.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7tv4um6a.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lpaxwi7twjf24f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (226, N'SanPham\226\Images\vn-11134207-7r98o-lt7y4lt6ws78e2.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\17a32bc3a107e794ac7ea5e217f2406c.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\6d1881dd288e350faa38a963b51bf1ec.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\870c6d7fdd953b1a3f55b6c352b5b380.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\e1615f05dceafda3cf1b7f428077395d.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\sg-11134201-22110-wfyt4orh88jv25.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\vn-11134207-7r98o-luvn5tom6n0y85.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\vn-11134207-7r98o-luvn5tom81le3f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\vn-11134207-7r98o-luvn5tom9g5u88.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (227, N'SanPham\227\Images\vn-11134207-7r98o-lv011wmz54pxe0.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (228, N'SanPham\228\Images\5cce4f4fa31189d8f806d020f22c3f68.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\252a59c9752a7b8342b857502f52d7dd.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\9591f1ce96790b1890e19d155293fa9c.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\9c1cb5d3dc65522f7cd0f8c31e5e1b7d.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\vn-11134207-7r98o-lo1z9fm98iy5ea.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\vn-11134207-7r98o-lo1z9fm99xilff.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\vn-11134207-7r98o-lo1z9fm9bc3159.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (229, N'SanPham\229\Images\vn-11134207-7r98o-lo1z9fnn6hru70.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (230, N'SanPham\230\Images\sg-11134201-22100-lcxv5a7lk5ive4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (230, N'SanPham\230\Images\sg-11134201-22120-n5muubr485kved.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (231, N'SanPham\231\Images\vn-11134207-7r98o-ltwpygi7kgsq67.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (231, N'SanPham\231\Images\vn-11134207-7r98o-ltwpygi7kgzx88.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (231, N'SanPham\231\Images\vn-11134207-7r98o-ltwpygi7rhmy89.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (231, N'SanPham\231\Images\vn-11134207-7r98o-ltwpygi8fdai1c.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (231, N'SanPham\231\Images\vn-11134207-7r98o-lu8t2m5w2j2p84.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (232, N'SanPham\232\Images\vn-11134207-7r98o-ltzj6ehwlxjlf7.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (232, N'SanPham\232\Images\vn-11134207-7r98o-ltzj6ehwlxy747.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (232, N'SanPham\232\Images\vn-11134207-7r98o-ltzj6ehx1dshe3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (233, N'SanPham\233\Images\02ad85f487fbb2a5fb42786c6089fa08.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (233, N'SanPham\233\Images\145ac46e779861afaa4b7241a2c95e47.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (233, N'SanPham\233\Images\1a813ec92cb6d459027eac2eec706966.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (233, N'SanPham\233\Images\a5c72bf2c069892f57df2a0e89913744.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (233, N'SanPham\233\Images\ed1c91a7036431070023a12f33f4e616.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (234, N'SanPham\234\Images\vn-11134207-7qukw-ljeym101dsr63d.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (234, N'SanPham\234\Images\vn-11134207-7qukw-ljeym101f7bm87.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (234, N'SanPham\234\Images\vn-11134207-7r98o-lkqieycz3rqzd1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\81a1012e11937a54ce3569b83b540a69.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\9406642e1d64847bca15bcf7c8f54a7a.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\b30dc5a465e89004ef532d50ef58b157.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\be653f06ae4cbe4f611c31407db8d37b.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\c55a9378a43cc2e2a15073a18cfbd1da.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\vn-11134201-7qukw-lep8flc3u10zaa.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\vn-11134207-23010-wu70b8dkc7lvfd.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (236, N'SanPham\236\Images\vn-11134207-7r98o-lv2w0bxmodfdb4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf88lil19.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8a0313b.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8benhf8.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8ct7x3b.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8e7sd08.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8fmct42.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fkkf8h0x99e.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (237, N'SanPham\237\Images\vn-11134207-7r98o-lo2fpqb427i28e.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (238, N'SanPham\238\Images\ce303e02e4569b46ac002ba5cbd76316.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (239, N'SanPham\239\Images\044ef8964f15bd433b34bbd7b84796a1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (239, N'SanPham\239\Images\2bbf923c08f4b8ac0a54096d196e9f15.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (239, N'SanPham\239\Images\705e3edc06981ef13c6cd47edca059a3.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (239, N'SanPham\239\Images\a2f43ee51c3a82b3ef44c131e0fb25b0.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-2gvty26x07iva4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-2wfcrd9x07iva0.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-6v6q1g8x07ive1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-g6wrqs9x07iv34.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-m1rbsvp407ivd4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-qjxjur6207ivba.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (240, N'SanPham\240\Images\sg-11134201-22100-xh0p9n0207iv81.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (242, N'SanPham\242\Images\3cf84c4326b53ec0eca8027a6a43a01d.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (242, N'SanPham\242\Images\5fa9aaccd639d0c7063b4623eaa9bedb.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (242, N'SanPham\242\Images\60626de1fae2bd22c0ca5f768702abf1.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (242, N'SanPham\242\Images\vn-11134207-7qukw-lito0t9xotn07f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (243, N'SanPham\243\Images\vn-11134207-7r98o-lp9kqhnrnia6f4.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (243, N'SanPham\243\Images\vn-11134207-7r98o-lp9kqhnrqbf273.jpg')
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (1, 1, N'Máy Tính 1', 100, 50, 50, 99, N'Electronics', 36, 28, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 119, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (2, 1, N'Máy Tính 2', 100, 50, 50, 100, N'Electronics', 10, 23, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 2, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (3, 1, N'Sách 1', 100, 50, 50, 100, N'Books', 3438, 3437, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 33, 500)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (4, 1, N'Sách 2', 100, 50, 50, 100, N'Books', 990, 71, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 117, 200)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (5, 1, N'Quần áo 1', 100, 50, 50, 100, N'Fashion and Clothing', 100, 48, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 7, 50)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (6, 1, N'Quần áo 2', 100, 50, 50, 80, N'Fashion and Clothing', 100, 95, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 49, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (7, 1, N'Trang sức 1', 100, 50, 50, 100, N'Jewellery', 10, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 3, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (8, 1, N'Trang sức 2', 100, 50, 50, 100, N'Jewellery', 0, 3, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 8, 290)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (9, 1, N'Mỹ phẩm 1', 100, 50, 50, 100, N'Health and Beauty', 1000, 543, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 0, 22)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (10, 1, N'Meowww', 100, 50, 50, 80, N'Electronics', 990, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 3, 2)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (189, 1, N'GiaiTich2', 10, 10, 0, 100, N'Books', 93, 93, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 9, 1231)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (193, 9, N'Pictures', 200, 180, 10, 93, N'Home and Garden', 100, 100, CAST(N'2024-04-13T00:00:00.000' AS DateTime), 9, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (197, 10, N'Arts', 100, 80, 20, 100, N'Home and Garden', 10, 10, CAST(N'2024-05-04T00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (217, 9, N'Tai nghe Bluetooth 5.0 không dây Mini trong tai thể thao có Mic Tai nghe rảnh tay Tai nghe nhét tai cho Samsung Huawei', 77, 66, 14.2857151, 88, N'Electronics', 20, 11, CAST(N'2023-11-08T00:00:00.000' AS DateTime), 12, 528)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (220, 9, N'Ghế xoay văn phòng, ghế lưới cao cấp thiết kế chống mỏi lưng, XOAY 360 độ học tập làm việc,Thiết kế lưng cong, hỗ trợ cộ', 15, 13, 13.333334, 94, N'Home and Garden', 1, 1, CAST(N'2024-05-04T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (221, 9, N'Ly giữ nhiệt Americano Inox 304 Cao Cấp Không Gỉ,Tặng ống hút siêu tiện lợi 600ml hàng đẹp (loại 1)', 1, 0.64, 36, 88, N'Home and Garden', 1, 1, CAST(N'2024-05-10T09:36:08.710' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (222, 9, N'Khăn tấm', 1, 0.55, 45, 70, N'Home and Garden', 10, 10, CAST(N'2024-05-10T09:38:14.823' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (223, 9, N'Serum Dưỡng Sáng, Phục Hồi Cho Da Dầu Mụn, Nhạy Cảm Niacinamide 10% + Arbutin 2% Tia''m Vita B3 Source 40ml', 20, 17, 15.000001, 91, N'Health and Beauty', 10, 10, CAST(N'2024-05-15T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (224, 9, N'Bàn Làm Việc, Bàn Gaming Nội Thất 5C chữ K,U,Z mặt gỗ 1m2,1m thiết kế cá tính, chân sắt sơn tĩnh điện dày dặn, chắc chắn', 30, 21, 30.0000019, 99.9, N'Home and Garden', 15, 12, CAST(N'2024-05-10T09:42:31.913' AS DateTime), 1, 63)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (225, 10, N'Bút Bi Nước Mực Gel Đen Xanh Đỏ Khô Nhanh Ngòi 0.5mm, Mực Đều, Nét Chữ Đẹp Đủ Màu - Trạm Sinh Viên.', 0.05, 0.03, 40, 100, N'Books', 100, 100, CAST(N'2024-05-07T00:00:00.000' AS DateTime), 2, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (226, 10, N'Ví nam Playboy kẻ, Ví da nam nhỏ gọn DODANA dáng ngang da PU', 10, 1, 90, 99, N'Fashion and Clothing', 20, 20, CAST(N'2024-05-09T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (227, 10, N'Sữa Tắm Lifebuoy 800gr Detox Và Sạch Sâu Khỏi Bụi Mịn Pm2.5 Detox 100% Từ Thiên Nhiên Diệt Khuẩn', 10, 8, 20, 97, N'Health and Beauty', 10, 10, CAST(N'2024-05-06T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (228, 10, N'Sách - Sherlock Holmes Trọn Bộ 3 Tập (Bìa Cứng 3 Cuốn)', 10, 8.88, 11.2000008, 100, N'Books', 10, 8, CAST(N'2024-05-10T09:56:21.810' AS DateTime), 4, 17.76)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (229, 10, N'Sách Hai số phận (Bìa mềm)', 5, 4, 20, 100, N'Books', 13, 13, CAST(N'2024-05-02T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (230, 10, N'Sách Cuộc đời kỳ lạ của Nikola Tesla', 4, 3.32, 17, 97, N'Books', 20, 20, CAST(N'2024-05-10T10:00:53.187' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (231, 10, N'Combo Sách Ghi Chép Pháp Y (Bộ 3 Cuốn)', 30, 10, 66.66667, 100, N'Books', 10, 4, CAST(N'2024-05-04T00:00:00.000' AS DateTime), 1, 60)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (232, 10, N'Sách - Thiên Tài Bên Trái, Kẻ Điên Bên Phải (Tái Bản)', 100, 99, 1, 100, N'Books', 9, 9, CAST(N'2024-05-03T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (233, 10, N'Sách Sự Im Lặng Của Bầy Cừu', 5, 4.8, 4, 99.7, N'Books', 10, 10, CAST(N'2024-05-05T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (234, 10, N'Sách - Phân Tích Tâm Lý Tội Phạm - Thế Giới Bên Trong Cái Ác', 10, 9, 10, 54, N'Books', 10, 10, CAST(N'2024-05-10T10:10:30.240' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (236, 11, N'Máy lọc không khí Dyson Pure Cool ™ Tower TP00 (Trắng/Bạc)', 500, 400, 20, 95, N'Electronics', 10, 8, CAST(N'2024-05-09T00:00:00.000' AS DateTime), 2, 800)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (237, 11, N'Sách - Harry Porter 8 cuốn', 22, 22, 0, 100, N'Books', 7, 7, CAST(N'2024-05-04T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (238, 11, N'Sách Thần thoại Bắc Âu', 5, 4.5, 10, 77, N'Books', 6, 6, CAST(N'2024-04-09T00:00:00.000' AS DateTime), 2, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (239, 11, N'Sách Những Người Khốn Khổ Trọn Bộ 3 Tập', 30, 10, 66.66667, 88, N'Books', 15, 15, CAST(N'2024-05-07T00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (240, 11, N'Yadou Túi Xách Tay Bằng Vải Canvas In Hình Snoopy Dễ Thương Có Ngăn Đựng Hộp Cơm Trưa', 4, 3, 25, 92, N'Health and Beauty', 10, 5, CAST(N'2024-05-14T00:00:00.000' AS DateTime), 1, 15)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (242, 11, N'Sách - Hai Vạn Dặm Dưới Đáy Biển (TB 2022)', 5, 2.5, 50, 100, N'Books', 10, 10, CAST(N'2024-05-10T10:44:36.767' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (243, 1, N'i have a pen', 2000, 1900, 5, 100, N'Books', 10, 9, CAST(N'2024-05-10T13:31:56.500' AS DateTime), 1, 1900)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (9, N'ImageCmt\9\96354260_p0_master1200.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (10, N'ImageCmt\10\z4060901955901_e7cc6587c00105d94ca3e8e389cc278f.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (10, N'ImageCmt\10\z4060901957809_d2589ced2abeb91cac6d8532ebcedea3.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (15, N'ImageCmt\15\5cce4f4fa31189d8f806d020f22c3f68.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (17, N'ImageCmt\17\5d8cc525a314e90ccce288276e0d71b5.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (18, N'ImageCmt\18\05374a90b3344b1da1428ea18989cb6d.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (19, N'ImageCmt\19\2f9fc434d2caa9283595a8415a7212b9.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (19, N'ImageCmt\19\8db8431c219129782f95fa50c86e69ee.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (20, N'ImageCmt\20\1714130487337.jpeg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (21, N'ImageCmt\21\vn-11134207-7r98o-lp9kqhnrowum7a.jpg')
GO
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (6, 3, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (6, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (6, 6, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (7, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (7, 8, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (7, 189, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (8, 8, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (8, 13, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (11, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (11, 6, 10)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (20, 4, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (25, 4, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (27, 1, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (27, 5, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (27, 6, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (28, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (29, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (30, 1, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (31, 189, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (32, 189, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (33, 5, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (34, 4, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (35, 217, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (36, 217, 2)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (37, 8, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (38, 217, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (38, 224, 3)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (38, 231, 6)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (38, 240, 5)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (39, 228, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (40, 236, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (41, 236, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (42, 243, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (43, 217, 1)
INSERT [dbo].[LstProduct] ([IDInvoice], [IDProduct], [Number]) VALUES (43, 228, 1)
GO
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (1, N'Dat&Son', N'TP.HCM', N'ShopAvatar\1\437374859_937598354818752_5221166171599750066_n.jpg', N'0906092793', N'student@hcmute@gmail.com', 4.9, N'Chạy dl tới chết!', CAST(N'2024-04-16T00:00:00.000' AS DateTime), 277, 8, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (9, N'ChuBeDan', N'DaNang', N'ShopAvatar\9\z3957084648253_817e8d84d9e3f39da8589f56389c49a9.jpg', N'0123456788', N'shop2@gmail.com', 5, N'Ngon bổ rẻ!', CAST(N'2024-05-03T23:15:53.800' AS DateTime), 46, 4, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (10, N'Family shop', N'HCMUTE', N'ShopAvatar\10\279080907_1371406840002401_4488939180690898952_n.jpg', N'0987654321', N'td@gmail.com', 5, N'Yahallo!', CAST(N'2024-05-05T16:42:58.157' AS DateTime), 29, 3, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (11, N'World of books', N'Celestial Palace', N'ShopAvatar\11\4K-Ultra-HD-Wallpapers.jpg', N'0987654321', N'celesPala@gmail.com', 5, N'Enjoy endless peacefull moment!', CAST(N'2024-05-05T22:07:25.657' AS DateTime), 21, 3, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (12, NULL, NULL, NULL, NULL, NULL, 5, N'Sorry! This user has not written slogan!', CAST(N'2024-05-10T10:14:03.280' AS DateTime), 0, 0, 0)
GO
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (1, N'1234', N'DanDanDon', NULL, NULL, CAST(N'2004-04-22T00:00:00.000' AS DateTime), N'0906092794', N'1@gmail.com', NULL, NULL, N'ImagesAvatar\1\z3957084648253_817e8d84d9e3f39da8589f56389c49a9.jpg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (9, N'372193713183', N'AccTest2', NULL, NULL, CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'0099999999', N'2@gmail.com', NULL, NULL, N'ImagesAvatar\9\1336369.jpeg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (10, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T00:00:00.000' AS DateTime), NULL, N'3@gmail.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (11, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T00:00:00.000' AS DateTime), NULL, N'4@gmail.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (12, NULL, NULL, NULL, NULL, CAST(N'2024-05-10T00:00:00.000' AS DateTime), NULL, N'td13052004@gmail.com', NULL, NULL, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__C9F2845681F2AFF2]    Script Date: 5/11/2024 10:28:13 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [DataTimeCreate]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT ((0)) FOR [Revenue]
GO
ALTER TABLE [dbo].[LstProduct] ADD  DEFAULT ((1)) FOR [Number]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT ((5)) FOR [Rating]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT ('Sorry! This user has not written slogan!') FOR [Slogan]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT ((0)) FOR [Visits]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT ((0)) FOR [Purchases]
GO
ALTER TABLE [dbo].[Shop] ADD  DEFAULT ((0)) FOR [NumOfCusRate]
GO
ALTER TABLE [dbo].[Bought]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Bought]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product_User] FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([IDShop])
REFERENCES [dbo].[Shop] ([IDShop])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[FaVProduct]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[FaVProduct]  WITH CHECK ADD FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[FaVProduct]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[FaVProduct]  WITH CHECK ADD FOREIGN KEY([IDUser])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[ImageLink]  WITH CHECK ADD  CONSTRAINT [FK_ImageLink_Inventory] FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[ImageLink] CHECK CONSTRAINT [FK_ImageLink_Inventory]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_IDShop] FOREIGN KEY([IDShop])
REFERENCES [dbo].[Shop] ([IDShop])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_IDShop]
GO
ALTER TABLE [dbo].[LstImagesCMT]  WITH CHECK ADD  CONSTRAINT [FK_Images_CMT] FOREIGN KEY([IDComment])
REFERENCES [dbo].[Comment] ([IDCmt])
GO
ALTER TABLE [dbo].[LstImagesCMT] CHECK CONSTRAINT [FK_Images_CMT]
GO
ALTER TABLE [dbo].[LstProduct]  WITH CHECK ADD FOREIGN KEY([IDInvoice])
REFERENCES [dbo].[Bought] ([IDInvoice])
GO
ALTER TABLE [dbo].[Priority]  WITH CHECK ADD FOREIGN KEY([IDproduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[Priority]  WITH CHECK ADD FOREIGN KEY([IDproduct])
REFERENCES [dbo].[Inventory] ([IDProduct])
GO
ALTER TABLE [dbo].[Priority]  WITH CHECK ADD FOREIGN KEY([IDuser])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Priority]  WITH CHECK ADD FOREIGN KEY([IDuser])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Shop]  WITH CHECK ADD  CONSTRAINT [FK_ShopID] FOREIGN KEY([IDShop])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Shop] CHECK CONSTRAINT [FK_ShopID]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_UserID] FOREIGN KEY([ID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_UserID]
GO
USE [master]
GO
ALTER DATABASE [LTWD_Final_Project] SET  READ_WRITE 
GO
