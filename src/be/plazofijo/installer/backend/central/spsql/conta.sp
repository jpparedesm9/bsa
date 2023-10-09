/*************************************************************************/
/*   Stored procedure:     sp_conta                                     */
/*   Base de datos:        cob_pfijo                                    */
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
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_conta')
   drop proc sp_conta
go

create procedure sp_conta(
@s_user              login         = 'sp_conta',
@i_debug             char(1)       = 'N'
)
with encryption

as

declare
@w_error             int,
@w_mon_nac           int,
@w_chqcom            catalogo,
@w_gmf               catalogo,
@w_msg               descripcion,
@w_tipo_trn          catalogo,
@w_en_tente          catalogo,
@w_op_plazo_cont     catalogo,
@w_op_num_dias       int,
@w_reversa           char(1),
@w_secuencia         int,
@w_op_toperacion     catalogo,
@w_td_aux            varchar(30),
@w_tente             catalogo,
@w_tplazo            catalogo,
@w_con_rete          char(1),
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
@w_ofi_usu           int,
@w_ofi_oper          int,
@w_fecha_val         datetime,
@w_tran_cur          varchar(10),
@w_op_moneda         int,
@w_reverso           char(1),
@w_monto_cur         money,
@w_td_moneda         int,
@w_td_monto          money,
@w_td_monto_mn       money,
@w_td_concepto       varchar(20),
@w_td_codval         int,
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
@w_re_area           int,
@w_op_estado         int,
@w_op_ente           int,
@w_ente              int,
@w_banco             varchar(24),
@w_valor_base        money,
@w_afecta            varchar(1),
@w_valor_ref         varchar(5),
@w_cont              int,
@w_operacionpf       int,
@w_cheque            int,
@w_marcados          int,
@w_clave             varchar(40),
@w_stored            cuenta,
@w_dp_area           varchar(10),
@w_oficina_aux       smallint,
@w_factor            int,
@w_comprobante_base  int,
@w_tasa_ret          float,
@w_tasa_gmf          float,
@w_retfuente         catalogo,
@w_valret            money,
@w_orden_impresion   int,
@w_ec_cuenta         cuenta,
@w_ofi_central       smallint,
@w_instrumento       int,
@w_serie_ini         varchar(100),
@w_subtipo           int,
@w_cheque_str        varchar(50),
@w_plazo_ant         int, 
@w_plazo_aux         int,
@w_total             int,
@w_detalles          int,
@w_bloque            int,
@w_cuenta_banco      cuenta,
@w_cliente           int

/* VARIABLES DE TRABAJO */
select
@w_sp_name      = 'conta.sp',
@w_mensaje      = '',
@w_estado_prod  = '',
@w_cod_producto = 14,
@w_valor_base   = 0,
@w_ofi_central  = 0,
@w_total        = 0,
@w_detalles     = 0

/* DETERMINAR FECHA PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre with (nolock)
where  fc_producto = @w_cod_producto

--Desacople
exec @w_error = cob_interfase..sp_iccontable
     @i_operacion = 'D',
     @i_empresa   = 1,
     @i_fecha     = @w_fecha_proceso,
     @i_producto  = 14,
     @t_trn       = 60025   

if @w_error <> 0
   return @w_error
   
if @i_debug = 'S'  print '--> sp_conta. Encontro Corte...'


/* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */

select
@w_fecha_mov   = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from  cob_conta..cb_corte with (nolock)
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha_mov = '01/01/1900' begin
   select
   @w_error   = 601078,
   @w_mensaje = ' ERROR NO EXISTEN PERIODOS DE CORTE ABIERTOS '
   goto ERRORFIN
end

if @i_debug = 'S' begin
   print '--> sp_conta. Fecha Conta ' + cast(@w_fecha_mov as varchar)
   print '--> sp_conta. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
end

/* DETERMINAR EL CODIGO DEL RUBRO USADO PARA INTERFAZ PFI -S.BANCARIOS
PARA ORDENES DE IMPRESION DE CHEQUES COMERCIALES*/
select @w_chqcom = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'CHQCOM'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 14000, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL CHQCOM'
   goto ERRORFIN
end

select @w_gmf = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'GMF'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 14000, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL GMF'
   goto ERRORFIN
end

select @w_tasa_gmf = pa_float
from   cobis..cl_parametro
where  pa_nemonico  = 'IMDB'
and    pa_producto  = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 14000, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL IMDB'
   goto ERRORFIN
end

select @w_retfuente = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'RETFUE'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 14000, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL RETFUE'
   goto ERRORFIN
end


/* DETERMINAR LA MONEDA NACIONAL Y CANTIDAD DE DECIMALES */
select @w_mon_nac = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

/* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
select @w_estado_prod = pr_estado
from   cob_conta..cb_producto with (nolock)
where  pr_empresa  = 1
and    pr_producto = @w_cod_producto


if @i_debug = 'S'  print '--> sp_conta. Fecha Conta ' + cast(@w_fecha_mov as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_estado_prod' + cast(@w_estado_prod as varchar)


/* VALIDA EL PRODUCTO EN CONTABILIDAD */
if @w_estado_prod not in ('V','E') begin
   select
   @w_error   = 601018,
   @w_mensaje = ' PRODUCTO NO VIGENTE EN CONTA '
   goto ERRORFIN
end

/* CREAR TABLA DE TRABAJO PARA REGISTRAR LAS TRANSACCIONES A CONTABILIZAR */
create table #transacciones(
tr_operacion     int          not null,
tr_secuencial    int          not null,
tr_fecha_mov     datetime     not null,
tr_fecha_ref     datetime     not null,
tr_ofi_usu       int          not null,
tr_ofi_oper      int          not null,
tr_tran          int          not null,
tr_tipo_trn      varchar(10)  not null,
tr_reverso       char(1)      not null,
tr_secuencia     int          not null,
tr_procesado     char(1)      not null)

/* OBTENER NUMERO DE COMPROBANTE */
exec @w_error = cob_conta..sp_cseqcomp
@i_tabla     = 'cb_scomprobante',
@i_empresa   = 1,
@i_fecha     = @w_fecha_proceso,
@i_modulo    = @w_cod_producto,
@i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
@o_siguiente = @w_comprobante_base out

if @w_error <> 0 begin
   select
   @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE '
   goto ERROR1
end

if @i_debug = 'S'  print '--> sp_conta. @w_fecha_mov' + cast(@w_fecha_mov as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_cod_producto' + cast(@w_cod_producto as varchar)

if @i_debug = 'S' begin
   print '   @w_comprobante: ' + cast(@w_comprobante as varchar)
   print '   @w_perfil:      ' + @w_perfil
end


/* RESERVA COMPROBANTES PARA LA FECHA DE PROCESO */
select @w_bloque = 0
select @w_bloque = count(1) from pf_transaccion
where  tr_estado = 'ING'
and    tr_fecha_mov = @w_fecha_proceso

update cob_conta..cb_seqnos_comprobante with (rowlock) set
sc_actual           = sc_actual + (@w_bloque * 2)
where sc_empresa = 1
and   sc_fecha   = @w_fecha_proceso
and   sc_tabla   = 'cb_scomprobante'
and   sc_modulo  = @w_cod_producto

if @@error <> 0 begin
   select 
   @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
   goto ERRORFIN
end


/* INSERTAR EN TEMPORALES TOTALES A CONTABILIZAR */
while @w_fecha_mov <= @w_fecha_hasta begin

   if @i_debug = 'S'  print '--> sp_conta. @w_fecha_mov' + cast(@w_fecha_mov as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_fecha_hasta' + cast(@w_fecha_hasta as varchar)

   /* TRANSACCIONES A CONTABILIZAR */
   insert into #transacciones(
   tr_operacion,  tr_secuencial, tr_fecha_mov,  
   tr_fecha_ref,  tr_ofi_usu,    tr_ofi_oper,   
   tr_tran,       tr_tipo_trn,   tr_reverso,    
   tr_secuencia,  tr_procesado )
   select
   tr_operacion,    tr_secuencial,  tr_fecha_mov,
   tr_fecha_ref,    tr_ofi_usu,     tr_ofi_oper,
   tr_tran,         tr_tipo_trn,    tr_reverso,     
   isnull(tr_secuencia, -1), 'N'
   from   pf_transaccion
   where  tr_estado    = 'ING'
   and    tr_fecha_mov = @w_fecha_mov

   if @@error <> 0 begin
      select
      @w_mensaje = ' ERR AL INSERTAR TRANSACCION CABECERA 1 ', 
      @w_error   = 710001
      goto ERRORFIN
   end

   select @w_fecha_mov = dateadd(dd,1,@w_fecha_mov)
end
   
select
'op_operacion'     = op_operacion,
'op_num_banco'     = op_num_banco,
'op_ente'          = op_ente,
'op_moneda'        = op_moneda,
'op_toperacion'    = op_toperacion,
'op_num_dias '     = op_num_dias,
'en_tente'         = convert(varchar(10),' ')
into  #opera
from  #transacciones, pf_operacion with (nolock)
where op_operacion = tr_operacion
and tr_procesado   = 'N'

create index pf_operacion_C_Key
on #opera (op_operacion)

update #opera
set    en_tente = (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end)
from   cobis..cl_ente, #opera
where  en_ente = op_ente
   
/* CREAR TABLA DE TRABAJO TEMPORAL PARA MANEJAR LOS DETALLES DE LA TRANSACCION A CONTABILIZAR */
create table #detalles(
td_concepto   varchar(10)    null,
td_codvalor   int            null,
td_moneda     int            null,
td_aux        varchar(20)    null,
td_monto      money          null)


