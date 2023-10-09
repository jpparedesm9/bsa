/*****************************************************************************/
/*      Archivo:                  sp_valida_ah_linea_pendiente.sp            */
/*      Stored procedure:         sp_valida_ah_linea_pendiente               */
/*      Base de Datos:            cob_pasivas_mig                            */
/*      Producto:                 Cuentas                                    */
/*****************************************************************************/
/*                      IMPORTANTE                                           */
/*      Este programa es parte de los paquetes bancarios propiedad de        */
/*      "MACOSA",representantes exclusivos para el Ecuador de la             */
/*      AT&T                                                                 */
/*      Su uso no autorizado queda expresamente prohibido asi como           */
/*      cualquier autorizacion o agregado hecho por alguno de sus            */
/*      usuario sin el debido consentimiento por escrito de la               */
/*      Presidencia Ejecutiva de MACOSA o su representante                   */
/*****************************************************************************/
/*                      PROPOSITO                                            */
/* Realiza la validacion de las tabla ah_linea_pendiente para la migracion   */
/*****************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ah_linea_pendiente')
   drop proc sp_valida_ah_linea_pendiente
go

create proc sp_valida_ah_linea_pendiente(
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

select @w_sp_name  = 'sp_valida_ah_linea_pendiente',
       @w_tabla    = 'ah_linea_pendiente_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_conteo = count(*)
from    ah_linea_pendiente_mig
where   lp_cuenta >= @i_clave_i
and     lp_cuenta <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'lp_cuenta'

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
and ah_cuenta = (select lp_cuenta from ah_linea_pendiente_mig where lp_cuenta = a.ah_cuenta)
   
-- --------------------------------------------------------------------
-- - Busco que el campo lp_cuenta  sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'lp_cuenta '

insert into ah_log_mig (lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar,lp_cuenta),
       196,
       lp_cuenta
from ah_linea_pendiente_mig a
where lp_cuenta between @i_clave_i and @i_clave_f
and lp_cuenta not in (select ah_cuenta from ah_cuenta_mig where ah_cuenta = a.lp_cuenta)

-- --------------------------------------------------------------------
-- - Busco que el campo lp_linea  sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'lp_linea'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar,ah_cuenta),
       197,
       convert(int,ah_cuenta)
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_linea <> (select count(*) from ah_linea_pendiente_mig where a.ah_cuenta = lp_cuenta)


-- ---------------------------------------------------------------------
-- - Valida el Nemonico de la transaccion
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'lp_nemonico'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, lp_nemonico),
       198,
       lp_cuenta
from ah_linea_pendiente_mig
where lp_cuenta between @i_clave_i and @i_clave_f
and lp_nemonico not in ('DPSL','NCSL','RESL','NDSL','CAAH')


-- ---------------------------------------------------------------------
-- -Valida el Valor de la transaccion
-- ---------------------------------------------------------------------
select @w_nomcolumna = '  lp_valor '

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, lp_valor),
       199,
       lp_cuenta
from ah_linea_pendiente_mig
where lp_cuenta between @i_clave_i and @i_clave_f
and   lp_valor < 0

-- ---------------------------------------------------------------------
-- -Valida la Fecha del movimiento 
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'lp_fecha'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, lp_fecha),
       200,
       lp_cuenta
from ah_linea_pendiente_mig
where lp_cuenta between @i_clave_i and @i_clave_f
and  lp_fecha > @w_fecha_proceso


-- ---------------------------------------------------------------------
-- -Valida el Control de la cuenta 
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'lp_control'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, lp_control),
       201,
       lp_cuenta
from ah_linea_pendiente_mig
where lp_cuenta between @i_clave_i and @i_clave_f
and  lp_control < 0


-- ---------------------------------------------------------------------
-- -Valida la Fecha del movimiento 
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'lp_signo'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       lp_signo,
       202,
       lp_cuenta
from ah_linea_pendiente_mig
where lp_cuenta between @i_clave_i and @i_clave_f
and   lp_signo not in ('D','C')


-- ---------------------------------------------------------------------
-- -Valida el Indicador de registro  
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'lp_enviada'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar,lp_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       lp_enviada,
       203,
       convert(int,lp_cuenta)
from ah_linea_pendiente_mig
where convert(int,lp_cuenta ) between @i_clave_i and @i_clave_f
and   lp_enviada not in ('N')


-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_linea_pendiente_mig set lp_estado_mig = 'VE'
where convert(int,lp_cuenta)  between @i_clave_i and @i_clave_f
and convert(int,lp_cuenta)  not in (select convert(int, lm_id_reg) from ah_log_mig 
                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_linea_pendiente_mig'
                      group by lm_id_reg)
and lp_estado_mig is null

update ah_linea_pendiente_mig set lp_estado_mig = 'ER'
where convert(int,lp_cuenta) between @i_clave_i and @i_clave_f
and lp_estado_mig is null

return  0
go

