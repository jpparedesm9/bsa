
use cob_cartera
go

truncate table ca_vigencia_funeral_net

declare
@w_sp_name             varchar(32),          
@w_path_destino        varchar(200), 
@w_s_app               varchar(40),
@w_cmd                 varchar(5000),
@w_destino             varchar(255),
@w_errores             varchar(255),
@w_comando             varchar(6000),
@w_error               int, 
@w_path                varchar(255),
@w_mensaje             varchar(100),
@w_fecha_proc          datetime,
@w_ffecha              int,
@w_col_id              int,
@w_columna             varchar(50),
@w_cabecera            varchar(5000),
@w_destino_cabecera    varchar(255),
@w_destino_lineas      varchar(255),
@w_est_anulado         int,
@w_est_novigente       int,
@w_est_cancelado       int,
@w_est_castigado       int,
@w_est_vencido         int,
@w_est_vigente         int

TRUNCATE TABLE seguros_funeral_net_altas_tmp

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso
select @w_ffecha = 103 

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_anulado    = @w_est_anulado    out,
@o_est_novigente  = @w_est_novigente  out,
@o_est_cancelado  = @w_est_cancelado  out,
@o_est_castigado  = @w_est_castigado  out,
@o_est_vencido    = @w_est_vencido    out,
@o_est_vigente    = @w_est_vigente    out 


create table #seguros_funeral_net_altas(
 ra_ente				int				null,
 ra_identificador  		varchar(64)     null,
 ra_apellido_paterno   	varchar(64)		null,
 ra_apellido_materno   	varchar(64)		null,
 ra_nombre				varchar(100)	null,
 ra_fecha_de_emision	varchar(10)	    null,
 ra_edad				tinyint			null,
 ra_rfc                 varchar(30)     null,
 ra_operacion           varchar(10)     null,
 ra_tipo_plan           varchar(10)     null
)

insert into seguros_funeral_net_altas_tmp
select 
'IDENTIFICADOR',
'APELLIDO PATERNO',
'APELLIDO MATERNO',
'NOMBRE',
'FECHA DE EMISION',
'EDAD',
'RFC' ,
'OPERACION',
'TIPO_PLAN'

--Datos de Credito para tipo 01 y subtipo 0025
insert into #seguros_funeral_net_altas
SELECT distinct
	op_cliente,
	en_banco,
	isnull(p_p_apellido,''),
	isnull(p_s_apellido,''),
	isnull(en_nombre,'')+' '+isnull(p_s_nombre,''),
	convert(varchar(10),max(op_fecha_liq),103),
	datediff(year, isnull(p_fecha_nac,@w_fecha_proc), @w_fecha_proc),
	en_rfc,
	'ALTA',
	'01'
FROM cob_cartera..ca_operacion,
     cobis..cl_ente
where op_estado = @w_est_vigente
and op_cliente  = en_ente
and op_toperacion <> 'REVOLVENTE'
and en_banco is not null
and not exists(select 1 
               from ca_vigencia_funeral_net 
               where vfn_ente       = en_ente
               and   vfn_fecha_baja is null)
group by op_cliente, en_banco, p_p_apellido, p_s_apellido, en_nombre, p_s_nombre, p_fecha_nac, en_rfc             

--Datos de Credito para tipo 01 y subtipo 0025
insert into #seguros_funeral_net_altas
SELECT distinct
	op_cliente,
	en_banco,
	isnull(p_p_apellido,''),
	isnull(p_s_apellido,''),
	isnull(en_nombre,'')+' '+isnull(p_s_nombre,''),
	convert(varchar(10),max(op_fecha_liq),103),
	datediff(year, isnull(p_fecha_nac,@w_fecha_proc), @w_fecha_proc),
	en_rfc,
	'ALTA',
	'01'
FROM cob_cartera..ca_operacion,
     cobis..cl_ente
where op_toperacion = 'REVOLVENTE'
and   op_fecha_fin  > @w_fecha_proc
and   op_cliente  = en_ente
and  en_banco is not null
and not exists(select 1 
               from ca_vigencia_funeral_net 
               where vfn_ente       = en_ente
               and   vfn_fecha_baja is null)
group by op_cliente, en_banco, p_p_apellido, p_s_apellido, en_nombre, p_s_nombre, p_fecha_nac, en_rfc             

/******************************************************************/
/* Actualizacion fecha vigencia                                   */
/******************************************************************/
select  
cliente   = op_cliente, 
fecha_fin = max(op_fecha_fin) 
into #operaciones
from  ca_operacion,
      ca_vigencia_funeral_net
where op_cliente    = vfn_ente
and   op_estado     = @w_est_vigente
and   op_operacion <> vfn_operacion
and   vfn_fecha_baja is null
group by op_cliente

select cliente, op_operacion, fecha_fin 
into #operaciones_activas
from #operaciones,
     cob_cartera..ca_operacion
where op_cliente  = cliente
and   op_fecha_fin= fecha_fin
and   op_estado   = @w_est_vigente

update ca_vigencia_funeral_net
set vfn_operacion      = op_operacion,
    vfn_fecha_vigencia = fecha_fin
from #operaciones_activas
where vfn_ente    = cliente
                

--Datos del Cliente 		   
insert into seguros_funeral_net_altas_tmp(
	ra_identificador,  	
    ra_apellido_paterno,
    ra_apellido_materno,
    ra_nombre,			
    ra_fecha_de_emision,
    ra_edad,
    ra_rfc,
    ra_operacion,
    ra_tipo_plan
)
select distinct    
	ra_identificador,  	
	ra_apellido_paterno,
	ra_apellido_materno,
	ra_nombre,			
	ra_fecha_de_emision,
	ra_edad,
	ra_rfc,
    ra_operacion,
    ra_tipo_plan 
from #seguros_funeral_net_altas	

select                      
ra_ente,  ra_identificador,'fecha_fin' = max(op_fecha_fin)  
into #operaciones_altas
from #seguros_funeral_net_altas, 
     ca_operacion
where op_cliente = ra_ente
and   op_estado  = @w_est_vigente
group by ra_ente,  ra_identificador

insert into ca_vigencia_funeral_net(
vfn_ente, vfn_buc         ,  vfn_fecha_inicio, vfn_operacion )
select distinct 
ra_ente,  ra_identificador,  @w_fecha_proc   , max(op_operacion)
from #operaciones_altas,
     ca_operacion
where ra_ente      = op_cliente
and   op_fecha_fin = fecha_fin
group by ra_ente,  ra_identificador


update ca_vigencia_funeral_net
set vfn_fecha_vigencia = op_fecha_fin
from ca_operacion 
where vfn_operacion = op_operacion

select *
from cob_cartera..seguros_funeral_net_altas_tmp



go

