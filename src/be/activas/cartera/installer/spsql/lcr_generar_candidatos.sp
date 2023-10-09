
/*************************************************************************/
/*   ARCHIVO:         lcr_generar_candidatos.sp                          */
/*   NOMBRE LOGICO:   sp_lcr_generar_candidatos                          */
/*   Base de datos:   cob_cartera                                        */
/*   PRODUCTO:        Credito                                            */
/*   Fecha de escritura:   Enero 2018                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*  Permite insertar alertas de los clientes cada semana, si se estan en */
/*  Listas negras o Negativ File                                         */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/* FECHA           AUTOR                     DETALLE                     */
/* 08/JUL/2019     MTA       Validar nulos en el grupo                   */
/* 11/nov/2019     AGO       actualizacion                               */
/* 13/Jul/2021     ACH       Err#161681. Eliminar la data bajo criterios */
/* 13/Jul/2021     ACH       Req#161681. Se agrega clientes con          */
/*                           creditos cancelados                         */
/* 02/08/2021      BGU       Aumento operaciones canceladas              */
/* 04/09/2021      ACH       Pruebas Caso CLOUD_161141 F1yF1             */
/* 04/05/2022      KVI       Comentado por Error #182813                 */
/* 08/09/2022      DCU       Req. #192491                                */
/*************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_lcr_generar_candidatos')
    drop proc sp_lcr_generar_candidatos
go

create proc sp_lcr_generar_candidatos (
    @i_param1           datetime   =   null ,
	@i_forzar           char(1)    = 'N',-- FECHA DE PROCESO
	@i_debug            char(1)    = 'N'
)as
declare
@w_sp_name          varchar(20),
@w_s_app            varchar(50),
@w_path             varchar(255),  
@w_msg              varchar(200),  
@w_return           int,
@w_dia              varchar(2),
@w_mes              varchar(2),
@w_anio             varchar(4),
@w_fecha_r          varchar(10),
@w_file_rpt         varchar(40),
@w_file_rpt_1       varchar(140),
@w_file_rpt_1_out   varchar(140),
@w_bcp              varchar(2000),
@w_ultimo_dia       int,
@w_cabecera         varchar(5000),
@w_op_vigentes      int,
@w_transacciones    int,
@w_procesos         int,
@w_usuarios_app     int,
@w_fecha_proceso    datetime,
@w_id_alerta        int,
@w_ente             int,
@w_result           varchar(2),
@w_cc               varchar(64),
@w_matriz           varchar(64),
@w_riesgo           varchar(64),
@w_dias_atraso      int,
@w_calif            varchar(64),
@w_error            int,
@w_values           varchar(255),
@w_variables        varchar(255),
@w_result_values    varchar(255),
@w_parent           int,
@w_fecha_inicio	    datetime,
@w_ciudad_nacional  int,
@w_dia_generar      int,
@w_fecha_final	    int,
@w_dia_restar 	    int,
@w_fecha_hasta	    datetime,
@w_rule_id          int,
@w_acronym         varchar(30),
@w_cargo_gerente   int ,
@w_fecha_corte     datetime ,
@w_fecha_corrida_ant datetime , 
@w_destino2        varchar(5000),
@w_columna         varchar(5000),
@w_col_id          int ,
@w_comando         varchar(5000),
@w_nom_cabecera    varchar(5000),
@w_nom_columnas    varchar(5000),
@w_cont_columnas   INT, 
@w_destino         VARCHAR(5000),
@w_errores         VARCHAR(5000),
@w_sql             VARCHAR(5000), 
@w_comilla         char(1),
@w_fecha_reproceso varchar(10),
@w_dias_atraso_par	smallint,
@w_dias_desc        smallint, -- Descartar
@w_dias_post        smallint, -- posponer
@w_fecha_cred_dias_ant varchar(10),
@w_ciclo_grupal        int




declare @resultadobcp table (linea varchar(max))
print 'gc1'
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_dia_generar = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'DECLCR'
and    pa_producto = 'CLI'


select @w_cargo_gerente = pa_smallint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CGEOFI'
and    pa_producto = 'CCA'

select @w_dias_atraso_par = pa_smallint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'DATRE'
and    pa_producto = 'CCA'

select @w_ciclo_grupal = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CCALCR'
and    pa_producto = 'CCA'

print '@w_ciclo_grupal= ' + convert(varchar,@w_ciclo_grupal)

select @w_dias_desc = pa_smallint from cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'
select @w_dias_post = pa_smallint from cobis..cl_parametro where pa_nemonico = 'DPC' and pa_producto = 'CCA'
print 'gc2'
if @@rowcount = 0 select @w_cargo_gerente = 1 
print 'gc3'
-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

--truncate table ca_reporte_control_tmp

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7 -- CARTERA

print 'gc4'
/* FECHA PROCESO */
if(@i_param1 is null)
begin
	select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
