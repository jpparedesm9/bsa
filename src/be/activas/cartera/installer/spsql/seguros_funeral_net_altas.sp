/************************************************************************/
/*   Archivo:              seguros_funeral_net_altas.sp                 */
/*   Stored procedure:     sp_seguro_funeral_net_altas		   	        */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Nolberto Vite		                        */
/*   Fecha de escritura:   25 Junio 2018                                */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera el reporte de los clientes identificados con la cuenta N2   */
/*    “Superdigital” con el Producto 01 y Sub-Producto 25.              */
/*                                                                      */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      25/06/2018     NVI             Emision Inicial                  */
/*      21/05/2019     DCU             Cambio req. 114570               */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_seguro_funeral_net_altas')
   drop proc sp_seguro_funeral_net_altas
go

create proc sp_seguro_funeral_net_altas
(
 @i_param1  DATETIME = null 
)
as 

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
	convert(varchar(10),op_fecha_liq,103),
	datediff(year, isnull(p_fecha_nac,@w_fecha_proc), @w_fecha_proc),
	en_rfc,
	'ALTA',
	'01'
FROM cob_cartera..ca_operacion,
     cobis..cl_ente
WHERE op_estado  = @w_est_vigente
and op_cliente   = en_ente
and op_fecha_liq = @w_fecha_proc
and op_toperacion <>  'REVOLVENTE'
and not exists(select 1 
               from ca_vigencia_funeral_net 
               where vfn_ente       = en_ente
               and   vfn_fecha_baja is null)


insert into #seguros_funeral_net_altas
SELECT distinct
	op_cliente,
	en_banco,
	isnull(p_p_apellido,''),
	isnull(p_s_apellido,''),
	isnull(en_nombre,'')+' '+isnull(p_s_nombre,''),
	convert(varchar(10),op_fecha_liq,103),
	datediff(year, isnull(p_fecha_nac,@w_fecha_proc), @w_fecha_proc),
	en_rfc,
	'ALTA',
	'01'
FROM cob_cartera..ca_operacion o,
     cobis..cl_ente
WHERE op_toperacion = 'REVOLVENTE'
and op_cliente      = en_ente
and op_fecha_liq    = @w_fecha_proc
and op_estado      in (@w_est_cancelado, @w_est_vigente)
and not exists(select 1 
               from ca_vigencia_funeral_net 
               where vfn_ente       = en_ente
               and   vfn_fecha_baja is null)
and not exists(select 1 
               from #seguros_funeral_net_altas 
               where ra_ente = en_ente )            
                              
/******************************************************************/
/* Actualizacion fecha vigencia                                   */
/******************************************************************/
update ca_vigencia_funeral_net
set vfn_fecha_vigencia = op_fecha_fin
from ca_operacion
where op_operacion = vfn_operacion
and   vfn_fecha_vigencia is null

--Actualizacion fecha vigencia grupales
select  
cliente   = op_cliente, 
fecha_fin = max(op_fecha_fin) 
into #operaciones
from  ca_operacion,
      ca_vigencia_funeral_net
where op_cliente    =  vfn_ente
and   op_estado     =  @w_est_vigente
and   op_operacion  <> vfn_operacion
and   op_toperacion <> 'REVOLVENTE'
and   vfn_fecha_baja is null
group by op_cliente

select cliente, op_operacion, fecha_fin 
into #operaciones_activas
from #operaciones,
     cob_cartera..ca_operacion
where op_cliente  = cliente
and op_fecha_fin  = fecha_fin
and op_estado     = @w_est_vigente
and op_toperacion <>  'REVOLVENTE'
and fecha_fin    is not null

update ca_vigencia_funeral_net
set vfn_operacion      = op_operacion,
    vfn_fecha_vigencia = fecha_fin
from #operaciones_activas
where vfn_ente           = cliente
and   vfn_fecha_vigencia < fecha_fin

--Actualizacion fecha vigencia revolventes
select  
cliente   = op_cliente, 
fecha_fin = max(op_fecha_fin) 
into #operaciones_revol
from  ca_operacion,
      ca_vigencia_funeral_net
where op_cliente     = vfn_ente
and   op_estado      in (@w_est_cancelado, @w_est_vigente)
and   op_operacion   <> vfn_operacion
and   op_toperacion  =  'REVOLVENTE'
and   vfn_fecha_baja is null
and   op_fecha_fin   >= @w_fecha_proc
group by op_cliente

select cliente, op_operacion, fecha_fin 
into #operaciones_activas_revol
from #operaciones_revol,
     cob_cartera..ca_operacion
where op_cliente    = cliente
and   op_estado     in (@w_est_cancelado, @w_est_vigente)
and   op_fecha_fin  = fecha_fin
and   op_toperacion = 'REVOLVENTE'
and   op_fecha_fin >= @w_fecha_proc
and   fecha_fin    is not null

update ca_vigencia_funeral_net
set vfn_operacion      = op_operacion,
    vfn_fecha_vigencia = fecha_fin
