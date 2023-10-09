

/************************************************************************/
/*  Archivo:              trascart.sp                                   */
/*  Stored procedure:     sp_traslada_cartera                           */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         Julio Cesar Quintero D.                       */
/*  Fecha de escritura:   17/Diciembre/2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                           CAMBIOS                                    */
/*  FECHA      AUTOR          CAMBIO                                    */
/*  Nov-2010   Elcira Pelaez  NR-0059 traslado del valor de diferido    */
/*  Ene-2014   Luisa Bernal   REQ 00375 Traslado cupos cartera          */
/*  Julio-2019 AGO            Trasaldo de Garantias                     */
/*  07-05-2021 ACH            Caso#158146 - Error se actualizaban       */
/*                            operaciones grupales por traspaso de      */
/*                            cliente, cuando tenian el mismo codigo    */
/************************************************************************/

use cob_cartera
go 
if exists (select 1 from sysobjects where name = 'sp_traslada_cartera')
   drop proc sp_traslada_cartera
go
---Inc. 26929 Partiendo de la Ver. 22  jul-27-2011
create proc  sp_traslada_cartera(
   @s_user              login    = null,      
   @s_term              varchar(30) = null,
   @s_date              datetime = null,   
   @s_ofi               int      = null,
   @i_operacion         char(1)  = null,    
   @i_cliente           int      = null,   
   @i_banco             cuenta   = null,   
   @i_oficina_destino   smallint = null,
   @i_oficial_destino   smallint = null,
   @i_en_linea          char(1)  = 'S',
   @i_desde_batch       char(1)  = 'N',
   @i_es_grupo          char(1)  = null
)

as
declare
      @w_sp_name                varchar(32),
      @w_error                  int,
      @w_operacionca            int,
      @w_secuencial             int,
      @w_fecha_proceso          datetime,
      @w_toperacion             catalogo,
      @w_op_moneda              smallint, 
      @w_oficina_origen         int,
      @w_oficina_destino        int,
      @w_op_estado              tinyint,
      @w_cliente                int,
      @w_tipo                   char(1),
      @w_num_registros          int,
      @w_banco                  cuenta,
      @w_rowcount               int,
      @w_est_castigado          tinyint,
      @w_est_novigente          tinyint,
      @w_est_vigente            tinyint,
      @w_est_vencido            tinyint,
      @w_est_cancelado          tinyint,
      @w_est_credito            tinyint,
      @w_est_diferido           int,
      @w_est_anulado            tinyint,
      @w_oficial_origen         smallint,
      @w_oficial_destino        smallint,
      @w_saldo_cap              money,
      @w_fecha_ult_proceso      datetime,
      @w_calificacion           char(1),
      @w_commit                 char(1),
      @w_estado_str             varchar(15),
      @w_msg                    varchar(100),
      @w_bloque                 varchar(20),
      @w_ciudad                 int,
      @w_concepto_cap           catalogo,
      @w_estacion               smallint,
      @w_op_tramite             int , 	  --REQ 00375 TRASLADO TRAMITES CUPO CARTERA
      @w_grupo                  int,
      @w_tramite_grupal         int ,
      @w_monto                  MONEY,
      @w_forma_pago             catalogo	,
      @w_codvalor               INT  ,
      @w_garantia               catalogo,
      @w_gar_cv                 int ,
      @w_gar_valor              money	  
      
--- INICIAR VARIABLES DE TRABAJO 
select  
@w_sp_name       = 'sp_traslada_cartera',
@w_commit        = 'N',
@w_garantia      = 'GAR_DEB'


select 
@w_gar_cv  = cp_codvalor 
from ca_producto where cp_producto = @w_garantia  

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_credito    = @w_est_credito   out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_anulado    = @w_est_anulado  out

select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

