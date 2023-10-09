/* ********************************************************************* */
/*   Archivo:              baevacli.sp                                   */
/*   Stored procedure:     sp_eval_grp_en017                             */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         KVI                                           */
/*   Fecha de escritura:   25/Mayo/2023                                  */
/* ********************************************************************* */
/*                       IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/* ********************************************************************* */
/*                       PROPOSITO                                       */
/*   Generar un reporte diario con los clientes evaluados con el tipo de */
/*   Califación igual a EN017.  									     */
/* ********************************************************************* */
/*                       MODIFICACIONES                                  */
/*   FECHA         AUTOR      RAZON                                      */
/*   25-May-2023   KVI        Emisión inicial                            */
/* ********************************************************************* */

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_eval_grp_en017')
   drop proc sp_eval_grp_en017
go

create proc sp_eval_grp_en017(
    @i_param1    datetime = null -- fecha 
)
as  
declare
@w_sp_name       	char(30),
@w_s_app            varchar(50),
@w_path             varchar(255),  
@w_msg              varchar(300),
@w_return           int,
@w_dia              varchar(2),
@w_mes              varchar(2),
@w_anio             varchar(4),
@w_fecha_r          varchar(10),
@w_file_rpt         varchar(40),
@w_file_rpt_1       varchar(200),
@w_file_rpt_1_out   varchar(140),
@w_error            int,
@w_msg_error        varchar(255),
@w_cmd              varchar(1000),
@w_comando          varchar(1000),
@w_batch			int,
@w_fecha            datetime,
@w_fecha_proceso    datetime,
@w_ffecha			int,
@w_ciudad_nacional  int,
@w_fecha_borrado    datetime,
@w_vig_registros    int


select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

select  
@w_sp_name = 'sp_eval_grp_en017', 
@w_batch   = 5001,
@w_ffecha  = 103,
@w_fecha   = isnull(@i_param1, @w_fecha_proceso)

-- Paso a Historico
insert into cobis..rte_eval_grp_en017_hist
select *,getdate() from cobis..rte_eval_grp_en017

truncate table cobis..rte_eval_grp_en017
truncate table cobis..rte_eval_grp_en017_rpt


--Borrado de registros que superaron el tiempo del parametro
select @w_vig_registros = pa_int from cl_parametro where pa_nemonico = 'VREC17'
select @w_fecha_borrado = dateadd(month, -@w_vig_registros, @w_fecha)

delete from cobis..rte_eval_grp_en017_hist
where eh_fecha_hist < @w_fecha_borrado


-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


-- FECHA 
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha)
begin
	select @w_fecha = dateadd(dd,-1,@w_fecha)
end

print 'fecha' + convert(varchar(10),@w_fecha,103)


--DETERMINAR UNIVERSO DE REGISTROS A REPORTAR 
select 
ib_secuencial                                                                 as 'secuencial',      
ib_folio                                                                      as 'folio_sol',
ib_fecha                                                                      as 'fecha_sol', 
substring(convert(varchar(10), ib_fecha, 112),1,6)                            as 'fecha_sol_num',
substring(convert(varchar(10), ib_fecha, 112),1,4) + 
          convert(varchar(2), datepart(week, ib_fecha))                       as 'fecha_sol_sem',
