/************************************************************************/
/*   Archivo:                 rptcmpcli.sp                              */
/*   Stored procedure:        sp_rpt_comp_clientes_act                  */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Octubre 01 de 2019                        */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generación de informes mensuales que permitan evaluar              */
/*   el impacto social de TUIIO en la comunidad.                        */
/*   --> Reporte Comportamiento de Clientes Activos por Producto        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   19/09/2019 Walther Toledo  Emision Inicial Caso Redmine#123062     */
/*   29/04/2020 ACH             Regularizacion por caso #156405         */
/*   18/05/2021 DCumbal         Cambios #156405 Mejora                  */
/************************************************************************/


use cob_conta_super
go
if not object_id('sp_rpt_comp_clientes_act') is null
   drop proc sp_rpt_comp_clientes_act
go
-- ========================================================
create proc sp_rpt_comp_clientes_act
   @i_param1 datetime = null

as
declare 
   @w_batch          int,
   @w_formato_fecha  int,
   @w_filial         int,
   @w_fecha          datetime,
   @w_fecha_1        datetime,
   @w_met_pag_frec   varchar(10),
   @w_ente_aux       int,
   @w_exp_credit     char(1),
   ---
   @w_s_app          varchar(255),
   @w_path           varchar(255),
   @w_destino        varchar(255),
   @w_dest_cab       varchar(255),
   @w_errores        varchar(255),
   @w_cmd            varchar(5000),
   @w_error          int,
   @w_comando        varchar(6000),
   @w_columna        varchar(50),
   @w_cabecera       varchar(5000),
   @w_oper_act       int,
   @w_oper_act_i    int,
   @w_oper_sgt       int,
   @w_cont           int,
   @w_tot            money,
   @w_val_act        money,
   @w_val_sgt        money,
   @w_subtot         money,
   @w_msg            varchar(132),
   @w_mensaje        varchar(512),
   @w_ciudad_nacional   int,
   @w_return         int,
   @w_fecha_proceso datetime,
   @w_sp_name        varchar(64),
   @w_cab_rpt       varchar(1024),
   @w_toper         varchar(10),
   @w_decimales      tinyint,
   @w_vencido        tinyint,
   @w_vigente        tinyint,
   @w_dia_semana     int, 
   @w_dia_max        int,
   @w_procesa        char(1),
   @w_dia_viernes    int,
   @w_fecha_param    datetime
 
select @w_batch = 36437,
       @w_decimales = 2,
       @w_fecha_param = @i_param1

select @w_sp_name = 'sp_rpt_comp_clientes_act',
       @w_error = 0
   
select @w_filial = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'FILSAN'
if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254, @w_mensaje = 'No se encuentra parametro FILSAN'
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'
if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254, @w_mensaje = 'No se encuentra parametro CIUN'
   goto ERROR_PROCESO
end

/****************Validacion Ejecucion******************/
select @w_fecha_param = dateadd (dd,-1 ,@w_fecha_param)
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_param)
   select @w_fecha_param = dateadd (dd,-1 ,@w_fecha_param)
      
select @w_fecha   = @w_fecha_param

select @w_dia_max = isnull(pa_int,8)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'DIMAPR'
and    pa_producto = 'ADM'

select @w_dia_viernes = isnull(pa_int,6)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'NUDIVI'
and    pa_producto = 'ADM'

select @w_dia_semana = datepart(dw, @w_fecha)
select @w_procesa = 'N' 
select @w_fecha_1 = @w_fecha

if @w_dia_semana = @w_dia_viernes and (datepart(dd,@w_fecha_1)<= @w_dia_max)
   select @w_procesa = 'S'
else
begin 
    select @w_fecha_1 = dateadd(dd, 1, @w_fecha_1)
    
   if (datepart(dd,@w_fecha_1)<= @w_dia_max)
   begin
       while exists(select 1 from cobis..cl_dias_feriados 
                 where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_1) 
       begin
           select @w_fecha_1 = dateadd(dd, 1, @w_fecha_1) 
           
           select @w_dia_semana = datepart(dw, @w_fecha_1)
           if @w_dia_semana = @w_dia_viernes
           begin
              select @w_procesa = 'S'
              break
           end
       end   
   end   
end

print '@w_procesa: ' + @w_procesa

