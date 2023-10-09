/*************************************************/
---No Bug: AHO-H80489
---Título de la Historia: Reg. Detalle cheque
---Fecha: 15/08/2016
--Descripción del la Historia:  Registro de detalle de cheque
--Descripción de la Solución:   Se registran catalogos, errores, autorizaciones y se crean objectos necesarios para la funcionalidad
--Autor: Tania Baidal
/*************************************************/

use cobis
go

--Remesas/BackEnd/sql/re_catlgo.sql, Dependencias/sql/cc_catlgo.sql 

delete cl_catalogo_pro from cl_tabla
where  cl_tabla.tabla in ('re_origen_cheque', 'cc_tipos_cheque')
  and  codigo = cp_tabla
  
delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('re_origen_cheque', 'cc_tipos_cheque')
  and  cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where  cl_tabla.tabla in ('re_origen_cheque', 'cc_tipos_cheque')
go

  
declare @w_codigo smallint
select @w_codigo = max(codigo) + 1
from cl_tabla

print 'Tipos de cheques'
insert into cl_tabla values (@w_codigo, 're_origen_cheque', 'Tipos de cheques')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '0', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '1', 'CHEQUES NORMALES - WACHOVIA BANK', 'E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2', 'CKS EXT VEINTICINCO DIAS', 'E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '3', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '5', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '7', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '10', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '15', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '25', 'CHEQUES EXTRANJEROS', 'V')

select @w_codigo = @w_codigo + 1
print 'cc_tipos_cheque'
insert into cl_tabla (codigo,tabla,descripcion) values (@w_codigo,'cc_tipos_cheque','Tipos de Cheque')
insert into cobis..cl_catalogo_pro values('CTE', @w_codigo)
insert into cobis..cl_catalogo_pro values('AHO', @w_codigo)
insert into cobis..cl_catalogo_pro values('REM', @w_codigo)
insert into cobis..cl_catalogo (tabla,codigo,valor,estado) values(@w_codigo, '1', 'Cheque Local', 'V')
insert into cobis..cl_catalogo (tabla,codigo,valor,estado) values(@w_codigo, '2', 'Cheque Extranjero', 'V')
insert into cobis..cl_catalogo (tabla,codigo,valor,estado) values(@w_codigo, '3', 'Cheque Propio', 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'
go


--Parametros

--Dependencias/sql/cc_param.sql
print 'Parametros Generales de Cuentas Corrientes'
go
delete cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'DIRE'
go

insert into cl_parametro values('DIAS DE DIFERIDO DE CHEQUES LOCALES', 'DIRE','T',NULL,2,NULL,NULL,NULL,NULL,NULL,'CTE')
go

print 'Parametros Generales de Cuentas Corrientes'
go
delete cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'DVCH'
go

insert into cl_parametro values('DIAS DE VIGENCIA DE UN CHEQUE','DVCH','I',NULL,NULL,NULL,365,NULL,NULL,NULL,'CTE')
go


print 'Parametros Generales de Cuentas Corrientes'
go
delete cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'DFMCH'
go

insert into cl_parametro values('DIAS PARA LA FECHA MAXIMA DE UN CHEQUE','DFMCH','I',NULL,NULL,NULL,60,NULL,NULL,NULL,'CTE')
go


use cob_remesas
go
--Remesas\BackEnd\sql\re_dropt.sql
print 're_detalle_cheque'
if exists (select 1 from sysobjects where name = 're_detalle_cheque' and type = 'U')
   drop table re_detalle_cheque
go

--Remesas\BackEnd\sql\re_table.sql
print 're_detalle_cheque'
create table re_detalle_cheque
       (dc_filial       tinyint      not null,
        dc_oficina      smallint     not null,
        dc_fecha        date         not null,
        dc_fecha_efe    date         null,
        dc_id           smallint     null,
        dc_trn          smallint     null,
        dc_numctrl      int          null,
        dc_secuencial   smallint     not null,
        dc_ssn          int          null,
        dc_ssn_branch   int          null,
        dc_cta_banco    cuenta       null,
        dc_producto     tinyint      null,
        dc_tipo         catalogo     null,
        dc_tipo_chq     catalogo     null,
        dc_co_banco     smallint     null,
        dc_no_banco     varchar(50)  null,
        dc_cta_cheque   varchar(50)  null,
        dc_num_cheque   int          null,
        dc_valor        money        null,
        dc_moneda       tinyint      null,
        dc_fechaemision date         null,
        dc_estado       char(1)      null,
        dc_user         login        null,
        dc_hora         datetime     null,
		dc_detalle      varchar(128) null,		
		dc_factor           float    null,
        dc_cotizacion       float    null,
        dc_valor_convertido   money  null,
        dc_mon_destino      tinyint  null
		
		)
go

--Remesas\BackEnd\sql\re_dropf.sql
print 'i_bco_cta_chq'
if exists (select 1 from sysindexes where name = 'i_bco_cta_chq')
   drop index re_detalle_cheque.i_bco_cta_chq
go

print 'i_ofi_fech_pro_bco_cta'
if exists (select 1 from sysindexes where name = 'i_ofi_fech_pro_bco_cta')
   drop index re_detalle_cheque.i_ofi_fech_pro_bco_cta
go

--Remesas\BackEnd\sql\re_fkey.sql
print 'i_bco_cta_chq'
create nonclustered index i_bco_cta_chq on re_detalle_cheque (dc_co_banco, dc_cta_cheque, dc_num_cheque)
go

print 'i_ofi_fech_pro_bco_cta'
create nonclustered index i_ofi_fech_pro_bco_cta on re_detalle_cheque (dc_oficina, dc_fecha_efe, dc_producto, dc_cta_banco)
go



use cob_cuentas
go
--Dependencias/sql/cc_table.sql
print 'TABLA ====> cc_retencion_locales_hsbc'
if exists(select 1 from sysobjects where name = 'cc_retencion_locales_hsbc')
   drop table cc_retencion_locales_hsbc
go

create table cc_retencion_locales_hsbc
(

rl_filial      tinyint         NOT NULL,
rl_agencia     smallint        NOT NULL, 
rl_region      smallint        NOT NULL,
rl_prod_banc   smallint        NOT NULL,
rl_tipo_cheque char(1)         NOT NULL,          
rl_dias        tinyint         NOT NULL, 
rl_hora_inicio datetime        NULL, 
rl_hora_fin    datetime        NULL
)
go

if exists (select * from sysindexes
            where name = 'cc_retencion_locales_hsbc_Key')
   drop index cc_retencion_locales_hsbc.cc_retencion_locales_hsbc_Key
go

/*cc_retencion_locales_hsbc*/
print 'cc_retencion_locales_hsbc'
create unique clustered index cc_retencion_locales_hsbc_Key on cc_retencion_locales_hsbc (rl_filial, rl_agencia, rl_region, rl_prod_banc, rl_tipo_cheque)
go

------------------------------------------------------------------------
use cobis
go

declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 3,
	   @w_transaccion = 18,
	   @w_descripcion = 'CONSULTA DE BANCO',
	   @w_nemonico    = 'COBA',
	   @w_desc_larga  = 'CONSULTA DE BANCO VIA F5',
	   @w_procedure   = 011,
	   @w_base        = 'cob_cuentas',
	   @w_nombresp    = 'sp_banco',
	   @w_filesp      = 'banco.sp'


--Dependencias/sql/cc_proc.sql
if exists (SELECT * FROM cobis..ad_procedure WHERE pd_procedure = @w_procedure)
begin
       DELETE FROM ad_procedure WHERE pd_procedure = @w_procedure
end

insert into cobis..ad_procedure values(@w_procedure,@w_nombresp,@w_base,'V',getdate(),@w_filesp)

--Dependencias/sql/cc_tran.sql
if exists (SELECT * FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion)
begin
       delete FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion
end


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)