from #operaciones_activas_revol
where vfn_ente           = cliente
and   vfn_fecha_vigencia < fecha_fin

--Sustituir vigencia Operaciones @w_est_castigado, @w_est_cancelado
select cliente = op_cliente, operacion_can = op_operacion
into #operaciones_baja  
from ca_vigencia_funeral_net,
     ca_operacion  
where vfn_operacion  = op_operacion
and   vfn_ente       = op_cliente   
and   op_estado      in (@w_est_castigado, @w_est_cancelado)
and   vfn_fecha_baja is null
and   op_toperacion <> 'REVOLVENTE'

insert into #operaciones_baja 
select cliente = op_cliente, operacion_can = op_operacion
from ca_vigencia_funeral_net,
     ca_operacion  
where vfn_operacion  = op_operacion
and   vfn_ente       = op_cliente   
and   op_estado      = @w_est_castigado
and   vfn_fecha_baja is null
and   op_toperacion  = 'REVOLVENTE'

insert into #operaciones_baja 
select cliente = op_cliente, operacion_can = op_operacion
from ca_vigencia_funeral_net,
     ca_operacion  
where vfn_operacion  = op_operacion
and   vfn_ente       = op_cliente   
and   op_estado      = @w_est_cancelado
and   op_fecha_fin   < @w_fecha_proc
and   vfn_fecha_baja is null
and   op_toperacion  = 'REVOLVENTE'
   
select cliente       = op_cliente        , 
       fecha_fin     = max(op_fecha_fin) , 
       operacion_can = max(operacion_can)
into #operaciones_activas_rem
from cob_cartera..ca_operacion,
      #operaciones_baja
where op_cliente = cliente
and   op_estado  = @w_est_vigente
group by op_cliente

select op_cliente   , 
       op_operacion ,
       operacion_can,
       op_fecha_fin
into #operaciones_reemplazar
from cob_cartera..ca_operacion,
     #operaciones_activas_rem
where op_cliente  = cliente
and   op_estado   = @w_est_vigente
and   op_fecha_fin= fecha_fin 

update ca_vigencia_funeral_net
set   vfn_operacion      = op_operacion,
      vfn_fecha_vigencia = op_fecha_fin
from  #operaciones_reemplazar
where vfn_ente      = op_cliente
and   vfn_operacion = operacion_can  

                
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
where op_cliente    = ra_ente
and   op_estado     in (@w_est_cancelado, @w_est_vigente)
and   op_toperacion = 'REVOLVENTE'
group by ra_ente,  ra_identificador

insert into #operaciones_altas
select                      
ra_ente,  ra_identificador,'fecha_fin' = max(op_fecha_fin)  
from #seguros_funeral_net_altas, 
     ca_operacion
where op_cliente    = ra_ente
and   op_estado     = @w_est_vigente
and   op_toperacion <> 'REVOLVENTE'
and   not exists (select 1 from #operaciones_altas where ra_ente = op_cliente)
group by ra_ente,  ra_identificador

insert into ca_vigencia_funeral_net(
vfn_ente, vfn_buc         ,  vfn_fecha_inicio, vfn_operacion, vfn_fecha_vigencia )
select distinct
ra_ente,  ra_identificador,  @w_fecha_proc   , op_operacion , op_fecha_fin
from #operaciones_altas,
     ca_operacion
where ra_ente      = op_cliente
and   op_fecha_fin = fecha_fin
and   op_estado    = @w_est_vigente
and   op_toperacion <> 'REVOLVENTE'

insert into ca_vigencia_funeral_net(
vfn_ente, vfn_buc         ,  vfn_fecha_inicio, vfn_operacion, vfn_fecha_vigencia )
select distinct
ra_ente,  ra_identificador,  @w_fecha_proc   , op_operacion , op_fecha_fin
from #operaciones_altas,
     ca_operacion
where ra_ente       = op_cliente
and   op_fecha_fin  = fecha_fin
and   op_estado     in (@w_est_cancelado, @w_est_vigente)
and   op_toperacion = 'REVOLVENTE'
----------------------------------------
--	Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
	
	
select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7
		
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..seguros_funeral_net_altas_tmp out '

select 	@w_destino= @w_path + 'FUNERAL_NET_ALTAS_' +  replace(CONVERT(varchar(10), @w_fecha_proc, @w_ffecha),'/', '')+ '.txt',
	    @w_errores  = @w_path + 'FUNERAL_NET_ALTAS_' +  replace(CONVERT(varchar(10), @w_fecha_proc, @w_ffecha),'/', '')+ '.err'
	
select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

PRINT ' CMD: ' + @w_comando 

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724680,
   @w_mensaje = 'Error generando Archivo de Seguros Funeral Net Altas'
   goto ERROR
end

return 0

ERROR:
exec cobis..sp_errorlog 
	@i_fecha        = @w_fecha_proc,
	@i_error        = @w_error,
	@i_usuario      = 'usrbatch',
	@i_tran         = 26004,
	@i_descripcion  = @w_mensaje,
	@i_tran_name    =null,
	@i_rollback     ='S'
return @w_error

go