end
else
begin
	select @w_fecha_proceso = @i_param1
end

select @w_fecha_corte = @w_fecha_proceso
print 'gc5'
if @i_forzar = 'N' begin 
   print 'gc6'
   select @w_fecha_corte = dateadd(dd, -1, @w_fecha_proceso)
    
   while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte) 
      select @w_fecha_corte= dateadd(dd,-1,@w_fecha_corte)  
   
    if (datepart(ww, @w_fecha_corte) =  datepart(ww, @w_fecha_proceso))  return 0 
	
end else begin 
  --si forzar es igual = s se tiene que ejecutar el reporte operativo a la fecha que se envia como parametro 
  print 'gc7'
   --------------------------------
   /* ENTRAR BORRANDO LA TABLA DE TRABAJO */ 
   if not object_id('cob_conta_super..sb_reporte_operativo') is null truncate table cob_conta_super..sb_reporte_operativo
   
   select @w_fecha_reproceso = convert(varchar(10),@w_fecha_proceso,101)
  print 'gc8'
   exec cob_conta_super..sp_reporte_operativo
   @i_param1   = @w_fecha_reproceso,   --FECHA
   @i_param2   ='28793',   --BATCH 28793
   @i_param3   = '101'    --FORMATO FECHA
  print 'gc9'

end 

/* ENTRAR BORRANDO LA TABLA DE OPERACIONES CANCELADAS */ --Req. 163006
   if not object_id('cob_conta_super..sb_operacion_cancelada') is null truncate table cob_conta_super..sb_operacion_cancelada
   print 'gc10'
 -- 30 dias atras
   exec cob_conta_super..sp_operaciones_canceladas
   @i_param1   = @w_fecha_reproceso,   --FECHA 
   @i_param2   ='28793',   --BATCH 28793
   @i_param3   = '101'    --FORMATO FECHA

print 'gc11'
select @w_fecha_corrida_ant = max (cc_fecha_ing) from ca_lcr_candidatos

select @w_fecha_corrida_ant = isnull(@w_fecha_corrida_ant , '01/01/1900') 

delete ca_lcr_candidatos where cc_promocion is null and cc_descripcion is null and cc_asesor_asig is null

--Los clientes DESCARTADOS NO se deberán mostrar durante 30 días una vez seleccionada la opción descartado (desaparecen), 
--si al día 31 sigue cumpliendo las reglas si se deberá mostrar
delete ca_lcr_candidatos where cc_promocion = 'D' and datediff(dd, cc_date , @w_fecha_proceso) > @w_dias_desc

--Los clientes PROPUESTO se deberán mostrar durante los 30 días una vez seleccionada la opción propuesto o 
delete ca_lcr_candidatos where cc_promocion = 'P' and datediff(dd, cc_date , @w_fecha_proceso) > @w_dias_post

--simplemente se agregue un comentario. Al día 31 ya deberá ser sujeto a evaluación nuevamente y si ya no cumple las reglas ahora si se debe eliminar..
delete ca_lcr_candidatos where cc_promocion is null and cc_descripcion is not null and datediff(dd, cc_fecha_descrip , @w_fecha_proceso) > @w_dias_post
print 'gc12'
--caso#161681
select * 
into #gc_ca_lcr_candidatos_respaldo
from ca_lcr_candidatos

truncate table ca_lcr_candidatos
print 'gc13'
-- reporte operativo temporal
create table #gc_sb_reporte_operativo (
	CC                       smallint not null,
	CONTRATO                 varchar (24) not null,
	[ID GRUPO]               int not null,
	[NOMBRE GRUPO]           varchar (64) not null,                                          
	[CLIENTE COBIS]          int not null,
	[APELLIDO PATERNO]       varchar (64) not null,
	[APELLIDO MATERNO]       varchar (64) not null,
	NOMBRE1                  varchar (64) not null,                                                                                              
	[CICLO INDIVIDUAL]       int not null,
	[PRODUCTO DE PRESTAMOS]  varchar (40) not null,
	[DIAS MAX ATRASO ANT]    int not null,
	[DIAS MAX ATRASO ACT]    int not null,
	[DIAS MORA]              int not null,
	[NIVEL DE RIESGO]        char (1) not null,
	mca_operacion            int null
)

