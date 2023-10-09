/************************************************************************/
/*	Archivo: 	        resparam.sp                             */
/*	Stored procedure:       sp_resparam                             */
/*	Base de datos:  	cobis				        */ 
/*	Producto:                             		                */
/*	Disenado por:           Cecilia Villacres                       */
/*			                      	                        */
/*	Fecha de escritura:     Febrero-2003  				*/
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
/*				PROPOSITO				*/
/*	sp que permite ingresar, modificar, eliminar , consultar y      */
/*	buscar datos en la tabla  ad_producto_respaldo                  */
/*	                                                                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/04/2016  BBO         Migracion SYB-SQL FAL  		*/
/*	                                        			*/
/*	                                                                */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_resparam')
    drop proc sp_resparam
go
create proc sp_resparam(
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               varchar(64) = null,
   @s_corr               char(1)     = null,
   @s_ssn_corr           int         = null,
   @s_ofi                smallint    = null,
   @t_rty                char(1)     = null,
   @t_trn                int    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @t_show_version         bit  = 0,
   @i_operacion          char(1)     = null,
   @i_producto           tinyint  =  null,
   @i_abreviatura     	 char(3) =  null,
   @i_base_datos   	 varchar(64)=  null,
   @i_catalogo           char(1) =  null,
   @i_parametro        	 char(1) =  null,
   @i_secuenciales  	 char(1) =  null,
   @i_perfiles           char(1) =  null,
   @i_tablas_param 	 char(1) =  null)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_producto        	 tinyint, 	
   @w_abreviatura    	 char(3),
   @w_base_datos   	 varchar(64)   , 
   @w_catalogo           char(1), 	
   @w_parametro       	 char(1) , 	
   @w_secuenciales 	 char(1),	
   @w_perfiles           char(1), 	
   @w_tablas_param	 char(1), 
   @w_error              int
   


select @w_today = convert(varchar(10),getdate(),101)
select @w_sp_name = 'sp_resparam'

------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_resparam, version 4.0.0.0'
      return 0
end


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
   begin
     select 
     @w_producto         = pr_producto, 	
     @w_abreviatura      = pr_abreviatura,
     @w_base_datos       = pr_base_datos, 
     @w_catalogo         = pr_catalogos, 	
     @w_parametro        = pr_parametros_g, 	
     @w_secuenciales     = pr_secuenciales,	
     @w_perfiles         = pr_perfiles, 	
     @w_tablas_param     = pr_tablas_param	

     from cobis..ad_producto_respaldo
     where  pr_producto = @i_producto

     if @@rowcount > 0
            select @w_existe = 1
     else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
   begin
      if @i_producto  is NULL or @i_abreviatura  is NULL or @i_base_datos is NULL or @i_catalogo is NULL or
         @i_parametro is NULL or @i_secuenciales is NULL or @i_perfiles   is NULL or @i_tablas_param is NULL

      begin
         /* Campos NOT NULL con valores nulos */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 107098
          return 1 
      end    
    end


/* Ingreso del registro */
/******************************/

if @i_operacion = 'I'
begin
   if @w_existe = 0 
   begin 
      insert into ad_producto_respaldo (
         pr_producto,
         pr_abreviatura,
         pr_base_datos,
         pr_catalogos,
         pr_parametros_g,
         pr_secuenciales,
         pr_perfiles,
         pr_tablas_param)    
       values (
         @i_producto,         	
         @i_abreviatura,
         @i_base_datos,
         @i_catalogo,
         @i_parametro,
         @i_secuenciales,
         @i_perfiles,
         @i_tablas_param 	)

      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 103032
         return 1 
      end
   end
   else
   begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 103032
      return 1 
   end
end


/* Actualizacion del registro  */
/******************************/
if @i_operacion = 'U'
begin
   if @w_existe = 1
         update cobis..ad_producto_respaldo
         set  	
            pr_abreviatura  = @i_abreviatura,
            pr_base_datos   = @i_base_datos, 
            pr_catalogos    = @i_catalogo, 	
            pr_parametros_g = @i_parametro, 	
            pr_secuenciales = @i_secuenciales,	
            pr_perfiles     = @i_perfiles, 	
            pr_tablas_param = @i_tablas_param  	

         where  pr_producto = @i_producto 

            
         if @@error <> 0 
         begin
            /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 105005
             return 1 
         end        
end


/* Eliminacion del registro  */
/******************************/
if @i_operacion = 'D'
   begin
      delete ad_producto_respaldo
      where pr_producto = @i_producto 

      if @w_existe = 0
         begin
            /* Registro a eliminar no existe */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 107003
              return 1 
         end
  
end

/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'Q'
   begin   
      if @w_existe = 1
         begin
              select 
              @w_producto, 	
   	      @w_abreviatura,
              @w_base_datos, 
              @w_catalogo, 	
              @w_parametro, 	
              @w_secuenciales,	
              @w_perfiles, 	
              @w_tablas_param        
         end
   else
      return 1 

end


/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'S'
begin
   select "PRODUCTO"           = pr_producto, 
          "ABREVIATURA"        = pr_abreviatura ,
          "BASE DE DATOS"      = pr_base_datos, 
          "CATALOGOS"          = pr_catalogos,
          "PARAM GENERALES"    = pr_parametros_g,
          "SECUENCIALES"       = pr_secuenciales,
          "PARAM PERFILES"     = pr_perfiles,
          "TABLAS PARAM"       = pr_tablas_param
  
   from ad_producto_respaldo
   
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
     

return 0

go








