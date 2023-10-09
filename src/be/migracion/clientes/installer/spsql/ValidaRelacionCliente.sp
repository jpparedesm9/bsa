/***********************************************************************/
/*      Archivo:                        ValidaRelacionCliente.sp       */
/*      Stored procedure:               sp_valida_cl_instancia         */
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
/* Realiza la validacion de las tabla cl_instancia para la migracion   */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_instancia')
   drop proc sp_valida_cl_instancia
go

create proc sp_valida_cl_instancia(
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

select @w_sp_name  = 'sp_valida_cl_instancia',
       @w_tabla    = 'cl_instancia_mig'

select @w_conteo = count(1)
from    cl_instancia_mig
where   in_ente_i >= @i_clave_i
and     in_ente_i <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Valido que los campos in_ente_i y in_ente_d no sean iguales
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'in_ente_i, in_ente_i'
insert into cl_log_mig
select convert (varchar, in_relacion),
        @w_tabla,
        @w_sp_name,
        @w_nomcolumna,
        CONVERT(varchar(30),in_ente_i), --in_ente_i
        173,
        in_ente_d
from cl_instancia_mig x
where in_ente_i = in_ente_d
  and in_ente_i between @i_clave_i and @i_clave_f
-- --------------------------------------------------------------------
-- - Busco que el campo in_ente_i sea valido en la tabla cl_instancia
-- --------------------------------------------------------------------
  insert into cl_log_mig
select convert (varchar, in_relacion),
        @w_tabla,
        @w_sp_name,
        @w_nomcolumna,
        CONVERT(varchar(30),in_ente_i), --in_ente_i
        170,
        in_ente_d
from cl_instancia_mig x
where in_ente_i between @i_clave_i and @i_clave_f
  and in_ente_i not in (select en_ente from cl_ente_mig where en_ente = x.in_ente_i)
  
-- --------------------------------------------------------------------
-- - Busco que el campo in_ente_d sea valido en la tabla cl_instancia
-- --------------------------------------------------------------------
  select @w_nomcolumna   = 'in_ente_d'
insert into cl_log_mig
select convert (varchar, in_relacion),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar(30),in_ente_d), --in_ente_d
       171,
       in_ente_i
from cl_instancia_mig x
where in_ente_i between @i_clave_i and @i_clave_f
  and in_ente_d not in (select en_ente from cl_ente_mig where en_ente = x.in_ente_d)
  
-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'in_relacio,in_ente_i,in_ente_d'
insert into cl_log_mig
select convert(varchar, in_relacion),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar(30),in_ente_i), --in_ente_i
       30,
       in_ente_d
from  cl_instancia_mig
where in_ente_i between @i_clave_i and @i_clave_f
group by in_relacion,in_ente_i, in_ente_d
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
UPDATE cl_instancia_mig SET in_estado_mig = 'ER'
  FROM cl_instancia_mig i JOIN cl_log_mig l
    ON i.in_relacion = convert(int , l.lm_id_reg)
   AND convert(varchar,i.in_ente_i) = l.lm_dato
   AND i.in_ente_d = l.lm_operacion
   and l.lm_columna= 'in_ente_i'
   AND l.lm_tabla  = 'cl_instancia_mig'
   and l.lm_dato   between convert(varchar,@i_clave_i) 
                       AND convert(varchar,@i_clave_f)
 where i.in_ente_i between @i_clave_i AND @i_clave_f

UPDATE cl_instancia_mig SET in_estado_mig = 'ER'
  FROM cl_instancia_mig i JOIN cl_log_mig l
    ON i.in_relacion = convert(int , l.lm_id_reg)
   AND i.in_ente_i = l.lm_operacion
   AND convert(varchar,i.in_ente_d) = l.lm_dato
   and l.lm_columna= 'in_ente_d'
   AND l.lm_tabla  = 'cl_instancia_mig'
   and l.lm_dato   between convert(varchar,@i_clave_i) 
                       AND convert(varchar,@i_clave_f)
 where i.in_ente_i between @i_clave_i AND @i_clave_f

update cl_instancia_mig set in_estado_mig = 'VE'
 where in_ente_i between @i_clave_i AND @i_clave_f
   and in_estado_mig is null

-- ------------------------------------------------------------------
-- - Marcar Error en tablas Anteriores
-- ------------------------------------------------------------------
/*update cl_ente_mig set en_estado_mig = 'ER'
where en_ente between @i_clave_i and @i_clave_f
and en_ente in (select convert(int, lm_id_reg) from cl_log_mig
                                               where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
                                               and lm_tabla = @w_tabla
                                               group by lm_id_reg)*/
-- ------------------------------------------------------------------
-- - Si ente dio error, marcar con error registros relacionados
-- ------------------------------------------------------------------
UPDATE cl_instancia_mig SET in_estado_mig = 'ER'
  FROM cl_instancia_mig i JOIN cl_log_mig l
    ON ( convert(varchar,i.in_ente_i) = l.lm_dato
        OR   convert(varchar,i.in_ente_d) = l.lm_dato)
   AND l.lm_tabla  = 'cl_ente_mig'
   and l.lm_dato   between convert(varchar,@i_clave_i) 
                       AND convert(varchar,@i_clave_f)
 where i.in_ente_i between @i_clave_i AND @i_clave_f

return 0
go

