/***************************************************************************/
/*      Archivo:                        sp_valida_ah_ciudad_deposito.sp    */
/*      Stored procedure:               sp_valida_ah_ciudad_deposito       */
/*      Base de Datos:                  cob_pasivas_mig                    */
/*      Producto:                       Cuentas                            */
/***************************************************************************/
/*                      IMPORTANTE                                         */
/*      Este programa es parte de los paquetes bancarios propiedad de      */
/*      "MACOSA",representantes exclusivos para el Ecuador de la           */
/*      AT&T                                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como         */
/*      cualquier autorizacion o agregado hecho por alguno de sus          */
/*      usuario sin el debido consentimiento por escrito de la             */
/*      Presidencia Ejecutiva de MACOSA o su representante                 */
/***************************************************************************/
/*                      PROPOSITO                                          */
/* Realiza la validacion de las tabla ah_ciudad_deposito para la migracion */
/***************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ah_ciudad_deposito')
   drop proc sp_valida_ah_ciudad_deposito
go

create proc sp_valida_ah_ciudad_deposito(
   @i_clave_i           int          = null,  
   @i_clave_f           int          = null
)
as
declare
   @w_sp_name            varchar(30),
   @w_tabla              varchar(30),
   @w_nomcolumna         varchar(30),
   @w_conteo             int,
   @w_fecha_proceso      datetime

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------
set nocount on

select @w_sp_name  = 'sp_valida_ah_ciudad_deposito',
       @w_tabla    = 'ah_ciudad_deposito_mig'
       
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_conteo = count(*)
from    ah_ciudad_deposito_mig
where   cd_cuenta >= @i_clave_i
and     cd_cuenta <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_24h'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_cuenta),
       289,
       ah_cuenta
   from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where ah_cta_banco = ca_cta_banco_mig)
and ah_cuenta = (select cd_cuenta from ah_ciudad_deposito_mig where cd_cuenta = a.ah_cuenta)

-- --------------------------------------------------------------
-- - Valida campo ah_24h de ah_cuenta_mig
-- - sumatoria valor de registros del los bloqueos por cuenta
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_24h'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_24h),
       207,
       ah_cuenta
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_24h <> (select sum(cd_valor) from ah_ciudad_deposito_mig where cd_cuenta = a.ah_cuenta)
   
-- --------------------------------------------------------------------
-- - Busco que el campo cd_cuenta sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'cd_cuenta'

insert into ah_log_mig (lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_cuenta),
       151,
       cd_cuenta
from ah_ciudad_deposito_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_cuenta not in (select ah_cuenta from ah_cuenta_mig where ah_cuenta between @i_clave_i and @i_clave_f)

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_ciudad'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_ciudad),
       152,
       cd_cuenta
from ah_ciudad_deposito_mig a
where cd_cuenta between @i_clave_i and @i_clave_f
and a.cd_ciudad not in (select ci_ciudad from cobis..cl_ciudad 
					    where ci_ciudad = a.cd_ciudad)


-- ---------------------------------------------------------------------
-- -Valida la Fecha del Depósito
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_fecha_depo'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_fecha_depo),
       153,
       cd_cuenta
from ah_ciudad_deposito_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_fecha_depo  > @w_fecha_proceso

-- ---------------------------------------------------------------------
-- -Valida la Fecha de Efectivización del Depósito
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_fecha_efe'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_fecha_efe),
       154,
       cd_cuenta
from ah_ciudad_deposito_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_fecha_efe < cd_fecha_depo

-- ---------------------------------------------------------------------
-- -Valida que la fecha de bloqueo no sea > a la fecha de migracion
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_valor'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_valor),
       155,
       cd_cuenta
from ah_ciudad_deposito_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_valor < 0

-- ---------------------------------------------------------------------
-- -Validar especifica si se ha efectivizado
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_efectivizado'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_efectivizado),
       156,
       cd_cuenta
from ah_ciudad_deposito_mig a
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_efectivizado not in ('S','N')
														
-- ---------------------------------------------------------------------
-- -Validar el valores a efectivizar
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cd_valor_efe'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cd_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cd_valor_efe),
       157,
       cd_cuenta
from ah_ciudad_deposito_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_valor_efe < 0 and cd_valor_efe is not null

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_ciudad_deposito_mig set cd_estado_mig = 'VE'
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_cuenta not in (select convert(int, lm_id_reg) from ah_log_mig 
                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_ciudad_deposito_mig'
                      group by lm_id_reg)
and cd_estado_mig is null

update ah_ciudad_deposito_mig set cd_estado_mig = 'ER'
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_estado_mig is null

return  0
go

