/************************************************************************/
/*   Archivo:              constran.sp                                  */
/*   Stored procedure:     sp_consultar_transacciones                   */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Francisco Yacelga                            */
/*   Fecha de escritura:   25/Nov./1997                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                             PROPOSITO                                */
/*   Consulta de los datos de una operacion                             */
/************************************************************************/ 
/*                             CAMBIOS                                  */
/* 04/10/2010         Yecid Martinez     Fecha valor baja Intensidad    */
/*                                       NYMR 7x24                      */
/************************************************************************/

use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_consultar_transacciones')
   drop proc sp_consultar_transacciones
go

create proc sp_consultar_transacciones (
   @s_user              login       = null,
   @s_date              datetime    = null,
   @s_term              descripcion = null,
   @s_ofi               smallint    = null,
   @i_operacion         char(1)     = null,
   @i_formato_fecha     int         = 103,
   @i_fecha_desde       datetime    = null,
   @i_fecha_hasta       datetime    = null,
   @i_banco             cuenta      = null,
   @i_oficina           smallint    = null,
   @i_tipo              varchar(10) = null,
   @i_usuario           varchar(10) = null,
   @i_toperacion        catalogo    = null,
   @i_monto             money       = null, 
   @i_estado            varchar(10) = null,   
   @i_concepto          catalogo    = null,
   @i_siguiente         int         = 0
)

as declare
   @w_sp_name        varchar(32),
   @w_error          int,
   @w_opcion         int,
   @w_operacionca    int,
   @w_trubro         catalogo,
   @w_codvalor       int,
   @w_testado        varchar(30), 
   @w_tperiodo       tinyint, 
   @w_tmoneda        varchar(30), 
   @w_tmonto         float, 
   @w_tmonto_mn      float, 
   @w_tcod_moneda    tinyint, 
   @w_tcotizacion    float, 
   @w_treferencia    varchar(30),
   @w_tbeneficiario  varchar(64),
   @w_num_dec        tinyint,
   @w_op_moneda      int,
   @w_op_oficina     int,
   @w_toperacion     catalogo,
   @w_return	     int

select @w_sp_name = 'sp_consultar_transacciones'

if @i_banco is null begin
   select @w_error =  710517
   goto ERROR
end

/* Seleccion datos de operacion */
select 
@w_operacionca = op_operacion,
@w_op_moneda   = op_moneda,
@w_op_oficina  = op_moneda,
@w_toperacion  = op_toperacion
from   ca_operacion
where  op_banco = @i_banco
   
   
if @i_operacion = 'Q' or @i_operacion='C' begin

   if isnull(@i_tipo,'XXX') <> 'PRV' begin
   
      select  
      fecha_mov   = tr_fecha_mov,
      fecha_ref   = tr_fecha_ref,
      ofi_usu     = tr_ofi_usu,
      trans       = tr_tran,
      estado      = tr_estado,
      usuario     = tr_usuario,
      terminal    = tr_terminal,
      observacion = tr_observacion,
      comprobante = tr_comprobante,
      operacion   = tr_operacion,
      secuencial  = tr_secuencial
      into #transacciones
      from ca_transaccion
      where tr_banco       = @i_banco
      and   tr_secuencial  > 0
      and   tr_tran   not in ('PRV','HFM')
      and   tr_secuencial > @i_siguiente 
      and  (tr_fecha_mov  >= @i_fecha_desde  or @i_fecha_desde is null)
      and  (tr_fecha_mov  <= @i_fecha_hasta  or @i_fecha_hasta is null)
      and  (tr_ofi_usu     = @i_oficina      or @i_oficina     is null)
      and  (tr_tran        = @i_tipo         or @i_tipo        is null)
      and  (tr_usuario     = @i_usuario      or @i_usuario     is null)
      and  (tr_estado      = @i_estado       or @i_estado      is null)

    end else begin

      select
      fecha_mov  = tp_fecha_mov,
      fecha_ref  = tp_fecha_ref,
      dividendo  = tp_dividendo,
      concepto   = tp_concepto,
      codvalor   = tp_codvalor,
      estado     = tp_estado,
      monto      = sum(tp_monto),
      secuencial = 9900000 + tp_dividendo + tp_secuencia  -- + tp_codvalor
      into #transacciones_prv
      from ca_transaccion_prv
      where tp_operacion = @w_operacionca
      and  (tp_fecha_mov  >= @i_fecha_desde  or @i_fecha_desde is null)
      and  (tp_fecha_mov  <= @i_fecha_hasta  or @i_fecha_hasta is null)
      and  (tp_estado      = @i_estado       or @i_estado      is null)
      group by tp_fecha_mov, tp_fecha_ref, tp_dividendo, tp_concepto, tp_codvalor, tp_estado, tp_secuencia
      order by tp_fecha_mov, tp_fecha_ref, tp_dividendo, tp_concepto, tp_codvalor, tp_estado, tp_secuencia


    end

