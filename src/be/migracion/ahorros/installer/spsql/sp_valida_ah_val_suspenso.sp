/************************************************************************/
/*      Archivo:                sp_valida_ah_val_suspenso.sp            */
/*      Stored procedure:       sp_valida_ah_val_suspenso               */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           RSA                                     */
/*      Fecha de escritura:     26-Ago-2016                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la migracion de los valores de suspenso   */
/*      de las cuentas de ahorros.                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR               RAZON                          */
/*  26/Ago/2016      Roxana Sánchez      Validacion Categorias          */
/************************************************************************/
use cob_externos
go

if exists (select * from sysobjects where name = 'sp_valida_ah_val_suspenso')
    drop proc sp_valida_ah_val_suspenso
go

create proc sp_valida_ah_val_suspenso(
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
@w_fecha_proceso      datetime,
@w_prod_banc          smallint,
@w_cod_ente           int,
@w_categoria          char(1)

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------

select @w_sp_name         = 'sp_valida_ah_val_suspenso_mig',
   @w_tabla           = 'ah_val_suspenso_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

   
select @w_conteo = count(1)
from    ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0


-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'vs_cuenta'

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
and ah_cuenta = (select vs_cuenta from ah_val_suspenso_mig where vs_cuenta = a.ah_cuenta)

-- ---------------------------------------------------------------------
-- - Valida la causa de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna   = 'vs_cuenta'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_cuenta),
       290,
       vs_cuenta
from ah_val_suspenso_mig x
where vs_cuenta between @i_clave_i and @i_clave_f
and exists (select vs_cuenta from cob_ahorros..ah_val_suspenso where vs_cuenta = x.vs_cuenta and vs_secuencial=x.vs_secuencial and vs_fecha=x.vs_fecha and vs_ssn=x.vs_ssn)

-- --------------------------------------------------------------------
-- - Busco que el campo vs_cuenta sea valido en la tabla ah_cuenta
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'vs_cuenta'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_cuenta),
       151,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_cuenta not in (select ah_cuenta from ah_cuenta_mig where ah_cuenta between @i_clave_i and @i_clave_f)

-- ---------------------------------------------------------------------
-- - Valida el Secuencial de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'vs_secuencial'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_secuencial),
       128,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_secuencial  = 0

-- ---------------------------------------------------------------------
-- -Valida el valor no sea < 0
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'vs_valor'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_valor),
       155,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_valor < 0

---------------------------------------------------------------------
--Valida la Oficina de la Cuenta que tienen valores en suspensos contra la tabla cl_oficina
---------------------------------------------------------------------
select @w_nomcolumna = 'vs_oficina'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_oficina),
       145,
       vs_cuenta
from ah_val_suspenso_mig a
where vs_cuenta between @i_clave_i and @i_clave_f
and a.vs_oficina not in (select of_oficina from cobis..cl_oficina 
						 where of_oficina = a.vs_oficina)
                               
                               
-- ---------------------------------------------------------------------
-- -Valida la Fecha del Valor en Suspenso
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'vs_fecha'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_fecha),
       153,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_fecha  > @w_fecha_proceso
                             
-------------------------------
--VALIDAR HORA DEL SUSPENSO
------------------------------- 
select @w_nomcolumna = 'vs_hora'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_hora),
       264,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_hora is null

-------------------------------                               
--Valida Estado del Suspenso
---------------------------------------------------------------------
select @w_nomcolumna = 'vs_estado'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_estado),
       2,
       vs_cuenta
from ah_val_suspenso_mig a
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_estado not in ('C','N')   

-------------------------------                               
--Valida Procesada del Suspenso
---------------------------------------------------------------------
select @w_nomcolumna = 'vs_procesada'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_procesada),
       266,
       vs_cuenta
from ah_val_suspenso_mig a
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_procesada not in ('S','N')   

-- ---------------------------------------------------------------------
-- -Valida la clave de activación no sea < 0
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'vs_clave'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_clave),
       265,
       vs_cuenta
from ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_clave < 0

-------------------------------                               
--Valida Impuestos del Suspenso
---------------------------------------------------------------------
select @w_nomcolumna = 'vs_impuesto'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, vs_cuenta),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, vs_impuesto),
       267,
       vs_cuenta
from ah_val_suspenso_mig a
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_impuesto not in ('S','N')   

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update ah_val_suspenso_mig set vs_estado_mig = 'VE'
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_cuenta not in (select convert(int, lm_id_reg) from ah_log_mig 
                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 'ah_val_suspenso_mig'
                      group by lm_id_reg)
and vs_estado_mig is null

update ah_val_suspenso_mig set vs_estado_mig = 'ER'
where vs_cuenta between @i_clave_i and @i_clave_f
and vs_estado_mig is null