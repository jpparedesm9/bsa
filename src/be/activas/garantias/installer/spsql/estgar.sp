/************************************************************************/
/*	Archivo: 		estgar.sp			        */
/*	Stored procedure: 	sp_estados_garantia			*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Patricia Garzon                   	*/
/*	Fecha de escritura:     21/jun/2000  				*/
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
/*	Este programa permite ingresar, eliminar y modificar los 	*/
/*	estados que puede tener una garantia.                           */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		          RAZON	        	*/
/*  21/jun/2000	  Patricia Garzon            Emision Inicial		*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_estados_garantia')
    drop proc sp_estados_garantia
go
create proc sp_estados_garantia (
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
   @i_operacion          char(1)      = null,
   @i_estado		 char(1)      = null,
   @i_des_estado         descripcion  = null,
   @i_cod_valor          int          = null,
   @i_formato_fecha      int          =	null   --PGA 16/06/2000
)
as

declare
   @w_today              datetime,     
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error		 int,
   @w_estado             char(1),
   @w_des_estado         descripcion,
   @w_cod_valor          int

select @w_sp_name = 'sp_estados_garantia'
--print 'op %1! ', @i_operacion
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19891 and @i_operacion = 'I') or
   (@t_trn <> 19892 and @i_operacion = 'U') or
   (@t_trn <> 19893 and @i_operacion = 'D') or
   (@t_trn <> 19894 and @i_operacion = 'S') or
   (@t_trn <> 19895 and @i_operacion = 'Q')
   
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
        @w_estado             = eg_estado,
        @w_des_estado         = eg_descripcion,
        @w_cod_valor          = eg_codvalor
    from cob_custodia..cu_estados_garantia
    where eg_estado = @i_estado

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
      insert into cu_estados_garantia ( eg_estado,  eg_descripcion,  eg_codvalor )
      values ( @i_estado,    @i_des_estado,    @i_cod_valor )
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
         update cob_custodia..cu_estados_garantia 
         set 
  	   eg_descripcion  = @i_des_estado,    
           eg_codvalor     = @i_cod_valor 
         where eg_estado   = @i_estado

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
         delete cob_custodia..cu_estados_garantia 
         where eg_estado = @i_estado
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
begin set rowcount 20
    select 
   	"CODIGO"       = eg_estado, 
	"DESCRIPCION"  = eg_descripcion,
   	"CODIGO VALOR" = eg_codvalor
    from cob_custodia..cu_estados_garantia  
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
              @w_estado,
              @w_des_estado,
              @w_cod_valor
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

go