print 'gc14'
insert into  #gc_sb_reporte_operativo
(CC,CONTRATO,[ID GRUPO],[NOMBRE GRUPO],[CLIENTE COBIS],[APELLIDO PATERNO],
[APELLIDO MATERNO],NOMBRE1,[CICLO INDIVIDUAL],[PRODUCTO DE PRESTAMOS],
[DIAS MAX ATRASO ANT],[DIAS MAX ATRASO ACT],[DIAS MORA],[NIVEL DE RIESGO])
select CC,CONTRATO,[ID GRUPO],[NOMBRE GRUPO],[CLIENTE COBIS],[APELLIDO PATERNO],
[APELLIDO MATERNO],NOMBRE1,[CICLO INDIVIDUAL],[PRODUCTO DE PRESTAMOS],
[DIAS MAX ATRASO ANT],[DIAS MAX ATRASO ACT],[DIAS MORA],[NIVEL DE RIESGO]
from cob_conta_super..sb_reporte_operativo

select *, mca_operacion  = convert(int,null) into #gc_sb_operaciones_canceladas from cob_conta_super..sb_operacion_cancelada
print 'gc15'

insert into #gc_sb_reporte_operativo 
select * from #gc_sb_operaciones_canceladas oc
where not exists (select 1 from #gc_sb_reporte_operativo ro where ro.[CLIENTE COBIS] = oc.[CLIENTE COBIS])


update #gc_sb_reporte_operativo set 
mca_operacion        = op_operacion 
from ca_operacion 
where CONTRATO = op_banco
print 'gc16'
select 
mca_fecha                = @w_fecha_corte ,
mca_operacion            = mca_operacion,
mca_banco                = CONTRATO,
mca_fecha_desembolso     = convert(datetime,null),
mca_grupo                = [ID GRUPO], --MTA agrega validacion de nulos-
mca_oficina              = CC,
mca_oficial_id           = convert(int,null),
mca_cliente              = [CLIENTE COBIS],
mca_ciclo                = [CICLO INDIVIDUAL],
mca_edad_mora            = [DIAS MORA] ,
mca_atraso_max_ant       = [DIAS MAX ATRASO ANT],
mca_atraso_max_act       = [DIAS MAX ATRASO ACT],
mca_nivel_riesgo_ext     = [NIVEL DE RIESGO],
mca_riesgo_pld           = convert(varchar,null),
mca_toperacion           = [PRODUCTO DE PRESTAMOS],
mca_nombre_grupo         = [NOMBRE GRUPO],
mca_nombre               = isnull([APELLIDO PATERNO], ' ')+' ' +isnull([APELLIDO MATERNO] , ' ')+' ' +isnull(NOMBRE1   , ' '),
mca_gerente              = convert(varchar(24),null),
mca_asesor               = convert(varchar(24),null)
into #gc_maestro_cartera
from #gc_sb_reporte_operativo


print 'gc17'
update #gc_maestro_cartera set 
mca_fecha_desembolso   = op_fecha_liq
from ca_operacion 
where mca_operacion = op_operacion 

--SE ELIMINA LOS MENORES O IGUALES A LA CORRIDA ANTERIOR 
--delete #gc_maestro_cartera where mca_fecha_desembolso <=@w_fecha_corrida_ant

update #gc_maestro_cartera set 
mca_riesgo_pld  =  isnull(ea_nivel_riesgo,'A1')
from cobis..cl_ente_aux
where mca_cliente   =  ea_ente 

--BORRAR REVOLVENTES
delete #gc_maestro_cartera  where mca_toperacion = 'REVOLVENTE'

--BORRAR DE LA EJECUCION ANTERIOR 
delete #gc_maestro_cartera 
from   ca_lcr_candidatos 
where  mca_cliente = cc_cliente 

--BORRAR LOS CICLOS MENORES O IGUALES A 2 se SE PERMITE DE 3 PARA ARRIBA 
delete #gc_maestro_cartera
where mca_ciclo < @w_ciclo_grupal

--BORRAR LOS QUE TENGAN DIAS DE ATRASO MENOR O IGUAL AL PARAMETRO (7)
delete #gc_maestro_cartera
where mca_atraso_max_act > @w_dias_atraso_par

--BORRAR LOS QUE TENGAN DIAS DE MORA MENOR O IGUAL AL PARAMETRO (7) -- Error #182813
delete #gc_maestro_cartera
where mca_edad_mora > @w_dias_atraso_par

print 'gc18'
--ELIMINA CLIENTES CON ACTIVIDAD DENEGADA
delete #gc_maestro_cartera 
from cobis..cl_negocio_cliente
where mca_cliente  = nc_ente 
and   nc_actividad_ec in (select C.codigo from cobis..cl_catalogo C, cobis..cl_tabla T
						where  C.tabla = T.codigo
						and    T.tabla = 'cl_actividad_lcr' )

--ELIMINA CLIENTE EN LISTA NEGRAS
delete #gc_maestro_cartera 
from cobis..cl_ente_aux
where mca_cliente  = ea_ente 
and ea_lista_negra = 'S'

--ELIMNA CLIENTES EN NEGATIVE FILES
delete #gc_maestro_cartera 
from cobis..cl_ente_aux
where mca_cliente  = ea_ente 
and   ea_negative_file = 'S'
						
--BORRAR OPER DIAS MORA DIAS ATRASO  >0
--delete  #gc_maestro_cartera where (mca_edad_mora > 0 or mca_atraso_max_ant >0 or mca_atraso_max_act > 0 ) -- Error #182813


--BORRAR LOS RIESGOS EXTERNOS PERMITIR SOLO A B C D 
delete #gc_maestro_cartera
where mca_nivel_riesgo_ext not in (select C.valor from cobis..cl_catalogo C, cobis..cl_tabla T
									where  C.tabla = T.codigo
									and    T.tabla = 'ca_lcr_riesgo_cred_ext' ) 


--BORRAR RIESGOS PLD NO PERMITIDOS
delete #gc_maestro_cartera where mca_riesgo_pld in (select C.valor from cobis..cl_catalogo C, cobis..cl_tabla T
												where  C.tabla = T.codigo
												and    T.tabla = 'ca_lcr_riesgo_pld' )


