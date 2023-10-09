/************************************************************************/
/*   Archivo:              otcargos.sp                                  */
/*   Stored procedure:     sp_otros_cargos                              */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Francisco Yacelga                            */
/*   Fecha de escritura:   25/Nov./1997                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Consulta para front end otros Cargos                               */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*   FECHA              AUTOR          RAZON                            */
/*   JUN-09-2010        EPB            Quitar Codigo Causacion Pasivas  */
/* 04/10/2010         Yecid Martinez     Fecha valor baja Intensidad    */
/*                                       NYMR 7x24                      */
/* 18/01/2012         Luis C. Moreno  RQ293 Saldo por amort. reconoc.   */
/* 18/05/2017         Jorge Salazar   CGS-S112643 PARAMETRIZACIÓN BASE  */
/*                                    DE CARTERA APF                    */
/* 04/04/2020         Dario Cumbal     Cambios 137397                   */
/* 07-01-2020         DCU              Req. 140073                      */
/* 19/01/2022         DCU            Caso:170130 - IFRS                 */
/************************************************************************/

use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_otros_cargos')
   drop proc sp_otros_cargos
go


create proc sp_otros_cargos (
   @s_date              datetime    = null,
   @s_ssn               int         = null,
   @s_srv               varchar(30) = null,
   @s_user              login       = null,
   @s_term              descripcion = null,
   @s_ofi               smallint    = null,
   @i_banco             cuenta      = null,
   @i_operacion         char(1)     = null,
   @i_formato_fecha     int         = null,
   @i_toperacion        varchar(10) = null,
   @i_moneda            int         = null,
   @i_concepto          varchar(10) = null,
   @i_monto             money       = null,
   @i_comentario        varchar(64) = null,
   @i_tipo_rubro        char(1)     = null,
   @i_base_calculo      money       = 0,
   @i_div_desde         smallint    = 0,
   @i_div_hasta         smallint    = 0,
   @i_saldo_op          char(1)     = 'N',
   @i_saldo_por_desem   char(1)     = 'N',
   @i_tasa              float       = 0,
   @i_num_dec_tapl      tinyint     = null,
   @i_credito           char(1)     = 'N',
   @i_sec_act           int         = null,
   @i_forma_cabio_fecha char(1)     = null,
   @i_secuencial        int         = null,
   @i_en_linea          char(1)     = 'S',
   @i_desde_batch       char(1)     = 'N',
   @i_generar_trn       char(1)     = 'S',  
   @i_secuencial_ioc    int         = null,
   @i_temporal          char(1)     = 'N',
   @o_sec_tran          int         = 0 output
)
as
declare
   @w_sp_name              varchar(32),
   @w_error                int,
   @w_operacionca          int,
   @w_fecha_ven            datetime,
   @w_di_fecha_ven         datetime,
   @w_fecha_ult_proceso    datetime,
   @w_ru_concepto          catalogo,
   @w_co_descripcion       varchar(50),
   @w_ru_tipo_rubro        catalogo,
   @w_ru_referencial       catalogo,
   @w_va_clase             char(1),
   @w_vd_signo_default     char(1),
   @w_vd_valor_default     float,
   @w_vd_signo_maximo      char(1),
   @w_vd_valor_maximo      float,
   @w_vd_signo_minimo      char(1),
   @w_vd_valor_minimo      float,
   @w_vd_referencia        catalogo,
   @w_valor_referencia     float,
   @w_op_sector            char(1),
   @w_secuencial           int,
   @w_dividendo            int,
   @w_di_estado            int,
   @w_oficina              smallint,
   @w_codvalor             int,
   @w_c                    varchar(64),
   @w_num_dec              tinyint,
   @w_num_dec_tapl         tinyint,
   @w_valor_rubro          money,
   @w_ru_saldo_op          char(1),
   @w_ru_saldo_por_desem   char(1),
   @w_div_desde            smallint,
   @w_div_hasta            smallint,
   @w_div_actual           smallint,
   @w_est_novigente        tinyint,
   @w_est_vigente          tinyint,
   @w_est_vencido          tinyint,
   @w_est_cancelado        tinyint,
   @w_est_suspenso         tinyint,
   @w_est_castigado        tinyint,
   @w_est_anulado          tinyint,
   @w_valor_tot            money,
   @w_tasa                 float,
   @w_ru_limite            char(1),
   @w_rango_max            money,
   @w_categoria_rubro      catalogo,
   @w_cliente              int,
   @w_gerente              smallint,
   @w_gar_admisible        char(1),
   @w_reestructuracion     char(1),
   @w_calificacion         char(1),
   @w_op_oficina           smallint,
   @w_producto             tinyint,
   @w_concepto_cxp         varchar(30),
   @w_re_area              smallint,
   @w_secuencial_cxp       int,
   @w_banco                cuenta,
   @w_moneda               int,
   @w_toperacion           catalogo,
   @w_moneda_nacional      tinyint,
   @w_cotizacion           float,
   @w_fecha                datetime,
   @w_monto_mn             money,
   @w_estado_div           int,
   @w_estado_op            smallint,
   @w_divi_vigente         smallint,       -- IFJ 02/Feb/2006 REQ 500
   @w_valida               char(1),
   @w_max_dividendo        int,
   @w_estado_maximo        smallint,
   @w_rango                tinyint,
   @w_tipo                 char(1),
   @w_return               int,
   @w_gracia_int           smallint,       -- REQ 175: PEQUEÑA EMPRESA
   @w_vlr_x_amort          money,          -- REQ 293: RECONOCIMIENTO GARANTIAS FNG Y USAID
   @w_sector               int,            -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_rubro_iva            catalogo,       -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_tasa_iva             float,          -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_tasa_ref_iva         catalogo,       -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_commit               char(1),         -- CGS-S112643 PARAMETRIZACIÓN BASE DE CARTERA APF
   @w_commora              catalogo,
   @w_est_etapa2           int,
   @w_provisiona           char(1)

