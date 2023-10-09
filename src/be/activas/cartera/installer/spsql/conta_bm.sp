/************************************************************************/
/*   Stored procedure:     sp_caconta_bm                               */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_caconta_bm')
   drop proc sp_caconta_bm
go
 
CREATE proc [dbo].[sp_caconta_bm]

   @s_user              login       = 'admcar',
   @i_simulacion        char(1)     = 'N',
   @i_debug             char(1)     = 'N',
   @i_paralelismo       char(1)     = 'N',  -- FYA*
   @i_fecha             datetime    = null,   
   @i_filial            int         = null,
   @i_opcion_trn        varchar(10) = null,
   @i_tipo_trn          varchar(10) = null,
   @i_opcion_banco      varchar(10) = null,
   @i_banco             varchar(10) = null,
   @i_causacion         varchar(10) = null,
   @i_proceso           int         = null

as declare
   @w_error          	int,
   @w_mon_nac           int,
   @w_num_dec_mn        int,
   @w_ar_origen         int,
   @w_asiento           int,
   @w_comprobante       int,
   @w_debcred           int,
   @w_oficina           smallint,
   @w_re_ofconta        int,
   @w_ascii             tinyint,
   @w_fecha_proceso     smalldatetime,
   @w_fecha_desde       smalldatetime,
   @w_fecha_hasta       smalldatetime,
   @w_fecha_conta       smalldatetime,
   @w_mensaje           varchar(255),
   @w_descripcion       varchar(255),
   @w_concepto          varchar(255),
   @w_cuenta_final      varchar(40),
   @w_cuenta_aux        varchar(40),
   @w_trama             varchar(40),
   @w_resultado         varchar(40),
   @w_sp_name        	descripcion,
   @w_cotizacion        float,
   @w_perfil            catalogo,
   @w_of_origen_cur     int,
   @w_of_destino_cur    int,
   @w_fecha_val_cur     datetime,
   @w_fecha_pro_cur     datetime,
   @w_tran_cur          catalogo,
   @w_moneda_cur        int,
   @w_toperacion_cur    catalogo,
   @w_estado_cur        catalogo,
   @w_monto_cur         money,
   @w_tod_moneda        int,
   @w_tod_sector        catalogo,
   @w_tod_monto         money,
   @w_tod_monto_mn      money,
   @w_tod_concepto      varchar(20),
   @w_tod_codval	    int,
   @w_dp_cuenta         varchar(40),
   @w_parametro         varchar(24),
   @w_dp_debcred        char(1),
   @w_dp_constante      char(1),
   @w_dp_area           varchar(10),
   @w_dp_origen_dest    char(1),
   @w_evitar_asiento    char(1),
   @w_debito            money,
   @w_credito           money,
   @w_debito_me         money,
   @w_credito_me        money,
   @w_tot_debito        money,
   @w_tot_credito       money,
   @w_tot_debito_me     money,
   @w_tot_credito_me    money,
   @w_estado_prod       char(1),
   @w_cod_producto      tinyint,
   @w_cod_producto_ca   tinyint,
   @w_moneda_as         int,
   @w_total             int,
   @w_re_area           int,
   @w_pos               smallint,
   @w_gar_admisible     varchar(1),
   @w_calificacion      varchar(1),
   @w_clase_cart        varchar(1),
   @w_clase_cust        varchar(1),
   @w_estado            int,
   @w_estado_aux        int,
   @w_categoria         varchar(2),
   @w_ente              int,
   @w_tr_banco          varchar(24),
   @w_con_iva           varchar(1),
   @w_valor_base        money,
   @w_valor_iva         money,
   @w_con_timbre        varchar(1),
   @w_valor_timbre      money,
   @w_co_categoria      catalogo,
   @w_porcentaje_iva    float,
   -- PARALELISMO
   @p_operacion_ini     int,
   @p_operacion_fin     int,
   @p_proceso           int,
   @p_programa          catalogo,
   @p_total_oper        int,
   @p_estado            char(1),
   @p_ult_update        datetime,
   @p_cont_operacion    int,
   @p_tiempo_update     int,
   @w_numero            int,
   @w_referencial_iva   varchar(20),
   @w_maxfecha_iva      datetime,
   @w_banco_cur         cuenta,
   @w_tod_cuenta        cuenta,
   @w_bcp_parametro     varchar(100),
   @w_afecta            varchar(1),
   @w_valor_ref         varchar(5),
   @w_mes_concilia      varchar(2),
   @w_dia_concilia      varchar(2),
   @w_tod_beneficiario  varchar(64)


   

select @p_programa      = 'caconta_bm',    -- FYA antes caconta
       @p_proceso       = @i_proceso, -- SOLO POR MANTENER EL ESTANDAR DEL NOMBRE DE VARIABLES DEL PARALELO
       @p_ult_update    = getdate(),
       @p_tiempo_update = 15


/* VARIABLES DE TRABAJO */
select
@w_sp_name         = 'caconta.sp',
@w_mensaje         = '',
@w_estado_prod     = '',
@w_cod_producto    = 200,   --Sicredito
@w_cod_producto_ca = 7,     --Cartera
@w_valor_base      = 0

select @i_filial = isnull(@i_filial, 1)

if @i_debug = 'S'  print '--> sp_caconta.Inicio Contabilidad...'

truncate table cob_conta..cb_boc_cta_perfil

