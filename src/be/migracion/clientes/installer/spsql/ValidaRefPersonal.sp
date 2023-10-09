/***********************************************************************/
/*      Archivo:                        cl_vrefp.sp                    */
/*      Stored procedure:               sp_valida_ref_personal         */
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
/* Realiza la validacion de las tabla cl_ref_personal para la migracion*/
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_ref_personal')
   drop proc sp_valida_ref_personal
go

create proc sp_valida_ref_personal(
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

select @w_sp_name  = 'sp_valida_ref_personal',
       @w_tabla    = 'cl_ref_personal_mig'

select @w_conteo = count(*)
from    cl_ref_personal_mig
where   rp_persona >= @i_clave_i
and     rp_persona <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Busco que el campo rp_persona sea valido en la tabla cl_ente
-- --------------------------------------------------------------------
select @w_nomcolumna = 'rp_persona'

insert into cl_log_mig
select convert(varchar, rp_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, rp_persona),
       20,
       rp_persona
from cl_ref_personal_mig x
where rp_persona between @i_clave_i and @i_clave_f
and rp_persona not in (select en_ente from cl_ente_mig where en_ente = x.rp_persona)

-- --------------------------------------------------------------------
-- - Validando datos en catalogo
-- - rp_parentesco   cl_parentesco
-- --------------------------------------------------------------------
select @w_nomcolumna = 'rp_parentesco'

insert into cl_log_mig
select convert(varchar, rp_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, rp_parentesco),
       40,
       rp_persona
from cl_ref_personal_mig x
where rp_persona between @i_clave_i and @i_clave_f
and rp_parentesco not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                          where c.tabla  = t.codigo
                                          and   t.tabla  = 'cl_parentesco'
										  and   c.codigo = x.rp_parentesco)

-- -------------------------------------------------------------------------
-- - Busco que el campo rp_funcionario sea valido en la tabla cl_funcionario
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'rp_funcionario'

insert into cl_log_mig
select convert(varchar, rp_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, rp_funcionario),
       21,
       rp_persona
from cl_ref_personal_mig
where rp_persona between @i_clave_i and @i_clave_f
and rp_funcionario not in (select fu_login from cobis..cl_funcionario)

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'rp_persona'

insert into cl_log_mig
select convert(varchar, rp_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, rp_persona),
       30,
       rp_persona
from  cl_ref_personal_mig
where rp_persona between @i_clave_i and @i_clave_f
group by rp_persona, rp_referencia
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_ref_personal_mig set rp_estado_mig = 'VE'
where rp_persona between @i_clave_i and @i_clave_f
and rp_persona not in (select convert(int, lm_id_reg) from cl_log_mig
                                                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
													  and lm_tabla = @w_tabla
                                                      group by lm_id_reg)
and rp_estado_mig is null

update cl_ref_personal_mig set rp_estado_mig = 'ER'
where rp_persona between @i_clave_i and @i_clave_f
and rp_estado_mig is null

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

update cl_telefono_mig set te_estado_mig = 'ER'
where te_ente between @i_clave_i and @i_clave_f
and te_ente in (select convert(int, lm_id_reg) from cl_log_mig
                                               where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                               and lm_tabla = @w_tabla
                                               group by lm_id_reg)

update cl_trabajo_mig set tr_estado_mig = 'ER'
where tr_persona between @i_clave_i and @i_clave_f
and tr_persona in (select convert(int, lm_id_reg) from cl_log_mig
                                                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
													  and lm_tabla = @w_tabla
                                                      group by lm_id_reg)
-- ------------------------------------------------------------------
-- - Si ente dio error, marcar con error registros relacionados
-- ------------------------------------------------------------------
update cl_ref_personal_mig set rp_estado_mig = 'ER'
where rp_persona between @i_clave_i and @i_clave_f
and rp_persona between @i_clave_i and @i_clave_f
and rp_persona in (SELECT en_ente FROM cob_externos..cl_ente_mig
                where en_ente between @i_clave_i and @i_clave_f
                  and en_ente in (select convert(int, lm_id_reg) from cob_externos..cl_log_mig
                                       where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                         and lm_tabla = 'cl_ente_mig'
                                       group by lm_id_reg)
)

return  0
go

