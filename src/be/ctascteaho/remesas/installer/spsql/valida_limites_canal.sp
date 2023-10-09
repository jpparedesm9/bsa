/****************************************************************************/
/*     Archivo:     valida_limites_canal.sp                                 */
/*     Stored procedure: sp_valida_limites_canal                            */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_valida_limites_canal')
  drop proc sp_valida_limites_canal
go
/****** Object:  StoredProcedure sp_valida_limites_canal    Script Date: 11/05/2016 16:53:30 ******/
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE proc sp_valida_limites_canal (
   @s_ssn	             int             = null,
   @s_date	             datetime        = null,
   @s_ofi	             smallint        = null,
   @s_srv	             varchar(30)     = null,
   @s_user	             varchar(30)     = null,
   @s_term	             varchar(10)     = null,
   @s_rol	             int             = null,      
   @t_corr               char(1)         = 'N',
   @t_ssn_corr           varchar(12)     = null,  -- Secuencia de transaccion a reversar
   @t_trn    		     int 		     = null,  
   @i_producto           varchar(16)     = null,
   @i_operacion  	     char(1)		 = null,
   @i_fecha  	         datetime		 = null,
   @i_trn                int             = 0,
   @i_tipo_prod          int             = 0,
   @i_val                money           = 0,
   @i_trn_ext            char(1)         = 'N',
   @i_canal              int             = 0,
   @i_cta                varchar(16)     = null,
   @i_causal             char(5)         = null,                 --- PARAMETRO LIMITES RESTRICTIVOS req 412
   @o_msg                varchar(254)    = null out  
   )  
as  
declare  
   @w_par_cant_trn_cb     int,  
   @w_par_monto_trn_cb    money,  
   @w_sp_name             varchar(32),  
   @w_error               int,  
   @w_num_retiros         int,  
   @w_val_retiro_efec     int,  
   @w_val_retiro_chq      int,  
   @w_num_debitos         tinyint,  
   @w_val_debhoy          money,  
   @w_num_debitos_hoy_ofi tinyint,  
   @w_valor_aut           money,  
   @w_retiro_add          smallint,
   @w_oficina_radicacion  char(1), -- req 412
   @w_origen              char(10),
   @w_especie             char(10),
   @w_num_debitos_hoy     int,
   @w_tx                  varchar(4), --req 412
   @w_val_debitos_hoy     money
     
select @w_sp_name         = 'sp_valida_limites_canal',  
    @w_error              = 0,  
    @w_par_cant_trn_cb    = 0,  
    @w_par_monto_trn_cb   = 0,  
    @w_num_debitos        = 0,  
    @w_val_debhoy         = 0,  
    @w_valor_aut          = 0,  
    @w_retiro_add         = 0,
    @w_oficina_radicacion = 'S' -- req 412
	     
-- REQ 412
if @i_canal = 4 --CAV 21/04/2015 Solo debe validar oficina radicadora cuando se realice por caja
begin
   if exists (select 1
              from   cob_ahorros..ah_cuenta  
              where  ah_cta_banco = @i_cta
              and    ah_oficina   = @s_ofi)
      select @w_oficina_radicacion = 'S'
   else
      select @w_oficina_radicacion = 'N'
end
	
/*REQ  412 APLICACION DE LIMITES A CAUSALES*/
if not exists(select 1
              from   pe_causales_restringidas
              where  cr_tipo_tran = 'D'
              and    cr_causal = @i_causal) -- VERIFICAR SI ES UNA CAUSAL RESTRINGIDA
begin 
   
   select @w_par_cant_trn_cb = 65000, -- SIN LIMITE DE TRANSACCIONES
          @w_par_monto_trn_cb = 922337203685477  -- SIN LIMITE DE MONTO
