/*cr_provi.sp***********************************************************/
/*   Archivo:                   cr_cal_provi.sp                        */
/*   Stored procedure:          sp_calculo_provision                   */
/*   Base de Datos:             cob_conta_super                        */
/*   Disenado por:              Pedro Rafael Montenegro Rosales        */
/*   Producto:                  CONSOLIDADOR                           */
/*   Fecha de Documentacion:    06/Dic/2016                            */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de     */
/*   "MACOSA".                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como        */
/*   cualquier autorizacion o agregado hecho por alguno de sus         */
/*   usuario sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante                */
/***********************************************************************/
/*                              PROPOSITO                              */
/*  Calculo de provisiones.                                            */
/***********************************************************************/

use cob_conta_super
go

if exists (select * from sysobjects where name = 'sp_calculo_provision' )
   drop proc sp_calculo_provision
go

create proc sp_calculo_provision (
   @i_param1            varchar(255)
)
as
declare
   @i_fecha             datetime,
   @w_periodicidad      varchar(1),
   @w_error             int,
   @w_sp_name           varchar(32),
   @w_usuario           login,
   @w_mensaje           varchar(255),
   @w_msg               varchar(200),
   @w_clase_comercial   catalogo,
   @w_clase_consumo     catalogo,
   @w_clase_vivienda    catalogo,
   @w_clase_micro       catalogo,
   @w_calif_buena       catalogo,

   @w_gar_liquida       catalogo,
   @w_gar_hipoteca      catalogo,

   @w_est_vencido       tinyint,
   @w_est_vigente       tinyint,

   @w_porc_prov_max     float,
   @w_min_dias_mora     tinyint   
   
select 
@i_fecha         = convert(datetime, @i_param1),
@w_sp_name       = 'sp_calculo_provision',
@w_usuario       = 'crebatch',
@w_error         = 2100001

exec @w_error = sp_dia_habil_cierre
@i_fecha        = @i_fecha,
@o_periodicidad = @w_periodicidad out,
@o_msg          = @w_msg out

if @w_error <> 0 begin
   select   @w_mensaje   = 'Error Ejecutando sp_dia_habil_cierre ',
            @w_error     = 2108028 
   goto ERRORFIN
end

if @w_msg is not null begin
   select   @w_mensaje  = @w_msg,
            @w_error    = 2108028 
   goto ERRORFIN
end

--PARAMETRO DE CLASE COMERCIAL
select @w_clase_comercial = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CCCOM'
and pa_producto = 'CCA'

if @w_clase_comercial is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <CCCOM> '
   goto ERRORFIN
end

--PARAMETRO DE CLASE CONSUMO
select @w_clase_consumo = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CCCON'
and pa_producto = 'CCA'

if @w_clase_consumo is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <CCCOM> '
   goto ERRORFIN
end

--PARAMETRO DE CLASE HIPOTECARIA
select @w_clase_vivienda = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CCVIV'
and pa_producto = 'CCA'

if @w_clase_vivienda is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <CCCOM> '
   goto ERRORFIN
end

--PARAMETRO DE SUBTIPO MICROCREDITO
select @w_clase_micro = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CSMIC'
and pa_producto = 'CCA'

if @w_clase_micro is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <CCCOM> '
   goto ERRORFIN
end

--PARAMETRO DE CALIFICACION BUENA
select @w_calif_buena = pa_char
from cobis..cl_parametro
where pa_nemonico = 'BCAL'
and pa_producto   = 'REC'

if @w_calif_buena is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <BCAL> '
   goto ERRORFIN
end

--PARAMETRO DE PORCENTAJE DE PROVISION MAXIMA
select @w_porc_prov_max = pa_float
from cobis..cl_parametro
where pa_nemonico = 'PMAP'
and pa_producto   = 'REC'

if @w_porc_prov_max is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <PMAP> '
   goto ERRORFIN
end

--PARAMETRO DE MINIMO DE DIAS DE MORA
select @w_min_dias_mora = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMDM'
and pa_producto   = 'REC'

if @w_min_dias_mora is null begin
   select   @w_error   = 2101084,
            @w_mensaje = 'No Encontro parametro <CMDM> '
   goto ERRORFIN
