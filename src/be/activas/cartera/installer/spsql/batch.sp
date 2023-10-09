/************************************************************************/
/*   Archivo:             batch.sp                                      */
/*   Stored procedure:    sp_batch                                      */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Fabian de la Torre                            */
/*   Fecha de escritura:  Ene. 98.                                      */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*            PROPOSITO                                                 */
/*   Procedimiento que realiza la ejecucion del fin de dia de           */
/*   cartera.                                                           */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA              AUTOR             CAMBIOS                    */
/*   23/abr/2010   Fdo Carvajal   MANEJO SOLO OPS CON NOTAS DEBITO      */
/*   24/Sep/2015   Elcira Pelaez  SACAR DE UNIVERSO LAS NORMALIZACIONES */
/*                                DEL DIA                               */
/*   12/Jul/2019   MTA           Agregar validacion para LCR Caso 116911*/
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_batch')
   drop proc sp_batch
go

create proc sp_batch
@i_param1              varchar(255)  = null,
@i_param2              varchar(255)  = null,
@i_param3              varchar(255)  = null,
@i_param4              varchar(255)  = null,   
@i_param5              varchar(255)  = null,  
@i_param6              varchar(255)  = null,     -- FCP Interfaz Ahorros

@i_siguiente_dia       datetime      = null,   
@s_user                varchar(14)   = null,
@s_term                varchar(30)   = null,
@s_date                datetime      = null,
@s_ofi                 smallint      = null,
@i_en_linea            char(1)       = 'N',
@i_banco               cuenta        = null,
@i_pry_pago            char(1)       = 'N', 
@i_aplicar_clausula    char(1)       = 'S',
@i_aplicar_fecha_valor char(1)       = 'N',
@i_modo                char(1)       = null,
@i_TRC                 char(1)       = 'N',
@i_control_fecha       char(1)       = 'S',
@i_debug               char(1)       = 'N', 
@i_pago_ext            char(1)       = 'N'  ---req 482

as
declare
@w_return          int,
@w_oficina_central int,
@w_rowcount        int,
@w_cont            int,
@w_marcados        int,
@w_ctrl_fin        char(1),
@i_hijo            varchar(2), 
@i_sarta           int, 
@i_batch           int, 
@i_opcion          char(1), 
@i_bloque          int,
@w_sig_dia_habil   datetime,                         -- FCP Interfaz Ahorros
@w_est_cancelado   tinyint,                          -- FCP Interfaz Ahorros
@w_est_vencido     tinyint,                          -- FCP Interfaz Ahorros
@w_est_vigente     tinyint,                          -- FCP Interfaz Ahorros
@w_ciudad_nacional int,                              -- FCP Interfaz Ahorros
@w_tipo_batch      char(1),                           -- FCP Interfaz Ahorros
@w_fecha_cierre	   datetime,
@w_fin_mes 	   char(1),
@w_ejecutar_fin_mes	char(1),
@w_ult_dia_mes     varchar(2),
@w_ultimo_dia      varchar(10), 
@w_mes             varchar(2), 
@w_ano             varchar(4), 
@w_ultimo_dia_def_habil  datetime





create table #ca_rubro_int_tmp(
ro_operacion          int      null,
ro_concepto           catalogo null,
ro_porcentaje         float    null,
ro_tipo_rubro         char(1)  null,
ro_provisiona         char(1)  null,
ro_fpago              char(1)  null,
ro_concepto_asociado  char(10)  null,
ro_valor              money    null,
ro_num_dec            tinyint  null,
ro_porcentaje_efa     float    null
)

create table #ca_rubro_imo_tmp(
ro_operacion          int      null,
ro_concepto           catalogo null,
ro_porcentaje         float    null,
ro_tipo_rubro         char(1)  null,
ro_provisiona         char(1)  null,
ro_fpago              char(1)  null,
ro_concepto_asociado  char(1)  null,
ro_valor              money    null,
ro_num_dec            tinyint  null
)

if @i_param1 is not null
   select 
   @i_hijo          = convert(varchar(2), rtrim(ltrim(@i_param1))),
   @i_sarta         = convert(int       , rtrim(ltrim(@i_param2))),
   @i_batch         = convert(int       , rtrim(ltrim(@i_param3))),
   @i_opcion        = convert(char(1)   , rtrim(ltrim(@i_param4))),
   @i_bloque        = convert(int       , rtrim(ltrim(@i_param5))),   
   @w_tipo_batch    = isnull(convert(char(1), rtrim(ltrim(@i_param6))), 'N'),
   @w_ctrl_fin      = 'N'
   

-- INICIO FCP Interfaz Ahorros - ESTADOS DE CARTERA 
exec @w_return = sp_estados_cca
@o_est_cancelado = @w_est_cancelado out,
@o_est_vencido   = @w_est_vencido out,
@o_est_vigente   = @w_est_vigente out

