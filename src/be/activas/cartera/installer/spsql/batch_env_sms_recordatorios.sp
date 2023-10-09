/************************************************************************/
/*   Stored procedure:     sp_batch_env_sms_recordatorios             	*/
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
/* del sms	por recordatorio de vencimiento de cuotas                	*/
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA       AUTOR    CAMBIO                                     */
/*   OCT-16-2020    AIN      Versión incial                             */
/*   SEP-03-2022    ACH      #180130 Modificaciones SMS Cobranza --     */
/************************************************************************/
use cob_cartera
go

if exists ( select 1 from sysobjects where name = 'sp_batch_env_sms_recordatorios' )
   drop proc sp_batch_env_sms_recordatorios
go

create proc sp_batch_env_sms_recordatorios (
   @i_param1      date
)
as

declare 
   @w_return               int,
   @w_sp_name              varchar(100),
   @w_msg                  varchar(255),
   @w_fecha                date,
   @w_fecha_vencimiento    date,
   @w_valores              varchar(255),
   @w_resultado            varchar(255),
   @w_num_dias             int,
   @w_error                int,
   @w_nombre_dia           varchar(50),
   @w_bloque_mens          varchar(1),
   @w_bloque_plantilla     int,
   @w_ciudad_nacional      int,
   @w_plantilla            varchar (10),
   @w_tiempo_mes           int,		
   @w_fecha_elim           date,
   @w_fecha_ejec           datetime,
   @w_grp_ant			   int,
   @w_grupo		           int,
   @w_miem_faltante        int,
   @w_cant_a_notif         tinyint,
   @w_cant_miem            int,
   @w_permiso_eje          char(1),
   @w_est_vigente          int,
   @w_est_vencido          int,
   @w_est_etapa2           int

select @w_sp_name = 'sp_batch_env_sms_recordatorios'

print 'FechaDentrada:  ' + convert(varchar, @i_param1)

if @i_param1 is null
begin 
   select @w_fecha = fp_fecha 
   from cobis..ba_fecha_proceso   
end
else
begin
   select @w_fecha = @i_param1
end
-- Permiso de insercción
select @w_permiso_eje = 'S'

-- Cantidad de Miembros a Notificar
select @w_cant_a_notif = pa_tinyint 
from cobis..cl_parametro
where pa_nemonico ='SMSPRE'
and pa_producto = 'CCA'

-- Enviar los datos a la tabla historica
insert into cob_cartera_his..ca_ns_sms_recordatorios_his
select *
from ca_ns_sms_recordatorios

-- Se elimina los datos de la tabla antes de cada ejecución
truncate table ca_ns_sms_recordatorios

-- Número de tiempo para mantener los datos de la tabla ca_ns_sms_recordatorios_his - sp
select @w_tiempo_mes = pa_smallint 
from cobis..cl_parametro 
where pa_nemonico= 'TPERSR'

if @w_tiempo_mes < 0
begin
   select @w_tiempo_mes = 3
end

select @w_fecha_elim = DATEADD(month,(-1)*@w_tiempo_mes,@i_param1)
print 'Tiempo de espera para eliminar de ca_ns_sms_recordatorios_his -> ' + convert(varchar(2),@w_tiempo_mes) + '-->>Fecha para eliminar los datos -> ' + convert(varchar(20), @w_fecha_elim)

-- Fecha y hora real de ejecución
select @w_fecha_ejec = CONVERT(DATETIME, CONVERT(CHAR(8), @i_param1, 112) + ' ' + CONVERT(CHAR(8), getdate(), 108))

-- Se elimina los datos de la tabla ca_ns_sms_recordatorios_his de acuerdo al parametro
delete from cob_cartera_his..ca_ns_sms_recordatorios_his
where nsc_fecha_ing <= @w_fecha_elim

-- Se obtiene el numero del bloque que se asocia con las variables de cada mensaje
select @w_bloque_mens = codigo 
from cobis..cl_catalogo 
where tabla = (select codigo 
               from cobis..cl_tabla 
               where tabla = 'ns_bloque_sms') 
and   valor = 'RECORDATORIO'

-- Se obtiene el parametro de ciudad de nacimiento
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--Estados de cartera
/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
   @o_est_vigente   = @w_est_vigente   out,
   @o_est_vencido   = @w_est_vencido   out,
   @o_est_etapa2    = @w_est_etapa2    out