end

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error = cob_externos..sp_estados
   @i_producto    = 7,
   @o_est_vencido = @w_est_vencido out,
   @o_est_vigente = @w_est_vigente out

if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null begin
   select   @w_error   = 2108029,
            @w_mensaje = 'No Encontro Estado Vencido/Vigente para Cartera '
   goto ERRORFIN
end

create table #periodos_cuota
(
   pc_periodo  char(1),
   pc_dias_min int,
   pc_dias_max int
)

insert into #periodos_cuota (pc_periodo, pc_dias_min, pc_dias_max) values ('W', 1 , 7)
insert into #periodos_cuota (pc_periodo, pc_dias_min, pc_dias_max) values ('Q', 8, 15)
insert into #periodos_cuota (pc_periodo, pc_dias_min, pc_dias_max) values ('M', 16, 99999)

if not exists (select 1 from cob_conta_super..sb_provisiones) begin
   select   @w_error = 2108032,
            @w_mensaje = 'NO EXISTE DATOS DE PORCENTAJE DE PROVISIONES'   
   goto ERRORFIN
end

truncate table cob_conta_super..sb_dato_provision 

if @@error <> 0 begin
   select   @w_error = 2108032,
            @w_mensaje = 'ERROR AL BORRAR EN TABLA <cob_conta_super..sb_dato_provision >'   
   goto ERRORFIN
end

--LLENA LA TABLA PARA PROVISION
select   do_key				   = identity (int),
         do_banco             = do_banco, 
         do_clase_cartera     = do_clase_cartera, 
         do_tipo_cartera      = do_tipo_cartera, 
         do_subtipo_cartera   = do_subtipo_cartera, 
         do_calificacion      = do_calificacion, 
         do_dias_mora         = do_dias_mora_365 + case when do_estado_cartera = @w_est_vencido and (do_op_anterior is not null or do_reestructuracion = 'S') 
                                                      then do_dias_mora_ant else 0 end, 
         do_dias_mora_norm    = do_dias_mora_365, 
         do_dias_mora_ant     = do_dias_mora_ant, 
         do_estado_cartera    = do_estado_cartera,
         do_periodicidad_cuota= do_periodicidad_cuota,
         
         --do_saldo_cap         = do_saldo_cap,
         --do_saldo_int         = do_saldo_int,

         --do_porc_cap_liq      = convert(float, null),
         --do_porc_cap_hip      = convert(float, null),
         --do_porc_cap_des      = convert(float, null),
         --do_porc_int_liq      = convert(float, null),
         --do_porc_int_hip      = convert(float, null),
         --do_porc_int_des      = convert(float, null),
         
         do_saldo_cap_liq     = isnull(do_cap_liq, 0),
         do_saldo_cap_hip     = isnull(do_cap_hip, 0),
         do_saldo_cap_des     = isnull(do_cap_des, 0),
         do_saldo_int_liq     = isnull(do_int_liq, 0),
         do_saldo_int_hip     = isnull(do_int_hip, 0),
         do_saldo_int_des     = isnull(do_int_des, 0),

         do_prov_cap_liq      = convert(money, 0),
         do_prov_cap_hip      = convert(money, 0),
         do_prov_cap_des      = convert(money, 0),
         do_prov_int_liq      = convert(money, 0),
         do_prov_int_hip      = convert(money, 0),
         do_prov_int_des      = convert(money, 0),

         do_provision_cap     = convert(money, 0),
         do_provision_int     = convert(money, 0)
into #tmp_provision
from cob_conta_super..sb_dato_operacion
where do_fecha          = @i_fecha 
and do_aplicativo	      = 7
and do_oficina          > 0
and do_estado_cartera   in (@w_est_vencido, @w_est_vigente)

if @@error <> 0 begin
   select   @w_error = 2108030,
            @w_mensaje = 'ERROR AL INSERTAR EN TABLA <#tmp_provision>'
   goto ERRORFIN
end

