/************************************************************************/
/*	Archivo: 	        item.sp	  			                            */
/*	Stored procedure:       sp_item                                     */
/*	Base de datos:  	cob_custodia				                    */
/*	Producto:               garantias               		            */
/*	Disenado por:           Rodrigo Garces                  	        */
/*			        Luis Alfredo Castellanos              	            */
/*	Fecha de escritura:     Junio-1995  				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	Los Items manejados por los diferentes tipos de garantias           */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	Oct/1995   L.Castellanos    Emision Inicial			                */
/*      Dic/2002   JVelandia        cambio etiqueta valor actual        */ 
/*      Mar/2007   MGonzalez        Modificaciones Req 729:Numero fisico*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_item')
    drop proc sp_item
go
create proc sp_item (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_tipo_custodia      descripcion  = null,
   @i_item               tinyint  = null,
   @i_nombre             descripcion  = null,
   @i_detalle            descripcion  = null,
   @i_tipo_dato          char(  1)  = null,
   @i_filial		 tinyint = null,
   @i_sucursal           smallint = null,
   @i_custodia           int = null,
   @i_mandatorio         char(1) = null,
   @i_param1             descripcion = null,
   @i_param2             descripcion = null,
   @i_secuencial1	 tinyint = null,
   @i_valor1		 descripcion = null
   
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tipo_custodia      descripcion,
   @w_item               tinyint,
   @w_nombre             descripcion,
   @w_detalle            descripcion,
   @w_tipo_dato          char(  1),
   @w_ultimo_item        tinyint,
   @w_error              int,
   @w_secservicio        int,
   @w_contador           tinyint,
   @w_mandatorio         char(1),
   @w_conta              tinyint

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_item'



/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19110 and @i_operacion = 'I') or
   (@t_trn <> 19111 and @i_operacion = 'U') or
   (@t_trn <> 19112 and @i_operacion = 'D') or
   (@t_trn <> 19113 and @i_operacion = 'V') or
   (@t_trn <> 19114 and @i_operacion = 'S') or
   (@t_trn <> 19115 and @i_operacion = 'Q') or
   (@t_trn <> 19116 and @i_operacion = 'A') or
   (@t_trn <> 19117 and @i_operacion = 'B') or
   (@t_trn <> 19118 and @i_operacion = 'Z') or --MVI 10/16/96 Produbanco imp.
   (@t_trn <> 19119 and @i_operacion = 'O')    --MVI 10/16/96 Produbanco imp.
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end


select @w_secservicio = @@spid

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select @w_tipo_custodia = it_tipo_custodia,
           @w_item          = it_item,
           @w_nombre        = it_nombre,
           @w_detalle       = it_detalle,
           @w_tipo_dato     = it_tipo_dato,
           @w_mandatorio    = it_mandatorio
    from   cob_custodia..cu_item
    where  it_tipo_custodia = @i_tipo_custodia 
    and    it_item = @i_item

    if @@rowcount > 0
      select @w_existe = 1
    else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
  if @i_tipo_custodia is NULL or 
     @i_tipo_dato is NULL 
  begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
  end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin

  select @w_conta = 0
  
  set rowcount 1

  select @w_conta = 1
  from cu_item
  where it_tipo_custodia = @i_tipo_custodia 
  and   it_nombre = @i_nombre

  set rowcount 0

  if @w_conta  = 1  or @w_existe = 1
  begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901002
        return 1 
  end
  
  begin tran
    select @w_ultimo_item = isnull(max(it_item),0)
    from cu_item 
    where it_tipo_custodia = @i_tipo_custodia
 
    select @w_ultimo_item = @w_ultimo_item + 1
    insert into cu_item(
              it_tipo_custodia,
              it_item,
              it_nombre,
              it_detalle,
              it_tipo_dato,
              it_mandatorio)
    values (
              @i_tipo_custodia,
              @w_ultimo_item,
              @i_nombre,
              @i_detalle,
              @i_tipo_dato,
              @i_mandatorio)

   if @@error <> 0 
   begin
     /* Error en insercion de registro */
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1905001
     return 1 
   end
 
   select @w_ultimo_item

   /* Transaccion de Servicio */
   /***************************/

    insert into ts_item
    values (@w_secservicio,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cu_item',
            @i_tipo_custodia,@i_item, @i_nombre,@i_detalle,@i_tipo_dato,
            @i_mandatorio)

    if @@error <> 0 
    begin
     /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
    end 

         /* Insercion de elementos NULL para items existentes */

         insert into cu_item_custodia (
                ic_filial,
                ic_sucursal,
                ic_tipo_cust,
                ic_custodia,
                ic_item,
                ic_valor_item,
                ic_secuencial,
                ic_codigo_externo
               )
         select distinct 
                ic_filial,ic_sucursal,ic_tipo_cust,ic_custodia,
                @w_ultimo_item,'',ic_secuencial,ic_codigo_externo
         from   cu_item_custodia
         where  ic_tipo_cust = @i_tipo_custodia
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end
    
    begin tran
         update cob_custodia..cu_item
         set    it_nombre     =  @i_nombre,
                it_detalle    =  @i_detalle,
                it_tipo_dato  =  @i_tipo_dato,
                it_mandatorio =  @i_mandatorio
         where  it_tipo_custodia = @i_tipo_custodia 
         and    it_item = @i_item

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_item
         values (@w_secservicio,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,'cu_item',
         @w_tipo_custodia,
         @w_item,
         @w_nombre,
         @w_detalle,
         @w_tipo_dato,
         @w_mandatorio)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end       

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_item
         values (@w_secservicio,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,'cu_item',
         @i_tipo_custodia,
         @i_item,
         @i_nombre,
         @i_detalle,
         @i_tipo_dato,
         @i_mandatorio)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end

    begin tran
         delete cob_custodia..cu_item
         where it_tipo_custodia = @i_tipo_custodia        
         and it_item = @i_item

         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

         delete cu_item_custodia 
         where ic_tipo_cust = @i_tipo_custodia
         and ic_item = @i_item
         if @@error <> 0 
            begin

	   /* Error en insercion de registro */
	    exec cobis..sp_cerror
	    @t_from  = @w_sp_name,
	    @i_num   = 1903001
	    return 1 
	    end




         /* Transaccion de Servicio */
         /***************************/

         insert into ts_item
         values (@w_secservicio,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,'cu_item',
         @w_tipo_custodia,
         @w_item,
         @w_nombre,
         @w_detalle,
         @w_tipo_dato,
         @w_mandatorio)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
       begin
         select 
              @w_tipo_custodia,
              @w_item,
              @w_nombre,
              @w_detalle,
              @w_tipo_dato,
              @w_mandatorio
              
         return 0
       end 
    else
       return 1 