if @w_error <> 0
begin
   print 'Error ejecucion sp_estados_cca'
   goto ERROR
end
   

SELECT @w_nombre_dia = (CASE DATENAME(dw,@w_fecha)
                         when 'Monday'    then 'LUNES'
                         when 'Tuesday'   then 'MARTES'
                         when 'Wednesday' then 'MIERCOLES'
                         when 'Thursday'  then 'JUEVES'
                         when 'Friday'    then 'VIERNES'
                         when 'Saturday'  then 'SABADO'
                         when 'Sunday'    then 'DOMINGO'
                        END)
                        
print 'Nombre del día ' + @w_nombre_dia

----->>>PRIMERA EJECUCION
-- Se obtiene el número de días de acuerdo a la regla SMSR
select  @w_valores = @w_bloque_mens+ '|' + @w_nombre_dia 

-- SE EJECUTA REGLA DE VALIDACION DE NUMERO DE VALIDACION PARA VENCIMIENTO DE OPERACIONES	
exec @w_error           = cob_cartera..sp_ejecutar_regla
	 @s_ssn                  = 1,
	 @s_ofi                  = 1,
	 @s_user                 = 'usrbatch',
	 @s_date                 = @w_fecha,
	 @s_srv                  = 1,
	 @s_term                 = '0.0.0.0',
	 @s_rol     = 1,
	 @s_lsrv                 = 1,
	 @s_sesn                 = 1,
	 @i_regla                = 'SMSR', 
	 @i_tipo_ejecucion       = 'REGLA',     
	 @i_valor_variable_regla = @w_valores,
	 @o_resultado1           = @w_resultado out

if @w_error <> 0
begin
   select @w_msg = 'ERROR AL EJECUTAR REGLA RECORDATORIO DE SMS' 
   goto ERROR
end

select @w_num_dias = convert(int,@w_resultado)
select @w_fecha_vencimiento = dateadd(day,@w_num_dias,@w_fecha) --Fecha de vencimiento = fecha de ingreso mas numeros de días

print 'fecha_ven_uno: ' + convert(varchar, @w_fecha_vencimiento) + '>>>num_dias: ' + convert(varchar, @w_num_dias) -- = '09/01/2022 00:00:00'-- (div atrasado) -- '09/26/2022' (vigente)--borrar--se agrega por pruebas

-- verificar si la fecha de vencimiento a enviar sms es feriado no debe ejecutar el proceso
if exists(select 1 
             from cobis..cl_dias_feriados 
			 where df_ciudad = @w_ciudad_nacional	
			 and   df_fecha  = @w_fecha_vencimiento ) 
begin
   print 'La fecha de vencimiento ingresada es feriado por lo tanto no realiza ejecución'
   select @w_permiso_eje = 'N'
end

select @w_plantilla = codigo 
from cobis..cl_catalogo 
where tabla = (select codigo 
               from cobis..cl_tabla 
               where tabla = 'ns_plantilla_sms') 
and   valor = 'Tuiio_Pago_Grupal_Proximo'

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>ACHP
-->>CREACION DE TABLA UNIVERSO PRINCIPAL -- TODAS LAS OPERACIONES EN ESTADO VIGENTE
create table #op_hijas_vigentes(
    grupo          int, 
    operacion_hija int, 
    integrante     int,
    banco_padre    cuenta,
    estado_div     int,
    fecha_ven      datetime,
    tramite        int,
    rol            char(19),
    num_telefono   varchar(16),
	dia_ejecucion  varchar(20)
)

-->>-->>-->>-->>Primera ejecucion
--Universo de operaciones vigentes
insert into #op_hijas_vigentes
select tg_grupo, 
       tg_operacion, 
       tg_cliente, --miembro
       tg_referencia_grupal, 
	   di_estado , 
	   di_fecha_ven,
       op_tramite,
       '',
	   '',
	   @w_nombre_dia
from cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion, cob_cartera..ca_dividendo
where tg_prestamo = op_banco
and tg_participa_ciclo = 'S'
and tg_monto > 0
and op_estado in (@w_est_vigente, @w_est_etapa2)
and di_operacion = tg_operacion
and di_fecha_ven = @w_fecha_vencimiento
and di_estado = @w_est_vigente
 
