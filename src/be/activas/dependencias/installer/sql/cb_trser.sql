USE cob_conta
GO

IF OBJECT_ID ('dbo.cb_vcotizacion') IS NOT NULL
	DROP VIEW dbo.cb_vcotizacion
GO

create view cb_vcotizacion 
     ( cv_fecha,cv_moneda,cv_valor) 
    as
select ct_fecha,ct_moneda,ct_valor
  from cb_cotizacion

GO