--ACTUALIZACION DEL ID OFICIAL 

update #gc_maestro_cartera set
mca_oficial_id  = op_oficial 
from ca_operacion 
where mca_banco = op_banco 


print 'gc19'
--ACUALIZACION GERENTE 															
update #gc_maestro_cartera set 
mca_gerente = fu_login 
from cobis..cl_oficina, cobis..cl_funcionario
where of_oficina = fu_oficina
and   fu_oficina = mca_oficina
and   fu_cargo   = @w_cargo_gerente
and   fu_estado	 = 'V'


--ACTUALIZACION ASESOR 
update #gc_maestro_cartera set 
mca_asesor = fu_login 
from cobis..cc_oficial, cobis..cl_funcionario
where oc_funcionario   = fu_funcionario 
and   oc_oficial       = mca_oficial_id 

if @i_debug  = 'S'  select * from #gc_maestro_cartera

print 'gc20'
select 
cc_fecha_ing =convert(datetime,null),
cc_operacion =max(mca_operacion),
cc_fecha_liq =convert(datetime,null),
cc_grupo     =convert(int,null),
cc_nom_grupo =convert(varchar(64),null),
cc_oficina   =convert(int,null),
cc_cliente   =mca_cliente,
cc_nombre    =convert(varchar(255),null),
cc_gerente   =convert(varchar(14),null),
cc_asesor    =convert(varchar(14),null),
cc_user         =convert(varchar(10), null),--*
cc_date         =convert(datetime, null),
cc_respuesta    =convert(varchar(10), null),--*
cc_periodicidad =convert(varchar(10), null),--*
cc_asesor_asig  =convert(varchar(10), null),--*
cc_descripcion  =convert(varchar(600), null),
cc_promocion    =convert(char(1), null),
cc_fecha_descrip =convert(datetime,null)
into #gc_ca_lcr_candidatos 
from #gc_maestro_cartera
group by mca_cliente

update  #gc_ca_lcr_candidatos  set 
cc_fecha_ing = mca_fecha,
cc_gerente   = mca_gerente,
cc_asesor    = mca_asesor,
cc_fecha_liq = mca_fecha_desembolso,
cc_oficina   = mca_oficina,
cc_nom_grupo = mca_nombre_grupo,
cc_grupo     = mca_grupo,
cc_nombre    = mca_nombre
from #gc_maestro_cartera 
where cc_operacion = mca_operacion
print 'gc21'
--Elimina clientes que ya existen caso#161681
delete #gc_ca_lcr_candidatos from #gc_ca_lcr_candidatos C, #gc_ca_lcr_candidatos_respaldo R 
where C.cc_grupo = R.cc_grupo
and C.cc_cliente = R.cc_cliente
and C.cc_fecha_liq = R.cc_fecha_liq

