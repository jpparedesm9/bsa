use cobis
go
/*************************************************************************/
/*   ARCHIVO:         sp_alerta_riesgo_batch.sp                          */
/*   NOMBRE LOGICO:   sp_alerta_riesgo_batch                             */
/*   Base de datos:   cobis                                              */
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
/*   FECHA         AUTOR            RAZON                                */
/* 09/Ene/2018    PXSG              Emision inicial                      */
/*************************************************************************/

if exists(select 1 from sysobjects where name = 'sp_alerta_riesgo_batch')
    drop proc sp_alerta_riesgo_batch
go
create proc sp_alerta_riesgo_batch (
    @t_show_version     bit         =   0,
    @i_param1           datetime   =   null -- FECHA DE PROCESO
)as
declare
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),  
  @w_msg            varchar(200),  
  @w_return         int,
  @w_dia            varchar(2),
  @w_mes            varchar(2),
  @w_anio           varchar(4),
  @w_fecha_r        varchar(10),
  @w_file_rpt       varchar(40),
  @w_file_rpt_1     varchar(140),
  @w_file_rpt_1_out varchar(140),
  @w_bcp            varchar(2000),
  @w_primer_dia     varchar(10),
  @w_ultimo_dia     varchar(10),
  @w_cabecera       varchar(30),
  @w_op_vigentes    int,
  @w_transacciones  int,
  @w_procesos       int,
  @w_usuarios_app   int,
  @w_fecha_proceso  datetime,
  @w_id_alerta      int,
  @w_fecha_salida   datetime  

select @w_sp_name = 'sp_alerta_riesgo_batch'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


/* FECHA PROCESO */
select @w_fecha_proceso = @i_param1

/* FECHA SALIDA */
select @w_fecha_salida = pa_datetime 
from   cobis..cl_parametro 
where  pa_nemonico = 'FCSALD' 
and    pa_producto='CLI' 

if(@i_param1 is null)
begin
select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso
end

print 'fecha_proceso--->'+ convert(varchar(50), @w_fecha_proceso)

declare @alertas as table 
(
	sucursal        int, 
	grupo		    int,
	codigoCliente   int,
	nombreGrupo     varchar(64),
	nombreCliente   varchar(100), 
	rfc             varchar(30),
	contrato		varchar(24), 
	tipoProducto    varchar(255), 
	tipoLista		varchar(2), 
	fechaConsulta	datetime, 
    fechaAlerta		datetime, 
	fechaOperacion  datetime, 
	fechaDictamina  datetime, 
	fechaReporte    datetime, 
	observaciones   varchar(255), 
	nivelRiesgo		varchar(255), 
	etiqueta		varchar(255), 
	escenario		varchar(255), 
	tipoAlerta		varchar(100), 
	tipoOperacion   varchar(255), 
	monto		    money, 
	estadoAlerta	varchar(100), 
	generaReporte	varchar(2),
	codigoIP        int
)

SELECT @w_id_alerta = max(ar_id_alerta) + 1 FROM cobis..cl_alertas_riesgo
/*
DELETE FROM cobis..cl_alertas_riesgo WHERE ar_tipo_lista IN ('LI','NF')
*/

insert into @alertas    
select  'sucursal'          = en_oficina,
        'grupo'             = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                                   where cg_ente = en_ente and cg_estado = 'V'),
        'codigoCliente'     = en_ente,
        'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                                   where cg_ente = en_ente and cg_estado = 'V')),
        'nombreCliente'     = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
        'rfc'               = isnull(en_nit,en_rfc),
        'contrato'          = (SELECT TOP 1 op_banco FROM cob_cartera..ca_operacion WHERE op_cliente=en_ente),
        'tipoProducto'      = (SELECT TOP 1 op_toperacion FROM cob_cartera..ca_operacion WHERE op_cliente=en_ente),
        'tipoLista'         = 'LI',
		'fechaConsulta'	    = @w_fecha_proceso,
        'fechaAlerta'       = ln_fecha_reg,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaOperacion'    = ln_fecha_reg,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaDictamina'    = null,-- fecha cuando se cambia de dictaminado ,
        'fechaReporte'      = null,-- Fecha cuando se envia el reporte
        'observaciones'     = ' ',
        'nivelRiesgo'       = ' ',
        'etiqueta'          = ' ',
        'escenario'         = ' ',
        'tipoAlerta'        = 'LN', -- Defecto Listas Negras
        'tipoOperacion'     = ' ',
        'monto'             = 0,
        'estado'            = 'EI', --Defecto status Investigacion
        'generaReporte'     = ' ',
        'codigoIP'          = null
from cobis..cl_ente, cob_credito..cr_lista_negra
where lower(ln_nombre) = lower((isnull(en_nombre, '') + isnull(' ' + p_s_nombre, '')))
and lower(ln_apellidos) = lower((isnull(p_p_apellido, '') + isnull(' ' + p_s_apellido, '')))
and ln_fecha_reg >= @w_fecha_salida
and en_ente not in (select ar_ente from cobis..cl_alertas_riesgo where ar_status = 'NR')
and en_ente not in (select ar_ente from cobis..cl_alertas_riesgo where ar_status = 'SR' and EOMONTH(ar_fecha_alerta)<@w_fecha_proceso )
--and (convert(varchar,ln_fecha_reg,103) <= convert(varchar,@w_fecha_proceso, 103)
--and convert(varchar,ln_fecha_reg,103) >= convert(varchar,dateadd(day,-7, @w_fecha_proceso), 103))


