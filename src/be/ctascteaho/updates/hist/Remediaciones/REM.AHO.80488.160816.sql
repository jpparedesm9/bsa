/******************************************************/
/*Fecha Creación del Script: 2016/08/16               */
/*Impresion de contratos                              */
/*Modulo : AHORROS                                    */
/*Creado por : Douglas Fu Cevallos                    */
/******************************************************/

use cobis
go

--Actualizacion de catalogo re_plantillas

--pe_catlgo.sql
declare @w_codigo smallint

print 'Actualizando catalogo re_plantillas'

select @w_codigo = codigo from cobis..cl_tabla where tabla = 're_plantillas'
delete cobis..cl_catalogo where tabla = @w_codigo


INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo,'CONAHO.RPT','CONTRATO AHORROS - PER NAT'     ,'V',NULL,NULL,NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo,'CERASA.RPT','CERTIFICADO APORTACION(ANVERSO)','V',NULL,NULL,NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo,'CERASR.RPT','CERTIFICADO APORTACION(REVERSO)','V',NULL,NULL,NULL)
go


declare @w_rol      int,
        @w_moneda   tinyint

select @w_rol = ro_rol
from   ad_rol
where  ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from   cl_parametro
where  pa_nemonico = 'CMNAC' and pa_producto = 'ADM'


--ah_proc.sql
if exists (SELECT * FROM cobis..ad_procedure WHERE pd_procedure = 502)
begin
    DELETE FROM ad_procedure WHERE pd_procedure = 502
end

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (502, 'sp_cons_datos_cuenta', 'cob_ahorros', 'V', getdate(), 'ahcondatcta.sp')

--ah_tran.sql
if exists (SELECT * FROM cobis..cl_ttransaccion WHERE tn_trn_code = 538)
begin
    delete FROM cobis..cl_ttransaccion WHERE tn_trn_code = 538
end

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (538, 'CONSULTA DE DATOS DE CUENTAS PARA CONTRATOS', '538', 'CONSULTA DE DATOS DE CUENTAS PARA CONTRATOS')

--ah_protran.sql
if exists (SELECT * FROM cobis..ad_pro_transaccion WHERE pt_producto = 4 and pt_tipo = 'R' and pt_moneda = @w_moneda and pt_transaccion = 538)
begin
    delete from cobis..ad_pro_transaccion WHERE pt_producto = 4 and pt_tipo = 'R' and pt_moneda = @w_moneda and pt_transaccion = 538
end

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', @w_moneda, 538, 'V', getdate(), 502, NULL)

--ah_traut.sql
if exists (SELECT * FROM cobis..ad_tr_autorizada WHERE ta_producto = 4 and ta_tipo = 'R' and ta_moneda = @w_moneda and ta_transaccion = 538 and ta_rol = @w_rol)
begin
    DELETE FROM cobis..ad_tr_autorizada WHERE ta_producto = 4 and ta_tipo = 'R' and ta_moneda = @w_moneda and ta_transaccion = 538 and ta_rol = @w_rol 
end

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 538, @w_rol, getdate(), 1, 'V', getdate())

go

