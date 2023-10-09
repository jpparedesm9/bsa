/************************************************************************/
/*   Stored procedure:     sp_batch_env_sms_cobranza                  	*/
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Alexander Inca	                            */
/*   Fecha de escritura:   Octubre. 2020                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */

/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/* Procedimiento que obtiene la información del cliente para el envío   */
/* del sms																*/
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA         AUTOR    CAMBIO                                   */
/*   OCT-12-2020      AIN      Versión incial                           */
/*   JUL-01-2022      WTO      Req#180130- Apicacion de Regla SMSCOBDIEN*/
/*                             y envio a mesa directiva y 2 miembros más*/
/*   SEP-21-2022      AIN      Corrección fecha de ejecución            */
/*   OCT-12-2022      MTE      Corrección y Ajuste de Universo          */

/************************************************************************/
use cob_cartera
go

if exists ( select 1 from sysobjects where name = 'sp_batch_env_sms_cobranza' )
   drop proc sp_batch_env_sms_cobranza
go

create proc sp_batch_env_sms_cobranza (
   @i_param1      date
)
as

declare @w_dia             int,
        @w_plantilla       varchar (10),
        @w_cliente         int,
        @w_telefono        varchar(12),
        @w_bloque          varchar(2),
        @w_dia_min         int,
        @w_dia_max         int,
        @w_num_dia         int,
		@w_tiempo_mes      int,
		@w_sp_name         varchar(25),
		@w_fecha_elim      date,
		@w_error           int,
		@w_msg             varchar(250),
		@w_fecha_ejec      datetime ,
	    @w_grp_ant		   int,
	    @w_grupo	       int,
		@w_cant_miem       tinyint,
		@w_miem_faltante   tinyint,
        @w_cant_a_notif    tinyint,
		@w_nombre_dia      varchar(50),
		@w_fecha           date,		
		@w_result_values   varchar(255), 
		@w_parent          varchar(255), 
		@w_valores         varchar(255), 
		@w_part            varchar(255),
		@w_dias_atraso_ini int,
		@w_dias_atraso_fin int,
		@w_restriccion     varchar(1),
		@w_ciudad_nacional int,
		@w_rol             smallint,
		@w_variables       varchar(255),
		@w_primer_dia      datetime,
		@w_ultimo_dia      datetime,
		@w_conteo_grupos   int,
      @w_est_vigente     int,
      @w_est_vencido     int,
      @w_est_etapa2      int,
      @w_est_castigado   int, 
      @w_est_cancelado   int,    
		@w_fecha_valida    datetime
		
--Estados de cartera
/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
   @o_est_vigente   = @w_est_vigente   out,
   @o_est_vencido   = @w_est_vencido   out,
   @o_est_etapa2    = @w_est_etapa2    out,
   @o_est_castigado = @w_est_castigado out, 
   @o_est_cancelado = @w_est_cancelado out

if @w_error <> 0
begin
   print 'Error ejecucion sp_estados_cca'
   goto ERROR
end

select @w_sp_name = 'sp_batch_env_sms_cobranza'
print 'Comienza la ejecución del sp: ' + @w_sp_name
print 'Fecha de ingreso es: ' + convert(varchar,@i_param1,103)

if @i_param1 is null
begin
   select @w_fecha = fp_fecha 
   from cobis..ba_fecha_proceso   
end
else
begin
   select @w_fecha = @i_param1
end

-- Cantidad de Miembros a Notificar
select @w_cant_a_notif = pa_tinyint 
from cobis..cl_parametro
where pa_nemonico ='SMSCOB' 
and pa_producto = 'CCA'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

-- INI - obtener el dia habil anterior - sp
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

-- Se verifica que la fecha para la consulta sea la de incio de día
while exists(select 1 
			from cobis..cl_dias_feriados 
			where df_ciudad = @w_ciudad_nacional	
			 and   df_fecha  = @w_fecha )
begin
   select @w_fecha = dateadd(day,-1,@w_fecha)
