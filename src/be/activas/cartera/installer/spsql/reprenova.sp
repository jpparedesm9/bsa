
/************************************************************************/
/*    Base de datos:          cob_cartera                               */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Santiago Mosquera                       */
/*      Fecha de escritura:     07/10/2019                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*Genera el reporte de los clientes que no renovaron el crédito         */
/*                        MOFICIACIONES                                 */
/*07-10-2019               SMO                     Emisión inicial      */
/*07-31-2019               MTA                     Agregar parametro    */
/*12-04-2019               MTA              Validacion del siguente mes */
/************************************************************************/  
use cob_cartera
go

if object_id ('sp_reporte_renovaciones') is not null
    drop procedure sp_reporte_renovaciones
GO

create proc sp_reporte_renovaciones(
	@i_param1     datetime  = null
)
as

declare 
       @w_fecha_proceso        datetime,
       @w_s_app                varchar(30),
       @w_path                 varchar(255),
       @w_fecha_fin            datetime,
       @w_nombre_archivo       varchar(255),
       @w_cmd                  varchar(8000),
       @w_arch_contenido       varchar(255),
       @w_arch_cabecera        varchar(255),
       @w_arch_completo        varchar(255),
       @w_arch_errores         varchar(255),
       @w_error                int,
       @w_columna              varchar(50),
       @w_col_id               int,
       @w_cabecera             varchar(8000),
       @w_count                int,
       @w_fecha                datetime,
       @w_mes 				   int,
       @w_anio                 int,
       @w_ini_mes_sig          datetime,
       @w_ultimo_dia_habil     datetime,
       @w_ciudad_nacional      int,
	   @w_dias_no_renov        int,
	   @w_est_vigente          tinyint,
	   @w_est_vencido          tinyint,
       @w_est_cancelado        tinyint,
       @w_est_suspenso         tinyint,
       @w_est_castigado        tinyint,
       @w_dias_atra_no_renov   int,
       @w_errores_cab     varchar(255)  
	   
truncate table rpt_clientes_no_renuevan

declare @w_integrantes table(
   referencia_grupal     cuenta,
   integrantes           int)

declare @w_estado_civil table(
   codigo                varchar(10),
   valor                 varchar(64)
)

declare @w_sexo       table(
   codigo                varchar(10),
   valor                 varchar(64)
)

declare @w_nivel_estudio table(
   codigo                varchar(10),
   valor                 varchar(64)
)

declare @w_referencia_tiempo table(
   codigo                varchar(10),
   valor                 varchar(64)
)

declare @w_dias_mora   table(
   dm_operacion           int,
   dm_dias_mora           int
)

create table #operaciones_canceladas(
   oc_cliente             int,
   oc_operacion           int,
   oc_banco               cuenta,
   oc_fecha_fin           datetime,
   oc_tipo_operacion      varchar(100) null
)

create table #operaciones_castigadas(
   oca_cliente             int,
   oca_operacion           int
)

create table #operaciones_actuales(
   oa_cliente   int
)

create table #clientes_no_renuevan(
    nr_cliente               int,
    nr_operacion             int,
	nr_oficina               int,
    nr_nom_oficina           varchar(255) null,
	nr_regional              int,
    nr_nom_regional          varchar(255) null,
	nr_asesor                int,
	nr_nom_asesor            varchar(255) null,
	nr_coordinador           int,
	nr_nom_coordinador       varchar(255) null,
	nr_gerente               int,
	nr_nom_gerente           varchar(255) null,
	nr_grupo                 int,
	nr_nom_grupo             varchar(255) null,
	nr_nom_producto          varchar(255) null,
	nr_ciclo_indv            int,
	nr_ciclo_grup            int,
	nr_apellido1             varchar(100) null,
	nr_apellido2             varchar(100) null,
	nr_nombre1               varchar(100) null,
	nr_nombre2               varchar(100) null,
	nr_num_integrantes       int,
	nr_rfc                   varchar(20) null,
	nr_buc                   varchar(20) null,
	nr_cuenta                varchar(100) null,
	nr_tipo_cuenta           varchar(20) null,
	nr_genero                varchar(30) null,	
	nr_edad                  int,
	nr_estado_civil          varchar(30) null,
	nr_escolaridad           varchar(255) null,
	nr_prestamo_grupal       varchar(64) null,
	nr_celular               varchar(20) null,
	nr_act_economica         varchar(255) null,
	nr_antiguedad_negocio    varchar(30) null,
	nr_correo_electronico    varchar(255) null,
	nr_ingreso_mensual       money null,
   nr_gastos_mensuales      money null,
   nr_otros_ingresos        money null,
	nr_costos_operativos     money null,
   nr_capacidad_pago        money null, 
	nr_monto_credito         money null, 
	nr_fecha_desembolso      datetime,
	nr_fecha_cancelacion     datetime,
	nr_dias_atraso           int null,
	nr_dias_no_renovado      int null,
	nr_banco                 cuenta,
	nr_operacion_padre       char(1),
	nr_tipo_operacion        varchar(255) null,
	nr_tramite               int   
)

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