if @w_procesa = 'N' return 0
/******************************************************/

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec cob_externos..sp_estados
@i_producto    = 7,
@o_est_vencido = @w_vencido out,
@o_est_vigente = @w_vigente out

select 
@w_fecha_proceso = fp_fecha,
@w_fecha = isnull(@w_fecha_param, fp_fecha)
from cobis..ba_fecha_proceso

-- Calcular el ultimo dia habil del mes anterior
select @w_fecha = dateadd(dd, -day(@w_fecha) + 1 ,@w_fecha)

select @w_fecha_1 = dateadd(dd, -1, @w_fecha)
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_1) 
begin
   if datepart(dd, @w_fecha_1) != 1 select @w_fecha_1 = dateadd(dd, -1, @w_fecha_1) else break
end

print '@w_fecha_1:' + convert(varchar,@w_fecha_1)

select
   dop_banco            = do_banco, 
   dop_aplicativo       = do_aplicativo,
   dop_fecha            = do_fecha,
   dop_bco_pr_cr        = convert(varchar(64), ''),
-- -------------------- - --------------------------------------------- -----
   dop_oficina          = do_oficina,                                   -- 01
   dop_nom_ofi          = convert(varchar(64), ''),                     -- 02
   dop_regional         = convert(smallint, 0),                         -- 03
   dop_nom_reg          = convert(varchar(64), ''),                     -- 04
   dop_buc              = (select en_banco from cobis..cl_ente          -- 05
                           where en_ente = do_codigo_cliente),
   dop_cod_cli          = do_codigo_cliente,                            -- 06
   dop_ciclo_ind        = convert(int,0),                               -- 07
   dop_ciclo_grp        = case when do_tipo_operacion = 'GRUPAL' then do_numero_ciclos else convert(int,0) end, -- 08
   dop_exp_credit       = case ea_nivel_riesgo_cg                       -- 09
                          when 'C' then 'NO' else 'SI' end,
   dop_nro_ciclo_oi     = case ea_nro_ciclo_oi when 0 then ' '          -- 10
                          else convert(varchar,ea_nro_ciclo_oi) end,
   dop_num_cta_abi      = convert(smallint,0),                          -- 11
   dop_saldo_cta_abi    = convert(money,0),                             -- 12
   dop_num_cta_atrso    = convert(int, 0),                              -- 13
   dop_nivel_riesgo     = ea_nivel_riesgo_cg,                           -- 14
   dop_nivel_riesgo_des = case ea_nivel_riesgo_cg                       -- 15
                             when 'A' then 'RIESGO MUY BAJO'
                             when 'B' then 'RIESGO BAJO'
                             when 'C' then 'SIN EXPERIENCIA'
                             when 'D' then 'RIESGO ALTO'
                             when 'E' then 'RIESGO MUY ALTO (Condicionado)'
                             when 'F' then 'RIESGO INACEPTABLE'
                          end,
   dop_hizo_pag_sol     = convert(varchar(10), ' '),                    -- 16
   dop_reci_pag_sol     = convert(varchar(10), ' '),                    -- 17
   dop_canal_prin       = convert(varchar(10), ' '),                    -- 18
   dop_grupo_id         = isnull(convert(varchar(10), do_grupo),' '),   -- 19
   dop_nom_grp          = convert(varchar(64), ' '),                    -- 20
   dop_num_int          = (select convert(varchar,count(1))             -- 21
                           from cobis..cl_cliente_grupo 
                           where cg_grupo = do_grupo),
   dop_toperacion       = do_tipo_operacion,                            -- 22
   dop_sub_prod         = convert(varchar(64), ' '),                    -- 23
   dop_monto_pr_cr      = convert(money, 0),                            -- 24
   dop_atraso_pr_cr     = convert(int, 0),                         -- 25
   dop_atr_acu_pr_cr    = convert(int, 0),                         -- 26
   dop_monto_act_cr     = case when do_tipo_operacion = 'REVOLVENTE'    -- 27
                          then do_monto_aprobado
                          else do_monto end,
   dop_atraso_act_cr    = convert(int, 0),                         -- 28
   dop_atr_acu_act_cr   = convert(int, 0),                         -- 29
   dop_inc_monto        = convert(money, 0),                            -- 30
   dop_dec_monto        = convert(money, 0),                            -- 31
   dop_fecha_desem      = convert(datetime,null,103),           -- 32
   dop_saldo            = do_saldo,                                     -- 33
   dop_dias_mora_365    = do_dias_mora_365,                             -- 34
   dop_saldo_cap        = case when do_dias_mora_365 >= 8 
                          then do_saldo_cap else 0 end                  -- 35