end 
-- FIN - obtener el dia habil anterior - 

-- Número de tiempo para mantener los datos de la tabla historica ca_ns_sms_cobranzas_his
select @w_tiempo_mes = pa_smallint 
from cobis..cl_parametro 
where pa_nemonico= 'TPERSC'

if @w_tiempo_mes < 0
begin
   select @w_tiempo_mes = 3
end

select @w_fecha_elim = DATEADD(month,(-1)*@w_tiempo_mes,@i_param1)

-- Fecha del primer día de la semana de acuerdo a la fecha
select @w_primer_dia = dateadd(week, datediff(week, 0, @w_fecha), 0);
print 'Primer dia de la semana: ' + isnull(convert(varchar(10),@w_primer_dia,103),'')

-- Fecha del ultimo dia de la semana de acuerdo a la fecha de ingreso
select @w_ultimo_dia = dateadd(day,4,@w_primer_dia)
print 'Ultimo dia de la semana: ' + isnull(convert(varchar(10),@w_ultimo_dia,103),'')

print 'Tiempo de espera para eliminar datos de la tabla ca_ns_sms_cobranzas_his: ' + convert(varchar(2),@w_tiempo_mes) 
print 'Fecha para eliminar los datos:' + convert(varchar(20),@w_fecha_elim,103)

select @w_fecha_ejec = CONVERT(DATETIME, CONVERT(CHAR(8), @i_param1, 112) + ' ' + CONVERT(CHAR(8), getdate(), 108))

-- Se elimina los datos de la tabla historica de acuerdo al parametro - sp
delete from cob_cartera_his..ca_ns_sms_cobranzas_his
where nsc_fecha_ing <= @w_fecha_elim

-- Se obtiene la plantilla
select @w_plantilla = codigo 
from cobis..cl_catalogo 
where tabla = (select codigo 
               from cobis..cl_tabla 
               where tabla = 'ns_plantilla_sms') 
and   valor = 'Tuiio_Cuida_Situacion_Financiera'

if @w_plantilla is null
begin
   select @w_msg = 'No existe plantilla para envío de sms'
   select @w_error = 70011018
end

select @w_fecha_valida =  nsc_fecha_ing from cob_cartera..ca_ns_sms_cobranzas order by nsc_fecha_ing desc
-- Paso a historicos
if (convert(varchar(10),@w_fecha,103) <> convert(varchar(10), @w_fecha_valida, 103) )
begin
    print 'Validacion para paso a historicos'
insert into cob_cartera_his..ca_ns_sms_cobranzas_his
select *
from ca_ns_sms_cobranzas
end

-- Se obtiene el maximo secuencial de la tabla historica
select @w_dia = isnull(max(nsc_dia)+1,1) 
from cob_cartera_his..ca_ns_sms_cobranzas_his 
  
truncate table ca_ns_sms_cobranzas

create table #fechaVenUniverso 
(
   operacion int, 
   cliente int, 
   fecha_ven datetime,
   num_dia_atraso int, 
   num_dia_dezplamiento int,
   total_dia int,
   grupo int,
   rol_cliente varchar(10),
   num_telefono varchar(12),
   tramite int
)

insert into #fechaVenUniverso 
(
   operacion,
   cliente,
   fecha_ven,
   num_dia_dezplamiento,
   grupo,
   num_telefono,
   tramite
)
select op_operacion,
       op_cliente,
       min(di_fecha_ven),
       0,
       tg_grupo,
       '',
	   tg_tramite
from cob_cartera..ca_operacion,
     cob_cartera..ca_estado,
     cob_cartera..ca_dividendo,
     cob_credito..cr_tramite_grupal
where op_estado = es_codigo
and es_procesa = 'S'
and tg_prestamo = op_banco
and di_operacion = op_operacion
and tg_operacion = op_operacion
and di_estado = @w_est_vencido
and tg_participa_ciclo = 'S'
and tg_monto > 0
and tg_prestamo != tg_referencia_grupal 
group by tg_tramite,op_operacion,op_cliente,tg_grupo

