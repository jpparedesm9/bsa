/************************************************************************/
/*  Archivo:            conta_prv_oper.sp                               */
/*  Stored procedure:   sp_caconta_prv_oper                             */
/*  Base de datos:      cob_cartera                                     */
/*  Producto:           Cartera                                         */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "Cobiscorp".                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/  
/*                              PROPOSITO                               */
/************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_caconta_prv_oper')
	drop proc sp_caconta_prv_oper
go

create proc sp_caconta_prv_oper
   @s_user              login         = 'automatico',
   @i_debug             char(1)       = 'N',
   @i_oper              int 
 
as declare
   @w_error          	int,
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
   @w_sp_name        	descripcion,
   @w_perfil            varchar(10),
   @w_op_oficina        int,
   @w_op_moneda         int,
   @w_toperacion        varchar(10),
   @w_reverso           char(1),
   @w_sector            varchar(10),
   @w_dp_cuenta         varchar(40),
   @w_parametro         varchar(24),
   @w_dp_debcred        char(1),
   @w_debito            money,
   @w_credito           money,
   @w_debito_me         money,
   @w_credito_me        money,
   @w_estado_prod       char(1),
   @w_cod_producto      tinyint,
   @w_re_area           int,
   @w_gar_admisible     varchar(1),
   @w_calificacion      varchar(1),
   @w_clase_cart        varchar(1),
   @w_op_estado         int,
   @w_ente              int,
   @w_banco             varchar(24),
   @w_con_iva           varchar(1),
   @w_valor_base        money,
   @w_maxfecha_iva      datetime,
   @w_operacionca       int,
   @w_clave             varchar(40),
   @w_stored            cuenta,
   @w_dp_area           varchar(10),
   @w_factor            int,
   @w_comprobante_base  int,
   @w_oficina_procesar  int,
   @w_fecha_procesar    datetime,
   @w_iva               catalogo,
   @w_commit            char(1),
   @w_tasa_iva          float,
   @w_fecha             datetime,
   @w_entidad_convenio  varchar(1),
   @w_bancamia          varchar(24)
   
/* VARIABLES DE TRABAJO */
select
@w_sp_name          = 'conta_prv_oper.sp',
@w_mensaje          = '',
@w_estado_prod      = '',
@w_cod_producto     = 7, 
@w_valor_base       = 0,
@w_oficina_procesar = 0,
@w_commit           = 'N'

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/* DETERMINAR CODIGO DE BANCAMIA PARA EMPLEADOS */
select @w_bancamia  = convert(varchar(24),pa_int)
from cobis..cl_parametro
where pa_nemonico = 'CCBA'
and   pa_producto = 'CTE'

exec cob_ccontable..sp_errorcconta
@t_trn         = 60025,
@i_operacion   = 'D',
@i_empresa     = 1,
@i_fecha       = @w_fecha,
@i_producto    = 7

if @i_debug = 'S'  print '--> sp_caconta_prv_oper.Inicio Contabilidad...'

-- Crear Tabla de Manejo de Errores
create table #errores
(
er_operacion   int null,
er_banco       cuenta null,
er_error       int null,
er_descripcion varchar(255) null
)

--drop table #transaccion_prv1
create table #transaccion_prv1(
tp_operacion     int       null, 
tp_fecha_mov     datetime  null,
tp_concepto      catalogo  null, 
tp_codvalor      int       null,
tp_monto         money     null
)

-- Transacciones a Procesar
create table #transaccion_prv(
tp_perfil        catalogo  null,
tp_operacion     int       null,   
tp_secuencial    int       null,
tp_fecha_mov     datetime  null,   
tp_tran          catalogo  null,
tp_banco         cuenta    null,
tp_sector        int       null,
tp_gar_admisible char(1)   null,
tp_calificacion  char(1)   null,
tp_clase         char(1)   null,
tp_cliente       int       null,
tp_oficina       int       null,
tp_toperacion    catalogo  null,
tp_concepto      catalogo  null,
tp_codvalor      int       null,
tp_moneda        tinyint   null,
tp_monto         money     null,
tp_org_fondos    catalogo  null,
tp_ent_convenio  varchar(1) null
)

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
   @w_mensaje = ' PROC-INDIVIDUAL ERR NO DEFINIDA AREA DE CARTERA ' ,
   @w_error   = 708176
   goto ERRORFIN