end
else
begin
   
   select @w_par_cant_trn_cb  = lr_nro_transacciones,
          @w_par_monto_trn_cb = lr_monto_transacciones,
          @w_origen           = lr_origen,
          @w_especie          = lr_especie
   from   pe_causales_restringidas
   inner  join pe_limites_restrictivos on lr_tabla = 0 and lr_tipo_tran = 'D' and lr_origen = cr_origen and lr_especie = cr_especie
   where  cr_tipo_tran = 'D'
   and    cr_causal = @i_causal
   
   if @@rowcount = 0
   begin
      select @w_error = 2609859, @o_msg = 'NO EXISTE CONFIGURACION DE LIMITES PARA LA CAUSAL ' + @i_causal
      goto ERROR
   end
   
  
    
    select @w_num_debitos_hoy  = isnull(sum((case tm_correccion
												when 'N' then 1
												when 'S' then -1
												end)), 0),
		  @w_val_debitos_hoy  = isnull(sum((case tm_correccion
											when 'N' then isnull(tm_valor, 0)
											when 'S' then isnull(-tm_valor, 0)
											end)), 0)
	   from cob_ahorros..ah_tran_monet
	   where  tm_cta_banco = @i_cta
	   and    tm_fecha     = @i_fecha
	   and    tm_signo     = 'D'
	   and    tm_estado is null
	   and    tm_causa   in(select cr_causal 
							from cob_remesas..pe_causales_restringidas
							where cr_especie = @w_especie
							and   cr_origen  = @w_origen )

   if (1 + @w_num_debitos_hoy) > @w_par_cant_trn_cb
   begin
      select @w_error = 2609862, @o_msg = 'VALOR SUPERA EL NUMERO MAXIMO DE TRANSACCIONES DESDE CANAL'
      goto ERROR
   end
   
   if (@i_val + @w_val_debitos_hoy) > @w_par_monto_trn_cb
   begin
      select @w_error = 2609861, @o_msg = 'VALOR SUPERA MONTO PERMITIDO PARA TRANSACCIONES DESDE CANAL'
      goto ERROR
   end
end

--se verifica si la transacci¾n debe evaluarse para topes de oficinac REQ 412
select @w_tx = codigo 
from cobis..cl_tabla 
where tabla  = 'pe_tx_topes_oficina'

if exists (select 1 from cobis..cl_catalogo where tabla = @w_tx and codigo = @i_trn and estado = 'V')
   return 0

--se verifica si la causal debe evaluarse para topes de producto REQ 412
if not exists (select 1 from cob_remesas..pe_causales_restringidas
               where cr_especie in (select c.codigo from cobis..cl_tabla t, cobis..cl_catalogo c
                                where t.tabla  = 'cl_medio_pago'
                                and   t.codigo = c.tabla
                                and   c.estado = 'V')
           and cr_causal = @i_causal)
begin   
   return 0 -- terminar sin validaciones adicionales.
end

-- validaci¾n de autorizaci¾n
select @w_valor_aut = isnull(ar_valor,0)  
from   cob_ahorros..ah_aut_retiro_ofic  
where ar_cta_banco =  @i_cta  
and   convert(datetime, ar_fecha, 103)  = convert(datetime, @i_fecha, 103)  
and   ar_forma_pago = 'E'  
and   ar_estado = 'V'  


-- TOPES MAXIMOS DE RETIRO
-- SELECCION DE CAMPOS SEGUN SEA OFICINA ORIGEN U OTRA REQ 412
if @w_oficina_radicacion = 'S'
begin
   select @w_num_retiros     = isnull(to_cantidad,0),  
          @w_val_retiro_efec = (case when to_mar_efec = 'S' then isnull(to_vlr_efec,0) else null end),  
          @w_val_retiro_chq  = (case when to_mar_chq = 'S' then isnull(to_vlr_chq,0) else null end)  
   from  cob_remesas..pe_tope_oficina  
   where to_tipo_prod = @i_tipo_prod  
end
ELSE
begin
   select @w_num_retiros     = isnull(to_cantidad,0),  
          @w_val_retiro_efec = (case when to_mar_efec_otra = 'S' then isnull(to_vlr_efec_otra, 0) else null end),  
          @w_val_retiro_chq  = (case when to_mar_chq_otra = 'S' then isnull(to_vlr_chq_otra, 0) else null end)  
   from  cob_remesas..pe_tope_oficina  
   where to_tipo_prod = @i_tipo_prod
end


