/************************************************************************/
/*   Stored procedure:     sp_caconta                                   */
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
/*                            CAMBIOS                                   */
/************************************************************************/
/*      FECHA           AUTOR             RAZON                         */
/*   Jul-07-2010   Elcira Pelaez  MANEJO nuevo sp_ca07_pf   para sacar  */
/*                                @w_clave (cal-gar-clase-mon-org.fondo)*/
/*   Feb-23-2011   Elcira Pelaez  Control error en consulta Operacione  */
/*   Julio-11-2019 AGO            ajuste en el TCO                      */
/*   AGO-29-2019   PRO            Ajuste para obtener ente en trn DSC   */
/*   Dic-28-2020   DCU            #151513                               */
/************************************************************************/
 
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_caconta')
   drop proc sp_caconta
go
 
CREATE proc [dbo].[sp_caconta]
   @i_param1            varchar(255)  = null, 
   @i_param2            varchar(255)  = null, 
   @i_param3            varchar(255)  = null, 
   @i_param4            varchar(255)  = null, 
   @i_param5            varchar(255)  = null,
   @s_user              login         = 'sp_caconta',
   @i_debug             char(1)       = 'N',
   @i_banco             cuenta        = null   
 
as declare
   @w_error             int,
   @w_mon_nac           int,
   @w_num_dec_mn        int,
   @w_ar_origen         int,
   @w_asiento           int,
   @w_comprobante       int,
   @w_debcred           int,
   @w_oficina           smallint,
   @w_re_ofconta        int,
   @w_fecha_proceso     smalldatetime,
   @w_fecha_hasta       smalldatetime,
   @w_fecha_mov         smalldatetime,
   @w_mensaje           varchar(255),
   @w_descripcion       varchar(255),
   @w_concepto          varchar(255),
   @w_cuenta_final      varchar(40),
   @w_sp_name           descripcion,
   @w_cotizacion        float,
   @w_perfil            varchar(10),
   @w_of_origen_cur     int,
   @w_op_oficina        int,
   @w_fecha_val         datetime,
   @w_tran_cur          varchar(10),
   @w_op_moneda         int,
   @w_toperacion        varchar(10),
   @w_reverso           char(1),
   @w_monto_cur         money,
   @w_dtr_moneda        int,
   @w_sector            varchar(10),
   @w_dtr_monto         money,
   @w_dtr_monto_mn      money,
   @w_dtr_concepto      varchar(20),
   @w_dtr_codval      int,
   @w_dp_cuenta         varchar(40),
   @w_parametro         varchar(24),
   @w_dp_debcred        char(1),
   @w_dp_constante      char(1),
   @w_dp_origen_dest    char(1),
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
   @w_moneda_as         int,
   @w_secuencial        int,
   @w_secuencial_ref    INT,
   @w_re_area           int,
   @w_gar_admisible     varchar(1),
   @w_calificacion      varchar(1),
   --@w_clase_cart        varchar(1),
   @w_clase_cart        varchar(10),
   @w_subtipo_cart      varchar(10),
   @w_op_estado         int,
   @w_ente              int,
   @w_banco             varchar(24),
   @w_con_iva           varchar(1),
   @w_valor_base        money,
   @w_con_timbre        varchar(1),
   @w_valor_timbre      money,
   @w_porcentaje_iva    float,
   @w_referencial_iva   varchar(20),
   @w_maxfecha_iva      datetime,
   @w_dtr_cuenta        cuenta,
   @w_bcp_parametro     varchar(100),
   @w_afecta            varchar(1),
   @w_valor_ref         varchar(5),
   @w_cont              int,
   @w_operacionca       int,
   @w_cheque            int,
   @w_marcados          int,
   @w_llenado           varchar(24),
   @w_clave             varchar(40),
   @w_stored            cuenta,
   @w_dp_area           varchar(10),
   @w_hijo              varchar(2),
   @w_sarta             int,
   @w_batch             int,
   @w_opcion            char(1),
   @w_bloque            int,
   @w_oficina_aux       smallint,
   @w_factor            int,
   @w_comprobante_base  int,
   @w_idlote            int,
   @w_commit            char(1),
   @w_rowcount          int,
   @w_op_origen_fondos  varchar(10),
   @w_entidad_convenio  varchar(1),
   @w_bancamia          varchar(24),
   @w_valret            money,
   @w_conret            char(1),
   @w_categoria         char(1),
   @w_montodes	        money,
   @w_cliente_al        varchar(20),
   @w_tramite           int,
   @w_dm_producto       catalogo,
   @w_op_gar            int,
   @w_op_fon            int
   
/* VARIABLES DE TRABAJO */
select
@w_sp_name      = 'caconta.sp',
@w_mensaje      = '',
@w_estado_prod  = '',
@w_cod_producto = 7, 
@w_valor_base   = 0,
@w_llenado      = '                       ',
@w_commit       = 'N' ,
@w_hijo         = convert(varchar(2), rtrim(ltrim(@i_param1))),
@w_sarta        = convert(int       , rtrim(ltrim(@i_param2))),
@w_batch        = convert(int       , rtrim(ltrim(@i_param3))),
@w_opcion       = convert(char(1)   , rtrim(ltrim(@i_param4))),
@w_bloque       = convert(int       , rtrim(ltrim(@i_param5)))

if @i_debug = 'S'  print '--> sp_caconta.Inicio Contabilidad...'

select @w_op_fon = -2, @w_op_gar = -3

/* DETERMINAR CODIGO DE BANCAMIA PARA EMPLEADOS */

