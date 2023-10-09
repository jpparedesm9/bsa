/************************************************************************/
/*	Archivo: 		arevalor.sp			        */
/*	Stored procedure: 	sp_arevalorizar				*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Xavier Tapia                      	*/
/*	Fecha de escritura:     27/JUL/1999  				*/
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
/*	Este programa permite ingresar los registros de Revalorizacion	*/
/*	de Acciones, los que seran tomados posteriormente por el proce- */
/*	so BATCH valoriza.sqr para su revalorizacion         		*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		          RAZON	        	*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_arevalorizar')
    drop proc sp_arevalorizar
go
create proc sp_arevalorizar (
   @s_ssn                int      = null,
   @s_sesn                int      = null,
   @s_rol                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @s_ofi                smallint  = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_entidad_emisora	 int = null,
   @i_des_entidad	 varchar(255) = null,
   @i_fuente_valor	 catalogo = null,
   @i_des_fuente	 varchar(64) = null,
   @i_valor_accion     	 money = null,
   @i_fecha_avaluo       datetime  = null,
   @i_estado		 char	= null,
   @i_formato_fecha      int =	null   --PGA 16/06/2000

)
as

declare
   @w_today              datetime,     
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error		 int,
   @w_entidad_emisora	 int,
   @w_des_entidad	 varchar(255),
   @w_fuente_valor	 catalogo,
   @w_des_fuente	 varchar(64),
   @w_valor_accion     	 money,
   @w_fecha_avaluo       datetime,
   @w_estado		 char

--select @w_today = convert(varchar(10),@s_date,@i_formato_fecha)
select @w_sp_name = 'sp_arevalorizar'

/***********************************************************/
/* Codigos de Transacciones                                */


if (@t_trn <> 19878 and @i_operacion = 'I') or
   (@t_trn <> 19879 and @i_operacion = 'U')  
or
   (@t_trn <> 19880 and @i_operacion = 'D') or
   (@t_trn <> 19881 and @i_operacion = 'S') or
   (@t_trn <> 19881 and @i_operacion = 'Q')
   
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
   	@w_entidad_emisora    = rv_entidad_emisora, 
	@w_des_entidad	      = rv_des_entidad,
   	@w_fuente_valor       = rv_fuente_valor, 
	@w_des_fuente	      = rv_des_fuente,
   	@w_valor_accion       = rv_valor_accion,
   	@w_fecha_avaluo       = rv_fecha_avaluo,
   	@w_estado             = rv_estado 
    from cob_custodia..cu_revaloriza
    where 
	rv_estado = 'V'
	and rv_entidad_emisora = @i_entidad_emisora

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


      -- CODIGO EXTERNO

      insert into cu_revaloriza(
	rv_entidad_emisora, rv_des_entidad, rv_fuente_valor, rv_des_fuente,
	rv_valor_accion, rv_fecha_avaluo, rv_estado)
      values (
	@i_entidad_emisora, @i_des_entidad, @i_fuente_valor, @i_des_fuente,
	@i_valor_accion, @i_fecha_avaluo, @i_estado)
      if @@error <> 0 
      begin

       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end

    --  select @w_ultimo


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
         update cob_custodia..cu_revaloriza
         set 
  	   rv_fuente_valor = @i_fuente_valor, 
	   rv_des_fuente = @i_des_fuente,
   	   rv_valor_accion = @i_valor_accion, 
   	   rv_fecha_avaluo = @i_fecha_avaluo
         where 
	   rv_entidad_emisora = @i_entidad_emisora
	   and rv_estado = @i_estado
 


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
         delete cob_custodia..cu_revaloriza
         where 
	   rv_entidad_emisora = @i_entidad_emisora
  	   and rv_fuente_valor = @i_fuente_valor
   	   and rv_valor_accion = @i_valor_accion 
   	   and rv_fecha_avaluo = @i_fecha_avaluo
	   and rv_estado = @i_estado
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
   	"ENTIDAD" = rv_entidad_emisora, 
	"DESCRIPCION ENTIDAD EMISORA" = rv_des_entidad,
	"FUENTE"    = rv_fuente_valor, 
	"DESCRIPCION FUENTE VALOR" = rv_des_fuente,
   	"VALOR ACCION"    = rv_valor_accion, 
   	"FECHA AVALUO"    = convert(varchar(10),rv_fecha_avaluo,@i_formato_fecha),
   	"ESTADO"          = rv_estado 
    from cob_custodia..cu_revaloriza
    where 
	rv_estado = 'V'
    order by rv_entidad_emisora
 
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
                @w_entidad_emisora,
		@w_des_entidad,
   		@w_fuente_valor,
		@w_des_fuente,
   		@w_valor_accion,
   		convert(varchar(10),@w_fecha_avaluo,@i_formato_fecha),
		--"01/02/1999", -- @w_fecha_avaluo,
   		@w_estado
    end else
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