en_oficial                                                                    as 'oficial',
en_oficina                                                                    as 'oficina_ente',
convert(int,null)                                                             as 'cod_sucursal',
convert(varchar(64),null)                                                     as 'nom_sucursal',
convert(int,null)                                                             as 'centro_costos',
convert(varchar(64),null)                                                     as 'nom_regional',
convert(int,null)                                                             as 'cod_asesor',
ib_usuario                                                                    as 'asesor',
convert(int,null)                                                             as 'cod_gerente',
convert(varchar(14),null)                                                     as 'gerente',
convert(int,null)                                                             as 'cod_coordinador',
convert(varchar(14),null)                                                     as 'coordinador',
convert(varchar(24),null)                                                     as 'banco',
convert(datetime,null)                                                        as 'fecha',
convert(varchar(10),null)                                                     as 'toperacion',
convert(smallint,null)                                                        as 'ciclo_cliente',
convert(int,null)                                                             as 'tramite',
convert(money,null)                                                           as 'monto_sol',
convert(smallint,null)                                                        as 'plazo_sol',
convert(varchar(10),null)                                                     as 'cod_periodicidad',
convert(varchar(64),null)                                                     as 'periodicidad_sol',
convert(int,null)                                                             as 'score',
convert(varchar(3),null)                                                      as 'score_clave',
convert(varchar(50),null)                                                     as 'score_nombre',
convert(varchar(4),null)                                                      as 'score_cod_razon',
ib_cliente                                                                    as 'ente',
convert(varchar(10),null)                                                     as 'produc_prestamo',
'N'                                                                           as 'sub_produc_prestamo',
convert(smallint,0)                                                           as 'tiene_cuentas',
convert(money,null)                                                           as 'saldo_vencido',
convert(varchar(5),null)                                                      as 'max_morosidad_hist',
convert(smallint,null)                                                        as 'clave_observacion',
ea_nivel_riesgo_cg                                                            as 'nivel_riesgo',
ea_nivel_riesgo_1                                                             as 'nivel_riesgo_1',
ea_nivel_riesgo_2                                                             as 'nivel_riesgo_2',
p_calif_cliente                                                               as 'color_cliente',
null                                                                          as 'estatus_aprobacion'
into #reporte_buro_diario_eva_cli
from cob_credito..cr_interface_buro, cobis..cl_ente, cobis..cl_ente_aux 
where ib_cliente = en_ente
and en_ente      = ea_ente
and ib_estado    = 'V'
and convert(varchar,ib_fecha,103) = convert(varchar,@w_fecha,103)
and ea_tipo_calif_eva_cli = 'EN017'


-- Sucursal
update #reporte_buro_diario_eva_cli
set cod_sucursal = fu_oficina
from cobis..cl_funcionario, cobis..cc_oficial
where oficial = oc_oficial
and oc_funcionario = fu_funcionario 

update #reporte_buro_diario_eva_cli
set nom_sucursal = upper(of_nombre)
from cobis..cl_oficina
where of_oficina = cod_sucursal

update #reporte_buro_diario_eva_cli
set nom_sucursal = upper(of_nombre)
from cobis..cl_oficina
where cod_sucursal = 0
and oficina_ente = of_oficina


-- CC: Centro de Costos
update #reporte_buro_diario_eva_cli
set centro_costos = re_ofconta
from cob_conta..cb_relofi
where re_ofadmin = cod_sucursal


-- Regional
update #reporte_buro_diario_eva_cli
set nom_regional = (select A.of_nombre
                    from cobis..cl_oficina A, cobis..cl_oficina B
                    where A.of_oficina = B.of_regional
                    and   B.of_oficina = P.cod_sucursal)
from #reporte_buro_diario_eva_cli P


-- Coordinador
update #reporte_buro_diario_eva_cli
set cod_coordinador = fu_jefe,
    cod_asesor = fu_funcionario
from cobis..cl_funcionario 
where fu_login = asesor  

update #reporte_buro_diario_eva_cli
set coordinador = fu_login
from cobis..cl_funcionario 
where fu_funcionario = cod_coordinador  


-- Gerente
update #reporte_buro_diario_eva_cli 
set cod_gerente = fu_jefe
from cobis..cl_funcionario 
where fu_funcionario = cod_coordinador  

update #reporte_buro_diario_eva_cli
set gerente = fu_login
from cobis..cl_funcionario 
where fu_funcionario = cod_gerente


-- Ciclo Cliente 
update #reporte_buro_diario_eva_cli 
set banco = (select max(op_banco)
             from cob_conta_super..sb_operacion
             where op_aplicativo = 7
             and   op_cliente    = ente
			 and   op_fecha     <= @w_fecha
             group by op_cliente)

