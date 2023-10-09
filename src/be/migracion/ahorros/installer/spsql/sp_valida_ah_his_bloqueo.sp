/***********************************************************************/
/*      Archivo:                        sp_valida_ah_his_bloqueo.sp    */
/*      Stored procedure:               sp_valida_ah_his_bloqueo       */
/*      Base de Datos:                  cob_pasivas_mig                */
/*      Producto:                       Cuentas                        */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      "MACOSA",representantes exclusivos para el Ecuador de la       */
/*      AT&T                                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier autorizacion o agregado hecho por alguno de sus      */
/*      usuario sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante             */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza la validacion de las tabla ah_his_bloqueo para la migracion*/
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ah_his_bloqueo')
   drop proc sp_valida_ah_his_bloqueo
go

create proc sp_valida_ah_his_bloqueo(
   @i_clave_i           int          = null,  
   @i_clave_f           int          = null
)
as
set nocount on 

declare
   @w_sp_name            varchar(30),
   @w_tabla              varchar(30),
   @w_nomcolumna         varchar(30),
   @w_conteo             int,
   @w_fecha_proceso      datetime
   

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------


select @w_sp_name  = 'sp_valida_ah_his_bloqueo',
       @w_tabla    = 'ah_his_bloqueo_mig'
       
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_conteo = count(*)
from    ah_his_bloqueo_mig
where   hb_cuenta >= @i_clave_i
and     hb_cuenta <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_cuenta'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_cuenta),
       289,
       ah_cuenta,
       ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where ah_cta_banco = ca_cta_banco_mig)
and ah_cuenta = (select hb_cuenta from ah_his_bloqueo_mig where hb_cuenta = a.ah_cuenta)

-- --------------------------------------------------------------
-- - Valida campo ah_monto_bloq de ah_cuenta_mig
-- - sumatoria valor de registros del los bloqueos por cuenta
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_monto_bloq'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_monto_bloq),
       206,
       ah_cuenta,
       ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_monto_bloq <> (select sum(hb_valor) from ah_his_bloqueo_mig where hb_cuenta = a.ah_cuenta)

 
-- --------------------------------------------------------------------
-- - Busco que el campo hb_cuenta sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'hb_cuenta'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_cuenta),
       138,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_cuenta not in (select ah_cuenta from ah_cuenta_mig where ah_cuenta between @i_clave_i and @i_clave_f)

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_secuencial'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_secuencial),
       139,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_secuencial  = 0


-- ---------------------------------------------------------------------
-- -Valida el Valor del Bloqueo
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_valor'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_valor),
       140,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_valor  = 0

-- ---------------------------------------------------------------------
-- -Valida el Total Valores Bloqueados
-- ---------------------------------------------------------------------
/*select @w_nomcolumna = 'hb_monto_bloq'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_monto_bloq),
       141,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_monto_bloq  = 0*/

-- ---------------------------------------------------------------------
-- -Valida la fecha de bloqueo
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_fecha'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_fecha),
       219,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_fecha > @w_fecha_proceso

-- ---------------------------------------------------------------------
-- -Valida la fecha de vencimiento
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_fecha_ven'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_fecha_ven),
       220,
       hb_cuenta
from ah_his_bloqueo_mig hb 
inner join ah_cuenta_mig ah  on ( hb.hb_cuenta = ah.ah_cuenta ) 
inner join cob_remesas..pe_pro_bancario pb  on ( ah.ah_prod_banc = pb.pb_pro_bancario) 
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_fecha_ven  < @w_fecha_proceso

-- ---------------------------------------------------------------------
-- -Valida que la fecha de bloqueo no sea > a la fecha de vencimiento
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_fecha'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_fecha),
       142,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_fecha > hb_fecha_ven and hb_fecha is not null

-- ---------------------------------------------------------------------
-- -VALIDAR LA EXISTENCIA DEL OFICIAL DE CREDITO
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_autorizante'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_autorizante),
       143,
       hb_cuenta
from ah_his_bloqueo_mig a
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_autorizante = ''
                                                        
-- ---------------------------------------------------------------------
-- -VALIDAR LA EXISTENCIA DEL OFICIAL DE CREDITO
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_oficina'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_oficina),
       145,
       hb_cuenta
from ah_his_bloqueo_mig a
where hb_cuenta between @i_clave_i and @i_clave_f
and a.hb_oficina not in (select of_oficina from cobis..cl_oficina 
                         where of_oficina = a.hb_oficina)
                         
-- ---------------------------------------------------------------------
-- -VALIDAR LA CAUSA DEL BLOQUEO
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_causa'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_causa),
       146,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_causa = ''

-- ---------------------------------------------------------------------
-- -Validar el Saldo de la Cuenta despues del bloqueo
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_saldo'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_saldo),
       147,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_saldo < 0

-- ---------------------------------------------------------------------
-- -Validar Acción del Bloqueo(Levantamiento,Bloqueo)
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hb_accion'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_accion),
       148,
       hb_cuenta
from ah_his_bloqueo_mig
where hb_cuenta between @i_clave_i and @i_clave_f 
and hb_accion not in ('L','B') 

-- ---------------------------------------------------------------------
-- -Valida la fecha de vencimiento debe ser null para ahorro programado
-- ---------------------------------------------------------------------
set @w_nomcolumna = 'hb_fecha_ven'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, hb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hb_fecha_ven),
       253,
       hb_cuenta
from ah_his_bloqueo_mig hb 
inner join ah_cuenta_mig ah  on ( hb.hb_cuenta = ah.ah_cuenta ) 
inner join cob_remesas..pe_pro_bancario pb  on ( ah.ah_prod_banc = pb.pb_pro_bancario) 
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_fecha_ven  is not null 

-- ---------------------------------------------------------------------
-- -Valida la hb_causa = 7 para ctas de ahorro programado.
-- ---------------------------------------------------------------------
set @w_nomcolumna = 'hb_causa'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select  convert(varchar, hb_cuenta),
        @w_tabla,
        @w_sp_name,
        @w_nomcolumna,
        convert(varchar, hb_causa),
        255,
        hb_cuenta
from ah_his_bloqueo_mig hb 
inner join ah_cuenta_mig ah  on ( hb.hb_cuenta = ah.ah_cuenta ) 
inner join cob_remesas..pe_pro_bancario pb  on ( ah.ah_prod_banc = pb.pb_pro_bancario ) 
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_causa  not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='ah_causa_bloqueo_val') ) 


-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_his_bloqueo_mig set hb_estado_mig = 'VE'
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_cuenta not in (select convert(int, lm_id_reg) from ah_log_mig 
                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_his_bloqueo_mig'
                      group by lm_id_reg)
and hb_estado_mig is NULL

update ah_his_bloqueo_mig set hb_estado_mig = 'ER'
where hb_cuenta between @i_clave_i and @i_clave_f
and hb_estado_mig is null

return  0
go