end


if @i_operacion = 'A'
begin
      set rowcount 20
      if (@i_tipo_custodia is null and @i_item is null)
         select @i_tipo_custodia = @i_param1,
                @i_item = convert(tinyint,@i_param2)
      if @i_modo = 0 
      begin
         select "TIPO CUSTODIA" = it_tipo_custodia, "ITEM" = it_item,
                "NOMBRE" = it_nombre
           from cu_item
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
         select it_tipo_custodia, it_item, it_nombre
         from cu_item
         where ((it_tipo_custodia > @i_tipo_custodia) or
               (it_item > @i_item and it_tipo_custodia = @i_tipo_custodia))
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

if @i_operacion = 'S'
begin
   set rowcount 20
   select "ITEM"       = it_item,
          "NOMBRE"     = substring(it_nombre,1,30),
          "TIPO DATO"  = it_tipo_dato,
          "OBLIGATORIO" = it_mandatorio
          
   from cu_item 
   where it_tipo_custodia = @i_tipo_custodia
   and (it_item > @i_item or @i_item is NULL)

   if @@rowcount = 0
   begin
      if @i_item is NULL
      begin

         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
      else
         return 1
   end
end

if @i_operacion = 'B' -- BUSQUEDA CON CRITERIOS
begin
--select @i_secuencial1 = isnull(@i_secuencial1, 1)
--select @i_valor1 = isnull(@i_valor1, '%')

   select distinct "FILIAL"=cu_filial,
                   "OFICINA"=cu_sucursal,
                   "GARANTIA"=cu_custodia,
                   "DESCRIPCION"=substring(cu_descripcion,1,20),
                   "VALOR GARANTIA"=convert(money,cu_valor_inicial),
                   "MONEDA" = cu_moneda
   from cu_custodia,cu_item_custodia
   where cu_tipo        = @i_tipo_custodia
     and cu_filial      = ic_filial
     and cu_sucursal    = ic_sucursal
     and cu_tipo        = ic_tipo_cust
     and cu_custodia    = ic_custodia
     and ic_item	= @i_secuencial1
     and ic_valor_item  like @i_valor1
   order by cu_filial,cu_sucursal,cu_custodia

   if @@rowcount = 0
   begin
      select @w_error = 1901004
      goto error
   end
end

if @i_operacion = 'Z'
begin
     select it_item,it_nombre,ic_valor_item
     from cu_item,cu_item_custodia
     where it_tipo_custodia = @i_tipo_custodia
       and ic_tipo_cust     = @i_tipo_custodia
       and ic_filial        = @i_filial
       and ic_sucursal      = @i_sucursal
       and ic_custodia      = @i_custodia
       and ic_item          = it_item
end

if @i_operacion = 'O'
begin
     select tr_numero_op_banco
     from cu_custodia,cob_credito..cr_gar_propuesta,cob_credito..cr_tramite
     where cu_filial     = @i_filial
     and cu_sucursal   = @i_sucursal
     and cu_tipo       = @i_tipo_custodia
     and cu_custodia   = @i_custodia
     and gp_garantia   = cu_codigo_externo
     and gp_tramite    = tr_tramite 
end

return 0
error:    /* Rutina que dispara sp_cerror dado el codigo de error */

             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = @w_error
             return 1 
go