-- -------------------- - ------------------------------------ -----
into #datos_operaciones
from sb_dato_operacion
inner join cobis..cl_ente_aux
on ea_ente = do_codigo_cliente
where (
   (do_estado_cartera in (1,2) and do_tipo_operacion = 'GRUPAL') OR 
   (do_tipo_amortizacion = 'ROTATIVA' and @w_fecha_1 between do_fecha_concesion and do_fecha_vencimiento))
and do_fecha      = @w_fecha_1


select count(1) from #datos_operaciones

create index dat_oper_idx1 on #datos_operaciones(dop_cod_cli)
create index dat_oper_idx2 on #datos_operaciones(dop_toperacion)
create index dat_oper_idx3 on #datos_operaciones(dop_banco)

select count(1) from #datos_operaciones

select distinct dop_cod_cli
into #datos_clientes_op
from #datos_operaciones

select distinct dop_banco
into #datos_opers_banco
from #datos_operaciones

update #datos_operaciones
set dop_nom_ofi = of_nombre,
    dop_regional = of_regional
from #datos_operaciones
inner join cobis..cl_oficina 
on dop_oficina = of_oficina 
and of_filial = @w_filial

update #datos_operaciones set 
dop_nom_reg = (select r.of_nombre from cobis..cl_oficina r 
               where dop_regional = r.of_oficina)
			   
select distinct op_banco banco
into #opers_solo_grp
from sb_operacion
inner join cob_credito..cr_tramite_grupal
on tg_referencia_grupal = op_banco
and op_fecha <= @w_fecha_1

select 
ciclo_ind = count(distinct(op_banco)) ,
cliente = op_cliente,
toper   = op_toperacion
into #oper_ciclo_ind
from #datos_operaciones
inner join sb_operacion 
on op_cliente = dop_cod_cli 
   and op_toperacion = dop_toperacion
