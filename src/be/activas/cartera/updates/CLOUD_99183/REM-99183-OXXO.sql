
use cob_cartera
go

declare 
@w_corresponsal_id       int,
@w_cp_id                 int,
@w_ctr_id                int

----------------------------------------------------
-------   PARAMETRIZACION OXXO        --------------
----------------------------------------------------

--REGISTRO DE OXXO COMO FORMA DE PAGO (VALIDAR LOS VALORES EN ESPECIAL cp_codvalor
delete from ca_producto 
where cp_producto = 'OXXO'

insert into ca_producto 
(cp_producto, cp_descripcion, cp_categoria, cp_moneda, cp_codvalor, cp_desembolso,cp_pago,cp_atx,
cp_retencion,cp_pago_aut,cp_pcobis,cp_producto_reversa,cp_afectacion,cp_estado,cp_act_pas)
values
('OXXO', 'CORRESPONSAL OXXO', 'CORRESP', 0, 139, 'N','S','N',
0,'N',null,'OXXO','D','V','T')


if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ctr_convenio'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal_tipo_ref')) begin
   alter table ca_corresponsal_tipo_ref
   add ctr_convenio   varchar(255) null
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'co_convenio'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal')) begin
			   
   alter table ca_corresponsal
   drop column co_convenio
			   
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'cp_pie_pagina'
               AND Object_ID = Object_ID('cob_cartera..ca_pie_pagina_corresp')) begin
			   
   alter table ca_pie_pagina_corresp
   alter column cp_pie_pagina varchar(500)
			   
end

go

-------------------------------------------------------
----------               OXXO                  --------
-------------------------------------------------------
use cob_cartera
go

declare 
@w_corresponsal_id      int,
@w_cp_id                 int,
@w_ctr_id                int

select @w_corresponsal_id = co_id
from ca_corresponsal
where co_nombre = 'OXXO'

delete ca_pie_pagina_corresp where co_id = @w_corresponsal_id
delete ca_corresponsal_limites where cl_corresponsal_id = @w_corresponsal_id
delete ca_corresponsal_err where ce_corresponsal_id = @w_corresponsal_id
delete ca_corresponsal_tipo_ref where ctr_co_id = @w_corresponsal_id
delete ca_corresponsal where co_id = @w_corresponsal_id

select @w_corresponsal_id = isnull(max(co_id),0) + 1
from ca_corresponsal