end 


if @i_operacion = 'Q' begin


   --PRINT '--INICIO NYMR 7x24 Ejecuto FECHA VALOR BAJA INTENSIDAD ' + CAST(@w_operacionca as varchar)
  
   EXEC @w_return = sp_validar_fecha
      @s_user                  = @s_user,
      @s_term                  = @s_term,
      @s_date                  = @s_date ,
      @s_ofi                   = @s_ofi,
      @i_operacionca           = @w_operacionca,
      @i_debug                 = 'N' 

   if @w_return <> 0 
   begin
      select @w_error = @w_return 
      goto ERROR
   end






   if isnull(@i_tipo,'XXX') <> 'PRV' begin

      set rowcount 25

      if @i_monto is not null begin
      
         select distinct
         'Fecha   '           = convert(varchar,fecha_mov,@i_formato_fecha),
         'Oficina'            = ofi_usu,
         'Tipo'               = trans,
         'Linea de Credito'   = @w_toperacion,
         'Estado'             = estado,          
         'No. Operacion'      = @i_banco,
         'Usuario'            = substring(usuario,1,10),
         'Terminal'           = substring(terminal,1,12),
         'Observacion'        = substring(observacion,1,30),
         'Comprob. Contable'  = comprobante,                ---cualquier campo adicional se debera ingresar antes de Secuencial_Tran, caso contrario se debera modificar el front-end
         'Secuencial_Tran'    = secuencial
         from #transacciones, ca_det_trn
         where operacion      = dtr_operacion
         and   secuencial     = dtr_secuencial
         and  (dtr_monto      = @i_monto        or @i_monto       is null)
         and   secuencial > @i_siguiente
         order by  secuencial
      
         if @@rowcount = 0 begin
            set rowcount 0
            select @w_error = 710026
            goto ERROR
         end

      end else begin

         select distinct
         'Fecha   '           = convert(varchar,fecha_mov,@i_formato_fecha),
         'Oficina'            = ofi_usu,
         'Tipo'               = trans,
         'Linea de Credito'   = @w_toperacion,
         'Estado'             = estado,          
         'No. Operacion'      = @i_banco,
         'Usuario'            = substring(usuario,1,10),
         'Terminal'           = substring(terminal,1,12),
         'Observacion'        = substring(observacion,1,30),
         'Comprob. Contable'  = comprobante,                ---cualquier campo adicional se debera ingresar antes de Secuencial_Tran, caso contrario se debera modificar el front-end
         'Secuencial_Tran'    = secuencial
         from #transacciones
         where secuencial > @i_siguiente
         order by  secuencial
      
         if @@rowcount = 0 begin
            set rowcount 0
            select @w_error = 710026
            goto ERROR
         end

      end
      
      set rowcount 0
        
   end else begin
   
  
      set rowcount 30
      
      select distinct
      'Fecha   '           = convert(varchar,fecha_mov,@i_formato_fecha),
      'Fecha Valor'        = convert(varchar,fecha_ref,@i_formato_fecha),
      'Oficina'            = @w_op_oficina,
      'Tipo'               = 'PRV',
      'Linea de Credito'   = @w_toperacion,    
      'No. Operacion'      = @i_banco,  
      'Cuota'              = dividendo,
      'Clase'              = op_sector,
      'Estado'             = estado , 
      'Monto'              = sum(monto),    ---cualquier campo adicional se debera ingresar antes de Secuencial_Tran, caso contrario se debera modificar el front-end
      'Secuencial_Tran'    = secuencial
      from #transacciones_prv, ca_operacion
      where secuencial > @i_siguiente
      and   op_banco   = @i_banco
      group by fecha_mov, fecha_ref, secuencial, estado, dividendo, op_sector
      order by  secuencial
      
      if @@rowcount = 0 begin
         set rowcount 0
         select @w_error = 710026
         goto ERROR
      end
      
      set rowcount 0

      
   end 

