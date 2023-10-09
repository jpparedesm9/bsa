/************************************************************************/
/*      Archivo:                sp_valida_re_accion_nd.sp               */
/*      Stored procedure:       sp_valida_re_accion_nd                  */
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

if exists (select * from sysobjects where name = 'sp_valida_re_accion_nd')
    drop proc sp_valida_re_accion_nd 
go

create proc sp_valida_re_accion_nd(
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

select @w_sp_name         = 'sp_valida_re_accion_nd_mig',
   @w_tabla           = 're_accion_nd_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

   
select @w_conteo = count(1)
from    re_accion_nd_mig
where an_causa between @i_clave_i and @i_clave_f
if @w_conteo = 0
return 0

-- ---------------------------------------------------------------------
-- - Valida la causa de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'an_causa'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_causa),
       290,
       an_causa
from re_accion_nd_mig x
where an_causa between @i_clave_i and @i_clave_f
and exists (select an_causa from cob_remesas..re_accion_nd where an_causa = x.an_causa and an_comision=x.an_comision and an_modo=x.an_modo and an_producto=x.an_producto)

-- ---------------------------------------------------------------------
-- - Valida la causa de la Tabla
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'an_causa'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_causa),
       268,
       an_causa
from re_accion_nd_mig
where an_causa between @i_clave_i and @i_clave_f
and an_causa not in (select codigo from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla ='ah_causa_nd'))


-- ---------------------------------------------------------------------
-- - Valida el Producto Ahorros
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'an_producto'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_producto),
       211,
       an_causa
from re_accion_nd_mig
where an_causa between @i_clave_i and @i_clave_f
and an_producto  <> 4

--------------------------------------------------------                               
--Valida la acción que se realiza para las Notas de Débitos
---------------------------------------------------------------------
select @w_nomcolumna = 'an_accion'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_accion),
       269,
       an_causa
from re_accion_nd_mig a
where an_causa between @i_clave_i and @i_clave_f
and an_accion not in ('S','V','E')   

--------------------------------------------------------                               
--Valida el cobro de comisión 
---------------------------------------------------------------------
select @w_nomcolumna = 'an_comision'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_comision),
       270,
       an_causa
from re_accion_nd_mig a
where an_causa between @i_clave_i and @i_clave_f
and an_comision not in ('S','N')   

--------------------------------------------------------                               
--Valida los impuestos si se cobran o no 
---------------------------------------------------------------------
select @w_nomcolumna = 'an_impuesto'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_impuesto),
       271,
       an_causa
from re_accion_nd_mig a
where an_causa between @i_clave_i and @i_clave_f
and an_impuesto not in ('S','N')   

--------------------------------------------------------                               
--Valida los saldos minimos si se cobran o no 
---------------------------------------------------------------------
select @w_nomcolumna = 'an_saldomin'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_saldomin),
       272,
       an_causa
from re_accion_nd_mig a
where an_causa between @i_clave_i and @i_clave_f
and an_saldomin not in ('S','N')   

--------------------------------------------------------                               
--Valida el modo si o no 
---------------------------------------------------------------------
select @w_nomcolumna = 'an_modo'

insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
select convert(varchar, an_causa),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, an_modo),
       273,
       an_causa
from re_accion_nd_mig a
where an_causa between @i_clave_i and @i_clave_f
and an_modo not in ('S','N')   

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update re_accion_nd_mig set an_estado_mig = 'VE'
where an_causa between @i_clave_i and @i_clave_f
and an_causa not in (select convert(int, lm_id_reg) 
                  from ah_log_mig                                                      
                  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 're_accion_nd_mig'
                  group by lm_id_reg)
and an_estado_mig is null

update re_accion_nd_mig set an_estado_mig = 'ER'
where an_causa between @i_clave_i and @i_clave_f
and an_estado_mig is null
return  0
go 