SELECT @w_dias_no_renov =isnull(pa_int,1)
FROM   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'DNOREN'

SELECT @w_dias_atra_no_renov=isnull(pa_int,0) 
FROM cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico = 'DANORE'

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out

if @@error <> 0 
   return 708201
      
	  
select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

select @w_fecha = @i_param1

if @w_fecha is null
   select @w_fecha = @w_fecha_proceso

 
select @w_fecha = dateadd(day,-1,@w_fecha)

while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_fecha ) begin
	select @w_fecha = dateadd(day,-1,@w_fecha)
	
end

select 
@w_mes             = MONTH (@w_fecha),  
@w_anio            = YEAR (@w_fecha)

--Inicio MTA 
IF @w_mes =12
BEGIN
   SELECT @w_mes  = 1,
         @w_anio = @w_anio+1
END
ELSE 
   SELECT @w_mes= @w_mes+1
--Fin MTA 
   
SELECT @w_ini_mes_sig     = datefromparts(@w_anio, @w_mes, 1)

print 'hoy '+convert(varchar, @w_fecha)

select @w_ultimo_dia_habil = dateadd(day,-1,@w_ini_mes_sig)

while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_ultimo_dia_habil ) begin
	select @w_ultimo_dia_habil = dateadd(day,-1,@w_ultimo_dia_habil)
	
end
print '@w_ultimo_dia_habil '+convert(varchar, @w_ultimo_dia_habil)

if @w_fecha <> @w_ultimo_dia_habil
	return 0

insert into #operaciones_canceladas 
select op_cliente, op_operacion, op_banco, op_fecha_fin,op_toperacion
from ca_operacion
where op_estado = @w_est_cancelado
and op_toperacion in ('GRUPAL','INDIVIDUAL')

insert into #operaciones_castigadas 
select op_cliente, op_operacion
from ca_operacion
where op_estado = @w_est_castigado


