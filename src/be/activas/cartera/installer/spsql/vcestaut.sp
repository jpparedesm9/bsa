

/************************************************************************/
/*   Archivo:              vcestaut.sp                                  */
/*   Stored procedure:     sp_veri_cambio_est_automatico                */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         Raul Altamirano Mendez                       */
/*   Fecha de escritura:   Dic-19-2016                                  */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Realiza verificaciones necesarias para efectuar cambios de estado  */
/*   automaticos de vigente a vencido y viceversa                       */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-19-2016    Raul Altamirano   Emision Inicial - Version MX   */
/*      JUN-10-2019    SMO      Consulta de tabla de cambio de estados  */
/*      JUL-07-2020    AGO      #142173  DIAS DE DESPLAZAMIENTO         */
/*      03/09/2020     DCU      Caso:  147123                           */
/*   NOV-2021      Andy G.          Req. 170130 Nuevos Estados CCA      */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_veri_cambio_est_automatico')
   drop proc sp_veri_cambio_est_automatico
go

SET ANSI_NULLS ON
GO

create proc sp_veri_cambio_est_automatico(
   @s_user                login,
   @s_term                varchar(30),
   @s_date                datetime,
   @s_ofi                 smallint,
   @i_operacionca         int,
   @i_debug               char(1) = 'N',
   @o_msg                 varchar(100) = null out) 

as 
declare
@w_return                int,
@w_sp_name               varchar(30),
@w_error                 int,
@w_estado                int,
@w_est_cancelado         tinyint,
@w_est_vigente           tinyint,
@w_est_vencido           tinyint,
@w_fecha_ult_proceso     datetime,
@w_banco                 cuenta,
@w_operacionca           int,
@w_min_di_fecha_ven      datetime,
@w_dias_mora             smallint,
@w_dmora_pven_cuo  tinyint,
@w_dmora_paso_vencido    tinyint,
@w_ciudad_nacional       int,
@w_cambio_estado         char(1),
@w_verifica_mora         smallint,
@w_estado_ini            tinyint,
@w_estado_fin            tinyint,
@w_commit                char(1),
@w_toperacion            varchar(10),
@w_dias_desplazamiento   int ,
@w_est_etapa1            int ,
@w_est_etapa2            int ,
@w_est_etapa3            int, 
@w_dmora_etapa1_2_cuo    int ,
@w_dmora_etapa2_3_cuo    int , 
@w_dmora_paso_etapa1     int, 
@w_dmora_paso_etapa2     int

select @w_commit = 'N'

 
select @w_toperacion = op_toperacion
from cob_cartera..ca_operacion
where op_operacion=@i_operacionca

--PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@rowcount = 0 begin
   select @w_error = 101024
   goto ERROR
end

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_etapa2     = @w_est_etapa2    out
if @@error <> 0  begin
   select @w_error = 710001, @o_msg = 'NO ENCONTRARON ESTADOS PARA CARTERA'
   goto ERROR
end





--DIAS MORA PARA PASAR DE ESTADO ETAPA VIGENTE  A ETAPA 1 
select @w_dmora_etapa1_2_cuo = em_dias_cont
from  cob_cartera..ca_estados_man
where em_toperacion  = @w_toperacion
and   em_tipo_cambio = 'A'
and em_estado_ini    = @w_est_vigente
and em_estado_fin    = @w_est_etapa2


---DIAS DE MORA PARA PASAR A ETAPA 3 (VENCIDO)
select @w_dmora_pven_cuo = em_dias_cont
from  cob_cartera..ca_estados_man
where em_toperacion  = @w_toperacion
and   em_tipo_cambio = 'A'
and em_estado_ini    = @w_est_etapa2
and em_estado_fin    = @w_est_vencido





 
select 
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_banco             = op_banco,
@w_estado            = op_estado,
@w_operacionca       = op_operacion
from   ca_operacion
where  op_operacion = @i_operacionca

if @@rowcount = 0                
   return 0

select 
@w_estado_ini = @w_estado,
@w_cambio_estado = 'N'



if @w_estado_ini = @w_est_vigente  --ESTADO INICIAL DE LA OPERACION ESTADO 1 
begin
   if (select count(1) from ca_dividendo with (nolock)
       where  di_operacion = @w_operacionca
       and    di_estado    = @w_est_vigente) > 0        
   begin   
       select @w_min_di_fecha_ven = min(di_fecha_ven)
       from   ca_dividendo  with (nolock)
       where  di_operacion = @w_operacionca
       and    di_estado = @w_est_vencido
	   
	   exec @w_error = sp_dia_habil 
       @i_fecha  = @w_min_di_fecha_ven,
       @i_ciudad = @w_ciudad_nacional,
       @o_fecha  = @w_min_di_fecha_ven out
 
       if @w_error <> 0 goto ERROR

       select @w_dias_mora = 0
       
       
       select 
       di_operacion,
       dias_360 = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_ult_proceso), @w_fecha_ult_proceso),
       fecha_ven_ini = min(di_fecha_ven),
       dias_restar   = convert(int,0)
       into #operaciones_vencida
       from ca_dividendo
       where di_operacion = @w_operacionca
       and   di_estado    = @w_est_vencido
       group by  di_operacion
       
       
       update #operaciones_vencida set 
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
       from #operaciones_vencida, #dias_restar
       where de_operacion   = di_operacion
       and   fecha_ven_ini <= de_fecha_ini
       group by de_operacion
       
       update #operaciones_vencida
       set dias_restar= isnull(dias,0)
       from #reales
       where di_operacion = de_operacion
       
       select
       di_operacion, 
       dias_360= dias_360 - isnull(dias_restar,0)
       into #actualizacion_vencida
       from #operaciones_vencida

       --select * from #actualizacion_vencida

       select @w_dias_mora =dias_360
       from #actualizacion_vencida
       
       select @w_verifica_mora = @w_dias_mora % 30  --Considerar meses de 30 dias
   
       select @w_dmora_paso_etapa2 = @w_dmora_etapa1_2_cuo
	    
       
       --print '@w_dias_mora:' + convert(varchar, @w_dias_mora)
       --print '@w_dmora_pven_cuo:' + convert(varchar, @w_dmora_pven_cuo)
	   --print '@w_dmora_paso_vencido:' + convert(varchar, @w_dmora_paso_vencido) 	    
       print 'Banco: ' + @w_banco + ' Numero dias: ' + convert(varchar, @w_dias_mora)
     
       if @w_dias_mora >= @w_dmora_paso_etapa2
          select 
          @w_estado_fin = @w_est_etapa2,
          @w_cambio_estado = 'S'
   end