and op_fecha <= @w_fecha_1
and op_banco not in (select banco from #opers_solo_grp)
group by op_cliente, op_toperacion

create index oper_ciclo_idx1 on #oper_ciclo_ind(cliente)
create index oper_ciclo_idx2 on #oper_ciclo_ind(toper)

update #datos_operaciones
set dop_ciclo_ind = ciclo_ind
from #datos_operaciones
inner join #oper_ciclo_ind
on cliente = dop_cod_cli
and toper = dop_toperacion


-- Para calculo de campo 11 No Ctas Abiertas, campo 12 Monto de la deuda (ctas abiertas) y  campo 13 No ctas con atraso menor a 90 díass
-- 2do
select 
saldo_actual = convert(money,replace(replace(bc_saldo_actual,'+',''),'-','')),
codigo_cliente = ib_cliente,
es_forma_pago = case when bc_forma_pago_actual in ('04', '03','02', '01', '00', 'UR') then 1 else 0 end
into #datos_buro_cuenta

from #datos_clientes_op
   inner join cob_credito..cr_interface_buro 
on ib_cliente = dop_cod_cli
inner join cob_credito..cr_buro_cuenta 
on ib_secuencial = bc_ib_secuencial
and bc_fecha_cierre_cuenta is null

create index buro_cta_idx1 on #datos_buro_cuenta(codigo_cliente)

select
cliente = codigo_cliente,
num_cta_abi = count(1),
saldo_cta_abi = sum(saldo_actual),
num_cta_atrso = sum(es_forma_pago)
into #datos_cta_abiertas
from #datos_operaciones
inner join #datos_buro_cuenta
on codigo_cliente = dop_cod_cli
and saldo_actual > 0
group by codigo_cliente

create index cta_abi_idx1 on #datos_cta_abiertas(cliente)

update #datos_operaciones set 
dop_num_cta_abi   = num_cta_abi,
dop_saldo_cta_abi = saldo_cta_abi,
dop_num_cta_atrso = num_cta_atrso
from #datos_operaciones
inner join #datos_cta_abiertas
on cliente = dop_cod_cli


/*
select distinct do_codigo_cliente mp_cod_cli, dd_concepto mp_concepto, count(dd_concepto) mp_veces,
row_number() over ( partition by do_codigo_cliente order by count(dd_concepto) desc) as row_ind
into #metodo_pago
from sb_dato_operacion
inner join #datos_clientes_op x
on x.dop_cod_cli = do_codigo_cliente
inner join sb_dato_transaccion 
on do_banco = dt_banco 
and do_fecha = dt_fecha
and do_aplicativo = dt_aplicativo
inner join sb_dato_transaccion_det 
on dt_fecha = dd_fecha 
and dd_banco = dt_banco
and dd_aplicativo = dt_aplicativo
and dt_secuencial = dd_secuencial
and dt_tipo_trans = 'PAG'
and dd_concepto in ('SANTANDER', 'OXXO', 'ELAVON')
and dd_fecha <= @w_fecha_1
group by do_codigo_cliente, dd_concepto*/
--- do_fecha por la de la nueva tabla no debo poblar la nueva tabla dado que sb_dato_transaccion ya tiene la ifnformación --- ****

--- Inicio cambio 1
--select distinct do_codigo_cliente mp_cod_cli, dd_concepto mp_concepto, count(dd_concepto) mp_veces,
--row_number() over ( partition by do_codigo_cliente order by count(dd_concepto) desc) as row_ind
select distinct op_cliente mp_cod_cli, dd_concepto mp_concepto, count(dd_concepto) mp_veces,
row_number() over ( partition by op_cliente order by count(dd_concepto) desc) as row_ind
into #metodo_pago
from sb_operacion
inner join #datos_clientes_op x
on x.dop_cod_cli = op_cliente
inner join sb_dato_transaccion 
on op_banco = dt_banco 
--and do_fecha = dt_fecha
and op_aplicativo = dt_aplicativo
inner join sb_dato_transaccion_det 
on dt_fecha = dd_fecha 
and dd_banco = dt_banco
and dd_aplicativo = dt_aplicativo
and dt_secuencial = dd_secuencial
and dt_tipo_trans = 'PAG'
and dd_concepto in ('SANTANDER', 'OXXO', 'ELAVON')
and dd_fecha <= @w_fecha_1
group by op_cliente, dd_concepto
--- Fin cambio 1

update #datos_operaciones set 
   dop_canal_prin = (select top 1 mp_concepto from #metodo_pago where mp_cod_cli = dop_cod_cli and row_ind = 1)
   
update #datos_operaciones 
set dop_nom_grp = gr_nombre
from #datos_operaciones 
inner join cobis..cl_grupo
on dop_grupo_id = gr_grupo
and dop_toperacion = 'GRUPAL'



select dop_banco ds_banco, 
       (case op_promocion 
       when 'S' then 'PROMOCION'
       when 'N' then 'TRADICIONAL' 
       else 'TRADICIONAL' end ) ds_sub_prod
into #datos_subproducto
from #datos_operaciones 
inner join cob_cartera..ca_operacion 
on op_banco = dop_banco 
and op_toperacion = 'GRUPAL'

update #datos_operaciones set
dop_sub_prod = ds_sub_prod
from #datos_operaciones
inner join #datos_subproducto
on dop_banco = ds_banco
and dop_toperacion = 'GRUPAL'

select 
banco = dc_banco, 
dia_max = max(case when dc_fecha_vto < dc_fecha_can then datediff(day, dc_fecha_vto, dc_fecha_can)
                   when dc_fecha_vto < @w_fecha_1 and dc_fecha_can is null then datediff(day, dc_fecha_vto, @w_fecha_1)
            else 0 end ),
dias  = sum(case when dc_fecha_vto < dc_fecha_can then datediff(day, dc_fecha_vto, dc_fecha_can)
                   when dc_fecha_vto < @w_fecha_1 and dc_fecha_can is null then datediff(day, dc_fecha_vto, @w_fecha_1)
            else 0 end )
into #dias_atraso
from sb_dato_cuota_pry 
inner join #datos_operaciones 
on dc_banco = dop_banco
and dc_fecha = @w_fecha_1
group by dc_banco

create index dias_atr_idx1 on #dias_atraso(banco)


-- Para calculo del campo 28 y 29
update #datos_operaciones set
dop_atr_acu_act_cr = dias,
dop_atraso_act_cr = dia_max
from #datos_operaciones
inner join #dias_atraso
on banco = dop_banco

select banco = dop_banco,
       fecha_desem = max(dt_fecha_trans)
into #oper_fecha_desm
from #datos_opers_banco
inner join sb_dato_transaccion
on dop_banco = dt_banco
and dt_tipo_trans='DES'
group by dop_banco
create index oper_fec_idx1 on #oper_fecha_desm(banco)

update #datos_operaciones set
dop_fecha_desem = fecha_desem
from #datos_operaciones
inner join #oper_fecha_desm   
on banco = dop_banco

-- ===================================================================================================================
-- Calculo de los campos 30 Incremento del Monto y 31 Decremento del Monto
if not object_id('tempdb..#operaciones_clientes') is null drop table #operaciones_clientes
create table #operaciones_clientes(
oc_cod_cli int, oc_monto money, oc_toper varchar(10), oc_banco varchar(64),
oc_fecha datetime null, oc_dias_atraso int null)

insert into #operaciones_clientes(oc_cod_cli,oc_banco,oc_toper, oc_monto, oc_fecha, oc_dias_atraso) --- reemplzar con la nueva tabla campo: op_monto ( fin de mes ca_operacion)
select distinct do_codigo_cliente,do_banco,do_tipo_operacion, do_monto, do_fecha, do_atraso_grupal
from cob_conta_super..sb_dato_operacion
inner join #datos_operaciones
-- Se necesita obtener los incrementos por cliente y por tipo de operacion
on do_codigo_cliente = dop_cod_cli
and do_tipo_operacion = dop_toperacion
and do_fecha <= @w_fecha_1
and do_tipo_operacion = 'GRUPAL'

insert into #operaciones_clientes(oc_cod_cli,oc_banco,oc_toper, oc_monto, oc_fecha, oc_dias_atraso) ---- dejar por dop_dias_mora_365
select distinct do_codigo_cliente,do_banco,do_tipo_operacion, max(do_monto), do_fecha, dop_dias_mora_365
from cob_conta_super..sb_dato_operacion
inner join #datos_operaciones
-- Se necesita obtener los incremntos por cliente y por tipo de operacion
on do_codigo_cliente = dop_cod_cli
and do_tipo_operacion = dop_toperacion
and do_fecha <= @w_fecha_1
and do_tipo_operacion = 'REVOLVENTE'
group by do_codigo_cliente,do_banco,do_tipo_operacion,do_fecha,dop_dias_mora_365

-- Tabla para calculo del campo 30 y 31
if not object_id('tempdb..#opers_incdec_clientes') is null drop table #opers_incdec_clientes 

create table #opers_incdec_clientes(
oc_ind int identity(1,1) primary key, oc_cod_cli int, 
oc_monto money, oc_toper varchar(10), oc_fecha datetime,
oc_banco varchar(30) )

