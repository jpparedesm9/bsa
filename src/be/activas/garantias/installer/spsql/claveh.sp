/************************************************************************/
/*	Archivo: 		claveh.sp			        */
/*	Stored procedure: 	sp_clase_vehiculo			*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Milena Gonzalez                  	*/
/*	Fecha de escritura:     14/Ene/2003  				*/
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
/*	Este programa permite ingresar, eliminar y modificar las 	*/
/*	clases de Vehiculos para el calculo de seguros de cartera       */
/************************************************************************/
/*				MODIFICACIONES				*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_clase_vehiculo')
    drop proc sp_clase_vehiculo
go
create proc sp_clase_vehiculo (
   @s_ssn                int      = null,
   @s_sesn               int      = null,
   @s_rol                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion  = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @s_ofi                smallint     = null,
   @t_trn                smallint     = null,
   @t_from               varchar(30)  = null,
   @t_file               varchar(14) = null,
   @t_debug              char(1)  = 'N',
   @i_operacion          char(1)      = null,
   @i_tipo		 varchar(64)      = null,
   @i_clase              varchar(10)  = null,
   @i_descripcion        varchar(64)  = null,
   @i_param1     	 descripcion = null,
   @i_modo               tinyint = null,
   @i_cond1              varchar(15) = null
)
as

declare
   @w_today              datetime,     
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error		 int,
   @w_tipo               varchar(64),
   @w_clase              varchar(10),
   @w_descripcion        varchar(64),
   @w_vehiculo           char(1)

select @w_sp_name = 'sp_clase_vehiculo'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19945 and @i_operacion = 'I') or
   (@t_trn <> 19949 and @i_operacion = 'U') or
   (@t_trn <> 19946 and @i_operacion = 'D') or
   (@t_trn <> 19948 and @i_operacion = 'S') or
   (@t_trn <> 19947 and @i_operacion = 'Q') or
   (@t_trn <> 19950 and @i_operacion = 'B') 
   
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,  
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin
    select
        @w_tipo          = cv_tipo,
        @w_clase         = cv_clase,
        @w_descripcion   = cv_descripcion
    from cob_custodia..cu_clase_vehiculo
    where cv_tipo = @i_tipo
    and   cv_clase= @i_clase

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
   /* Registro ya existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1 
   end

   begin tran 
      insert into cu_clase_vehiculo ( cv_tipo,  cv_clase,  cv_descripcion )
      values ( @i_tipo,    @i_clase,    @i_descripcion )
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end
   commit tran 
   return 0
end


/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    begin tran
         update cob_custodia..cu_clase_vehiculo
         set 
  	   cv_clase        = @i_clase,    
           cv_descripcion  = @i_descripcion
         where cv_tipo     = @i_tipo
         and   cv_clase    = @i_clase

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end
    commit tran

    return 0
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end
    else
    begin tran
         delete cob_custodia..cu_clase_vehiculo
         where cv_tipo = @i_tipo
         and   cv_clase = @i_clase
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_from= @w_sp_name,
             @i_num   = 1907001
             return 1 
         end
    commit tran
    return 0
end


if @i_operacion = 'S' 
begin 
--set rowcount 20
    select 
   	"TIPO DE GARANTIA"   = cv_tipo, 
	"CLASE DE VEHICULO"  = cv_clase,
   	"DESCRIPCON"         = cv_descripcion
    from cob_custodia..cu_clase_vehiculo
         if @@rowcount = 0
         begin
            select @w_error  = 1901003
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
         end 
     return 0
end 

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
    begin 
         select 
              @w_tipo,
              @w_clase,
              @w_descripcion
    end 
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901005
        return 1 
    end
    return 0
end


if @i_operacion = 'B'
begin

    select @w_vehiculo = 'N'

    if exists(select 1 from cu_clase_vehiculo where cv_tipo = @i_tipo)
        select @w_vehiculo = 'S'

    select @w_vehiculo

    return 0
end


if @i_operacion = 'A'
begin
   set rowcount 20

   if @i_modo = 0 
   begin
      select
      "CLASE DE VEHICULO" = cv_clase,
      "DESCRIPCION" = cv_descripcion
      from cu_clase_vehiculo
      where cv_tipo = @i_cond1
      if @@rowcount = 0
      begin
 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
    end
    else 
    begin
       select cv_clase,cv_descripcion
       from cu_clase_vehiculo
       where cv_clase > @i_clase
       and cv_tipo = @i_cond1
       if @@rowcount = 0
       begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name, 

          @i_num   = 1901004
          return 1 
       end
    end
end


if @i_operacion = 'V'
begin
   select cv_descripcion
   from cu_clase_vehiculo
   where cv_tipo = @i_tipo
   and   cv_clase = @i_clase
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end


go

