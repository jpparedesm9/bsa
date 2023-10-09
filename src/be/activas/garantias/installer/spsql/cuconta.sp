/************************************************************************/
/*	Archivo:            cuconta.sp                                      */
/*	Stored procedure:   sp_cuconta                                      */
/*	Base de datos:      cob_custodia                                    */
/*	Producto:           Garantias                                       */
/*	Disenado por:       RRB                                             */
/*	Fecha de escritura:	Jun 2011                                        */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propied            */
/*  ' MACOSA ', representantes exclusivos para el Ecuador               */
/*  ' NCR CORPORATION '.                                                */
/*  Su uso no autorizado queda expresamente prohibido asi               */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*                              PROPOSITO                               */
/*  Contabilizar las transccioes generadas desde garantías por cambios  */
/*  de estado o de valor                                                */
/************************************************************************/  
/*                             MODIFICACIONES                           */
/************************************************************************/  

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cuconta')
   drop proc sp_cuconta
go

create proc sp_cuconta
@i_param1              varchar(255)  = null,
@i_param2              varchar(255)  = null,
@i_param3              varchar(255)  = null,
@i_param4              varchar(255)  = null
            
as 
declare 
@w_error               int,
@w_return              int,
@w_sp_name             descripcion,
@w_money               money,
@w_area_custodia       int, 
@w_asiento             int, 
@w_cuenta_final        varchar(20),
@w_dp_debcred          char(1),
@w_tipo_doc            char(1),
@w_dp_cuenta           varchar(20),
@w_dp_constante        varchar(20),
@w_cuenta_aux          varchar(20),
@w_pos                 int,
@w_trama               varchar(20),
@w_ascii               int,
@w_contenido_trama     int,
@w_resultado           varchar(20),
@w_dtr_codvalor        int,
@w_estado              int,
@w_dtr_valor           money,
@w_dtr_valor_mn        money,
@w_debito              money,
@w_credito             money,
@w_debito_me           money, 
@w_credito_me          money,
@w_tot_debito          money,
@w_tot_credito         money,
@w_tot_credito_me      money,
@w_tot_debito_me       money,
@w_re_ofconta          int,
@w_moneda_cont         char(1),
@w_moneda_nacional     int,
@w_comprobante         int,
@w_debcred             int,
@w_debcred_s           char(1),
@w_of_destino          int,
@w_of_origen		   int,
@w_oficina_custodia    int,   --PGA 16mar2001 
@w_of_dest_as          int,
@w_ar_destino          int,
@w_ar_origen           int,
@w_posicion            char(1), 
@w_mensaje             varchar(255),
@w_tipo                catalogo,
@w_perfil              catalogo,
@w_tr_tran             catalogo,
@w_descripcion_a       varchar(160),
@w_descripcion         varchar(25),
@w_tr_secuencial       int,
@w_evitar_asiento      char(1), 
@w_clase_custodia      char(1),  
@w_moneda              tinyint, 
@w_decimales           char(1), 
@w_num_dec_mn          int,
@w_rollback            int,
@w_clase_cartera       char(1),
@w_dtr_cotizacion      float,
@w_codigo_externo      varchar(64),
@w_codigo_externo_aux  varchar(64),
@w_cliente             int, 
@w_today               datetime,
@w_clase               catalogo,
@w_tipo_gar            varchar(64),
@w_estado_gar          catalogo,
@w_of_gar              int,
@w_of_dest_gar         int,
@w_secuencial          int,
@w_moneda1             tinyint,
@w_cliente1            int,
@w_usuario             descripcion,
@w_garan_empleado      char(1),
@w_conta               int,
@w_error_asiento       varchar(120), --pga 15may2001
@w_error_comprob       varchar(120), --pga 15may2001
@contador              int,
@cont                  int,
@w_calificacion        char(1),
@w_fecha_con           datetime,
@w_tran_modulo         varchar(20),
@w_filial              tinyint,
@w_fecha               datetime,
@w_tipo_trn            catalogo,
@w_debug               char(1),
@w_comprobante_base    int,
@w_commit              char(1),
@s_user                varchar(20),
@w_stored              varchar(20),
@w_clave               varchar(20),
@w_rowcount            int,
@w_cod_producto        tinyint,
@w_fecha_hasta         datetime,
@w_fecha_proceso       datetime,
@w_estado_prod         char(1)

