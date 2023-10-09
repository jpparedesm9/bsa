USE cob_cartera
GO

IF EXISTS(SELECT 1 FROM sysobjects where name = 'sp_castigo_automatico')
    DROP PROC sp_castigo_automatico
GO

/*************************************************************************/  
/*   Archivo:              ca_castigo_automatico.sp	                     */
/*   Stored procedure:     sp_castigo_automatico                         */
/*   Base de datos:        cob_cartera                                   */
/*   Producto:             Cartera                                       */
/*   Disenado por:         Jose Luis Calvillo                            */
/*   Fecha de escritura:   Marzo 2019                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Caatigar operaciones vencidas de acuerdo a la tabla de parametros   */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    13/Marzo/2019         JLCC              emision inicial            */
/*    12/Abril/2019         JLCC              Se ajusta consulta que     */
/*										   obtiene créditos a castigar   */
/*    31/Ago/2020           DCU            Caso: 145246 Calculo dias mora*/
/*    03/09/2020            DCU            Caso:  147123                 */
/*************************************************************************/

CREATE PROC sp_castigo_automatico
(
@i_param1   datetime,
@i_en_linea char(1)='N'
)
as
declare

@w_est_castigo    int,
@w_est_anulado    int,
@w_est_vencido    int,
@w_estado_ini     int,
@w_operacionca    int,                     
@w_estado         tinyint,
@w_error          int,
@w_cambio         int,
@w_return         int,
@w_num_error      int, 
@w_sp_name        varchar(50),
@w_msg            varchar(200),
@w_fecha_proceso  datetime,
@w_oficina        int,
@w_toperacion     catalogo,
@w_banco          cuenta,
@w_moneda         int,
@w_dmora_pven_cuo    int,
@w_min_di_fecha_ven  datetime,
@w_ciudad_nacional   int,
@w_dias_mora         int,
@w_fecha_ult_proceso datetime,
@w_dias_desplaza     int

select 
@w_sp_name       = 'sp_castigo_automatico',
@w_fecha_proceso = @i_param1

exec @w_error    = sp_estados_cca
@o_est_castigado = @w_est_castigo   out,
@o_est_anulado   = @w_est_anulado   out, 
@o_est_vencido   = @w_est_vencido   out 

--PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'



select distinct
	operacion  = op_operacion,
    estado     = op_estado,
    oficina    = op_oficina,
    toperacion = op_toperacion,
    banco      = op_banco,
    moneda     = op_moneda,
    fecha_ult_proceso = op_fecha_ult_proceso
into  #operacion_castigo
from ca_estados_man, ca_operacion, ca_dividendo
where em_tipo_cambio = 'A'
    and em_estado_fin = @w_est_castigo
    and em_toperacion = op_toperacion
    and em_estado_ini  = op_estado
    and op_operacion = di_operacion
    and di_estado = 2
    and datediff(dd,di_fecha_ven, @w_fecha_proceso) >= em_dias_cont
       
if @@ROWCOUNT=0 return 
 
--cursor--
while 1=1
begin  

   select top 1  
   @w_operacionca = operacion,   
   @w_estado      = estado,
   @w_oficina     = oficina,
   @w_toperacion  = toperacion,
   @w_banco       = banco,
   @w_moneda      = moneda,
   @w_fecha_ult_proceso = fecha_ult_proceso
   from #operacion_castigo

   if @@ROWCOUNT=0 break
   
   
   select @w_dmora_pven_cuo = em_dias_cont
   from  cob_cartera..ca_estados_man
   where em_toperacion  = @w_toperacion
   and   em_tipo_cambio = 'A'
   and em_estado_ini    = @w_estado       --Estado de la operacion
   and em_estado_fin    = @w_est_castigo

   
   select @w_min_di_fecha_ven = min(di_fecha_ven)
   from   ca_dividendo  with (nolock)
   where  di_operacion = @w_operacionca
   and    di_estado    = @w_est_vencido
	   
   exec @w_error = sp_dia_habil 
   @i_fecha  = @w_min_di_fecha_ven,
   @i_ciudad = @w_ciudad_nacional,
   @o_fecha  = @w_min_di_fecha_ven out
   
   
   select @w_dias_mora = 0
   
   select 
   di_operacion,
   dias_360 = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_ult_proceso), @w_fecha_ult_proceso),
   fecha_ven_ini = min(di_fecha_ven),
   dias_restar   = convert(int,0)
   into #operacion_vencida
   from ca_dividendo
   where di_operacion = @w_operacionca
   and   di_estado    = @w_est_vencido
   group by  di_operacion
       
       
   update #operacion_vencida set 
   dias_360 = 0
   where dias_360 <0  
       
   select d.*
   into #desplazamiento
   from ca_desplazamiento d
   where de_operacion = @w_operacionca
   and   de_estado    = 'A'
   and   de_archivo   <> 'WORKFLOW'

   select de_operacion,
   de_fecha_ini, 
   dias = case when de_fecha_fin>= @w_fecha_ult_proceso then
          datediff(dd,de_fecha_ini, @w_fecha_ult_proceso)
          else 
          datediff(dd,de_fecha_ini, de_fecha_fin) end
   into #dias_restar            
   from #desplazamiento
   where de_operacion = @w_operacionca
   and   de_estado    = 'A'
       
   select de_operacion, dias = sum(dias)
   into #reales
   from #operacion_vencida, #dias_restar
   where de_operacion   = di_operacion
   and   fecha_ven_ini <= de_fecha_ini
   group by de_operacion
       
   update #operacion_vencida
   set dias_restar= isnull(dias,0)
   from #reales
   where di_operacion = de_operacion
       
   select
   di_operacion, 
   dias_360= dias_360 - isnull(dias_restar,0)
   into #actualizacion_vencida
   from #operacion_vencida

   select @w_dias_mora =dias_360
   from #actualizacion_vencida
   
   
   print 'Banco: ' + @w_banco + ' Numero dias: ' + convert(varchar, @w_dias_mora)
   
  
   if @w_dias_mora >= @w_dmora_pven_cuo
   begin
      exec @w_return   = sp_cambio_estado_manual
      @s_user          = 'userbatch',
      @s_term          = '',         
      @s_date          = @w_fecha_proceso,          
      @s_ofi           = @w_oficina,           
      @i_toperacion    = @w_toperacion,    
      @i_oficina       = @w_oficina,       
      @i_banco         = @w_banco,             
      @i_moneda        = @w_moneda,         
      @i_fecha_proceso = @w_fecha_proceso,  
      @i_en_linea      = @i_en_linea,       
      @i_gerente       = 0,          
      @i_moneda_nac    = @w_moneda,  
      @i_estado_ini    = @w_estado,     
      @i_estado_fin    = @w_est_castigo,
      @i_operacionca   = @w_operacionca 
      
      --sp error log-- 
      if @w_error <> 0
      begin
         select @w_msg ='ERROR AL EJECUTAR SP_CAMBIO_MANUAL'
     
         exec @w_error=sp_errorlog 
         @i_fecha     = @w_fecha_proceso,
         @i_error     = @w_num_error, 
         @i_usuario   = 'usrbatch', 
         @i_tran      = 7999,
         @i_tran_name = @w_sp_name,
         @i_cuenta    = @w_banco,
         @i_anexo     = @w_msg,
         @i_rollback  = 'N'
      end
   end
   
   delete #operacion_castigo  
   where operacion =@w_operacionca
   
   drop table #operacion_vencida
   drop table #desplazamiento
   drop table #dias_restar
   drop table #reales
   drop table #actualizacion_vencida
end 

return 0

go