--TABLA DE LA PANTALLA
insert #gc_ca_lcr_candidatos
select 
cc_fecha_ing           ,0,cc_fecha_liq            	,cc_grupo,        
cc_nom_grupo           ,cc_oficina              	,cc_cliente,      
cc_nombre              ,cc_gerente           	    ,cc_asesor,
cc_user                ,cc_date                     ,cc_respuesta,
cc_periodicidad        ,cc_asesor_asig              ,cc_descripcion,
cc_promocion,           cc_fecha_descrip   
from #gc_ca_lcr_candidatos_respaldo
print 'gc22'
--Elimina clientes repetidos - caso#161681
select cliente_rep = cc_cliente, grupo_rep = cc_grupo, fecha_liq_rep = cc_fecha_liq, fecha_min_rep = convert(datetime,'01/01/1900'), num_rep = count(*) 
into #gc_ca_lcr_candidatos_rep
from #gc_ca_lcr_candidatos
group by cc_cliente, cc_grupo, cc_fecha_liq
having count(*) > 1

select cliente = cc_cliente, grupo = cc_grupo, fecha_liq = cc_fecha_liq , min_fecha = min(cc_fecha_ing)
into #gc_ca_lcr_candidatos_no_borrar
from #gc_ca_lcr_candidatos_rep, #gc_ca_lcr_candidatos
where cliente_rep = cc_cliente
and grupo_rep = cc_grupo
and fecha_liq_rep = cc_fecha_liq
group by cc_cliente, cc_grupo, cc_fecha_liq

update #gc_ca_lcr_candidatos_rep
set fecha_min_rep = min_fecha
from #gc_ca_lcr_candidatos_no_borrar
where cliente_rep = cliente
and grupo_rep = grupo
and fecha_liq_rep = fecha_liq

delete #gc_ca_lcr_candidatos
from #gc_ca_lcr_candidatos_rep
where cliente_rep = cc_cliente
and grupo_rep = cc_grupo
and fecha_liq_rep = cc_fecha_liq
and cc_fecha_ing <> fecha_min_rep

if @i_debug  = 'S'  select * from #gc_ca_lcr_candidatos
print 'gc23'
--TABLA DE LA PANTALLA
insert into ca_lcr_candidatos (
cc_fecha_ing,           cc_fecha_liq,               cc_grupo,        
cc_nom_grupo,           cc_oficina,              	cc_cliente,      
cc_nombre,              cc_gerente,              	cc_asesor,
cc_user,                cc_date,                    cc_respuesta,
cc_periodicidad,        cc_asesor_asig,             cc_descripcion,
cc_promocion,           cc_fecha_descrip)  
select distinct 
cc_fecha_ing,           cc_fecha_liq,               cc_grupo,        
cc_nom_grupo,           cc_oficina,              	cc_cliente,      
cc_nombre,              cc_gerente,              	cc_asesor,
cc_user,                cc_date,                    cc_respuesta,
cc_periodicidad,        cc_asesor_asig,             cc_descripcion,
cc_promocion,           cc_fecha_descrip
from #gc_ca_lcr_candidatos
print 'gc24'
delete  ca_lcr_candidatos 
where cc_cliente in ( select io_campo_1 from cob_workflow..wf_inst_proceso where io_campo_4 = 'REVOLVENTE' and io_estado = 'EJE' )  
and cc_respuesta is null
--
delete  ca_lcr_candidatos 
where cc_cliente in (select op_cliente from ca_operacion where @w_fecha_proceso between op_fecha_ini and op_fecha_fin and op_toperacion = 'REVOLVENTE')
and cc_respuesta is null

update cobis..cl_ente_aux set
ea_colectivo = 'CC',
ea_nivel_colectivo = 'O'
from ca_lcr_candidatos
where ea_ente = cc_cliente
print 'gc25'
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
	exec cobis..sp_errorlog 
	@i_fecha        = @w_fecha_proceso,
	@i_error        = @w_error,
	@i_usuario      = 'usrbatch',
	@i_tran         = 1,
	@i_descripcion  = @w_msg,
	@i_tran_name    =null,
	@i_rollback     ='S'
	return @w_error

go


