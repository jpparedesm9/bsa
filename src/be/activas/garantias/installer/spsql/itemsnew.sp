/************************************************************************/
/*	Archivo: 	        itemsnew.sp                             */
/*	Stored procedure:       sp_items_new                            */
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
/*	Nov/1995   L. Castellanos    Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_items_new')
    drop proc sp_items_new    
go
create proc sp_items_new  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
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
   @i_numerocount        tinyint  = null,
   @i_nombre1            descripcion = null,  
   @i_valor_item1        descripcion = null,
   @i_nombre2            descripcion = null,  
   @i_valor_item2        descripcion = null,
   @i_nombre3            descripcion = null,  
   @i_valor_item3        descripcion = null,
   @i_nombre4            descripcion = null,  
   @i_valor_item4        descripcion = null,
   @i_nombre5            descripcion = null,  
   @i_valor_item5        descripcion = null,
   @i_nombre6            descripcion = null,  
   @i_valor_item6        descripcion = null,
   @i_nombre7            descripcion = null,  
   @i_valor_item7        descripcion = null,
   @i_nombre8            descripcion = null,  
   @i_valor_item8        descripcion = null,
   @i_nombre9            descripcion = null,  
   @i_valor_item9        descripcion = null,
   @i_nombre10           descripcion = null,  
   @i_valor_item10       descripcion = null,
   @i_nombre11           descripcion = null,  
   @i_valor_item11       descripcion = null,
   @i_nombre12            descripcion = null,  
   @i_valor_item12        descripcion = null,
   @i_nombre13            descripcion = null,  
   @i_valor_item13        descripcion = null,
   @i_nombre14            descripcion = null,  
   @i_valor_item14        descripcion = null,
   @i_nombre15            descripcion = null,  
   @i_valor_item15        descripcion = null,
   @i_nombre16            descripcion = null,  
   @i_valor_item16        descripcion = null,
   @i_nombre17            descripcion = null,  
   @i_valor_item17        descripcion = null,
   @i_nombre18            descripcion = null,  
   @i_valor_item18        descripcion = null,
   @i_nombre19            descripcion = null,  
   @i_valor_item19        descripcion = null,
   @i_nombre20            descripcion = null,  
   @i_valor_item20        descripcion = null,
   @i_nombre21            descripcion = null,  
   @i_valor_item21        descripcion = null,
   @i_nombre22            descripcion = null,  
   @i_valor_item22        descripcion = null,
   @i_nombre23            descripcion = null,  
   @i_valor_item23        descripcion = null,
   @i_nombre24            descripcion = null,  
   @i_valor_item24        descripcion = null,
   @i_nombre25            descripcion = null,  
   @i_valor_item25        descripcion = null,
   @i_nombre26            descripcion = null,  
   @i_valor_item26        descripcion = null,
   @i_nombre27            descripcion = null,  
   @i_valor_item27        descripcion = null,
   @i_nombre28            descripcion = null,  
   @i_valor_item28        descripcion = null,
   @i_nombre29            descripcion = null,  
   @i_valor_item29        descripcion = null,
   @i_nombre30            descripcion = null,  
   @i_valor_item30        descripcion = null,
   @i_items               tinyint     = null

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int, 
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo_cust          descripcion,
   @w_custodia           int,
   @w_item               tinyint,
   @w_item_actual        tinyint,
   @w_valor_item         descripcion,
   @w_nombre             descripcion,
   @w_secuencial  	 smallint,
   @w_numitems    	 tinyint,
   @w_mandatorio  	 char(1),
   @w_codigo_externo  	 varchar(64),
   @v_nombre             varchar(30),
   @v_valor_item         varchar(30),
   @w                    tinyint

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_items_new'

/***********************************************************/
/* Codigos de Transacciones                                */
/*if (@t_trn <> 19753 and @i_operacion = 'I') or
   (@t_trn <> 19754 and @i_operacion = 'U') */