update #fechaVenUniverso
set num_dia_atraso = DATEDIFF(DAY, fecha_ven, @w_fecha)

select de_operacion, 
       sum(DATEDIFF(DAY, de_fecha_ini, de_fecha_fin)) as dia_desplazamiento
into #desplazamiento_tmp
from cob_cartera..ca_desplazamiento 
where de_estado = 'A'
group by de_operacion

update #fechaVenUniverso 
set num_dia_dezplamiento = dia_desplazamiento    
from #desplazamiento_tmp
where de_operacion = operacion

update #fechaVenUniverso 
set total_dia = num_dia_atraso - num_dia_dezplamiento 

-- Dia de la semana
SELECT @w_nombre_dia = (CASE DATENAME(dw,@w_fecha)
                         when 'Monday'    then 'LUNES'
                         when 'Tuesday'   then 'MARTES'
                         when 'Wednesday' then 'MIERCOLES'
                         when 'Thursday'  then 'JUEVES'
                         when 'Friday'    then 'VIERNES'
                         when 'Saturday'  then 'SABADO'
                         when 'Sunday'    then 'DOMINGO'
                        END)  -- sp
print 'Nombre del día ' + @w_nombre_dia

select  @w_valores = 'GRUPAL|' + @w_nombre_dia -- tOper|diaSemana

exec @w_error = cob_pac..sp_rules_param_run
@s_rol                     = @w_rol,
@i_rule_mnemonic           =  'SMSCOBDIEN',
@i_var_values              = @w_valores,
@i_var_separator           = '|',
@i_modo                    = 'S',
@i_tipo                    = 'S',
@o_return_variable         = @w_variables     out,
@o_return_results          = @w_result_values out, -- DIAS ATRASO INICIO|IAS ATRASO FIN|RESTRICCION
@o_last_condition_parent   = @w_parent         out

print 'w_valores= '+@w_valores + ' :: w_variables= ' + @w_variables
-- print 'RETURN '+convert(varchar,@w_error)
if @w_error <> 0 
begin
	select @w_msg = 'Error al ejecutar regla Sms Cobranza Dias de Envio',
	       @w_error = 103163
	goto ERROR
end
print 'Resultado: '+@w_result_values -- '3|40|S|'

select @w_dias_atraso_ini = convert(int,SUBSTRING(@w_result_values,0, CHARINDEX('|',@w_result_values)))
select @w_part = SUBSTRING(@w_result_values,CHARINDEX('|',@w_result_values)+1, len(@w_result_values))
select @w_dias_atraso_fin = convert(int,SUBSTRING(@w_part,0, CHARINDEX('|',@w_part)))
select @w_restriccion = SUBSTRING(@w_part,CHARINDEX('|',@w_part)+1, 1) -- S/N

delete from #fechaVenUniverso where total_dia not between @w_dias_atraso_ini and @w_dias_atraso_fin

