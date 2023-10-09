/***********************************************************************/
/*      Archivo:                        ValidaEnte.sp                  */
/*      Stored procedure:               sp_valida_cl_ente              */
/*      Base de Datos:                  cob_basicas_mig                */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      "COBISCORP SA",representantes exclusivos para el Ecuador de la */
/*      AT&T                                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier autorizacion o agregado hecho por alguno de sus      */
/*      usuario sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP SA o su representante       */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza la validacion de las tablas de clientes para la migracion   */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_valida_cl_ente')
   drop proc sp_valida_cl_ente
go

create proc sp_valida_cl_ente(
   @i_clave_i            int          = null,
   @i_clave_f            int          = null,
   @i_incre              char(1)      = null
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

select @w_sp_name         = 'sp_valida_cl_ente',
       @w_tabla           = 'cl_ente_mig'

select @w_conteo = count(*)
from    cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
if @w_conteo = 0
   return 0

--- ---------------------------------------------------------------------------
-- - Validar que dentro de la tabla de clientes no exista otro con igual código
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'en_ente'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_ente),
       96,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
group by en_ente
having count(en_ente) > 1

-- --------------------------------------------------------------
-- - Verifico que el contador de direcciones corresponda con el
-- - valor máximo del secuencial (campo di_direccion) de la tabla
-- - cl_direccion_mig
-- --------------------------------------------------------------
select @w_nomcolumna = 'en_direccion'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_direccion),
       98,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_direccion <> (select count(*) from cl_direccion_mig where di_ente = x.en_ente)

-------------------------------------------------------------
-- Se valida el tipo y número de identificación si son nulos
-------------------------------------------------------------
select @w_nomcolumna = 'en_tipo_ced'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       en_tipo_ced,
       81,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_tipo_ced not in (select ct_codigo from cobis..cl_tipo_documento)

select @w_nomcolumna = 'en_subtipo'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       en_subtipo,
       81,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo not in ('C', 'P')

---------------------------------------
-- VALIDACION DE GENERO
----------------------------------------
select @w_nomcolumna = 'p_sexo'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       p_sexo,
       56,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P'
and p_sexo not in(select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                  where c.tabla  = t.codigo
                                  and   t.tabla  = 'cl_sexo'
								  and   c.codigo = x.p_sexo)

-------------------------------------
-- VALIDACION ESTADO CIVIL
-------------------------------------
select @w_nomcolumna = 'p_estado_civil'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       p_estado_civil,
       57,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P'
and p_estado_civil not in(select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                          where c.tabla  = t.codigo
                                          and   t.tabla  = 'cl_ecivil'
										  and   c.codigo = x.p_estado_civil)

--------------------------------------------
-- VALIDACION DE PROFESION
--------------------------------------------
select @w_nomcolumna = 'p_profesion'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       p_profesion,
       55,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P'
and p_profesion not in(select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                          where c.tabla  = t.codigo
                                          and   t.tabla  = 'cl_profesion'
										  and   c.codigo = x.p_profesion)

---------------------------------
-- VALIDACION DE SECTOR ECONOMICO
---------------------------------
select @w_nomcolumna = 'en_sector'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       en_sector,
       61,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P'
and en_sector not in(select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                          where c.tabla  = t.codigo
                                          and   t.tabla  = 'cl_sectoreco'
										  and   c.codigo = x.en_sector)


--------------------------------
-- VALIDACION DEL PAIS
--------------------------------
select @w_nomcolumna = 'en_pais'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_pais),
       29,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_pais not in(select pa_pais from cobis..cl_pais)

--------------------------------
-- VALIDACION OFICINA
--------------------------------
select @w_nomcolumna = 'en_oficina'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_oficina),
       33,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_oficina not in(select of_oficina from cobis..cl_oficina)

-------------------------------
-- OFICIAL DEL CLIENTE
-------------------------------
select @w_nomcolumna = 'en_oficial'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_oficial),
       110,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_oficial not in (select oc_oficial from cobis..cc_oficial)

--------------------------------
-- VALIDACION DEL PAIS DE NACIMIENTO
--------------------------------
select @w_nomcolumna = 'p_ciudad_nac'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, p_ciudad_nac),
       109,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and p_ciudad_nac not in (select ci_ciudad from cobis..cl_ciudad)

----------------------------------------------------------------------------
-- VALIDACION DEL PAIS DE NACIMIENTO DISTINTO DE NULL SI en_tipo_ced = 'CI'
----------------------------------------------------------------------------
select @w_nomcolumna = 'p_ciudad_nac'
insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       'Valor Nulo',
       159,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_tipo_ced = 'CI' and en_subtipo = 'P' and p_ciudad_nac is null

----------------------------------------------------------------------------
-- VALIDACION NUMERO DE CARGAS
----------------------------------------------------------------------------
select @w_nomcolumna = 'p_num_cargas'

insert into cl_log_mig
select convert (varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       'Cargas Nulas',
       160,
       en_ente
from cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P' and p_num_cargas is null

----------------------------------------------------------------------------
-- VALIDACION RIESGO
----------------------------------------------------------------------------
select @w_nomcolumna = 'en_riesgo'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       en_riesgo,
       61,
       en_ente
from cl_ente_mig x
where en_ente between @i_clave_i and @i_clave_f
and en_subtipo = 'P'
and en_riesgo not in(select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                          where c.tabla  = t.codigo
                                          and   t.tabla  = 'cl_riesgo'
										  and   c.codigo = x.en_riesgo)

-- -------------------------------------------------------------------------
-- - Registros Duplicados
-- -------------------------------------------------------------------------
select @w_nomcolumna = 'en_ente'

insert into cl_log_mig
select convert(varchar, en_ente),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, en_ente),
       30,
       en_ente
from  cl_ente_mig
where en_ente between @i_clave_i and @i_clave_f
group by en_ente
having count(1) > 1

-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update cl_ente_mig set en_estado_mig = 'VE'
where en_ente between @i_clave_i and @i_clave_f
and en_ente not in (select convert(int, lm_id_reg) from cl_log_mig
                                                   where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f
												   and lm_tabla = @w_tabla
                                                   group by lm_id_reg)
and en_estado_mig is null

update cl_ente_mig set en_estado_mig = 'ER'
where en_ente between @i_clave_i and @i_clave_f
and en_estado_mig is null



return  0
go
