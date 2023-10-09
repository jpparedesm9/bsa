/************************************************************************/
/*   Archivo:              comdiferida.sp                               */
/*   Stored procedure:     sp_comision_diferida                         */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Roxana Sánchez Orozco                        */
/*   Fecha de escritura:   Diciembre 05-2016                            */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Apropiación de comisiones de otorgamiento.                         */
/*      en Desembolso, Provisión, en las cancelaciones y las            */
/*      operaciones castigadas en la integración.                       */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/************************************************************************/
/*        FECHA                AUTOR                CAMBIO              */
/*      05/12/2016          R. Sánchez            Emision Inicial       */
/************************************************************************/
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_comision_diferida')
   drop proc sp_comision_diferida 
go

create proc sp_comision_diferida 
   @s_date              smalldatetime = null,
   @i_operacion         char(1)       ,
   @i_operacionca       int           ,
   @i_secuencial_ref    int           = 0

as
declare
   @w_sp_name                      varchar(32),
   @w_error                        int,
   @w_dias                         int,
   @w_fecha_ult_proceso            smalldatetime,
   @w_num_dec_op                   int,
   @w_moneda_mn                    int,
   @w_num_dec_n                    int,
   @w_est_cancelado                int,
   @w_moneda_op                    int,
   @w_valor                        money,
   @w_oficina_op                   int
   

-- CAPTURA NOMBRE DE STORED PROCEDURE
select   @w_sp_name = 'sp_comision_diferida'


/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out

if @i_operacion = 'L' begin

   -- INSERCION DE REGISTRO DE LA COMISION DIFERIDA
   insert into ca_comision_diferida (
   cd_operacion, cd_concepto,      cd_cuota,
   cd_acumulado, cd_estado,        cd_cod_valor )
   select 
   ro_operacion, ro_concepto,      ro_valor,
   0,            @w_est_cancelado, (co_codigo * 1000 + @w_est_cancelado * 10)
   from cob_cartera..ca_rubro_op,cob_cartera..ca_concepto
   where ro_operacion = @i_operacionca 
   and co_concepto    = ro_concepto 
   and ro_fpago       = 'L' 
   and co_categoria   = 'O' 
       
   if @@error <> 0 begin
     select @w_error = 710001
     goto ERROR
   end
end


if @i_operacion in  ('P','A')  begin
   
   if not exists (
   select 1 from cob_cartera..ca_comision_diferida
   where cd_operacion =@i_operacionca )
      return 0
   
   select 
   @w_dias              = datediff(dd,op_fecha_ult_proceso,op_fecha_fin),
   @w_fecha_ult_proceso = op_fecha_ult_proceso,
   @w_moneda_op         = op_moneda,
   @w_oficina_op        = op_oficina
   from ca_operacion 
   where op_operacion = @i_operacionca
   
   if @i_operacion = 'A' 
      select @w_dias = 0
   else
      select @i_secuencial_ref = 0
      
   
   -- LECTURA DE DECIMALES
   exec @w_error = sp_decimales
   @i_moneda       = @w_moneda_op,
   @o_decimales    = @w_num_dec_op out,
   @o_mon_nacional = @w_moneda_mn  out,
   @o_dec_nacional = @w_num_dec_n  out

   select 
   operacion = cd_operacion , 
   concepto  = cd_concepto, 
   valor     = case when @w_dias = 0 then (cd_cuota - cd_acumulado) else round(((cd_cuota - cd_acumulado)/@w_dias),@w_num_dec_op) end, 
   estado    = cd_estado,
   cod_valor = cd_cod_valor   
   into #ca_comison_tmp 
   from ca_comision_diferida
   where cd_operacion = @i_operacionca
   
   if @@error <> 0 begin
     select @w_error = 710001
     goto ERROR
   end
    
   update ca_comision_diferida
   set    cd_acumulado = (cd_acumulado + valor)
   from  #ca_comison_tmp 
   where  cd_operacion  = operacion
   and    cd_concepto   = concepto
   and    cd_estado     = estado
  
   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end  
  
   insert into ca_transaccion_prv (
   tp_fecha_mov,      tp_operacion,   tp_fecha_ref,
   tp_secuencial_ref, tp_estado,      tp_comprobante,
   tp_fecha_cont,     tp_dividendo,   tp_concepto,
   tp_codvalor,       tp_monto,       tp_secuencia,
   tp_ofi_oper)   
   select 
   @s_date,           operacion,      @w_fecha_ult_proceso,
   @i_secuencial_ref, 'ING',          0,
   NULL,              1,              concepto,
   cod_valor,         valor,          1,
   @w_oficina_op
   from  #ca_comison_tmp 
   where operacion = @i_operacionca
   
   if @@error <> 0 begin
     select @w_error = 710001
     goto ERROR
   end
   
end

return 0

ERROR:
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error
   return @w_error  
go