--  CAPTURA NOMBRE DE STORED PROCEDURE
select @w_sp_name = 'sp_otros_cargos'
--
select @w_commit     = 'N',
       @w_commora    = 'COMMORA'

---ESTADOS DE LA CARTERA
exec @w_return   = sp_estados_cca
@o_est_vigente   = @w_est_vigente   out,
@o_est_novigente = @w_est_novigente out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_castigado = @w_est_castigado out,
@o_est_anulado   = @w_est_anulado   out,
@o_est_etapa2    = @w_est_etapa2    out 

if @w_return <> 0 begin
   select @w_error = @w_return
   goto ERROR
end

select @w_estado_op = op_estado
from   ca_operacion
where  op_banco = @i_banco

if @w_estado_op is null
   select @w_estado_op = opt_estado
   from   ca_operacion_tmp
   where  opt_banco = @i_banco

if @w_estado_op in (@w_est_cancelado,@w_est_anulado) begin
   select @w_error = 710563
   goto ERROR
end        

exec @w_error = sp_decimales
@i_moneda     = @i_moneda,
@o_decimales  = @w_num_dec out

-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

--VALIDACION EXISTENCIA DEL CONCEPTO
if @i_concepto is not null begin
   if not exists (select 1 from ca_concepto where co_concepto = @i_concepto)
   begin
      select @w_error = 710082
      goto ERROR
   end                 
end

if @i_temporal = 'N'
begin
   select 
   @w_operacionca = op_operacion,
   @w_fecha_ven   = op_fecha_fin,
   @w_tipo        = op_tipo,
   @w_gracia_int  = op_gracia_int,                       -- REQ 175: PEQUEÑA EMPRESA
   @w_sector      = op_sector
   from   ca_operacion
   where  op_banco = @i_banco
end
else
begin
   select 
   @w_operacionca = opt_operacion,
   @w_fecha_ven   = opt_fecha_fin,
   @w_tipo        = opt_tipo,
   @w_gracia_int  = opt_gracia_int,                       -- REQ 175: PEQUEÑA EMPRESA
   @w_sector      = opt_sector
   from   ca_operacion_tmp
   where  opt_banco = @i_banco
end



if @i_forma_cabio_fecha = 'S' and @w_tipo in ('C','R')  ---desde la pantalla CAMBIO DE FECHA
begin
   print 'Operacion de tipo REDESCUENTO, no permite cambio de fecha'
   return 0
end


if @i_operacion='Q'
begin

   --PRINT '--INICIO NYMR 7x24 Ejecuto FECHA VALOR BAJA INTENSIDAD ' + CAST(@w_operacionca as varchar)

   EXEC @w_return = sp_validar_fecha
      @s_user                  = @s_user,
      @s_term                  = @s_term,
      @s_date                  = @s_date,
      @s_ofi                   = @s_ofi,
      @i_operacionca           = @w_operacionca,
      @i_debug                 = 'N'

   if @w_return <> 0
   begin
      select @w_error = @w_return 
      goto ERROR
   end

   select @w_di_fecha_ven = di_fecha_ven
   from   ca_dividendo
   where  di_operacion = @w_operacionca
   and    di_estado    = 1  --vigente
   
   select @w_di_fecha_ven = isnull(@w_di_fecha_ven, @w_fecha_ven)
   
   /* LCM - 293: CONSULTA LA TABLA DE RECONOCIMIENTO PARA VALIDAR SI LA OBLIGACION TIENE RECONOCIMIENTO */
   select @w_vlr_x_amort = 0

   select @w_vlr_x_amort = pr_vlr - pr_vlr_amort
   from ca_pago_recono with (nolock)
   where pr_operacion = @w_operacionca
   and   pr_estado    = 'A'

   -- DATOS DE LA CABECERA
   select op_toperacion,
          op_oficina,
          op_banco,
          op_moneda,
          op_oficial,
          convert(varchar, op_fecha_fin, @i_formato_fecha),
          convert(float,op_monto_aprobado), convert(float, op_monto), es_descripcion,
          op_cliente,
          op_nombre,
          convert(varchar, @w_di_fecha_ven, @i_formato_fecha),
          convert(varchar, op_fecha_ult_proceso, @i_formato_fecha),
          convert(float, @w_vlr_x_amort)--RQ293 Saldo amortizacion reconocimiento
   from   ca_operacion, ca_estado
   where  op_operacion = @w_operacionca
   and    es_codigo    = op_estado
end


-- CONSULTA LOS CARGOS EN NA
---DEF:7428:NOV:09:2006:EPB
if @i_operacion = 'O'
begin
   select 'Sec.'=oc_secuencial,
          'Div.Ini'=oc_div_desde, 
          'Dic.Hasta'=oc_div_hasta ,
          'Fecha'= convert(varchar, oc_fecha, @i_formato_fecha) ,
          'Concepto'=oc_concepto ,
          'Valor'=oc_monto, 
          'Ref'=oc_referencia
   from  ca_otro_cargo
   where oc_operacion = @w_operacionca
   and   oc_estado in ('NA','A')  --Mroa: Para mostrar tambien los cargos aplicados
   order by oc_fecha