end

if @i_debug = 'S'  print '--> sp_caconta_prv_oper. Encontro Corte...'

/* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
select @w_estado_prod = pr_estado
from cob_conta..cb_producto with (nolock)
where pr_empresa  = 1
and   pr_producto = @w_cod_producto

/* VALIDA EL PRODUCTO EN CONTABILIDAD */
if @w_estado_prod not in ('V','E') begin
   select 
   @w_error   = 601018,
   @w_mensaje = '  PROC-INDIVIDUAL  PRODUCTO NO VIGENTE EN CONTA ' 
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
   @w_mensaje = ' PROC-INDIVIDUAL  ERROR NO EXISTEN PERIODOS DE CORTE ABIERTOS ' 
   goto ERRORFIN
end

if @i_debug = 'S' begin
   print '--> sp_caconta_prv_oper. Fecha Conta ' + cast(@w_fecha_mov as varchar)
   print '--> sp_caconta_prv_oper. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
end

/* INSERTAR EN TEMPORALES TOTALES A CONTABILIZAR */
while @w_fecha_mov <= @w_fecha_hasta begin

   /* TRANSACCIONES PRV A CONTABILIZAR */
   
   insert into #transaccion_prv1
   select
   tp_operacion     = tp_operacion,   
   tp_fecha_mov     = @w_fecha_mov,   
   tp_concepto      = tp_concepto,
   tp_codvalor      = tp_codvalor,
   tp_monto         = sum(tp_monto)
   from ca_transaccion_prv with (index = idx2)
   where  tp_estado    = 'ING'
   and    tp_fecha_mov = @w_fecha_mov
   and    tp_operacion = @i_oper
   group by tp_operacion, tp_concepto, tp_codvalor

   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL   ERR AL INSERTAR TRANSACCION CABECERA 1 ' ,
      @w_error   = 710001
      goto ERRORFIN
   end

   /* DETERMINAR PERFIL CONTABLE A UTILIZAR */
   
   select @w_fecha_mov = dateadd(dd,1,@w_fecha_mov)

end

create index idx2 on #transaccion_prv1 (tp_operacion)

insert into #transaccion_prv
select
tp_perfil        = convert(varchar(10),'NO EXISTE'),
tp_operacion     = tp_operacion,   
tp_secuencial    = datepart(yy,tp_fecha_mov) * 10000 + datepart(mm,tp_fecha_mov) * 100 + datepart(dd,tp_fecha_mov),  
tp_fecha_mov     = tp_fecha_mov,   
tp_tran          = 'PRV',
tp_banco         = op_banco,
tp_sector        = op_sector,
tp_gar_admisible = case when isnull(op_gar_admisible,'N') = 'S' then 'I' else 'O' end,
tp_calificacion  = isnull(ltrim(rtrim(op_calificacion)), 'A'),
tp_clase         = substring(op_clase,1,1),
tp_cliente       = op_cliente,
tp_oficina       = op_oficina,
tp_toperacion    = op_toperacion,
tp_concepto      = tp_concepto,
tp_codvalor      = tp_codvalor,
tp_moneda        = op_moneda,
tp_monto         = tp_monto,
tp_org_fondos    = dt_categoria,
tp_ent_convenio  = case when dt_entidad_convenio = @w_bancamia then '1' else '0' end
from #transaccion_prv1 with (index = idx2), ca_operacion, ca_default_toperacion with (nolock)
where  tp_operacion   = op_operacion
and    op_toperacion  = dt_toperacion 

if @@error <> 0 begin
   select 
   @w_mensaje = '  PROC-INDIVIDUAL  ERR AL INSERTAR TRANSACCION CABECERA 1 ' ,
   @w_error   = 710001
   goto ERRORFIN
