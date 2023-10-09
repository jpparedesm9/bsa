/***********************************************************************/
/*      Archivo:                        ValidaTelefono.sp              */
/*      Stored procedure:               sp_valida_cl_telefono          */
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
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_telefono')
   drop proc sp_valida_cl_telefono
go

create proc sp_valida_cl_telefono(
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

select @w_sp_name      = 'sp_valida_cl_telefono',
       @w_tabla        = 'cl_telefono_mig'

select @w_conteo = count(*)
from    cl_telefono_mig
where   te_ente >= @i_clave_i
and     te_ente <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Busco que el campo te_ente sea valido en la tabla cl_ente
-- --------------------------------------------------------------------
select @w_nomcolumna = 'te_ente'

insert into cl_log_mig
select convert(varchar, te_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, te_ente),
       20,
       te_ente
from cl_telefono_mig x
where te_ente between @i_clave_i and @i_clave_f
and te_ente not in (select en_ente from cl_ente_mig where en_ente = x.te_ente)

-- ---------------------------------------------------------------------
-- - Busco que el campo te_direccion sea valido en la tabla cl_direccion
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'te_direccion'

insert into cl_log_mig
select convert(varchar, te_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, te_direccion),
       26,
       te_ente
from cl_telefono_mig x
where te_ente between @i_clave_i and @i_clave_f
and te_direccion not in (select di_direccion from cl_direccion_mig where di_ente = x.te_ente and di_direccion = x.te_direccion)

-- ---------------------------------------------------------------------
-- - Busco que el campo te_tipo_telefono sea valido en la tabla cl_ttelefono
-- ---------------------------------------------------------------------

select @w_nomcolumna = 'te_tipo_telefono'

insert into cl_log_mig
select convert(varchar, te_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       te_tipo_telefono,
       75,
       te_ente
from cl_telefono_mig x
where te_ente between @i_clave_i and @i_clave_f
and te_tipo_telefono not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                             where c.tabla  = t.codigo
                                             and   t.tabla  = 'cl_ttelefono'
											 and   c.codigo = x.te_tipo_telefono)

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'te_ente'

insert into cl_log_mig
select convert(varchar, te_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, te_ente),
       30,
       te_ente
from  cl_telefono_mig
where te_ente between @i_clave_i and @i_clave_f
group by te_ente, te_direccion, te_secuencial
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_telefono_mig set te_estado_mig = 'VE'
where te_ente between @i_clave_i and @i_clave_f
and te_ente not in (select convert(int, lm_id_reg) from cl_log_mig
                                                   where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
												   and lm_tabla = @w_tabla
                                                   group by lm_id_reg)
and te_estado_mig is null

update cl_telefono_mig set te_estado_mig = 'ER'
where te_ente between @i_clave_i and @i_clave_f
and te_estado_mig is null

-- ------------------------------------------------------------------
-- - Marcar Error en tablas Anteriores
-- ------------------------------------------------------------------
update cl_ente_mig set en_estado_mig = 'ER'
where en_ente between @i_clave_i and @i_clave_f
and en_ente in (select convert(int, lm_id_reg) from cl_log_mig
                                               where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                               and lm_tabla = @w_tabla
                                               group by lm_id_reg)

update cl_direccion_mig set di_estado_mig = 'ER'
where di_ente between @i_clave_i and @i_clave_f
and di_ente in (select convert(int, lm_id_reg) from cl_log_mig
                                               where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                               and lm_tabla = @w_tabla
                                               group by lm_id_reg)
-- ------------------------------------------------------------------
-- - Si ente dio error, marcar con error registros relacionados
-- ------------------------------------------------------------------
update cl_direccion_mig set di_estado_mig = 'ER'
where di_ente between @i_clave_i and @i_clave_f
and di_ente in(SELECT en_ente FROM cob_externos..cl_ente_mig
                where en_ente between @i_clave_i and @i_clave_f
                  and en_ente in (select convert(int, lm_id_reg) from cob_externos..cl_log_mig
                                       where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                         and lm_tabla = 'cl_ente_mig'
                                       group by lm_id_reg)
)
return  0
go

