USE cob_credito
GO

IF OBJECT_ID ('dbo.tgd_cr_pa_pregunta_mir') IS NOT NULL
	DROP TRIGGER dbo.tgd_cr_pa_pregunta_mir
GO

IF OBJECT_ID ('dbo.tgd_cr_pa_pregunta_mir_opc') IS NOT NULL
	DROP TRIGGER dbo.tgd_cr_pa_pregunta_mir_opc
GO

IF OBJECT_ID ('dbo.tgd_cr_planes') IS NOT NULL
	DROP TRIGGER dbo.tgd_cr_planes
GO

IF OBJECT_ID ('dbo.tgd_cr_seguro_parentesco') IS NOT NULL
	DROP TRIGGER dbo.tgd_cr_seguro_parentesco
GO

IF OBJECT_ID ('dbo.tgd_cr_seguro_plan') IS NOT NULL
	DROP TRIGGER dbo.tgd_cr_seguro_plan
GO

IF OBJECT_ID ('dbo.tgu_cr_pa_pregunta_mir') IS NOT NULL
	DROP TRIGGER dbo.tgu_cr_pa_pregunta_mir
GO

IF OBJECT_ID ('dbo.tgu_cr_pa_pregunta_mir_opc') IS NOT NULL
	DROP TRIGGER dbo.tgu_cr_pa_pregunta_mir_opc
GO

IF OBJECT_ID ('dbo.tgu_cr_planes') IS NOT NULL
	DROP TRIGGER dbo.tgu_cr_planes
GO

IF OBJECT_ID ('dbo.tgu_cr_seguro_parentesco') IS NOT NULL
	DROP TRIGGER dbo.tgu_cr_seguro_parentesco
GO

IF OBJECT_ID ('dbo.tgu_cr_seguro_plan') IS NOT NULL
	DROP TRIGGER dbo.tgu_cr_seguro_plan
GO

IF OBJECT_ID ('tgu_ca_seguro_externo','TR') IS NOT NULL
   drop trigger tgu_ca_seguro_externo
go

CREATE trigger [dbo].[tgd_cr_pa_pregunta_mir]
on [dbo].[cr_pa_pregunta_mir]
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
    SELECT 11,
           'cr_mirpr',  
		   convert(varchar, deleted.pr_pregunta),
		   deleted.pr_texto,
           deleted.pr_estado,
		   'cr_mirpr',
		   @w_us_fecha_ult_mod
      FROM deleted

end


GO

CREATE trigger [dbo].[tgd_cr_pa_pregunta_mir_opc]
on [dbo].[cr_pa_pregunta_mir]
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
    SELECT 11,
           'cr_mirop',  
		   convert(varchar, deleted.pr_pregunta),
		   deleted.pr_texto,
           deleted.pr_estado,
		   'cr_mirop',
		   @w_us_fecha_ult_mod
      FROM deleted

end


GO

CREATE trigger [dbo].[tgd_cr_planes]
on [dbo].[cr_planes]
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
    SELECT 11,
           'cr_planes',  
		   convert(varchar, deleted.pl_codigo),
		   deleted.pl_descripcion,
           deleted.pl_estado,
		   'cr_mspla',
		   @w_us_fecha_ult_mod
      FROM deleted

end


GO

CREATE trigger [dbo].[tgd_cr_seguro_parentesco]
on [dbo].[cr_seguro_parentesco]
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
    SELECT 12,
           'cr_seguro_parentesco',  
		   convert(varchar, deleted.sp_codigo),
		   deleted.sp_parentesco,
           deleted.sp_estado,
		   'cr_separ',
		   @w_us_fecha_ult_mod
      FROM deleted

end


GO

CREATE trigger [dbo].[tgd_cr_seguro_plan]
on [dbo].[cr_seguro_plan]
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
    SELECT 13,
           'cr_seguro_plan',  
		   convert(varchar, deleted.sp_codigo),
		   deleted.sp_plan,
           deleted.sp_estado,
		   'cr_segpl',
		   @w_us_fecha_ult_mod
      FROM deleted

end


GO

CREATE trigger [dbo].[tgu_cr_pa_pregunta_mir]
on [dbo].[cr_pa_pregunta_mir]
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
    SELECT 11,
           'cr_mirpr',  
		   convert(varchar, inserted.pr_pregunta),
		   inserted.pr_texto,
           inserted.pr_estado,
		   'cr_mirpr',
		   @w_us_fecha_ult_mod
      FROM inserted

