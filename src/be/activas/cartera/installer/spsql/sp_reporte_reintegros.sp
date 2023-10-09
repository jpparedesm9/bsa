/************************************************************************/
/*  Archivo:                sp_reporte_reintegros.sp                    */
/*  Stored procedure:       sp_reporte_reintegros                       */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           --------                                    */
/*  Fecha de Documentacion: 19/03/2021                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Realiza consultas de los clientes para generar la reimpresión de     */
/* documentos                                                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/* 13/14/2021  Wismark Castro          Emision Inicial                  */
/* **********************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_reporte_reintegros')
    drop proc sp_reporte_reintegros
go

create proc sp_reporte_reintegros
   @i_operacion     char(1)    =   'I',
   @i_param1        datetime   =   null -- FECHA DE PROCESO

as

declare 
@w_fecha                   smalldatetime,
@w_fecha_ini               datetime,
@w_sp_name                 varchar(30),
@w_return                  int,
@w_s_app                   varchar(255),
@w_path                    varchar(255),
@w_nombre                  varchar(255),
@w_nombre_cab              varchar(255),
@w_destino                 varchar(2500),
@w_destino_detalle         varchar(2500),
@w_destino_cabecera        varchar(2500),
@w_errores                 varchar(1500),
@w_error                   int,
@w_fecha_proceso	       datetime = null,
@w_fecha_aux               datetime = null,
@w_ciudad                  int,
@w_comando                 varchar(3500),
@w_nombre_plano            varchar(2500),
@w_mensaje                 varchar(255),
@w_msg                     varchar(255),
@w_columna                 varchar(50),
@w_col_id                  int,
@w_cabecera                varchar(5000),
@w_reporte                 varchar(2500),
@w_fecha_pruebas           datetime,
@w_dia_sem                 int

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_reporte_reintegros'

print 'Start proces'

select @w_fecha_proceso = fc_fecha_cierre 
	from cobis..ba_fecha_cierre
	where fc_producto = 7

if @i_param1 is null 
    begin
		select @i_param1 = @w_fecha_proceso
    end

select @w_fecha = @i_param1

--Inicio generación tabla de trabajo

if @i_operacion = 'I' begin
		
		print 'Operación de creacion de tabla, @i_operacion = ' + @i_operacion
		
   		select 
   		operacion            = op_operacion,
   		oficina              = op_oficina,
   		banco                = op_banco,
   		grupo                = op_cliente,
   		monto_padre          = dd_monto,
   		monto_int_padre      = dd_monto_int,
   		monto_iva_padre      = dd_monto_iva
   		into #operacion_padre
   		from ca_devolucion_descuento,
   		ca_operacion
   		where dd_estado_pago = 'P'
   		and dd_tipo ='P'
   		and dd_operacion = op_operacion 
   		and dd_fecha_registro >= '12/19/2020'
   
   		select 
   		mca_operacion            = op_operacion,
   		mca_operacion_padre      = op_operacion,
   		mca_division             = convert(varchar(64),''),
   		mca_region               = convert(varchar(64),''),
   		mca_oficina              = op_oficina,
   		mca_grupo                = op_cliente,
   		mca_nombre_grupo         = convert(varchar(64),''),
   		mca_cliente              = dd_ente,
   		mca_banco                = op_banco,
   		mca_oficial_id           = op_oficial,
   		mca_oficial              = convert(varchar(64),''),
   		mca_oficial_status       = convert(varchar(64),''),
   		mca_coordinador_id       = convert(int,0),
   		mca_coordinador          = convert(varchar(64),''),
   		mca_gerente_id           = convert(int,0),
   		mca_gerente              = convert(varchar(64),''),
   		mca_fecha_desembolso     = op_fecha_liq,
   		mca_fecha_cancelacion    = op_fecha_fin,
   		mca_fecha_reintegro      = convert(datetime,null),
   		mca_producto             = op_toperacion,
   		mca_subtipo_producto     = convert(varchar(64),''),
   		mca_tasa                 = convert(float, null),
   		mca_tasa_diferencia      = dd_tasa_descuento,
   		mca_promocion            = 'DIGITALIZATE Y GANA',
   		mca_sub_promocion        = convert(varchar(64),''),
   		mca_monto_total          = op_monto,
   		mca_monto_devuelto       = dd_monto,
   		mca_motivo_dispercion    = 'TUIO CONFIAMOS',
   		mca_tramite              = convert(int, null),
   		dd_fecha_registro
   		into #reporte_devoluciones
   		from ca_devolucion_descuento, ca_operacion
   		where dd_operacion = op_operacion
   		and dd_estado_pago = 'P'
   		and dd_tipo ='P'
		and dd_monto <> 0
   		and dd_operacion = op_operacion 
   		and dd_fecha_registro >= '12/19/2020'
   
   		
   		update #reporte_devoluciones set
   		mca_tramite = op_tramite
   		from cob_cartera..ca_operacion
   		where mca_operacion_padre = op_operacion
   
   		select 
   		operacion_papa = mca_operacion,
   		banco = tg_referencia_grupal,
   		operacion_hija = tg_operacion
   		into #operaciones_hijas
   		from #reporte_devoluciones,
   		cob_cartera..ca_operacion,
   		cob_credito..cr_tramite_grupal
   		where mca_operacion =op_operacion
   		and op_banco = tg_referencia_grupal
   		and tg_prestamo <> tg_referencia_grupal
   		and tg_monto > 0
   
   
   		select operacion_papa, fecha= max(tr_fecha_ref)
   		into #ultima_transaccion
   		from #operaciones_hijas,
   		ca_operacion,
   		ca_transaccion
   		where operacion_hija = op_operacion
   		and   op_estado = 3
   		and  op_operacion = tr_operacion
   		group by operacion_papa
   
   
   		update #reporte_devoluciones set
   		mca_fecha_cancelacion = fecha
   		from #ultima_transaccion
   		where mca_operacion = operacion_papa
   

   		update #reporte_devoluciones set 
   		mca_tasa  = ro_porcentaje
   		from ca_rubro_op
   		where ro_operacion = mca_operacion
   		and   ro_concepto  = 'INT' 
   
   
   		update #reporte_devoluciones
   		set mca_region = (select A.of_nombre
   						  from cobis..cl_oficina A, cobis..cl_oficina B
   						  where A.of_oficina = B.of_regional
   						  and   B.of_oficina = P.mca_oficina)
   		from  #reporte_devoluciones P
   
   		update #reporte_devoluciones
   		set mca_division = upper(of_nombre)
   		from cobis..cl_oficina
   		where  of_oficina = mca_oficina
   
   
   		update #reporte_devoluciones set
   		mca_nombre_grupo = gr_nombre,
   		mca_oficial_id   =  gr_oficial 
   		from cobis..cl_grupo
   		where mca_grupo = gr_grupo
   
   		update  #reporte_devoluciones set 
   		mca_coordinador_id = fu_jefe,
   		mca_oficial        = fu_nombre
   		from cobis..cl_funcionario f
   		where fu_funcionario = mca_oficial_id  
   
   
   		update  #reporte_devoluciones set 
   		mca_gerente_id  = fu_jefe ,
   		mca_coordinador = fu_nombre
   		from cobis..cl_funcionario 
   		where fu_funcionario = mca_coordinador_id 
   
   		update  #reporte_devoluciones set 
   		mca_gerente = fu_nombre
   		from cobis..cl_funcionario 
   		where fu_funcionario = mca_gerente_id  
   
   		update  #reporte_devoluciones set 
   		mca_fecha_reintegro = sod_fecha
   		from cob_cartera..ca_operacion,
   		cob_cartera..ca_santander_orden_deposito
   		where mca_operacion_padre = op_operacion
   		and op_banco = sod_banco
   		and sod_tipo = 'DSC'
   		and  dd_fecha_registro >= dateadd(dd,-4,sod_fecha)
   		and  dd_fecha_registro <= dateadd(dd,4,sod_fecha)

   
   		select distinct
   		tramite            = tr_tramite,
   		promocion          = case tr_promocion when 'S' then 'S' else 'N' end
   		into #tramites
   		from #reporte_devoluciones, 
   		cob_credito..cr_tramite t 
   		where mca_tramite = tr_tramite
   
   
   		update #reporte_devoluciones set 
   		mca_subtipo_producto   = case promocion when 'S' then 'PROMO' when 'N' then 'TRADICIONAL' else 'INDIVIDUAL' end
   		from #tramites
   		where mca_tramite = tramite
   
   
   
   		update #reporte_devoluciones set
   		mca_sub_promocion = case when mca_tasa - mca_tasa_diferencia = 70 then
   							'DIGITALIZATE Y GANA 14%'
   							else
   							'PAGO PUNTUAL 7%'
   							end
        
   		-----ARMADO TABLA REPORTE
   
   		--Limpiza tabla reporte Reintegros--
   		truncate table cob_cartera..ca_reporte_devol
   					   
   		--Encabezados de reporte 
   		insert into cob_cartera..ca_reporte_devol
   		(
   		REGION,             OFICINA,           GRUPO,                ID_COBIS,
   		CONTRATO ,          ID_ASESOR ,        ID_COORDINADOR,       ID_GERENTE,
   		FECHA_DESEMBOLSO,   FECHA_CANCELACION, FECHA_CREACION,       FECHA_REINTEGRO,
   		PRODUCTO,           SUB_PRODUCTO,      TASA_INTERES,         DIFERENCIA_TASAS,
   		PROMOCION ,         SUB_PROMOCION ,    MONTO_TOTAL_CREDITO , MONTO_DEVUELTO,   
   		MOTIVO_DISPERSION
   		)
   		select 
   		'REGION',             'OFICINA',           'GRUPO',                'ID_COBIS',
   		'CONTRATO' ,          'ID_ASESOR',         'ID_COORDINADOR',       'ID_GERENTE',
   		'FECHA_DESEMBOLSO',   'FECHA_CANCELACION', 'FECHA_CREACION',       'FECHA_REINTEGRO',
   		'PRODUCTO',           'SUB_PRODUCTO',      'TASA_INTERES',         'DIFERENCIA_TASAS',
   		'PROMOCION',          'SUB_PROMOCION',     'MONTO_TOTAL_CREDITO',  'MONTO_DEVUELTO',   
   		'MOTIVO_DISPERSION'
    
   		--Rango de reporte (semana laborable)--
   
   		--obtiene parametro DISTRITO FERIADO NACIONAL
   		select @w_ciudad = pa_smallint 
   			from cobis..cl_parametro 
   			where pa_nemonico = 'CFN' 
   			AND pa_producto = 'ADM'
   			
   			
   		if @@error != 0 or @@ROWCOUNT != 1
   		begin
   		   select @w_error = 609318
   		   goto ERROR_PROCESO
   		end
   
		SELECT @w_fecha_ini = @w_fecha
		
		--Lunes de esa semana 
		select @w_fecha_ini = DATEADD(WK,DATEDIFF(WK,0,@w_fecha_ini),0)
		
        --Lunes de la semana anterior (Semana del reporte)
        select @w_fecha_ini = dateadd(wk,-1,@w_fecha_ini)
		
		--Viernes de la semana anterior(Semana del reporte)
		select  @w_fecha_aux = dateadd(dd,4,@w_fecha_ini)
		
		-- Carga de info a tabla reporte
   		insert into cob_cartera..ca_reporte_devol
   		(
   		REGION,             OFICINA,           GRUPO,                ID_COBIS,
   		CONTRATO ,          ID_ASESOR ,        ID_COORDINADOR,       ID_GERENTE,
   		FECHA_DESEMBOLSO,   FECHA_CANCELACION, FECHA_CREACION,       FECHA_REINTEGRO,
   		PRODUCTO,           SUB_PRODUCTO,      TASA_INTERES,         DIFERENCIA_TASAS,
   		PROMOCION,          SUB_PROMOCION ,    MONTO_TOTAL_CREDITO , MONTO_DEVUELTO,   
   		MOTIVO_DISPERSION
   		)
   		select 
   		CONVERT(varchar(64),mca_region), 
   		CONVERT(varchar(64),mca_division),
   		CONVERT(varchar(64),mca_grupo),
   		CONVERT(varchar(64),mca_cliente),
   		CONVERT(varchar(64),mca_banco),
   		CONVERT(varchar(64),mca_oficial_id),
   		CONVERT(varchar(64),mca_coordinador_id),
   		CONVERT(varchar(64),mca_gerente_id),
   		CONVERT(varchar(64),mca_fecha_desembolso,111),
   		CONVERT(varchar(64),mca_fecha_cancelacion,111),
   		CONVERT(varchar(64),getdate(),111),  --'03/16/2021'  Revisar 
   		CONVERT(varchar(64),mca_fecha_reintegro,111),
   		CONVERT(varchar(64),mca_producto),
   		CONVERT(varchar(64),mca_subtipo_producto),
   		CONVERT(varchar(64),mca_tasa),
   		CONVERT(varchar(64),mca_tasa_diferencia),
   		CONVERT(varchar(64),mca_promocion),
   		CONVERT(varchar(64),mca_sub_promocion),
   		CONVERT(varchar(64),mca_monto_total),
   		CONVERT(varchar(64),mca_monto_devuelto),
   		CONVERT(varchar(64),mca_motivo_dispercion)
   		from #reporte_devoluciones
   		where mca_fecha_cancelacion between @w_fecha_ini and @w_fecha_aux
   		order by mca_grupo
		
   		print ' Finalizo el proceso de creación de tabla'
  
end

if @i_operacion = 'G' begin

           print 'Operación de generación de tabla, @i_operacion = ' + @i_operacion
		   
   		   /*** GENERAR BCP ***/
   		   select @w_s_app = pa_char
   		   from cobis..cl_parametro
   		   where pa_producto = 'ADM'
   		   and   pa_nemonico = 'S_APP'
   		   
   		   --Consultar
   		   select @w_path = pa_char 
   		   from cobis..cl_parametro 
   		   where pa_nemonico ='RRPATH'
   		   and pa_producto ='ADM'
   		   
   		   select @w_path = @w_path+'ReportePromociones\' 
   		   
   		   print 'Inicio generación reporte'
   		   print 'Path : '
   		   print @w_path
   			   
   			   select @w_comando = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_reporte_devol out '
   				select 
   				@w_destino_detalle  = @w_path + 'DISPERSIONES_TUIIO_' + replace(CONVERT(varchar(10), @w_fecha,112),'/', '')+ '.txt',
   				@w_errores  = @w_path + 'DISPERSIONES_TUIIO_' + replace(CONVERT(varchar(10), @w_fecha,112),'/', '')+ '.err'
   				
   				select @w_comando = @w_comando + @w_destino_detalle + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
   				
   				PRINT ' CMD: ' + @w_comando 
   				
   				exec @w_error = xp_cmdshell @w_comando
   				
   				if @w_error <> 0 
   				begin
   				   select
   				   @w_error = 70171,
   				   @w_mensaje = 'Error generando Archivo de DISPERSIONES_TUIIO Semanal'
   				   goto ERROR_PROCESO
   				end
   					
   		--ERROR GENERAL DEL PROCESO 
   		return 0
   
   		ERROR_PROCESO:
   		   select @w_msg = isnull(@w_mensaje, 'ERROR GENERAL DEL PROCESO')
   		   
   		   exec cob_cartera..sp_errorlog
   		   @i_error         = @w_error,
   		   @i_fecha         = @w_fecha,  
   		   @i_usuario       = 'usrbatch',
   		   @i_tran          = 26004,
   		   @i_tran_name     = @w_sp_name,
   		   @i_rollback    = 'N',
   		   @i_descripcion = @w_msg   
   
   		   return @w_error
   return 0

end

go