select @w_bancamia  = convert(varchar(24),pa_int)
from cobis..cl_parametro
where pa_nemonico = 'CCBA'
and   pa_producto = 'CTE'

/* DETERMINAR FECHA PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre with (nolock)
where fc_producto = @w_cod_producto

/* SELECCION DEL AREA DE CARTERA */
select @w_ar_origen = pa_smallint
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and pa_nemonico   = 'ARC'

if @@rowcount = 0 begin
   select 
   @w_mensaje = ' ERR NO DEFINIDA AREA DE CARTERA ' ,
   @w_error   = 708176
   goto ERRORFIN
end

if @i_debug = 'S'  print '--> sp_caconta. Encontro Corte...'

/* DETERMINAR LA MONEDA NACIONAL Y CANTIDAD DE DECIMALES */
select @w_mon_nac = pa_tinyint
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and   pa_nemonico = 'MLO'

select @w_num_dec_mn = pa_tinyint                                                                                                                                                                                                                         
from cobis..cl_parametro with (nolock)                                                                                                                                                                                                                  
where pa_producto = 'CCA'                                                                                                                                                                                                                                  
and   pa_nemonico = 'NDE'    

/* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
select @w_estado_prod = pr_estado
from cob_conta..cb_producto with (nolock)
where pr_empresa  = 1
and   pr_producto = @w_cod_producto

/* VALIDA EL PRODUCTO EN CONTABILIDAD */
if @w_estado_prod not in ('V','E') begin
   select 
   @w_error   = 601018,
   @w_mensaje = ' PRODUCTO NO VIGENTE EN CONTA ' 
   goto ERRORFIN
end

/* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */
select  
@w_fecha_mov   = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from cob_conta..cb_corte with (nolock)
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha_mov = '01/01/1900' begin
   select 
   @w_error   = 601078,
   @w_mensaje = ' ERROR NO EXISTEN PERIODOS DE CORTE ABIERTOS ' 
   goto ERRORFIN
end

if @i_debug = 'S' begin
   print '--> sp_caconta. Fecha Conta ' + cast(@w_fecha_mov as varchar)
   print '--> sp_caconta. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
end

if @w_opcion = 'G' begin  -- generar universo

   truncate table ca_universo_conta
   
   /* INSERTAR EN TEMPORALES TOTALES A CONTABILIZAR */
   while @w_fecha_mov <= @w_fecha_hasta begin
   
      /* TRANSACCIONES A CONTABILIZAR DISTINTAS A 'PRV', 'REJ','MIG','HFM'*/
      insert into ca_universo_conta
      select
      tr_operacion,   tr_secuencial,  tr_fecha_mov,   
      tr_fecha_ref,   tr_ofi_usu,     tr_tran,        
      'N',            0,              tr_ofi_oper
      from ca_transaccion 
      where  tr_estado    = 'ING'
      and    tr_tran     not in ('PRV','REJ','MIG','HFM')
      and    tr_fecha_mov = @w_fecha_mov
	  and    ((tr_banco = @i_banco and @i_banco is not null) or (tr_banco != '' and @i_banco is null))

      if @@error <> 0 begin
         select 
         @w_mensaje = ' ERR AL INSERTAR TRANSACCION CABECERA 1 ' ,
         @w_error   = 710001
         goto ERRORFIN
      end
      
      select @w_fecha_mov = dateadd(dd,1,@w_fecha_mov)
   
   end
   
   delete cobis..ba_ctrl_ciclico 
   where ctc_sarta = @w_sarta
   
   insert into cobis..ba_ctrl_ciclico
   select sb_sarta,sb_batch, sb_secuencial, 'S', 'P'
   from cobis..ba_sarta_batch
   where sb_sarta = @w_sarta
   and   sb_batch = @w_batch
  
   return 0
   
end


/* OPCION QUE SE EJECUTARA SOLO SI EL PROCESO ES EL BATCH MASIVO (NO PARA FECHA VALOR) */
if @w_opcion = 'B' begin  --procesos batch

   select @w_cont = isnull(count(*),0)
   from ca_universo_conta with (nolock)
   where ub_estado   = @w_hijo
   
   select @w_cont = @w_bloque - @w_cont
   
   if @w_cont > 0 begin
   
      set rowcount @w_cont
      
      update ca_universo_conta set
      ub_estado = @w_hijo
      where ub_estado    = 'N'
      
      if @@error <> 0 return 710001
      
      set rowcount 0
      
   end
   
   /* CONTROL DE TERMINACION DE PROCESO */
   if not exists(select 1 from ca_universo_conta with (nolock)
   where ub_estado = @w_hijo) begin
     
      update cobis..ba_ctrl_ciclico with (rowlock) set
      ctc_procesar = 'N'
      where ctc_sarta      = @w_sarta
      and   ctc_batch      = @w_batch
      and   ctc_secuencial = @w_hijo
      
      if @@error <> 0 return 710002  

   end
end

if @@trancount = 0 begin
   begin tran 
   select @w_commit = 'S'
end      


/* RESERVAR UN RANGO DE COMPROBANTES */
exec @w_error = cob_conta..sp_cseqcomp
@i_tabla     = 'cb_scomprobante', 
@i_empresa   = 1,
@i_fecha     = @w_fecha_proceso,
@i_modulo    = 7,
@i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
@o_siguiente = @w_comprobante_base out
   
if @w_error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
   goto ERRORFIN
end