if @w_corresponsal_id is not null begin
   insert into ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
   values (@w_corresponsal_id, 'OXXO', 'OXXO', 'OXXO_DBe7nWGjlw', 'cob_cartera..sp_oxxo_gen_ref', 'cob_cartera..sp_oxxo_val_ref', 'I', 20)
   
   select @w_cp_id = isnull(max(cp_id),0) +1 
   from ca_pie_pagina_corresp
   
   insert into ca_pie_pagina_corresp values 
   (@w_cp_id, 'OXXO: Horarios de atención de 8:00 a 16:30 hrs, se cobrará una comisión de $10.00 (IVA incluido) por evento. Las operaciones no podrán exceder el importe individual de $4,500.00 ni del monto acumulado diario de $9,000.00. En caso de no cumplir con tu pago, se cobrará una comisión por atraso de $200.00 IVA incluido', @w_corresponsal_id)

   select @w_ctr_id = isnull(max(ctr_id),0)
   from ca_corresponsal_tipo_ref
   
   select @w_ctr_id = @w_ctr_id +1
   insert into ca_corresponsal_tipo_ref values (@w_ctr_id,'00','GL','GARANTIA LIQUIDA', @w_corresponsal_id, null)
   select @w_ctr_id = @w_ctr_id +1
   insert into ca_corresponsal_tipo_ref values (@w_ctr_id,'01','PG','PAGO DE CREDITO GRUPAL', @w_corresponsal_id, null)
   select @w_ctr_id = @w_ctr_id +1
   insert into ca_corresponsal_tipo_ref values (@w_ctr_id,'02','CG','PAGO PARA CANCELACION DE CREDITO GRUPAL', @w_corresponsal_id, null)
   select @w_ctr_id = @w_ctr_id +1
   insert into ca_corresponsal_tipo_ref values (@w_ctr_id,'03','PI','PAGO DE CREDITO INDIVIDUAL REVOLVENTE', @w_corresponsal_id, null)
   select @w_ctr_id = @w_ctr_id +1
   insert into ca_corresponsal_tipo_ref values (@w_ctr_id,'04','CI','PAGO PARA CANCELACION DE CREDITO INDIVIDUAL REVOLVENTE', @w_corresponsal_id, null)
   
   
   insert into ca_corresponsal_limites values (@w_corresponsal_id,100,10000,'GL')
   insert into ca_corresponsal_limites values (@w_corresponsal_id,100,10000,'PG')
   insert into ca_corresponsal_limites values (@w_corresponsal_id,100,10000,'PI')
   insert into ca_corresponsal_limites values (@w_corresponsal_id,100,10000,'CI')
   insert into ca_corresponsal_limites values (@w_corresponsal_id,100,10000,'CG')
   
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70179, '13', 'EL PAGO TIENE MAS DE 60 DIAS DE ANTIGUEDAD.')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70178, '13', 'LA FECHA DE PAGO ES MAYOR A LA FECHA DE PROCESO.')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70180, '20', 'NO EXISTE EL PAGO A REVERSAR CON EL FOLIO PROPORCIONADO')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70184, '11', 'NO EXISTE TRAMITE GRUPAL EN CURSO.')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70210, '18', 'YA EXISTE UN PAGO REGISTRADO PARA EL FOLIO PROPORCIONADO')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70212, '23', 'EL TOKEN PROPORCIONADO NO ESTA REGISTRADO PARA EL CORRESPONSAL')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70213, '16', 'EL MONTO SUPERA EL LIMITE MAXIMO PERMITIDO PARA ESTE CORRESPONSAL')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70211, '25', 'REVERSA APLICADA ANTERIORMENTE')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70186, '14', 'NO EXISTE EL CREDITO RELACIONADO A LA REFERENCIA O NO ACEPTA PAGOS')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70214, '13', 'ERROR: PAGO REALIZADO FUERA DE TIEMPO (1 DIA O MENOS).')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70215, '20', 'ERROR: NO SE PUEDE REVERSAR DESDE EL SERVICIO, TRN YA APLICADA EN COBIS.')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 0, '00', 'TRANSACCION EXITOSA')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 1, '00', 'TRANSACCION EXITOSA')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70000, '17', 'ERROR AL APLICAR EL PAGO')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 80000, '20', 'REVERSA NO APLICADA')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 99, '99', 'ERROR AL CONSULTAR')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70301, '27', 'ERROR: NO EXISTE PRESTAMO GRUPAL')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70302, '27', 'ERROR: NO EXISTE PRESTAMO INDIVIDUAL')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70303, '27', 'ERROR: NO EXISTE CONFIGURACION PARA LIMITES DE PAGO')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70304, '27', 'ERROR: TOKEN NO COINCIDE')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70305, '27', 'ERROR: NO EXISTE EL CORREPONSAL PARAMETRIZADO')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70306, '27', 'ERROR: ERROR AL CONSULTAR ESTADOS DE CARTERA')
   insert into dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   values (@w_corresponsal_id, 70307, '20', 'ERROR: EXISTE MAS DE UN REGISTRO A REVERSAR CON EL FOLIO INGRESADO.') 
   
   
end

update ca_corresponsal set
co_tiempo_aplicacion_pag_rev = 5
where co_nombre = 'SANTANDER'
-------------------------------------------------------
----------          SANTANDER                  --------
-------------------------------------------------------
select @w_corresponsal_id = co_id
from ca_corresponsal
where co_nombre ='SANTANDER'