delete from #operaciones_canceladas
where oc_cliente in (select oca_cliente from #operaciones_castigadas)

insert into #operaciones_actuales
select op_cliente
from ca_operacion
where op_estado <> @w_est_cancelado
and op_toperacion in ('GRUPAL','INDIVIDUAL')

insert into #clientes_no_renuevan (nr_cliente,nr_operacion,nr_operacion_padre)
select oc_cliente, max(oc_operacion),'N'
from #operaciones_canceladas
where oc_cliente not in (select oa_cliente from #operaciones_actuales)
and oc_tipo_operacion in ('GRUPAL','INDIVIDUAL')
group by oc_cliente


delete from #operaciones_canceladas
delete from #operaciones_actuales

insert into #operaciones_canceladas
select op_cliente, op_operacion, op_banco, op_fecha_fin,op_toperacion
from ca_operacion 
where op_fecha_fin < @w_fecha 
and op_toperacion='REVOLVENTE'

insert into #operaciones_actuales
select op_cliente
from ca_operacion 
where op_fecha_fin > @w_fecha
and op_toperacion='REVOLVENTE'

delete from #operaciones_canceladas
where oc_cliente in (select oca_cliente from #operaciones_castigadas)

insert into #clientes_no_renuevan (nr_cliente,nr_operacion,nr_operacion_padre)
select oc_cliente, max(oc_operacion),'N'
from #operaciones_canceladas
where oc_cliente not in (select oa_cliente from #operaciones_actuales)
and oc_tipo_operacion = 'REVOLVENTE'
group by oc_cliente

update #clientes_no_renuevan set
nr_oficina          = op_oficina,
nr_asesor           = op_oficial,
nr_monto_credito    = op_monto,
nr_fecha_desembolso = op_fecha_liq,
nr_banco            = op_banco,
nr_dias_atraso      = 0,
nr_tipo_operacion   = op_toperacion,
nr_nom_producto     ='Tradicional'
from ca_operacion 
where op_operacion  = nr_operacion

update #clientes_no_renuevan set
nr_nom_producto     = 'Revolvente'
from #clientes_no_renuevan 
where nr_tipo_operacion  = 'REVOLVENTE'

update #clientes_no_renuevan
set nr_operacion_padre = 'S'
from cob_credito..cr_tramite_grupal
where tg_referencia_grupal = nr_banco

update #clientes_no_renuevan
set nr_tramite = tg_tramite
from cob_credito..cr_tramite_grupal
where tg_prestamo = nr_banco

update #clientes_no_renuevan set
nr_nom_producto     = (case tr_promocion when 'S' then 'Grupal(Promocion)' else 'Grupal(Tradicional)' end)
from cob_credito..cr_tramite 
where tr_tramite  = nr_tramite

INSERT INTO @w_sexo
SELECT a.codigo, a.valor
FROM cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cl_sexo'

INSERT INTO @w_estado_civil
SELECT a.codigo, a.valor
FROM cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cl_ecivil'

INSERT INTO @w_nivel_estudio
SELECT a.codigo, a.valor
FROM cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cl_nivel_estudio'

insert into @w_referencia_tiempo
SELECT a.codigo, a.valor
FROM cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cl_referencia_tiempo'

--Días de Atraso
insert into @w_dias_mora
select di_operacion , max(datediff(dd,di_fecha_ven,di_fecha_can))
from ca_dividendo, #clientes_no_renuevan
where di_operacion = nr_operacion
group by di_operacion

update #clientes_no_renuevan
set nr_nom_oficina = isnull(of_nombre,'')
FROM  cobis..cl_oficina
where of_oficina = nr_oficina

update #clientes_no_renuevan
set nr_regional = a.of_regional,
nr_nom_regional = isnull(b.of_nombre,'')
FROM  cobis..cl_oficina a, cobis..cl_oficina b
where a.of_oficina = nr_oficina
and b.of_oficina = a.of_regional

UPDATE #clientes_no_renuevan 
set nr_nom_asesor   = isnull(fu_nombre,''),
nr_coordinador = fu_jefe
from cobis..cc_oficial, cobis..cl_funcionario
where nr_asesor     = oc_oficial
and   oc_funcionario = fu_funcionario

UPDATE #clientes_no_renuevan 
set nr_nom_coordinador    = isnull(fu_nombre,''),
nr_gerente           = fu_jefe
from cobis..cc_oficial, cobis..cl_funcionario
where nr_coordinador  = oc_oficial
and   oc_funcionario   = fu_funcionario

UPDATE #clientes_no_renuevan 
set nr_nom_gerente        = isnull(fu_nombre,'')
from cobis..cc_oficial, cobis..cl_funcionario
where nr_gerente     = oc_oficial
and   oc_funcionario  = fu_funcionario

UPDATE #clientes_no_renuevan 
set nr_grupo        = ci_grupo
from cob_cartera..ca_ciclo
where nr_operacion     =ci_operacion
and nr_operacion_padre='S'

UPDATE #clientes_no_renuevan 
set nr_grupo        = dc_grupo,
nr_ciclo_indv       = dc_ciclo
from cob_cartera..ca_det_ciclo
where nr_operacion     =dc_operacion
and nr_operacion_padre='N'

UPDATE #clientes_no_renuevan 
set nr_nom_grupo = isnull(gr_nombre,''),
nr_ciclo_grup    = gr_num_ciclo
from cobis..cl_grupo
where gr_grupo    =nr_grupo

UPDATE #clientes_no_renuevan 
set nr_apellido1 = isnull(p_p_apellido,''),
nr_apellido2     = isnull(p_s_apellido,''),
nr_nombre1       = isnull(en_nombre,''),
nr_nombre2       = isnull(p_s_nombre,''),
nr_rfc           = isnull(en_rfc,''),
nr_buc           = isnull(en_banco,''),
nr_genero        = (SELECT valor FROM @w_sexo where codigo = p_sexo),
nr_edad          = datediff(yy, p_fecha_nac,@w_fecha),
nr_estado_civil  = (SELECT valor FROM @w_estado_civil where codigo = p_estado_civil),
nr_escolaridad   = (SELECT valor FROM @w_nivel_estudio where codigo = p_nivel_estudio),
nr_ingreso_mensual  = isnull(en_otros_ingresos,0)
from cobis..cl_ente
where nr_cliente    =en_ente
and nr_operacion_padre ='N'

--banco de la operacion padre
UPDATE #clientes_no_renuevan 
set nr_prestamo_grupal = isnull(ci_prestamo,'')
from cob_cartera..ca_ciclo
where nr_operacion   =ci_operacion
and nr_operacion_padre ='S'

UPDATE #clientes_no_renuevan 
set nr_prestamo_grupal = isnull(dc_referencia_grupal,'')
from cob_cartera..ca_det_ciclo
where nr_operacion   =dc_operacion
and nr_operacion_padre ='N'


insert into @w_integrantes
select tg_referencia_grupal, count(tg_referencia_grupal)
from cob_credito..cr_tramite_grupal
where tg_referencia_grupal IN (SELECT DISTINCT nr_prestamo_grupal
FROM #clientes_no_renuevan)
GROUP BY tg_referencia_grupal

update #clientes_no_renuevan
set nr_num_integrantes = integrantes
from @w_integrantes
where referencia_grupal = nr_prestamo_grupal

UPDATE #clientes_no_renuevan 
set nr_cuenta = isnull(ea_cta_banco,0),
nr_gastos_mensuales    = isnull(ea_ct_ventas,0),
nr_otros_ingresos      = isnull(ea_ventas,0),
nr_costos_operativos   = isnull(ea_ct_operativo,0)
from cobis..cl_ente_aux
where nr_cliente    =ea_ente

UPDATE #clientes_no_renuevan 
set nr_celular = isnull(te_valor,'')
from cobis..cl_telefono
where nr_cliente    =te_ente
and te_tipo_telefono='C'

update #clientes_no_renuevan 
set nr_act_economica =isnull(nc_nombre,''),
nr_antiguedad_negocio = (select valor from @w_referencia_tiempo where codigo = nc_tiempo_actividad )
from cobis..cl_negocio_cliente
where nc_ente = nr_cliente

UPDATE #clientes_no_renuevan
set nr_correo_electronico = di_descripcion
FROM cobis..cl_direccion
where di_ente = nr_cliente
and   di_tipo = 'CE'

update #clientes_no_renuevan 
set nr_capacidad_pago = ((nr_ingreso_mensual + nr_otros_ingresos) -(nr_gastos_mensuales + nr_costos_operativos))

UPDATE #clientes_no_renuevan 
set nr_dias_atraso = isnull(dm_dias_mora,0)
from @w_dias_mora
where nr_operacion = dm_operacion
and dm_dias_mora >= 0

UPDATE #clientes_no_renuevan 
set nr_fecha_cancelacion = op_fecha_ult_proceso
from cob_cartera..ca_operacion
where nr_operacion = op_operacion
and nr_tipo_operacion in ('GRUPAL','INDIVIDUAL')

UPDATE #clientes_no_renuevan 
set nr_fecha_cancelacion = op_fecha_fin
from cob_cartera..ca_operacion
where nr_operacion = op_operacion
and nr_tipo_operacion = 'REVOLVENTE'

UPDATE #clientes_no_renuevan 
set nr_dias_no_renovado = datediff(dd, nr_fecha_cancelacion, @w_fecha)

insert into rpt_clientes_no_renuevan
select nr_nom_oficina,nr_nom_regional,nr_nom_gerente,nr_nom_coordinador,nr_nom_asesor,nr_grupo,nr_nom_grupo,
nr_nom_producto,nr_ciclo_indv,nr_ciclo_grup,nr_apellido1,nr_apellido2,nr_nombre1,nr_nombre2,nr_num_integrantes,
nr_rfc,nr_buc,nr_cuenta,nr_tipo_cuenta,nr_genero,nr_edad,nr_estado_civil,nr_escolaridad,nr_celular,nr_act_economica,
nr_antiguedad_negocio,nr_correo_electronico,nr_ingreso_mensual,nr_gastos_mensuales,nr_otros_ingresos,
nr_capacidad_pago,nr_monto_credito,convert(varchar(10),nr_fecha_desembolso,103),convert(varchar(10),nr_fecha_cancelacion,103),nr_dias_atraso,nr_dias_no_renovado
from #clientes_no_renuevan
where nr_operacion_padre='N'
and nr_dias_atraso<= @w_dias_atra_no_renov
and nr_dias_no_renovado>= @w_dias_no_renov

----------------------------------------
--	Generar Archivo 
----------------------------------------

---------CONTENIDO----------------
select @w_s_app = pa_char
from cobis..cl_parametro	
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
	
select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7 

select  @w_path=@w_path+'Impacto_Social\'

select @w_fecha_fin = @w_ultimo_dia_habil

select @w_nombre_archivo = 'IS_NORENOVADOS_D'+convert(varchar(10),@w_fecha_fin,12)

print '@w_nombre_archivo '+@w_nombre_archivo
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_clientes_no_renuevan out '

select @w_arch_contenido = @w_path + @w_nombre_archivo+ '_cont.txt',
	    @w_arch_cabecera  = @w_path + @w_nombre_archivo+ '_cab.txt',
		 @w_arch_completo  = @w_path + @w_nombre_archivo+ '.txt',
	    @w_arch_errores   = @w_path + @w_nombre_archivo+ '.err',
	    @w_errores_cab    = @w_path + @w_nombre_archivo+ '_cab.err'

select @w_cmd = @w_cmd + @w_arch_contenido+ ' -b5000 -c -C RAW -T -e ' + @w_arch_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

print '@w_comando 1>> ' +@w_cmd

exec @w_error = xp_cmdshell @w_cmd
if @w_error <> 0 
	return @w_error
	

----------------------------------------
--	Generar Archivo Cabecera 
----------------------------------------

if not object_id('rpt_clientes_no_renuevan_cabe') is null drop table rpt_clientes_no_renuevan_cabe
create table rpt_clientes_no_renuevan_cabe (nombres_columnas varchar(1024))
insert into rpt_clientes_no_renuevan_cabe values(
'Oficina'                                         + '|' +  'Region'                         + '|' +
'Nombre del Gerente'                              + '|' +  'Nombre del Coordinador'         + '|' +
'Nombre del Asesor'                               + '|' +  'Id grupo'                       + '|' +
'Nombre del grupo'                                + '|' +  'Nombre del producto'            + '|' +
'Ciclo individual'                                + '|' +   'Ciclo grupal'                  + '|' +
'Apellido Paterno'                                + '|' +  'Apellido Materno'               + '|' +
'Nombre'                                          + '|' +  'Nombre 2'                       + '|' +
'No. de integrantes'                              + '|' +  'RFC'                            + '|' +
'BUC'                                             + '|' +  'Cuenta de deposito'             + '|' +
'Tipo de cuenta'                                  + '|' +  'Genero'                         + '|' +
'Edad'                                            + '|' +  'Estado civil'                   + '|' +
'Escolaridad'                                     + '|' +  'Numero celular'                 + '|' +
'Nombre corto de la actividad economica'          + '|' +  'Años de antigüedad del negocio' + '|' +
'Correo electronico'                              + '|' +  'Ingreso mensual'                + '|' +
'Gastos mensuales'                                + '|' +  'Otros ingresos'                 + '|' +
'Capacidad de pago'                               + '|' +  'Monto del credito'              + '|' +
'Fecha de desembolso'                             + '|' +  'Fecha de cancelacion'           + '|' +
'Dias de atraso maximo durante el ciclo'          + '|' +  'Dias de No Renovado'            + '|' 
)

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_clientes_no_renuevan_cabe out '
select @w_cmd = @w_cmd + @w_arch_cabecera + ' -b1 -c -C RAW -T -e ' + @w_errores_cab + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
 PRINT '@w_comando2>> '+ convert(VARCHAR(300),@w_cmd)
exec @w_error = xp_cmdshell @w_cmd
if @w_error <> 0 begin
   print 'Error generando cabecera de renovaciones'
   print @w_cmd
   return @w_error
end

--------- UNIR CABECERA CON CONTENIDO ----------------
	select @w_cmd = 'copy ' + @w_arch_cabecera + ' + ' + @w_arch_contenido + ' ' + @w_arch_completo
  PRINT '@w_comando3>> '+ convert(VARCHAR(300),@w_cmd)
	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error
	   
------ ELIMINAR ARCHIVOS TEMPORALES
	select @w_cmd = 'del ' + @w_arch_cabecera 
 	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error
 
	select @w_cmd = 'del ' + @w_arch_contenido
 	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error

	select @w_cmd = 'del ' + @w_errores_cab
 	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error  

/**********************/

go
