 /***********************************************************************/
/*Archivo               :     camestau.sp                               */
/*Stored procedure      :     sp_cambio_estado_automatico               */
/*Base de datos         :     cob_cartera                               */
/*Producto              :     Credito y Cartera                         */
/*Disenado por          :     Fabian de la Torre                        */
/*Fecha de escritura    :     31/08/1999                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*Este programa es parte de los paquetes bancarios propiedad de         */
/*"MACOSA".                                                             */
/*Su uso no autorizado queda expresamente prohibido asi como            */
/*cualquier alteracion o agregado hecho por alguno de sus               */
/*usuarios sin el debido consentimiento por escrito de la               */
/*Presidencia Ejecutiva de MACOSA o su representante.                   */
/************************************************************************/
/*                                PROPOSITO                             */
/*Maneja los cambios de estado automaticos para las operaciones         */
/************************************************************************/
/*                                CAMBIOS                               */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/*      26/11/2020     D. Cumbal        #150082                         */
/*   NOV-2021      Andy G.          Req. 170130 Nuevos Estados CCA      */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_automatico')
drop proc sp_cambio_estado_automatico
go

create proc sp_cambio_estado_automatico(
   @s_user            login,
   @s_term            varchar(30),
   @s_date            datetime,
   @s_ofi             smallint,
   @i_toperacion      catalogo,
   @i_oficina         smallint,
   @i_banco           cuenta,
   @i_operacionca     int,
   @i_moneda          tinyint,
   @i_fecha_proceso   datetime,
   @i_en_linea        char(1),    
   @i_gerente         smallint,
   @i_estado_ini      tinyint,
   @i_moneda_nac      smallint
) 

as 
declare
@w_sp_name               descripcion,
@w_return                int,
@w_secuencial            int,
@w_di_dividendo          smallint,
@w_di_vigente            int,
@w_di_fecha_ven          datetime,
@w_est_vigente           tinyint,
@w_est_vencido           tinyint,
@w_est_cancelado         tinyint,
@w_est_novigente         tinyint,
@w_num_dias              int,
@w_secuencia             int,
@w_max_dividendo         int,
@w_tipo_cambio           char(1),
@w_estado_ini            tinyint,
@w_estado_fin            tinyint,
@w_trn                   catalogo,
@w_min_dividendo_ven     smallint,     
@w_est_suspenso          tinyint,
@w_op_fecha_ult_proceo   datetime,
@w_est_etapa1            int ,
@w_est_etapa2            int ,
@w_est_etapa3            int 
--- CARGAR VARIABLES DE TRABAJO 
select
@w_sp_name       = 'sp_cambio_estado_automatico',
@w_trn           = 'EST',  --EST (CAMBIO DE ESTADO AUTOMATICO)
@w_secuencial    = 0,
@w_di_dividendo  = 0,
@w_di_vigente    = 0,
@w_num_dias      = 0,
@w_tipo_cambio   = 'A'


--- CARGAR ESTADOS 
exec @w_return    = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_etapa2     = @w_est_etapa2   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out

if @w_return <> 0 
begin
   PRINT 'No encontraron estados para cartera '
   return 708201
end


-- DATOS DE LA OPERACION 
select
@w_estado_ini          = op_estado,
@w_op_fecha_ult_proceo = op_fecha_ult_proceso 
from ca_operacion
where op_operacion = @i_operacionca


select @w_num_dias = 0


---BUSCAR EL DIVIDENDO VIGENTE 
select @w_di_vigente = di_dividendo
from   ca_dividendo
where  di_operacion  = @i_operacionca
and    di_estado     = @w_est_vigente


---BUSCAR EL DIVIDENDO MAS VENCIDO
set rowcount 1
select @w_min_dividendo_ven = isnull(di_dividendo, 0)
from   ca_dividendo
where  di_operacion  = @i_operacionca
and    di_estado     = @w_est_vencido
order by di_dividendo
set rowcount 0