end



-- CONSULTA LOS RUBROS

if @i_operacion ='H'
begin
   -- CHEQUEA QUE EXISTA EL RUBRO
   select 'Concepto'    = co_concepto,
          'Descripcion' = co_descripcion
   from   ca_rubro,ca_concepto
   where  ru_toperacion = @i_toperacion
   and    ru_moneda       = @i_moneda
   and    ru_concepto     = co_concepto
   and    ru_fpago        = 'M'
   
   if @@rowcount = 0
   begin
      select @w_error = 710082
      goto ERROR
   end  
end



-- CONSULTA LOS RUBROS CON SU RESPECTIVO VALOR

if @i_operacion ='S'
begin
   -- CHEQUA QUE EXISTA EL RUBRO
   select @w_c = co_descripcion 
   from   ca_rubro,ca_concepto
   where  ru_concepto = @i_concepto
   and    ru_toperacion = @i_toperacion
   and    ru_moneda     = @i_moneda
   and    ru_concepto   = co_concepto
   and    ru_fpago      = 'M'
   
   if @@rowcount = 0
   begin
      select @w_error = 710082
      goto ERROR
   end  
   
   --  EXISTE EL RUBRO
   select @w_operacionca = op_operacion,
          @w_fecha_ven   = op_fecha_fin,
          @w_op_sector   = op_sector
   from   ca_operacion
   where  op_banco = @i_banco
   
   select @w_tasa = 0.0,
          @w_num_dec_tapl = null
   
   -- CONSULTA PARA SACAR EL VALOR DE LOS RUBROS
   select @w_ru_concepto        = ru_concepto,
          @w_co_descripcion     = co_descripcion,
          @w_ru_tipo_rubro      = ru_tipo_rubro,
          @w_ru_referencial     = ru_referencial,
          @w_ru_limite          = ru_limite,
          @w_va_clase           = va_clase,
          @w_vd_signo_default   = vd_signo_default,
          @w_vd_valor_default   = vd_valor_default,
          @w_vd_signo_maximo    = vd_signo_maximo, 
          @w_vd_valor_maximo    = vd_valor_maximo,
          @w_vd_signo_minimo    = vd_signo_minimo,  
          @w_vd_valor_minimo    = vd_valor_minimo,
          @w_vd_referencia      = vd_referencia,
          @w_ru_saldo_op        = ru_saldo_op,
          @w_ru_saldo_por_desem = ru_saldo_por_desem,
          @w_num_dec_tapl       = vd_num_dec
   from   ca_valor_det, ca_rubro, ca_concepto,
          ca_valor
   where  vd_sector      = @w_op_sector
   and    ru_concepto    = co_concepto
   and    ru_toperacion  = @i_toperacion
   and    ru_moneda      = @i_moneda
   and    ru_concepto    = @i_concepto
   and    ru_fpago       = 'M'
   and    ru_referencial = vd_tipo
   and    vd_tipo        = va_tipo
   
   if @@rowcount <> 0
   begin
      if @w_va_clase = 'F'
      begin

         select @w_fecha = max(vr_fecha_vig)
         from   ca_valor_referencial
         where  vr_tipo      = @w_vd_referencia
         and    vr_fecha_vig <= @s_date


         select @w_valor_referencia = vr_valor
         from   ca_valor_referencial
         where  vr_tipo       = @w_vd_referencia
         and    vr_secuencial = (select max(vr_secuencial)
                                 from   ca_valor_referencial
                                 where  vr_tipo      = @w_vd_referencia
                                 and    vr_fecha_vig = @w_fecha)
         and    vr_fecha_vig = @w_fecha
         
         exec sp_calcula_valor
              @i_base       = @w_valor_referencia,
              @i_factor     = @w_vd_valor_default,
              @i_signo      = @w_vd_signo_default,
              @o_resultado  = @w_vd_valor_default out
         
         exec sp_calcula_valor
              @i_base      = @w_valor_referencia,
              @i_factor    = @w_vd_valor_maximo,
              @i_signo     = @w_vd_signo_maximo,
              @o_resultado = @w_vd_valor_maximo out
         
         exec sp_calcula_valor
              @i_base       = @w_valor_referencia,
              @i_factor     = @w_vd_valor_minimo,
              @i_signo      = @w_vd_signo_minimo,
              @o_resultado  = @w_vd_valor_minimo out
         
         if @w_num_dec_tapl is not null
            select @w_vd_valor_default = round(@w_vd_valor_default,@w_num_dec_tapl),
                   @w_vd_valor_maximo  = round(@w_vd_valor_maximo,@w_num_dec_tapl),
                   @w_vd_valor_minimo  = round(@w_vd_valor_minimo,@w_num_dec_tapl)
      end
      ELSE
      begin
         select @w_vd_valor_maximo = @w_vd_valor_default,
                @w_vd_valor_minimo = @w_vd_valor_default
      end

      if @w_ru_tipo_rubro = 'Q'
      begin
         select @w_tasa = @w_vd_valor_default,
                @w_error = 0
         
         exec @w_error = sp_rubro_calculado
              @i_tipo            = 'Q',
              @i_monto           = 0,
              @i_concepto        = @w_ru_concepto,
              @i_operacion       = @w_operacionca,
              @i_porcentaje      = @w_tasa,
              @i_saldo_op        = @w_ru_saldo_op,
              @i_saldo_por_desem = @w_ru_saldo_por_desem,
              @i_usar_tmp        = 'N',
              @o_valor_rubro     = @w_valor_rubro out
         
         if @w_error <> 0
            goto ERROR
         
         select @w_vd_valor_default = round(@w_valor_rubro, @w_num_dec)
         
         select @w_vd_valor_maximo  = @w_vd_valor_default,
                @w_vd_valor_minimo  = @w_vd_valor_default
      end
      
      if @w_ru_tipo_rubro in ('O','V','Q') and (@w_ru_limite = 'S') 
      begin
         --NR-293
         select @w_rango = isnull(max(ct_nro_rangos),1)
         from ca_campos_tablas_rubros
         where ct_concepto  = @w_ru_concepto
         
         if  @w_rango = 1
         begin
             select @w_rango_max = tur_valor_max
             from   ca_campos_tablas_rubros, 
                    ca_tablas_un_rango
             where  ct_concepto  = @w_ru_concepto
             and    tur_concepto = ct_concepto
         
            if @@rowcount = 0 
            begin
