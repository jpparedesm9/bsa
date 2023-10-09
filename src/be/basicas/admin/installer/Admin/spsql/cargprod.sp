/************************************************************************/
/*	Archivo: 	        cargprod.sp                             */
/*	Stored procedure:       sp_cargprod                             */
/*	Base de datos:  	cobis				        */
/*	Producto:                             		                */
/*	Disenado por:           Cecilia Villacres                       */
/*	Fecha de escritura:     Febrero/03  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO			        */
/*		                                                        */
/*	 sp que permite hacer consultas auxiliares a la tabla           */
/*	 ad_producto_respaldo como tambien permite consultar las tablas */
/*       de datos existentes en una especifica base de datos		*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA       AUTOR		 RAZON		                */
/*  11-04-2016    BBO             Migracion Sybase-Sqlserver FAL  */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_cargprod')
   drop proc sp_cargprod
go

create proc sp_cargprod (
   @s_date               datetime    = null,
   @t_trn                int    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_tipo               varchar(64) = null, 
   @i_producto           int         = null
)
as
declare
   @w_today           datetime,       -- fecha del dia
   @w_return          int,
   @w_sp_name         varchar(32),    -- nombre stored proc
   @w_existe          tinyint,        -- existe el registro
   @w_error           int,
   @w_base_datos      varchar(64)    

select @w_today   = @s_date
select @w_sp_name = 'sp_cargprod'


-- Consulta opcion QUERY

if @i_operacion = 'E'
begin
   select  
   'Producto' = pr_producto ,
   'Abreviatura' = pr_abreviatura
   from cobis..ad_producto_respaldo
   where pr_tablas_param = 'S'  

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107099  
      return 1
   end
end

-- Consulta opcion V

if @i_operacion = 'V'
begin
   select  
   pr_abreviatura
   from cobis..ad_producto_respaldo
   where pr_producto =@i_producto
   and pr_tablas_param = 'S' 

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107099  
      return 1
   end
end

-- Consulta opcion QUERY
if @i_operacion = 'H'
begin

--print 'dentro de operacion H producto: ' + convert(varchar, @i_producto)

select @w_base_datos = pr_base_datos 
from cobis..ad_producto_respaldo
where pr_producto = @i_producto

if @w_base_datos = 'cob_cartera'
   select 'TABLAS'= name 
   from cob_cartera..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cobis'
   select 'TABLAS'= name 
   from cobis..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_ahorros'
   select 'TABLAS'= name 
   from cob_ahorros..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_ahorros_his'
   select 'TABLAS'= name 
   from cob_ahorros_his..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_atm '
--   select 'TABLAS'= name 
--   from cob_atm ..sysobjects
--   where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--   order by name

if @w_base_datos = 'cob_cartera_his'
   select 'TABLAS'= name 
   from cob_cartera_his ..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_comext'
   select 'TABLAS'= name 
   from cob_comext..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_conta'
   select 'TABLAS'= name 
   from cob_conta ..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_conta_his'
   select 'TABLAS'= name 
   from cob_conta_his..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_credito'
   select 'TABLAS'= name 
   from cob_credito..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_credito_his'
--  select 'TABLAS'= name 
--   from cob_credito_his..sysobjects
--  where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--   order by name

if @w_base_datos = 'cob_cuentas'
   select 'TABLAS'= name 
   from cob_cuentas..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_cuentas_his'
   select 'TABLAS'= name 
   from cob_cuentas_his..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_custodia'
   select 'TABLAS'= name 
   from cob_custodia..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_cversion'
--   select 'TABLAS'= name 
--   from cob_cversion..sysobjects
--   where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--  order by name

if @w_base_datos = 'cob_distrib'
   select 'TABLAS'= name 
   from cob_distrib..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_interfase '
--   select 'TABLAS'= name 
--   from cob_interfase..sysobjects
--   where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--   order by name

if @w_base_datos = 'cob_pfijo '
   select 'TABLAS'= name 
   from cob_pfijo..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_remesas  '
   select 'TABLAS'= name 
   from cob_remesas..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_remesas_his  '
   select 'TABLAS'= name 
   from cob_remesas_his..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_reportes '
--   select 'TABLAS'= name 
--   from cob_reportes..sysobjects
--   where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--   order by name

if @w_base_datos = 'cob_sbancarios '
   select 'TABLAS'= name 
   from cob_sbancarios..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'cob_sbancarios_his '
   select 'TABLAS'= name 
   from cob_sbancarios_his..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

--if @w_base_datos = 'cob_sidac '
--   select 'TABLAS'= name 
--   from cob_sidac..sysobjects
--   where type = 'U'
--   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
--                    where  pr_producto = @i_producto)
--   order by name

if @w_base_datos = 'firmas '
   select 'TABLAS'= name 
   from firmas..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'master '
   select 'TABLAS'= name 
   from master..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'model '
   select 'TABLAS'= name 
   from model..sysobjects
   where type = 'U'
   order by name

if @w_base_datos = 'sybsystemdb '
   select 'TABLAS'= name 
   from sybsystemdb..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'sybsystemprocs  '
   select 'TABLAS'= name 
   from sybsystemprocs..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

if @w_base_datos = 'tempdb '
   select 'TABLAS'= name 
   from tempdb..sysobjects
   where type = 'U'
   and name not in (select pr_tablas from cobis..ad_parametrizacion_respaldo
                    where  pr_producto = @i_producto)
   order by name

end

return 0
go
