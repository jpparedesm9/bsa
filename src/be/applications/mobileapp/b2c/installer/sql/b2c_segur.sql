use cobis
go
--Enrolamiento
declare @w_rol tinyint,        
        @w_trn int
		
select @w_trn  = 1890023

delete from cl_ttransaccion where tn_trn_code = @w_trn
delete from ad_procedure where pd_procedure = @w_trn
delete from ad_pro_transaccion where pt_transaccion = @w_trn
delete from ad_tr_autorizada where ta_transaccion = @w_trn

insert into cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values(@w_trn,'ENROLAMIENTO B2C','ENRB2C','ENROLAMIENTO BUSSINESS TO CUSTOMER')

insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (@w_trn, 'sp_b2c_enrola', 'cob_bvirtual', 'V', getdate(), substring('sp_b2c_enrola.sp',1,14))

insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure,pt_especial)
values(18,'R',0,@w_trn,'V',getdate(),@w_trn, null)

go

--Recuperacion password
declare @w_rol tinyint,        
        @w_trn int
		
select @w_trn  = 17007
select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete from cl_ttransaccion where tn_trn_code = @w_trn
delete from ad_procedure where pd_procedure = @w_trn
delete from ad_pro_transaccion where pt_transaccion = @w_trn
delete from ad_tr_autorizada where ta_transaccion = @w_trn

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (@w_trn, 'Manage Mobile Create Password', 'MMC', '')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (@w_trn, 'sp_crear_clave', 'cob_bvirtual', 'V', getdate(), '')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure)
values (18, 'R', 0, @w_trn, 'V', getdate(), @w_trn)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (18,'R',0,17007,@w_rol,getdate(), 1, 'V',getdate())
go

--Cambio de password
declare @w_rol tinyint,        
        @w_trn int
		
select @w_trn = 17006
select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1


delete from cl_ttransaccion where tn_trn_code = @w_trn
delete from ad_procedure where pd_procedure = @w_trn
delete from ad_pro_transaccion where pt_transaccion = @w_trn
delete from ad_tr_autorizada where ta_transaccion = @w_trn

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
                     values (17006, 'Manage Mobile Password', 'MMP', '')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (17006, 'sp_administra_clave', 'cob_bvirtual', 'V', getdate(), '')

insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure,pt_especial)
values(18,'R',0,@w_trn,'V',getdate(),@w_trn, null)

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
values(18,'R',0,@w_trn,@w_rol,'01/01/2015',1,'V','01/01/2015')
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete cobis..ad_procedure where pd_procedure in (1890025) and pd_base_datos = 'cob_bvirtual'
insert into cobis..ad_procedure values (1890025,   'sp_b2c_validar_registro',  'cob_bvirtual', 'V', getdate(), 'b2c_validar.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(1890025)
insert into cobis..cl_ttransaccion values (1890025,  'VALIDACION REGISTRO B2C',  '890025', 'VALIDACION REGISTRO B2C') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (1890025)
insert into cobis..ad_pro_transaccion values (18, 'R', @w_moneda,  1890025,       'V', getdate(), 1890025,       null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (1890025)
insert into cobis..ad_tr_autorizada values (18,  'R', @w_moneda, 1890025,    @w_rol,         getdate(), 3,          'V', getdate())
go


declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete cobis..ad_procedure where pd_procedure in (1890024) and pd_base_datos = 'cob_bvirtual'
insert into cobis..ad_procedure values (1890024,'sp_b2c_registrar_celular','cob_bvirtual','V', getdate(), 'b2c_regcel.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in (1890024)
insert into cobis..cl_ttransaccion values (1890024,'REGISTRO DE NUMERO TELEFONICO PARA B2C','890024','REGISTRO DE NUMERO TELEFONICO PARA B2C') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (1890024)
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,1890024,'V', getdate(), 1890024,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (1890024)
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,1890024,@w_rol,getdate(), 3,'V', getdate())
go


--Preguntas de Verificación

use cobis
go

declare @w_transacion int,
        @w_rol     smallint,
        @w_moneda  tinyint

select @w_transacion = 1890026
		
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 
and ro_filial = 1

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and pa_producto = 'ADM'
   
delete cobis..ad_procedure where pd_procedure in (@w_transacion) and pd_base_datos = 'cob_bvirtual'
insert into cobis..ad_procedure values (@w_transacion,        'sp_b2c_generar_preguntas',            'cob_bvirtual',                    'V', getdate(), 'b2c_ingreg.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion)
insert into cobis..cl_ttransaccion values (@w_transacion,       'B2C - GENERACION DE PREGUNTAS DE VERIFICACION',                         '890026',   'B2C - GENERACION DE PREGUNTAS DE VERIFICACION') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion)
insert into cobis..ad_pro_transaccion values (18,          'R', @w_moneda,          @w_transacion,       'V', getdate(), @w_transacion,       null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion)
insert into cobis..ad_tr_autorizada values (18,          'R', @w_moneda,          @w_transacion,    @w_rol,         getdate(), 3,          'V', getdate())
go


declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_transacion int
		
select @w_transacion = 1890027

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
--Validar Respuestas

delete cobis..ad_procedure where pd_procedure in (@w_transacion ) 
insert into cobis..ad_procedure values (@w_transacion ,'sp_b2c_validar_respuestas','cob_bvirtual','V', getdate(),'b2c_valresp.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion )
insert into cobis..cl_ttransaccion values (@w_transacion ,'B2C - VALIDACION DE RESPUESTAS A PREGUNTAS DE VERIFICACION','890027','B2C - VALIDACION DE RESPUESTAS A PREGUNTAS DE VERIFICACION') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion )
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,@w_transacion ,'V', getdate(), '890027' ,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion )
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,@w_transacion ,@w_rol,getdate(), 3,'V', getdate())