-- TRANSACCIONES EN EFECTIVO
select tipo_tran   = tm_tipo_tran,
       causa       = tm_causa,
       num_debitos = (case tm_correccion 
                             when 'N' then count(1)
                             when 'S' then count(1)-1
                      end), 
       val_debhoy  = (case tm_correccion 
                             when 'N' then isnull(sum(isnull(tm_valor,0)),0)
                             when 'S' then isnull(sum(isnull(tm_valor * -1,0)),0)
                      end),
       medio_pago = 'EFE'
into #transacciones
from cob_ahorros..ah_tran_monet
where tm_fecha = @i_fecha
and   (tm_tipo_tran  in (263,371) or (tm_tipo_tran = 264 and tm_causa in (select cr_causal
                                                                          from cob_remesas..pe_causales_restringidas
                                                                          where cr_especie in (select c.codigo 
                                                                          from cobis..cl_tabla t, cobis..cl_catalogo c
                                                                          where t.tabla  = 'cl_medio_pago'
                                                                          and   t.codigo = c.tabla
                                                                          and   c.estado = 'V'))))
and   tm_estado is null
and   tm_cta_banco  = @i_cta
group by tm_correccion, tm_tipo_tran, tm_causa       

-- TRANSACCIONES EN CHEQUE
insert into #transacciones
select tipo_tran   = tm_tipo_tran,
       causa       = tm_causa,
       num_debitos = (case tm_correccion 
                             when 'N' then count(1)
                             when 'S' then count(1)-1
                      end),
       val_debhoy  = (case tm_correccion 
	                         when 'N' then isnull(sum(isnull(tm_valor,0)),0)
                             when 'S' then isnull(sum(isnull(tm_valor * -1,0)),0)
                      end),
       medio_pago = 'CHQ'
from cob_ahorros..ah_tran_monet
where tm_fecha = @i_fecha
and   tm_tipo_tran  = 380
and   tm_estado is null
and   tm_cta_banco  = @i_cta
group by tm_correccion, tm_tipo_tran, tm_causa

select @w_num_debitos = sum(num_debitos) 
from #transacciones


if @@rowcount = 0
   select @w_num_debitos = 0

if @w_val_retiro_efec > 0 and @i_trn in (263,371,264)
begin
   if @w_valor_aut > 0  --SI EXISTEN AUTORIZACIONES
   begin
      if isnull(@i_val,0) <> @w_valor_aut
      begin
         if @i_canal = 4
            select @w_error = 357526, @o_msg = 'VALOR DE RETIRO NO AUTORIZADO PARA LA CUENTA'
         else
            select @w_error = 2609861, @o_msg = 'VALOR SUPERA MONTO PERMITIDO PARA TRANSACCIONES DESDE CANAL' 
         
         goto ERROR 
      end
	  
      update cob_ahorros..ah_aut_retiro_ofic set ar_estado = 'U'
      where ar_cta_banco =  @i_cta
      and   convert(datetime, ar_fecha, 103)  = convert(datetime, @i_fecha, 103)
      and   ar_forma_pago = 'E'
      and   ar_estado = 'V'

      if @@error <> 0
      begin
         select @w_error = 2105001, @o_msg = 'ERROR ACTUALIZANDO AUTORIZACION DE RETIRO'
         goto ERROR
      end
   end
   else -- NO EXISTEN AUTORIZACIONES
   begin
      select @w_val_debhoy  = sum(val_debhoy)
      from #transacciones
      where medio_pago = 'EFE'
      
      if @@rowcount = 0
         select @w_val_debhoy = 0
      
      if ( (isnull(@w_val_debhoy,0) + isnull(@i_val,0)) > @w_val_retiro_efec )
      begin
         if @i_canal = 4
            select @w_error = 357526, @o_msg = 'MONTO DE RETIRO EXCEDIDO PARA LA CUENTA'
         else
            select @w_error = 2609861, @o_msg = 'VALOR SUPERA MONTO PERMITIDO PARA TRANSACCIONES DESDE CANAL'
         goto ERROR
      end
   end
end