--Dependencias/sql/cc_protran.sql
if exists (SELECT * FROM cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion  and pt_moneda = @w_moneda)
begin
delete from cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion and pt_moneda = @w_moneda
end

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)

--Dependencias/sql/cc_traut.sql
if exists (SELECT * FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda)
begin
    DELETE FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda
end

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
GO


declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 3,
	   @w_transaccion = 639,
	   @w_descripcion = 'REGISTRO DE CHEQUE',
	   @w_nemonico    = 'RECH',
	   @w_desc_larga  = 'REGISTRO DE CHEQUE EN LA TABLA DEFINITIVA',
	   @w_procedure   = 482,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_detallecheque',
	   @w_filesp      = 'detcheq.sp'

--Dependencias/sql/cc_proc.sql
if exists (SELECT * FROM cobis..ad_procedure WHERE pd_procedure = @w_procedure)
begin
       DELETE FROM ad_procedure WHERE pd_procedure = @w_procedure
end

insert into cobis..ad_procedure values(@w_procedure,@w_nombresp,@w_base,'V',getdate(),@w_filesp)

--Dependencias/sql/cc_tran.sql
if exists (SELECT * FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion)
begin
       delete FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion
end


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)


--Dependencias/sql/cc_protran.sql
if exists (SELECT * FROM cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion  and pt_moneda = @w_moneda)
begin
delete from cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion and pt_moneda = @w_moneda
end

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)

--Dependencias/sql/cc_traut.sql
if exists (SELECT * FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda)
begin
    DELETE FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda
end

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
GO

--Remesas\BackEnd\sql\re_error
delete from cl_errores
where numero = 357586

insert into cobis..cl_errores
values (357586, 0, 'Tipo de cheque enviado no es local')
go