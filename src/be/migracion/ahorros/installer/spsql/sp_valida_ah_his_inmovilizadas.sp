/*****************************************************************************/
/*      Archivo:                  sp_valida_ah_his_inmovilizadas.sp          */
/*      Stored procedure:         sp_valida_ah_his_inmovilizadas             */
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
/* Realiza la validacion de las tabla ah_his_inmovilizadas para la migracion */
/*****************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ah_his_inmovilizadas')
   drop proc sp_valida_ah_his_inmovilizadas
go

create proc sp_valida_ah_his_inmovilizadas(
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

select @w_sp_name  = 'sp_valida_ah_his_inmovilizadas',
       @w_tabla    = 'ah_his_inmovilizadas_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso       


select @w_conteo = count(*)
from ah_his_inmovilizadas_mig
where  hi_codigo between @i_clave_i and @i_clave_f

if @w_conteo = 0
   return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'ah_cuenta'

insert into ah_log_mig
select convert(varchar, hi_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hi_cuenta),
       289,
       hi_codigo,
       hi_cuenta
from ah_his_inmovilizadas_mig a
where hi_codigo between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where a.hi_cuenta = ca_cta_banco_mig)  
 
-- --------------------------------------------------------------------
-- - Busco que el campo hi_cuenta sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'hi_cuenta'

insert into ah_log_mig
select convert(varchar, hi_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hi_cuenta),
       159,
       hi_codigo,
       hi_cuenta
from ah_his_inmovilizadas_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.hi_cuenta)= convert(varchar(24), b.ah_cta_banco))
where  hi_codigo between @i_clave_i and @i_clave_f
and b.ah_cta_banco is null

-- --------------------------------------------------------------
-- - Valida campo ah_disponible de ah_cuenta_mig
-- - cantidad de registros del los bloqueos por cuenta
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_disponible'

insert into ah_log_mig
select convert(varchar, hi_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hi_saldo),
       235,
       hi_codigo,
       hi_cuenta
from ah_his_inmovilizadas_mig,  ah_cuenta_mig
where  hi_codigo between @i_clave_i and @i_clave_f
and  hi_cuenta = ah_cta_banco
and hi_saldo <  ah_disponible 

-- ---------------------------------------------------------------------
-- - Valida el Valor del Depósito
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hi_saldo'

insert into ah_log_mig
select convert(varchar, hi_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hi_saldo),
       160,
       hi_codigo,
       hi_cuenta
from ah_his_inmovilizadas_mig
where   hi_codigo between @i_clave_i and @i_clave_f
and hi_saldo < 0 


-- ---------------------------------------------------------------------
-- -Valida la Fecha de Inmovilizacion
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'hi_fecha'

insert into ah_log_mig
select convert(varchar, hi_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, hi_fecha),
       162,
       hi_codigo,
       hi_cuenta
from ah_his_inmovilizadas_mig
where   hi_codigo between @i_clave_i and @i_clave_f
and hi_fecha > @w_fecha_proceso



-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_his_inmovilizadas_mig set hi_estado_mig = 'VE'
where hi_codigo between @i_clave_i and @i_clave_f
and hi_codigo not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_his_inmovilizadas_mig'
                  group by lm_id_reg)
and hi_estado_mig is null

update ah_his_inmovilizadas_mig set hi_estado_mig = 'ER'
where hi_codigo between @i_clave_i and @i_clave_f
and hi_estado_mig is null

return  0
go