end


/* CALCULO DE LOS TOTALES SELECCIONADOS */

if @i_operacion='C' begin

   if isnull(@i_tipo,'XXX') <> 'PRV' begin

      select 
      'Rubro'    = dtr_concepto,
      'Cuota'    = isnull(dtr_dividendo,0),
      'CodValor' = dtr_codvalor,
      'Moneda'   = dtr_moneda,
      'Monto'    = sum(dtr_monto), 
      'Monto MN' = sum(dtr_monto_mn)
      from #transacciones, ca_det_trn
      where operacion      = dtr_operacion
      and   secuencial     = dtr_secuencial
      group by dtr_concepto, dtr_codvalor, dtr_moneda,isnull(dtr_dividendo,0)
      having abs(sum(dtr_monto)) >= 0.01
      order by dtr_codvalor
       
   end else begin
   
      select 
      'Rubro'    = concepto,
      'Estado'   = estado,
      'CodValor' = codvalor,
      'Moneda'   = @w_op_moneda,
      'Monto'    = sum(monto), 
      'Monto MN' = sum(monto)
      from #transacciones_prv
      group by concepto, codvalor, estado
      having abs(sum(monto)) >= 0.01
      order by codvalor

   end
 
   set rowcount 0
end

/* DETALLE DE LA TRANSACCION */
if @i_operacion = 'S' begin

   
   if @i_siguiente between 20000000 and 20990000 return 0
   
   if exists ( select 1 from ca_det_trn
               where dtr_operacion  = @w_operacionca
               and   dtr_secuencial = @i_siguiente
               and   dtr_monto     <> 0
             )
      select 
      'Rubro'        = dtr_concepto,
      'Monto'        = dtr_monto, 
      'Monto MN'     = dtr_monto_mn,
      'Moneda'       = dtr_moneda,
      'Cotizacion'   = dtr_cotizacion, 
      'Ref/Cta'      = dtr_cuenta,
      'Beneficiario' = dtr_beneficiario,
      'Estado'       = dtr_estado,
      'Codigo Valor' = dtr_codvalor
      from ca_det_trn
      where dtr_operacion  = @w_operacionca
      and   dtr_secuencial = @i_siguiente
      and   dtr_monto     <> 0
      
   else
   
      select 
      'Rubro'        = tp_concepto,
      'Monto'        = tp_monto, 
      'Monto MN'     = tp_monto,
      'Moneda'       = op_moneda,
      'Cotizacion'   = 0, 
      'Ref/Cta'      = op_banco,
      'Beneficiario' = op_nombre,
      'Estado'       = tp_estado,
      'Codigo Valor' = tp_codvalor
      from ca_transaccion_prv, ca_operacion
      where tp_operacion  = @w_operacionca
      and   tp_operacion  = op_operacion
      and   @i_siguiente = 9900000 + tp_dividendo + tp_secuencia -- + tp_codvalor
      and   tp_monto     <> 0 
   
end

return 0

ERROR:

exec cobis..sp_cerror
@t_debug = 'N',
@t_from  = @w_sp_name,
@i_num   = @w_error

return @w_error

go


/***********

exec cob_cartera..sp_consultar_transacciones
@s_user   = 'fdlt',
@i_banco  = '100010000030' ,
@i_operacion = 'Q'

exec cob_cartera..sp_consultar_transacciones
@s_user   = 'fdlt',
@i_banco  = '100010000030' ,
@i_operacion = 'C'

exec cob_cartera..sp_consultar_transacciones
@s_user   = 'fdlt',
@i_banco  = '100010000030',
@i_tipo   = 'PRV',
@i_operacion = 'Q',
@i_siguiente = 19

exec cob_cartera..sp_consultar_transacciones
@s_user   = 'fdlt',
@i_banco  = '100010000030',
@i_tipo   = 'PRV',
@i_operacion = 'C'

exec cob_cartera..sp_consultar_transacciones
@s_user   = 'fdlt',
@i_banco  = '100010000030',
@i_siguiente   = 1,
@i_operacion = 'S'

set rowcount 100
select * from ca_transaccion_prv

*******/