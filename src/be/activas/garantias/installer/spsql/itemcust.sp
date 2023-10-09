/************************************************************************/
/*	Archivo: 	        itemcust.sp                             */
/*	Stored procedure:       sp_item_custodia                        */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Ingreso / Modificacion / Eliminacion / Consulta y Busqueda      */
/*	de los items (Informacion Particular por tipo de garantia)      */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Nov/1995   L. Castellanos    Emision Inicial	                */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_item_custodia')
    drop proc sp_item_custodia
go
create proc sp_item_custodia (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint  = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_item               tinyint  = null,
   @i_valor_item         descripcion  = null,
   @i_nombre             descripcion = null,
   @i_secuencial	 smallint = null,
   @i_numerocount        tinyint  = null

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int, 
   @w_secservicio        int, 
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo_cust          descripcion,
   @w_custodia           int,
   @w_item               tinyint,
   @w_item_actual        tinyint,
   @w_valor_item         descripcion,
   @w_secuencial  	 smallint,
   @w_numitems    	 tinyint,
   @w_mandatorio  	 char(1),
   @w_codigo_externo  	 varchar(64)

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_item_custodia'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19050 and @i_operacion = 'I') or
   (@t_trn <> 19051 and @i_operacion = 'U') or
   (@t_trn <> 19052 and @i_operacion = 'D') or
   (@t_trn <> 19053 and @i_operacion = 'V') or
   (@t_trn <> 19054 and @i_operacion = 'S') or
   (@t_trn <> 19055 and @i_operacion = 'Q') or
   (@t_trn <> 19056 and @i_operacion = 'A') or
   (@t_trn <> 19057 and @i_operacion = 'C') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/*GENERA SECUENCIAL PARA TRAN DE SERVICIO*/
   select @w_secservicio = @@spid

/* Chequeo de Existencias */
/**************************/
if  @i_operacion <> 'S' and @i_operacion <> 'A'
and @i_operacion <> 'Q' and @i_operacion <> 'D'
begin
   select 
   @w_item       = it_item,
   @w_mandatorio = it_mandatorio
   from cu_item
   where it_tipo_custodia = @i_tipo_cust
   and it_nombre = @i_nombre
   if @@rowcount = 0
   begin
   /* Nombre del item no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901007
      return 1 
   end


  exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                  @w_codigo_externo out




   select 
   @w_filial      = ic_filial,
   @w_sucursal    = ic_sucursal,
   @w_tipo_cust   = ic_tipo_cust,
   @w_custodia    = ic_custodia,
   @w_item_actual = ic_item,
   @w_valor_item  = ic_valor_item,
   @w_secuencial  = ic_secuencial,
   @w_codigo_externo = ic_codigo_externo 
   from cob_custodia..cu_item_custodia
   where 
   ic_codigo_externo = @w_codigo_externo
   and ic_secuencial = @i_secuencial and
   ic_item = @w_item

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_filial is NULL or 
   @i_sucursal is NULL or 
   @i_tipo_cust is NULL or 
   @i_custodia is NULL or 
   @w_item is NULL or
   (@w_mandatorio = 'S' and @i_valor_item is NULL)
        
   begin
      /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end

end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   begin tran
      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                      @w_codigo_externo out


      insert into cu_item_custodia (
      ic_filial, ic_sucursal, ic_tipo_cust,
      ic_custodia, ic_secuencial, ic_item,
      ic_valor_item, ic_codigo_externo)
      values (
      @i_filial, @i_sucursal, @i_tipo_cust,
      @i_custodia, @i_secuencial, @i_item ,
      @i_valor_item, @w_codigo_externo)
   
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
         insert into ts_item_custodia
         values (
         @w_secservicio,@t_trn,'N',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_item', @i_filial,
         @i_sucursal, @i_tipo_cust, @i_custodia,
         @i_item, @i_valor_item, @i_secuencial,
   	 @w_codigo_externo)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903003
            return 1 
         end 
    commit tran 
    return 0
end


/* Actualizacion del registro */
/******************************/
if @i_operacion = 'U'
begin
   begin tran
      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
     @w_codigo_externo out
    -- MVI 07/08/96 cuando luego creo un nuevo item
    if not exists (select ic_item from cu_item_custodia
                  where  ic_item           = @i_item 
                  and    ic_secuencial     = @i_secuencial
                  and    ic_codigo_externo = @w_codigo_externo)
    begin 
       insert into cu_item_custodia(
       ic_filial, ic_sucursal, ic_tipo_cust,
       ic_custodia, ic_item, ic_valor_item,
       ic_secuencial, ic_codigo_externo)
       values (
       @i_filial, @i_sucursal, @i_tipo_cust,
       @i_custodia, @i_item, @i_valor_item,
       @i_secuencial, @w_codigo_externo)

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
       insert into ts_item_custodia
       values 
       (@w_secservicio,@t_trn,'N',
       @s_date,@s_user,@s_term,
       @s_ofi,'cu_item_custodia', @i_filial,
       @i_sucursal, @i_tipo_cust, @i_custodia,
       @i_item, @i_valor_item, @i_secuencial,
       @w_codigo_externo)

       if @@error <> 0 
       begin
       /* Error en insercion de transaccion de servicio */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903003
          return 1 
       end
    end
    else
    begin     --MVI 07/08/96 hasta aqui aumento 
       update cob_custodia..cu_item_custodia
       set 
       ic_valor_item = @i_valor_item
       where 
       ic_filial = @i_filial and
       ic_sucursal = @i_sucursal and
       ic_tipo_cust = @i_tipo_cust and
       ic_custodia = @i_custodia and
       ic_secuencial = @i_secuencial and
       ic_item = @w_item
       if @@error <> 0 
       begin
       /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end

       /* Transaccion de Servicio */
       /***************************/
       insert into ts_item_custodia
       values
      (@w_secservicio,@t_trn,'P',
       @s_date,@s_user,@s_term,
       @s_ofi,'cu_item_custodia', @w_filial,
       @w_sucursal, @w_tipo_cust, @w_custodia,
       @w_item_actual, @w_valor_item, @i_secuencial,
       @w_codigo_externo)

       if @@error <> 0 
       begin
       /* Error en insercion de transaccion de servicio */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903003
          return 1 
       end
       /* Transaccion de Servicio */
       /***************************/
       insert into ts_item_custodia
       values
      (@w_secservicio,@t_trn,'A',
       @s_date,@s_user,@s_term,
       @s_ofi,'cu_item_custodia', @i_filial,
       @i_sucursal, @i_tipo_cust, @i_custodia,
       @w_item, @i_valor_item, @i_secuencial,
       @w_codigo_externo)

       if @@error <> 0 
       begin
         /* Error en insercion de transaccion de servicio */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903003
          return 1 
       end
    end
    commit tran
    return 0
end
   
/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin

    begin tran

      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                      @w_codigo_externo out

       delete cob_custodia..cu_item_custodia
       where 
       ic_codigo_externo = @w_codigo_externo
       and ic_secuencial = @i_secuencial 

       if @@error <> 0
       begin
       /*Error en eliminacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1907001
          return 1 
       end

       update cu_item_custodia
       set ic_secuencial = ic_secuencial - 1
       where 
       ic_codigo_externo = @w_codigo_externo
       and ic_secuencial > @i_secuencial 

       if @@error <> 0 
       begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
        end



       /* Transaccion de Servicio */
         /***************************/
       insert into ts_item_custodia
       values (
       @w_secservicio,@t_trn,'B',
       @s_date,@s_user,@s_term,
       @s_ofi,'cu_item_custodia', @w_filial,
       @w_sucursal, @w_tipo_cust, @w_custodia,
       @w_item_actual, @w_valor_item, @w_secuencial,
       @w_codigo_externo)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
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

    exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                    @w_codigo_externo out

    select max(ic_secuencial)
    from cu_item_custodia
    where ic_codigo_externo = @w_codigo_externo

    return 0
end

/* Busqueda de valores */

if @i_operacion = 'A'
begin
   select @w_tipo_cust = @i_tipo_cust
   if @i_modo = 0
   begin
      select "ITEM"=it_item,
	     "NOMBRE"=it_nombre,
	     "TIPO"=it_tipo_dato,
	     "MANDATORIEDAD"=it_mandatorio,
	     "DESCRIPCION"='                                     ' 
      from cu_item --,cu_item_custodia 
      where it_tipo_custodia  = @w_tipo_cust
      order by it_item
      if @@rowcount = 0
       begin
          return 1 
       end
   end
   if @i_modo = 1
   begin
      select "ITEM"          =it_item,
             "NOMBRE"        =substring(it_nombre,1,100),
             "TIPO"          =it_tipo_dato,
             "MANDATORIEDAD" =it_mandatorio,
             "DESCRIPCION"   ='                                     '
      from cu_item 
      where it_tipo_custodia  = @w_tipo_cust
        and it_item           > @i_item
      order by it_item
      if @@rowcount = 0
       begin
      /* No existen mas registros */
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
         @i_num   = 1901004
           return 1 
       end
   end   
end

/* Busqueda de todas las ocurrencias para la garantia dada */

if @i_operacion = 'S'
begin
    /* Seteo el Contador de Filas */
    if @i_numerocount = 16
       set rowcount 16
    if @i_numerocount = 17
       set rowcount 17
    if @i_numerocount = 18
       set rowcount 18
    if @i_numerocount = 19
       set rowcount 19
    if @i_numerocount = 20
       set rowcount 20
    if @i_numerocount = 21
       set rowcount 21
    if @i_numerocount = 22
       set rowcount 22
    if @i_numerocount = 23
       set rowcount 23
    if @i_numerocount = 24
       set rowcount 24
    if @i_numerocount = 25
       set rowcount 25
    if @i_numerocount = 26
       set rowcount 26
    if @i_numerocount = 27
       set rowcount 27
    if @i_numerocount = 28
       set rowcount 28
    if @i_numerocount = 29
       set rowcount 29
    if @i_numerocount = 30
       set rowcount 30


      select @w_codigo_externo = cu_codigo_externo
      from cu_custodia
      where cu_filial = @i_filial 
      and   cu_sucursal = @i_sucursal
      and   cu_tipo = @i_tipo_cust
      and   cu_custodia = @i_custodia

      select "SECUENCIAL"=ic_secuencial,
             "ITEM"=ic_item,
             "NOMBRE"=substring(it_nombre,1,100),
             "DESCRIPCION"=substring(ic_valor_item,1,100)   --pga 10may2001
       from cu_item,cu_item_custodia 
      where it_tipo_custodia  = @i_tipo_cust   
        and ic_filial         = @i_filial
        and (ic_sucursal       = @i_sucursal or @i_sucursal is null)
        and it_tipo_custodia  = ic_tipo_cust
        and it_item           = ic_item
        --and (ic_custodia       = @i_custodia or (@i_custodia is null))
        and (ic_codigo_externo = @w_codigo_externo)
        and ((ic_secuencial    > @i_secuencial
             or (ic_secuencial = @i_secuencial and ic_item > @i_item)) or
            @i_item is null)
        and ic_secuencial > 0
      order by ic_secuencial,ic_item

end

if @i_operacion = 'C'
begin
    set rowcount 20
       select ic_tipo_cust,
       ic_custodia
       from cu_item_custodia
             left outer join cu_item on
                it_tipo_custodia = ic_tipo_cust
                and it_item      = ic_item
           where ic_filial       = @i_filial
           and ic_sucursal       = @i_sucursal          
           and (ic_valor_item like @i_valor_item
           or @i_valor_item is null)
           and ((ic_tipo_cust > @i_tipo_cust
           or (ic_tipo_cust = @i_tipo_cust
           and ic_custodia > @i_custodia)
           or ic_custodia is null))  

        order by ic_secuencial,it_item
    
      if @@rowcount = 0
      begin
            if @i_custodia is null /* Modo 0 */
               select @w_error  = 1901003
            else
               select @w_error  = 1901004
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
      end 
      return 0
end
go