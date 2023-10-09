/************************************************************************/
/*	Archivo: 	        disponi.sp                              */ 
/*	Stored procedure:       sp_valor_disponible                     */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Patricia Garzon  			*/
/*	Fecha de escritura:     Junio-2000  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa cada vez que se efectua un pago desde Cartera, se */
/*      encargara  actualizar el monto disponible de la(s) garantia(s)  */
/*      que amparan una operacion                                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/jun/05	Pablo Gaibor	Optimizacion			*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_valor_disponible')
    drop proc sp_valor_disponible
go
create proc sp_valor_disponible (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_ofi                smallint    = null,
   @t_trn                smallint    = null,
   @i_operacion          char(1)     = null, 
   @i_monto              float       = null, 
   @i_moneda             int         = null, 
   @i_tramite            int         = null  
)
as
   declare
   @w_tramite            int,    
   @w_producto           catalogo,
   @w_codigo_externo     varchar(64),
   @w_porcentaje         float,
   @w_moneda_gar         tinyint,
   @w_moneda_tr          tinyint,
   @w_moneda_loc         tinyint,  
   @w_valor_mn_pago      float,   
   @w_valor_mg_pago      float,   
   @w_valor_pago         float,
   @w_cobertura          float,
   @w_disponible         float,
   @w_disp               float,
   @w_diferencia         float,
   @w_pago               char(1),
   @w_ban                char(1),
   @w_valor_actual       float,
   @w_cont               int,
   @w_monto              float,     
   @w_cotizacion_pago    money,     
   @w_cotizacion_gar     money,
   @w_sesion		 int

select 	@w_ban 	  = 'S',
	@w_cont   = 1,
	@w_sesion = @@spid*100

delete cob_custodia..cu_tmp_gar_op 
where  tgo_ssn     = @w_sesion 
and    tgo_tramite = @i_tramite

if @i_operacion = 'P' or @i_operacion = 'R' 
begin
   insert into cob_custodia..cu_tmp_gar_op 
   select @w_sesion,      tr_tramite,              tr_producto,    gp_garantia,
          gp_porcentaje,  gp_valor_resp_garantia,  cu_disponible,  cu_pago,
          cu_moneda,      cu_valor_inicial
   from   cob_custodia..cu_custodia,
          cob_credito..cr_gar_propuesta,
          cob_credito..cr_tramite
   where  gp_garantia       = cu_codigo_externo
   and    tr_tramite        = gp_tramite
   and    gp_tramite        = @i_tramite
   and	  tr_tramite        = @i_tramite
   and	  cu_codigo_externo >= '0'
   and	  gp_garantia >= '0'

   select @w_moneda_tr = tr_moneda
   from   cob_credito..cr_tramite
   where  tr_tramite   = @i_tramite

   select @w_moneda_loc = pa_tinyint
   from   cobis..cl_parametro
   where  pa_nemonico   = 'MLOCR'
   set transaction isolation level read uncommitted

   select @w_monto      = @i_monto,
	  @w_valor_pago = @i_monto 
end

if @i_operacion = 'P'
begin
   while @w_ban = 'S' 
   begin
      select @w_diferencia = 0
      set rowcount  1
      select @w_tramite        = tgo_tramite, 
             @w_producto       = tgo_producto, 
             @w_codigo_externo = tgo_garantia, 
             @w_porcentaje     = tgo_porcentaje,  
             @w_cobertura      = tgo_valor_resp, 
             @w_disponible     = tgo_disponible, 
             @w_pago           = tgo_pago,
             @w_moneda_gar     = tgo_moneda, 
             @w_valor_actual   = tgo_valor_actual
      from   cob_custodia..cu_tmp_gar_op 
      where  tgo_ssn 	       = @w_sesion
      and    tgo_tramite       = @i_tramite
      and    (tgo_pago is null or tgo_pago <> 'T')
      order by tgo_porcentaje desc

      if @@rowcount = 0
      begin 
         select  @w_ban = 'N'
         break 
      end 

      set rowcount 0
      select @w_valor_pago = @w_monto
 
      if @i_moneda <> @w_moneda_gar   
      begin 
         if @i_moneda <> @w_moneda_loc   
         begin 
            select @w_cotizacion_pago = cv_valor   
            from   cob_conta..cb_vcotizacion
            where  cv_moneda          = convert(tinyint,@i_moneda) --emg Ene-16-01 optimizacion
            and    cv_fecha           = (select max(cv_fecha) 
                                         from   cob_conta..cb_vcotizacion
                                         where  cv_fecha  <= @s_date
                                         and    cv_moneda =  convert(tinyint,@i_moneda))                        

            select @w_valor_mn_pago = @w_monto * @w_cotizacion_pago
         end 
         else  
            select @w_valor_mn_pago = @w_monto 

         if @w_moneda_gar <> @w_moneda_loc   
         begin 
            select @w_cotizacion_gar = cv_valor   
            from   cob_conta..cb_vcotizacion
            where  cv_moneda         = @w_moneda_gar
            and    cv_fecha          = (select max(cv_fecha) 
                                        from   cob_conta..cb_vcotizacion
                                        where  cv_fecha  <= @s_date
                                        and    cv_moneda =  @w_moneda_gar)                        

            select @w_valor_mg_pago = @w_valor_mn_pago * @w_cotizacion_gar
            select @w_valor_pago    = @w_valor_mg_pago  
         end 
      else 
      begin 
         select @w_valor_mg_pago = @w_valor_mn_pago
         select @w_valor_pago    = @w_valor_mg_pago  
      end  
   end 																																														

   select @w_diferencia = @w_valor_pago + @w_disponible

   if  @w_diferencia >= @w_valor_actual
   begin     
      update cob_custodia..cu_custodia
      set    cu_disponible     =  @w_valor_actual,
             cu_pago           = 'T'   
      where  cu_codigo_externo = @w_codigo_externo 
       
      update cob_custodia..cu_tmp_gar_op 
      set    tgo_pago     = 'T'
      where  tgo_garantia = @w_codigo_externo 
      
      select @w_ban = 'N'
      select @w_valor_pago = @w_valor_pago - (@w_valor_actual - @w_disponible)

      if @i_moneda <> @w_moneda_gar           
      begin 
         if @w_moneda_gar <> @w_moneda_loc   
         begin  
            select @w_valor_pago = @w_valor_pago / @w_cotizacion_gar 
         end
         if @i_moneda <> @w_moneda_loc   
         begin 
            select @w_monto = @w_valor_pago / @w_cotizacion_pago               
         end 
      end 
      else
      begin
         select @w_monto = @w_valor_pago  
      end
      if  @w_diferencia = @w_valor_actual
      begin 
         select @w_monto = 0,	
                @w_ban   = 'N'
      end 
      else  
         select @w_ban = 'S'
      end
  
      if  @w_diferencia < @w_valor_actual
      begin     
         update cob_custodia..cu_custodia
         set    cu_disponible     =  @w_diferencia,
                cu_pago           = 'F' 
         where  cu_codigo_externo = @w_codigo_externo 

         select @w_valor_pago = 0,
                @w_ban        = 'N'
      end
         
      select @w_cont = @w_cont + 1
      if @w_cont = 5
         select @w_ban = 'N'
   end -- While
end -- fin pagos 

if @i_operacion = 'R'
begin
   while @w_ban = 'S' 
   begin
      select @w_diferencia = 0

      set rowcount  1
      select @w_tramite        = tgo_tramite, 
             @w_producto       = tgo_producto, 
             @w_codigo_externo = tgo_garantia, 
             @w_porcentaje     = tgo_porcentaje,  
             @w_cobertura      = tgo_valor_resp, 
             @w_disponible     = tgo_disponible, 
             @w_pago           = tgo_pago,
             @w_moneda_gar     = tgo_moneda, 
             @w_valor_actual   = tgo_valor_actual
      from   cob_custodia..cu_tmp_gar_op 
      where  tgo_ssn           = @w_sesion
      and    tgo_tramite       = @i_tramite
      and    (tgo_pago = 'T' or tgo_pago = 'F')
             order by tgo_porcentaje 

      if @@rowcount = 0
      begin 
         select @w_ban = 'N'
         break 
      end 

      set rowcount 0

      select @w_disp       = @w_valor_actual - @w_cobertura
      select @w_diferencia = @w_disponible   - @w_disp 

      if  @w_valor_pago > @w_diferencia
      begin     
         update cob_custodia..cu_custodia
         set    cu_disponible     = @w_disponible,
                cu_pago           = null
         where  cu_codigo_externo = @w_codigo_externo 
       
         update cob_custodia..cu_tmp_gar_op 
         set    tgo_pago     = null
         where  tgo_garantia = @w_codigo_externo 
       
         select @w_valor_pago = @w_valor_pago - @w_diferencia,
                @w_ban = 'S'
       end
  
       if  @w_valor_pago < @w_diferencia
       begin     
          update cob_custodia..cu_custodia
          set    cu_disponible     =  @w_diferencia,
                 cu_pago           = 'F' 
          where  cu_codigo_externo = @w_codigo_externo 

          select @w_valor_pago = 0,
                 @w_ban        = 'N'
       end

       select @w_cont = @w_cont + 1

       if @w_cont = 5
          select @w_ban = 'N'
   end 
end 
return 0
go