if @w_min_dividendo_ven != 0
begin
   if not exists ( select 1 from ca_desplazamiento where de_operacion = @i_operacionca and de_estado = 'A')
   begin
      select @w_di_fecha_ven = di_fecha_ven
      from   ca_dividendo
      where  di_operacion    = @i_operacionca
      and    di_dividendo    = @w_min_dividendo_ven
      
      select @w_num_dias = isnull(datediff(dd,@w_di_fecha_ven, @i_fecha_proceso),0) + 1
	  
	 
	  
	  
   end
   else
   begin
      select 
      di_operacion,
      dias_360 = datediff(dd, isnull(min(di_fecha_ven),@i_fecha_proceso), @i_fecha_proceso),
      fecha_ven_ini = min(di_fecha_ven),
      dias_restar   = convert(int,0)
      into #dividendo_mas_vencido
      from ca_dividendo
      where di_operacion = @i_operacionca
      and   di_estado    = @w_est_vencido
      group by  di_operacion
       
      update #dividendo_mas_vencido set 
      dias_360 = 0
      where dias_360 <0  
       
      select d.*
      into #inf_desplazamiento
      from ca_desplazamiento d
      where de_operacion = @i_operacionca
      and   de_estado    = 'A'
      and   de_archivo   <> 'WORKFLOW'

      select de_operacion,
      de_fecha_ini, 
      dias = case when de_fecha_fin>= @i_fecha_proceso then
             datediff(dd,de_fecha_ini, @i_fecha_proceso)
             else 
             datediff(dd,de_fecha_ini, de_fecha_fin) end
      into #dias_por_desplazamiento            
      from #inf_desplazamiento
      where de_operacion = @i_operacionca
      and   de_estado    = 'A'
       
      select de_operacion, dias = sum(dias)
      into #dias_totales_desplazamiento
      from #dividendo_mas_vencido, #dias_por_desplazamiento
      where de_operacion   = di_operacion
      and   fecha_ven_ini <= de_fecha_ini
      group by de_operacion
       
      update #dividendo_mas_vencido
      set dias_restar= isnull(dias,0)
      from #dias_totales_desplazamiento
      where di_operacion = de_operacion
      
      select @w_num_dias = dias_360 - isnull(dias_restar,0)
      from #dividendo_mas_vencido 
	  

	  
   end 
end   

print 'sp_cambio_estado_automatico @w_num_dias: ' + convert(varchar,@w_num_dias)
--- SELECCIONAR EL NUEVO ESTADO DE LA OBLIGACION 
select @w_estado_fin  = em_estado_fin
from   ca_estados_man
where  em_toperacion  = @i_toperacion
and    em_tipo_cambio = @w_tipo_cambio
and    em_estado_ini  = @w_estado_ini
and    em_dias_cont  <= @w_num_dias
and    em_dias_fin   >= @w_num_dias   

if @@rowcount = 0
   return 0


--- CONDICION DE SALIDA 
if @w_estado_fin is null 
   return 0

if @i_estado_ini = @w_estado_fin   
   return 0


--- OBTENER RESPALDO ANTES DEL CAMBIO DE ESTADO
exec @w_secuencial  = sp_gen_sec
@i_operacion        = @i_operacionca

exec @w_return  = sp_historial
@i_operacionca  = @i_operacionca,
@i_secuencial   = @w_secuencial

if @w_return != 0 
   return @w_return
   
 
if @w_estado_fin = @w_est_vigente
begin
   exec @w_return  = sp_cambio_estado_vigente
   @s_user         = @s_user,
   @s_term         = @s_term,
   @i_operacionca  = @i_operacionca

   if  @w_return <> 0 
   begin
      PRINT 'Error ejecutando sp  sp_cambio_estado_vigente  @w_operacionca  ' + cast (@i_operacionca as varchar)
      return 708201
   end
end


if @w_estado_fin = @w_est_etapa2          --estado 12 
begin
   exec @w_return  = sp_cambio_estado_vencido
   @s_user         = @s_user,
   @s_term         = @s_term,
   @i_etapa_fin    = 2,  
   @i_operacionca  = @i_operacionca

   if  @w_return <> 0 
   begin
      PRINT 'Error ejecutando sp  sp_cambio_estado_vigente  @w_operacionca  ' + cast (@i_operacionca as varchar)
      return 708201
   end
end


if @w_estado_fin =  @w_est_vencido  --( ESTADO VENCIDO TRADICIONAL CON CAMBIO DE DESCRIPCION A ETAPA 3  ) 
begin
   exec @w_return  = sp_cambio_estado_vencido
   @s_user         = @s_user,
   @s_term         = @s_term,
   @i_etapa_fin    = 3, ---VENCIDO TRADICIONAL (mas de 90 )
   @i_operacionca  = @i_operacionca
   
   if @w_return <> 0 
   begin
      PRINT 'Error ejecutando sp  sp_cambio_estado_vencido  @w_operacionca  ' + cast (@i_operacionca as varchar)
      return 708201
   end
end


update ca_operacion set
op_edad = op_estado
where op_operacion = @i_operacionca

if @@error <> 0 
   return 705066

return 0

go