update #reporte_buro_diario_eva_cli 
set toperacion = op_toperacion,
    fecha      = op_fecha
from cob_conta_super..sb_operacion
where op_banco = banco

--Actualiza Grupal
update #reporte_buro_diario_eva_cli 
set ciclo_cliente = isnull(dc_ciclo, 0) 
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where op_banco = banco
and op_operacion = dc_operacion

--Actualiza LCR
update #reporte_buro_diario_eva_cli 
set ciclo_cliente = (select count(distinct(op_banco)) 
                     from cob_conta_super..sb_operacion 
					 where op_cliente = ente 
					 and op_toperacion = 'REVOLVENTE')
where toperacion = 'REVOLVENTE'


-- Monto, Plazo y Periodicidad Solicitada
update #reporte_buro_diario_eva_cli 
set monto_sol = isnull(monto_sol, do_monto),
    plazo_sol = isnull(plazo_sol, do_num_cuotas),
	periodicidad_sol = isnull(periodicidad_sol, do_plazo)
from cob_conta_super..sb_dato_operacion
where do_fecha        = fecha
and do_codigo_cliente = ente
and do_banco          = banco 


-- Score
update #reporte_buro_diario_eva_cli
set score           = sb_valor,
    score_clave     = sb_codigo,
    score_nombre    = sb_nombre,
	score_cod_razon = sb_codigo_razon
from cob_credito..cr_score_buro
where sb_ib_secuencial = secuencial


-- Producto de Prestamos
update #reporte_buro_diario_eva_cli
set produc_prestamo = toperacion


-- SubProducto Prestamo
update #reporte_buro_diario_eva_cli
set sub_produc_prestamo = isnull((select top 1 tr_promocion
                                  from cob_credito..cr_tramite, cob_credito..cr_tramite_grupal
                                  where tr_tramite = tg_tramite 
                                  and   tg_prestamo = banco
                                  order by tr_tramite desc), sub_produc_prestamo)


-- Cuentas - Tiene Cuentas
update #reporte_buro_diario_eva_cli
set tiene_cuentas = 1
from cob_credito..cr_buro_cuenta
where bc_ib_secuencial = secuencial


-- Cuentas - Saldo Vencido
update #reporte_buro_diario_eva_cli
set saldo_vencido = (select sum(convert(money,bc_saldo_vencido))
                     from cob_credito..cr_buro_cuenta
                     where bc_ib_secuencial = secuencial
                     and   bc_forma_pago_actual in ('02','03','04','05','06','07'))


-- Maxima Morosidad Historico de Pagos 
update #reporte_buro_diario_eva_cli
set max_morosidad_hist = (select max(convert(int, bc_mop_historico_morosidad_mas_grave))
                          from cob_credito..cr_buro_cuenta
                          where bc_ib_secuencial = secuencial
                          group by bc_ib_secuencial)


-- Cuentas - Clave Observacion
update #reporte_buro_diario_eva_cli
set clave_observacion = (select count(bc_clave_observacion)
                         from cob_credito..cr_buro_cuenta
                         where bc_ib_secuencial = secuencial
                         and bc_clave_observacion in ('CV', 'FD', 'FR', 'GP', 'IM', 'LC', 'LO', 'RN', 'SG', 'UP', 'VR'))


-- Estatus Aprobacion
update #reporte_buro_diario_eva_cli
set estatus_aprobacion = -1
where nivel_riesgo_1 = 'F'

update #reporte_buro_diario_eva_cli
set estatus_aprobacion = isnull(estatus_aprobacion,0)
where nivel_riesgo_2 in ('MA','CE')

update #reporte_buro_diario_eva_cli
set estatus_aprobacion = isnull(estatus_aprobacion,1)
where color_cliente in ('VERDE','AMARILLO')