/* LAZO RECORRER CADA UNA DE LAS TRANSACCIONES A CONTABILIZAR */
while 1=1 begin

   set rowcount 1

   select
   @w_operacionpf    = tr_operacion,
   @w_secuencial     = tr_secuencial,
   @w_fecha_mov      = tr_fecha_mov,
   @w_fecha_val      = tr_fecha_ref,
   @w_ofi_usu        = tr_ofi_usu,
   @w_ofi_oper       = tr_ofi_oper,
   @w_tran_cur       = tr_tran,
   @w_tipo_trn       = tr_tipo_trn,
   @w_reverso        = tr_reverso,
   @w_secuencia      = tr_secuencia
   from  #transacciones with (nolock)
  
  
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   set rowcount 0


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
   @w_comprobante    = 0


   /* LEER DATOS DE LA OPERACION */
   select
   @w_banco         = op_num_banco,
   @w_op_ente       = op_ente,
   @w_op_moneda     = op_moneda,
   @w_op_toperacion = op_toperacion,
   @w_op_num_dias   = op_num_dias,
   @w_en_tente      = en_tente /*TIPO DE ENTE: OFICIAL O PARTICULAR */
   from  #opera
   where op_operacion = @w_operacionpf

   if @i_debug = 'S'  print '--> sp_conta. @w_banco' + cast(@w_banco as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_op_ente' + cast(@w_op_ente as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_op_moneda' + cast(@w_op_moneda as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_op_toperacion' + cast(@w_op_toperacion as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_op_num_dias' + cast(@w_op_num_dias as varchar)

   /* DETERMINAR EL PLAZO CONTABLE DE LA OPERACION */
   select @w_op_plazo_cont = pc_plazo_cont
   from   pf_plazo_contable
   where  @w_op_num_dias between pc_plazo_min and pc_plazo_max

   if @@rowcount = 0 begin
      select
      @w_error = 141054,
      @w_descripcion =    'Ban:' + ltrim(rtrim(@w_banco))             + ' ' +
                          'Sec:' + convert(varchar,@w_secuencial)     + ' ' +
                          'Trn:' + convert(varchar,@w_tran_cur)       + ' ' +
                          'TTr:' + ltrim(rtrim(@w_tipo_trn))          + ' ' +
                          'Rev:' + convert(char(1),@w_reverso)        + ' ' +
                          'TOp:' + ltrim(rtrim(@w_op_toperacion))     + ' ' +
                          'FVa:' + convert(varchar(10),@w_fecha_val,103),
      @w_mensaje = 'NO EXISTE PLAZO CONTABLE PARA PLAZO '+convert(varchar, @w_op_num_dias)
      goto ERROR1
   end

   if @i_debug = 'S'  print '--> sp_conta. @w_op_plazo_cont' + cast(@w_op_plazo_cont as varchar)

   /* SELECCION DEL AREA CONTABLE */
   select @w_ar_origen = td_area_contable
   from   pf_tipo_deposito with (nolock)
   where  td_mnemonico = @w_op_toperacion
   
   if @@rowcount = 0 begin
      select
      @w_mensaje = ' ERR NO DEFINIDO TIPO DE DEPOSITO: ' + @w_op_toperacion,
      @w_error   = 708176
      goto ERROR1
   end

   if @i_debug = 'S'  print '--> sp_conta. @w_ar_origen' + cast(@w_ar_origen as varchar)


   /* CONCEPTO DEL COMPROBANTE */
   select @w_descripcion =
   'Ban:' + ltrim(rtrim(@w_banco))             + ' ' +
   'Sec:' + convert(varchar,@w_secuencial)     + ' ' +
   'Trn:' + convert(varchar,@w_tran_cur)       + ' ' +
   'TTr:' + ltrim(rtrim(@w_tipo_trn))          + ' ' +
   'Rev:' + convert(char(1),@w_reverso)        + ' ' +
   'TOp:' + ltrim(rtrim(@w_op_toperacion))     + ' ' +
   'FVa:' + convert(varchar(10),@w_fecha_val,103)

   if @i_debug = 'S' begin
      print ''
      print 'CONTABILIZANDO... ' + @w_descripcion
   end

   if @i_debug = 'S'  print '--> sp_conta. @w_descripcion' + cast(@w_descripcion as varchar)


   /* CONTABILIDAD ELIMINADA... MARCAR REGISTRO COMO CONTABILIZADO */
   if @w_estado_prod = 'E' begin
      select @w_comprobante = -1  -- Contabilidad eliminada
      goto MARCAR
   end

   truncate table #detalles


   if @i_debug = 'S'  print '--> sp_conta. @w_secuencial' + cast(@w_secuencial as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_operacionpf' + cast(@w_operacionpf as varchar)

   insert into #detalles
   select
   td_concepto,        td_codvalor,            td_moneda,
   td_aux,             sum(td_monto)
   from  pf_transaccion_det with (nolock)
   where td_secuencial = @w_secuencial
   and   td_operacion  = @w_operacionpf
   group by  td_concepto, td_codvalor, td_moneda, td_aux
   having abs(sum(td_monto)) > 0.01

   if @@rowcount = 0 goto MARCAR

   /* DETERMINAR PERFIL CONTABLE */
   select @w_perfil = ltrim(rtrim(tp_perfil))
   from   pf_tranperfil with (nolock)
   where  tp_tran       = @w_tran_cur
   and    tp_estado     = case @w_reverso when 'S' then 'R' else 'N' end

   if @@rowcount = 0 begin
      select
      @w_error   = 701148,
      @w_mensaje = ' ERROR NO EXISTE TIPO DE TRANSACCION PARA: ' + isnull(@w_tran_cur,'') 
      goto ERROR1
   end

   if @i_debug = 'S'  print '--> sp_conta. @w_tran_cur' + cast(@w_tran_cur as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_perfil' + cast(@w_perfil as varchar)
   if @i_debug = 'S'  print '--> sp_conta. @w_reverso' + cast(@w_reverso as varchar)


   if not exists(select 1 from cob_conta..cb_perfil with (nolock)
                 where pe_empresa  = 1
                   and pe_producto = @w_cod_producto
                   and pe_perfil   = @w_perfil) 
   begin
      select @w_error   = 701148,
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
      @i_modulo    = @w_cod_producto,
      @i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
      @o_siguiente = @w_comprobante out
   
      if @w_error <> 0 begin
         select 
         @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE ' 
         goto ERROR1
      end
   end


   /** SI SE TRATA DE UNA REVERSA DE TRANSACCION */
   if @w_reversa = 'S'
      select @w_factor = -1
   else
      select @w_factor = 1
      
   select 
   @w_detalles = count (distinct td_codvalor)
   from #detalles

   select
   @w_total = count(distinct td_codvalor)
   from #detalles, cob_conta..cb_det_perfil with (nolock)
   where dp_empresa     = 1
   and   dp_producto    = @w_cod_producto
   and   dp_perfil      = @w_perfil
   and   dp_codval      = td_codvalor
   and   abs(td_monto)>= 0.1

   if (@w_total - @w_detalles) <> 0  begin
      print 'error en comprobante'
      goto SIGUIENTE
   end

   /** CURSOR PARA OBTENER LOS DETALLES DEL PERFIL RESPECTIVO **/
   declare cursor_perfil cursor for select
   td_concepto,        td_codvalor,             td_moneda,
   td_aux,             dp_cuenta,               dp_debcred,
   dp_constante,       dp_origen_dest,          dp_area,
   td_monto
   from #detalles, cob_conta..cb_det_perfil with (nolock)
   where dp_empresa     = 1
   and   dp_producto    = @w_cod_producto
   and   dp_perfil      = @w_perfil
   and   dp_codval      = td_codvalor
   and   abs(td_monto)>= 0.1

   open cursor_perfil

   fetch cursor_perfil into
   @w_td_concepto,     @w_td_codval,      @w_td_moneda,
   @w_td_aux,          @w_dp_cuenta,      @w_dp_debcred,
   @w_dp_constante,    @w_dp_origen_dest, @w_dp_area,
   @w_td_monto

   while @@fetch_status = 0 begin

      if @i_debug = 'S' begin
         print '    RUBRO:  ' + @w_td_concepto
         print '    Param:  ' + @w_dp_cuenta
         print '    CodVal: ' + cast(@w_td_codval as varchar)
         print '    perfil: ' + @w_perfil
         print '    total:  ' + cast(@w_secuencial as varchar)
         print '    Of_orig:' + cast(@w_ofi_usu as varchar)
         print '    Of_dest:' + cast(@w_ofi_oper as varchar)
      end

      select
      @w_debito         = 0.00,
      @w_debito_me      = 0.00,
      @w_credito        = 0.00,
      @w_credito_me     = 0.00,
      @w_td_concepto    = ltrim(rtrim(@w_td_concepto)),
      @w_valor_base     = 0,
      @w_valor_ref      = null,
      @w_afecta         = null,
      @w_td_monto       = @w_td_monto * @w_factor

      if @i_debug = 'S'  print '--> sp_conta. @w_cod_producto' + cast(@w_cod_producto as varchar)
      if @i_debug = 'S'  print '--> sp_conta. @w_perfil' + cast(@w_perfil as varchar)


      select @w_re_area = ta_area,
             @w_ofi_central = ta_ofi_central
      from cob_conta..cb_tipo_area with (nolock)
      where ta_tiparea  = @w_dp_area
      and   ta_empresa  = 1
      and   ta_producto = @w_cod_producto

      if @@rowcount = 0 select @w_re_area = @w_ar_origen, @w_ofi_central = @w_ofi_oper

      if @i_debug = 'S'  print '--> sp_conta. @w_re_area' + cast(@w_re_area as varchar)
      if @i_debug = 'S'  print '--> sp_conta. @w_ofi_central' + cast(@w_ofi_central as varchar)


      /* CONCEPTO DEL ASIENTO */
      select @w_concepto = @w_descripcion           +
      ' Cpt:'  + @w_td_concepto                     +
      ' CVa:'  + convert(varchar,@w_td_codval)

      select @w_ec_cuenta = '0'

      if @i_debug = 'S'  print '--> sp_conta. @w_td_concepto' + cast(@w_td_concepto as varchar)

      /* TRANSACCION REALIZADA POR SERVICIOS BANCARIOS */
      if @w_td_concepto = @w_chqcom begin

         select 
         @w_orden_impresion = isnull(mm_secuencial_lote,0),
         @w_ec_cuenta       = isnull(mm_cuenta,'0')
         from   pf_emision_cheque with (nolock),
         pf_mov_monet
         where  ec_operacion = mm_operacion
         and    ec_secuencia = mm_secuencia
         and    ec_sub_secuencia = mm_sub_secuencia
         and    isnull(ec_numero, 0) > 0
         and    ec_tran          = @w_tran_cur
         and    ec_operacion     = @w_operacionpf
         and    ec_secuencia     = @w_secuencia
         and    ec_sub_secuencia = convert(tinyint, @w_td_aux)

         if @@rowcount = 0 select @w_orden_impresion = 0

         if @w_orden_impresion > 0 begin

               select 
               --@w_secuencial  = isnull(il_sec_origen,il_secuencial), 
               @w_instrumento = il_instrumento, 
               @w_subtipo     = il_subtipo, 
               @w_serie_ini   = SUBSTRING(convert(varchar(20),il_serie_numerica),1,(charindex('.',(convert (varchar(20),il_serie_numerica))))-1)
               from   cob_sbancarios..sb_impresion_lotes
               where  il_secuencial = @w_orden_impresion
         
         end

         select @w_cheque_str = convert(varchar(50),isnull(@w_serie_ini,0))

         if @i_debug = 'S' begin
            print '--> sp_conta. @w_orden_impresion ' + cast(@w_orden_impresion as varchar)
            print '--> sp_conta. @w_secuencial      ' + cast(@w_secuencial      as varchar)
            print '--> sp_conta. @w_instrumento     ' + cast(@w_instrumento     as varchar)
            print '--> sp_conta. @w_subtipo         ' + cast(@w_subtipo         as varchar)
            print '--> sp_conta. @w_serie_ini       ' + cast(@w_serie_ini       as varchar)
            print '--> sp_conta. @w_cheque_str      ' + cast(@w_cheque_str      as varchar)            
         end

      end

      /* CONTABILIDAD DE IMPUESTOS (RUBROS QUE SE CALCULAN EN BASE A OTROS) */
      if @w_td_concepto in (@w_gmf, @w_retfuente) begin

         /* AQUI DETERMINAR EL VALOR DE LA BASE @w_valor_base */

         if @w_td_concepto = @w_retfuente begin
            select @w_con_rete = '0215'
            select @w_valret = @w_td_monto

            select @w_tasa_ret = cr_porcentaje/100
            from cob_conta..cb_conc_retencion
            where cr_empresa = 1
            and cr_codigo    = '0215'
            and cr_tipo      = 'R'
            and cr_debcred   = 'D'

            select @w_valor_base = @w_td_monto/@w_tasa_ret
         end

         if @w_td_concepto = @w_gmf begin
            select @w_valor_base = @w_td_monto / @w_tasa_gmf
            select @w_valret = @w_td_monto
         end
      end


if @i_debug = 'S'  print '--> sp_conta. @w_td_monto' + cast(@w_td_monto as varchar)

      /* REVERSAS EN CASO DE NEGATIVOS, INVERTIR SIGNOS DEL ASIENTO */
      if @w_td_monto < 0 begin
         if @w_dp_debcred = '2' 
            select @w_dp_debcred = '1'
         else 
            select @w_dp_debcred = '2'

         select @w_td_monto = -1 * @w_td_monto
      end

      select @w_debcred = convert(int,@w_dp_debcred)


      /* DETERMINAR MONTO EN MONEDA NACIONAL */
      if @w_td_moneda <> @w_mon_nac begin

         select @w_cotizacion = ct_valor
           from cob_conta..cb_cotizacion
          where ct_moneda  =  @w_td_moneda
            and ct_fecha   = (select max(ct_fecha)
                                from cob_conta..cb_cotizacion
                               where ct_moneda  =  @w_td_moneda
                                 and ct_fecha   <= @w_fecha_proceso)

         if @w_cotizacion is null begin
            select
            @w_mensaje  = 'Error en Busqueda Cotizacion',
            @w_error    = 701070
            goto ERROR_PERF
         end

         if @w_cotizacion is not null
            select @w_td_monto_mn = @w_cotizacion * @w_td_monto

      end else begin

         select
         @w_cotizacion   = 1,
         @w_td_monto_mn = @w_td_monto                           --LAZG Redondeos

      end

      if @i_debug = 'S' print '   MONTO_MN: '+convert(varchar, @w_td_monto_mn, 1) + ' DEBCRED:'+convert(varchar, @w_debcred)

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA NACIONAL */
      select
      @w_debito   = @w_td_monto_mn*(2-@w_debcred),
      @w_credito  = @w_td_monto_mn*(@w_debcred-1)
      

      /* DETERMINAR VALORES DE DEBITO Y CREDITO EN MONEDA EXTRANJERA */
      if  @w_dp_constante = 'T'
      and @w_td_moneda  <> @w_mon_nac
         select
         @w_debito_me  = @w_td_monto * (2-@w_debcred),
         @w_credito_me = @w_td_monto * (@w_debcred-1)

      /* FORZAR MONEDA LOCAL SEGUN CORRESPONDA */
      if @w_dp_constante = 'L'
         select
         @w_moneda_as  = @w_mon_nac,
         @w_debito_me  = 0.00,
         @w_credito_me = 0.00
      else
         select @w_moneda_as = @w_td_moneda

      /* DETERMINAR OFICINA A LA QUE SE CONTABILIZARA */
      if @w_dp_origen_dest = 'O'
         select @w_oficina = @w_ofi_usu
      else begin
         if @w_dp_origen_dest = 'D' begin
            select @w_oficina = @w_ofi_oper
         end
         else begin
            if @w_dp_origen_dest = 'C' begin
               select @w_oficina = @w_ofi_central
            end
         end
      end

if @i_debug = 'S'  print '--> sp_conta. @w_dp_origen_dest' + cast(@w_dp_origen_dest as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_oficina' + cast(@w_oficina as varchar)


      select
      @w_tplazo      = @w_op_plazo_cont,
      @w_oficina_aux = @w_oficina,
      @w_ente        = @w_op_ente,
      @w_tente       = @w_en_tente

      /* TRANSCCIONES DE MANEJO ESPECIAL (CAMBIOS DE OFICINA Y PLAZO) */
      if @w_tipo_trn = 'EOP' begin  

         select	@w_plazo_ant = or_num_dias
         from	pf_operacion_renov, 
	        pf_operacion
         where	op_operacion		= or_operacion
         and	or_operacion		= @w_operacionpf
         and    op_estado		= 'ACT'
         and	or_fecha_ult_renov	>= op_fecha_valor

      
         if @w_td_concepto = 'AHO'
         begin

            select   @w_cuenta_banco = mm_cuenta
            from     cob_pfijo..pf_mov_monet M
            where    mm_operacion         = @w_operacionpf
            and      mm_producto          = 'AHO'
            and      mm_tran              = 14943
            and      mm_valor             = @w_td_monto
            and      mm_fecha_aplicacion  = @w_fecha_mov
            and      mm_sub_secuencia     = @w_td_aux
            and      mm_estado            = 'A' 

            exec @w_error = cob_interfase..sp_iahorros
                 @i_operacion    = 'A',
                 @i_cuenta_banco = @w_cuenta_banco,
                 @o_cliente      = @w_cliente          out

            if @w_error <> 0
            begin
               select
               @w_mensaje  = ' ERR ejecutando sp_iahorros ' +  @w_cuenta_banco,
               @w_error    = 701102
               goto ERROR_PERF
            end

            --selecciona el cliente de la cta de ahorros
            select   @w_ente = isnull(@w_cliente, @w_op_ente)
         end
 

	 select @w_plazo_aux = isnull(@w_plazo_ant  , 0)
		
	 if @w_plazo_aux > 0
	    select @w_tplazo      = @w_plazo_aux               --cambio de plazo
      
      end

      if @w_tipo_trn = 'REN' select @w_tplazo      = @w_td_aux               --cambio de plazo
      if @w_tipo_trn = 'COF' select @w_oficina_aux = convert(int,@w_td_aux)  --cambio de oficina
      if @w_tipo_trn = 'END' begin --ENDOSOS
         select @w_ente = convert(int,@w_td_aux)  --cambio de cliente, endoso

      end

         select @w_tente = case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end
         from   cobis..cl_ente
         where  en_ente = @w_ente

      if @w_tipo_trn in ('APE','CAN') and (@w_td_aux is not null) and  (@w_td_concepto in ('AHO', 'CHG', 'CTE')) begin --ENDOSOS
         select @w_ente = convert(int,@w_td_aux)  --cambio de cliente, endoso
      end

      /* DETERMINAR LA CUENTA CONTABLE DONDE REGISTRAR EL ASIENTO */
      if substring(@w_dp_cuenta,1,1) in ('1','2','3','4','5','6','7','8','9','0')
      begin

         select @w_cuenta_final   = @w_dp_cuenta

      end else begin

         select @w_stored = pa_stored
         from   cob_conta..cb_parametro with (nolock)
         where  pa_empresa     = 1
         and    pa_parametro   = @w_dp_cuenta

         if @@rowcount = 0 begin
            select
            @w_mensaje  = ' ERR NO EXISTE TABLA DE CUENTAS ' +  @w_dp_cuenta + '(cb_parametro)',
            @w_error    = 701102
            goto ERROR_PERF
         end

if @i_debug = 'S'  print '--> sp_conta. @w_stored' + cast(@w_stored as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_dp_cuenta' + cast(@w_dp_cuenta as varchar)


         select @w_clave = case @w_stored
         when 'sp_pf01_pf' then rtrim(@w_tplazo) + '.' + rtrim(convert(varchar,@w_td_moneda)) + '.' + @w_tente
         when 'sp_pf02_pf' then @w_td_concepto +'.'+convert(varchar,@w_td_moneda) +'.'+ isnull(@w_ec_cuenta, '0')
         when 'sp_pf03_pf' then convert(varchar,@w_td_moneda)
         end
         if @i_debug = 'S' print '   SP: '+@w_stored +' @w_dp_cuenta :'+@w_dp_cuenta + ' CLAVE: '+ @w_clave

if @i_debug = 'S'  print '--> sp_conta. @w_clave' + cast(@w_clave as varchar)

         select @w_cuenta_final = isnull(rtrim(ltrim(re_substring)), '')
         from cob_conta..cb_relparam with (nolock)
         where re_empresa             = 1
         and   re_parametro           = @w_dp_cuenta
         and   ltrim(rtrim(re_clave)) = @w_clave

         if @@rowcount = 0 select @w_cuenta_final = ''

      end
      if @i_debug = 'S'  print '   Cuenta Final: ' + @w_cuenta_final 


if @i_debug = 'S'  print '--> sp_conta. @w_cuenta_final' + cast(@w_cuenta_final as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_credito' + cast(@w_credito as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_debito' + cast(@w_debito as varchar)


      /* GENERAR ASIENTO DEL COMPROBANTE */
      if  @w_cuenta_final <> '' and @w_credito+@w_debito >= 0.01  begin         
         select
         @w_asiento        = @w_asiento        + 1,
         @w_tot_credito    = @w_tot_credito    + @w_credito,
         @w_tot_debito     = @w_tot_debito     + @w_debito,
         @w_tot_credito_me = @w_tot_credito_me + @w_credito_me,
         @w_tot_debito_me  = @w_tot_debito_me  + @w_debito_me

         /* DETERMINAR OFICINA DESTINO*/
         select @w_re_ofconta = re_ofconta
         from   cob_conta..cb_relofi with (nolock)
         where  re_filial  = 1
         and    re_empresa = 1
         and    re_ofadmin = @w_oficina_aux

         if @@rowcount = 0 begin
            select
            @w_mensaje  = ' ERR NO EXISTE OF.CONTABLE (cb_relofi) ' + convert(varchar,@w_oficina) + '-',
            @w_error    = 701102
            goto ERROR_PERF
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
         @w_cod_producto,    @w_fecha_mov,       @w_comprobante,
         1,                  @w_asiento,         @w_cuenta_final,
         @w_re_ofconta,      @w_re_area,         @w_credito,
         @w_debito,          isnull(@w_concepto,@w_descripcion), @w_credito_me,
         @w_debito_me,       @w_cotizacion,      'N',
        'A',                 @w_moneda_as,       0,
         @w_ente,            @w_con_rete,        @w_valor_base,
         @w_valret,          null,               @w_td_monto,
         null,               null,               null,
         null,               null,               null,
         null,               null,               @w_banco,
         'N',                null,               null,
         'S',                @w_dp_debcred,      null,
         @w_cheque_str,      null,               null,
         null,               'N' )

         if @@error <> 0 begin
            select
            @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_sasiento_tmp ',
            @w_error   = 710001
            goto ERROR_PERF
         end

      end --CUENTA FINAL <> ''

      goto SIGUIENTE_PERF

      ERROR_PERF:
      close cursor_perfil
      deallocate cursor_perfil

      goto ERROR1


      SIGUIENTE_PERF:

      fetch cursor_perfil into
      @w_td_concepto,     @w_td_codval,      @w_td_moneda,
      @w_td_aux,          @w_dp_cuenta,      @w_dp_debcred,
      @w_dp_constante,    @w_dp_origen_dest, @w_dp_area,
      @w_td_monto

   end  -- cursol de los detalles del perfil

   close cursor_perfil
   deallocate cursor_perfil


   /** GENERACION DEL COMPROBANTE **/
   select @w_re_ofconta = re_ofconta
   from   cob_conta..cb_relofi with (nolock)
   where  re_filial  = 1
   and    re_empresa = 1
   and    re_ofadmin = @w_ofi_usu

   if @@rowcount = 0 begin
      select
      @w_mensaje = ' ERR NO EXISTE OF.ORIGEN ' + convert(varchar,@w_ofi_usu)+ '-',
      @w_error   = 701102
      goto ERROR1
   end

   if abs(@w_tot_debito - @w_tot_credito) >= 0.01 begin
      select
      @w_mensaje = 'NO CUADRAN DEBITOS CON CREDITOS: D-> ' +  convert(varchar,@w_tot_debito)+ ' C-> ' + convert(varchar,@w_tot_credito),
      @w_error   = 701102
      goto ERROR1
   end

if @i_debug = 'S'  print '--> sp_conta. @w_tot_debito' + cast(@w_tot_debito as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_tot_credito' + cast(@w_tot_credito as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_comprobante' + cast(@w_comprobante as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_re_ofconta' + cast(@w_re_ofconta as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_ar_origen' + cast(@w_ar_origen as varchar)
if @i_debug = 'S'  print '--> sp_conta. @w_fecha_mov' + cast(@w_fecha_mov as varchar)



   if @w_tot_debito >= 0.01 or @w_tot_credito >= 0.01 begin

      if @i_debug = 'S' print '   Generando comprobante... of: ' + cast(@w_re_ofconta as varchar)

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
      @s_user,           @w_descripcion,   convert(char(10),getdate(),101),
      @w_perfil,         @w_asiento,       @w_tot_debito,
      @w_tot_credito,    @w_tot_debito_me, @w_tot_credito_me,
      @w_cod_producto,   'N',                'I',
      'N',               null,             null,
      'sa',              @w_secuencial,   'N')

      if @@error <> 0 begin
         select
         @w_mensaje = 'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_scomprobante_tmp ',
         @w_error   = 710001
         print 'ERROR COMP'
         goto ERROR1
      end

      if @i_debug = 'S' print '   Generando comprobante... @w_comprobante: ' + cast(@w_comprobante as varchar)
      
      
   end else begin
	  print 'ERROR ELSE'
      select
      @w_comprobante = -2, -- sin asientos
      @w_mensaje = 'COMPROBANTE SIN ASIENTOS'
      goto ERROR1
   end

   MARCAR:

         if @i_debug = 'S' print '   Generando comprobante... @w_operacionpf: ' + cast(@w_operacionpf as varchar)
         if @i_debug = 'S' print '   Generando comprobante... @w_secuencial: ' + cast(@w_secuencial as varchar)

   
   update pf_transaccion with (rowlock)set
   tr_comprobante  =  @w_comprobante,
   tr_fecha_cont   =  @w_fecha_proceso,
   tr_estado       =  'CON'
   where tr_operacion  = @w_operacionpf
   and   tr_secuencial = @w_secuencial

   if @@error <> 0 begin
      print 'ERROR PF_TRAN'
      select @w_mensaje = ' ERR AL MARCAR TABLA DE TRANSACCION BANCAMIA '
      select @w_error = 700002
      goto ERROR1
   end
   
   
   
   goto SIGUIENTE

   ERROR1:

   select @w_mensaje = @w_descripcion + ' ' + @w_mensaje
   if @i_debug = 'S' print '            ERROR1 --> ' + @w_mensaje


   exec @w_error = cob_interfase..sp_iccontable
        @i_operacion   = 'I',
        @t_trn         = 60011,
        @i_empresa     = 1,
        @i_fecha       = @w_fecha_proceso,
        @i_producto    = @w_cod_producto,
        @i_tran_modulo = @w_secuencial, --@w_tran_cur,
        @i_asiento     = 0,
        @i_fecha_conta = @w_fecha_mov,
        @i_numerror    = @w_error,
        @i_mensaje     = @w_mensaje,
        @i_perfil      = @w_perfil,
        @i_oficina     = @w_re_ofconta


   exec sp_errorlog
   @s_date      = @w_fecha_proceso,
   @i_fecha     = @w_fecha_proceso,
   @i_error     = @w_error,
   @i_usuario   = 'operador',
   @i_tran      = 14000,
   @i_cuenta    = @w_banco,
   @i_descripcion = @w_mensaje,
   @i_cta_pagrec  = ''

   SIGUIENTE:

   delete  #transacciones 
   where tr_operacion  = @w_operacionpf
   and   tr_secuencial = @w_secuencial
   
end --end while

return 0

ERRORFIN:

if @i_debug = 'S' print 'ERROR: '+@w_msg

exec @w_error = cob_interfase..sp_iccontable
     @t_trn         = 60011,
     @i_operacion   = 'I',
     @i_empresa     = 1,
     @i_fecha       = @w_fecha_proceso,
     @i_producto    = @w_cod_producto,
     @i_tran_modulo = 0,
     @i_asiento     = 0,
     @i_fecha_conta = @w_fecha_mov,
     @i_numerror    = @w_error,
     @i_mensaje     = @w_mensaje,
     @i_perfil      = @w_perfil,
     @i_oficina     = @w_re_ofconta

if @w_error <> 0
   return @w_error

exec sp_errorlog
@s_date      = @w_fecha_proceso,
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error,
@i_usuario   = 'operador',
@i_tran      = 14005,
@i_cuenta    = 'CONTABILIDAD',
@i_descripcion = @w_mensaje,
@i_cta_pagrec  = ''

return 0
go