--               print 'Parametrizar en Definicion de Tablas de Rubros el Rubro..' + cast(@w_ru_concepto as varchar)
               select @w_error = 721301
               goto ERROR
            end
        end

         if  @w_rango = 2
         begin
            if @@rowcount = 0
            begin
--               print 'Programacion no existe para el rubro el Rubro en tablas de dos rangos..' + cast(@w_ru_concepto as varchar)
               select @w_error = 721302
               goto ERROR
            end
        end
        
            
         
         if round(@w_vd_valor_default,@w_num_dec) <= round(@w_rango_max,@w_num_dec)
         begin
            select @w_vd_valor_default = @w_rango_max
            select @w_vd_valor_maximo  = @w_rango_max
            select @w_vd_valor_minimo  = @w_rango_max
         end
      end
      
      select @w_ru_concepto,
             @w_co_descripcion,
             @w_ru_tipo_rubro,
             @w_ru_referencial,
             @w_vd_valor_default,
             @w_vd_valor_maximo,
             @w_vd_valor_minimo,
             @w_vd_referencia,
             isnull(@w_ru_saldo_op, 'N'),
             isnull(@w_ru_saldo_por_desem, 'N'),
             @w_tasa,
             @w_num_dec_tapl
   end
   ELSE
   begin
      select @w_error = 710081
      goto ERROR
   end
end

if @i_operacion = 'C'
begin
   select @w_operacionca = op_operacion,
          @w_error       = 0
   from   ca_operacion
   where  op_banco = @i_banco
   
   exec @w_error = sp_rubro_calculado
        @i_tipo            = 'Q',
        @i_monto           = @i_base_calculo,
        @i_concepto        = @i_concepto,
        @i_operacion       = @w_operacionca,
        @i_porcentaje      = @i_tasa,
        @i_saldo_op        = @i_saldo_op,
        @i_saldo_por_desem = @i_saldo_por_desem,
        @i_usar_tmp        = 'N',
        @o_valor_rubro     = @w_valor_rubro out
   
   if @w_error <> 0
      goto ERROR
   
   select @w_vd_valor_default = round(@w_valor_rubro, @w_num_dec)
   select @w_vd_valor_maximo  = @w_vd_valor_default,
          @w_vd_valor_minimo  = @w_vd_valor_default
   
   select @w_vd_valor_default, @w_vd_valor_maximo, @w_vd_valor_minimo
end

