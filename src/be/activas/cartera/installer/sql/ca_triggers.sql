USE cob_cartera
GO

IF OBJECT_ID ('dbo.tgd_ca_default_toperacion') IS NOT NULL
	DROP TRIGGER dbo.tgd_ca_default_toperacion
GO

CREATE trigger [dbo].[tgd_ca_default_toperacion]
on [dbo].[ca_default_toperacion]
for delete
as
begin
declare
@w_us_fecha_ult_mod    datetime

	-- Fecha de Proceso
    SELECT @w_us_fecha_ult_mod = fp_fecha
      FROM cobis..ba_fecha_proceso

    -- Rastros de catalogos utilizados por la PDA
    INSERT INTO cobis..ad_rastro_catalogo (
			rc_codigo_tabla,
			rc_tabla,
			rc_codigo,
			rc_valor,
			rc_estado,
		    rc_tabla_dbf,
			rc_fecha_ult_mod   )
    SELECT 2,
           'ca_default_toperacion',  
		   deleted.dt_toperacion,
		   deleted.dt_toperacion,
           deleted.dt_estado,
		   'ca_dtope',
		   @w_us_fecha_ult_mod
      FROM deleted

end

GO

IF OBJECT_ID ('dbo.tgu_ca_default_toperacion') IS NOT NULL
	DROP TRIGGER dbo.tgu_ca_default_toperacion
GO

CREATE trigger [dbo].[tgu_ca_default_toperacion]
on [dbo].[ca_default_toperacion]
for update, insert
as
begin
declare
@w_us_fecha_ult_mod    datetime

	-- Fecha de Proceso
    SELECT @w_us_fecha_ult_mod = fp_fecha
      FROM cobis..ba_fecha_proceso

    -- Rastros de catalogos utilizados por la PDA
    INSERT INTO cobis..ad_rastro_catalogo (
			rc_codigo_tabla,
			rc_tabla,
			rc_codigo,
			rc_valor,
			rc_estado,
			rc_tabla_dbf,
			rc_fecha_ult_mod   )
    SELECT 2,
           'ca_default_toperacion',  
		   inserted.dt_toperacion,
		   inserted.dt_toperacion,
           inserted.dt_estado,
		   'ca_dtope',
		   @w_us_fecha_ult_mod
      FROM inserted

end

GO

IF OBJECT_ID ('tgi_ca_defaulttoper') IS NOT NULL
	DROP TRIGGER tgi_ca_defaulttoper
GO

CREATE trigger tgi_ca_defaulttoper
on ca_default_toperacion
after insert, update
as
begin

    update ca_default_toperacion
    set dt_tipo_redondeo = NULL
    from ca_default_toperacion d  inner join Inserted i 
	    on  d.dt_toperacion    = i.dt_toperacion
	    and d.dt_moneda        = i.dt_moneda
	    and i.dt_tipo_redondeo = 99
	
end
GO

--Triggers para manejar valores por defecto del APF
--INICIO
IF OBJECT_ID ('tgi_ca_rubro') IS NOT NULL
	DROP TRIGGER tgi_ca_rubro
GO

CREATE trigger tgi_ca_rubro
on ca_rubro
for insert, update
as
begin

	--ru_saldo_por_desem
	update ca_rubro 
    set ru_monto_aprobado = 'N'
    from ca_rubro r  inner join Inserted i 
	    on  r.ru_toperacion = i.ru_toperacion
	    and r.ru_moneda     = i.ru_moneda
	    and r.ru_concepto   = i.ru_concepto
	    and i.ru_monto_aprobado   is NULL
		
    --ru_intermediacion, ru_redescuento
	update ca_rubro 
    set ru_intermediacion = 0,
	    ru_redescuento    = 0
    from ca_rubro r  inner join Inserted i 
	    on  r.ru_toperacion = i.ru_toperacion
	    and r.ru_moneda     = i.ru_moneda
	    and r.ru_concepto   = i.ru_concepto
        
end

GO