/* RESERVA COMPROBANTES PARA LA FECHA DE PROCESO */
update cob_conta..cb_seqnos_comprobante with (rowlock) set
sc_actual           = sc_actual + (@w_bloque * 2)
where sc_empresa = 1
and   sc_fecha   = @w_fecha_proceso
and   sc_tabla   = 'cb_scomprobante'
and   sc_modulo  = 7 

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
   goto ERRORFIN
end

if @w_commit = 'S' begin 
   commit tran            
   select @w_commit = 'N'
end                      

/* CREAR TABLA DE TRABAJO TEMPORAL PARA MANEJAR LOS DETALLES DE LA TRANSACCION A CONTABILIZAR */
create table #detalles(
dtr_concepto   varchar(10)    null,        
dtr_codvalor   int         null,            
dtr_moneda     int         null,  
dtr_cuenta     varchar(20) null,          
dtr_monto      money       null,
dtr_dividendo  int        null,
dtr_secuencial int       null,
dtr_operacion  int         null)
   
/* LAZO RECORRER CADA UNA DE LAS TRANSACCIONES A CONTABILIZAR */
while 1=1 begin

   set rowcount 1

   select 
   @w_operacionca    = ub_operacion,
   @w_secuencial     = ub_secuencial,
   @w_fecha_mov      = ub_fecha_mov,
   @w_fecha_val      = ub_fecha_ref,
   @w_of_origen_cur  = ub_ofi_usu,
   @w_tran_cur       = ub_tran,
   @w_op_oficina     = ub_ofi_oper
   from ca_universo_conta  --with (nolock)  Se comenta para evitar lectura sucia
   where ub_estado    = @w_hijo

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
       
   set rowcount 0
            
   update ca_universo_conta set   --with (rowlock) se retira para evitar lecturas sucias
   ub_estado   = 'P'
   where ub_operacion  = @w_operacionca
   and   ub_secuencial = @w_secuencial
   and   ub_estado     = @w_hijo
   
   if @@rowcount = 0 return 0  -- tenemos dos proceso con el mismo hijo.  
         
   /* VARIABLES INICIALES */
   select
   @w_asiento        = 0,
   @w_tot_credito    = 0,
   @w_tot_debito     = 0,
   @w_tot_credito_me = 0,
   @w_tot_debito_me  = 0,
   @w_mensaje        = '',
   @w_cuenta_final   = '',
   @w_reverso        = 'N',
   @w_comprobante    = 0,
   @w_cliente_al     = null

   /* LEER DATOS DE LA OPERACION */
   select 
   @w_banco            = op_banco,
   @w_sector           = op_sector,
   @w_gar_admisible    = case when isnull(op_gar_admisible,'N') = 'S' then 'I' else 'O' end,
   @w_calificacion     = isnull(ltrim(rtrim(op_calificacion)), 'A'),
   @w_clase_cart       = op_clase,
   @w_op_estado        = op_estado,
   @w_ente             = op_cliente,
   --@w_op_oficina       = op_oficina,
   @w_op_moneda        = op_moneda,
   @w_toperacion       = op_toperacion,
   @w_op_origen_fondos = dt_categoria,
   @w_entidad_convenio = case when dt_entidad_convenio = @w_bancamia then '1' else '0' end,
   @w_tramite          = op_tramite,   
   @w_subtipo_cart     = op_subtipo_linea
   from ca_operacion, ca_default_toperacion with (nolock)
   where op_operacion  = @w_operacionca
   and   op_toperacion = dt_toperacion
   and   op_moneda     = dt_moneda 

   if @@rowcount = 0 and @w_operacionca > 0 begin 
      select 
      @w_error   = 701049,
      @w_mensaje = 'REVISAR EXISTENCIA DE LA OPERACION en  ca_operacion' 
      goto ERROR1
   end

   if @w_secuencial < 0 select @w_reverso = 'S'
   
   if @w_operacionca = @w_op_gar
      select @w_banco = tr_banco,
             @w_ente  = convert(int, tr_banco),
	         @w_toperacion   = tr_toperacion,
			 @w_sector       = '',
			 @w_clase_cart   = '',
			 @w_subtipo_cart = ''
	  from  ca_transaccion		 
	  where tr_operacion  = @w_operacionca
      and   tr_secuencial = @w_secuencial
 

   /* CONCEPTO DEL COMPROBANTE */
   select @w_descripcion = 
   case @w_operacionca when @w_op_gar then 
   'Cli:' else 'Ban:' end + ltrim(rtrim(@w_banco))   + ' ' +
   'Sec:' + convert(varchar,@w_secuencial)     + ' ' +
   'Trn:' + ltrim(rtrim(@w_tran_cur))          + ' ' +   
   'Rev:' + convert(char(1),@w_reverso)        + ' ' +
   'TOp:' + ltrim(rtrim(@w_toperacion))        + ' ' +
   'FVa:' + convert(varchar(10),@w_fecha_val,103)                                                   
                
   if @i_debug = 'S' begin
      print ''
      print 'CONTABILIZANDO... ' + @w_descripcion 
   end

   /* CONTABILIDAD ELIMINADA... MARCAR REGISTRO COMO CONTABILIZADO */
   if @w_estado_prod = 'E' begin
      select @w_comprobante = -1  -- Contabilidad eliminada
      goto MARCAR
   end

   truncate table #detalles
   insert into #detalles
   select
   dtr_concepto,        dtr_codvalor,            dtr_moneda,  
   dtr_cuenta,          sum(dtr_monto),          dtr_dividendo, dtr_secuencial,dtr_operacion
   from ca_det_trn with (nolock)
   where dtr_secuencial = @w_secuencial
   and   dtr_operacion  = @w_operacionca
   group by  dtr_concepto, dtr_codvalor, dtr_moneda, dtr_cuenta, dtr_dividendo, dtr_secuencial,dtr_operacion

   if @@rowcount = 0 goto MARCAR

   if @w_tran_cur in ('PAG','EST','ETM')
   begin
      update #detalles set dtr_codvalor = dtr_codvalor + 1
      from ca_dividendo
       where dtr_secuencial = @w_secuencial
       and   dtr_operacion  = @w_operacionca 
       and   di_operacion   = dtr_operacion
       and   di_dividendo   = dtr_dividendo
       and   di_fecha_ven   < @w_fecha_val
       and   dtr_codvalor%10 = 0
       and   dtr_codvalor >= 10000
       
       if @@error <> 0
       begin
         select 
         @w_error   = 701148,
         @w_mensaje = ' ERROR ACTUALIZACION CODIGO VALOR EXIGIBLE/NO EXIGIBLE' 
         goto ERROR1
       end
   end
   
   /* DETERMINAR PERFIL CONTABLE */
   select @w_perfil = ltrim(rtrim(to_perfil))
   from ca_trn_oper with (nolock)
   where to_toperacion = @w_toperacion
   and   to_tipo_trn   = @w_tran_cur

   if @@rowcount = 0 begin 
      select 
      @w_error   = 701148,
      @w_mensaje = ' ERROR NO EXISTE TRN ' + isnull(@w_tran_cur,'') + ' PARA EL TOp:' + isnull(@w_toperacion,'') + ' EN LA TABLA ca_trn_oper' 
      goto ERROR1
   end

   if not exists(select 1 from cob_conta..cb_perfil with (nolock)
   where pe_empresa  = 1
   and   pe_producto = @w_cod_producto
   and   pe_perfil   = @w_perfil) begin
      select 
      @w_error   = 701148,
      @w_mensaje = ' ERROR NO EXISTE PERFIL ' + @w_perfil + ' EN LA TABLA cb_perfil'
      goto ERROR1
   end


   if @w_fecha_mov = @w_fecha_proceso begin 
 
      select @w_comprobante = @w_comprobante_base
      select @w_comprobante_base = @w_comprobante_base + 1

   end else begin

      /* RESERVAR UN RANGO DE COMPROBANTES */
      exec @w_error = cob_conta..sp_cseqcomp
      @i_tabla     = 'cb_scomprobante', 
      @i_empresa   = 1,
      @i_fecha     = @w_fecha_mov,
      @i_modulo    = 7,
      @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
      @o_siguiente = @w_comprobante out
   
      if @w_error <> 0 begin
         select 
         @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
         goto ERROR1
      end

   end

   if @i_debug = 'S' begin
     print '   @w_comprobante: ' + cast(@w_comprobante as varchar)
     print '   @w_perfil:      ' + @w_perfil
   end
   
   
   /** SI SE TRATA DE UNA REVERSA DE TRANSACCION */
   if @w_secuencial < 0 
      select @w_factor = -1
   else
      select @w_factor = 1
   
   /** CURSOR PARA OBTENER LOS DETALLES DEL PERFIL RESPECTIVO **/
   declare cursor_perfil cursor for select
   dtr_concepto,        dtr_codvalor,            dtr_moneda,  
   dtr_cuenta,          dp_cuenta,               dp_debcred,        
   dp_constante,        dp_origen_dest,          dp_area,
   dtr_monto
   from #detalles, cob_conta..cb_det_perfil with (nolock)
   where dp_empresa     = 1
   and   dp_producto    = @w_cod_producto  --cartera
   and   dp_perfil      = @w_perfil
   and   dp_codval      = dtr_codvalor
   and   abs(dtr_monto)>= power(convert(float, 10), isnull(@w_num_dec_mn, 0) * -1)
   
   open cursor_perfil

   fetch cursor_perfil into
   @w_dtr_concepto,     @w_dtr_codval,     @w_dtr_moneda,
   @w_dtr_cuenta,       @w_dp_cuenta,      @w_dp_debcred,       
   @w_dp_constante,     @w_dp_origen_dest, @w_dp_area,          
   @w_dtr_monto

   while @@fetch_status = 0 begin

      if @i_debug = 'S' begin
         print '    RUBRO:  ' + @w_dtr_concepto    
         print '    Param:  ' + @w_dp_cuenta
         print '    CodVal: ' + cast(@w_dtr_codval as varchar)
         print '    Sector: ' + @w_sector
         print '    perfil: ' + @w_perfil
         print '    cl_cart:' + @w_clase_cart
         print '    subtipo:' + @w_subtipo_cart
         print '    toper:  ' + @w_toperacion
         print '    total:  ' + cast(@w_secuencial as varchar)
         print '    Of_orig:' + cast(@w_of_origen_cur as varchar)
         print '    Of_dest:' + cast(@w_op_oficina as varchar)
	     print '    Monto:  ' + cast(@w_dtr_monto as varchar)
      end

      
      
      select 
      @w_debito         = 0.00,
      @w_debito_me      = 0.00,
      @w_credito        = 0.00,
      @w_credito_me     = 0.00,
      @w_dtr_concepto   = ltrim(rtrim(@w_dtr_concepto)),
      @w_con_iva        = 'N',
      @w_conret         = 'N',  
      @w_valor_base     = 0,
      @w_con_timbre     = 'N',
      @w_valor_timbre   = 0,
      @w_valor_ref      = null,
      @w_afecta         = null,
      @w_porcentaje_iva = 0,
      @w_dtr_monto      = @w_dtr_monto * @w_factor
      
      select @w_re_area = ta_area 
      from cob_conta..cb_tipo_area with (nolock)
      where ta_tiparea  = @w_dp_area
      and   ta_empresa  = 1
      and   ta_producto = 7
      
      if @@rowcount = 0 select @w_re_area = @w_ar_origen
      
      /* CONCEPTO DEL ASIENTO */
      select @w_concepto = @w_descripcion
	  if @w_operacionca > 0
	     select @w_concepto = @w_concepto           +
         ' Cpt:'  + @w_dtr_concepto                 +
         ' CVa:'  + convert(varchar,@w_dtr_codval)

      /* TRANSACCION REALIZADA POR SERVICIOS BANCARIOS */
      if @w_tran_cur = 'DES' begin

         select @w_idlote = 0
         select @w_idlote       = isnull(dm_idlote,0)
         from ca_desembolso with (nolock)
         where isnull(dm_idlote ,0) > 0
         and   dm_producto = @w_dtr_concepto
         and   dm_estado   = 'A'
         and   dm_secuencial = @w_secuencial
         and   dm_operacion  = @w_operacionca       
                  
         if @w_idlote > 0 begin
            exec @w_error = cob_sbancarios..sp_qry_num_inst
            @i_sec        = @w_idlote,
            @i_interfaz   = 'S',
            @o_numero     = @w_cheque out
            
            if @w_error <> 0 begin
               select 
               @w_mensaje  = ' ERR CONSULTA CHEQUE ENTREGADO POR DESEMBOLSO' + '-',
               @w_error    = 710004
               close cursor_perfil
               deallocate cursor_perfil
               goto ERROR1
            end
            
            if @w_cheque is null begin
               select 
               @w_mensaje  = ' ERR CONSULTA CHEQUE ENTREGADO POR DESEMBOLSO VALOR NULO' + '-',
               @w_error    = 710004
               close cursor_perfil
               deallocate cursor_perfil
               goto ERROR1
            end            
            
            select @w_concepto = @w_concepto + ' Chq:'  + convert(varchar(24),@w_cheque)
            select @w_descripcion = @w_descripcion + ' Chq:'  + convert(varchar(24),@w_cheque)
         end  
         else 
         begin 
         
            select @w_dm_producto  = null
            select @w_dm_producto  = dm_producto 
            from ca_desembolso with (nolock)
            where isnull(dm_idlote ,0) = 0
            and   dm_producto   = @w_dtr_concepto
            and   dm_estado     = 'A'
            and   dm_secuencial = @w_secuencial
            and   dm_operacion  = @w_operacionca      

            -- Si  no existe el desembolso se consulta la transaccion para encontrar el concepto
            -- en caso de ser un reverso
            if  @w_dm_producto  is null
                select   @w_dm_producto  = dtr_concepto
                from cob_cartera..ca_det_trn
                where dtr_secuencial = @w_secuencial
                and   dtr_operacion  = @w_operacionca 
                and   dtr_concepto   = 'NCAH'
             
            -- Se toma el ente de la alianza para el desemboolso
            if @w_dm_producto = 'NCAH' 
            begin 
               select @w_cliente_al = null
               select @w_cliente_al = convert(varchar(20), al_ente )
               from cob_credito..cr_tramite, cobis..cl_alianza, cobis..cl_alianza_cliente
               where tr_tramite = @w_tramite
               and   tr_alianza = al_alianza 
               --and   al_estado  = 'V'
               and   tr_cliente = ac_ente
               and   tr_alianza = al_alianza 
               --and   ac_estado  = 'V' 
            end
         end
         
      end
      
      /* CONTABILIDAD DE IMPUESTOS (SOLO PARA RUBROS TIPO IVA) */
      select @w_categoria = co_categoria from ca_concepto with (nolock)
      where  co_concepto  = @w_dtr_concepto

      select @w_referencial_iva = ru_referencial
      from   ca_rubro with (nolock)
      where  ru_concepto   = @w_dtr_concepto
      and    ru_toperacion = @w_toperacion

      select @w_maxfecha_iva   = max(vr_fecha_vig)
      from   ca_valor_referencial with (nolock)
      where  vr_tipo           = @w_referencial_iva

      select @w_porcentaje_iva = vr_valor
      from   ca_valor_referencial with (nolock)
      where  vr_tipo           = @w_referencial_iva
      and    vr_fecha_vig      = @w_maxfecha_iva
      
      select @w_montodes = ro_base_calculo
      from ca_rubro_op
      where ro_operacion = @w_operacionca
      and   ro_concepto  = @w_dtr_concepto
      
       if @w_categoria ='A'
       begin         
         select @w_con_iva = 'S'
         select @w_porcentaje_iva = isnull(@w_porcentaje_iva,0)         
         if @w_porcentaje_iva > 0.01 
               select @w_valor_base=@w_dtr_monto/(@w_porcentaje_iva*0.01)
         select @w_valret = null      
       end
       if @w_categoria = 'T'  
       begin         
         select @w_conret  = 'S'
         select @w_porcentaje_iva = isnull(@w_porcentaje_iva,0)         
         if @w_porcentaje_iva > 0 
         begin
               select @w_valret = @w_dtr_monto
               select @w_valor_base=@w_montodes
               --select @w_dtr_monto = null
         end      
       end

      /* REVERSAS EN CASO DE NEGATIVOS, INVERTIR SIGNOS DEL ASIENTO */
      if @w_dtr_monto < 0 begin
         if @w_dp_debcred = '2' select @w_dp_debcred = '1'   
         else select @w_dp_debcred = '2'   
         select @w_dtr_monto = -1 * @w_dtr_monto
      end

      select @w_debcred = convert(int,@w_dp_debcred)


      /* DETERMINAR MONTO EN MONEDA NACIONAL */         
      if @w_dtr_moneda <> @w_mon_nac begin

         exec @w_error = sp_buscar_cotizacion
         @i_moneda     = @w_dtr_moneda,
         @i_fecha      = @w_fecha_proceso,
         @o_cotizacion = @w_cotizacion output
         
         if @w_error <> 0 begin      
            select 
            @w_mensaje  = 'Error en Busqueda Cotizacion',
            @w_error    = 701070
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end

         select @w_dtr_monto_mn = @w_cotizacion * @w_dtr_monto         

      end else begin
         select 
         @w_cotizacion   = 1,
         @w_dtr_monto_mn = @w_dtr_monto                           --LAZG Redondeos
      end

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA NACIONAL */
      select
      @w_debito   = @w_dtr_monto_mn*(2-@w_debcred),
      @w_credito  = @w_dtr_monto_mn*(@w_debcred-1)

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA EXTRANJERA */
      if  @w_dp_constante = 'T' 
      and @w_dtr_moneda  <> @w_mon_nac
         select
         @w_debito_me  = @w_dtr_monto * (2-@w_debcred),
         @w_credito_me = @w_dtr_monto * (@w_debcred-1)

      /* FORZAR MONEDA LOCAL SEGUN CORRESPONDA */
      if @w_dp_constante = 'L' 
         select 
         @w_moneda_as  = @w_mon_nac,
         @w_debito_me  = 0.00,
         @w_credito_me = 0.00
      else
         select @w_moneda_as = @w_dtr_moneda

      /* DETERMINAR OFICINA A LA QUE SE CONTABILIZARA */
      if @w_dp_origen_dest = 'O' 
         select @w_oficina = @w_of_origen_cur
      if @w_dp_origen_dest = 'D' and @w_tran_cur <> 'TCO'
         select @w_oficina = @w_op_oficina
      if @w_dp_origen_dest = 'D' and @w_tran_cur = 'TCO'
         select @w_oficina = convert(int,@w_dtr_cuenta)
      if @w_dp_origen_dest = 'C' 
         select @w_oficina = ta_ofi_central
         from cob_conta..cb_tipo_area
         where ta_empresa  = 1
         and   ta_producto = @w_cod_producto
         and   ta_tiparea  = @w_dp_area
         
      /* DETERMINAR LA CUENTA CONTABLE DONDE REGISTRAR EL ASIENTO */
      if substring(@w_dp_cuenta,1,1) in ('1','2','3','4','5','6','7','8','9','0')
      begin
      
         select @w_cuenta_final   = @w_dp_cuenta
      
      end else begin

         select @w_stored = pa_stored
         from cob_conta..cb_parametro with (nolock)
         where pa_empresa     = 1
         and   pa_parametro   = @w_dp_cuenta

         if @@rowcount = 0 begin
            select 
            @w_mensaje  = ' ERR NO EXISTE TABLA DE CUENTAS ' +  @w_dp_cuenta + '(cb_parametro)',
            @w_error    = 701102
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end
         
         if @w_tran_cur = 'TLI' 
            select @w_entidad_convenio = convert(int, @w_dtr_cuenta)

         -- LGU-ini: buscar la forma de pago del RPA para esa cuenta ponerla al SOBRANTE
         IF @w_dtr_concepto = 'SOBRANTE'
         BEGIN
            SELECT
               @w_secuencial_ref = tr_secuencial_ref -- secuencial del RPA
            FROM ca_transaccion
            WHERE tr_operacion = @w_operacionca
            AND tr_secuencial  = abs(@w_secuencial)
            
            SELECT TOP 1
               @w_dtr_concepto = dtr_concepto  -- FORMA DE PAGO
            FROM ca_det_trn
            WHERE dtr_operacion = @w_operacionca
            AND dtr_secuencial  = @w_secuencial_ref
            AND dtr_concepto  <> 'VAC0'
            
            if @w_dtr_concepto = 'GAR_DEB'
            begin
               select @w_dtr_concepto = 'SOBRANTE'
            end 
         END 
         -- LGU-fin: buscar la forma de pago del RPA para esa cuenta ponerla al SOBRANTE

         select @w_clave = case @w_stored
         when 'sp_ca01_pf' then rtrim(ltrim(@w_sector)) +'.' + rtrim(ltrim(@w_clase_cart)) +'.'+ rtrim(ltrim(isnull(@w_subtipo_cart, '99'))) +'.'+ rtrim(ltrim(isnull(@w_toperacion, '')))
         when 'sp_ca02_pf' then convert(varchar,@w_dtr_moneda)
         when 'sp_ca03_pf' then rtrim(ltrim(@w_clase_cart)) +'.'+ rtrim(ltrim(@w_sector))
         when 'sp_ca04_pf' then rtrim(ltrim(@w_dtr_concepto))
         --when 'sp_ca05_pf' then @w_toperacion
         --when 'sp_ca06_pf' then @w_dtr_cuenta
         --when 'sp_ca07_pf' then @w_calificacion +'.'+ @w_gar_admisible +'.'+ @w_clase_cart +'.'+convert(varchar,@w_dtr_moneda) +'.'+ @w_op_origen_fondos + '.' + @w_entidad_convenio
         --when 'sp_ca08_pf' then @w_clase_cart +'.'+convert(varchar,@w_dtr_moneda) +'.'+ @w_op_origen_fondos + '.' + @w_entidad_convenio
         end   
         
         select @w_cuenta_final = isnull(rtrim(ltrim(re_substring)), '')
         from cob_conta..cb_relparam with (nolock)
         where re_empresa             = 1
         and   re_parametro           = @w_dp_cuenta
         and   ltrim(rtrim(re_clave)) = @w_clave
                     
         if @@rowcount = 0 select @w_cuenta_final = ''
            
      end
	  if @i_debug = 'S'  begin
		print '      Generando asiento... of: ' + cast(@w_re_ofconta   as varchar)
		print '            Nro. Compro......: ' + cast(@w_comprobante  as varchar)
		print '            Cuenta Final.....: ' + cast(@w_cuenta_final as varchar)
		print '            Ente.............: ' + cast(@w_ente         as varchar)
		print '            afect............: ' + cast(@w_dp_debcred   as varchar)
		print '            debito...........: ' + cast(@w_debito       as varchar)
		print '            credito..........: ' + cast(@w_credito      as varchar)
	  end	  
     
      /* GENERAR ASIENTO DEL COMPROBANTE */
      if  @w_cuenta_final <> '' and @w_credito+@w_debito >= 0.01  begin

         select 
         @w_asiento        = @w_asiento        + 1,
         @w_tot_credito    = @w_tot_credito    + @w_credito,
         @w_tot_debito     = @w_tot_debito     + @w_debito,
         @w_tot_credito_me = @w_tot_credito_me + @w_credito_me,
         @w_tot_debito_me  = @w_tot_debito_me  + @w_debito_me
         
         select @w_oficina_aux = @w_oficina
         
         /* DETERMINAR OFICINA DESTINO*/
         select @w_re_ofconta = re_ofconta
         from   cob_conta..cb_relofi with (nolock)
         where  re_filial  = 1
         and    re_empresa = 1
         and    re_ofadmin = @w_oficina_aux

         if @@rowcount = 0 begin
            select 
            @w_mensaje  = 'ERR NO EXISTE OF.CONTABLE (cb_relofi) ' + convert(varchar,@w_oficina) + '- @w_dp_origen_dest ' + CONVERT(VARCHAR,@w_dp_origen_dest) + '-'  ,
            @w_error    = 701102
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end

         
         if @w_conret = 'S'
            select @w_dtr_monto = null
			
		 if(@w_tran_cur = 'DSC') select @w_ente = convert(int,@w_dtr_cuenta)		 
            
         insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock) (                                                                                                                                              
         sa_producto,        sa_fecha_tran,        sa_comprobante,
         sa_empresa,         sa_asiento,           sa_cuenta,
         sa_oficina_dest,    sa_area_dest,         sa_credito,
         sa_debito,          sa_concepto,          sa_credito_me,
         sa_debito_me,       sa_cotizacion,        sa_tipo_doc,
         sa_tipo_tran,       sa_moneda,            sa_opcion,
         sa_ente,            sa_con_rete,          sa_base,
         sa_valret,          sa_con_iva,           sa_valor_iva,
         sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
         sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
         sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
         sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
         sa_posicion,        sa_debcred,           sa_oper_banco,
         sa_cheque,          sa_doc_banco,         sa_fecha_est, 
         sa_detalle,         sa_error )
         values (
         7,                  @w_fecha_mov,         @w_comprobante,
         1,                  @w_asiento,           @w_cuenta_final,
         @w_re_ofconta,      @w_re_area,           @w_credito,
         @w_debito,          isnull(@w_concepto,   @w_descripcion), @w_credito_me,
         @w_debito_me,       @w_cotizacion,        'N',
        'A',                 @w_moneda_as,         0,
         @w_ente,            @w_conret,            @w_valor_base,
         @w_valret,          @w_con_iva,           @w_dtr_monto,
         null,               null,                 null,
         null,               null,                 null,
         null,               null,                 @w_banco,
         'N',                null,                 null,
         'S',                @w_dp_debcred,        null,
         null,               @w_cliente_al,        null,
         null,               'N' )
         
         if @@error <> 0 begin
            select 
            @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_sasiento_tmp ',
            @w_error   = 710001
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end

     end

      fetch cursor_perfil into
      @w_dtr_concepto,     @w_dtr_codval,     @w_dtr_moneda,
      @w_dtr_cuenta,       @w_dp_cuenta,      @w_dp_debcred,       
      @w_dp_constante,     @w_dp_origen_dest, @w_dp_area,          
      @w_dtr_monto       

   end  -- cursol de los detalles del perfil

   close cursor_perfil
   deallocate cursor_perfil


   /** GENERACION DEL COMPROBANTE **/   
   select @w_re_ofconta = re_ofconta
   from   cob_conta..cb_relofi with (nolock)
   where  re_filial  = 1
   and    re_empresa = 1
   and    re_ofadmin = @w_of_origen_cur

   if @@rowcount = 0 begin     
      select 
      @w_mensaje = ' ERR NO EXISTE OF.ORIGEN ' + convert(varchar,@w_of_origen_cur)+ '-',
      @w_error   = 701102
      goto ERROR1
   end
   
   if abs(@w_tot_debito - @w_tot_credito) >= 0.01 begin
      select 
      @w_mensaje = 'NO CUADRAN DEBITOS CON CREDITOS: D-> ' +  convert(varchar,@w_tot_debito)+ ' C-> ' + convert(varchar,@w_tot_credito),
      @w_error   = 701102
      goto ERROR1
   end


   if @w_tot_debito >= 0.01 or @w_tot_credito >= 0.01 begin

      if @i_debug = 'S' print '   Generando comprobante... of: ' + cast(@w_re_ofconta as varchar)
      
      if @@trancount = 0 begin
         begin tran 
         select @w_commit = 'S'
      end      
      
      insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock) (
      sc_producto,       sc_comprobante,   sc_empresa,
      sc_fecha_tran,     sc_oficina_orig,  sc_area_orig,
      sc_digitador,      sc_descripcion,   sc_fecha_gra,      
      sc_perfil,         sc_detalles,      sc_tot_debito,
      sc_tot_credito,    sc_tot_debito_me, sc_tot_credito_me,
      sc_automatico,     sc_reversado,     sc_estado,
      sc_mayorizado,     sc_observaciones, sc_comp_definit,
      sc_usuario_modulo, sc_tran_modulo,   sc_error)
      values (
      @w_cod_producto,   @w_comprobante,   1,
      @w_fecha_mov,      @w_re_ofconta,    @w_ar_origen,
      @s_user,           @w_descripcion,   getdate(),     
      @w_perfil,         @w_asiento,       @w_tot_debito,
      @w_tot_credito,    @w_tot_debito_me, @w_tot_credito_me,
      @w_cod_producto,   'N',              'I',
      'N',               null,             null,
      'sa',              @w_secuencial,   'N')
      
      if @@error <> 0 begin
         select 
         @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_scomprobante_tmp ', 
         @w_error   = 710001
         goto ERROR1
      end

      update ca_transaccion with (rowlock)set 
      tr_comprobante  =  @w_comprobante,
      tr_fecha_cont   =  @w_fecha_proceso,
      tr_estado       =  'CON'
      where tr_operacion  = @w_operacionca
      and   tr_secuencial = @w_secuencial
      and   tr_estado     = 'ING'
         
      select
      @w_error    = @@error,
      @w_rowcount = @@rowcount

      if @w_error <> 0 begin
         select @w_mensaje = ' ERR AL MARCAR TABLA DE TRANSACCION BANCAMIA ' 
         select @w_error = 700002
         goto ERROR1
      end 
      
      if @w_rowcount = 0 begin
         if @w_commit = 'S' begin
            rollback tran
            select @w_commit = 'N'
         end
         return 0  -- tenemos dos proceso con el mismo hijo.
      end
      
      if @w_commit = 'S' begin 
         commit tran
         select @w_commit = 'N'
      end                 
      
      goto SIGUIENTE
      
   end 

   MARCAR:

   update ca_transaccion with (rowlock)set 
   tr_comprobante  =  @w_comprobante,
   tr_fecha_cont   =  @w_fecha_proceso,
   tr_estado       =  'CON'
   where tr_operacion  = @w_operacionca
   and   tr_secuencial = @w_secuencial
      
   if @@error <> 0 begin
      select @w_mensaje = ' ERR AL MARCAR TABLA DE TRANSACCION BANCAMIA ' 
      select @w_error = 700002
      goto ERROR1
   end
      
   goto SIGUIENTE

   ERROR1:

   if @w_commit = 'S' begin
      rollback tran
      select @w_commit = 'N'
   end      

   select @w_mensaje = isnull(@w_descripcion, convert(varchar(10), @w_operacionca)) + ' ' + @w_mensaje


   exec cob_interfase..sp_errorcconta
   @t_trn         = 60011,
   @i_operacion   = 'I',
   @i_empresa     = 1,
   @i_fecha       = @w_fecha_proceso,
   @i_producto    = 7,
   @i_tran_modulo = @w_secuencial, --@w_tran_cur,
   @i_asiento     = 0,
   @i_fecha_conta = @w_fecha_mov,
   @i_numerror    = @w_error,
   @i_mensaje     = @w_mensaje,
   @i_perfil      = @w_perfil,
   @i_oficina     = @w_re_ofconta

   if @i_debug = 'S' print '            ERROR1 --> ' + @w_mensaje

   exec sp_errorlog
   @i_fecha       = @w_fecha_proceso, 
   @i_error       = 7200, 
   @i_usuario     = @s_user,
   @i_tran        = 7000, 
   @i_tran_name   = @w_sp_name, 
   @i_rollback    = 'N',
   @i_cuenta      = @w_banco, 
   @i_descripcion = @w_mensaje

   SIGUIENTE:

end --end while 

if @w_opcion = 'B' begin -- Validacion para marcacion de todos los hilos como finalizados   

   update cobis..ba_ctrl_ciclico with (rowlock) set
   ctc_estado = 'F'
   where ctc_sarta      = @w_sarta
   and   ctc_batch      = @w_batch
   and   ctc_secuencial = @w_hijo
      
   if @@error <> 0 return 710002  
end

return 0

ERRORFIN:

if @w_commit = 'S' begin 
   rollback tran            
   select @w_commit = 'N'
end   

exec cob_interfase..sp_errorcconta
@t_trn         = 60011,
@i_operacion   = 'I',
@i_empresa     = 1,
@i_fecha       = @w_fecha_proceso,
@i_producto    = 7,
@i_tran_modulo = @w_secuencial, --@w_tran_cur,
@i_asiento     = 0,
@i_fecha_conta = @w_fecha_mov,
@i_numerror    = @w_error,
@i_mensaje     = @w_mensaje,
@i_perfil      = @w_perfil,
@i_oficina     = @w_re_ofconta

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

go