--select 'aa' = count(1) from #op_hijas_vigentes
-->>-->>-->>-->>Segunda ejecucion
if @w_nombre_dia = 'VIERNES'
begin
	print 'INGRESO A VIERNES***'
	select @w_nombre_dia = 'VIERNES**'
	  
	select @w_permiso_eje = 'S'
	  
	-- Se obtiene el número de días de acuerdo a la regla SMSR - sp
	select  @w_valores = @w_bloque_mens+ '|' + @w_nombre_dia 

	--SE EJECUTA REGLA DE VALIDACION DE NUMERO DE VALIDACION PARA VENCIMIENTO DE OPERACIONES	 - sp
	exec @w_error           = cob_cartera..sp_ejecutar_regla
	@s_ssn                  = 1,
	@s_ofi                  = 1,
	@s_user                 = 'usrbatch',
	@s_date                 = @w_fecha,
	@s_srv                  = 1,
	@s_term                 = '0.0.0.0',
	@s_rol                  = 1,
	@s_lsrv                 = 1,
	@s_sesn                 = 1,
	@i_regla                = 'SMSR', 
	@i_tipo_ejecucion       = 'REGLA',     
	@i_valor_variable_regla = @w_valores,
	@o_resultado1           = @w_resultado out

	if @w_error <> 0
	begin
	  select @w_msg = 'ERROR AL EJECUTAR REGLA RECORDATORIO DE SMS' 
	  goto ERROR
	end
   
    select @w_num_dias = 0
	select @w_num_dias = convert(int,@w_resultado)
	select @w_fecha_vencimiento = dateadd(day,@w_num_dias,@w_fecha) -- w_fecha_aux: dia ant habil  -- 20220809
	print 'fecha_ven_dos: ' + convert(varchar, @w_fecha_vencimiento) + '>>>num_dias: ' + convert(varchar, @w_num_dias) -- = '09/01/2022 00:00:00'-- (div atrasado) -- '09/26/2022' (vigente)--borrar--se agrega por pruebas

	-- Se obtiene el sgte día hábil
	if exists(select 1 
				 from cobis..cl_dias_feriados 
				 where df_ciudad = @w_ciudad_nacional	
				 and   df_fecha  = @w_fecha_vencimiento ) 
	begin
       print 'La fecha de vencimiento ingresada es feriado por lo tanto no realiza ejecución'
       select @w_permiso_eje = 'N'
	end

    insert into #op_hijas_vigentes
    select tg_grupo, 
           tg_operacion, 
           tg_cliente, --miembro
           tg_referencia_grupal, 
    	   di_estado , 
    	   di_fecha_ven,
           op_tramite,
           '',
    	   '',
		   @w_nombre_dia
    from cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion, cob_cartera..ca_dividendo
    where tg_prestamo = op_banco
    and tg_participa_ciclo = 'S'
    and tg_monto > 0
    and op_estado in (@w_est_vigente, @w_est_etapa2)
    and di_operacion = tg_operacion
    and di_fecha_ven = @w_fecha_vencimiento
    and di_estado = @w_est_vigente
end
--select 'total' = count(1), grupo from #op_hijas_vigentes group by grupo
--select top 4 * from #op_hijas_vigentes

update #op_hijas_vigentes set rol = cg_rol
from cobis..cl_cliente_grupo where cg_grupo = grupo and cg_ente = integrante
and cg_estado = 'V'

update #op_hijas_vigentes set num_telefono = te_valor
from cobis..cl_telefono
where te_ente = integrante
and te_tipo_telefono = 'C'

--Universo de operaciones vigentes que no tienen dividendos atrasado
select * 
into #operaciones_sin_coutas_atrasadas -- operacion sin cuotas atrasadas
from #op_hijas_vigentes
where not exists (select 1 from cob_cartera..ca_dividendo where di_operacion = operacion_hija and di_estado = @w_est_vencido )

-- =================================================
create table #fechaVenUniverso 
(
   operacion           int, 
   cliente             int,
   num_dia             int,
   nombre_dia          varchar(25),
   fecha_ejec          datetime,
   fecha_ven_hab       datetime,
   grupo               int,
   rol_cliente         varchar(10),
   num_telefono        varchar(12),
   tramite int
)