go


declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_transacion int
		
select @w_transacion = 1890028

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
--Validar Respuestas

delete cobis..ad_procedure where pd_procedure in (@w_transacion ) 
insert into cobis..ad_procedure values (@w_transacion ,'sp_b2c_msg_consultar','cob_bvirtual','V', getdate(),'sp_b2c_msco.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion )
insert into cobis..cl_ttransaccion values (@w_transacion ,'B2C - CONSULTAR MENSAJES','890028','B2C - CONSULTAR MENSAJES') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion )
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,@w_transacion ,'V', getdate(), @w_transacion ,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion )
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,@w_transacion ,@w_rol,getdate(), 3,'V', getdate())

go

declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_transacion int
		
select @w_transacion = 1890029

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
--Validar Respuestas

delete cobis..ad_procedure where pd_procedure in (@w_transacion ) 
insert into cobis..ad_procedure values (@w_transacion ,'sp_b2c_msg_ejecutar','cob_bvirtual','V', getdate(),'sp_b2c_msej.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion)
insert into cobis..cl_ttransaccion values (@w_transacion ,'B2C - EJECUTAR ACCIONES MENSAJES','890029','B2C - EJECUTAR ACCIONES MENSAJES') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion )
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,@w_transacion ,'V', getdate(), @w_transacion ,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion )
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,@w_transacion ,@w_rol,getdate(), 3,'V', getdate())

go

--Bloqueo temporal
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_transacion int
		
select @w_transacion = 1890030

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete cobis..ad_procedure where pd_procedure in (@w_transacion ) 
insert into cobis..ad_procedure values (@w_transacion ,'sp_bloq_usuario','cob_bvirtual','V', getdate(),'sp_b2c_msej.sp')    

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion)
insert into cobis..cl_ttransaccion values (@w_transacion ,'B2C - BLOQUEO TEMPORAL','BLKTMP','B2C - BLOQUEO TEMPORAL') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion )
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,@w_transacion ,'V', getdate(), @w_transacion ,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion )
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,@w_transacion ,@w_rol,getdate(), 3,'V', getdate())

go

--Desbloqueo Temporal
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_transacion int, 
		@w_procedure  int
		
select @w_transacion = 1890031

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_procedure = pd_procedure from cobis..ad_procedure where pd_stored_procedure = 'sp_b2c_msg_ejecutar' 
and pd_base_datos = 'cob_bvirtual'  

delete cobis..cl_ttransaccion  where tn_trn_code in(@w_transacion)
insert into cobis..cl_ttransaccion values (@w_transacion ,'B2C - DESBLOQUEO POR CLIENTE','DBKTMP','B2C - DESBLOQUEO POR CLIENTE') 

delete cobis..ad_pro_transaccion where pt_producto = 18 and pt_moneda   = @w_moneda and pt_transaccion in (@w_transacion )
insert into cobis..ad_pro_transaccion values (18,'R', @w_moneda,@w_transacion ,'V', getdate(), @w_procedure ,null)                                                                                                                                                                                                                     

delete cobis..ad_tr_autorizada where ta_producto = 18 and ta_rol      = @w_rol and ta_moneda   = @w_moneda and ta_transaccion in (@w_transacion )
insert into cobis..ad_tr_autorizada values (18,'R', @w_moneda,@w_transacion ,@w_rol,getdate(), 3,'V', getdate())