insert into #opers_incdec_clientes (oc_cod_cli,oc_banco,oc_toper, oc_fecha, oc_monto)
select oc_cod_cli,oc_banco, oc_toper, max(oc_fecha) oc_fecha, oc_monto
from #operaciones_clientes
group by oc_cod_cli,oc_banco,oc_toper, oc_monto
order by oc_cod_cli,oc_banco, oc_toper, oc_fecha
create index opers_incdec_idx1 on #opers_incdec_clientes(oc_ind)
create index opers_incdec_idx2 on #opers_incdec_clientes(oc_cod_cli)
create index opers_incdec_idx3 on #opers_incdec_clientes(oc_toper)
select @w_ente_aux = 0


alter table #opers_incdec_clientes add siguiente_secuencial int 
alter table #opers_incdec_clientes add monto_sig money
alter table #opers_incdec_clientes add diferencia_montos money

-- Grupal 
select ind         = oc_ind,
       cod_cliente = oc_cod_cli,
       siguiente = (select min(oc_ind)
                       from #opers_incdec_clientes t
                       where t.oc_cod_cli = d.oc_cod_cli
                       and   t.oc_ind   > d.oc_ind
                       and   t.oc_toper =d.oc_toper),
       monto_siguiente  = convert(money,0)
into #obtencion_siguiente_grupal                       
from #opers_incdec_clientes d
where oc_toper= 'GRUPAL'

update #obtencion_siguiente_grupal set
monto_siguiente = oc_monto
from #opers_incdec_clientes
where cod_cliente = oc_cod_cli
and   siguiente   = oc_ind
and   oc_toper    = 'GRUPAL'