if @w_val_retiro_chq > 0 and @i_trn in (380)
begin

   select @w_valor_aut = isnull(ar_valor,0)
   from cob_ahorros..ah_aut_retiro_ofic
   where ar_cta_banco =  @i_cta
   and   ar_fecha  = @i_fecha
   and   ar_forma_pago = 'C'
   and   ar_estado = 'V'
   
   if @w_valor_aut > 0  --SI EXISTEN AUTORIZACIONES
   begin
      if  isnull(@i_val,0) <> @w_valor_aut
      begin
         if @i_canal = 4
            select @w_error = 357526, @o_msg = 'VALOR DE RETIRO NO AUTORIZADO PARA LA CUENTA'
         else
            select @w_error = 2609861, @o_msg = 'VALOR SUPERA MONTO PERMITIDO PARA TRANSACCIONES DESDE CANAL'
         goto ERROR
      end
	  
      update cob_ahorros..ah_aut_retiro_ofic set ar_estado = 'U'
      where ar_cta_banco =  @i_cta
      and   ar_fecha  = @i_fecha
      and   ar_forma_pago = 'C'
      and   ar_estado = 'V'

      if @@error <> 0
      begin
         select @w_error = 2105001, @o_msg = 'ERROR ACTUALIZANDO AUTORIZACION DE RETIRO'
         goto ERROR
      end
   end
   else -- NO EXISTEN AUTORIZACIONES
   begin
      select @w_val_debhoy  = sum(val_debhoy)
      from #transacciones
      where medio_pago = 'CHQ'
      
      if @@rowcount = 0
         select @w_val_debhoy = 0
		 

	  
      if ((isnull(@w_val_debhoy,0) + isnull(@i_val,0)) > @w_val_retiro_chq)
      begin
         if @i_canal = 4
            select @w_error = 357526, @o_msg = 'MONTO DE RETIRO EXCEDIDO PARA LA CUENTA'
         else
            select @w_error = 2609861, @o_msg = 'VALOR SUPERA MONTO PERMITIDO PARA TRANSACCIONES DESDE CANAL'  
         goto ERROR
      end
   end
end

if @i_canal = 4 
begin

   select @w_num_debitos_hoy_ofi  = sum(num_debitos)
   from #transacciones
   where medio_pago in ('EFE','CHQ')
   and tipo_tran in (263, 371, 380, 264)
   
   if @@rowcount = 0
      select @w_num_debitos_hoy_ofi = 0
	  
   if (@w_num_retiros is not null) and (@w_num_debitos_hoy_ofi >= @w_num_retiros)	  
   begin   
      /* VERIFICAR AUTORIZACIONES PARA RETIRO - NUMERO */
      select @w_retiro_add = isnull(sum(isnull(ar_retiro_add,0)),0)
      from cob_ahorros..ah_aut_retiro_ofic
      where ar_cta_banco = @i_cta
      and   ar_fecha  = @i_fecha
      and   ar_forma_pago in ('E','C')
      and   ar_estado <> 'B'
	
      if @w_num_debitos_hoy_ofi >= (@w_num_retiros + @w_retiro_add)
      begin
         select @w_error = 357525, @o_msg = 'NUMERO DE RETIROS EXCEDIDO PARA LA CUENTA'
         goto ERROR
      end
	  
      update cob_ahorros..ah_aut_retiro_ofic set ar_estado = 'U'
      where ar_cta_banco =  @i_cta
      and   ar_fecha  = @i_fecha
      and   ar_forma_pago in ('C','E')
      and   ar_estado = 'V'

      if @@error <> 0
      begin
         select @w_error = 2105001, @o_msg = 'ERROR ACTUALIZANDO AUTORIZACION DE RETIRO'
         goto ERROR
      end  
   end
end
else
begin
   select @w_num_debitos_hoy_ofi  = sum(num_debitos)
   from #transacciones
   where medio_pago in ('EFE','CHQ')
   and tipo_tran in (263, 371, 380, 264)
   
   if @@rowcount = 0
      select @w_num_debitos_hoy_ofi = 0
	  
   if @w_num_debitos_hoy_ofi >= @w_num_retiros
      begin
         select @w_error = 357525, @o_msg = 'NUMERO DE RETIROS EXCEDIDO PARA LA CUENTA'
         goto ERROR
      end
end

ERROR:
if @w_error is null
   select @w_error = 2699999, @o_msg = 'ERROR DESCONOCIDO'

return @w_error


go