if @w_restriccion = 'S'
begin
    print 'Ingreso a eliminar por la restriccion'
	select cliente,
		   grupo
	into #sms_enviado
	from #fechaVenUniverso
	inner join cob_cartera_his..ca_ns_sms_cobranzas_his
	on cliente = nsc_cliente
	where nsc_fecha_ing >= @w_primer_dia
	and nsc_fecha_ing <= dateadd(day,1,@w_ultimo_dia)
	 
	select @w_conteo_grupos = count(grupo) from #sms_enviado
	print 'La cantidad de grupos en historico: ' + convert(varchar,@w_conteo_grupos)

	delete from #fechaVenUniverso
	where grupo in (select grupo from #sms_enviado)
end

-- ---------------------------------------------------------------
select grupo, tramite
into #GruposAEnviar
from #fechaVenUniverso
group by grupo, tramite

-- Mesa Directiva
select grupo, tramite, cg_ente cliente
into #MiembrosAEnviar
from #GruposAEnviar, cobis..cl_cliente_grupo
where cg_grupo = grupo
and cg_estado='V'
and cg_rol in ('P','S','T') -- @w_cant_a_notif

-- Validar si la mesa directiva no esta cancelada la operacion
delete  #MiembrosAEnviar
from cob_credito..cr_tramite_grupal,
     cob_cartera..ca_operacion
where tramite = tg_tramite
and cliente = tg_cliente
and tg_operacion = op_operacion
and op_estado = @w_est_cancelado

-- 2 Miembros y Faltantes de Mesa Directiva
select  @w_grupo = 0
while (exists (select 1 from #MiembrosAEnviar where grupo > @w_grupo))
begin
    select top 1
	@w_grupo  = grupo
	from #MiembrosAEnviar
	where grupo > @w_grupo
	order by grupo
	
	select @w_cant_miem = 0
	select @w_cant_miem = count(grupo)
	from #MiembrosAEnviar
	where grupo = @w_grupo

	select @w_miem_faltante = @w_cant_a_notif - @w_cant_miem + 2
	print 'Grupo=' + isnull(convert(varchar(100),@w_grupo),'') +' :: w_miem_faltante=' + isnull(convert(varchar(100),@w_miem_faltante),'')

	insert into #MiembrosAEnviar
	select top (@w_miem_faltante)
		grupo, 
		tramite, 
		cg_ente
	from #GruposAEnviar, 
	     cobis..cl_cliente_grupo,
	     cob_cartera..ca_operacion
	where cg_grupo = grupo
	and cg_ente = op_cliente
	and cg_estado='V'
	and cg_rol = 'M'
	and grupo = @w_grupo
	and op_estado in (@w_est_vigente, @w_est_vencido, @w_est_etapa2, @w_est_castigado)
	group by grupo, tramite, cg_ente
end
-- ---------------------------------------------------------------

create table #miembros_total(
   operacion int, 
   cliente int, 
   fecha_ven datetime,
   grupo int,
   rol_cliente varchar(10),
   num_telefono varchar(12)
)

insert into #miembros_total(
   operacion,
   cliente,
   fecha_ven,
   grupo,
   rol_cliente,
   num_telefono
)
select di_operacion,
       tg_cliente,
       max(di_fecha_ven),
       tg_grupo,
       '',
	   ''
from #MiembrosAEnviar,
     cob_cartera..ca_dividendo,
     cob_credito..cr_tramite_grupal
where tg_operacion = di_operacion
and tg_tramite = tramite
and tg_cliente = cliente
and di_estado = @w_est_vencido
group by di_operacion,tg_cliente,tg_grupo

update #miembros_total
set fecha_ven = (select max(di_fecha_ven) 
				from cob_cartera..ca_dividendo 
				where operacion = di_operacion 
				and di_estado in (@w_est_vencido, @w_est_cancelado)) -- CANCELADO

update #miembros_total
set rol_cliente = cg_rol
from cobis..cl_cliente_grupo
where cg_ente = cliente
and cg_grupo = grupo

update #miembros_total
set num_telefono = te_valor
from cobis..cl_telefono
where te_ente = cliente
and te_tipo_telefono = 'C'

insert into ca_ns_sms_cobranzas 
 select  nsc_dia         =  @w_dia,    
         nsc_operacion   =  operacion,
         nsc_cliente     =  cliente,
         nsc_num_telf    =  num_telefono,
         nsc_bloque      =  -1,
         nsc_plantilla   =  @w_plantilla,
         nsc_grupo       =  grupo,
         nsc_fecha_ven   =  fecha_ven,
         nsc_rol_cliente =  rol_cliente,
         nsc_fecha_ing   =  @w_fecha_ejec,
         nsc_estado      =  'N',
         nsc_fecha_env   =  null
  from #miembros_total
-- -----

return 0

ERROR:
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
		@i_msg    = @w_msg
   return @w_error

go