update #opers_incdec_clientes set
siguiente_secuencial =  siguiente,
monto_sig = monto_siguiente
from   #obtencion_siguiente_grupal
where cod_cliente = oc_cod_cli
and   ind         = oc_ind
and   oc_toper    = 'GRUPAL'
-- revolventes
select ind         = oc_ind,
       cod_cliente = oc_cod_cli,
       siguiente = (select min(oc_ind)
                       from #opers_incdec_clientes t
                       where t.oc_cod_cli = d.oc_cod_cli
                       and   t.oc_ind   > d.oc_ind
                       and   t.oc_toper =d.oc_toper),
       monto_siguiente  = convert(money,0)
into #obtencion_siguiente_revolvente                      
from #opers_incdec_clientes d
where oc_toper= 'REVOLVENTE'

update #obtencion_siguiente_revolvente set
monto_siguiente = oc_monto
from #opers_incdec_clientes
where cod_cliente = oc_cod_cli
and   siguiente   = oc_ind
and   oc_toper    = 'REVOLVENTE'

update #opers_incdec_clientes set
siguiente_secuencial =  siguiente,
monto_sig = monto_siguiente
from   #obtencion_siguiente_revolvente
where cod_cliente = oc_cod_cli
and   ind         = oc_ind
and   oc_toper    = 'REVOLVENTE'

--
update #opers_incdec_clientes set
diferencia_montos = monto_sig - oc_monto
where siguiente_secuencial is not null

select oc_cod_cli, 
oc_toper,
sumatoria = sum(diferencia_montos), 
conteo = count(1) - 1
into #calculos
from #opers_incdec_clientes
group by oc_cod_cli, oc_toper

select 
cod_cli = oc_cod_cli, 
toper   = oc_toper,   
valor   = case when conteo = 0 then 0 else sumatoria /conteo end
into #valores_finales
from #calculos

update #datos_operaciones set
      dop_dec_monto = case when valor <= 0 then abs(valor) else 0 end ,      
      dop_inc_monto = case when valor > 0 then valor else 0 end    
from #valores_finales
where dop_cod_cli  = cod_cli 
and dop_toperacion = toper
      
-- Calculo el campo 24 - Monto del crédito Primer Crédito (Ciclo 1)
--select dop_inc_monto,dop_dec_monto,* from #datos_operaciones
select 
cliente     = oc_cod_cli,
tipo_oper   = oc_toper,
fecha_min   = min(oc_fecha)
into #oper_min_toper
from #operaciones_clientes
group by oc_cod_cli,oc_toper --oc_banco, oc_monto, oc_toper, oc_dias_atraso

select 
cliente     = oc_cod_cli,
banco       = oc_banco,
monto       = oc_monto,
tipo_oper   = oc_toper,
fecha_min
into #oper_min
from #operaciones_clientes,
#oper_min_toper
where cliente     = oc_cod_cli
and   tipo_oper   = oc_toper
and   fecha_min   = oc_fecha

update #datos_operaciones set
dop_bco_pr_cr    = banco  ,
dop_monto_pr_cr  = monto
from #oper_min 
where  dop_cod_cli = cliente
and dop_toperacion = tipo_oper

-- Calculo del campo 25 - Días máximo de atraso (Primer Ciclo)
select 
cliente     = cliente, 
banco       = banco,
tipo_oper   = tipo_oper,
dias_atraso = max(oc_dias_atraso) 
into #dias_atraso_max
from #oper_min ,#operaciones_clientes
where banco     = oc_banco
and  tipo_oper  = oc_toper
group by cliente,banco,tipo_oper

update #datos_operaciones set
dop_atraso_pr_cr   = dias_atraso
from #dias_atraso_max
where  dop_cod_cli = cliente
and dop_toperacion = tipo_oper

create index dat_oper_idx4 on #datos_operaciones(dop_bco_pr_cr)

-- Calculo del campo 27 - Monto de crédito Actual (Último ciclo) 
select dc_banco, dc_num_cuota, max(dc_fecha_vto) dc_fecha_vto , max(dc_fecha_can) dc_fecha_can
into #cuota_operacion
from sb_dato_cuota_pry 
inner join #datos_operaciones 
on dc_banco = dop_bco_pr_cr 
and dc_toperacion = dop_toperacion
and dc_fecha = dop_fecha
and dc_fecha = @w_fecha_1
group by dc_banco, dc_num_cuota, dc_fecha_vto, dc_fecha_can

