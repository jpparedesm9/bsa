USE cob_conta
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_relofi'))
	DROP VIEW ts_relofi
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_plan_general'))
	DROP VIEW ts_plan_general
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_organizacion'))
	DROP VIEW ts_organizacion
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_oficina'))
	DROP VIEW ts_oficina
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_nivel_cuenta'))
	DROP VIEW ts_nivel_cuenta
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_nivel_area'))
	DROP VIEW ts_nivel_area
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_empresa'))
	DROP VIEW ts_empresa
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_dinamica'))
	DROP VIEW ts_dinamica
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_cuenta_proceso'))
	DROP VIEW ts_cuenta_proceso
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_cuenta_asociada'))
	DROP VIEW ts_cuenta_asociada
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_cotizacion'))
	DROP VIEW ts_cotizacion
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_corte'))
	DROP VIEW ts_corte
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_control'))
	DROP VIEW ts_control
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_concivapagado'))
	DROP VIEW ts_concivapagado
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_conciva'))
	DROP VIEW ts_conciva
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_concica'))
	DROP VIEW ts_concica
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_categoria'))
	DROP VIEW ts_categoria
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_banco'))
	DROP VIEW ts_banco
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_asoemp'))
	DROP VIEW ts_asoemp
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_area'))
	DROP VIEW ts_area
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_perfil'))
	DROP VIEW ts_perfil
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'ts_cuenta'))
	DROP VIEW ts_cuenta
GO
