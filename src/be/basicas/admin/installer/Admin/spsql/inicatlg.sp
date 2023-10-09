/************************************************************************/
/*	Archivo: 	        inicatlg.sp                             */
/*	Stored procedure:       sp_inicatlg                             */
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
/*	buscar datos en la tabla  ad_iniciales_catalogo                 */
/*	                                                                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/04/2016  BBO         Migracion SYB-SQL FAL		*/
/*	                                        			*/
/*	                                                                */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_inicatlg')
    drop proc sp_inicatlg
go
create proc sp_inicatlg(
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
   @i_operacion          char(1)     = null,
   @i_producto           tinyint  =  null,
   @i_inicial            char(16) =  null)
   
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_producto        	 tinyint, 
   @w_inicial	         char(16),
   @w_error              int
   


select @w_today = convert(varchar(10),getdate(),101)
select @w_sp_name = 'sp_inicatlg'


/*CHEQUEO DE EXISTENCIAS  */
/**************************/
if @i_operacion <> 'S' 
begin
   select 
   @w_producto         = ic_producto, 	
   @w_inicial          = ic_inicial	

   from cobis..ad_iniciales_catalogo
   where  ic_producto = @i_producto
   and    ic_inicial  = @i_inicial

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_producto  is NULL or @i_inicial  is NULL 
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


/* INGRESO DEL REGISTRO */
/******************************/

if @i_operacion = 'I'
begin
   if @w_existe = 0 
   begin 
      insert into ad_iniciales_catalogo 
      (ic_producto,ic_inicial)    
      values 
      (@i_producto,@i_inicial)

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


/* ELIMINACION DEL REGISTRO  */
/******************************/
if @i_operacion = 'D'
begin
   delete ad_iniciales_catalogo
   where ic_producto = @i_producto 
   and   ic_inicial  = @i_inicial

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

/* CONSULTA OPCION QUERY */
/*************************/
if @i_operacion = 'Q'
begin   
   if @w_existe = 1
   begin
      select 
      @w_producto,
      @w_inicial       
   end
   else
      return 1 
end


/* CONSULTA OPCION SERCH */
/*************************/
if @i_operacion = 'S'
begin
   select "PRODUCTO"   = ic_producto, 
          "INICIAL"    = ic_inicial
   from ad_iniciales_catalogo
   where ic_producto = @i_producto
  
   
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 601157 
      return 1 
   end
end
     

return 0

go










