/***********************************************************************/
/*      Archivo:                        ValidaRefInhibitoria.sql       */
/*      Stored procedure:               sp_valida_cl_refinh            */
/*      Base de Datos:                  cobis                          */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza la validacion de las tabla cl_telefono para la migracion    */
/************************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_refinh')
   drop proc sp_valida_cl_refinh
go

create proc sp_valida_cl_refinh(
   @i_clave_i            int          = null,
   @i_clave_f            int          = null
)
as
declare
   @w_sp_name            varchar(30),
   @w_tabla              varchar(30),
   @w_nomcolumna         varchar(30),
   @w_conteo             int

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------
set nocount on

select @w_sp_name      = 'sp_valida_cl_refinh',
       @w_tabla        = 'cl_refinh_mig'

select @w_conteo = count(*)
from    cl_refinh_mig
where   in_codigo >= @i_clave_i
and     in_codigo <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Se valida que el campo in_estado sea un catalogo de cl_ereferencia
-- --------------------------------------------------------------------
select @w_nomcolumna = 'in_estado'

insert into cl_log_mig
select convert(varchar, in_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       in_estado,
       166,
       in_codigo
from cl_refinh_mig x
where in_codigo between @i_clave_i and @i_clave_f
and in_estado not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                    where c.tabla  = t.codigo
                                    and   t.tabla  = 'cl_ereferencia'
									and   c.codigo = x.in_estado)

-------------------------------------------------------------
-- Se valida el tipo y número de identificación si son nulos
-------------------------------------------------------------
select @w_nomcolumna = 'in_tipo_ced'

insert into cl_log_mig
select convert(varchar, in_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       in_tipo_ced,
       81,
       in_codigo
from cl_refinh_mig
where in_codigo between @i_clave_i and @i_clave_f
and in_tipo_ced not in (select ct_codigo from cobis..cl_tipo_documento)

select @w_nomcolumna = 'in_subtipo'

insert into cl_log_mig
select convert(varchar, in_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       in_subtipo,
       81,
       in_codigo
from cl_refinh_mig
where in_codigo between @i_clave_i and @i_clave_f
and in_subtipo not in ('C', 'P')

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'in_codigo'

insert into cl_log_mig
select convert(varchar, in_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, in_codigo),
       30,
       in_codigo
from  cl_refinh_mig
where in_codigo between @i_clave_i and @i_clave_f
group by in_codigo
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_refinh_mig set in_estado_mig = 'VE'
where in_codigo between @i_clave_i and @i_clave_f
and in_codigo not in (select convert(int, lm_id_reg) from cl_log_mig
                                                     where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                                     and lm_tabla = @w_tabla
                                                     group by lm_id_reg)
and in_estado_mig is null

update cl_refinh_mig set in_estado_mig = 'ER'
where in_codigo between @i_clave_i and @i_clave_f
and in_estado_mig is null

return  0
go