-- PARALELISMO
if @p_proceso is not null begin
   select 
   @p_operacion_ini  = operacion_ini,
   @p_operacion_fin  = operacion_fin,
   @p_estado         = estado,
   @p_cont_operacion = isnull(procesados, @p_operacion_fin - @p_operacion_ini)
   from   ca_paralelo_tmp
   where  programa = @p_programa
   and    proceso  = @p_proceso
end

if @p_proceso is not null begin
   update ca_paralelo_tmp
   set    estado      = 'P',
          spid        = @@spid,
          hora        = getdate(),
          hostprocess = master..sysprocesses.hostprocess,
          procesados  = @p_cont_operacion
   from   master..sysprocesses
   where  programa = @p_programa
   and    proceso  = @p_proceso
   and    master..sysprocesses.spid = @@spid
      
   select @p_estado = 'P'
end


/* DETERMINAR FECHA PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = @w_cod_producto_ca

/* SELECCION DEL AREA DE CARTERA */
select @w_ar_origen = pa_smallint
from cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico   = 'ARC'

if @@rowcount = 0 begin
   select 
   @w_mensaje = 'ERR: NO DEFINIDA AREA DE CARTERA',
   @w_error   = 708176
   goto ERRORFIN
end


/* VERIFICAR QUE EXISTA UN PERIODO DE CORTE ABIERTO EN LA CONTABILIDAD */
if not exists(select 1 from cob_conta..cb_corte
              where co_empresa   = 1
              and   co_fecha_ini = @w_fecha_proceso
              and   co_estado in ('A','V')) 
begin
   select 
   @w_error   = 601078,
   @w_mensaje = 'ERROR: EL PERIODO DE CORTE PARA LA FECHA DE PROCESO ESTA CERRADO (cb_corte)' + convert(varchar,@w_fecha_proceso,103)
   goto ERRORFIN
end


if @i_debug = 'S'  print '--> sp_caconta. Encontro Corte...'


/* DETERMINAR LA MONEDA NACIONAL Y CANTIDAD DE DECIMALES */
select @w_mon_nac = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'MLO'

select @w_num_dec_mn = pa_tinyint                                                                                                                                                                                                                         
from cobis..cl_parametro                                                                                                                                                                                                                                  
where pa_producto = 'CCA'                                                                                                                                                                                                                                  
and   pa_nemonico = 'NDE'    

/* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
select @w_estado_prod = pr_estado
from cob_conta..cb_producto 
where pr_empresa  = 1
and   pr_producto = @w_cod_producto_ca

/* VALIDA EL PRODUCTO EN CONTABILIDAD */
if @w_estado_prod not in ('V','E') begin
   select 
   @w_error   = 601018,
   @w_mensaje = 'PRODUCTO NO VIGENTE EN CONTA'
   goto ERRORFIN
end

/* CREAR TABLAS DE TRABAJO */
create table #cotizacion (
fecha       datetime,
moneda		int,
normal      money)

select *
into #totales
from ca_totales
where 1=2


/* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */
select  
@w_fecha_desde = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from cob_conta..cb_corte
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha_desde = '01/01/1900' begin
   select 
   @w_error   = 601078,
   @w_mensaje = 'ERROR: NO EXISTEN PERIODOS DE CORTE ABIERTOS'
   goto ERRORFIN
end


/* INSERTAR EN TEMPORALES TOTALES A CONTABILIZAR */
select @w_fecha_conta = @w_fecha_desde

if @i_debug = 'S'
begin
   print '--> sp_caconta. Fecha Conta ' + cast(@w_fecha_conta as varchar)
   print '--> sp_caconta. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
end

while @w_fecha_conta <= @w_fecha_hasta begin

   /* COTIZACION A UTILIZAR */
   insert into #cotizacion
   select 
   @w_fecha_conta, ct_moneda,  ct_valor
   from   cob_conta..cb_cotizacion x
   where  ct_fecha     = (select max(ct_fecha) from cob_conta..cb_cotizacion
                          where ct_moneda   = x.ct_moneda) 
   and    ct_moneda   <> 0
   group  by ct_fecha,ct_moneda, ct_valor      

   if @@error <> 0 begin
      select 
      @w_mensaje = 'ERR: AL INSERTAR COTIZACION DEL DIA',
      @w_error   = 710001
      goto ERRORFIN
   end


   /* TRANSACCIONES A CONTABILIZAR */
   insert into #totales
   select *
   from ca_totales
   where to_fecha_mov    = @w_fecha_conta  -- transacciones realizadas hoy
   and   to_comprobante  = 0
   and   (  @i_paralelismo = 'N' 
        or (to_total between @p_operacion_ini and @p_operacion_fin )
          ) -- FYA APLICA PARALELISMO

   if @@error <> 0 begin
      select 
      @w_mensaje = 'ERR: AL INSERTAR TRANSACCION CABECERA 1',
      @w_error   = 710001
      goto ERRORFIN
   end

   select @w_fecha_conta = dateadd(dd,1,@w_fecha_conta)

end


select @w_numero = count(1)
from #totales



/* CURSOR PRINCIPAL DE TRANSACCIONES */
declare cursor_tran cursor for
select
to_total,        to_fecha_mov,    to_fecha_ref,    
to_ofi_usu,      to_ofi_oper,     to_tran,         
to_moneda,       to_toperacion,   to_estado,
to_banco
from #totales
order by to_total