end 
else
   select 
   @w_estado_fin = @w_est_vigente,
   @w_cambio_estado = 'S'
   
   
   

if @w_estado_ini = @w_est_etapa2
begin
   if (select count(1) from ca_dividendo with (nolock)
       where  di_operacion = @w_operacionca
       and    di_estado    = @w_est_vencido) > 0        
   begin   
       select @w_min_di_fecha_ven = min(di_fecha_ven)
       from   ca_dividendo  with (nolock)
       where  di_operacion = @w_operacionca
       and    di_estado = @w_est_vencido
	   
	   exec @w_error = sp_dia_habil 
       @i_fecha  = @w_min_di_fecha_ven,
       @i_ciudad = @w_ciudad_nacional,
       @o_fecha  = @w_min_di_fecha_ven out
 
       if @w_error <> 0 goto ERROR

       select @w_dias_mora = 0
       
       
       select 
       di_operacion,
       dias_360 = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_ult_proceso), @w_fecha_ult_proceso),
       fecha_ven_ini = min(di_fecha_ven),
       dias_restar   = convert(int,0)
       into #operaciones_vencida2
       from ca_dividendo
       where di_operacion = @w_operacionca
       and   di_estado    = @w_est_vencido
       group by  di_operacion
       
       
       update #operaciones_vencida2 set 
       dias_360 = 0
       where dias_360 <0  
       
       select d.*
       into #desplazamiento2
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
       into #dias_restar2            
       from #desplazamiento2
       where de_operacion = @w_operacionca
       and   de_estado    = 'A'
       
       select de_operacion, dias = sum(dias)
       into #reales2
       from #operaciones_vencida2, #dias_restar2
       where de_operacion   = di_operacion
       and   fecha_ven_ini <= de_fecha_ini
       group by de_operacion
       
       update #operaciones_vencida2
       set dias_restar= isnull(dias,0)
       from #reales2
       where di_operacion = de_operacion
       
       select
       di_operacion, 
       dias_360= dias_360 - isnull(dias_restar,0)
       into #actualizacion_vencida2
       from #operaciones_vencida2

       --select * from #actualizacion_vencida

       select @w_dias_mora =dias_360
       from #actualizacion_vencida2
       
       select @w_verifica_mora = @w_dias_mora % 30  --Considerar meses de 30 dias
   
       select @w_dmora_paso_vencido = @w_dmora_pven_cuo
	    
       
       --print '@w_dias_mora:' + convert(varchar, @w_dias_mora)
       --print '@w_dmora_pven_cuo:' + convert(varchar, @w_dmora_pven_cuo)
	   --print '@w_dmora_paso_vencido:' + convert(varchar, @w_dmora_paso_vencido) 	    
       print 'Banco: ' + @w_banco + ' Numero dias: ' + convert(varchar, @w_dias_mora)
     
       if @w_dias_mora >= @w_dmora_paso_vencido
          select 
          @w_estado_fin = @w_est_vencido,
          @w_cambio_estado = 'S'
   end
end 
else
   select 
   @w_estado_fin = @w_est_etapa2,
   @w_cambio_estado = 'S'
   
   
   

if @@trancount = 0 begin
   begin tran    -- control de atomicidad
   select @w_commit = 'S'
end
   
select @w_sp_name = 'sp_cambio_estado_op'

if @i_debug = 'S' print 'Ejecutando sp: ' + @w_sp_name

if @w_cambio_estado = 'S' 
begin


  
   
   exec @w_error = sp_cambio_estado_op
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_date           = @s_date,
   @s_ofi            = @s_ofi,
   @i_banco          = @w_banco,
   @i_fecha_proceso  = @w_fecha_ult_proceso,
   @i_estado_ini     = @w_estado_ini,
   @i_estado_fin     = @w_estado_fin,
   @i_tipo_cambio    = 'A',
   @i_en_linea       = 'N'

   if @w_error <> 0 goto ERROR
end
   
if @w_commit = 'S' begin 
   commit tran
   select @w_commit = 'N'
end

return 0

ERROR:
if @w_commit = 'S'
   rollback tran

return @w_error

go