-- Registro Tabla Fisica
insert into rte_eval_grp_en017(
eg_bc_secuencial,             eg_folio_solicitud,      eg_fecha_solicitud,         eg_bc_fecha_solicitud_num, 
eg_bc_fecha_solicitud_semana, eg_sucursal,             eg_cc,                      eg_regional,
eg_clave_asesor,              eg_clave_gerente,        eg_clave_cordinador,        eg_ciclo_cliente,                
eg_monto_solicitado,          eg_plazo_solicitado,     eg_periodicidad_solicitada, eg_bc_score,                     
eg_clave_score,               eg_bc_score_nombre,      eg_bc_score_codrazon,       eg_id_cliente_cobis,             
eg_producto_prestamos,        eg_subprod_prestamo,     eg_bc_tiene_cuentas,        eg_bc_saldo_vencido,             
eg_bc_max_morosidad_hist,     eg_bc_clave_observacion, eg_nivel_riesgo,            eg_nivel_riesgo_score,           
eg_semaforo,                  eg_estatus_aprobacion,           
eg_fecha_reg,                 eg_login)					    
select
secuencial,                   folio_sol,               fecha_sol,                  fecha_sol_num,
fecha_sol_sem,                nom_sucursal,            centro_costos,              nom_regional,
cod_asesor,                   cod_gerente,             cod_coordinador,            ciclo_cliente,
monto_sol,                    plazo_sol,               periodicidad_sol,           score,
score_clave,                  score_nombre,            score_cod_razon,            ente,
produc_prestamo,              sub_produc_prestamo,     tiene_cuentas,              saldo_vencido,
max_morosidad_hist,           clave_observacion,       nivel_riesgo,               nivel_riesgo_2,
color_cliente,                estatus_aprobacion,
getdate(),                    'usrbatch'           
from #reporte_buro_diario_eva_cli

if @@error != 0 begin
   select 
   @w_error = 141080,
   @w_msg_error = 'No se pudo insertar tabla fisica rte_eval_grp_en017'
   goto ERROR_PROCESO
end


-- Registro Cabecera
insert into rte_eval_grp_en017_rpt(
re_bc_secuencial,             re_folio_solicitud,      re_fecha_solicitud,         re_bc_fecha_solicitud_num, 
re_bc_fecha_solicitud_semana, re_sucursal,             re_cc,                      re_regional,
re_clave_asesor,              re_clave_gerente,        re_clave_cordinador,        re_ciclo_cliente,                
re_monto_solicitado,          re_plazo_solicitado,     re_periodicidad_solicitada, re_bc_score,                     
re_clave_score,               re_bc_score_nombre,      re_bc_score_codrazon,       re_id_cliente_cobis,             
re_producto_prestamos,        re_subprod_prestamo,     re_bc_tiene_cuentas,        re_bc_saldo_vencido,             
re_bc_max_morosidad_hist,     re_bc_clave_observacion, re_nivel_riesgo,            re_nivel_riesgo_score,           
re_semaforo,                  re_estatus_aprobacion)				    
select 
'BC_Secuencial',              'Folio_Solicitud',       'Fecha_Solicitud',          'BC_Fecha_solicitud_num',
'BC_Fecha_solicitud_semana',  'Sucursal',              'CC',                       'Regional',
'Clave_asesor',               'Clave_gerente',         'Clave_cordinador',         'Ciclo_cliente',
'Monto_solicitado',           'Plazo_solicitado',      'Periodicidad_solicitada',  'BC_Score',
'Clave_Score',                'BC_Score_Nombre',       'BC_Score_CodRazon',        'ID_Cliente_Cobis',
'PRODUCTO DE PRESTAMOS',      'SUBPRODUCTO PRESTAMO',  'BC_Tiene_cuentas',         'BC_Saldo_vencido',
'BC_Max_Morosidad_Hist',      'BC_Clave_Observacion',  'Nivel_Riesgo',             'Nivel_Riesgo_Score',
'Semaforo',                   'Estatus_aprobacion'

