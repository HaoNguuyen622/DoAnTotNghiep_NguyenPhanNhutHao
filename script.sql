USE [master]
GO
/****** Object:  Database [EcommerceData]    Script Date: 16-May-21 7:49:08 PM ******/
CREATE DATABASE [EcommerceData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EcommerceData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EcommerceData.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EcommerceData_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EcommerceData_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EcommerceData] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EcommerceData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EcommerceData] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EcommerceData] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EcommerceData] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EcommerceData] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EcommerceData] SET ARITHABORT OFF 
GO
ALTER DATABASE [EcommerceData] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EcommerceData] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EcommerceData] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EcommerceData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EcommerceData] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EcommerceData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EcommerceData] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EcommerceData] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EcommerceData] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EcommerceData] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EcommerceData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EcommerceData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EcommerceData] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EcommerceData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EcommerceData] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EcommerceData] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EcommerceData] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EcommerceData] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EcommerceData] SET  MULTI_USER 
GO
ALTER DATABASE [EcommerceData] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EcommerceData] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EcommerceData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EcommerceData] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EcommerceData] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EcommerceData] SET QUERY_STORE = OFF
GO
USE [EcommerceData]
GO
/****** Object:  Table [dbo].[Collection]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NULL,
	[User_Id] [int] NULL,
	[DateAdd] [datetime] NULL,
 CONSTRAINT [PK_Collection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupRole]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_GroupRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[term_id] [int] NULL,
	[group_date] [datetime] NULL,
	[product_id] [int] NULL,
	[group_item] [int] NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayMeta]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayMeta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_pay] [int] NULL,
	[meta_key] [varchar](255) NULL,
	[meta_value] [nvarchar](max) NULL,
 CONSTRAINT [PK_PayMeta] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pays]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pays](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[pay_sum] [money] NULL,
	[pay_date] [datetime] NULL,
	[pay_status] [int] NULL,
	[item_json] [nvarchar](max) NULL,
	[pay_form] [int] NULL,
	[pay_guild] [varchar](128) NULL,
 CONSTRAINT [PK_Pays] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_date] [datetime] NULL,
	[product_update] [datetime] NULL,
	[product_name] [nvarchar](200) NULL,
	[product_guid] [varchar](255) NULL,
	[product_password] [nvarchar](255) NULL,
	[product_view] [int] NULL,
	[product_content] [nvarchar](max) NULL,
	[product_status] [int] NULL,
	[product_img] [varchar](2000) NULL,
	[product_price] [money] NULL,
	[product_percent] [int] NULL,
	[product_active] [bit] NULL,
	[product_inventory] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDescription]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDescription](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[pd_content] [varchar](255) NULL,
	[pd_name] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProductDescription] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](255) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Terms]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Terms](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[term_name] [nvarchar](255) NULL,
	[term_item] [int] NULL,
 CONSTRAINT [PK_Terms] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMeta]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMeta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[meta_key] [varchar](255) NULL,
	[meta_value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserMeta] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16-May-21 7:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[user_login] [varchar](60) NULL,
	[user_pass] [varchar](255) NULL,
	[user_nicename] [varchar](50) NULL,
	[user_email] [varchar](100) NULL,
	[user_activation_key] [varchar](255) NULL,
	[user_status] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Collection] ON 

INSERT [dbo].[Collection] ([ID], [Product_Id], [User_Id], [DateAdd]) VALUES (1, 5, 5, CAST(N'2021-05-16T12:30:47.653' AS DateTime))
INSERT [dbo].[Collection] ([ID], [Product_Id], [User_Id], [DateAdd]) VALUES (2, 5, 5, CAST(N'2021-05-16T12:34:18.980' AS DateTime))
INSERT [dbo].[Collection] ([ID], [Product_Id], [User_Id], [DateAdd]) VALUES (3, 5, 5, CAST(N'2021-05-16T12:39:52.347' AS DateTime))
INSERT [dbo].[Collection] ([ID], [Product_Id], [User_Id], [DateAdd]) VALUES (4, 5, 5, CAST(N'2021-05-16T12:40:55.433' AS DateTime))
SET IDENTITY_INSERT [dbo].[Collection] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupRole] ON 

INSERT [dbo].[GroupRole] ([ID], [role_id], [user_id]) VALUES (2, 2, 5)
SET IDENTITY_INSERT [dbo].[GroupRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Groups] ON 

INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (1, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (2, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (3, NULL, 1, NULL, 3, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (4, NULL, 2, NULL, 4, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (5, NULL, 2, NULL, 5, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (6, NULL, 2, NULL, 6, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (7, NULL, 3, NULL, 7, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (8, NULL, 3, NULL, 8, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (9, NULL, 3, NULL, 9, NULL)
INSERT [dbo].[Groups] ([ID], [user_id], [term_id], [group_date], [product_id], [group_item]) VALUES (10, NULL, 4, NULL, 10, NULL)
SET IDENTITY_INSERT [dbo].[Groups] OFF
GO
SET IDENTITY_INSERT [dbo].[Pays] ON 

INSERT [dbo].[Pays] ([ID], [user_id], [pay_sum], [pay_date], [pay_status], [item_json], [pay_form], [pay_guild]) VALUES (6, 5, 27000.0000, CAST(N'2021-05-16T12:27:31.630' AS DateTime), 6, N'[{Product_Id:1,Price:27000,Amount:1},]', 1, N'38aefcc4-f6e7-48e3-8e2d-a6b2c06e2c2f')
SET IDENTITY_INSERT [dbo].[Pays] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (1, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 0, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-1.jpg', 30000.0000, 10, 1, 12)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (2, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), CAST(N'2021-05-16T19:00:31.703' AS DateTime), N'Chuối', NULL, NULL, NULL, N'<p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>

<p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</p>
', NULL, N'8d2a769a-8a4f-4d24-b45e-291bc18e03d0product-2.jpg', 30000.0000, 20, 1, 12)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (3, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 0, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-3.jpg', 30000.0000, 10, 1, 12)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (4, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), CAST(N'2021-05-16T19:00:41.457' AS DateTime), N'Nho', NULL, NULL, NULL, N'<p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>

<p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</p>
', NULL, N'product-4.jpg', 30000.0000, 15, 1, 50)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (5, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), CAST(N'2021-05-16T19:01:00.053' AS DateTime), N'Hamberger', NULL, NULL, NULL, N'<p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>

<p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</p>
', NULL, N'product-5.jpg', 30000.0000, 15, 1, 200)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (6, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 0, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-6.jpg', 30000.0000, 0, 1, 0)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (7, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 0, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-7.jpg', 30000.0000, 0, 1, 1)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (8, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 0, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-8.jpg', 30000.0000, 0, 1, 5)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (9, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 1, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-9.jpg', 30000.0000, 0, 1, 8)
INSERT [dbo].[Product] ([ID], [user_id], [product_date], [product_update], [product_name], [product_guid], [product_password], [product_view], [product_content], [product_status], [product_img], [product_price], [product_percent], [product_active], [product_inventory]) VALUES (10, NULL, CAST(N'2021-05-15T00:00:00.000' AS DateTime), NULL, N'Crab Pool Security', NULL, NULL, 2, N'<p>
                                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                    Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                    Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                    sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                    eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                    Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                    sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                    diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                    ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                    Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                    Proin eget tortor risus.
                                </p>
                                <p>
                                    Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                    ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                    elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                    porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                    nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                </p>', NULL, N'product-10.jpg', 30000.0000, 0, 1, 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([ID], [role_name]) VALUES (1, N'Người dùng')
INSERT [dbo].[Roles] ([ID], [role_name]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Terms] ON 

INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (1, N'Trái cây', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (2, N'Rau củ', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (3, N'Bánh kẹo', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (4, N'Nước ngọt', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (5, N'Gạo', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (6, N'Đồ gia dụng', 1)
INSERT [dbo].[Terms] ([ID], [term_name], [term_item]) VALUES (1002, N'danh mục 3', NULL)
SET IDENTITY_INSERT [dbo].[Terms] OFF
GO
SET IDENTITY_INSERT [dbo].[UserMeta] ON 

INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (7, 5, N'address', N'Lái Thiêu')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (8, 5, N'phonenumber', N'0949287875')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (9, 5, N'email', N'tanthanh141214@gmail.com')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (10, 5, N'date', N'15-May-21 11:10:02 PM')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (11, 5, N'date_login', N'15-May-21 11:10:02 PM')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (12, 5, N'date_password', N'15-May-21 11:10:02 PM')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (13, 5, N'zalo', N'')
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (14, 5, N'sex', NULL)
INSERT [dbo].[UserMeta] ([ID], [user_id], [meta_key], [meta_value]) VALUES (1020, 5, N'fb', N'')
SET IDENTITY_INSERT [dbo].[UserMeta] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [user_login], [user_pass], [user_nicename], [user_email], [user_activation_key], [user_status]) VALUES (5, NULL, N'thanhht', N'Admin', N'admin@gmail.com', N'73f2fae8-eed8-4632-8a20-ef1597bbc306', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [FK_Collection_Product] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [FK_Collection_Product]
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [FK_Collection_Users] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [FK_Collection_Users]
GO
ALTER TABLE [dbo].[GroupRole]  WITH CHECK ADD  CONSTRAINT [FK_GroupRole_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[GroupRole] CHECK CONSTRAINT [FK_GroupRole_Roles]
GO
ALTER TABLE [dbo].[GroupRole]  WITH CHECK ADD  CONSTRAINT [FK_GroupRole_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[GroupRole] CHECK CONSTRAINT [FK_GroupRole_Users]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Product]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Terms] FOREIGN KEY([term_id])
REFERENCES [dbo].[Terms] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Terms]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Users]
GO
ALTER TABLE [dbo].[Pays]  WITH CHECK ADD  CONSTRAINT [FK_Pays_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Pays] CHECK CONSTRAINT [FK_Pays_Users]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Users]
GO
ALTER TABLE [dbo].[ProductDescription]  WITH CHECK ADD  CONSTRAINT [FK_ProductDescription_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[ProductDescription] CHECK CONSTRAINT [FK_ProductDescription_Product]
GO
ALTER TABLE [dbo].[UserMeta]  WITH CHECK ADD  CONSTRAINT [FK_UserMeta_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserMeta] CHECK CONSTRAINT [FK_UserMeta_Users]
GO
USE [master]
GO
ALTER DATABASE [EcommerceData] SET  READ_WRITE 
GO
