/*************************************************/
---No Bug: 73517
---Título de la Historia: Consultas de Productos Menores de Edad
---Fecha: 22/07/2016
--Descripción del la Historia: Consultas para las cuentas del producto bancario menor de edad
--Descripción de la Solución: Se crea el parametro para Proximidad de Mayoria de Edad
--Autor: Walther Toledo
/*************************************************/
--------------Ahorros\Backend\sql\ah_param.sql
use cobis
go
delete from cl_parametro where pa_nemonico = 'PRXMYE' and pa_producto='AHO'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_int, pa_producto)
VALUES ('PROXIMIDAD MAYORIA DE EDAD', 'PRXMYE', 'I',  6,  'AHO')
go
print 'Creacion de Parametro PRXMYE --> OK'
go
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------------re_seqnos.sql
use cobis
go
delete cl_seqnos where bdatos = 'cob_remesas' and tabla = 're_valor_udis'
insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_valor_udis', 0, 'vu_id')
print 'Creacion del secuencial de la Tabla re_valor_udis --> OK'
go

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------------re_table.sql,re_dropt.sql
use cob_remesas
go
if exists (select name from sysobjects where name = 're_valor_udis')
    drop table re_valor_udis
go
CREATE TABLE re_valor_udis
( 
    vu_id       int     not null,
    vu_valor    MONEY   not null,
    vu_fec_act  datetime not null
)
go
print 'Creacion de la Tabla re_valor_udis --> OK'
go

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------------No va en el instalador, ya que es solo para realizar pruebas
use cobis
go
DECLARE @w_siguiente INT

SELECT @w_siguiente = siguiente 
  from cobis..cl_seqnos
 WHERE tabla = 're_valor_udis'
  AND bdatos = 'cob_remesas'

INSERT INTO cob_remesas..re_valor_udis(vu_id, vu_valor, vu_fec_act)
VALUES(@w_siguiente, 0.25,getdate())

update cobis..cl_seqnos 
   SET siguiente = @w_siguiente + 1
 WHERE tabla = 're_valor_udis'
   AND bdatos = 'cob_remesas'
go
print 'Insercion de Valor Actual del UDI en re_valor_udis --> OK'
go

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
use cobis
go
------------------------------------------------------------------------
declare 
     @w_rol         int,
     @w_moneda      tinyint,
     @w_producto    tinyint,
     @w_trx         int,
     @w_proc         int

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
select @w_trx       = 537, -- Id de la trx
       @w_proc      = 501,  -- prod asociado
       @w_producto  = 4

------------------CL_TTRANSACCION----------------------------
delete from cl_ttransaccion where tn_trn_code = @w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA PRODUCTO MENORES DE EDAD', 'PRMNED', 'CONSULTA PRODUCTO MENORES DE EDAD')

-------------------AD_PRO_TRANSACCION----------------------------
DELETE FROM ad_pro_transaccion where pt_transaccion=@w_trx and pt_producto=@w_producto and pt_procedure=@w_proc and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)

----------------------AD_PROCEDURE------------------------------
DELETE FROM ad_procedure WHERE pd_procedure = @w_proc
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_proc, 'sp_valida_prod_menoredad', 'cob_ahorros', 'V',  getdate(), 'valpromedad.sp')

------------------AD_TR_AUTORIZADA----------------------------
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (@w_trx) and ta_moneda=@w_moneda
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())

GO