if @@rowcount > 0 begin
   update ca_corresponsal_tipo_ref set 
   ctr_convenio = 9744
   where ctr_tipo_cobis = 'PI'
   and   ctr_co_id      = @w_corresponsal_id
   
   update ca_corresponsal_tipo_ref set 
   ctr_convenio = 9744
   where ctr_tipo_cobis = 'PG'
   and   ctr_co_id      = @w_corresponsal_id
   
   update ca_corresponsal_tipo_ref set 
   ctr_convenio = 9742
   where ctr_tipo_cobis = 'GL'
   and   ctr_co_id      = @w_corresponsal_id
   
   update ca_corresponsal_tipo_ref set 
   ctr_convenio = 9742
   where ctr_tipo_cobis = 'CI'
   and   ctr_co_id      = @w_corresponsal_id
   
   update ca_corresponsal_tipo_ref set 
   ctr_convenio = 9742
   where ctr_tipo_cobis = 'CG'
   and   ctr_co_id      = @w_corresponsal_id
end
go

----------------------------------------------------------
-------------    SERVICIOS    ----------------------------
----------------------------------------------------------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.ReadPayments'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.ReadPayments','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','readPayments','obtiene el detalle de pago por corresponsal',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.ReadPayments' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('BankingCorrespondent.BankingCorrespondentPayment.ReadPayments', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--PAGOS
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.Pay'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.Pay','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','pay','registra el pago del corresponsal en la tabla de tanqueo',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.Pay' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('BankingCorrespondent.BankingCorrespondentPayment.Pay', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--REVERSA
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.Reverse'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.Reverse','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','reverse','registra la reversa del pago del corresponsal en la tabla de tanqueo',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.Reverse' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values(
'BankingCorrespondent.BankingCorrespondentPayment.Reverse', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--PARAMETROS
delete cobis..cl_parametro WHERE pa_nemonico in ('HUDDD', 'IDOXXO')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HORA ULTIMA DISPERSION DEL DIA', 'HUDDD', 'C', '17:00', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ID BANCO EN OXXO', 'IDOXXO', 'C', '49', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
--ERRORES
delete cobis..cl_errores where numero in (70301, 70302, 70303,70304, 70305, 70306, 70307)
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70301, 0, 'ERROR: NO EXISTE PRESTAMO GRUPAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70302, 0, 'ERROR: NO EXISTE PRESTAMO INDIVIDUAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70303, 0, 'ERROR: NO EXISTE CONFIGURACION PARA LIMITES DE PAGO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70304, 0, 'ERROR: TOKEN NO COINCIDE')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70305, 0, 'ERROR: NO EXISTE EL CORREPONSAL PARAMETRIZADO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70306, 0, 'ERROR: ERROR AL CONSULTAR ESTADOS DE CARTERA')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70307, 0, 'ERROR: EXISTE MAS DE UN REGISTRO A REVERSAR CON EL FOLIO INGRESADO.')


go


----------------------------------------------------------
-- PARAMETRIZACION OFICINAS E INSTITUCIONES CODIGO DE BARRAS    
----------------------------------------------------------
use cobis
go


declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

SELECT @w_producto = pd_abreviatura FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

delete cl_catalogo WHERE tabla NOT IN (SELECT codigo FROM cl_tabla)
DELETE cl_catalogo_pro WHERE cp_tabla NOT IN (SELECT codigo FROM cl_tabla)
delete cl_catalogo where tabla in (select codigo from cl_tabla WHERE tabla in ('cl_institution_barcodes','cl_offices_barcodes'))
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla WHERE tabla in ('cl_institution_barcodes','cl_offices_barcodes'))
delete cl_tabla where tabla in ('cl_institution_barcodes','cl_offices_barcodes')

select @w_nom_tabla = 'cl_institution_barcodes'
select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'Instituciones para codigo de barras')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'1','OXXO','V')


select @w_nom_tabla = 'cl_offices_barcodes'
select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'Oficinas para codigo de barras')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado)  
select  @w_id_tabla as tabla,codigo,valor,estado from cl_catalogo where tabla in (9) 

GO

