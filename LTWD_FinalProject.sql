USE [LTWD_Final_Project]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Bought]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[FaVProduct]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[ImageLink]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[LstImagesCMT]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[LstProduct]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[Shop]    Script Date: 5/9/2024 4:58:10 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 5/9/2024 4:58:10 PM ******/
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
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (31, 9, CAST(N'2024-05-09T13:55:25.203' AS DateTime), 450)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (32, 9, CAST(N'2024-05-09T13:58:28.093' AS DateTime), 90)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (33, 9, CAST(N'2024-05-09T14:11:28.950' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (34, 9, CAST(N'2024-05-09T14:20:38.523' AS DateTime), 50)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (35, 1, CAST(N'2024-05-09T14:47:02.713' AS DateTime), 66)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (36, 1, CAST(N'2024-05-09T14:52:49.520' AS DateTime), 132)
INSERT [dbo].[Bought] ([IDInvoice], [IDUser], [DateBought], [TotalPrice]) VALUES (37, 9, CAST(N'2024-05-09T16:46:56.953' AS DateTime), 250)
SET IDENTITY_INSERT [dbo].[Bought] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (1, 9, CAST(N'2024-05-09T14:20:41.600' AS DateTime), N'dasdasd', 5, 9)
INSERT [dbo].[Comment] ([IDShop], [IDUser], [DataTimeCreate], [Comment], [Rate], [IDCmt]) VALUES (1, 9, CAST(N'2024-05-09T16:47:01.853' AS DateTime), N'Trang sức rất đẹp', 5, 10)
SET IDENTITY_INSERT [dbo].[Comment] OFF
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
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (1, 1, N'Máy Tính 1', 100, 50, 50, 99, N'Electronics', 36, 28, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 114, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (2, 1, N'Máy Tính 2', 100, 50, 50, 100, N'Electronics', 10, 23, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 2, 100)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (3, 1, N'Sách 1', 100, 50, 50, 100, N'Books', 3438, 3437, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 30, 500)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (4, 1, N'Sách 2', 100, 50, 50, 100, N'Books', 990, 71, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 115, 200)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (5, 1, N'Quần áo 1', 100, 50, 50, 100, N'Fashion and Clothing', 100, 48, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 6, 50)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (6, 1, N'Quần áo 2', 100, 50, 50, 80, N'Fashion and Clothing', 100, 95, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 47, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (7, 1, N'Trang sức 1', 100, 50, 50, 100, N'Jewellery', 10, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 3, 30)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (8, 1, N'Trang sức 2', 100, 50, 50, 100, N'Jewellery', 0, 3, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 8, 290)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (9, 1, N'Mỹ phẩm 1', 100, 50, 50, 100, N'Health and Beauty', 1000, 543, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 0, 22)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (10, 1, N'Meowww', 100, 50, 50, 80, N'Electronics', 990, 10, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 2, 2)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (11, 1, N'aaaa', 100, 50, 50, 10, N'Health and Beauty', 0, 0, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 8, 76)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (12, 1, N'sdadsad', 100, 50, 50, 100, N'Jewellery', 90, 9, CAST(N'2024-03-31T00:00:00.000' AS DateTime), 2, 223)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (189, 1, N'GiaiTich2', 100, 90, 10, 90, N'Electronics', 100, 93, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 8, 1231)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (193, 9, N'Pictures', 200, 180, 10, 93, N'Home and Garden', 100, 100, CAST(N'2024-04-13T00:00:00.000' AS DateTime), 9, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (197, 10, N'Arts', 100, 80, 20, 100, N'Home and Garden', 10, 10, CAST(N'2024-05-04T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[Inventory] ([IDProduct], [IDShop], [Name], [OriginalPrice], [CurrentPrice], [Save], [Newness], [Type], [NumberInput], [NumberLeft], [BoughtTime], [Priority], [Revenue]) VALUES (217, 9, N'Tai nghe Bluetooth 5.0 không dây Mini trong tai thể thao có Mic Tai nghe rảnh tay Tai nghe nhét tai cho Samsung Huawei', 77, 66, 14.2857151, 88, N'Electronics', 20, 17, CAST(N'2023-11-08T00:00:00.000' AS DateTime), 4, 132)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (9, N'ImageCmt\9\96354260_p0_master1200.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (10, N'ImageCmt\10\z4060901955901_e7cc6587c00105d94ca3e8e389cc278f.jpg')
INSERT [dbo].[LstImagesCMT] ([IDComment], [ImageLink]) VALUES (10, N'ImageCmt\10\z4060901957809_d2589ced2abeb91cac6d8532ebcedea3.jpg')
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
GO
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (1, N'Dat&Son', N'TP.HCM', N'ShopAvatar\1\437374859_937598354818752_5221166171599750066_n.jpg', N'0906092793', N'student@hcmute@gmail.com', 4.9, N'Chạy dl tới chết!', CAST(N'2024-04-16T00:00:00.000' AS DateTime), 242, 7, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (9, N'ChuBeDan', N'DaNang', N'ShopAvatar\9\z3957084648253_817e8d84d9e3f39da8589f56389c49a9.jpg', N'0123456788', N'shop2@gmail.com', 5, N'Ngon bổ rẻ!', CAST(N'2024-05-03T23:15:53.800' AS DateTime), 24, 2, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (10, N'Test', N'HCMUTE', N'ShopAvatar\10\279080907_1371406840002401_4488939180690898952_n.jpg', N'0987654321', N'td@gmail.com', 5, N'Yahallo!', CAST(N'2024-05-05T16:42:58.157' AS DateTime), 4, 0, 0)
INSERT [dbo].[Shop] ([IDShop], [NameShop], [Address], [ShopAvatar], [PhoneNumber], [Email], [Rating], [Slogan], [CreateDate], [Visits], [Purchases], [NumOfCusRate]) VALUES (11, NULL, NULL, NULL, NULL, NULL, 5, N'Sorry! This user has not written slogan!', CAST(N'2024-05-05T22:07:25.657' AS DateTime), 0, 0, 0)
GO
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (1, N'1234', N'DanDanDon', NULL, NULL, CAST(N'2004-04-22T00:00:00.000' AS DateTime), N'0906092794', N'1@gmail.com', NULL, NULL, N'ImagesAvatar\1\z3957084648253_817e8d84d9e3f39da8589f56389c49a9.jpg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (9, N'372193713183', N'AccTest2', NULL, NULL, CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'0099999999', N'2@gmail.com', NULL, NULL, N'ImagesAvatar\9\1336369.jpeg')
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (10, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T00:00:00.000' AS DateTime), NULL, N'3@gmail.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [IdentityNum], [Name], [Address], [Sex], [DoB], [PhoneNumber], [Email], [IDFavProduct], [IDFavShop], [Avatar]) VALUES (11, NULL, NULL, NULL, NULL, CAST(N'2024-05-05T22:07:30.823' AS DateTime), NULL, N'4@gmail.com', NULL, NULL, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__C9F2845681F2AFF2]    Script Date: 5/9/2024 4:58:10 PM ******/
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