if @w_debug = 'S'  print '--> sp_cuconta.Inicio Contabilidad...'

/* VARIABLES DE TRABAJO */
select 
@w_sp_name          = 'cuconta.sp',
@w_moneda_nacional  = 0,
@w_mensaje          = '',
@w_today            = convert(varchar(10), getdate(),101),
@s_user             = isnull(@s_user, 'crebatch'),
@w_area_custodia    = 0,
@w_oficina_custodia = 0,
@w_debug            = 'N',
@w_commit           = 'N' ,
@w_cod_producto     = 19,

-- Variables Entrada

@w_filial          = @i_param1,
@w_codigo_externo  = @i_param2,
@w_debug           = @i_param3

select @w_error_asiento = '', 
       @w_error_comprob = '' ,
       @w_num_dec_mn    = 0

/** TABLA TEMPORAL PARA ALMACENAR LOS ASIENTOS **/
create table #asiento (
asiento            int,
cuenta             varchar(24),
oficina_dest       int,
area_dest          int,
credito            money,
debito             money,
concepto           varchar(60),
credito_me         money,
debito_me          money,
moneda             int, 
cotizacion         float,
debcred            char(1),
moneda_cont        char(1),
cliente            int,			
documento          varchar(64),
base_retencion     int null,		
concepto_retencion varchar(64) null
)

if @@trancount = 0 begin
   begin tran 
   select @w_commit = 'S'
end      

/* DETERMINAR FECHA PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre with (nolock)
where fc_producto = @w_cod_producto

if @w_debug = 'S'  print '--> sp_caconta. Encontro Corte...'

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
@w_fecha       = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from cob_conta..cb_corte with (nolock)
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha = '01/01/1900' begin
   select 
   @w_error   = 601078,
   @w_mensaje = ' ERROR NO EXISTEN PERIODOS DE CORTE ABIERTOS ' 
   goto ERRORFIN
end

if @w_debug = 'S' begin
   print '--> sp_caconta. Fecha Conta ' + cast(@w_fecha       as varchar)
   print '--> sp_caconta. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
end

/* BORRADO DE ERRORES */
exec @w_return = cob_interfase..sp_errorcconta
@t_trn       = 60025,
@i_operacion = 'D',
@i_producto  = 19,
@i_empresa   = 1

if @w_commit = 'S' begin 
   commit tran            
   select @w_commit = 'N'
end                      

select
B.tr_secuencial,     B.tr_oficina_orig,    B.tr_oficina_dest,  tc_tipo_bien,
cu_clase_custodia,   B.tr_tran,cu_moneda,  cu_codigo_externo,  cg_ente,
cu_tipo,             B.tr_estado_gar,      B.tr_usuario,       tc_garan_empleado,
B.tr_descripcion ,   B.tr_fecha_tran
into #cu_transaccion_tmp
from cu_transaccion B,
     cu_custodia,  
     cu_tipo_custodia,
     cu_cliente_garantia
where B.tr_fecha_tran    >= @w_fecha           
and   B.tr_fecha_tran    <= @w_fecha_hasta     
and B.tr_estado          = 'I'                 
and B.tr_codigo_externo  = cu_codigo_externo
and tc_tipo              = cu_tipo
and cu_codigo_externo    = cg_codigo_externo			
and cg_principal         = 'D'
and (cu_codigo_externo    = @w_codigo_externo or @w_codigo_externo is null)
order by cu_codigo_externo, tr_secuencial 

/** SELECCION DEL AREA DE GARANTIAS**/
select @w_area_custodia = pa_smallint
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'ARG'

if @w_area_custodia = 0 begin
   select @w_mensaje = 'ERR: NO DEFINIDA AREA DE CUSTODIA'
   select @w_error = 190009
   goto ERROR
end
 
/** SELECCION DEL OFICINA DE GARANTIAS**/
select @w_oficina_custodia = pa_smallint
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'OFG'

if @w_oficina_custodia = 0 
begin
   select @w_mensaje = 'ERR: NO DEFINIDA OFICINA DE CUSTODIA'
   select @w_error = 190009
   goto ERROR
end

if @w_debug = 'S'  select * from #cu_transaccion_tmp