go


use cobis
go

begin tran

go

--- TRANSACCIONES 
delete cl_ttransaccion where tn_trn_code in(1875900,1875901) 
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values (1875900, 'ADMINISTRA TOKEN','GENT','ADMINISTRA TOKEN')   

go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values (1875901, 'ADMINISTRA NOTIFICACION TOKEN','GENT','ADMINISTRA NOTIFICACION TOKEN')   


--- PROCEDIMIENTOS
delete from ad_procedure where  pd_procedure in(1875900,1875901) 
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1875900, 'sp_administra_token','cob_bvirtual', 'V', getdate(),substring('sp_administra_token.sp',1,14))   	
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1875901, 'sp_se_generar_notif','cobis', 'V', getdate(),substring('sp_se_generar_notif',1,14))   	
go

declare @w_rol smallint
select @w_rol = ro_rol
from  ad_rol
where ro_descripcion like '%ADMINISTRADOR%BRANCH%' and 	ro_filial = 1
if @@rowcount =0 
begin 
	select @w_rol = ro_rol
	from cobis..ad_rol
	where ro_descripcion like '%MENU POR PROCESOS%'
end 


declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and pa_producto = 'ADM'

if @w_moneda = null
   select @w_moneda = 0
-- SEGURIDAD
delete ad_pro_transaccion where pt_transaccion in(1875900,1875901) 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values(18,'R',@w_moneda,1875900,'V',getdate(),1875900)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values(18,'R',@w_moneda,1875901,'V',getdate(),1875901)
-- TRANSACCIONES AUTORIZADAS
delete ad_tr_autorizada where ta_transaccion in(1875900,1875901) 

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(18,'R',@w_moneda,1875900,@w_rol,getdate(),1,'V',getdate())


insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(18,'R',@w_moneda,1875901,@w_rol,getdate(),1,'V',getdate())

use cobis
go

declare @w_transaccion int = 1500 -- TRANSACCION UTILIZADA PARA EL INICIO DE SESION

if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion) begin
	delete cl_ttransaccion where tn_trn_code = @w_transaccion
	if @@ROWCOUNT != 0 begin
		print 'Se elimina la transacción existente: ' + convert(varchar, @w_transaccion)
	end
end

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico) values (1500, 'CONEXION DEL SISTEMA - LOGIN', 'STARLG')

if @@ROWCOUNT != 0 begin
	print 'Se crea la transacción: ' + convert(varchar, @w_transaccion)
end

commit tran

GO


-- Requerimiento #158566

declare 
@w_tn_trn_code        int,
@w_pd_producto        int,
@w_ro_rol             int,
@w_ta_autorizante     int,
@w_pd_procedure       int

select @w_tn_trn_code = 775074 -- Se inicializa el codigo de la transacción
select @w_pd_procedure  = 775074
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'BANCA VIRTUAL' and pd_abreviatura = 'BVI' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'ENVIO NOTIFICACION SMS ENROLAMIENTO' 
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'ENVIO NOTIFICACION SMS ENROLAMIENTO', @w_tn_trn_code, 'ENVIO NOTIFICACION SMS ENROLAMIENTO')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_notifb2c_sms' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_notifb2c_sms', 'cob_bvirtual', 'V', getdate(), 'sp_ntb2csms.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL 20 CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), @w_ta_autorizante, 'V', getdate())

GO

--===================== ONBOARDING REQUERIMIENTO 168293 ====================

---------------------------------------------------
------ CREACION CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1721,
@w_pd_procedure = 1721


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='CREACION CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CREACION CLIENTE ONBOARDING', @w_tn_trn_code, 'CREACION CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_registro_onboarding' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_registro_onboarding', 'cobis', 'V', getdate(), 'b2cregonb.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go


---------------------------------------------------
------ ACTUALIZACION CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1722,
@w_pd_procedure = 1722


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='ACTUALIZACION CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'ACTUALIZACION CLIENTE ONBOARDING', @w_tn_trn_code, 'ACTUALIZACION CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_persona', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go

---------------------------------------------------
------ CREACION DIRECCION ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1723,
@w_pd_procedure = 1723


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='CREACION DIRECCION ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CREACION DIRECCION ONBOARDING', @w_tn_trn_code, 'CREACION DIRECCION ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_direccion' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_direccion', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go

---------------------------------------------------
------ BUSCAR CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1724,
@w_pd_procedure = 1724


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='BUSCAR CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'BUSCAR CLIENTE ONBOARDING', @w_tn_trn_code, 'BUSCAR CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_persona', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go