if (@t_trn <> 19750 and @i_operacion = 'I') or
   (@t_trn <> 19751 and @i_operacion = 'U') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I' 
begin



  


   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                       @w_codigo_externo out

   --emg May-26-04 insertar seguro por cambio de valor en construccion

     delete cob_cartera..ca_seguros_base_garantia 
     from cob_credito..cr_gar_propuesta
     where sg_tipo_garantia = @i_tipo_cust
     and sg_tramite = gp_tramite
     and gp_garantia = @w_codigo_externo
     and sg_tramite > 0
     and sg_fecha_reg > ''
     and sg_tipo_garantia > ''

    insert into cob_cartera..ca_seguros_base_garantia
    select gp_tramite ,@s_date,@i_tipo_cust
    from   cob_credito..cr_gar_propuesta
    where  gp_garantia = @w_codigo_externo


   if exists (select 1 from cob_cartera..ca_seguros_base_garantia, cob_credito..cr_gar_propuesta
              where sg_tipo_garantia = @i_tipo_cust
              and sg_tramite = gp_tramite
              and gp_garantia = @w_codigo_externo
              and sg_fecha_reg > ''
              and sg_tipo_garantia > '')
     begin 
        update cob_cartera..ca_seguros_base_garantia  
        set sg_fecha_reg = @s_date 
        from cob_credito..cr_gar_propuesta
        where sg_tramite = gp_tramite        
        and  gp_garantia = @w_codigo_externo
        and sg_fecha_reg > ''
        and sg_tipo_garantia > ''
     end


   select @w = 0
   while @w < @i_items
   begin
      select @w = @w + 1
      select @v_nombre = '@i_nombre' + convert(varchar(2),@w)
      select @v_valor_item = '@i_valor_item' + convert(varchar(2),@w)

      if @v_nombre = '@i_nombre1' and @v_valor_item = '@i_valor_item1'
         select @w_nombre = @i_nombre1,@w_valor_item = @i_valor_item1
      else 
      if @v_nombre = '@i_nombre2' and @v_valor_item = '@i_valor_item2'
         select @w_nombre = @i_nombre2,@w_valor_item = @i_valor_item2
      else
      if @v_nombre = '@i_nombre3' and @v_valor_item = '@i_valor_item3'
         select @w_nombre = @i_nombre3,@w_valor_item = @i_valor_item3
      else
      if @v_nombre = '@i_nombre4' and @v_valor_item = '@i_valor_item4'
         select @w_nombre = @i_nombre4,@w_valor_item = @i_valor_item4
      else
      if @v_nombre = '@i_nombre5' and @v_valor_item = '@i_valor_item5'
         select @w_nombre = @i_nombre5,@w_valor_item = @i_valor_item5
      else
      if @v_nombre = '@i_nombre6' and @v_valor_item = '@i_valor_item6'
         select @w_nombre = @i_nombre6,@w_valor_item = @i_valor_item6
      else
      if @v_nombre = '@i_nombre7' and @v_valor_item = '@i_valor_item7'
         select @w_nombre = @i_nombre7,@w_valor_item = @i_valor_item7
      else
      if @v_nombre = '@i_nombre8' and @v_valor_item = '@i_valor_item8'
         select @w_nombre = @i_nombre8,@w_valor_item = @i_valor_item8
      else
      if @v_nombre = '@i_nombre9' and @v_valor_item = '@i_valor_item9'
         select @w_nombre = @i_nombre9,@w_valor_item = @i_valor_item9
      else
      if @v_nombre = '@i_nombre10' and @v_valor_item = '@i_valor_item10'
         select @w_nombre = @i_nombre10,@w_valor_item = @i_valor_item10
      else
      if @v_nombre = '@i_nombre11' and @v_valor_item = '@i_valor_item11'
         select @w_nombre = @i_nombre11,@w_valor_item = @i_valor_item11
      else 
      if @v_nombre = '@i_nombre12' and @v_valor_item = '@i_valor_item12'
         select @w_nombre = @i_nombre12,@w_valor_item = @i_valor_item12
      else
      if @v_nombre = '@i_nombre13' and @v_valor_item = '@i_valor_item13'
         select @w_nombre = @i_nombre13,@w_valor_item = @i_valor_item13
      else
      if @v_nombre = '@i_nombre14' and @v_valor_item = '@i_valor_item14'
         select @w_nombre = @i_nombre14,@w_valor_item = @i_valor_item14
      else
      if @v_nombre = '@i_nombre15' and @v_valor_item = '@i_valor_item15'
         select @w_nombre = @i_nombre15,@w_valor_item = @i_valor_item15
      else
      if @v_nombre = '@i_nombre16' and @v_valor_item = '@i_valor_item16'
         select @w_nombre = @i_nombre16,@w_valor_item = @i_valor_item16
      else
      if @v_nombre = '@i_nombre17' and @v_valor_item = '@i_valor_item17'
         select @w_nombre = @i_nombre17,@w_valor_item = @i_valor_item17
      else
      if @v_nombre = '@i_nombre18' and @v_valor_item = '@i_valor_item18'
         select @w_nombre = @i_nombre18,@w_valor_item = @i_valor_item18
      else
      if @v_nombre = '@i_nombre19' and @v_valor_item = '@i_valor_item19'
         select @w_nombre = @i_nombre19,@w_valor_item = @i_valor_item19
      else
      if @v_nombre = '@i_nombre20' and @v_valor_item = '@i_valor_item20'
         select @w_nombre = @i_nombre20,@w_valor_item = @i_valor_item20
      else
      if @v_nombre = '@i_nombre21' and @v_valor_item = '@i_valor_item21'
         select @w_nombre = @i_nombre21,@w_valor_item = @i_valor_item21
      else 
      if @v_nombre = '@i_nombre22' and @v_valor_item = '@i_valor_item22'
         select @w_nombre = @i_nombre22,@w_valor_item = @i_valor_item22
      else
      if @v_nombre = '@i_nombre23' and @v_valor_item = '@i_valor_item23'
         select @w_nombre = @i_nombre23,@w_valor_item = @i_valor_item23
      else
      if @v_nombre = '@i_nombre24' and @v_valor_item = '@i_valor_item24'
         select @w_nombre = @i_nombre24,@w_valor_item = @i_valor_item24
      else
      if @v_nombre = '@i_nombre25' and @v_valor_item = '@i_valor_item25'
         select @w_nombre = @i_nombre25,@w_valor_item = @i_valor_item25
      else
      if @v_nombre = '@i_nombre26' and @v_valor_item = '@i_valor_item26'
         select @w_nombre = @i_nombre26,@w_valor_item = @i_valor_item26
      else
      if @v_nombre = '@i_nombre27' and @v_valor_item = '@i_valor_item27'
         select @w_nombre = @i_nombre27,@w_valor_item = @i_valor_item27
      else
      if @v_nombre = '@i_nombre28' and @v_valor_item = '@i_valor_item28'
         select @w_nombre = @i_nombre28,@w_valor_item = @i_valor_item28
      else
      if @v_nombre = '@i_nombre29' and @v_valor_item = '@i_valor_item29'
         select @w_nombre = @i_nombre29,@w_valor_item = @i_valor_item29
      else
      if @v_nombre = '@i_nombre30' and @v_valor_item = '@i_valor_item30'
         select @w_nombre = @i_nombre30,@w_valor_item = @i_valor_item30