/* CURSOR PRINCIPAL DE TRANSACCIONES */
declare cursor_tran cursor for 
select 
tr_secuencial,      tr_oficina_orig,   tr_oficina_dest,   tc_tipo_bien,
cu_clase_custodia,  tr_tran,           cu_moneda,         cu_codigo_externo, 
cg_ente,            cu_tipo,           tr_estado_gar,     tr_usuario,        
tc_garan_empleado,  tr_descripcion,    tr_fecha_tran
from #cu_transaccion_tmp, cu_cambios_estado
where tr_tran        = ce_tran
and   ce_contabiliza = 'S'
and   tr_estado_gar  = ce_estado_fin
--and   ce_estado_ini  = substring(tr_descripcion,10,1) 
order by cu_codigo_externo, tr_secuencial 
for read only

open cursor_tran
fetch cursor_tran into
@w_secuencial,     @w_of_origen,    @w_of_destino, @w_tipo,
@w_clase_custodia, @w_tr_tran,      @w_moneda,     @w_codigo_externo, 
@w_cliente,        @w_tipo_gar,     @w_estado_gar, @w_usuario, 
@w_garan_empleado, @w_descripcion_a,@w_fecha_con

while @@fetch_status = 0 
begin 

   set rowcount 0
   delete #asiento
   
   -- VARIABLES INICIALES 
   
   select 
   @w_asiento        = 0,
   @w_tot_credito    = 0,
   @w_tot_debito     = 0,
   @w_tot_credito_me = 0,
   @w_tot_debito_me  = 0,
   @w_rollback       = 0,
   @w_mensaje        = '',
   @w_clase          = ''
   
   select @w_descripcion_a = @w_descripcion_a + convert(varchar(30), @w_codigo_externo),
          @w_of_gar        = @w_of_origen,
          @w_of_dest_gar   = @w_of_destino,
          @w_perfil        = @w_tr_tran
          
   select @w_descripcion = 
          'Cus:' + @w_codigo_externo + ' ' + 
          'Trn:' + rtrim(@w_tr_tran) + ' ' +
          'Tip:' + rtrim(@w_tipo)    + ' ' + 
          'Mon:' + convert(varchar(3),@w_moneda)
          
   if @w_debug = 'S' begin
      print ''
      print 'CONTABILIZANDO... ' + @w_descripcion 
   end
   
   if @w_debug = 'S' begin
      print '   @w_perfil:     ' + @w_perfil + ' @w_secuencial ' + cast(@w_secuencial as varchar)
   end   
          
  -- CURSOR PARA OBTENER LOS DETALLES DEL PERFIL RESPECTIVO 
   declare cursor_perfil cursor for select
   dp_cuenta,  dp_debcred,   dp_constante,
   ta_area,    dtr_codvalor, dtr_valor,dtr_clase_cartera,
   dtr_calificacion
   from cob_conta..cb_det_perfil,
        cob_conta..cb_tipo_area,
        cob_custodia..cu_det_trn
   where dp_empresa      = @w_filial
   and  dp_empresa       = ta_empresa
   and ta_producto       = dp_producto
   and ta_tiparea        = dp_area
   and ta_utiliza_valor  = 'S'
   and dp_producto       = 19  
   and dp_perfil         = @w_perfil
   and dtr_secuencial    = @w_secuencial
   and dp_codval         = dtr_codvalor
   and dtr_codigo_externo = @w_codigo_externo  --pga21may2001
   for read only

   open cursor_perfil 
   fetch cursor_perfil into
   @w_dp_cuenta,  @w_dp_debcred,   @w_dp_constante,
   @w_ar_destino, @w_dtr_codvalor, @w_dtr_valor,
   @w_clase, @w_calificacion

   while @@fetch_status = 0 begin 
      select @w_evitar_asiento = 'N'
      select @w_debcred      = convert(int,@w_dp_debcred)
      select @w_cuenta_final = ''
      
      if @w_debug = 'S' begin
         print '    Param   :' + @w_dp_cuenta
         print '    CodVal  :' + cast(@w_dtr_codvalor as varchar)
         print '    perfil  :' + @w_perfil
         print '    cl_cart :' + @w_clase
         print '    calif   :' + @w_calificacion
         print '    Of_orig :' + cast(@w_ar_destino as varchar)
         print '    Valor   :' + cast(@w_dtr_valor as varchar)
         print '    Cod.Ext :' + @w_codigo_externo
      end
      
      if @w_fecha_con = @w_fecha begin 
      
         select @w_comprobante = @w_comprobante_base
         select @w_comprobante_base = @w_comprobante_base + 1
      
      end else begin

         /* RESERVAR UN RANGO DE COMPROBANTES */
         exec @w_error = cob_conta..sp_cseqcomp
         @i_empresa   = @w_filial,
         @i_tabla     = 'cb_scomprobante', 
         @i_fecha     = @w_fecha_con,
         @i_modulo    = 7,
         @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
         @o_siguiente = @w_comprobante out
      
         if @w_error <> 0 begin
            select 
            @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
            goto ERROR1
         end
      
      end
         

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
            @w_mensaje  = ' ERR NO EXISTE TABLA DE CUENTAS ' +  isnull(@w_dp_cuenta, 'NO DEFINIDA') + '(cb_parametro)',
            @w_error    = 190001
            if @w_debug = 'S' print @w_mensaje
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end
                  
         select @w_clave = case @w_stored
         when 'sp_cu01_pf' then @w_clase      +'.'+ @w_tipo_gar +'.'+ @w_estado_gar
         when 'sp_cu02_pf' then @w_estado_gar +'.'+ @w_tipo_gar 
         end   
        
         select @w_cuenta_final = isnull(rtrim(ltrim(re_substring)), '')
         from cob_conta..cb_relparam with (nolock)
         where re_empresa             = 1
         and   re_parametro           = @w_dp_cuenta
         and   ltrim(rtrim(re_clave)) = @w_clave
                     
         if @@rowcount = 0 select @w_cuenta_final = ''

         if @w_debug = 'S' print ' GARANTIA CTA ===> @w_codigo_externo ' + @w_codigo_externo + ' @w_cuenta_final  ' + @w_cuenta_final  + ' @w_clave ' + @w_clave
            
      end
      
      /* GENERAR ASIENTO DEL COMPROBANTE */
      if  @w_cuenta_final <> '' begin
      
         if @@trancount = 0 begin
            begin tran 
            select @w_commit = 'S'
         end      

         select @w_asiento = @w_asiento + 1
         -- CAMBIAR CREDITOS Y DEBITOS EN CASO DE NEGATIVOS 
         if @w_dtr_valor < 0 
         begin           

         if @w_debcred = 2 select @w_debcred = 1
            else select @w_debcred = 2
            select @w_dtr_valor    = -1 * @w_dtr_valor
         end 
          
         if @w_moneda = 0
	            select
        	    @w_debito         = @w_dtr_valor*(2-@w_debcred),
	            @w_credito        = @w_dtr_valor*(@w_debcred-1),
	            @w_debito_me         = 0,
	            @w_credito_me        = 0,
	            @w_dtr_cotizacion    = 0
         else
         begin
            select @w_dtr_cotizacion = a.cv_valor
            from cob_conta..cb_vcotizacion a
            where a.cv_moneda = @w_moneda
              and a.cv_fecha = (select max(b.cv_fecha)
                         from   cob_conta..cb_vcotizacion b
                         where  b.cv_moneda = a.cv_moneda
                         and b.cv_fecha <= @w_fecha) --@s_date)
            
	            select @w_debito     = round((@w_dtr_valor*(2-@w_debcred)*
        	                           @w_dtr_cotizacion),@w_num_dec_mn),
	            @w_credito           = round((@w_dtr_valor*(@w_debcred-1)*
	                                   @w_dtr_cotizacion),@w_num_dec_mn),
	            @w_debito_me         = @w_dtr_valor*(2-@w_debcred),
	            @w_credito_me        = @w_dtr_valor*(@w_debcred-1)
            end

         select @w_moneda_cont = convert(char(1),@w_moneda)
         
         if @w_debcred = 2 select @w_debcred_s = '2'
         else              select @w_debcred_s = '1'
 
         select @w_re_ofconta = re_ofconta
         from   cob_conta..cb_relofi
         where  re_filial  = @w_filial
         and    re_empresa = @w_filial
         and    re_ofadmin = convert(int,@w_of_origen) --PGA 16mar2001 @w_of_destino)

         if @w_debug = 'S'  begin
            print '      Generando asiento... of: ' + cast(@w_re_ofconta   as varchar)
            print '            Nro. Compro......: ' + cast(@w_comprobante  as varchar)
            print '            Cuenta Final.....: ' + cast(@w_cuenta_final as varchar)
            print '            Ente.............: ' + cast(@w_cliente      as varchar)
            print '            afect............: ' + cast(@w_dp_debcred   as varchar)
            print '            debito...........: ' + cast(@w_debito       as varchar)
            print '            credito..........: ' + cast(@w_credito      as varchar)
         end
         
         insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock) (                                                                                                                                              
         sa_producto,        sa_fecha_tran,      sa_comprobante,
         sa_empresa,         sa_asiento,         sa_cuenta,
         sa_oficina_dest,    sa_area_dest,       sa_credito,
         sa_debito,          sa_concepto,        sa_credito_me,
         sa_debito_me,       sa_cotizacion,      sa_tipo_doc,
         sa_tipo_tran,       sa_moneda,          sa_opcion,
         sa_ente,            sa_con_rete,        sa_base,
         sa_valret,          sa_con_iva,         sa_valor_iva,
         sa_iva_retenido,    sa_con_ica,         sa_valor_ica,
         sa_con_timbre,      sa_valor_timbre,    sa_con_iva_reten,
         sa_con_ivapagado,   sa_valor_ivapagado, sa_documento,
         sa_mayorizado,      sa_con_dptales,     sa_valor_dptales,
         sa_posicion,        sa_debcred,         sa_oper_banco,
         sa_cheque,          sa_doc_banco,       sa_fecha_est, 
         sa_detalle,         sa_error )
         values (
         19,                 @w_fecha_con,       @w_comprobante,
         1,                  @w_asiento,         @w_cuenta_final,
         @w_re_ofconta,      @w_area_custodia,   @w_credito,
         @w_debito,          @w_descripcion,     @w_credito_me,
         @w_debito_me,       @w_dtr_cotizacion,  'N',
        'A',                 @w_moneda,          0,
         @w_cliente,         null,               @w_dtr_valor,
         null,               null,               @w_dtr_valor,
         null,               null,               null,
         null,               null,               null,
         null,               null,               @w_codigo_externo,
         'N',                null,               null,
         'S',                @w_dp_debcred,      null,
         null,               null,               null,
         null,               'N' )
         
         if @@error <> 0 begin
            select 
            @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_sasiento_tmp ',
            @w_error   = 190001
            if @w_debug = 'S' print @w_mensaje
            close cursor_perfil
            deallocate cursor_perfil
            goto ERROR1
         end
        
         select @w_tot_debito     = @w_tot_debito + @w_debito
         select @w_tot_debito_me  = @w_tot_debito_me + @w_debito_me
         select @w_tot_credito    = @w_tot_credito + @w_credito
         select @w_tot_credito_me = @w_tot_credito_me + @w_credito_me

      end
      fetch cursor_perfil into
      @w_dp_cuenta,  @w_dp_debcred,   @w_dp_constante,
      @w_ar_destino, @w_dtr_codvalor, @w_dtr_valor,
      @w_clase,@w_calificacion
 
   end
   close cursor_perfil 
   deallocate cursor_perfil 

   -- DETERMIAR POSICION DEL COMPROBANTE 
   select @w_posicion = 'N'
   
   if abs(@w_tot_debito - @w_tot_credito) >= 0.01 begin
      select 
      @w_mensaje = 'NO CUADRAN DEBITOS CON CREDITOS: D-> ' +  convert(varchar,isnull(@w_tot_debito,0))+ ' C-> ' + convert(varchar,isnull(@w_tot_credito,0)),
      @w_error   = 190001
      if @w_debug = 'S' print ' GENERAR COMPROBANTE Debito: ' + cast(isnull(@w_tot_debito,0)  as varchar)	+ ' Credito: ' + cast(isnull(@w_tot_credito,0) as varchar)
      goto ERROR1
   end


   -- GENERACION DEL COMPROBANTE 
   select @w_re_ofconta = re_ofconta
   from   cob_conta..cb_relofi
   where  re_filial  = @w_filial
   and    re_empresa = @w_filial
   and    re_ofadmin = convert(int,@w_of_origen)

   select @w_descripcion =  convert(varchar(5),@w_dtr_codvalor) + '-' + @w_descripcion

   if @w_tot_debito >= 0.01 or @w_tot_credito >= 0.01 begin
   
      if @@trancount = 0 begin
         begin tran 
         select @w_commit = 'S'
      end      
      
      if @w_debug = 'S' print '   Generando comprobante... of: ' + cast(@w_re_ofconta as varchar)

      select @w_tran_modulo = convert(varchar(6),@w_secuencial)+'-'+convert(varchar(20),@w_codigo_externo)

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
      19,                @w_comprobante,   1,
      @w_fecha_con,      @w_re_ofconta,    @w_area_custodia,
      @s_user,           @w_descripcion,   getdate(),     
      @w_perfil,         @w_asiento,       @w_tot_debito,
      @w_tot_credito,    @w_tot_debito_me, @w_tot_credito_me,
      19,                'N',	             'I',
      'N',               null,             null,
      'sa',              @w_secuencial,   'N')
      
      if @@error <> 0 begin
         select 
         @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_scomprobante_tmp ', 
         @w_error   = 710001
         if @w_debug = 'S' print @w_mensaje
         goto ERROR1
      end

      update cu_transaccion
      set tr_estado = 'C'
      where tr_estado = 'I'
      and   tr_codigo_externo = @w_codigo_externo
      and  tr_secuencial = @w_secuencial
         
      select
      @w_error    = @@error,
      @w_rowcount = @@rowcount

      if @w_error <> 0 begin
         select @w_mensaje = ' ERR AL MARCAR TABLA DE TRANSACCION BANCAMIA ' 
         select @w_error = 190001
         if @w_debug = 'S' print @w_mensaje
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
      
   end else begin
   
      select 
      @w_comprobante = -2, -- sin asientos
      @w_error       = 199999,
      @w_mensaje = 'COMPROBANTE SIN ASIENTOS'
      if @w_debug = 'S' print @w_mensaje
      goto ERROR1     
   end

   ERROR1:
   if @w_commit = 'S' begin
      rollback tran
      select @w_commit = 'N'
   end      

   select @w_tran_modulo = convert(varchar(6),@w_secuencial)+'-'+convert(varchar(20),@w_codigo_externo)
   
   if @w_mensaje is null
      select @w_mensaje = 'Error Garantia fuera de perfil'

   /* BORRADO DE ERRORES */
   exec @w_return = cob_interfase..sp_errorcconta
   @t_trn         = 60011,
   @i_operacion   = 'I',
   @i_producto    = 19,
   @i_empresa     = @w_filial,
   @i_fecha       = @w_fecha,
   @i_mensaje     = @w_mensaje,
   @i_fecha_conta = @w_fecha_proceso,
   @i_asiento     = 0,
   @i_tran_modulo = @w_tran_modulo,
   @i_numerror    = @w_error,
   @i_perfil      = @w_perfil,
   @i_oficina     = @w_of_destino

   if @w_error_comprob <> '' begin 
      begin tran
      insert into cob_custodia..cu_errorlog (
              er_fecha_proc,     er_usuario,    er_tran, 
              er_garantia,       er_descripcion)
      values (@w_fecha,          @w_usuario,    @w_secuencial, 
              @w_codigo_externo, @w_error_comprob)
      commit tran
      select @w_error_comprob = ''
   end 

   if @w_error_asiento <> '' begin 
      begin tran
      insert into cob_custodia..cu_errorlog 
             (er_fecha_proc,     er_usuario,      er_tran,       
              er_garantia,       er_descripcion)
      values (@w_fecha,          @w_usuario,      @w_secuencial, 
              @w_codigo_externo, @w_error_asiento)
      commit tran
      select @w_error_asiento = ''
   end 
   
   if @w_debug = 'S' print '            ERROR1 --> ' + @w_mensaje

   SIGUIENTE:
   
   fetch cursor_tran into
   @w_secuencial,     @w_of_origen,    @w_of_destino, @w_tipo,
   @w_clase_custodia,      @w_tr_tran,      @w_moneda,     @w_codigo_externo, 
   @w_cliente,        @w_tipo_gar,     @w_estado_gar, @w_usuario,
   @w_garan_empleado, @w_descripcion_a, @w_fecha_con
end --end while cursor transacciones

close cursor_tran
deallocate cursor_tran

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
@i_fecha       = @w_fecha_con,
@i_producto    = 7,
@i_tran_modulo = @w_secuencial, --@w_tran_cur,
@i_asiento     = 0,
@i_fecha_conta = @w_fecha_proceso,
@i_numerror    = @w_error,
@i_mensaje     = @w_mensaje,
@i_perfil      = @w_perfil,
@i_oficina     = @w_re_ofconta

ERROR:
exec cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num = @w_error
return 1

go