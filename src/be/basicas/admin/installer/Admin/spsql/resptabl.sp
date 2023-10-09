/************************************************************************/
/*	Archivo: 	        resptabl.sp                             */
/*	Stored procedure:       sp_resptabl                             */
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
/*	sp que realiza el respaldo de los nombres                       */
/*	de las tablas correspondientes a una base de datos determinada  */
/*	en la tabla ad_parametrizacion_respaldo, y ademas permite       */
/*      hacer consultas a la misma.                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA       AUTOR		 RAZON		                */
/*  	Feb/2003                                                        */
/************************************************************************/



use cobis
go

if exists (select * from sysobjects where name = 'sp_resptabl')
   drop proc sp_resptabl
go
create proc sp_resptabl (
   @s_date               datetime    = null,
   @t_trn                int         = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_tipo               varchar(64) = null,
   @i_producto           tinyint     = null,
   @i_tablas             varchar(64) = null   
)
as
declare
   @w_today           datetime,       -- fecha del dfa
   @w_return          int,
   @w_sp_name         varchar(32),    -- nombre stored proc
   @w_existe          tinyint,        -- existe el registro
   @w_error           int,
   @w_producto        tinyint, 	
   @w_tablas          varchar (64)
  
    

select @w_today   = @s_date
select @w_sp_name = 'sp_resptabl'

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
   select 
   @w_producto         = pr_producto, 	
   @w_tablas           = pr_tablas
     
   from cobis..ad_parametrizacion_respaldo
   where  pr_producto = @i_producto
   and    pr_tablas = @i_tablas

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end



/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' 
begin
   if @i_producto  is NULL or  
      @i_tablas    is NULL 

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
      insert into ad_parametrizacion_respaldo 
      (pr_producto,pr_tablas)    
      values 
      (@i_producto,@i_tablas)
         
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
end



/* Eliminacion del registro  */
/******************************/
if @i_operacion = 'D'
begin
   delete ad_parametrizacion_respaldo
   where pr_producto = @i_producto 
   and   pr_tablas   = @i_tablas

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


/* Consulta respaldadas */
/*************************/

if @i_operacion = 'S'
begin
   select  
   'Tablas' = pr_tablas
   from ad_parametrizacion_respaldo
   where pr_producto = @i_producto  

 /*  if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107099  
      return 1
   end*/
end



return 0 

go