--ACTUALIZA LOS VALORES DE PROVISION CON SUS RESPECTIVAS PROVISIONES (PARA PRESTAMOS QUE NO SON MICROCREDITO)
update #tmp_provision set
   
   --do_porc_cap_liq = (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera 
   --                     and pr_calificacion = @w_calif_buena
   --                     and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   --do_porc_cap_hip =  (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = @w_clase_vivienda 
   --                     and pr_calificacion = do_calificacion 
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   --do_porc_cap_des =  (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera
   --                     and pr_calificacion = do_calificacion
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100),       
   --do_porc_int_liq = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera 
   --                     and pr_calificacion = @w_calif_buena
   --                     and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),  
   --do_porc_int_hip = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = @w_clase_vivienda 
   --                     and pr_calificacion = do_calificacion
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100), 
   --do_porc_int_des = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera
   --                     and pr_calificacion = do_calificacion
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),
   
   do_prov_cap_liq = do_saldo_cap_liq * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera 
                        and pr_calificacion = @w_calif_buena
                        and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   do_prov_cap_hip = do_saldo_cap_hip * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = @w_clase_vivienda 
                        and pr_calificacion = do_calificacion 
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   do_prov_cap_des = do_saldo_cap_des * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera
                        and pr_calificacion = do_calificacion
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100),       
   do_prov_int_liq = do_saldo_int_liq * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera 
                        and pr_calificacion = @w_calif_buena
                        and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),  
   do_prov_int_hip = do_saldo_int_hip * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = @w_clase_vivienda 
                        and pr_calificacion = do_calificacion
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100), 
   do_prov_int_des = do_saldo_int_des * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera
                        and pr_calificacion = do_calificacion
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100)
where do_clase_cartera in (@w_clase_consumo, @w_clase_vivienda) 
or (do_clase_cartera in (@w_clase_comercial) 
   and (do_subtipo_cartera not in (@w_clase_micro) or do_subtipo_cartera is null))

if @@error <> 0 begin
   select   @w_error = 2108031,
            @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <#tmp_provision>'   
   goto ERRORFIN
end

