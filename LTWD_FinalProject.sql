USE [LTWD_Final_Project]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Bought]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 5/5/2024 11:29:02 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[DataTimeCreate] ASC,
	[IDUser] ASC,
	[IDShop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FaVProduct]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[ImageLink]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[LstProduct]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[Shop]    Script Date: 5/5/2024 11:29:02 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 5/5/2024 11:29:02 PM ******/
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
SET IDENTITY_INSERT [dbo].[Bought] OFF
GO
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T20:24:52.760' AS DateTime), N'Services are good!', 4)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T20:25:23.160' AS DateTime), N'hello?', 2)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T20:29:48.250' AS DateTime), N'Quần áo còn xài được ', 3)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T20:31:16.747' AS DateTime), N'Rất đẹp', 4)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T20:34:57.227' AS DateTime), N'8:34', 4)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 9, CAST(N'2024-05-03T21:05:16.157' AS DateTime), N'Test từ User2', 4)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-03T21:11:33.310' AS DateTime), N'daslkdajakld', 4)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-05T23:16:39.993' AS DateTime), N'Tôi đã khóc....', 5)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate]) VALUES (1, 1, CAST(N'2024-05-05T23:18:32.497' AS DateTime), N'Thật cảm động....', 5)
GO
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (1, 1)
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (1, 9)
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (4, 1)
INSERT [dbo].[FaVProduct] ([IDProduct], [IDUser]) VALUES (6, 9)
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
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (11, N'SanPham\11\Images\maxresdefault (1).jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (11, N'SanPham\11\Images\maxresdefault.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (11, N'SanPham\11\Images\OIP (1).jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (11, N'SanPham\11\Images\OIP (2).jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (11, N'SanPham\11\Images\OIP.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (12, N'SanPham\12\Images\432041522_803478641797498_7128876628545447927_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (12, N'SanPham\12\Images\Tite.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (12, N'SanPham\12\Images\vn-11134207-7r98o-lo9yjj9mwz2j5f.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (12, N'SanPham\12\Images\vn-11134207-7r98o-lqswwejdkrp3ab.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (189, N'SanPham\189\Images\giao-trinh-giai-tich-2-0-367.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\279080907_1371406840002401_4488939180690898952_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\314609776_2031902947008913_2786826105604834965_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\436202551_936976241547630_6939853369895260708_n.jpg')
INSERT [dbo].[ImageLink] ([IDProduct], [ImageLink]) VALUES (193, N'SanPham\193\Images\437374859_937598354818752_5221166171599750066_n.jpg')
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (1, 1, N'Máy Tính 1', 100, 50, 50, 99, N'Electronics', 36, 28, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 109, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (2, 1, N'Máy Tính 2', 100, 50, 50, 100, N'Electronics', 10, 23, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 2, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (3, 1, N'Sách 1', 100, 50, 50, 100, N'Books', 3438, 3437, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 29, 500)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (4, 1, N'Sách 2', 100, 50, 50, 100, N'Books', 990, 72, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 109, 200)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (5, 1, N'Quần áo 1', 100, 50, 50, 100, N'Fashion and Clothing', 100, 49, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 1, 50)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (6, 1, N'Quần áo 2', 100, 50, 50, 80, N'Fashion and Clothing', 100, 95, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 46, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (7, 1, N'Trang sức 1', 100, 50, 50, 100, N'Jewellry', 10, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 3, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (8, 1, N'Trang sức 2', 100, 50, 50, 100, N'Jewellry', 0, 8, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 7, 40)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (9, 1, N'Mỹ phẩm 1', 100, 50, 50, 100, N'Health and Beauty', 1000, 543, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 0, 22)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (10, 1, N'Meowww', 100, 50, 50, 80, N'Electronics', 990, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (11, 1, N'aaaa', 100, 50, 50, 10, N'Health and Beauty', 0, 0, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 4, 76)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (12, 1, N'sdadsad', 100, 50, 50, 100, N'Jewellery', 90, 9, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 1, 223)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (189, 1, N'GiaiTich2', 100, 90, 10, 90, N'Electronics', 100, 99, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 5, 1231)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (193, 9, N'Pictures', 100, 50, 50, 800, N'Home and Garden', 100, 100, CAST(N'2024-04-13T00:00:00.000' AS DateTime), 8, 0)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
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
GO
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (1, N'Dat&Son', N'TP.HCM', N'ShopAvatar\1\437374859_937598354818752_5221166171599750066_n.jpg', N'0906092793', N'student@hcmute@gmail.com', 4.9, N'Chạy dl tới chết!', CAST(N'2024-04-16T00:00:00.000' AS DateTime), 181, 2, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (9, NULL, NULL, NULL, NULL, NULL, 5, N'Sorry! This user has not written slogan!', CAST(N'2024-05-03T23:15:53.800' AS DateTime), 11, 0, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (10, N'Test', N'HCMUTE', N'ShopAvatar\10\96354260_p0_master1200.jpg', N'0987654321', N'td@gmail.com', 5, N'Yahallo!', CAST(N'2024-05-05T16:42:58.157' AS DateTime), 0, 0, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (11, NULL, NULL, NULL, NULL, NULL, 5, N'Sorry! This user has not written slogan!', CAST(N'2024-05-05T22:07:25.657' AS DateTime), 0, 0, 0)
GO
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (1, N'1234', N'DanDanDon', NULL, NULL, CAST(N'2004-04-22T00:00:00.000' AS DateTime), N'0906092794', N'1@gmail.com', NULL, NULL, N'ImagesAvatar\1\z3957084648253_817e8d84d9e3f39da8589f56389c49a9.jpg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (9, N'372193713183', N'AccTest2', NULL, NULL, CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'0099999999', N'2@gmail.com', NULL, NULL, N'ImagesAvatar\9\437592616_944789174099670_8151274283130571424_n.jpg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (10, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T00:00:00.000' AS DateTime), NULL, N'3@gmail.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (11, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T22:07:30.823' AS DateTime), NULL, N'4@gmail.com', NULL, NULL, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__C9F2845681F2AFF2]    Script Date: 5/5/2024 11:29:02 PM ******/
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
