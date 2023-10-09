/************************************************************************/
/*   Stored procedure:     sp_carmigc                                   */
/*   Base de datos:        cob_conta                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*     Consolidar todos los procesos que se realizan en la migracion    */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_carmigc')
   drop proc sp_carmigc
go
 
CREATE proc [dbo].[sp_carmigc]
(
   @i_param1   varchar(2)
)
as 
declare
@w_contador           int,
@w_interfaz           varchar(25),
@i_codinterfaz        varchar(2)

select @i_codinterfaz = @i_param1

/* LIMPIAR TABLAS */      
truncate table cob_conta..cb_estado_mig
truncate table cob_conta..cb_convivencia_tmp
truncate table cob_conta..cb_log_errores_mig
truncate table cob_conta..cb_scomprobante_mig
truncate table cob_conta..cb_sasiento_mig
delete from cob_conta..cb_registro

select @w_contador =  count(1)
from cob_externos..ex_convivencia_tmp

if @w_contador = 0 begin
   print 'No existen Registros a PROCESAR'
   return  6011592    ---No existe registro
end

select @w_interfaz = C.valor
from cobis..cl_tabla T,
     cobis..cl_catalogo C
where T.tabla = 'cb_interfaz'
and   C.tabla = T.codigo
and   C.codigo = @i_codinterfaz

begin tran

/*INSERTA EN CB_CONVIVENCIA_TMP*/
insert into cob_conta..cb_convivencia_tmp
select ct_comprobante,   ct_empresa,      ct_fecha_tran,
       ct_oficina_orig,  ct_area_orig,    ct_descripcion,     
       ct_automatico,    ct_estado,       ct_asiento,
       ct_cuenta,        ct_oficina_dest, ct_area_dest,
       ct_credito,       ct_debito,       ct_concepto,     
       ct_tipo_doc,      ct_moneda,       ct_usuario_modulo,     
       ct_credito_me,    ct_debito_me,    ct_cotizacion,
       ct_tipo_tran,     ct_tipo,         ct_identifica,     
       ct_concepto_imp,  ct_base_imp,     ct_documento,
       ct_oper_banco,    ct_cheque,       ct_origen_mvto
from cob_externos..ex_convivencia_tmp
where ct_usuario_modulo like '%' + @w_interfaz + '%'

if @@error <> 0 begin
   rollback tran
   print 'Error en la insercion de Registros en la tabla CB_CONVIVENCIA_TMP'
   return 601161    ---Error en insercion de registro
end

/* BORRADO DE INFORMACION */   
delete cob_externos..ex_convivencia_tmp
where ct_usuario_modulo = @w_interfaz

if @@error <> 0 begin
   rollback tran
   print 'Error en la borrado de Registros de la tabla ex_convivencia_tmp'
   return 601162    ---Error en borrado de registro
end

commit tran

return 0

go