if @w_return <> 0 return @w_return
-- FIN FCP Interfaz Ahorros - ESTADOS DE CARTERA 
   
select @i_siguiente_dia = isnull(@i_siguiente_dia,fc_fecha_cierre)
from cobis..ba_fecha_cierre
where fc_producto = 7   

select @w_fecha_cierre = @i_siguiente_dia

-- INICIO FCP Interfaz Ahorros 
-- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@rowcount = 0 return 101024

select @w_sig_dia_habil = dateadd(dd,1,@i_siguiente_dia)

exec @w_return = sp_dia_habil 
@i_fecha  = @w_sig_dia_habil,
@i_ciudad = @w_ciudad_nacional,
@o_fecha  = @w_sig_dia_habil out

if @w_return <> 0 
   return @w_return

-- FIN FCP Interfaz Ahorros - 

if @i_opcion = 'G' begin  -- generar universo

   truncate table ca_universo_batch
     
   print 'BATCH FINDIA CARTERA opcion:  ' + @w_tipo_batch 
   
   -- BATCH BAJA INTENSIDAD INI NYM 7x24  

   if @w_tipo_batch = 'D' begin 

      select  @w_ejecutar_fin_mes = isnull(pa_char,'N')
      from    cobis..cl_parametro
      where   pa_producto = 'CCA'
      and     pa_nemonico = 'FM7X24'

      --  En el fin de mes ultimo dia habil se ejecuta solo si el paramero general de cartera segun nemonico 'FM7X24' esta en 'S'
      
      select @w_ult_dia_mes  	= datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@w_fecha_cierre ))*(-1),dateadd(mm,1,@w_fecha_cierre )))
      select @w_mes 		= datepart(mm, @w_fecha_cierre)
      select @w_ano 		= datepart(yy, @w_fecha_cierre)
      select @w_ultimo_dia 	= @w_mes + '/' + @w_ult_dia_mes + '/' + @w_ano 

      select @w_ultimo_dia_def_habil  = convert(datetime, @w_ultimo_dia )

      while exists(select 1 from cobis..cl_dias_feriados
                where df_ciudad = @w_ciudad_nacional
                and   df_fecha  = @w_ultimo_dia_def_habil ) begin
         select @w_ultimo_dia_def_habil = dateadd(day,-1,@w_ultimo_dia_def_habil)
      end

      if @w_ultimo_dia_def_habil = @w_fecha_cierre and @w_ejecutar_fin_mes  <>  'S'
         return 0
 
      -- operaciones con abono ingresado 
	   
      select  op_operacion
      into    #univ_operaciones_aux  
      from    cob_cartera..ca_operacion with (index = ca_operacion_1), 
              cob_cartera..ca_abono -- with (index = ca_abono_1)
      where  op_operacion    = ab_operacion 
      and    ab_estado	in( 'ING' )

      -- operaciones con fecha valor

      insert into  #univ_operaciones_aux  
      select  bi_operacion 
      from    cob_cartera..ca_en_fecha_valor      

      -- operaciones con traslado de cartera

      insert into  #univ_operaciones_aux  
      select  trc_operacion 
      from    cob_cartera..ca_traslados_cartera

         
      if @w_ultimo_dia_def_habil = @w_fecha_cierre and @w_ejecutar_fin_mes  =  'S'
      begin
          -- evita procesar operaciones vencidas o que vencen el dia de proceso cuando es fin de mes.
	      insert into #univ_operaciones_aux
	      select di_operacion 
	      from ca_dividendo
	      where di_fecha_ven = @w_fecha_cierre -- Vencen Hoy
	      and di_estado      = @w_est_vigente
	
	      insert into #univ_operaciones_aux
	      select distinct di_operacion 
	      from ca_dividendo
	      where di_estado = @w_est_vencido     -- Se encentrasn vencidas
      end
      ---LLS000303  insertar las operaciones con nota debito el dia del proceso 
      ---           para eliminarlas despues
      
      insert into #univ_operaciones_aux
      select op_operacion
      from   cob_cartera..ca_operacion with (index = ca_operacion_1),
             cob_cartera..ca_estado,
             cob_cartera..ca_dividendo             
      where  op_estado     = es_codigo
      and    op_forma_pago in ('NDAH', 'NDCC')
      and    op_operacion   = di_operacion
      and    di_estado    = @w_est_vigente
      and    di_fecha_ven = @w_fecha_cierre -- Vencen Hoy
      
      ---LLS000303 Que se inserten todas las operacion incluyendo las de nota Debito
      ---          ya que enla tabla #univ_operaciones_aux estan la que se desean eliminar
      ---          para queno queden en el universo. Que serian unicamente las que tiene pago el dia
      ---          de l fecha de ejecucion

      
      ---ORS000337 Insertar en esta temporal las operaciones con renovaqcion pendiente
      insert into #univ_operaciones_aux
      select op_operacion
	  from cob_credito..cr_tramite with (nolock),
		     cob_credito..cr_op_renovar with (nolock),
		     cob_cartera..ca_operacion  with (nolock)
	  where tr_estado <> 'Z'  ----rechazados
	  and op_banco = or_num_operacion
	  and or_sec_prn   is null  ---Indica que la renovacion aun no se ha efectuado
	  and op_operacion = tr_numero_op 
	  and op_estado in (1,2,4,9)
	  and tr_tipo in('U','R')
	  and tr_tramite = or_tramite

      ---ORS 000337
      
      ---INC 60364 Excluir las que se castigaran en esta fecha
      insert into #univ_operaciones_aux
      select op_operacion
      from ca_castigo_masivo with (nolock),
           ca_operacion  with (nolock)
		where op_banco = cm_banco
		and   cm_estado = 'I'
		and   cm_fecha_castigo = @w_fecha_cierre -- FEcha Cartera
     ---INC 60364		

      ---LLS 77314
      insert into #univ_operaciones_aux
      select op_operacion
      from  ca_operacion  with (nolock)
	  where op_fecha_ini = @w_fecha_cierre -- desembolsadas hoy
	  and   op_estado = 1
     ---FIN LLS 77314

	  ---SACAR LAS NORMALIZACIONES DEL DIA
	  ---POR DESMARCA DE OPERACIONES DEL PROCESO 7321
      insert into #univ_operaciones_aux
      select   op_operacion
	  from cob_cartera..ca_operacion with (nolock),
	       cob_credito..cr_tramite with (nolock)
	  where op_tramite = tr_tramite
	  and   tr_tipo = 'M'
	  and   op_estado = 1
	  and   op_fecha_liq = @w_fecha_cierre
	  ---FIN SACAR LAS NORMALIZACIONES DEL DIA
      
      insert into ca_universo_batch
      select   op_operacion,  'N',   0
      from     cob_cartera..ca_operacion with (index = ca_operacion_1),
               cob_cartera..ca_estado
      where  op_estado 	     = es_codigo
      and    es_procesa      = 'S'


      
      delete ca_universo_batch 
      from   ca_universo_batch  ,
             #univ_operaciones_aux   
      where  ub_operacion = op_operacion	

   end

   --  BATCH NORMAL

   if  @w_tipo_batch = 'N'       -- FCP Interfaz Ahorros 
   begin 
      insert into ca_universo_batch 
      select op_operacion,  'N',   0
      from   ca_operacion, ca_estado
      where  op_estado = es_codigo
      and    es_procesa = 'S'
      and    op_fecha_ult_proceso <= @i_siguiente_dia    
      UNION     
      select op_operacion,  'N',   0
      from   ca_operacion o
      where  op_estado = @w_est_cancelado      
      and    op_tipo_amortizacion = 'ROTATIVA'
      and    op_fecha_ult_proceso <= @i_siguiente_dia    
      AND    (EXISTS(SELECT 1 FROM ca_abono WHERE o.op_operacion = ab_operacion
			      AND ab_estado = 'NA'
			      AND ab_fecha_pag <= @i_siguiente_dia    ) or
			      EXISTS(SELECT 1 FROM ca_desembolso WHERE o.op_operacion = dm_operacion
			      AND dm_estado = 'NA'
			      AND dm_fecha  <= @i_siguiente_dia    ) )      
      order by op_operacion
   end  
   -- INICIO FCP Interfaz Ahorros  -- MANEJO DE OPS CON DEBITO UNICAMENTE


   -- BATCH AHORROS

   if @w_tipo_batch = 'S' begin 
      -- PAGOS PENDIENTES EN NOTA DEBITO        
      select op_operacion
      into   #universo_batch
      from   ca_operacion, ca_estado
      where  op_estado    = es_codigo
      and    es_procesa   = 'S'
      and    op_fecha_ult_proceso <= @i_siguiente_dia    
      and    op_operacion in (
      select ab_operacion 
      from   ca_abono with (nolock), ca_abono_det (nolock), ca_producto (nolock)
      where  ab_fecha_pag      = @i_siguiente_dia
      and    ab_estado        in ('ING','P', 'NA')
      and    ab_operacion      = abd_operacion
      and    ab_secuencial_ing = abd_secuencial_ing
      and    abd_concepto      = cp_producto
      and    cp_categoria     in ('NDAH', 'NDCC'))
      
      -- DEBITOS AUTOMATICOS - Ops con cuotas Vencidas      
      insert into #universo_batch
      select distinct op_operacion
      from   ca_operacion O, ca_estado, ca_producto, ca_dividendo
      where  op_estado = es_codigo
      and    es_procesa = 'S'
      and    op_fecha_ult_proceso <= @i_siguiente_dia    
      and    op_forma_pago = cp_producto
      and    cp_pago_aut   = 'S'
      and    op_cuenta     is not null
      and   (cp_pcobis = 3 or cp_pcobis = 4)
      and    cp_categoria  in ('NDAH', 'NDCC')
      and    op_naturaleza = 'A'      
      and    di_operacion  = op_operacion
      and    (di_estado      = @w_est_vencido  or (di_estado = @w_est_vigente and di_fecha_ven = op_fecha_ult_proceso))
      --and   (di_fecha_ven between op_fecha_ult_proceso and @w_sig_dia_habil or op_fecha_fin <= @w_sig_dia_habil)

      insert into ca_universo_batch
      select distinct op_operacion, 'N', 0
      from   #universo_batch        
      order  by op_operacion              
   end       
   -- FIN FCP Interfaz Ahorros -- MANEJO DE OPS CON DEBITO UNICAMENTE                         
                                    
   If @@error <> 0 return 710001    
                                    
   delete cobis..ba_ctrl_ciclico    
   where ctc_sarta = @i_sarta       
                                    
   insert into cobis..ba_ctrl_ciclico
   select sb_sarta,sb_batch, sb_secuencial, 'S', 'P'
   from cobis..ba_sarta_batch       
   where sb_sarta = @i_sarta        
   and   sb_batch = @i_batch        
                                    
   return 0
   
