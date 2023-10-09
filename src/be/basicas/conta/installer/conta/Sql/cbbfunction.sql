USE [cob_conta]
GO
/****** Object:  UserDefinedFunction [dbo].[cp_descripcion]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cp_descripcion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[cp_descripcion]
GO
/****** Object:  UserDefinedFunction [dbo].[funct_ente]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funct_ente]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[funct_ente]
GO
/****** Object:  UserDefinedFunction [dbo].[funct_procta]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funct_procta]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[funct_procta]
GO
/****** Object:  UserDefinedFunction [dbo].[funt_count_comp]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funt_count_comp]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[funt_count_comp]
GO
/****** Object:  UserDefinedFunction [dbo].[funt_sum_cred]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funt_sum_cred]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[funt_sum_cred]
GO
/****** Object:  UserDefinedFunction [dbo].[funt_sum_deb]    Script Date: 03/14/2016 08:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funt_sum_deb]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[funt_sum_deb]
GO
