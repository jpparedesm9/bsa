/************************************************************************/
/*      Archivo:                pf_maestro.sp                           */
/*      Stored procedure:       maestro_pry_pf                         	*/
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yecid Martinez                      	*/
/*      Fecha de documentacion: 06/04/2010                              */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Carga maestro de plazo fijo.                			*/
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'maestro_pry_pf' and type = 'P')
   drop proc maestro_pry_pf
go

create proc maestro_pry_pf
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int		        = null,
@i_param1       	    varchar(255) 	= NULL,
@i_param2       	    varchar(255) 	= NULL
with encryption
as
declare 
@w_sp_name              descripcion,
@w_return               tinyint,
@w_error                int,
@w_periodo		        float,
@w_numdeci              tinyint,
@w_mes			        varchar(10),
@w_dia			        varchar(10),
@w_ano			        varchar(10),
@w_hora			        varchar(10),
@w_min			        varchar(10),
@w_path_s_app           varchar(30),
@w_path                 varchar(250),
@w_s_app                varchar(250),
@w_cmd                  varchar(250),
@w_archivo              descripcion,
@w_archivo_bcp          descripcion,
@w_errores              descripcion,
@w_msg                  descripcion,
@w_descripcion          varchar(254),
@w_cabecera             varchar(8000),
@w_tabla                sysname,
@w_comando              varchar(8000)

/** DEBUG **/
select @w_sp_name = 'maestro_pry_pf'


declare	@w_fecha_fin           datetime,
	@w_fecha_ini            datetime,
	@w_numbanco		varchar(1000),
	@w_detalle		char(1),
	@w_fecha		datetime

select	@w_fecha_ini = @i_param1,
	@w_fecha_fin = @i_param2


if @i_param1 = @i_param2
	select   @w_fecha_fin    = fc_fecha_cierre,
	         @w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
	from  cobis..ba_fecha_cierre
	where fc_producto = 14


/* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */

select 	@w_fecha = isnull(fp_fecha,getdate())
from	cobis..ba_fecha_proceso

select	@w_mes 	= convert(varchar,datepart(mm,@w_fecha)),
	@w_dia 	= convert(varchar,datepart(dd,@w_fecha)),
	@w_ano 	= convert(varchar,datepart(yy,@w_fecha)),
	@w_hora	= convert(varchar,datepart(hh,getdate())),
	@w_min	= convert(varchar,datepart(mi,getdate()))



	-- BORRO TABLAS
	truncate table pf_maestro_plan_pagos_aux
	truncate table pf_maestro_plan_pagos


	-- 'PROYECCIONES . UNICO PERIODO. VIGENTES '
	
	insert into pf_maestro_plan_pagos_aux
	select 	@w_fecha,
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_regional) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_zona) from cobis..cl_oficina O where of_oficina = op_oficina),
		op_oficina,
		op_num_banco,
		op_fecha_ven,
		op_monto,
		op_total_int_estimado,
		0,
		op_monto  + op_total_int_estimado,
		(select case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end from cobis..cl_ente where  en_ente = P.op_ente),
		'V',
		op_estado 
	from 	cob_pfijo..pf_operacion P
	where 	op_fpago = 'VEN'
	and    	op_estado in ('ACT', 'VEN')


	-- 'PROYECCIONES . PERIODICOS '
		
	insert into pf_maestro_plan_pagos_aux
	select 	@w_fecha,
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_regional) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_zona) from cobis..cl_oficina O where of_oficina = op_oficina),
		op_oficina,
		op_num_banco,
		cu_fecha_pago,
		case when datediff(dd,cu_fecha_pago,op_fecha_ven) = 0 then op_monto else 0 end, 
		cu_valor_cuota,
		0,
		case when datediff(dd,cu_fecha_pago,op_fecha_ven) = 0 then op_monto + cu_valor_cuota else cu_valor_cuota end,
		(select case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end from cobis..cl_ente where  en_ente = P.op_ente),
                cu_estado,
                op_estado
	from    cob_pfijo..pf_operacion P, 
		cob_pfijo..pf_cuotas
	where   (op_estado in ('ACT', 'VEN')
	or      (op_estado  	= 'CAN' and op_fecha_cancela between @w_fecha_ini  and @w_fecha_fin))
	and     op_fpago        = 'PER'
	and     op_operacion    = cu_operacion

	
	insert into pf_maestro_plan_pagos
	select	convert(varchar,mp_fecha,101),		
		mp_territorial,
		mp_zona	,
		mp_oficina ,
		mp_num_banco,		
		convert(varchar,mp_fecha_pago,101),		
		mp_monto,		
		mp_interes,		
		mp_otros,		
		mp_total,		
                mp_tipo_compania,
                mp_estado,
                mp_estado_op
	from	pf_maestro_plan_pagos_aux
	order by mp_territorial, mp_zona, mp_oficina, mp_num_banco, mp_fecha_pago