end

--- OPCION QUE SE EJECUTARA SOLO SI EL PROCESO ES EL BATCH MASIVO (NO PARA FECHA VALOR)   
if @i_opcion = 'B' begin  --procesos batch

   select @w_cont = count(*)
   from ca_universo_batch with (nolock)
   where ub_estado    = @i_hijo
   and   ub_intentos < 2
   
   select @w_cont = @i_bloque - @w_cont
   
   if @w_cont < 0 select @w_cont = @i_bloque

   if @w_cont > 0 begin
   
      set rowcount @w_cont
      
      update ca_universo_batch with (rowlock) set
      ub_estado = @i_hijo
      where ub_estado    = 'N'
      and   ub_intentos < 2  -- controlar que un préstamos se intente procesar 2 veces
      
      if @@error <> 0 return 710001
      
      set rowcount 0
      
   end
   
   update cobis..ba_ctrl_ciclico with (rowlock) set
   ctc_estado = 'P'
   where ctc_sarta      = @i_sarta
   and   ctc_batch      = @i_batch
   and   ctc_secuencial = @i_hijo
   
   --- CONTROL DE TERMINACION DE PROCESO 
   if not exists(select 1 from ca_universo_batch with (nolock)
   where ub_estado = @i_hijo
   and   ub_intentos < 2) begin
     
      update cobis..ba_ctrl_ciclico with (rowlock) set
      ctc_procesar = 'N'
      where ctc_sarta      = @i_sarta
      and   ctc_batch      = @i_batch
      and   ctc_secuencial = @i_hijo
      
      if @@error <> 0 return 710002  

   end      