-- TRANSMITIR UN CARGO
if @i_operacion = 'I' begin

   if  @i_div_desde < 1 or @i_div_hasta < 1 
   begin
      select @w_error = 710139
      goto ERROR
   end
   
   if @i_temporal = 'N'
   begin
      exec cob_cartera..sp_borrar_tmp
      @i_banco = @i_banco
      
      exec @w_return      = cob_cartera..sp_pasotmp  
      @s_user             = @s_user,
      @s_term             = @s_term,   
      @i_banco            = @i_banco,
      @i_operacionca      = 'S',
      @i_dividendo        = 'S',
      @i_amortizacion     = 'S',
      @i_cuota_adicional  = 'S',
      @i_rubro_op         = 'S'
       
   end
  
  
   select
   @w_operacionca       = opt_operacion,
   @w_oficina           = opt_oficina,
   @w_fecha_ult_proceso = opt_fecha_ult_proceso,
   @w_cliente           = opt_cliente,
   @w_gerente           = opt_oficial,
   @w_gar_admisible     = opt_gar_admisible,
   @w_reestructuracion  = opt_reestructuracion,
   @w_calificacion      = isnull(opt_calificacion,'A'),
   @w_moneda            = opt_moneda,
   @w_toperacion        = opt_toperacion
   from   ca_operacion_tmp
   where  opt_banco = @i_banco
      
   select @w_provisiona = rot_provisiona
   from ca_rubro_op_tmp
   where rot_operacion = @w_operacionca
   and   rot_concepto  = @i_concepto
   
   
   if @w_provisiona is null
   begin
      select @w_provisiona = ru_provisiona
      from ca_rubro
      where ru_toperacion = @w_toperacion
      and   ru_moneda     = @w_moneda
      and   ru_concepto   = @i_concepto
   end
   
   
   -- DETERMINAR EL VALOR DE COTIZACION DEL DIA 
   if @w_moneda = @w_moneda_nacional begin
       select @w_cotizacion = 1.0
   end else begin
       exec sp_buscar_cotizacion
       @i_moneda     = @w_moneda,
       @i_fecha      = @w_fecha_ult_proceso,
       @o_cotizacion = @w_cotizacion output
   end

   --Si la cuota es unica no valida
   select @w_valida = 'S'

   select @w_max_dividendo = max(dit_dividendo)
   from  ca_dividendo_tmp
   where dit_operacion = @w_operacionca

   select @w_estado_maximo  = dit_estado
   from  ca_dividendo_tmp
   where dit_operacion = @w_operacionca
   and   dit_dividendo = @w_max_dividendo

   if (@w_max_dividendo = 1 ) or (@w_estado_maximo  in (@w_est_vigente,@w_est_vencido))  select @w_valida = 'N'


   select
   @w_ru_tipo_rubro = ru_tipo_rubro,
   @w_ru_limite     = ru_limite
   from   ca_rubro
   where  ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_moneda
   and    ru_concepto   = @i_concepto

   select
   @w_rubro_iva       = ru_concepto,
   @w_tasa_ref_iva    = ru_referencial
   from   ca_rubro
   where  ru_toperacion          = @w_toperacion
   and    ru_moneda              = @w_moneda
   and    ru_concepto_asociado   = @i_concepto


   if @@rowcount <> 0 begin


      select @w_tasa_iva = vd_valor_default
      from   ca_valor, ca_valor_det
      where  va_tipo   = @w_tasa_ref_iva
      and    vd_tipo   = @w_tasa_ref_iva
      and    vd_sector = @w_sector
      
      if @@rowcount = 0
      begin
          print '(rubrotmp.sp) concepto asociado. Parametrizar Tasa para rubro.. @w_sector ' + cast(@w_tasa_ref_iva as varchar) + ' ' + cast(@w_sector as varchar)
          select @w_error = 710076
          goto ERROR
      end
      
   end


   -- Esta Versión solo permite otros cargos en el dividendo mas vencido o en el vigente
   --print 'El Ingreso de Este Cargo se hara en el dividendo mas Vencido si la operacion esta totalmente Vencida caso contrario en el Vigente' 


      /*VALIDACIONES*/
   if @i_div_desde = 0 and @i_div_hasta = 0 begin

      if @w_estado_op in (@w_est_vencido,@w_est_castigado,@w_est_suspenso)
         select @w_dividendo = isnull(min(dit_dividendo),0)
         from   ca_dividendo_tmp
         where  dit_operacion = @w_operacionca
         and    dit_estado    = @w_est_vencido  --PRIMER DIVIDENDO VENCIDO

      if @w_dividendo = 0 begin

         select @w_dividendo = dit_dividendo
         from   ca_dividendo_tmp
         where  dit_operacion= @w_operacionca
         and    dit_estado   = @w_est_vigente

         if @w_dividendo = 0 begin
             select @w_error = 710136
             goto ERROR
         end
      end

      select @w_div_desde = @w_dividendo
      select @w_div_hasta = @w_dividendo

   end else begin

      if @i_div_desde > @i_div_hasta begin
          select @w_error = 710139
          goto ERROR
      end

      if exists(select 1 from ca_dividendo_tmp
      where  dit_operacion = @w_operacionca
      and    dit_dividendo = @i_div_desde)
      begin
          select @w_div_desde = @i_div_desde
      end else  begin
          -- La operacion no posee dividendo desde
          select @w_error = 710137
          goto ERROR
      end
         
      if exists (select 1 from   ca_dividendo_tmp
      where  dit_operacion = @w_operacionca
      and    dit_dividendo = @i_div_hasta)
          select @w_div_hasta = @i_div_hasta
      ELSE
      begin
          select @w_error = 710138
          goto ERROR
      end
         
      if exists(select 1 from ca_dividendo_tmp
      where dit_operacion = @w_operacionca
      and   dit_dividendo between @i_div_desde and @i_div_hasta
      and   dit_estado = @w_est_cancelado)
      begin
          -- Uno de los dividendos del rango esta no vigente, cancelado o precancelado 
		  --Si el cliente pago la cuota no se puede cargar COMMORA
		  if(@i_concepto = @w_commora) begin
		    delete from ca_otro_cargo 
			where oc_operacion = @w_operacionca
			and   oc_concepto  = @w_commora
			and   oc_div_desde = @i_div_desde
			and   oc_div_hasta = @i_div_hasta
			
			if @@error <> 0 begin 
			   select @w_error= 710003
			   goto ERROR
			end
            return 0			
		  end 
		  
          select @w_error = 710140
          goto ERROR
      end
      
      -- REQ 175: PEQUEÑA EMPRESA - CONTROL DE INGRESO DE IOCS EN DIVIDENDOS CON GRACIA DE INTERES
      if @w_div_hasta <= @w_gracia_int or @w_div_desde <= @w_gracia_int begin
         select @w_error = 721325
         goto ERROR
      end

   end /*FIN VALIDACIONES*/

   if @@trancount = 0 begin
      select @w_commit = 'S'
      begin tran
   end
   
   

   if @i_generar_trn = 'S' begin  
   
   if @i_secuencial_ioc is null
      exec @w_secuencial = sp_gen_sec
      @i_operacion  = @w_operacionca
   else
      select @w_secuencial = @i_secuencial_ioc
      
   
   exec @w_error  = sp_historial
   @i_operacionca = @w_operacionca,
   @i_secuencial  = @w_secuencial

   if  @w_error <> 0  begin
       select @w_error = @w_error
       goto ERROR
   end   
   
   
   if @i_desde_batch != 'S'
   begin
   
      insert into ca_otro_cargo(
      oc_operacion,      oc_fecha,               oc_secuencial,
      oc_concepto,       oc_monto,               oc_referencia,
      oc_usuario,        oc_oficina,             oc_terminal,
      oc_estado,         oc_div_desde,           
      oc_div_hasta,      oc_base_calculo,        oc_secuencial_cxp) 
      values(
      @w_operacionca,    @w_fecha_ult_proceso,   @w_secuencial,
      @i_concepto,       @i_monto,               @i_comentario,
      @s_user,           @s_ofi,                 @s_term,
      'A',               @w_div_desde,           
      @w_div_hasta,      @i_base_calculo,        @w_secuencial)
     
      if @@error <> 0 begin
         select @w_error = 710001
         goto ERROR
      end
   end
   else
   begin
	  
      update ca_otro_cargo set
	  oc_secuencial = @w_secuencial,
      oc_estado  = 'A'
      where oc_operacion = @w_operacionca
      and oc_concepto   = @i_concepto
      and oc_secuencial = @i_secuencial

      if @@rowcount = 0
      begin
        select @w_error = 722233
        goto ERROR
      end   
   end
   
   --    PRINT '@i_toperacion  ' + CAST(@i_toperacion AS VARCHAR)
   --    PRINT '@w_operacionca ' + CAST(@w_operacionca AS VARCHAR)   
      
   insert into ca_transaccion(
   tr_secuencial,       tr_fecha_mov,         tr_toperacion,
   tr_moneda,           tr_operacion,         tr_tran,
   tr_en_linea,         tr_banco,             tr_dias_calc,
   tr_ofi_oper,         tr_ofi_usu,           tr_usuario,        
   tr_terminal,         tr_fecha_ref,         tr_secuencial_ref, 
   tr_estado,           tr_gerente,           tr_gar_admisible,      
   tr_reestructuracion, tr_calificacion,      ---RRB:feb-14-2002 para circular 50
   tr_observacion,      tr_fecha_cont,        tr_comprobante)
   values(
   @w_secuencial,       @s_date,              @w_toperacion,
   @w_moneda,           @w_operacionca,       'IOC',
   'S',                 @i_banco,             0,
   @w_oficina,          @s_ofi,               @s_user,       
   @s_term,             @w_fecha_ult_proceso, 0,             
   'ING',               @w_gerente,           isnull(@w_gar_admisible,''),
   @w_reestructuracion, @w_calificacion,               ---RRB:feb-14-2002 para circular 50
   '',                  @s_date,              0)
      
   if @@error <> 0 begin
       select @w_error = 710001
       goto ERROR
   end
   end --FIN GENERAR TRX = SI


            
   select @w_div_actual = @w_div_desde

   while (@w_div_actual <= @w_div_hasta)  begin

      select @w_di_estado = dit_estado
      from   ca_dividendo_tmp
      where  dit_operacion = @w_operacionca
      and    dit_dividendo = @w_div_actual
	  
	  if @w_di_estado = @w_est_cancelado goto SIGUIENTE
      
      declare @w_registros int
      select @w_registros = count(1) from ca_amortizacion_tmp where  amt_operacion   = @w_operacionca
      
      select 
      @w_di_estado = amt_estado
      from ca_amortizacion_tmp
      where  amt_operacion   = @w_operacionca
      and    amt_dividendo   = @w_div_actual
      and    amt_concepto    = @i_concepto
      
      if @@rowcount <> 0 begin

         if @w_di_estado = @w_est_cancelado begin
            print 'La obligacion no puede recibir este concepto en esta cuota'
            select @w_error = 710001
            goto ERROR
         end
         
         update ca_amortizacion_tmp set    
         amt_cuota     = amt_cuota + @i_monto,
         amt_acumulado = amt_acumulado + case when @w_provisiona = 'N' then @i_monto else 0 end                                           
         where  amt_operacion   = @w_operacionca
         and    amt_dividendo   = @w_div_actual
         and    amt_concepto    = @i_concepto
         
         if @@error <> 0 begin
            select @w_error = 710002
            goto ERROR
         end 

         if @w_rubro_iva is not null begin
             
            update ca_amortizacion_tmp set    
            amt_cuota     = amt_cuota + round(@i_monto*@w_tasa_iva/100, @w_num_dec),
            amt_acumulado = amt_acumulado + case when @w_provisiona = 'N' then round(@i_monto*@w_tasa_iva/100, @w_num_dec) else 0 end
            where  amt_operacion   = @w_operacionca
            and    amt_dividendo   = @w_div_actual
            and    amt_concepto    = @w_rubro_iva
            
            if @@error <> 0 begin
               select @w_error = 710002
               goto ERROR
            end 
         end 

      end  ELSE  begin
      
         select @w_di_estado = case when @w_estado_op = @w_est_etapa2 then @w_est_vigente
                               else @w_estado_op
							   end
							   
         if @w_estado_op = @w_est_vencido select @w_di_estado = @w_est_suspenso
         
         insert into ca_amortizacion_tmp(
         amt_operacion,   amt_dividendo,  amt_concepto,
         amt_estado,      amt_periodo,    amt_cuota,
         amt_gracia,      amt_pagado,     amt_acumulado,
         amt_secuencia)
         values(
         @w_operacionca, @w_div_actual, @i_concepto,
         @w_di_estado,   0,             @i_monto,
         0,              0,             case when @w_provisiona = 'N' then @i_monto else 0 end,--@i_monto,
         1)
         
         if @@error <> 0 begin
             select @w_error = 710001
             goto ERROR
         end  
         
         
        if @w_rubro_iva is not null begin

            insert into ca_amortizacion_tmp(
            amt_operacion,   amt_dividendo,  amt_concepto,
            amt_estado,      amt_periodo,    amt_cuota,
            amt_gracia,      amt_pagado,     amt_acumulado,
            amt_secuencia)
            values(
            @w_operacionca, @w_div_actual, @w_rubro_iva,
            @w_di_estado,   0,             round(@i_monto*@w_tasa_iva/100, @w_num_dec),
            0,              0,             case when @w_provisiona = 'N' then round(@i_monto*@w_tasa_iva/100, @w_num_dec) else 0 end,
            1)
            --print'@@error ' + cast(@@error as varchar)
            if @@error <> 0 begin
               select @w_error = 710001
               goto ERROR
            end  
         end

      end
    
	  
	  
	  if @i_generar_trn = 'S' begin 
 ------------------------------------------------------------------------------------------
      select @w_codvalor = (co_codigo * 1000) + (@w_di_estado * 10)
      from   ca_concepto
      where  co_concepto = @i_concepto
      
      insert into ca_det_trn (
      dtr_secuencial, dtr_operacion,    dtr_dividendo,
      dtr_concepto,
      dtr_estado,     dtr_periodo,      dtr_codvalor,
      dtr_monto,      
      dtr_monto_mn,     
      dtr_moneda,
      dtr_cotizacion, dtr_tcotizacion,  dtr_afectacion,
      dtr_cuenta,     dtr_beneficiario, dtr_monto_cont)
      values(
      @w_secuencial,  @w_operacionca,   @w_div_actual, 
      @i_concepto,
      @w_di_estado,   0,                @w_codvalor,
      @i_monto,   
      @i_monto,         
      @w_moneda,
      @w_cotizacion,  '',               'D',
      '',             @i_comentario,    0)
      
      if @@error <> 0 begin
         select @w_error = 710001
         goto ERROR
      end

      if @w_rubro_iva is not null begin

         select @w_codvalor = (co_codigo * 1000) + (@w_di_estado * 10)
         from   ca_concepto
         where  co_concepto = @w_rubro_iva
         
         insert into ca_det_trn (
         dtr_secuencial, dtr_operacion,    dtr_dividendo,
         dtr_concepto,
         dtr_estado,     dtr_periodo,      dtr_codvalor,
         dtr_monto,      dtr_monto_mn,     dtr_moneda,
         dtr_cotizacion, dtr_tcotizacion,  dtr_afectacion,
         dtr_cuenta,     dtr_beneficiario, dtr_monto_cont)
         values(
         @w_secuencial,  @w_operacionca,   @w_div_actual,
         @w_rubro_iva,
         @w_di_estado,   0,                @w_codvalor,
         round(@i_monto*@w_tasa_iva/100, @w_num_dec),
         round(@i_monto*@w_tasa_iva/100, @w_num_dec),
         @w_moneda,
         @w_cotizacion,  '',               'D',
         '',             @i_comentario,    0)
            
         if @@error <> 0 begin
            select @w_error = 710001
            goto ERROR
         end
      end
	  end --FIN GENERAR TRX= SI
  
      SIGUIENTE:
	  
      select @w_div_actual = @w_div_actual + 1
   
   end  -- While @w_div_actual <= @w_div_hasta
      
   select @w_valor_tot = isnull(sum(oc_monto),0)
   from   ca_otro_cargo
   where  oc_operacion  = @w_operacionca
   and    oc_secuencial = @w_secuencial
   and    oc_concepto   = @i_concepto
      
      
   if exists (select 1 from ca_rubro_op_tmp
   where  rot_operacion = @w_operacionca
   and    rot_concepto    = @i_concepto)
   begin
   
      update ca_rubro_op_tmp set
      rot_valor           = rot_valor + @w_valor_tot,
      rot_saldo_op        = @i_saldo_op,
      rot_saldo_por_desem = @i_saldo_por_desem,
      rot_base_calculo    = @i_base_calculo,
      rot_porcentaje      = @i_tasa,
      rot_porcentaje_aux  = @i_tasa
      where  rot_operacion = @w_operacionca
      and    rot_concepto  = @i_concepto
      
      if @@error <> 0 begin
          select @w_error = 710002
          goto ERROR
      end  

   end ELSE begin

      insert into ca_rubro_op_tmp(
      rot_operacion,            rot_concepto,        rot_tipo_rubro,
      rot_fpago,                rot_prioridad,       rot_paga_mora,
      rot_provisiona,           rot_signo,           rot_factor,
      rot_referencial,          rot_signo_reajuste,  rot_factor_reajuste,
      rot_referencial_reajuste, rot_valor,           rot_porcentaje,
      rot_porcentaje_aux,       rot_gracia,          rot_concepto_asociado,
      rot_principal,            rot_porcentaje_efa,  rot_garantia,
      rot_saldo_op,             rot_saldo_por_desem, rot_base_calculo,
      rot_num_dec)
      select 
      @w_operacionca,          ru_concepto,        ru_tipo_rubro,
      ru_fpago,                ru_prioridad,       ru_paga_mora,
      ru_provisiona,           '+',                0,
      ru_referencial,          '+',                0,
      null,                    @i_monto,           @i_tasa,
      @i_tasa,                 0,                  null,
      ru_principal,            0,                  0,
      @i_saldo_op,             @i_saldo_por_desem, @i_base_calculo,
      @w_num_dec
      from   ca_rubro       
      where  ru_toperacion  = @w_toperacion
      and    ru_moneda      = @w_moneda
      and    ru_concepto    = @i_concepto
     
      if @@error <> 0 begin
          select @w_error = 710001
          goto ERROR
      end  

   end

   if @w_rubro_iva is not null begin

      select @w_valor_tot = isnull(sum(amt_cuota),0)
      from   ca_amortizacion_tmp
      where  amt_operacion  = @w_operacionca
      and    amt_concepto   = @w_rubro_iva
       
       
      if exists (select 1 from   ca_rubro_op_tmp
      where  rot_operacion = @w_operacionca
      and    rot_concepto    = @w_rubro_iva)
      begin
       
         update ca_rubro_op_tmp set    
         rot_valor           = @w_valor_tot,
         rot_saldo_op        = @i_saldo_op,
         rot_saldo_por_desem = @i_saldo_por_desem,
         rot_base_calculo    = @i_base_calculo
         where  rot_operacion = @w_operacionca
         and    rot_concepto  = @w_rubro_iva
         
         if @@error <> 0
         begin
            select @w_error = 710002
            goto ERROR
         end  

      end ELSE begin

         insert into ca_rubro_op_tmp(
         rot_operacion,            rot_concepto,        rot_tipo_rubro,
         rot_fpago,                rot_prioridad,       rot_paga_mora,
         rot_provisiona,           rot_signo,           rot_factor,
         rot_referencial,          rot_signo_reajuste,  rot_factor_reajuste,
         rot_referencial_reajuste, rot_valor,           rot_porcentaje,
         rot_porcentaje_aux,       rot_gracia,          rot_concepto_asociado,
         rot_principal,            rot_porcentaje_efa,  rot_garantia,
         rot_saldo_op,             rot_saldo_por_desem, rot_base_calculo,
         rot_num_dec)
         select
         @w_operacionca,          ru_concepto,        ru_tipo_rubro,
         ru_fpago,                ru_prioridad,       ru_paga_mora,
         ru_provisiona,           '+',                0,
         ru_referencial,          '+',                0,
         null,                    @w_valor_tot,       @w_tasa_iva,
         @w_tasa_iva,             0,                  ru_concepto_asociado,
         ru_principal,            0,                  0,
         @i_saldo_op,             @i_saldo_por_desem, @i_base_calculo,
         @w_num_dec
         from   ca_rubro       
         where  ru_toperacion  = @w_toperacion
         and    ru_moneda      = @w_moneda
         and    ru_concepto    = @w_rubro_iva
         
         if @@error <> 0 begin
             select @w_error = 710001
             goto ERROR
         end
      end
   end
   
   --FI JSA 20170518 CALCULO IVA_CMORA
   select @o_sec_tran = @w_secuencial
   
   if @w_commit = 'S' begin
      select @w_commit = 'N'
      commit tran 
   end
   
   if @i_temporal = 'N'
   begin
      exec @w_return = cob_cartera..sp_pasodef
           @i_banco           = @i_banco,
           @i_operacionca     = 'S',
           @i_dividendo       = 'S',
           @i_amortizacion    = 'S',
           @i_cuota_adicional = 'S',
           @i_rubro_op        = 'S' 
   end