update cobis..cl_ente_aux set
ea_lista_negra = 'S'
from  @alertas
where codigoCliente  = ea_ente
and   tipoLista      = 'LI'
and   tipoAlerta     = 'LN'  
and   ea_lista_negra = 'N'

SELECT @w_id_alerta = max(ar_id_alerta) + 1 FROM cobis..cl_alertas_riesgo
insert into @alertas
select  'sucursal'          = en_oficina,
        'grupo'             = (select cg_grupo 
                                from cobis..cl_cliente_grupo where cg_ente = en_ente and cg_estado = 'V'),
        'codigoCliente'     = en_ente,
        'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                                   where cg_ente = en_ente and cg_estado = 'V')),
        'nombreCliente'     = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
        'rfc'               = isnull(en_nit,en_rfc),
        'contrato'          = (SELECT TOP 1 op_banco FROM cob_cartera..ca_operacion WHERE op_cliente=en_ente),
        'tipoProducto'      = (SELECT TOP 1 op_toperacion FROM cob_cartera..ca_operacion WHERE op_cliente=en_ente),
        'tipoLista'         = 'NF',
		'fechaConsulta'	    = @w_fecha_proceso,
        'fechaAlerta'       = nf_fecha_ultima_carga,--(SELECT convert(varchar,@w_fecha_proceso,103)), --(select convert(varchar,fp_fecha,103) from cobis..ba_fecha_proceso),
        'fechaOperacion'    = nf_fecha_ultima_carga,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaDictamina'    = null,-- fecha cuando se cambia a Dictaminado,
        'fechaReporte'      = null,-- fecha al generar el reporte,
        'observaciones'     = ' ',
        'nivelRiesgo'       = ' ',
        'etiqueta'          = ' ',
        'escenario'         = ' ',
        'tipoAlerta'        = 'NF', -- Defecto por Negative File
        'tipoOperacion'     = ' ',
        'monto'             = 0,
        'estado'            = 'EI', -- Defecto status Investigacion
        'generaReporte'     = ' ',
        'codigoIP'          = null
from cobis..cl_ente, cob_credito..cr_negative_file
where lower(replace(isnull(p_p_apellido,''),' ', ''))    = lower(replace(isnull(nf_ape_paterno,''),' ', ''))
and   lower(replace(isnull(p_s_apellido,''),' ', ''))    = lower(replace(isnull(nf_ape_materno,''),' ', ''))
and   (lower(replace(isnull(en_nombre,''),' ', '')) + lower(replace(isnull(p_s_nombre,''),' ', '')) = lower(replace(isnull(nf_nombre_razon_social,''),' ', ''))
or     lower(replace(isnull(c_razon_social,''),' ', '')) = lower(replace(isnull(nf_nombre_razon_social,''),' ', '')))
and   nf_fecha_ultima_carga >= @w_fecha_salida
and en_ente not in (select ar_ente from cobis..cl_alertas_riesgo where ar_status = 'NR')
and en_ente not in (select ar_ente from cobis..cl_alertas_riesgo where ar_status = 'SR' and EOMONTH(ar_fecha_alerta)<@w_fecha_proceso )
--and   (convert(varchar,nf_fecha_ultima_carga,103) <= convert(varchar,@w_fecha_proceso, 103)
--and   convert(varchar,nf_fecha_ultima_carga,103) >= convert(varchar,dateadd(day,-7, @w_fecha_proceso), 103))

UPDATE cobis..cl_alertas_riesgo SET
	   ar_fecha_consulta=fechaConsulta
	FROM @alertas 
	WHERE ar_ente     = codigoCliente
	AND ar_tipo_lista = tipoLista
	AND ar_etiqueta   = etiqueta

DELETE @alertas 
	FROM cobis..cl_alertas_riesgo 
	WHERE ar_ente     = codigoCliente
	AND ar_tipo_lista = tipoLista
	AND ar_etiqueta   = etiqueta


/* INSERTO EN TABLA FISICA */
insert into cobis..cl_alertas_riesgo
select sucursal,
    grupo,
    codigoCliente, 
    nombreGrupo,
    nombreCliente, 
    rfc,
    contrato, 
    tipoProducto,
    tipoLista,
    fechaConsulta,	
    fechaAlerta, 
    fechaOperacion, 
    fechaDictamina, 
    fechaReporte, 
    observaciones, 
    nivelRiesgo, 
    etiqueta,
    escenario,
    tipoAlerta,
    tipoOperacion,
    monto,
    estadoAlerta,
    generaReporte,
    codigoIP        
from @alertas

return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec cob_cartera..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = 70146,
     @i_descrp_error  = @w_msg

go
