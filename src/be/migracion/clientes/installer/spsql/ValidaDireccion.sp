/***********************************************************************/
/*      Archivo:                        ValidaDireccion.sp             */
/*      Stored procedure:               sp_valida_cl_direccion         */
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
/* Realiza la validacion de las tabla cl_direccion para la migracion   */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_direccion')
   drop proc sp_valida_cl_direccion
go

create proc sp_valida_cl_direccion(
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

select @w_sp_name  = 'sp_valida_cl_direccion',
       @w_tabla    = 'cl_direccion_mig'

select @w_conteo = count(*)
from    cl_direccion_mig
where   di_ente >= @i_clave_i
and     di_ente <= @i_clave_f
if @w_conteo = 0
   return 0

-- --------------------------------------------------------------------
-- - Busco que el campo di_ente sea valido en la tabla cl_ente
-- --------------------------------------------------------------------
select @w_nomcolumna   = 'di_ente'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_ente),
       20,
       di_ente
from cl_direccion_mig x
where di_ente between @i_clave_i and @i_clave_f
and di_ente not in (select en_ente from cl_ente_mig where en_ente = x.di_ente)

-- ---------------------------------------------------------------------
-- - Busco que el campo di_funcionario sea valido en la tabla cl_funcionario
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'di_funcionario'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_funcionario),
       21,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_funcionario not in (select fu_login from cobis..cl_funcionario)

-- ---------------------------------------------------------------------
-- - Busco que el campo di_principal sea valido
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'di_principal'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_principal),
       46,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_principal not in ('S', 'N')

-- ---------------------------------------------------------------------
-- - Validacion de campos en catalogos
-- - di_provincia   cl_provincia
-- - di_parroquia   cl_parroquia
-- - di_ciudad      cl_ciudad
-- - di_tipo        cl_tdireccion
-- - di_oficina     cl_oficina
-- - di_sector      cl_sector
-- ---------------------------------------------------------------------
select @w_nomcolumna = 'di_provincia'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_provincia),
       77,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_provincia not in (select pv_provincia from cobis..cl_provincia)

---------------------------------------
---Valida cl ciudad di_provincia = 9999
---------------------------------------
select @w_nomcolumna = 'di_provincia'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_provincia),
       164,
       di_ente
from cl_direccion_mig
inner join cobis..cl_provincia on (pv_provincia = di_provincia and di_provincia = 9999)
where di_ente between @i_clave_i and @i_clave_f

---------------------------------------
---Valida di_parroquia
---------------------------------------
select @w_nomcolumna = 'di_parroquia'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_parroquia),
       74,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_parroquia not in (select pq_parroquia from cobis..cl_parroquia)

select @w_nomcolumna = 'di_ciudad'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_ciudad),
       34,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_ciudad not in (select ci_ciudad from cobis..cl_ciudad)

-----------------------------------
---Valida cl ciudad ci_ciudad = 99999
-----------------------------------
select @w_nomcolumna = 'di_ciudad'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_ciudad),
       163,
       di_ente
from cl_direccion_mig
inner join cobis..cl_ciudad on (ci_ciudad = di_ciudad and di_ciudad = 99999)
where di_ente between @i_clave_i and @i_clave_f

-----------------------------------
---Valida di_tipo
-----------------------------------
select @w_nomcolumna = 'di_tipo'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       di_tipo,
       75,
       di_ente
from cl_direccion_mig x
where di_ente between @i_clave_i and @i_clave_f
and di_tipo not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                    where c.tabla  = t.codigo
                                    and   t.tabla  = 'cl_tdireccion'
									and   c.codigo = x.di_tipo)

-- -------------------------------------------------------------
-- - Verifico que el campo di_telefono tenga el mismo valor que
-- - el máximo secuencial (campo te_secuencial) de la tabla
-- - cl_telefono_mig
-- -------------------------------------------------------------
select @w_nomcolumna = 'di_telefono'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_telefono),
       97,
       di_ente
from cl_direccion_mig x
where di_ente between @i_clave_i and @i_clave_f
and di_telefono <> (select count(*) from cl_telefono_mig where te_ente = x.di_ente and te_direccion = x.di_direccion)

-- ------------------------------------------------------------------------
-- - Busco la oficina si es diferente de null porque no es campo obligatorio
-- ------------------------------------------------------------------------
select @w_nomcolumna = 'di_oficina'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_oficina),
       33,
       di_ente
from cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
and di_oficina not in (select of_oficina from cobis..cl_oficina)

-- ------------------------------------------------------------------------
-- - Busco el sector si es diferente de null porque no es campo obligatorio
-- ------------------------------------------------------------------------
select @w_nomcolumna = 'di_sector'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       di_sector,
       50,
       di_ente
from cl_direccion_mig x
where di_ente between @i_clave_i and @i_clave_f
and di_sector is not null
and di_sector not in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                      where c.tabla  = t.codigo
                                      and   t.tabla  = 'cl_sector'
									  and   c.codigo = x.di_sector)

-- -------------------------------------------------------------------------
-- - Busco que el campo di_vigencia  se encuentre dentro del catalogo cl_estado_ser
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'di_vigencia'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_vigencia),
       19,
       di_ente
from cl_direccion_mig x
where di_ente between @i_clave_i and @i_clave_f
and di_vigencia not in ('S', 'N')

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'di_ente'

insert into cl_log_mig
select convert(varchar, di_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, di_ente),
       30,
       di_ente
from  cl_direccion_mig
where di_ente between @i_clave_i and @i_clave_f
group by di_ente, di_direccion
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_direccion_mig set di_estado_mig = 'VE'
where di_ente between @i_clave_i and @i_clave_f
and di_ente not in (select convert(int, lm_id_reg) from cl_log_mig
                                                   where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
												   and lm_tabla = @w_tabla
                                                   group by lm_id_reg)
and di_estado_mig is null

update cl_direccion_mig set di_estado_mig = 'ER'
where di_ente between @i_clave_i and @i_clave_f
and di_estado_mig is null

-- ------------------------------------------------------------------
-- - Marcar Error en tablas Anteriores
-- ------------------------------------------------------------------
update cl_ente_mig set en_estado_mig = 'ER'
where en_ente between @i_clave_i and @i_clave_f
and en_ente in (select convert(int, lm_id_reg) from cl_log_mig
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