end


---DEF:7428:NOV:09:2006:EPB
if @i_operacion = 'P'
begin
   --VALIDACION DEL DIVIDENDO REGISTRADO POR EL USUARIO
   
   select @w_divi_vigente  = di_dividendo
   from   ca_dividendo
   where  di_operacion= @w_operacionca
   and    di_estado   = 1
   
   if  @i_div_desde < @w_divi_vigente
   begin
      select @w_error = 711011
      goto ERROR
   end
   
   
   select @w_max_dividendo = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @w_operacionca

   if  @i_div_hasta > @w_max_dividendo
   begin
      --PRINT 'ATENCIONN!!!.. el dividendo hasta no puede ser mayor que el ultimo dividendo'
      select @w_error = 711011
      goto ERROR
   end

   -- REQ 175: PEQUEÑA EMPRESA - CONTROL DE INGRESO DE IOCS EN DIVIDENDOS CON GRACIA DE INTERES
   if @w_div_hasta <= @w_gracia_int or @w_div_desde <= @w_gracia_int
   begin
      select @w_error = 721325
      goto ERROR
   end
    
   update ca_otro_cargo set
   oc_div_desde = @i_div_desde,
   oc_div_hasta = @i_div_hasta
   where  oc_operacion = @w_operacionca
   and    oc_secuencial = @i_sec_act
end


return 0

ERROR:

if @w_commit = 'S' begin
   select @w_commit = 'N'
   rollback tran
end

if @i_en_linea = 'S'
begin
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error
end


return @w_error


go

