/*************************************************************************/
/*   ARCHIVO:         sp_cliente_condicionado.sp                          */
/*   NOMBRE LOGICO:   sp_cliente_condicionado                             */
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
/* 28/Jun/2018    PXSG   Emision inicial                                 */
/*************************************************************************/
USE cobis
go
IF OBJECT_ID ('dbo.sp_cliente_condicionado') IS NOT NULL
	DROP PROCEDURE dbo.sp_cliente_condicionado
GO

CREATE PROCEDURE sp_cliente_condicionado (	
	@t_debug                   char(1) 	     = 'N',
	@t_file                    varchar(14)   = null,
	@t_from                    varchar(32)   = null,
	@t_show_version            bit           = 0,
	@s_rol                     smallint      = null,
	@i_ente                    int           = null
)
as 

DECLARE
    @w_sp_name               varchar(32),   
    @w_error                 int,
    @w_etiqueta              varchar(255),
	@w_fecha_proceso         datetime,
    @w_tab_cat_alerta        varchar(100),
    @w_cli_a3ccc             varchar(255),
    @w_cli_a3bloq            varchar(255)

	      
/*  Inicializacion de Variables  */
select @w_sp_name = 'sp_cliente_condicionado'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
SET @w_etiqueta='Condicionado'
SET @w_tab_cat_alerta='cl_alertas_tlista'

select @w_cli_a3ccc        = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CA3CCC' AND pa_producto='CLI'
select @w_cli_a3bloq       = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CA3BLO' AND pa_producto='CLI'


/*Declaro tabal temporal para los clientes condicionados*/
/*
DELETE  FROM cobis..cl_alertas_riesgo WHERE ar_etiqueta=@w_etiqueta
*/
declare @alertas_cli_condicionanos as table 
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
	fechaConsulta   datetime,
    fechaAlerta		datetime, 
	fechaOperacion  datetime, 
	fechaDictamina  datetime, 
	fechaReporte    datetime, 
	observaciones   varchar(255), 
	nivelRiesgo		varchar(255), 
	etiqueta		varchar(255), 
	escenario		varchar(300), 
	tipoAlerta		varchar(100), 
	tipoOperacion   varchar(255), 
	monto		    money, 
	estadoAlerta	varchar(100), 
	generaReporte	varchar(2),
	codigoIP        int
)

insert into @alertas_cli_condicionanos  
select  'sucursal'          = en_oficina,
        'grupo'             = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                                   where cg_ente = en_ente and cg_estado = 'V'),
        'codigoCliente'     = en_ente,
        'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                                   where cg_ente = en_ente and cg_estado = 'V')),
        'nombreCliente'     = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
        'rfc'               = isnull(en_nit,en_rfc),
        'contrato'          = null,
        'tipoProducto'      = null,
        'tipoLista'         = (SELECT ct.codigo FROM cobis..cl_tabla t,cobis..cl_catalogo ct
                               WHERE t.codigo=ct.tabla AND t.tabla=@w_tab_cat_alerta
                                AND ct.valor=@w_etiqueta),
		'fechaConsulta'     = @w_fecha_proceso,						
        'fechaAlerta'       = @w_fecha_proceso,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaOperacion'    = @w_fecha_proceso,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaDictamina'    = null,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'fechaReporte'      = null,--(SELECT convert(varchar,@w_fecha_proceso,103)),
        'observaciones'     = null,
        'nivelRiesgo'       = null,
        'etiqueta'          = ' ',
        'escenario'         = null,
        'tipoAlerta'        = ISnull(@w_etiqueta,'Condicionado'), --Cliente Condicionado
        'tipoOperacion'     = null,
        'monto'             = null,
        'estado'            = 'EI', 
        'generaReporte'     = null,
	     'codigoIP'         =null
from cobis..cl_ente, cobis..cl_ente_aux
WHERE en_ente=ea_ente
and   en_ente=@i_ente

UPDATE cobis..cl_alertas_riesgo SET
	   ar_fecha_consulta=fechaConsulta
	FROM @alertas_cli_condicionanos 
	WHERE ar_ente     = codigoCliente
	AND ar_tipo_lista = tipoLista
	AND ar_etiqueta   = etiqueta


DELETE @alertas_cli_condicionanos 
	FROM cobis..cl_alertas_riesgo 
	WHERE ar_ente     = codigoCliente
	AND ar_tipo_lista = tipoLista
	AND ar_etiqueta   = etiqueta

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
from @alertas_cli_condicionanos

return 0

--ERROR:
--    begin --Devolver mensaje de Error 
--    exec cobis..sp_cerror
--         @t_debug = @t_debug,
--         @t_file  = @t_file,
--         @t_from  = @w_sp_name,
--         @i_num   = @w_error
--    return @w_error
--    end
--go




GO