end


GO

CREATE trigger [dbo].[tgu_cr_pa_pregunta_mir_opc]
on [dbo].[cr_pa_pregunta_mir]
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
    SELECT 11,
           'cr_mirop',  
		   convert(varchar, inserted.pr_pregunta),
		   inserted.pr_texto,
           inserted.pr_estado,
		   'cr_mirop',
		   @w_us_fecha_ult_mod
      FROM inserted

end


GO

CREATE trigger [dbo].[tgu_cr_planes]
on [dbo].[cr_planes]
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
    SELECT 11,
           'cr_planes',  
		   convert(varchar, inserted.pl_codigo),
		   inserted.pl_descripcion,
           inserted.pl_estado,
		   'cr_mspla',
		   @w_us_fecha_ult_mod
      FROM inserted

end


GO

CREATE trigger [dbo].[tgu_cr_seguro_parentesco]
on [dbo].[cr_seguro_parentesco]
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
    SELECT 12,
           'cr_seguro_parentesco',  
		   convert(varchar, inserted.sp_codigo),
		   inserted.sp_parentesco,
           inserted.sp_estado,
		   'cr_separ',
		   @w_us_fecha_ult_mod
      FROM inserted

end


GO

CREATE trigger [dbo].[tgu_cr_seguro_plan]
on [dbo].[cr_seguro_plan]
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
    SELECT 13,
           'cr_seguro_plan',  
		   convert(varchar, inserted.sp_codigo),
		   inserted.sp_plan,
           inserted.sp_estado,
		   'cr_segpl',
		   @w_us_fecha_ult_mod
      FROM inserted

end


GO


---------------------------------------
----- TRIGGER SEGUROS EXTERNOS---------
---------------------------------------

create trigger tgu_ca_seguro_externo
on  ca_seguro_externo
after update, insert, delete
as
begin

   DECLARE @w_operacion varchar(7) 
   
   select @w_operacion = case when exists (select * from inserted) and exists(select * from deleted) 
                             THEN 'U'
                         when exists(select * from inserted) 
                             THEN 'I'
                         when exists(select * from deleted)
                             THEN 'D'
                         else 
                             NULL --Unknown
                         end
	
   if @w_operacion = 'I' or @w_operacion = 'U' begin 
   
      insert into cob_cartera_his..ca_seguro_externo_his
      (seh_operacion,     seh_fecha,             seh_usuario,
       seh_terminal,      seh_banco,             seh_cliente,          
      seh_fecha_ini,     seh_fecha_ult_intento,  seh_monto,            
      seh_estado,        seh_fecha_reporte,      seh_tramite,          
      seh_grupo,         seh_monto_pagado,       seh_monto_devuelto,   
      seh_forma_pago,    seh_tipo_seguro,        seh_monto_basico)   
       select 
	  @w_operacion,      getdate(),              se_usuario,
      se_terminal,       se_banco,               se_cliente,          
      se_fecha_ini,      se_fecha_ult_intento,   se_monto,            
      se_estado,         se_fecha_reporte,       se_tramite,          
      se_grupo,          se_monto_pagado,        se_monto_devuelto,   
      se_forma_pago,     se_tipo_seguro,         se_monto_basico
      from inserted 
	  
   end else if @w_operacion = 'D' begin
   
      insert into cob_cartera_his..ca_seguro_externo_his
      (seh_operacion,    seh_fecha,              seh_usuario,
       seh_terminal,     seh_banco,              seh_cliente,          
      seh_fecha_ini,     seh_fecha_ult_intento,  seh_monto,            
      seh_estado,        seh_fecha_reporte,      seh_tramite,          
      seh_grupo,         seh_monto_pagado,       seh_monto_devuelto,   
      seh_forma_pago,    seh_tipo_seguro,        seh_monto_basico)   
       select 
	  @w_operacion,      getdate(),              se_usuario,
      se_terminal,       se_banco,               se_cliente,          
      se_fecha_ini,      se_fecha_ult_intento,   se_monto,            
      se_estado,         se_fecha_reporte,       se_tramite,          
      se_grupo,          se_monto_pagado,        se_monto_devuelto,   
      se_forma_pago,     se_tipo_seguro,         se_monto_basico
      from deleted 
   
   end
end

go