end

create index idx1 on #transaccion_prv(tp_oficina, tp_fecha_mov, tp_perfil)

update #transaccion_prv set
tp_perfil = to_perfil
from ca_trn_oper
where tp_toperacion = to_toperacion
and   to_tipo_trn   = 'PRV'   

if @@error <> 0 begin
  select 
  @w_mensaje = ' PROC-INDIVIDUAL  ERR AL DETERMINAR PERFIL CONTABLE A UTILIZAR ' ,
  @w_error   = 710002
  goto ERRORFIN
end


select distinct oficina = tp_oficina, fecha = tp_fecha_mov, perfil = tp_perfil, estado = 'N'
into #oficinas 
from #transaccion_prv

while 1 = 1 begin -- Proceso por Oficinas
     
   set rowcount 1  

   select 
   @w_oficina_procesar = oficina,
   @w_fecha_procesar   = fecha,
   @w_perfil           = perfil
   from  #oficinas 

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end  
   
   set rowcount 0   
   
   delete #oficinas 
   where oficina = @w_oficina_procesar
   and   fecha   = @w_fecha_procesar  
   and   perfil  = @w_perfil 

   /* RESERVAR UN RANGO DE COMPROBANTES */
   exec @w_error = cob_conta..sp_cseqcomp
   @i_tabla     = 'cb_scomprobante', 
   @i_empresa   = 1,
   @i_fecha     = @w_fecha_procesar,
   @i_modulo    = 7,
   @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
   @o_siguiente = @w_comprobante out
      
   if @w_error <> 0 begin
      select 
      @w_mensaje = '  PROC-INDIVIDUAL ERROR AL GENERAR NUMERO COMPROBANTE ' 
      goto ERROR1
   end
   
   select 
   @w_debito  = 0,
   @w_credito = 0

   -- Detalles por operacion
   select
   de_banco        = tp_banco,
   de_toperacion   = tp_toperacion,
   de_operacion    = tp_operacion,
   de_concepto     = tp_concepto,         
   de_codvalor     = tp_codvalor,            
   de_moneda       = tp_moneda,  
   de_monto        = tp_monto,
   de_ref_iva      = convert(varchar(10),'N/A'),
   de_maxfec_iva   = convert(datetime, '01/01/1900'),
   de_porc_iva     = convert(float,0.0),
   de_valor_base   = convert(money,0),
   de_cuenta       = dp_cuenta,               
   de_debcred      = dp_debcred,           
   de_constante    = dp_constante,        
   de_origen_dest  = dp_origen_dest,           
   de_area         = convert(smallint, -1),
   de_tipo_area    = convert(varchar(10), dp_area),
   de_oficina      = tp_oficina,
   de_clave        = convert(varchar(40),''),
   de_cuenta_final = convert(varchar(40),''),
   de_debito       = convert(money,0),
   de_credito      = convert(money,0),
   de_con_iva      = 'N',
   de_fecha_mov    = tp_fecha_mov,
   de_sector       = tp_sector,
   de_gar_admisible= tp_gar_admisible,
   de_calificacion = tp_calificacion, 
   de_clase        = tp_clase,
   de_cliente      = tp_cliente,
   identity(int, 1,1) as de_asiento,
   de_org_fondos   = tp_org_fondos,
   de_ent_convenio = tp_ent_convenio
   into #detalles
   from #transaccion_prv with (index = idx1) , cob_conta..cb_det_perfil
   where dp_empresa          = 1
   and   dp_producto         = @w_cod_producto  -- cartera
   and   dp_perfil           = @w_perfil
   and   dp_codval           = tp_codvalor 
   and   tp_oficina          = @w_oficina_procesar
   and   tp_fecha_mov        = @w_fecha_procesar
   and   tp_perfil           = @w_perfil
   and   abs(tp_monto)      >= 0.01
   
   if @@error <>  0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL INSERTAR EN TABLA DE DETALLES ' 
      goto ERROR1
   end     
   
   create index idx1 on #detalles(de_oficina, de_fecha_mov)

   -- Validacion Rubros IVA
   update #detalles set
   de_ref_iva = ru_referencial
   from  ca_rubro with (nolock)
   where ru_concepto   = de_concepto
   and   ru_toperacion = de_toperacion
   and   ru_concepto_asociado is not null
                         
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (rubro iva) ',
      @w_error   = 710001
      goto ERROR1
   end

   select de_ref_iva, estado = 'N'
   into #iva
   from #detalles
   where de_ref_iva  <> 'N/A'
   group by de_ref_iva

   while 1 = 1 begin

      set rowcount 1

      select @w_iva = de_ref_iva
  from #iva
      where estado = 'N'

      if @@rowcount = 0 begin
         set rowcount 0
         break
      end

      set rowcount 0

      select @w_maxfecha_iva = max(vr_fecha_vig)
      from   ca_valor_referencial with (nolock)
      where  vr_tipo       = @w_iva
      and    vr_fecha_vig <= @w_fecha_procesar

      select @w_tasa_iva  = vr_valor
      from   ca_valor_referencial with (nolock)
      where  vr_tipo      = @w_iva
      and    vr_fecha_vig = @w_maxfecha_iva

      update #detalles set 
      de_maxfec_iva = @w_maxfecha_iva,
      de_con_iva    = 'S',
      de_porc_iva   = @w_tasa_iva,
      de_valor_base = de_monto/(@w_tasa_iva*0.01)
      where de_ref_iva  = @w_iva

      if @@error <> 0 begin
         select 
         @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (iva) ',
         @w_error   = 710001
         goto ERROR1
      end

      update #iva
      set estado = 'S'
      where de_ref_iva = @w_iva

      if @@error <> 0 begin
         select 
         @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (estado) ',
         @w_error   = 710001
         goto ERROR1
      end
   end
   
   -- Reversas de Negativos, Invertor el signo del asiento
   update #detalles set
   de_debcred = case when de_debcred = '2' then '1' else '2' end,
   de_monto   = de_monto * -1
   where de_monto < 0
   
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (reversas neg) ',
      @w_error   = 710001
      goto ERROR1
   end

   -- Tipo Area  
   update #detalles
   set de_area = ta_area
   from cob_conta..cb_tipo_area with (nolock)
   where ta_tiparea  = de_tipo_area
   and   ta_empresa  = 1
   and   ta_producto = 7


   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (tipo area) ',
      @w_error   = 710001
      goto ERROR1
   end
   
   -- Define clave
   update #detalles
   set de_clave = case when pa_stored = 'sp_ca01_pf' then de_calificacion +'.'+ de_gar_admisible +'.'+ de_clase +'.'+ convert(varchar(1),de_moneda) +'.'+ de_ent_convenio
                       when pa_stored = 'sp_ca02_pf' then de_calificacion +'.'+ de_clase +'.'+convert(varchar(1),de_moneda) +'.'+ de_ent_convenio 
                       when pa_stored = 'sp_ca03_pf' then de_clase +'.'+convert(varchar(1),de_moneda)
                       when pa_stored = 'sp_ca04_pf' then convert(varchar(1),de_moneda)
                       when pa_stored = 'sp_ca05_pf' then de_toperacion
                       when pa_stored = 'sp_ca06_pf' then de_cuenta 
                       when pa_stored = 'sp_ca07_pf' then de_calificacion +'.'+ de_gar_admisible +'.'+ de_clase +'.'+convert(varchar(1),de_moneda) +'.'+ de_org_fondos  +'.'+ de_ent_convenio
                       when pa_stored = 'sp_ca08_pf' then de_clase +'.'+convert(varchar(1),de_moneda) +'.'+ de_org_fondos  +'.'+ de_ent_convenio                       
                       else '' end
   from cob_conta..cb_parametro with (nolock)
   where pa_empresa   = 1
   and   pa_parametro = de_cuenta
  
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (clave) ',
      @w_error   = 710001
      goto ERROR1
   end

   -- Define Cuenta Final
   update #detalles
   set de_cuenta_final = isnull(rtrim(ltrim(re_substring)), '')
   from cob_conta..cb_relparam with (nolock)
   where re_empresa             = 1
   and   re_parametro           = de_cuenta
   and   ltrim(rtrim(re_clave)) = de_clave
   
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (cuenta final) ',
      @w_error   = 710001
      goto ERROR1
   end

   -- Oficina Contable
   select @w_re_ofconta = re_ofconta
   from   cob_conta..cb_relofi with (nolock)
   where  re_filial  = 1
   and    re_empresa = 1
   and    re_ofadmin = @w_oficina_procesar

   if @@rowcount = 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL Encontrar Oficina Contable ', 
      @w_error   = 710001
      goto ERROR1
   end
   
   /** FCP - Utiliza la oficina destino segun la parametrizacion del detalle de perfil **/
   -- Oficina Centralizada
   update #detalles set 
   de_oficina = re_ofconta
   from   cob_conta..cb_relofi with (nolock), cob_conta..cb_tipo_area with (nolock)
   where  re_filial      = 1
   and    re_empresa     = 1    
   and    ta_empresa     = 1
   and    re_ofadmin     = ta_ofi_central   
   and    ta_producto    = @w_cod_producto
   and    ta_tiparea     = de_tipo_area
   and    de_origen_dest = 'C'

   if @@error != 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL Actualizar Oficina Centralizada ', 
      @w_error   = 710001
      goto ERROR1
   end

   -- Oficina Destino cuando no es Centralizada
   update #detalles set 
   de_oficina = @w_re_ofconta
   where de_origen_dest != 'C'

   if @@error != 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL Actualizar Oficina Destino', 
      @w_error   = 710001
      goto ERROR1
   end
   -- FIN FCP   
   
   /* Valores Debito y Credito Moneda Nacional */
   
   update #detalles set 
   de_debito   = de_monto*(2-de_debcred),
   de_credito  = de_monto*(de_debcred-1)
       
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR UPDATE #detalles (debito) ',
      @w_error   = 710001
      goto ERROR1
   end

   select 
   @w_debito     = isnull(sum(de_debito),0),  
   @w_credito    = isnull(sum(de_credito),0), 
   @w_valor_base = isnull(sum(de_monto),0),
   @w_asiento    = count(1)
   from #detalles
   
   /* CONCEPTO DEL COMPROBANTE */
   select @w_descripcion = 
   'Trn:' + 'PRV-S-RRB' + ' ' + 
   'Vlr:' + convert(varchar,@w_valor_base)
   
   if @@trancount = 0 begin
      select @w_commit = 'S'
      BEGIN TRAN
   end
   
   /* INGRESA COMPROBANTE */
   
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
   @w_fecha_procesar, @w_re_ofconta,    @w_ar_origen,
   @s_user,           @w_descripcion,   convert(char(10),getdate(),101),     
   @w_perfil,         @w_asiento,       @w_debito,
   @w_credito,        @w_debito,        @w_credito,
   @w_cod_producto,   'N',	             'I',
   'N',               null,             null,
   'sa',              -999,             'N')
   
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL INSERTAR REGISTROS EN LA TABLA ct_scomprobante_tmp ', 
      @w_error   = 710001
      goto ERROR1
   end   
  
   /* INGRESA ASIENTO */
  
   insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock) (                                                                                                                                              
   sa_producto,        sa_fecha_tran,      sa_comprobante,
   sa_empresa,         sa_asiento,         sa_cuenta,
   sa_oficina_dest,    sa_area_dest,       sa_credito,
   sa_debito,          sa_credito_me,      sa_concepto,        
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
   select
   @w_cod_producto,    @w_fecha_procesar,  @w_comprobante,
   1,                  de_asiento,         de_cuenta_final,
 --@w_re_ofconta,      de_tipo_area,       de_credito, -- FCP comento
   de_oficina,         de_area,       de_credito, -- FCP Inserto
   de_debito,          0,                  'PRV. Op:'+ isnull(de_banco, '') + ' Co:' + de_concepto+' Cv:' + convert(varchar,de_codvalor),              
   0,                  1,                  'N',
   'A',                0,                  0,
   de_cliente,         null,               de_valor_base,
   null,               de_con_iva,         de_monto,
   null,               null,               null,
   null,               null,               null,
   null,               null,               de_banco,
   'N',                null,               null,
   'S',                de_debcred,         null,
   null,               null,               null,
   null,               'N' 
   from #detalles   
   if @@error <> 0 begin
      select 
      @w_mensaje = ' PROC-INDIVIDUAL  ERROR AL INSERTAR REGISTROS EN LA TABLA ct_sasiento_tmp ',
      @w_error   = 710001
      goto ERROR1
   end
   
   /* Marcar Contabilizado */
   
   update ca_transaccion_prv with (rowlock)set 
   tp_comprobante  =  @w_comprobante,
   tp_fecha_cont   =  @w_fecha_procesar,
   tp_estado       =  'CON'
   from #transaccion_prv a , ca_transaccion_prv b with (index = idx1)
   where a.tp_oficina    = @w_oficina_procesar
   and   a.tp_fecha_mov  = @w_fecha_procesar
   and   a.tp_perfil     = @w_perfil
   and   a.tp_operacion  = b.tp_operacion
   and   a.tp_fecha_mov  = b.tp_fecha_mov
   and   a.tp_codvalor   = b.tp_codvalor
   
   if @@error <> 0 begin
      select @w_mensaje = ' PROC-INDIVIDUAL   ERR AL MARCAR TABLA DE TRANSACCION BANCAMIA ' 
      select @w_error = 700002
      goto ERROR1
   end  
   
   if @w_commit = 'S' begin
      COMMIT TRAN                                       
      select @w_commit = 'N'
   end
   
   goto SIGUIENTE

   ERROR1:

   exec cob_ccontable..sp_errorcconta
   @t_trn         = 60011,
   @i_operacion   = 'I',
   @i_empresa     = 1,
   @i_fecha       = @w_fecha_proceso,
   @i_producto    = 7,
   @i_tran_modulo = 0, --@w_tran_cur,
   @i_asiento     = 0,
   @i_fecha_conta = @w_fecha_mov,
   @i_numerror    = @w_error,
   @i_mensaje     = @w_mensaje,
   @i_perfil      = @w_perfil,
   @i_oficina     = @w_re_ofconta

   exec sp_errorlog 
   @i_fecha        = @w_fecha,
   @i_error        = @w_error, 
   @i_usuario      = @s_user, 
   @i_tran         = 7999,
   @i_tran_name    = @w_sp_name,
   @i_cuenta       = 'ERROR1: PRV',
   @i_descripcion  = @w_mensaje,
   @i_rollback     = 'S'

   SIGUIENTE:

   drop table  #detalles
   drop table  #iva

end

return 0

ERRORFIN:
if @w_commit = 'S' begin
   ROLLBACK TRAN
   select @w_commit = 'N'
end

exec cob_ccontable..sp_errorcconta
@t_trn         = 60011,
@i_operacion   = 'I',
@i_empresa     = 1,
@i_fecha       = @w_fecha_proceso,
@i_producto    = 7,
@i_tran_modulo = 0, --@w_tran_cur,
@i_asiento     = 0,
@i_fecha_conta = @w_fecha_mov,
@i_numerror    = @w_error,
@i_mensaje     = @w_mensaje,
@i_perfil      = @w_perfil,
@i_oficina     = @w_re_ofconta


exec sp_errorlog 
@i_fecha       = @w_fecha,
@i_error       = @w_error, 
@i_usuario     = @s_user, 
@i_tran        = 7999,
@i_tran_name   = @w_sp_name,
@i_cuenta      = 'ERRORFIN: PRV',
@i_descripcion = @w_mensaje,
@i_rollback    = 'S'

return 0 
go