-- Consulta path de s_app

select	@w_path_s_app = pa_char
from   	cobis..cl_parametro
where  	pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

-- Consulta path de salida de pfijo en donde se guardara el archivo de salida

select 	@w_s_app = @w_path_s_app + 's_app'

select	@w_path = ba_path_destino
from  	cobis..ba_batch
where 	ba_batch = 14090

if @t_debug = 'S' print ' w_path ' + cast (@w_path as varchar)

-- Armar comando BCP que carga datos del maestro_aux

select	@w_archivo_bcp 	= @w_path  + 'Contenido', 
	@w_errores     	= @w_path  + 'error_' + @w_sp_name + '_' + @w_mes + @w_dia + @w_ano + '_' + @w_hora + @w_min,
	@w_cmd         	= @w_s_app + ' bcp -auto -login cob_pfijo..pf_maestro_plan_pagos out '
select	@w_comando 	= @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini ' + '-t;' 
print 'w_comando ' + cast (@w_comando as varchar)
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
	select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo+ ' '+ convert(varchar, @w_error)
	goto ERROR
end

-- Genero archivo con datos de cabecera segun campos de tabla pf_maestro

select 	@w_tabla = 'cob_pfijo..pf_maestro_plan_pagos'
select 	@w_cabecera = isnull(@w_cabecera + ';', '') + name from syscolumns where id = object_id(@w_tabla) order by colid
--select 	@w_cabecera = substring(@w_cabecera,2,datalength(@w_cabecera)) 
select 	@w_comando = 'echo ' + @w_cabecera + '>' + @w_path  + @w_sp_name + '_' + @w_mes + @w_dia + @w_ano + '_' + @w_hora + @w_min
print 'w_comando ' + cast (@w_comando as varchar)
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
	select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo+ ' '+ convert(varchar, @w_error)
	goto ERROR
end

-- Copio contenido en archivo definitivo

select @w_comando = 'type ' + @w_archivo_bcp + ' >>' + @w_path  + @w_sp_name + '_' + @w_mes + @w_dia + @w_ano + '_' + @w_hora + @w_min
print 'w_comando ' + cast (@w_comando as varchar)
exec xp_cmdshell @w_comando

if @w_error <> 0 begin
	select @w_msg = 'ERROR AL GENERAR ARCHIVO CABECERA'+ ' ' + convert(varchar, @w_error)
	goto ERROR
end

-- Elimina contenido de archivo auxiliar

select @w_comando = 'del ' + @w_archivo_bcp 
print 'w_comando ' + cast (@w_comando as varchar)
exec xp_cmdshell @w_comando

if @w_error <> 0 begin
	select @w_msg = 'ERROR AL GENERAR ARCHIVO CABECERA'+ ' ' + convert(varchar, @w_error)
	goto ERROR
end

return 0
ERROR:

select @w_descripcion = 'Error Inserccion maestro_pf ' + + @w_mes + @w_dia + @w_ano + @w_hora

exec sp_errorlog
@s_date      = @w_fecha,
@i_fecha     = @w_fecha,
@i_error     = 1,
@i_usuario   = 'operador',
@i_tran      = 14090,
@i_cuenta    = @w_descripcion,
@i_descripcion = @w_msg,
@i_cta_pagrec  = ''

return 1

go