end

--SET TRANSACTION ISOLATION LEVEL SNAPSHOT   

--- CREACION DE TABLAS DE TRABAJO 
create table #rubro_mora (ro_concepto  char(10))

--- EJECUCION DEL PROCESO BATCH 
exec @w_return = sp_batch1
@s_user                = @s_user,
@s_term                = @s_term,
@s_date                = @s_date,
@s_ofi                 = @s_ofi,
@i_en_linea            = @i_en_linea,
@i_banco               = @i_banco,
@i_siguiente_dia       = @i_siguiente_dia,
@i_pry_pago            = @i_pry_pago,
@i_aplicar_clausula    = @i_aplicar_clausula,
@i_aplicar_fecha_valor = @i_aplicar_fecha_valor,
@i_TRC                 = @i_TRC,
@i_modo                = @i_modo,
@i_hijo                = @i_hijo,
@i_control_fecha       = @i_control_fecha,
@i_debug               = @i_debug, 
@i_solo_debitos        = @w_tipo_batch,    -- FCP Interfaz Ahorros  
@i_pago_ext            = @i_pago_ext --Req 482

if @i_opcion = 'B' begin -- Validacion para marcacion de todos los hilos como finalizados   

   update cobis..ba_ctrl_ciclico with (rowlock) set
   ctc_estado = 'F'
   where ctc_sarta      = @i_sarta
   and   ctc_batch      = @i_batch
   and   ctc_secuencial = @i_hijo
      
   if @@error <> 0 return 710002  
end

return @w_return

go