open cursor_tran

fetch cursor_tran into
@w_total,            @w_fecha_pro_cur,     @w_fecha_val_cur,
@w_of_origen_cur,    @w_of_destino_cur,    @w_tran_cur,
@w_moneda_cur,       @w_toperacion_cur,    @w_estado_cur,
@w_banco_cur

--while @@fetch_status = 0 and (@p_estado = 'P') begin
while @@fetch_status = 0  begin -- NOA APLICA PARALELISMO


   if @@fetch_status = -2 begin
      close cursor_tran
      deallocate cursor_tran
      goto ERRORFIN
   end


   select @p_cont_operacion = @p_cont_operacion - 1

   -- ACTUALIZAR EL PROCESO CADA MINUTO
   if datediff(ss, @p_ult_update, getdate()) > @p_tiempo_update
   begin
      select @p_ult_update = getdate()

      update ca_paralelo_tmp
      set    hora       = getdate(),
             procesados = @p_cont_operacion
      where  programa = @p_programa
      and    proceso  = @p_proceso
            
      -- AVERIGUAR EL ESTADO DEL PROCESO
      select @p_estado = estado
      from   ca_paralelo_tmp
      where  programa = @p_programa
      and    proceso  = @p_proceso
   end

   /* VARIABLES INICIALES */
   select
   @w_asiento        = 0,
   @w_tot_credito    = 0,
   @w_tot_debito     = 0,
   @w_tot_credito_me = 0,
   @w_tot_debito_me  = 0,
   @w_mensaje        = '',
   @w_cuenta_final   = '',
   @w_fecha_conta    = @w_fecha_pro_cur

   /* CONCEPTO DEL COMPROBANTE */
   select @w_descripcion = 
   'Ban:' + ltrim(rtrim(@w_banco_cur))                         + ' ' +
   'Tot:' + ltrim(rtrim(convert(varchar,@w_total)))            + ' ' +
   'Trn:' + ltrim(rtrim(convert(varchar,@w_tran_cur)))         + ' ' +
   'Est:' + convert(char(3),@w_estado_cur)                     + ' ' +
   'TOp:' + ltrim(rtrim(convert(char(10),@w_toperacion_cur)))  + ' ' +
   'FV:'  + ltrim(rtrim(convert(varchar,@w_fecha_conta,103)))

   if @i_debug = 'S'  
      print '     CONTABILIZANDO... ' + @w_descripcion 

   /* CONTABILIDAD ELIMINADA... MARCAR REGISTRO COMO CONTABILIZADO */
   if @w_estado_prod = 'E' begin
      select @w_comprobante = -1  -- Contabilidad eliminada
      goto MARCAR
   end

   /* DETERMINAR PERFIL CONTABLE */
   if @i_debug = 'S'
   begin
      print '    @w_toperacion_cur: ' + @w_toperacion_cur
      print '    @w_tran_cur:       ' + @w_tran_cur
   end

   select @w_perfil = to_perfil
   from ca_trn_oper_bancamia
   where to_toperacion = @w_toperacion_cur
   and   to_tipo_trn   = @w_tran_cur

   if @@rowcount = 0 or @w_perfil is null begin 
      select 
      @w_error   = 701148,
      @w_mensaje = 'ERROR: NO EXISTE TRN ' + isnull(@w_tran_cur,'') + ' PARA EL TOp:' + isnull(@w_toperacion_cur,'') + ' EN LA TABLA ca_trn_oper_bancamia' 
      goto ERROR1
   end

   if not exists(select 1 from cob_conta..cb_perfil
                 where pe_empresa  = 1
                 and   pe_producto = @w_cod_producto
                 and   pe_perfil   = @w_perfil) begin
      select 
      @w_error   = 701148,
      @w_mensaje = 'ERROR: NO EXISTE PERFIL '+ @w_perfil + ' EN LA TABLA cb_perfil'
      goto ERROR1
   end

   /* BUSCAR NUMERO PROXIMO COMPROBANTE CONTABLE */
   exec @w_error = cob_conta..sp_cseqcomp
   @i_tabla     = 'cb_scomprobante', 
   @i_empresa   = 1,
   @i_fecha     = @w_fecha_conta,
   @i_modulo    = @w_cod_producto,
   @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
   @o_siguiente = @w_comprobante out
      
   if @w_error <> 0 begin
      select 
      @w_mensaje = 'ERROR AL GENERAR NUMERO COMPROBANTE '
      goto ERROR1
   end

   if @i_debug = 'S'
   begin
     print '    @w_comprobante: ' + cast(@w_comprobante as varchar)
     print '    @w_perfil:      ' + @w_perfil
     print '    @w_total:       ' + cast(@w_total as varchar)
   end

   /** CURSOR PARA OBTENER LOS DETALLES DEL PERFIL RESPECTIVO **/
   declare cursor_perfil cursor for select
   tod_concepto,      tod_codvalor,      tod_moneda,  
   tod_sector,        tod_monto,         dp_cuenta,         
   dp_debcred,        dp_constante,      dp_area,           
   dp_origen_dest,    (select ta_area from cob_conta..cb_tipo_area
                       where ta_tiparea  = x.dp_area
                       and   ta_empresa  = x.dp_empresa
                       and   ta_producto = x.dp_producto),
   tod_gar_admisible, tod_calificacion,  tod_clase_cart,
   tod_clase_cust,    tod_estado,        tod_categoria,
   tod_ente,          tod_banco,         tod_cuenta,
   tod_beneficiario
   from ca_totales_det, cob_conta..cb_det_perfil x
   where tod_total      = @w_total
   and   dp_empresa     = 1
   and   dp_producto    = @w_cod_producto  --sicredito
   and   dp_perfil      = @w_perfil
   and   dp_codval      = tod_codvalor
   and   abs(tod_monto)>= 0.01
   and   tod_banco      = @w_banco_cur
   order by dp_codval

   open cursor_perfil

   fetch cursor_perfil into
   @w_tod_concepto,     @w_tod_codval,     @w_tod_moneda,
   @w_tod_sector,       @w_tod_monto,      @w_dp_cuenta,        
   @w_dp_debcred,       @w_dp_constante,   @w_dp_area,          
   @w_dp_origen_dest,   @w_re_area,        @w_gar_admisible,    
   @w_calificacion,     @w_clase_cart,     @w_clase_cust,
   @w_estado,           @w_categoria,      @w_ente,
   @w_tr_banco,         @w_tod_cuenta,     @w_tod_beneficiario

   while @@fetch_status = 0 begin

      if @i_debug = 'S' begin
         print '    RUBRO:  ' + @w_tod_concepto    
         print '    Param:  ' + @w_dp_cuenta
         print '    CodVal: ' + cast(@w_tod_codval as varchar)
         print '    Sec:    ' + @w_tod_sector
         print '    perfil: ' + @w_perfil
         print '    cl_cart:' + @w_clase_cart
         print '    calif:  ' + @w_calificacion
         print '    t_gar:  ' + @w_gar_admisible
         print '    total:  ' + cast(@w_total as varchar)
      end

      select 
      @w_debito       = 0.00,
      @w_debito_me    = 0.00,
      @w_credito      = 0.00,
      @w_credito_me   = 0.00,
      @w_tod_concepto = ltrim(rtrim(@w_tod_concepto)),
      @w_con_iva      = 'N',
      @w_valor_base   = 0,
      @w_valor_iva    = 0,
      @w_con_timbre   = 'N',
      @w_valor_timbre = 0,
      @w_valor_ref    = null,
      @w_afecta       = null


      -- CONTABILIDAD DE IMPUESTOS
      -- CATEGORIA DE CONCEPTO
      select @w_co_categoria = co_categoria
      from   ca_concepto_bancamia
      where  co_concepto  = @w_tod_concepto
         
      if @w_co_categoria = 'A' 
      begin  --IVA
         select @w_con_iva = 'S'
         select @w_valor_iva = @w_tod_monto -- * @w_dtr_cotizacion
            

         /* PARA SICREDITO SE DEBE EXTRAER DE CA_RUBRO Y CA_REFERENCIAL */

         select @w_referencial_iva = ru_referencial
         from   ca_rubro_bancamia
         where  ru_concepto  = @w_tod_concepto

         select @w_maxfecha_iva   = max(vr_fecha_vig)
         from   ca_valor_referencial_bancamia
         where  vr_tipo           = @w_referencial_iva

         select @w_porcentaje_iva = vr_valor
         from   ca_valor_referencial_bancamia
         where  vr_tipo           = @w_referencial_iva
         and    vr_fecha_vig      = @w_maxfecha_iva

         select @w_porcentaje_iva = isnull (@w_porcentaje_iva,0)
            
         if @w_porcentaje_iva = 0
            select @w_valor_base = 0
         else         
            -- CALCULO DE LA BASE DEL IVA
            select @w_valor_base = @w_valor_iva / (@w_porcentaje_iva * 0.01)
      end
      else
         select @w_con_iva = 'N',
                @w_valor_iva = @w_tod_monto,   -- * @w_dtr_cotizacion,
                @w_valor_base = 0,
                @w_porcentaje_iva = 0

      --FIN CONTABILIDAD DE IMPUESTOS

      /* INICIO Inclusion Referencia para Conciliacion Bancaria por Nuevos Conceptos     AZU 23FEB09*/
      select  @w_afecta = ho_texto
      from ca_homologar
      where ho_tabla      = 'afecta_rubros'
      and   ho_codigo_org = @w_tod_concepto

      if @w_afecta is not null begin

         select @w_dia_concilia = substring(convert(varchar(10),@w_fecha_conta,101),4,2)
         select @w_mes_concilia = substring(convert(varchar(10),@w_fecha_conta,101),1,2)

         if @w_afecta <> 'P'
            select @w_valor_ref = @w_afecta + @w_mes_concilia + @w_dia_concilia
         else begin
            select @w_valor_ref = @w_afecta + substring(@w_tod_cuenta, len(@w_tod_cuenta)-3, len(@w_tod_cuenta))
         end
      end

      if @w_valor_ref is not null 
         select 
         @w_concepto  = @w_valor_ref + ' ' + @w_descripcion + ' ' + @w_tod_concepto + ' ' + @w_tod_beneficiario
      else
         select 
         @w_concepto  = @w_descripcion + ' ' + @w_tod_concepto + ' ' + @w_tod_beneficiario

      /* FIN Inclusion Referencia para Conciliacion Bancaria por Nuevos Conceptos     AZU 23FEB09*/
   

      /* REVERSAS EN CASO DE NEGATIVOS, INVERTIR SIGNOS DEL ASIENTO */
      if @w_tod_monto < 0 begin

         if @w_dp_debcred = '2' 
            select @w_dp_debcred = '1'   
         else
            select @w_dp_debcred = '2'   

         if @w_tod_monto < 0
            select @w_tod_monto = -1 * @w_tod_monto

      end

      select @w_debcred = convert(int,@w_dp_debcred)

      /* DETERMINAR MONTO EN MONEDA NACIONAL */         
      if @w_tod_moneda <> @w_mon_nac begin

         select 
         @w_cotizacion   = normal,
         --@w_tod_monto_mn = round(@w_tod_monto * normal, @w_num_dec_mn)   --LAZG Redondeos
         @w_tod_monto_mn = @w_tod_monto * normal                           --LAZG Redondeos
         from #cotizacion
         where moneda = @w_tod_moneda
         and   fecha  = @w_fecha_conta

         if @@rowcount = 0 begin
            close cursor_perfil
            deallocate cursor_perfil
            select @w_error   = 701070
            select @w_mensaje = 
            'ERR: NO EXISTE COTIZACION MONEDA: ' + convert(varchar, @w_tod_moneda)+ ' ' +
            'FECHA: ' + convert(varchar(10), @w_fecha_conta, 103)
            goto ERROR1
         end

      end else begin
         select 
         @w_cotizacion = 1,
         --@w_tod_monto_mn = round(@w_tod_monto, @w_num_dec_mn)   --LAZG Redondeos
         @w_tod_monto_mn = @w_tod_monto                           --LAZG Redondeos
      end

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA NACIONAL */
      select
      @w_debito   = @w_tod_monto_mn*(2-@w_debcred),
      @w_credito  = @w_tod_monto_mn*(@w_debcred-1)

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA EXTRANJERA */
      if  @w_dp_constante = 'T' 
      and @w_tod_moneda  <> @w_mon_nac
         select
         @w_debito_me  = @w_tod_monto * (2-@w_debcred),
         @w_credito_me = @w_tod_monto * (@w_debcred-1)

      /* FORZAR MONEDA LOCAL SEGUN CORRESPONDA */
      if @w_dp_constante = 'L' 
         select 
         @w_moneda_as  = @w_mon_nac,
         @w_debito_me  = 0.00,
         @w_credito_me = 0.00
      else
         select @w_moneda_as = @w_tod_moneda

      /* DETERMINAR OFICINA A LA QUE SE CONTABILIZARA */
      if @w_dp_origen_dest = 'O' 
         select @w_oficina = @w_of_origen_cur
      else
         select @w_oficina = @w_of_destino_cur


      if @w_tran_cur = 'TRC'
            select @w_calificacion = substring(rtrim(@w_tod_cuenta), 1, 1)



      if @w_tran_cur = 'CGR'
      begin
            select @w_gar_admisible = substring(rtrim(@w_tod_cuenta), 1, 1)

            if @w_gar_admisible = 'S'
               select @w_gar_admisible = 'I', @w_clase_cust = 'I'
            else
               select @w_gar_admisible = 'O', @w_clase_cust = 'O'
      end         

      select @w_evitar_asiento = 'N'

      select @w_estado_aux = @w_estado

      if @w_estado = 3 and @w_tod_codval >= 10000
          select @w_estado_aux = ((@w_tod_codval)/10)% 100 

      select @w_bcp_parametro =
      ltrim(rtrim(@w_dp_cuenta)) + ';' +
      convert(char(1),@w_tod_moneda) + ';' +
      ltrim(rtrim(@w_tod_sector)) + ';' +
      @w_gar_admisible + ';' +
      @w_calificacion + ';' +
      @w_clase_cart + ';' +
      @w_clase_cust + ';' +
      ltrim(rtrim(convert(varchar,@w_cod_producto))) + ';' +
      @w_tod_concepto + ';' +
      ltrim(rtrim(convert(varchar,@w_estado_aux))) + ';' +
      @w_categoria

      if @w_bcp_parametro is null and @i_debug = 'S'
      begin
          print 'No hay mensaje asociado @w_bcp_parametro'
          print '@w_dp_cuenta ' + @w_dp_cuenta
          print '@w_tod_moneda ' + cast(@w_tod_moneda as varchar)
          print '@w_tod_sector ' +cast(@w_tod_sector as varchar)
          print '@w_gar_admisible ' + cast (@w_gar_admisible as varchar)
          print '@w_calificacion ' + cast (@w_calificacion as varchar)
          print '@w_clase_cart ' + cast(@w_clase_cart as varchar)
          print '@w_clase_cust ' + cast(@w_clase_cust as varchar)
          print '@w_cod_producto ' + cast(@w_clase_cust as varchar)
          print '@w_tod_concepto ' + cast(@w_tod_concepto as varchar)
          print '@w_estado_aux ' + cast( @w_estado_aux as varchar)
          print '@w_categoria ' + cast(@w_categoria as varchar)
      end

      select
      @w_cuenta_final = bcp_cuenta
      from cob_conta..cb_boc_cta_perfil
      where bcp_codval    = @w_tod_codval
      and   bcp_parametro = @w_bcp_parametro

      if @@rowcount = 0 begin   
         /** RESOLUCION DE LA CUENTA DINAMICA **/
         select @w_cuenta_final = ''

         /* VERIFICAR SI LA TRAMA ES PARTE FIJA O PARAMETRO */
         select @w_ascii = ascii(substring(@w_dp_cuenta,1,1))
         select @w_pos   = charindex('.',@w_dp_cuenta)

         if @w_pos = 0 begin
  
            select 
            @w_cuenta_final   =  rtrim(ltrim(@w_dp_cuenta)),
            @w_evitar_asiento = 'N'
         end 
         else 
         begin  --LETRA, LA TRAMA ES UN PARAMETRO

           select @w_cuenta_aux = @w_dp_cuenta
           select @w_pos        = charindex('.',@w_cuenta_aux)

           while 0 = 0  -- SOLUCION DE LA CUENTA
           begin
               -- ELIMINAR PUNTOS INICIALES
               while @w_pos = 1 
               begin
                  select @w_cuenta_aux = substring (@w_cuenta_aux, 2, datalength(@w_cuenta_aux) - 1)
                  select @w_pos        = charindex ('.',@w_cuenta_aux)
               end
             
               -- AISLAR SIGUIENTE PARAMETRO DEL RESTO DE LA CUENTA
               if @w_pos > 0 
               begin --existe al menos un parametro
                  select @w_trama      = substring (@w_cuenta_aux,1,@w_pos-1)
                  select @w_cuenta_aux = substring (@w_cuenta_aux,@w_pos+1, datalength(@w_cuenta_aux)-@w_pos)
                  select @w_pos        = charindex('.',@w_cuenta_aux)
               end 
               ELSE 
               begin
                  select @w_trama      = @w_cuenta_aux
                  select @w_cuenta_aux = ''
               end
            
               -- CONDICION DE SALIDA DEL LAZO
               if @w_trama = '' 
                  break

               select @w_ascii = ascii(substring(@w_trama,1,1))
            
               if @w_ascii >= 48 and @w_ascii <= 57 
               begin --NUMERICO,PARTE FIJA
                  select @w_cuenta_final = @w_cuenta_final + @w_trama
               end 
               ELSE
               begin  --LETRA, LA TRAMA ES UN PARAMETRO
                  select @w_resultado = ''
 
                  select @w_parametro = @w_trama

                  if @i_debug = 'S'
                     print '@w_cuenta_aux:  ' + @w_cuenta_aux + ' calif ' + @w_calificacion + ' @w_tod_cuenta' + @w_tod_cuenta


                  exec @w_error     = sp_cuenta
                  @i_debug          = @i_debug,
                  @i_parametro      = @w_parametro,   --@w_dp_cuenta, 
                  @i_moneda         = @w_tod_moneda,
                  @i_sector         = @w_tod_sector,
                  @i_gar_admisible  = @w_gar_admisible,
                  @i_calificacion   = @w_calificacion,
                  @i_clase_cart     = @w_clase_cart,
                  @i_clase_cust     = @w_clase_cust,
                  @i_producto       = @w_cod_producto,     
                  @i_concepto       = @w_tod_concepto,
                  @i_estado         = @w_estado_aux,
                  @i_categoria      = @w_categoria,
                  @o_cuenta         = @w_resultado      out, 
                  @o_evitar_asiento = @w_evitar_asiento out, 
                  @o_msg            = @w_mensaje        out

                  if @w_error != 0 begin
                     close cursor_perfil
                     deallocate cursor_perfil
                     goto ERROR1
                  end

                  select @w_cuenta_final = @w_cuenta_final + @w_resultado
               end                         
            end          
         end
        
         if @w_evitar_asiento = 'N' begin 
            insert into cob_conta..cb_boc_cta_perfil values (@w_tod_codval,@w_bcp_parametro,@w_cuenta_final,'')
            if @@error <> 0 begin      
               select 
               @w_mensaje  = 'Error en bco_cta_perfil: ' + ltrim(rtrim(convert(varchar,@w_tod_codval))) + ' Parametro: ' + @w_bcp_parametro,
               @w_error    = 701102
               goto ERROR1
            end
         end
      end
      if @i_debug = 'S' and @w_evitar_asiento = 'S' 
         print '      evitar asiento...'


      /* GENERAR ASIENTO DEL COMPROBANTE */
      if @w_evitar_asiento = 'N' and @w_cuenta_final <> '' 
      begin
         if @i_debug = 'S' begin
            print '      cta:    ' + @w_cuenta_final 
            print '      afect:  ' + cast(@w_dp_debcred as varchar)
            print '      deb:    ' + cast(@w_debito_me as varchar)
            print '      debit:  ' + cast(@w_debito as varchar)
            print '      cre:    ' + cast(@w_credito_me as varchar)
            print '      credit: ' + cast(@w_credito as varchar)
         end

         select 
         @w_asiento        = @w_asiento        + 1,
         @w_tot_credito    = @w_tot_credito    + @w_credito,
         @w_tot_debito     = @w_tot_debito     + @w_debito,
         @w_tot_credito_me = @w_tot_credito_me + @w_credito_me,
         @w_tot_debito_me  = @w_tot_debito_me  + @w_debito_me

         /* DETERMINAR OFICINA DESTINO*/
         select @w_re_ofconta = re_ofconta
         from   cob_conta..cb_relofi
         where  re_filial  = 1
         and    re_empresa = 1
         and    re_ofadmin = @w_oficina

         if @@rowcount = 0 begin
            select 
            @w_mensaje  = 'ERR: NO EXISTE OF.CONTABLE (cb_relofi) -' + convert(varchar, @w_oficina) + '-',
            @w_error    = 701102
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end

         if @i_debug = 'S'  begin
            print '      Generando asiento... of: ' + cast(@w_re_ofconta as varchar)
            print '            Nro. Compro.     : ' + cast(@w_comprobante as varchar)
            print '            Cuenta Final.    : ' + cast(@w_cuenta_final as varchar)
            print '            Ente             : ' + cast(@w_ente as varchar)
         end

         exec @w_error = cob_conta..sp_sasiento
         @i_operacion      = 'I',
         @i_fecha_tran     = @w_fecha_conta,
         @i_comprobante    = @w_comprobante,
         @i_empresa        = 1,
         @i_asiento        = @w_asiento,
         @i_ente           = @w_ente,
         @i_documento      = @w_tr_banco,
         @i_base           = @w_valor_base,
         @i_con_iva        = @w_con_iva,
         @i_valor_iva      = @w_valor_iva,
         @i_cuenta         = @w_cuenta_final,
         @i_oficina_dest   = @w_re_ofconta,
         @i_area_dest      = @w_re_area,
         @i_credito        = @w_credito,
         @i_debito         = @w_debito,
         @i_concepto       = @w_concepto,
         @i_credito_me     = @w_credito_me,
         @i_debito_me      = @w_debito_me,
         @i_moneda         = @w_moneda_as,
         @i_cotizacion     = @w_cotizacion,
         @i_tipo_doc       = 'N',
         @i_tipo_tran      = 'A',
         @i_producto       = @w_cod_producto,
         @i_debcred        = @w_dp_debcred,
         @i_tran_modulo    = @w_total,
         @o_desc_error     = @w_mensaje out

         if @w_error !=0 begin
            close cursor_perfil
            deallocate cursor_perfil
            select 
            @w_mensaje = '(sp_sasiento) '+ isnull(@w_mensaje, '')
            goto ERROR1
         end

         if @w_tran_cur not in ('TRC', 'CGR')
         begin         
            update ca_det_trn_bancamia set
    	    dtr_cuenta  = substring(dtr_cuenta,1,8) + ' '+ substring(@w_cuenta_final,1,11)
            where dtr_secuencial    = @w_total
            and   dtr_concepto = @w_tod_concepto
            and   dtr_codvalor = @w_tod_codval
            and   dtr_banco    = @w_banco_cur
       
            if @@error !=0 begin
               close cursor_perfil
               deallocate cursor_perfil
               select 
               @w_mensaje = 'ERR: ACTUALIZAR ca_det_trn_bancamia '+ @w_tod_concepto +' '+ isnull(@w_mensaje, ''),
               @w_error   = 710002
               goto ERROR1
            end

            update ca_det_trn_bancamia_2 set
    	    dtr_cuenta  = substring(dtr_cuenta,1,8) + ' '+ substring(@w_cuenta_final,1,11)
            where dtr_secuencial    = @w_total
            and   dtr_concepto = @w_tod_concepto
            and   dtr_codvalor = @w_tod_codval
            and   dtr_banco    = @w_banco_cur
       
            if @@error !=0 begin
               close cursor_perfil
               deallocate cursor_perfil
               select 
               @w_mensaje = 'ERR: ACTUALIZAR ca_det_trn_bancamia_2 '+ @w_tod_concepto +' '+ isnull(@w_mensaje, ''),
               @w_error   = 710002
               goto ERROR1
            end

         end

      end
      else
      begin
           if @i_debug = 'S' begin
            print ' CUENTA VACIA EVITA ASIENTO'
            print '      cta:    ' + @w_cuenta_final 
            print '      afect:  ' + cast(@w_dp_debcred as varchar)
            print '      deb:    ' + cast(@w_debito_me as varchar)
            print '      debit:  ' + cast(@w_debito as varchar)
            print '      cre:    ' + cast(@w_credito_me as varchar)
            print '      credit: ' + cast(@w_credito as varchar)
         end
      end

      fetch cursor_perfil into
      @w_tod_concepto,     @w_tod_codval,     @w_tod_moneda,
      @w_tod_sector,       @w_tod_monto,      @w_dp_cuenta,        
      @w_dp_debcred,       @w_dp_constante,   @w_dp_area,          
      @w_dp_origen_dest,   @w_re_area,        @w_gar_admisible,    
      @w_calificacion,     @w_clase_cart,     @w_clase_cust,
      @w_estado,           @w_categoria,      @w_ente,
      @w_tr_banco,         @w_tod_cuenta,     @w_tod_beneficiario

   end  -- cursol de los detalles del perfil

   close cursor_perfil
   deallocate cursor_perfil

   if @i_debug = 'S'
      print '     @w_of_origen_cur:  ' + cast(@w_of_origen_cur as varchar)

   /** GENERACION DEL COMPROBANTE **/
   select @w_re_ofconta = re_ofconta
   from   cob_conta..cb_relofi
   where  re_filial  = 1
   and    re_empresa = 1
   and    re_ofadmin = @w_of_origen_cur

   if @@rowcount = 0 begin
      select 
      @w_mensaje = 'ERR: NO EXISTE OF.ORIGEN -' + convert(varchar, @w_of_origen_cur) + '-',
      @w_error   = 701102
      goto ERROR1
   end


   if @w_tot_debito >= 0.01 or @w_tot_credito >= 0.01 begin

      if @i_debug = 'S' 
         print '   Generando comprobante... of: ' + cast(@w_re_ofconta as varchar)

      exec @w_error = cob_conta..sp_scomprobante
      @i_operacion      = 'I',
      @i_producto       = @w_cod_producto,
      @i_comprobante    = @w_comprobante,
      @i_empresa        = 1,
      @i_fecha_tran     = @w_fecha_conta,
      @i_oficina_orig   = @w_re_ofconta,
      @i_area_orig      = @w_ar_origen,
      @i_digitador      = @s_user,
      @i_descripcion    = @w_descripcion,
      @i_perfil         = @w_perfil,
      @i_detalles       = @w_asiento,
      @i_tot_debito     = @w_tot_debito,
      @i_tot_credito    = @w_tot_credito,
      @i_tot_debito_me  = @w_tot_debito_me,
      @i_tot_credito_me = @w_tot_credito_me,
      @i_automatico     = @w_cod_producto,
      @i_reversado      = 'N',
      @i_estado         = 'I',
      @i_tran_modulo    = @w_total,
      @o_desc_error     = @w_mensaje out

      if @w_error !=0 begin
         select @w_mensaje = '(sp_scomprobante) ' + isnull(@w_mensaje, '')
         goto ERROR1
      end

      if @w_mensaje = ''
      begin
          update ca_totales set 
          to_comprobante = @w_comprobante,
          to_fecha_cont  = @w_fecha_proceso,
          to_estado      = 'CON'
          from ca_totales 
          where to_total = @w_total
          and   to_banco = @w_banco_cur

          if @@error <> 0 begin
             select @w_mensaje = 'ERR: AL MARCAR TABLA DE TOTALES '
             select @w_error = 700002
             goto ERROR1
          end

      end
       
   end else begin

      select 
      @w_comprobante = -2, -- sin asientos
      @w_mensaje = 'COMPROBANTE SIN ASIENTOS'
      goto ERROR1     
   end


   MARCAR:

   if @i_simulacion = 'N' or @w_comprobante = -1 begin

      update ca_transaccion_bancamia set 
      tr_comprobante  =  @w_comprobante,
      tr_fecha_cont   =  @w_fecha_proceso,
      tr_estado       =  'CON'
      where tr_banco      = @w_banco_cur
      and   tr_secuencial = @w_total

      if @@error <> 0 begin
         select @w_mensaje = 'ERR: AL MARCAR TABLA DE TRANSACCION BANCAMIA '
         select @w_error = 700002
         goto ERROR1
      end

      update ca_transaccion_bancamia_2 set 
      tr_comprobante      =  @w_comprobante,
      tr_fecha_cont       =  @w_fecha_proceso,
      tr_estado           =  'CON'
      where tr_banco      = @w_banco_cur
      and   tr_secuencial = @w_total

      if @@error <> 0 begin
         select @w_mensaje = 'ERR: AL MARCAR TABLA DE TRANSACCION BANCAMIA 2 '
         select @w_error = 700002
         goto ERROR1
      end


   end -- es simulacion = 'N'

   goto SIGUIENTE

   ERROR1:

   select @w_mensaje = @w_descripcion + ' ' + @w_mensaje

   --SET IDENTITY_INSERT cob_ccontable..cco_error_conaut ON

   exec cob_ccontable..sp_errorcconta
   @t_trn         = 60011,
   @i_operacion   = 'I',
   @i_empresa     = 1,
   @i_fecha       = @w_fecha_proceso,
   @i_producto    = 200,
   @i_tran_modulo = @w_total, --@w_tran_cur,
   @i_asiento     = 0,
   @i_fecha_conta = @w_fecha_conta,
   @i_numerror    = @w_error,
   @i_mensaje     = @w_mensaje,
   @i_perfil      = @w_perfil,
   @i_oficina     = @w_re_ofconta



   -- SET IDENTITY_INSERT cob_ccontable..cco_error_conaut OFF

   select @w_mensaje = @w_descripcion + ' ' + @w_mensaje

   if @i_debug = 'S' 
      print '            ERROR1 --> ' + @w_mensaje

   exec sp_errorlog
   @i_fecha       = @w_fecha_proceso, 
   @i_error       = 7200, 
   @i_usuario     = @s_user,
   @i_tran        = 7000, 
   @i_tran_name   = @w_sp_name, 
   @i_rollback    = 'N',
   @i_cuenta      = @w_banco_cur, 
   @i_descripcion = @w_mensaje


   SIGUIENTE:


   fetch cursor_tran into
   @w_total,            @w_fecha_pro_cur,     @w_fecha_val_cur,
   @w_of_origen_cur,    @w_of_destino_cur,    @w_tran_cur,
   @w_moneda_cur,       @w_toperacion_cur,    @w_estado_cur,
   @w_banco_cur

end --end while cursor transacciones

close cursor_tran
deallocate cursor_tran



return 0


ERRORFIN:

exec sp_errorlog
@i_fecha     = @w_fecha_proceso, 
@i_error     = 7200, 
@i_usuario   = @s_user,
@i_tran      = 7000, 
@i_tran_name = @w_sp_name, 
@i_rollback  = 'N',
@i_cuenta    = 'CONTABILIDAD', 
@i_descripcion = @w_mensaje

return 0