if @@error != 0 begin
   select 
   @w_error = 141080,
   @w_msg_error = 'No se pudo insertar cabecera en rte_eval_grp_en017_rpt'
   goto ERROR_PROCESO
end


-- Registro Datos
insert into rte_eval_grp_en017_rpt(
re_bc_secuencial,             re_folio_solicitud,      re_fecha_solicitud,         re_bc_fecha_solicitud_num, 
re_bc_fecha_solicitud_semana, re_sucursal,             re_cc,                      re_regional,
re_clave_asesor,              re_clave_gerente,        re_clave_cordinador,        re_ciclo_cliente,                
re_monto_solicitado,          re_plazo_solicitado,     re_periodicidad_solicitada, re_bc_score,                     
re_clave_score,               re_bc_score_nombre,      re_bc_score_codrazon,       re_id_cliente_cobis,             
re_producto_prestamos,        re_subprod_prestamo,     re_bc_tiene_cuentas,        re_bc_saldo_vencido,             
re_bc_max_morosidad_hist,     re_bc_clave_observacion, re_nivel_riesgo,            re_nivel_riesgo_score,           
re_semaforo,                  re_estatus_aprobacion)					    
select
convert(varchar,secuencial),        
convert(varchar,folio_sol),   
convert(varchar,fecha_sol,112), --AAAAMMDD    
convert(varchar,fecha_sol_num),
convert(varchar,fecha_sol_sem),             
convert(varchar,nom_sucursal),        
convert(varchar,centro_costos),             
convert(varchar,nom_regional),
convert(varchar,asesor),                
convert(varchar,gerente),         
convert(varchar,coordinador),           
convert(varchar,ciclo_cliente),
convert(varchar,monto_sol),                 
convert(varchar,plazo_sol),           
convert(varchar,periodicidad_sol),          
convert(varchar,score),
convert(varchar,score_clave),               
convert(varchar,score_nombre),        
convert(varchar,score_cod_razon),           
convert(varchar,ente),
convert(varchar,produc_prestamo),           
convert(varchar,sub_produc_prestamo), 
convert(varchar,tiene_cuentas),             
convert(varchar,saldo_vencido),
convert(varchar,max_morosidad_hist),        
convert(varchar,clave_observacion),   
convert(varchar,nivel_riesgo),              
convert(varchar,nivel_riesgo_2),
convert(varchar,color_cliente),             
convert(varchar,estatus_aprobacion)   
from #reporte_buro_diario_eva_cli


if @@error != 0 begin
   select 
   @w_error = 17050,
   @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA rte_eval_grp_en017_rpt'
   goto ERROR_PROCESO
end
--

--GENERACION DEL REPORTE 
--FORMATO DE HORAS 
select 
@w_mes   = substring(convert(varchar,@w_fecha, 101),1,2),
@w_dia   = substring(convert(varchar,@w_fecha, 101),4,2),
@w_anio  = substring(convert(varchar,@w_fecha, 101),7,4)


--DATOS DEL ARCHIVO
select 
@w_file_rpt =  ba_arch_resultado,
@w_path     =  ba_path_destino,
@w_fecha_r  =  @w_anio + @w_mes + @w_dia 
from cobis..ba_batch 
where ba_batch = @w_batch

--ARMADA DEL NOMBRE DEL REPORTE 
select 
@w_file_rpt       = isnull(@w_file_rpt, 'Reporte_EvalGrupal_'),
@w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '.txt',
@w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '.err'


select @w_cmd     = @w_s_app + 's_app bcp -auto -login cobis..rte_eval_grp_en017_rpt out '

select @w_comando = @w_cmd  +  @w_file_rpt_1  + ' -b5000 -c -T -e ' + @w_file_rpt_1_out+ ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select 
  @w_return = 70146,
  @w_msg    = 'ERROR: GENERAR LISTADO'
  goto ERROR_PROCESO
end


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
	 @i_error         = @w_error,
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = null,
	 @i_rollback      = 'S'

     return @w_error

go
