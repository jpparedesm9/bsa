/************************************************************************/
/*      Archivo:                        ValidaTrabajo.sp                */
/*      Stored procedure:               sp_valida_cl_trabajo            */
/*      Base de Datos:                  cobis                           */
/*      Producto:                       Clientes                        */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realiza la Traslado a las tablas de clientes para la migracion       */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_trabajo')
        drop proc sp_valida_cl_trabajo
go

create proc sp_valida_cl_trabajo(
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

select @w_sp_name  = 'sp_valida_cl_trabajo',
       @w_tabla    = 'cl_trabajo_mig'

select @w_conteo = count(*)
from    cl_trabajo_mig
where   tr_persona >= @i_clave_i
and     tr_persona <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Busco que el campo tr_persona sea valido en la tabla cl_ente
-- --------------------------------------------------------------------
select @w_nomcolumna = 'tr_persona'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_persona),
       20,
       tr_persona
from cl_trabajo_mig x
where tr_persona between @i_clave_i and @i_clave_f
and tr_persona not in (select en_ente from cl_ente_mig where en_ente = x.tr_persona)

-- -------------------------------------------------------------------------
-- - Validando datos aceptados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_sueldo'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_sueldo),
       43,
       tr_persona
from cl_trabajo_mig
where tr_persona between @i_clave_i and @i_clave_f
and tr_sueldo < 0

select @w_nomcolumna = 'tr_vigencia'
insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_vigencia),
       46,
       tr_persona
from cl_trabajo_mig
where tr_persona between @i_clave_i and @i_clave_f
and tr_vigencia not in('S', 'N')

-- -------------------------------------------------------------------------
-- - Validando datos en catalogos
-- - tr_tipo   cl_rol_empresa
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_tipo'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_tipo),
       47,
       tr_persona
from cl_trabajo_mig x
where tr_persona between @i_clave_i and @i_clave_f
and tr_tipo is not null
and tr_tipo not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                    where c.tabla  = t.codigo
                                    and   t.tabla  = 'cl_tipo_documento'
									and   c.codigo = x.tr_tipo)


-- -------------------------------------------------------------------------
-- - Validando datos en catalogos
-- - tr_cargo   cl_rol_empresa
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_cargo'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_cargo),
       10,
       tr_persona
from cl_trabajo_mig x
where tr_persona between @i_clave_i and @i_clave_f
and tr_cargo not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                     where c.tabla  = t.codigo
                                     and   t.tabla  = 'cl_rol_empresa'
									 and   c.codigo = x.tr_cargo)

-- -------------------------------------------------------------------------
-- - Validando tr_moneda en tabla cl_moneda
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_moneda'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_moneda),
       35,
       tr_persona
from cl_trabajo_mig
where tr_persona between @i_clave_i and @i_clave_f
and tr_moneda not in (select mo_moneda from cobis..cl_moneda)

-- -------------------------------------------------------------------------
-- - Busco que el campo tr_funcionario sea valido en la tabla cl_funcionario
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_funcionario'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_funcionario),
       21,
       tr_persona
from cl_trabajo_mig
where tr_persona between @i_clave_i and @i_clave_f
and tr_funcionario not in (select fu_login from cobis..cl_funcionario)

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'tr_persona'

insert into cl_log_mig
select convert(varchar, tr_persona),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, tr_persona),
       30,
       tr_persona
from  cl_trabajo_mig
where tr_persona between @i_clave_i and @i_clave_f
group by tr_persona, tr_trabajo
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_trabajo_mig set tr_estado_mig = 'VE'
where tr_persona between @i_clave_i and @i_clave_f
and tr_persona not in (select convert(int, lm_id_reg) from cl_log_mig
                                                      where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
													  and lm_tabla = @w_tabla
                                                      group by lm_id_reg)
and tr_estado_mig is null

update cl_trabajo_mig set tr_estado_mig = 'ER'
where tr_persona between @i_clave_i and @i_clave_f
and tr_estado_mig is null

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

-- ------------------------------------------------------------------
-- - Si ente dio error, marcar con error registros relacionados
-- ------------------------------------------------------------------
update cl_trabajo_mig set tr_estado_mig = 'ER'
where tr_persona between @i_clave_i and @i_clave_f
and tr_persona in(SELECT en_ente FROM cob_externos..cl_ente_mig
                where en_ente between @i_clave_i and @i_clave_f
                  and en_ente in (select convert(int, lm_id_reg) from cob_externos..cl_log_mig
                                       where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                         and lm_tabla = 'cl_ente_mig'
                                       group by lm_id_reg)
)
return 0
go