insert into #fechaVenUniverso 
(
   operacion,
   cliente,
   num_dia,
   nombre_dia,
   fecha_ejec,
   fecha_ven_hab,
   grupo,
   num_telefono,
   tramite
)
select operacion_hija,
       integrante,
       @w_num_dias,
       @w_nombre_dia,
       @w_fecha,
	   fecha_ven,
	   grupo, 
	   '',
	   tramite
from #operaciones_sin_coutas_atrasadas

select ge_grupo = grupo, ge_tramite = tramite
into #GruposAEnviar
from #fechaVenUniverso
group by grupo, tramite

-- Mesa Directiva
select me_grupo = grupo, me_tramite = tramite, me_integrante = integrante
into #MiembrosAEnviar
from #operaciones_sin_coutas_atrasadas
where rol in ('P','S','T')
 
-- 2 Miembros y Faltantes de Mesa Directiva
select  @w_grupo = 0

--select 'xx_total' = count(1), me_grupo from #MiembrosAEnviar group by me_grupo

while (exists (select 1 from #MiembrosAEnviar where me_grupo > @w_grupo))
begin
    select top 1
	@w_grupo  = me_grupo
	from #MiembrosAEnviar
	where me_grupo > @w_grupo
	order by me_grupo
	
	select @w_cant_miem = 0
	select @w_cant_miem = count(me_grupo)
	from #MiembrosAEnviar
	where me_grupo = @w_grupo

	select @w_miem_faltante = @w_cant_a_notif - @w_cant_miem
	print 'Grupo=' + isnull(convert(varchar(100),@w_grupo),'-') +' :: w_miem_faltante=' + isnull(convert(varchar(100),@w_miem_faltante),'-')

	insert into #MiembrosAEnviar
	select top (@w_miem_faltante)
		grupo, 
		tramite, 
		integrante--cg_ente	
	from #GruposAEnviar, #operaciones_sin_coutas_atrasadas
	where ge_grupo = grupo
	and ge_tramite = tramite	
	and rol = 'M'
	and grupo = @w_grupo
	group by grupo, tramite, integrante

end
--select 'yy_total' = count(1), me_grupo from #MiembrosAEnviar group by me_grupo
-- ---------------------------------------------------------------
create table #miembros_total(
   operacion int, 
   cliente int, 
   fecha_ven datetime,
   grupo int,
   rol_cliente varchar(10),
   num_telefono varchar(12),
   num_dia int,
   nombre_dia varchar(25),
   fecha_ejec datetime,
   fecha_ven_hab datetime
)

insert into #miembros_total(
   operacion,
   cliente,
   grupo,
   rol_cliente,
   num_telefono,
   num_dia,
   nombre_dia,
   fecha_ejec,
   fecha_ven_hab
)
select operacion_hija,
       integrante,
       grupo,
       rol,
	   num_telefono,
	   @w_num_dias,
       dia_ejecucion,
       @w_fecha,
	   fecha_ven
from #MiembrosAEnviar, #operaciones_sin_coutas_atrasadas
where me_grupo = grupo
and me_tramite = tramite
and me_integrante = integrante
group by operacion_hija, integrante, grupo, rol, num_telefono, dia_ejecucion, fecha_ven

-- =================================================
if (@w_permiso_eje = 'S')
begin
    print 'Ingreso a inserta en tabla definitiva del día ' + @w_nombre_dia
    insert into ca_ns_sms_recordatorios
    select nsr_operacion      = operacion,
           nsr_cliente        = cliente,
           nsr_num_telf       = num_telefono,
           nsr_bloque         = -1, -- No tiene parametros de envío, si tuviera parametros se pone el bloque del catalogo
           nsr_plantilla      = @w_plantilla,
           nsr_grupo          = grupo,
           nsr_num_dia        = num_dia,       
           nsr_fecha_ejec     = fecha_ejec,
           nsr_nom_dia        = nombre_dia,
           nsr_fecha_ven_hab  = fecha_ven_hab,
           nsr_rol_cliente    = rol_cliente,
           nsc_fecha_ing      =  @w_fecha_ejec,
           nsr_estado         = 'N',
           nsr_fecha_env      = null
    from #miembros_total
end

-- ----------
return 0

ERROR:
exec @w_return = cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error

return @w_error
go
