/************************************************************************/
/*   Archivo:            consgarfag.sp                                  */
/*   Stored procedure:   sp_cons_garfag                                 */
/*   Base de datos:      cob_custodia                                   */
/*   Producto:           garantias                                      */
/*   Fecha de escritura: 25 Agosto de 2015                              */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                          PROPOSITO                                   */
/*                                                                      */
/* Proceso que valida el porcentaje de cobertura de la garantias FAG    */
/* segun condiciones del cliente                                        */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR           RAZON                            */
/*  Agosto-11-2015     Andres Muñoz    Emision Inicial CCA 500          */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cons_garfag' and type = 'P')
   drop proc sp_cons_garfag
go

create proc sp_cons_garfag(
@s_ssn                       int          = null,
@s_date                      datetime     = null,
@s_user                      login        = null,
@s_term                      varchar(64)  = null,
@s_corr                      char(1)      = null,
@s_ssn_corr                  int          = null,
@s_ofi                       smallint     = null,
@s_srv                       varchar(30)  = null,
@s_lsrv                      varchar(30)  = null,
@t_rty                       char(1)      = null,
@t_from                      varchar(30)  = null,
@t_trn                       smallint     = null,
@i_cliente                   int          = null)

as
declare
@w_sp_name                   varchar(64),
@w_excepcion_fag             tinyint,
@w_porcent_default           int,
@w_cliente                   int,
@w_llave                     varchar(10),
@w_edad                      int,
@w_antiguedad                int,
@w_bloq_porcentaje           char(1),
@w_porcentaje                smallint,
@w_error                     int,
@w_msg                       varchar(64),
@w_tabla_corresp             varchar(5),
@w_codigo_tabla              varchar(5),
@w_garantia_obligatoria      char(1),
@w_agropecuario              varchar(5),
@w_segmento                  varchar(6)

select 
@w_sp_name              = 'sp_cons_garfag',
@w_cliente              = @i_cliente,
@w_tabla_corresp        = 'T165'

select @w_excepcion_fag = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico      = 'NEGF'
and    pa_producto      = 'CRE'

if @w_excepcion_fag is null
begin
   --PARAMETRO GENERAL NO ENCONTRADO
   select 
   @w_error = 150006,
   @w_msg   = 'PARAMETRO EXCEPCION % COBERTURA GARANTIAS FAG NO ENCONTRADO'
   goto ERRORFIN
end

select @w_porcent_default = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'PAAGF'
and    pa_producto = 'CRE'

if @w_porcent_default is null
begin
   --PARAMETRO GENERAL NO ENCONTRADO
   select 
   @w_error = 150006,
   @w_msg   = 'PARAMETRO DEFAULT % COBERTURA GARANTIAS FAG NO ENCONTRADO'
   goto ERRORFIN
end

select @w_garantia_obligatoria = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'OBLFAG'
and    pa_producto = 'CRE'

if @w_garantia_obligatoria is null
begin
   --PARAMETRO GENERAL NO ENCONTRADO
   select 
   @w_error = 150006,
   @w_msg   = 'PARAMETRO GARANTIA OBLIGATORIA FAG NO ENCONTRADO'
   goto ERRORFIN
end

--OBTIENE EL CODIGO DE SEGMENTO AGROPECUARIO
select @w_agropecuario = b.codigo
from   cobis..cl_tabla a,
       cobis..cl_catalogo b
where  a.tabla  = 'cl_subtipo_mercado'
and    a.codigo = b.tabla
and    b.valor  = 'AGROPECUARIO'
and    b.estado = 'V'

if @w_agropecuario is null
begin
   --NO EXISTE DATO EN CATALOGO O NO ESTA VIGENTE
   select 
   @w_error = 2805018,
   @w_msg   = 'NO EXISTE DATO AGROPECUARIO EN CATALOGO O NO ESTA VIGENTE'
   goto ERRORFIN
end

/*** SI EXCEPCION ES POR OFICINA ***/
if @w_excepcion_fag = 1
begin
   --OBTENER OFICINA DEL CLIENTE
   select @w_llave = case when en_oficina_prod is null 
                          then convert(varchar, en_oficina) 
                          else convert(varchar, en_oficina_prod) end
   from   cobis..cl_ente
   where  en_ente  = @w_cliente
end

/*** SI EXCEPCION ES POR ACTIVIDAD ECONOMICA ***/
if @w_excepcion_fag = 2
begin
   --OBTENER ACTIVIDAD ECONOMICA DEL CLIENTE
   select @w_llave = convert(varchar, en_actividad)
   from   cobis..cl_ente
   where  en_ente  = @w_cliente
end

/*** SI EXCEPCION ES POR SEGMENTO CLIENTE ***/
if @w_excepcion_fag = 3
begin
   --OBTENER MERCADO OBJETIVO DEL CLIENTE
   select @w_segmento = convert(varchar, mo_subtipo_mo)
   from   cobis..cl_mercado_objetivo_cliente
   where  mo_ente  = @w_cliente
   
   --VALIDA SI CLIENTE ES AGROPECUARIO
   if @w_segmento = @w_agropecuario
      select @w_llave = 'AGRO'
   else
      select @w_llave = 'NAGRO'
end

/*** SI EXCEPCION ES POR COMBINACION DE EDAD Y ANTIGUEDAD ***/
if @w_excepcion_fag = 4
begin
   --OBTIENE LA EDAD DEL CLIENTE
   select @w_edad = datediff(YEAR, p_fecha_nac, @s_date)
   from   cobis..cl_ente
   where  en_ente = @w_cliente
   
   --OBTIENE LA ANTIGUEDAD DE NEGOCIO DEL CLIENTE
   select @w_antiguedad = datediff(MM, en_fecha_negocio, @s_date)
   from   cobis..cl_ente
   where  en_ente = @w_cliente
   
   --VALIDA SI CLIENTE ES DE MENOR RIESGO
   if exists (select 1 from  cob_credito..cr_corresp_sib
                       where tabla         = @w_tabla_corresp
                       and   codigo_sib    = @w_excepcion_fag
                       and   codigo        = '02'              
                       and   @w_edad       > limite_inf
                       and   @w_antiguedad > limite_sup)
      select @w_llave = '02' --CODIGO MENOR RIESGO
   else
      select @w_llave = '01' --CODIGO MAYOR RIESGO
end

select @w_porcentaje = monto_sup 
from   cob_credito..cr_corresp_sib
where  tabla         = @w_tabla_corresp
and    codigo_sib    = @w_excepcion_fag
and    codigo        = @w_llave

if @w_porcentaje is null
begin
   if @w_excepcion_fag in (1, 2)
   begin
      select 
      @w_porcentaje      = @w_porcent_default,
      @w_bloq_porcentaje = 'S'
   end
   else
   begin
      select @w_bloq_porcentaje = 'N'
      select @w_porcentaje      = 0
   end
end
else
   select @w_bloq_porcentaje = 'S'

/*** SI EN EL PARAMETRO TIENE GARANTIA NO OBLIGATORIA ***/   
if @w_garantia_obligatoria = 'N'
begin
   select @w_bloq_porcentaje = 'N'
   select @w_porcentaje      = 0
end

/*** DEVUELVE VALORES AL FRONTEND PARA VALIDACION ***/
select @w_bloq_porcentaje
select @w_porcentaje

return 0

ERRORFIN:
   exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_msg   = @w_msg
   return @w_error
go
