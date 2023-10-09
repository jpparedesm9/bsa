/***********************************************************************/
/*      Archivo:                        sp_valida_ah_ctabloqueada.sp   */
/*      Stored procedure:               sp_valida_ah_ctabloqueada      */
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
/* Realiza la validacion de las tabla ah_ctabloqueada para la migracion   */
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ah_ctabloqueada')
   drop proc sp_valida_ah_ctabloqueada
go

create proc sp_valida_ah_ctabloqueada(
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

select @w_sp_name  = 'sp_valida_ah_ctabloqueada',
       @w_tabla    = 'ah_ctabloqueada_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_conteo = count(*)
from    ah_ctabloqueada_mig
where   cb_cuenta >= @i_clave_i
and     cb_cuenta <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------
 select @w_nomcolumna   = 'ah_cuenta'

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
and ah_cuenta = (select cb_cuenta from ah_ctabloqueada_mig where cb_cuenta = a.ah_cuenta)

-- --------------------------------------------------------------   
 -- - Valida campo ah_bloqueos de ah_cuenta_mig
-- - cantidad de registros del los bloqueos por cuenta
-- --------------------------------------------------------------
select @w_nomcolumna = 'ah_bloqueos'

insert into ah_log_mig
select convert(varchar, ah_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, ah_bloqueos),
       205,
       ah_cuenta,
       ah_cta_banco
from ah_cuenta_mig a
where ah_cuenta between @i_clave_i and @i_clave_f
and ah_bloqueos <> (select count(*) from ah_ctabloqueada_mig where cb_cuenta = a.ah_cuenta)

-- --------------------------------------------------------------------
-- - Busco que el campo cb_cuenta sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'cb_cuenta'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_cuenta),
       127,
       cb_cuenta
from ah_ctabloqueada_mig x
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_cuenta not in (select ah_cuenta from ah_cuenta_mig where ah_cuenta = x.cb_cuenta )-- GC between @i_clave_i and @i_clave_f)

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cb_secuencial'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_secuencial),
       128,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_secuencial  = 0

-- ---------------------------------------------------------------------
-- - Valida el Tipo de Bloqueo de Movimiento de la cuenta 1, 2 y 3
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'cb_tipo_bloqueo'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_tipo_bloqueo),
       129,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_tipo_bloqueo not in ('1','2','3')

-------------------------------
--VALIDAR LA FECHA DE APERTURA
------------------------------- 
select @w_nomcolumna = 'cb_fecha'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_fecha),
       130,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_fecha > @w_fecha_proceso

-------------------------------
--VALIDAR HORA BLOQUEO
------------------------------- 
select @w_nomcolumna = 'cb_hora'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_hora),
       131,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_hora is null

-------------------------------
--VALIDAR AUTORIZANTE DEL BLOQUEO
------------------------------- 
select @w_nomcolumna = 'cb_autorizante'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_autorizante),
       132,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_autorizante = ''

-------------------------------
--VALIDAR AUTORIZANTE DEL BLOQUEO
------------------------------- 
select @w_nomcolumna = 'cb_solicitante'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_solicitante),
       133,
       cb_cuenta
from ah_ctabloqueada_mig
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_solicitante = ''

---------------------------------------------------------------------
--Valida la Oficina de la Cuenta bloqueada contra la tabla cl_oficina
---------------------------------------------------------------------
select @w_nomcolumna = 'cb_oficina'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_oficina),
       134,
       cb_cuenta
from ah_ctabloqueada_mig a
where cb_cuenta between @i_clave_i and @i_clave_f
and a.cb_oficina not in (select of_oficina from cobis..cl_oficina 
						 where of_oficina = a.cb_oficina)
						 
---------------------------------------------------------------------
--Valida Estado del Bloqueo
---------------------------------------------------------------------
select @w_nomcolumna = 'cb_estado'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_oficina),
       227,
       cb_cuenta
from ah_ctabloqueada_mig a
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_estado not in ('C','V','L')

---------------------------------------------------------------------
--Valida Estado del Bloqueo
---------------------------------------------------------------------
select @w_nomcolumna = 'cb_causa'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, cb_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, cb_causa),
       136,
       cb_cuenta
from ah_ctabloqueada_mig a
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_causa not in ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15')
						

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_ctabloqueada_mig set cb_estado_mig = 'VE'
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_cuenta not in (select convert(int, lm_id_reg) from ah_log_mig 
                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_ctabloqueada_mig'
                      group by lm_id_reg)
and cb_estado_mig is null

update ah_ctabloqueada_mig set cb_estado_mig = 'ER'
where cb_cuenta between @i_clave_i and @i_clave_f
and cb_estado_mig is null

return  0
go