if @w_nombre is not null
begin
      exec @w_return = sp_item_custodia
      @t_trn        = 19050,
      --@s_ssn        = @s_ssn,
      @s_term       = @s_term,
      @s_date       = @s_date,
      @i_operacion  = 'I',            
      @i_filial     = @i_filial,
      @i_sucursal   = @i_sucursal,
      @i_tipo_cust  = @i_tipo_cust,
      @i_custodia   = @i_custodia,
      @i_secuencial = @i_secuencial,
      @i_item       = @w,
      @i_nombre     = @w_nombre,
      @i_valor_item = @w_valor_item

      if @w_return != 0
      begin
       /*  Error de ejecucion  */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909002 
         return 1 
      end 

end  
   end    -- While
   return 0
end

if @i_operacion = 'U' 
begin


       exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                       @w_codigo_externo out


   --emg May-26-04 insertar seguro por cambio de valor en construccion

     delete cob_cartera..ca_seguros_base_garantia 
     from cob_credito..cr_gar_propuesta
     where sg_tipo_garantia = @i_tipo_cust
     and sg_tramite = gp_tramite
     and gp_garantia = @w_codigo_externo
     and sg_tramite > 0
     and sg_fecha_reg > ''
     and sg_tipo_garantia > ''

    insert into cob_cartera..ca_seguros_base_garantia
    select gp_tramite ,@s_date,@i_tipo_cust
    from   cob_credito..cr_gar_propuesta
    where  gp_garantia = @w_codigo_externo

   select @w = 0
   while @w < @i_items
   begin
      select @w = @w + 1
      select @v_nombre = '@i_nombre' + convert(varchar(2),@w)
      select @v_valor_item = '@i_valor_item' + convert(varchar(2),@w)

      if @v_nombre = '@i_nombre1' and @v_valor_item = '@i_valor_item1'
         select @w_nombre = @i_nombre1,@w_valor_item = @i_valor_item1
      else 
      if @v_nombre = '@i_nombre2' and @v_valor_item = '@i_valor_item2'
         select @w_nombre = @i_nombre2,@w_valor_item = @i_valor_item2
      else
      if @v_nombre = '@i_nombre3' and @v_valor_item = '@i_valor_item3'
         select @w_nombre = @i_nombre3,@w_valor_item = @i_valor_item3
      else
      if @v_nombre = '@i_nombre4' and @v_valor_item = '@i_valor_item4'
         select @w_nombre = @i_nombre4,@w_valor_item = @i_valor_item4
      else
      if @v_nombre = '@i_nombre5' and @v_valor_item = '@i_valor_item5'
         select @w_nombre = @i_nombre5,@w_valor_item = @i_valor_item5
      else
      if @v_nombre = '@i_nombre6' and @v_valor_item = '@i_valor_item6'
         select @w_nombre = @i_nombre6,@w_valor_item = @i_valor_item6
      else
      if @v_nombre = '@i_nombre7' and @v_valor_item = '@i_valor_item7'
         select @w_nombre = @i_nombre7,@w_valor_item = @i_valor_item7
      else
      if @v_nombre = '@i_nombre8' and @v_valor_item = '@i_valor_item8'
         select @w_nombre = @i_nombre8,@w_valor_item = @i_valor_item8
      else
      if @v_nombre = '@i_nombre9' and @v_valor_item = '@i_valor_item9'
         select @w_nombre = @i_nombre9,@w_valor_item = @i_valor_item9
      else
      if @v_nombre = '@i_nombre10' and @v_valor_item = '@i_valor_item10'
         select @w_nombre = @i_nombre10,@w_valor_item = @i_valor_item10
      else
      if @v_nombre = '@i_nombre11' and @v_valor_item = '@i_valor_item11'
         select @w_nombre = @i_nombre11,@w_valor_item = @i_valor_item11
      else 
      if @v_nombre = '@i_nombre12' and @v_valor_item = '@i_valor_item12'
         select @w_nombre = @i_nombre12,@w_valor_item = @i_valor_item12
      else
      if @v_nombre = '@i_nombre13' and @v_valor_item = '@i_valor_item13'
         select @w_nombre = @i_nombre13,@w_valor_item = @i_valor_item13
      else
      if @v_nombre = '@i_nombre14' and @v_valor_item = '@i_valor_item14'
         select @w_nombre = @i_nombre14,@w_valor_item = @i_valor_item14
      else
      if @v_nombre = '@i_nombre15' and @v_valor_item = '@i_valor_item15'
         select @w_nombre = @i_nombre15,@w_valor_item = @i_valor_item15
      else
      if @v_nombre = '@i_nombre16' and @v_valor_item = '@i_valor_item16'
         select @w_nombre = @i_nombre16,@w_valor_item = @i_valor_item16
      else
      if @v_nombre = '@i_nombre17' and @v_valor_item = '@i_valor_item17'
         select @w_nombre = @i_nombre17,@w_valor_item = @i_valor_item17
      else
      if @v_nombre = '@i_nombre18' and @v_valor_item = '@i_valor_item18'
         select @w_nombre = @i_nombre18,@w_valor_item = @i_valor_item18
      else
      if @v_nombre = '@i_nombre19' and @v_valor_item = '@i_valor_item19'
         select @w_nombre = @i_nombre19,@w_valor_item = @i_valor_item19
      else
      if @v_nombre = '@i_nombre20' and @v_valor_item = '@i_valor_item20'
         select @w_nombre = @i_nombre20,@w_valor_item = @i_valor_item20
      else
      if @v_nombre = '@i_nombre21' and @v_valor_item = '@i_valor_item21'
         select @w_nombre = @i_nombre21,@w_valor_item = @i_valor_item21
      else 
      if @v_nombre = '@i_nombre22' and @v_valor_item = '@i_valor_item22'
         select @w_nombre = @i_nombre22,@w_valor_item = @i_valor_item22
      else
      if @v_nombre = '@i_nombre23' and @v_valor_item = '@i_valor_item23'
         select @w_nombre = @i_nombre23,@w_valor_item = @i_valor_item23
      else
      if @v_nombre = '@i_nombre24' and @v_valor_item = '@i_valor_item24'
         select @w_nombre = @i_nombre24,@w_valor_item = @i_valor_item24
      else
      if @v_nombre = '@i_nombre25' and @v_valor_item = '@i_valor_item25'
         select @w_nombre = @i_nombre25,@w_valor_item = @i_valor_item25
      else
      if @v_nombre = '@i_nombre26' and @v_valor_item = '@i_valor_item26'
         select @w_nombre = @i_nombre26,@w_valor_item = @i_valor_item26
      else
      if @v_nombre = '@i_nombre27' and @v_valor_item = '@i_valor_item27'
         select @w_nombre = @i_nombre27,@w_valor_item = @i_valor_item27
      else
      if @v_nombre = '@i_nombre28' and @v_valor_item = '@i_valor_item28'
         select @w_nombre = @i_nombre28,@w_valor_item = @i_valor_item28
      else
      if @v_nombre = '@i_nombre29' and @v_valor_item = '@i_valor_item29'
         select @w_nombre = @i_nombre29,@w_valor_item = @i_valor_item29
      else
      if @v_nombre = '@i_nombre30' and @v_valor_item = '@i_valor_item30'
         select @w_nombre = @i_nombre30,@w_valor_item = @i_valor_item30
if @w_nombre is not null
begin

      exec @w_return = sp_item_custodia
      @t_trn        = 19051,
      --@s_ssn        = @s_ssn,
      @s_term       = @s_term,
      @s_date       = @s_date,
      @i_operacion  = 'U',            
      @i_filial     = @i_filial,
      @i_sucursal   = @i_sucursal,
      @i_tipo_cust  = @i_tipo_cust,
      @i_custodia   = @i_custodia,
      @i_secuencial = @i_secuencial,
      @i_item       = @w,
      @i_nombre     = @w_nombre,
      @i_valor_item = @w_valor_item

      if @w_return != 0
      begin
       /*  Error de ejecucion  */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909002 
         return 1 
      end 
end
  
   end    -- While
   return 0
end
go