--ACTUALIZA LOS VALORES DE PROVISION CON SUS RESPECTIVAS PROVISIONES (PARA PRESTAMOS QUE SON MICROCREDITO)
update #tmp_provision set
   
   --do_porc_cap_liq = (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera 
   --                     and pr_subtipo_cartera = @w_clase_micro
   --                     and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
   --                     and pr_calificacion is null                        
   --                     and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   --do_porc_cap_hip = (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = @w_clase_vivienda 
   --                     and pr_calificacion = do_calificacion
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   --do_porc_cap_des = (isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera
   --                     and pr_subtipo_cartera = @w_clase_micro
   --                     and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
   --                     and pr_calificacion is null
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100),       
   --do_porc_int_liq = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera
   --                     and pr_subtipo_cartera = @w_clase_micro
   --                     and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
   --                     and pr_calificacion is null
   --                     and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),  
   --do_porc_int_hip = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = @w_clase_vivienda 
   --                     and pr_calificacion = do_calificacion
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100), 
   --do_porc_int_des = (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
   --                     from cob_conta_super..sb_provisiones 
   --                     where pr_clase_cartera = do_clase_cartera
   --                     and pr_subtipo_cartera = @w_clase_micro
   --                     and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
   --                     and pr_calificacion is null
   --                     and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),
   
   do_prov_cap_liq = do_saldo_cap_liq * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera 
                        and pr_subtipo_cartera = @w_clase_micro
                        and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
                        and pr_calificacion is null                        
                        and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   do_prov_cap_hip = do_saldo_cap_hip * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = @w_clase_vivienda 
                        and pr_calificacion = do_calificacion
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100), 
   do_prov_cap_des = do_saldo_cap_des * (isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera
                        and pr_subtipo_cartera = @w_clase_micro
                        and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
                        and pr_calificacion is null
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) / 100),       
   do_prov_int_liq = do_saldo_int_liq * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera
                        and pr_subtipo_cartera = @w_clase_micro
                        and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
                        and pr_calificacion is null
                        and @w_min_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100),  
   do_prov_int_hip = do_saldo_int_hip * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = @w_clase_vivienda 
                        and pr_calificacion = do_calificacion
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100), 
   do_prov_int_des = do_saldo_int_des * (case when do_estado_cartera = @w_est_vencido then @w_porc_prov_max else isnull((select pr_porcentaje 
                        from cob_conta_super..sb_provisiones 
                        where pr_clase_cartera = do_clase_cartera
                        and pr_subtipo_cartera = @w_clase_micro
                        and pr_periodo_cuota = (select pc_periodo from #periodos_cuota where do_periodicidad_cuota between pc_dias_min and pc_dias_max)
                        and pr_calificacion is null
                        and do_dias_mora between pr_dias_mora_ini and pr_dias_mora_fin), 0) end / 100)
where (do_clase_cartera in (@w_clase_comercial) and do_subtipo_cartera in (@w_clase_micro))

if @@error <> 0 begin
   select   @w_error = 2108031,
            @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <#tmp_provision>'   
   goto ERRORFIN
end

--ACTUALIZA LOS VALORES TOTALES DE PROVISION
update #tmp_provision set  do_provision_cap = do_prov_cap_liq + do_prov_cap_hip + do_prov_cap_des,
                           do_provision_int = do_prov_int_liq + do_prov_int_hip + do_prov_int_des

if @@error <> 0 begin
   select   @w_error = 2108031,
            @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <#tmp_provision>'   
   goto ERRORFIN
end

--select   do_key, do_banco, 
--         do_clase_cartera, do_subtipo_cartera, do_calificacion, do_dias_mora, do_estado_cartera, do_periodicidad_cuota,
--
--         --do_porc_cap_liq, 
--         do_saldo_cap_liq, do_prov_cap_liq,
--         --do_porc_cap_hip, 
--         do_saldo_cap_hip, do_prov_cap_hip,
--         --do_porc_cap_des, 
--         do_saldo_cap_des, do_prov_cap_des,
--         --do_porc_int_liq, 
--         do_saldo_int_liq, do_prov_int_liq,
--         --do_porc_int_hip, 
--         do_saldo_int_hip, do_prov_int_hip,
--         --do_porc_int_des, 
--         do_saldo_int_des, do_prov_int_des,
--
--         --do_provision_cap,
--         --do_provision_int,
--         
--         do_tipo_cartera, do_dias_mora, do_dias_mora_norm, do_dias_mora_ant
--from #tmp_provision
--order by do_banco

--ACTUALIZA TABLA FINAL DE PROVISION
insert into cob_conta_super..sb_dato_provision 
         (dp_banco,        dp_clase_cartera, dp_tipo_cartera,     dp_subtipo_cartera, 
         dp_calificacion,  dp_dias_mora,     dp_dias_mora_op_ant, dp_estado_cartera,
         dp_saldo_cap_liq, dp_saldo_cap_hip, dp_saldo_cap_des, 
         dp_saldo_int_liq, dp_saldo_int_hip, dp_saldo_int_des, 
         dp_provision_cap, dp_provision_int)
select   do_banco,         do_clase_cartera, do_tipo_cartera,     do_subtipo_cartera, 
         do_calificacion,  do_dias_mora,     do_dias_mora_ant,    do_estado_cartera,
         do_saldo_cap_liq, do_saldo_cap_hip, do_saldo_cap_des, 
         do_saldo_int_liq, do_saldo_int_hip, do_saldo_int_des, 
         do_provision_cap, do_provision_int
from  #tmp_provision

if @@error <> 0 begin
   select   @w_error = 2108030,
            @w_mensaje = 'ERROR AL INSERTAR EN TABLA <cob_conta_super..sb_dato_provision>'   
   goto ERRORFIN
end

--ACTUALIZA LOS VALORES DE PROVISION EN EL CONSOLIDADO DE OPERACION
update cob_conta_super..sb_dato_operacion 
   set   do_prov_cap = dp_provision_cap,
         do_prov_int = dp_provision_int
from cob_conta_super..sb_dato_provision 
where dp_banco          = do_banco
and do_fecha            = @i_fecha 
and do_aplicativo	      = 7
and do_oficina          > 0
and do_estado_cartera   in (@w_est_vencido, @w_est_vigente)

if @@error <> 0 begin
   select   @w_error = 2108031,
            @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <cob_conta_super..sb_dato_operacion>'   
   goto ERRORFIN
end

return 0

ERRORFIN: 
--select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return 1

go

/*
declare  @w_fecha			datetime,
         @w_error			int

select @w_fecha = '2016/10/13'
exec @w_error = cob_conta_super..sp_calculo_provision
	@i_param1 = @w_fecha 
	
if (@w_error > 0)
	SELECT * FROM cob_conta_super..sb_errorlog

*/