---  INSERCION EN CA_TRASLADOS_CARTERA BOTON TRANSMITIR 
if @i_operacion = 'I' begin
             
 
   --- SELECCIONO LA CIUDAD A LA QUE PERTENECE LA OFICINA 
   select @w_ciudad = of_ciudad
   from   cobis..cl_oficina with (nolock)
   where  of_filial  = 1
   and    of_oficina = @i_oficina_destino
   
   if @@rowcount = 0  begin
      select @w_error = 710001, @w_msg = 'ERROR AL DETERMINAR LA CIUDAD A LA QUE PERTENECE LA OFICINA'
      goto ERRORFIN
   end
   
   if ( @i_es_grupo = 'S' )
   begin   
	   --GRUPALES
       declare operaciones cursor for select
       op_operacion,                op_oficial,             op_toperacion,
       op_fecha_ult_proceso,        op_moneda,              op_banco,
       op_calificacion,             op_estado,              op_oficina,
       op_tramite,                  op_cliente
	   from cob_credito..cr_tramite, ca_operacion, cob_credito..cr_tramite_grupal with (nolock)
       where tr_tramite = op_tramite
       and tr_estado not in ('X', 'Z')
       and tg_cliente = @i_cliente
	   and op_operacion = tg_operacion
       and op_estado <> @w_est_cancelado
       and (op_banco = @i_banco or @i_banco is null)

	   union
	   select
       op_operacion,                op_oficial,             op_toperacion,
       op_fecha_ult_proceso,        op_moneda,              op_banco,
       op_calificacion,             op_estado,              op_oficina,
       op_tramite,                  op_cliente                                      
       from ca_operacion  with (nolock)                                   
       where op_cliente = @i_cliente
       and op_toperacion <> 'GRUPAL'
       and (op_banco = @i_banco or @i_banco is null)
       for read only
	   
   end
   else if (@i_es_grupo = 'N')
   begin
       declare operaciones cursor for select
       op_operacion,                op_oficial,             op_toperacion,
       op_fecha_ult_proceso,        op_moneda,              op_banco,
       op_calificacion,             op_estado,              op_oficina,
       op_tramite,                  op_cliente                                      
       from ca_operacion  with (nolock)
       where op_cliente = @i_cliente
       and op_toperacion <> 'GRUPAL'
       and (op_banco = @i_banco or @i_banco is null)
       for read only
   end
   else if (@i_es_grupo is null)
   begin
       declare operaciones cursor for select 
       op_operacion,                op_oficial,             op_toperacion,
       op_fecha_ult_proceso,        op_moneda,              op_banco,
       op_calificacion,             op_estado,              op_oficina,
       op_tramite,                  op_cliente                                      
       from ca_operacion  with (nolock)                                   
       where op_cliente = @i_cliente  
       and op_estado <> @w_est_cancelado
       and (op_banco = @i_banco or @i_banco is null)
       for read only
   end
   
   open  operaciones  
                                        
   fetch operaciones into  
   @w_operacionca,               @w_oficial_origen,         @w_toperacion,
   @w_fecha_ult_proceso,         @w_op_moneda,              @w_banco,
   @w_calificacion,              @w_op_estado,              @w_oficina_origen,                                  
   @w_op_tramite,                @w_cliente   
   
   while @@fetch_status = 0  begin
	  
      exec @w_secuencial =  sp_gen_sec
      @i_operacion       = @w_operacionca
	  
	  select @w_grupo = dc_grupo from ca_det_ciclo where dc_operacion = @w_operacionca
		
      select @w_tramite_grupal = tg_tramite from cob_credito..cr_tramite_grupal where tg_operacion = @w_operacionca

      /* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
      if @@trancount = 0 begin
         select @w_commit = 'S'
         begin tran
      end
      
      --- ACTUALIZACION OFICINA TABLA BASICA 
      update ca_operacion set 
      op_oficina  = @i_oficina_destino,
      op_oficial  = @i_oficial_destino,
      op_ciudad   = @w_ciudad
      where op_operacion = @w_operacionca
   
      if @@error <> 0 begin
         select @w_error = 710002, @w_msg = 'ERROR AL ACTUALIZAR LA OFICINA DE LA OPERACION EN CARTERA'
         goto ERRORFIN
      end
 
      /* SOLO SI HAY TRASLADO DE OFICINA HAY CONTABILIDAD */
      if  @w_oficina_origen <> @i_oficina_destino
      and @w_op_estado in (@w_est_vigente, @w_est_vencido, @w_est_castigado)
      begin
             
         insert into ca_transaccion(
         tr_secuencial,          tr_fecha_mov,                   tr_toperacion,
         tr_moneda,              tr_operacion,                   tr_tran,
         tr_en_linea,            tr_banco,                       tr_dias_calc,
         tr_ofi_oper,            tr_ofi_usu,                     tr_usuario,
         tr_terminal,            tr_fecha_ref,                   tr_secuencial_ref,
         tr_estado,              tr_observacion,                 tr_gerente,
         tr_gar_admisible,       tr_reestructuracion,            tr_calificacion,
         tr_fecha_cont,          tr_comprobante)  
         values(  
         @w_secuencial,          @w_fecha_proceso,               @w_toperacion,
         @w_op_moneda,           @w_operacionca,                 'TCO',
         @i_en_linea,            @w_banco,                       0,
         @w_oficina_origen,      @w_oficina_origen,              @s_user,
         @s_term,                @w_fecha_ult_proceso,           0,
         'ING',                  'TRASLADO DE OFICINA',          @w_oficial_origen,
         '',                     '',                             isnull(@w_calificacion,''),
         '',                     0)

                 
         if @@error <> 0  begin
            select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR LA TRANSACCION DE TRASLADO DE LA OPERACION: ' + @w_banco
            goto ERRORFIN
         end
        
         --- REGISTRAR VALORES QUE SALEN DE LA OFICINA ORIGEN 
         insert into ca_det_trn(
         dtr_secuencial   ,                   dtr_operacion ,       dtr_dividendo    ,
         dtr_concepto     ,                   dtr_periodo   ,       dtr_estado       ,
         dtr_monto        ,                   dtr_monto_mn  ,       dtr_codvalor     ,
         dtr_moneda       ,                   dtr_cotizacion,       dtr_tcotizacion  ,
         dtr_cuenta       ,                   dtr_afectacion,       dtr_beneficiario ,
         dtr_monto_cont)
         select 
         @w_secuencial,                       @w_operacionca,       am_dividendo,
         am_concepto,                         0,                    case am_estado when @w_est_novigente then @w_op_estado else am_estado end,
         -1*sum(am_acumulado-am_pagado),      0,                    co_codigo * 1000 + case am_estado when @w_est_novigente then @w_op_estado else am_estado end * 10,
         @w_op_moneda,                        1,                    'N',
         convert(varchar,@w_oficina_origen),  'D',                  '',
         0
         from ca_amortizacion, ca_concepto 
         where am_operacion = @w_operacionca
         and   am_estado   <> @w_est_cancelado
         and   co_concepto  = am_concepto
         group by am_dividendo, 
                  am_concepto, 
                  case am_estado when @w_est_novigente then @w_op_estado else am_estado end,  
                  co_codigo * 1000 + case am_estado when @w_est_novigente then @w_op_estado else am_estado end * 10
         having sum(am_acumulado - am_pagado) > 0
   
         if @@error <> 0  begin
            select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
            goto ERRORFIN
         end
		 
		--'MONTO DE TRASLADO DE LA GARANTIA LIQUIDA SIMILAR AL BOC'
		 
        select 
		@w_gar_valor      = gl_pag_valor
        from   cob_cartera..ca_garantia_liquida 
        where  gl_cliente = @w_cliente  
        and    gl_grupo   = @w_grupo
        and    gl_tramite = @w_tramite_grupal
		and    gl_pag_estado             = 'CB'
        and    isnull(gl_dev_estado,'X')  <> 'D'
		
		if @@rowcount = 0 select @w_gar_valor = 0 
		
	
		if @w_gar_valor  <> 0 begin  
		
		  --- REGISTRAR VALORES QUE SALEN DE LA OFICINA ORIGEN CA_GARANTIA _LIQUIDA 
            insert into cob_cartera..ca_det_trn(
            dtr_secuencial,     dtr_operacion,         dtr_dividendo,
            dtr_concepto,       dtr_estado,            dtr_periodo,
            dtr_codvalor,       dtr_monto,             dtr_monto_mn,
            dtr_moneda,         dtr_cotizacion,        dtr_tcotizacion,
            dtr_afectacion,     dtr_beneficiario,      dtr_cuenta,
            dtr_monto_cont)
            values(
            @w_secuencial,     @w_operacionca,          0,
            @w_garantia,      1,                        0,
            @w_gar_cv,       -1*@w_gar_valor,          -1*@w_gar_valor,
            @w_op_moneda,     1,                       'N',
            'D',              'CUSTODIA',               convert(varchar,@w_oficina_origen), 
            0.00)
		    
            if @@error <> 0  begin
               select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
               goto ERRORFIN
            end
			
			insert into cob_cartera..ca_det_trn(
            dtr_secuencial,     dtr_operacion,         dtr_dividendo,
            dtr_concepto,       dtr_estado,            dtr_periodo,
            dtr_codvalor,       dtr_monto,             dtr_monto_mn,
            dtr_moneda,         dtr_cotizacion,        dtr_tcotizacion,
            dtr_afectacion,     dtr_beneficiario,      dtr_cuenta,
            dtr_monto_cont)
            values(
            @w_secuencial,     @w_operacionca,         0,
            @w_garantia,       1,                      0,
            @w_gar_cv ,        @w_gar_valor,           @w_gar_valor,
            @w_op_moneda,      1,                      'N',
            'D',               'CUSTODIA',             convert(varchar,@i_oficina_destino), 
            0.00)
		    
            if @@error <> 0  begin
               select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
               goto ERRORFIN
            end
			
		end  
	
   
         --- REGISTRAR VALORES QUE SALEN DE LA OFICINA ORIGEN 
         insert into ca_det_trn(
         dtr_secuencial   ,                dtr_operacion ,       dtr_dividendo    ,
         dtr_concepto     ,                dtr_periodo   ,       dtr_estado       ,
         dtr_monto        ,                dtr_monto_mn  ,       dtr_codvalor     ,
         dtr_moneda       ,                dtr_cotizacion,       dtr_tcotizacion  ,
         dtr_cuenta       ,                dtr_afectacion,       dtr_beneficiario ,
         dtr_monto_cont)
         select 
         @w_secuencial,                    @w_operacionca,       am_dividendo,
         am_concepto,                      0,                    case am_estado when @w_est_novigente then @w_op_estado else am_estado end,
         sum(am_acumulado-am_pagado),      0,                    co_codigo * 1000 + case am_estado when @w_est_novigente then @w_op_estado else am_estado end * 10,
         @w_op_moneda,                     1,                   'N',
         convert(varchar,@i_oficina_destino), 'D',              '',
         0
         from ca_amortizacion, ca_concepto 
         where am_operacion = @w_operacionca
         and   am_estado   <> @w_est_cancelado
         and   co_concepto  = am_concepto
         group by am_dividendo, 
                  am_concepto, 
                  case am_estado when @w_est_novigente then @w_op_estado else am_estado end,  
                  co_codigo * 1000 + case am_estado when @w_est_novigente then @w_op_estado else am_estado end * 10
         having sum(am_acumulado - am_pagado) > 0
   
         if @@error <> 0  begin
            select @w_error = 708165, @w_msg = 'ERROR AL REGISTRAR DETALLES DE SALIDA: ' + @w_banco
            goto ERRORFIN
         end
		 
		
		 
		 if (@i_desde_batch = 'S')
		 begin
		    update ca_traslados_cartera set
		    trc_oficina_destino = @i_oficina_destino,
		    trc_oficial_destino = @i_oficial_destino,
		    trc_estado          = 'P',
		    trc_secuencial_trn  = @w_secuencial
		    where trc_operacion = @w_operacionca
		    and trc_fecha_proceso = @w_fecha_proceso
		 end
		 else
		 begin
		    insert into ca_traslados_cartera (
		    trc_fecha_proceso,          trc_cliente,          trc_operacion,            trc_user,
		    trc_oficina_origen,         trc_oficina_destino,  trc_estado,               trc_garantias,
		    trc_credito,                trc_sidac,            trc_fecha_ingreso,        trc_secuencial_trn,
		    trc_oficial_origen,         trc_oficial_destino,  trc_saldo_capital)
		    values(
		    @w_fecha_proceso,           @i_cliente,           @w_operacionca,           @s_user,
		    @w_oficina_origen,          @i_oficina_destino,   'P',                      'N',
		    'N',		                'N',                  getdate(),                @w_secuencial,
		    @w_oficial_origen,          @i_oficial_destino,   0)
		    
		    if @@error <> 0
		    begin
		      select @w_error = 710001, @w_msg = 'ERROR AL REGISTRAR TRASLADO DE OFICINA: ' + @w_banco
               goto ERRORFIN
		    end
		    
		 end
		 
         if @w_commit = 'S' begin
            commit tran
            select @w_commit = 'N'
         end
		
	  end
	  
	fetch operaciones  into  
	@w_operacionca,                   @w_oficial_origen,              @w_toperacion,
	@w_fecha_ult_proceso,             @w_op_moneda,                   @w_banco,
	@w_calificacion,                  @w_op_estado,                   @w_oficina_origen,
	@w_op_tramite,                    @w_cliente   --REQ 375

   end  -- WHILE CURSOR PRINCIPAL OPERACIONES 

   close operaciones          
   deallocate operaciones   
   

end --Operacion I


return 0

ERRORFIN:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end


if @i_en_linea  = 'S' begin

   exec cobis..sp_cerror
   @t_debug  = 'N',
   @t_file   = null,
   @t_from   = @w_sp_name,
   @i_num    = @w_error,
   @i_msg    = @w_msg
   
end else begin

   exec sp_errorlog 
   @i_fecha     = @s_date,
   @i_error     = @w_error, 
   @i_usuario   = @s_user, 
   @i_tran      = 7999,
   @i_tran_name = @w_sp_name,
   @i_cuenta    = 'GENERAL',
   @i_rollback  = 'N',
   @i_descripcion= @w_msg
   
end

return @w_error

go