-- Calculo del campo 26 Días de atraso acumulado (Primer Ciclo)
update #datos_operaciones set 
dop_atr_acu_pr_cr = (
   select max(case when dc_fecha_vto < dc_fecha_can then datediff(day, dc_fecha_vto, dc_fecha_can) else 0 end )
   from #cuota_operacion where dc_banco = dop_bco_pr_cr )


if not object_id('sb_rpt_comp_clientes_cab') is null drop table sb_rpt_comp_clientes_cab
create table sb_rpt_comp_clientes_cab (nombres_columnas varchar(1024))
insert into sb_rpt_comp_clientes_cab values(
'OFICINA'                                          + '|' +  'NOMBRE OFICINA'                                   + '|' +
'ID REGION'                                        + '|' +  'REGION'                                           + '|' +
'BUC'                                              + '|' +  'NUMERO DE CLIENTE COBIS'                          + '|' +
'CICLO INDIVIDUAL'                                 + '|' +  'CICLO GRUPAL'                                     + '|' +
'EXPERIENCIA CREDITICIA VALIDADA'                  + '|' +  'EXPERIENCIA ACTUAL'                               + '|' +
'NUMERO DE CUENTAS ABIERTAS'                       + '|' +  'MONTO DE LA DEUDA (CUENTAS ABIERTAS)'             + '|' +
'NUMERO DE CUENTAS CON ATRASO MENOR A 90 DIAS'     + '|' +  'CALIFICACION DE MATRIZ DE RIESGOS'                + '|' +
'NIVEL DE RIESGO'                                  + '|' +  'CLIENTE REALIZO PAGO SOLIDARIO'                   + '|' +
'CLIENTE RECIBIO PAGO SOLIDARIO'                   + '|' +  'CANAL PRINCIPAL DE PAGO DEL CLIENTE'              + '|' +
'ID GRUPO'                                         + '|' +  'NOMBRE DEL GRUPO'                                 + '|' +
'NO. DE INTEGRANTES DEL GRUPO'                     + '|' +  'PRODUCTO'                                         + '|' +
'SUBPRODUCTO'                                      + '|' +  'MONTO DEL CREDITO PRIMER CREDITO (CICLO 1)'       + '|' +
'DIAS MAXIMO DE ATRASO (PRIMER CICLO)'             + '|' +  'DIAS DE ATRASO ACUMULADO (PRIMER CICLO)'          + '|' +
'MONTO DE CREDITO ACTUAL (ULTIMO CICLO)'           + '|' +  'DIAS MAXIMO DE ATRASO (CRÉDITO ACTUAL/VIGENTE)'   + '|' +
'DIAS DE ATRASO ACUMULADO (CREDITO ACTUAL/VIGENTE)'+ '|' +  'INCREMENTO DE MONTO'                              + '|' +
'DECREMENTO DE MONTO'                              + '|' +  'FECHA DE DESEMBOLSO'                              + '|' +
'SALDO CARTERA'                                    + '|' +  'DIAS DE MORA'                                     + '|' +
'MONTO DE CARTERA EN RIESGO'
)
----------------------------------------
-- Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_rpt_comp_clientes_cab out '

-- IS_COMPORTAMIENTO_YYMMDD.TXT
select @w_dest_cab = @w_path + 'IS_COMPORTAMIENTO_CAB_'  + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.txt',
       @w_errores  = @w_path + 'IS_COMPORTAMIENTO_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.err'

select @w_comando = @w_cmd + @w_dest_cab + ' -b1 -c -C RAW -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end
-- ====================
if not object_id('sb_rpt_comp_clientes_act') is null drop table sb_rpt_comp_clientes_act

select
'Oficina'                                          = dop_oficina                 ,           -- 01
'Nombre oficina'                                   = isnull(dop_nom_ofi, '')     ,           -- 02
'Id Región'                                        = isnull(dop_regional, 0)     ,           -- 03
'Región'                                           = isnull(dop_nom_reg, '')     ,           -- 04
'BUC'                                              = isnull(dop_buc, '')         ,           -- 05
'Numero de cliente COBIS'                          = dop_cod_cli          ,                  -- 06
'Ciclo Individual'                                 = isnull(dop_ciclo_ind, 0)    ,           -- 07
'Ciclo grupal'                                     = isnull(dop_ciclo_grp, 0)    ,           -- 08
'Experiencia crediticia validada'                  = isnull(dop_exp_credit, '')  ,           -- 09
'Experiencia actual'                               = isnull(dop_nro_ciclo_oi, ' ') ,         -- 10
'Número de cuentas abiertas'                       = isnull(dop_num_cta_abi, 0)  ,           -- 11
'Monto de la deuda (cuentas abiertas)'             = convert(varchar,                        -- 12
                                                     round(isnull(dop_saldo_cta_abi,0),
                                                     @w_decimales)),
'Número de cuentas con atraso menor a 90 días'     = isnull(dop_num_cta_atrso, 0),           -- 13
'Calificación de matriz de riesgos'                = isnull(dop_nivel_riesgo ,''),           -- 14
'Nivel de riesgo'                                  = isnull(dop_nivel_riesgo_des, ' '),      -- 15
'Cliente realizó pago solidario'                   = isnull(dop_hizo_pag_sol, ' '),          -- 16
'Cliente recibió pago solidario'                   = isnull(dop_reci_pag_sol, ' '),          -- 17
'Canal principal de pago del cliente'              = isnull(dop_canal_prin, ' '),             -- 18
'Id grupo'                                         = isnull(dop_grupo_id, ' ') ,             -- 19
'Nombre del grupo'                                 = isnull(dop_nom_grp, ' ')     ,          -- 20
'No. de integrantes del grupo'                     = isnull(dop_num_int, ' ')      ,         -- 21
'Producto'                                         = dop_toperacion       ,                  -- 22
'Subproducto'                                      = isnull(dop_sub_prod, ' ')    ,           -- 23
'Monto del crédito Primer Crédito (Ciclo 1)'       = convert(varchar,                        -- 24
                                                     round(isnull(dop_monto_pr_cr,0),
                                                     @w_decimales)),
'Días máximo de atraso (Primer Ciclo)'             = isnull(dop_atraso_pr_cr, 0) ,           -- 25
'Días de atraso acumulado (Primer Ciclo)'          = isnull(dop_atr_acu_pr_cr, 0),           -- 26
'Monto de crédito Actual (Último ciclo)'           = convert(varchar,                        -- 27
                                                     round(isnull(dop_monto_act_cr,0),
                                                     @w_decimales)),
'Días máximo de atraso (Crédito Actual/vigente)'   = isnull(dop_atraso_act_cr , 0),          -- 28
'Días de atraso acumulado (Crédito Actual/vigente)'= isnull(dop_atr_acu_act_cr, 0),          -- 29
'Incrementó de monto'                              = convert(varchar,                        -- 30
                                                     round(isnull(dop_inc_monto,0),
                                                     @w_decimales)),
'Decremento de monto'                              = convert(varchar,                        -- 31
                                                     round(isnull(dop_dec_monto,0),
                                                     @w_decimales)),
'Fecha de desembolso'                              = convert(varchar,dop_fecha_desem,23),    -- 32
'Saldo Cartera'                                    = convert(varchar,round(dop_saldo,        -- 33
                                                     @w_decimales)),
'Días de mora'                                     = dop_dias_mora_365    ,                  -- 34
'Monto de cartera en riesgo'                       = convert(varchar,                        -- 35
                                                     round(isnull(dop_saldo_cap,0),
                                                      @w_decimales))
into sb_rpt_comp_clientes_act
from #datos_operaciones

--select * from sb_rpt_comp_clientes_act

----------------------------------------
-- Generar Archivo Plano
----------------------------------------
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_rpt_comp_clientes_act out '

-- IS_COMPORTAMIENTO_YYMMDD.TXT
select @w_destino  = @w_path + 'IS_COMPORTAMIENTO_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.txt',
       @w_errores  = @w_path + 'IS_COMPORTAMIENTO_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.err'

select @w_comando = @w_cmd + @w_path + 'rptcompcliact -b5000 -c -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end

-- ------
select @w_comando = 'copy ' + @w_dest_cab + ' + ' + @w_path + 'rptcompcliact ' + @w_destino
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 101254, @w_mensaje = 'Error Agregando Cabeceras ' + @w_comando
   goto ERROR_PROCESO
end


return 0

ERROR_PROCESO:
print 'Error ----> '
select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted
exec @w_return       = sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go