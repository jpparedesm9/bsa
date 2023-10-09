use cob_fpm
go

if exists (select 1 from sysobjects where name = 'sp_estados_fpm')
   drop proc sp_estados_fpm
go

CREATE PROCEDURE sp_estados_fpm (
    @i_operacion     char(1) = 'C',
    @i_estado_ini    varchar(30) = null,     -- DAG
    @i_toperacion    catalogo = null,	-- EESD
    @i_estado_sig    int = -1,
    @i_modo          int = 0,
    @i_valorcat      varchar(64) = null 
)
as
declare
   @w_sp_name		varchar (32),
   @w_codigocat         varchar(30)
    
/*  Captura nombre de Stored Procedure e Inicializa Variables  */
select	@w_sp_name = 'sp_estados'

if @i_valorcat is not null
select @w_codigocat  = '%'+ @i_valorcat + '%'

if @i_operacion = 'H'
begin
       select "233403" = es_descripcion, 
              "233405" = es_codigo 
       from cob_cartera..ca_estado
       where es_codigo > @i_estado_sig
       and ((@i_valorcat is null) or (@i_valorcat is not null and es_descripcion like @w_codigocat) )
       order by es_codigo

end   
   
   
if @i_operacion = 'V'
    select es_descripcion, 
           es_codigo 
    from cob_cartera..ca_estado
    where es_codigo = @i_estado_sig
   

if @i_operacion = 'T'
     select  "233403" = es_descripcion
     from cob_cartera..ca_estado where es_codigo in (
          select convert(tinyint,A.codigo)
          from cobis..cl_catalogo A,cobis..cl_tabla B
          where B.codigo = A.tabla and B.tabla =  'ca_estado_abogado')
          and es_codigo not in (select es_codigo from ca_estado
          where  es_descripcion = @i_estado_ini)

if @i_operacion = 'M'  --Estados manuales
   select  "233403" = es_descripcion
     from cob_cartera..ca_estados_man, cob_cartera..ca_estado
    where  em_toperacion = @i_toperacion
      and  em_tipo_cambio = 'M'
      and  em_estado_ini = (select es_codigo from ca_estado
      where  es_descripcion = @i_estado_ini)
      and  em_estado_fin = es_codigo
      and es_codigo not in (
          select convert(tinyint,A.codigo)
          from cobis..cl_catalogo A,cobis..cl_tabla B
          where B.codigo = A.tabla and B.tabla =  'ca_estado_abogado')
      order  by es_descripcion

if @i_operacion = 'E'  --Ejecución Legal
   select  "233403" = es_descripcion
     from cob_cartera..ca_estados_man, cob_cartera..ca_estado
    where  em_toperacion = @i_toperacion
      and  em_tipo_cambio = 'M'
      and  em_estado_ini = (select es_codigo from ca_estado
         		    where  es_descripcion = @i_estado_ini)
      and  em_estado_fin = es_codigo
    order  by es_descripcion


if @i_operacion = 'O' -- Consulta de Origen de fondos
   select  "233404" =  of_descripcion,
           "233405" =  of_codigo
   from   cob_cartera..ca_origen_fondo
   
   --FIE CCA032 Consulta filtrada
if @i_operacion = 'C'
begin
       select "233403" = es_descripcion, 
              "233405" = es_codigo 
       from cob_cartera..ca_estado
       where es_codigo > @i_estado_sig
       and ((@i_valorcat is null) or (@i_valorcat is not null and es_descripcion like @w_codigocat) )
	   and es_codigo not in (0,3,6,98,98)
       order by es_codigo
end    
   
return 0
