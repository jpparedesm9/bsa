/************************************************************************/
/*      Archivo:                pf_maestro.sp                           */
/*      Stored procedure:       maestro_pf                              */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yecid Martinez                      	*/
/*      Fecha de documentacion: 06/04/2010                              */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Carga maestro de plazo fijo.                                    */
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

if exists ( select 1 from sysobjects where name = 'maestro_pf' and type = 'P')
   drop proc maestro_pf
go

create proc maestro_pf (
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
@t_trn                  int             = NULL,
@i_param1               varchar(255)    = NULL,
@i_param2               varchar(255)    = NULL)
with encryption
as
declare 
@w_sp_name              descripcion,
@w_return               tinyint,
@w_error                int,
@w_periodo              float,
@w_numdeci              tinyint,
@w_mes	                varchar(10),
@w_dia	                varchar(10),
@w_ano	                varchar(10),
@w_hora	                varchar(10),
@w_min	                varchar(10),
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
@w_comando              varchar(8000),
@w_fecha_ven_aux	    datetime,
@w_Fecha_apertura_aux	datetime,
@w_op_dia_pago          int

/** DEBUG **/
select @w_sp_name = 'maestro_pf'


declare	@w_fecha_fin           datetime,
	@w_fecha_ini            datetime,
	@w_numbanco		varchar(1000),
	@w_detalle		char(1),
	@w_fecha		datetime,
	@w_Transaccion		descripcion,
	@w_Fecha_apertura	descripcion,
	@w_Dias_reales		descripcion,
	@w_Plazo		int

select	@w_fecha_ini = @i_param1,
	@w_fecha_fin = @i_param2


if @i_param1 = @i_param2
	select   @w_fecha_fin    = fc_fecha_cierre,
	         @w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
	from  cobis..ba_fecha_cierre
	where fc_producto = 14


select 	@w_fecha = isnull(fp_fecha,getdate())
from	cobis..ba_fecha_proceso

select	@w_mes 	= convert(varchar,datepart(mm,@w_fecha)),
	@w_dia 	= convert(varchar,datepart(dd,@w_fecha)),
	@w_ano 	= convert(varchar,datepart(yy,@w_fecha)),
	@w_hora	= convert(varchar,datepart(hh,getdate())),
	@w_min	= convert(varchar,datepart(mi,getdate()))



	-- BORRO TABLAS
	truncate table pf_maestro_aux
	truncate table pf_maestro


	-- 'CAPTACIONES y CANCELACIONES del ' + cast(@w_fecha_ini as varchar) + ' al ' + cast(@w_fecha_fin as varchar)
	
	insert into pf_maestro_aux
	select 	@w_fecha,
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_regional) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_zona) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select case op_estado when 'ACT' then 'VIGENTE-ACT' when 'VEN' then 'VIGENTE-VEN' when 'CAN' then 'CANCELACION' else '' end),
		op_num_banco,
		case when en_nomlar is null then en_nombre  + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end,
		(select (case when en_subtipo  = 'P' then 'PERSONA' else 'COMPANIA' end) from cobis..cl_ente where en_ente = op_ente),	
		en_tipo_ced,
		en_ced_ruc,
		op_monto_pg_int,
		case when op_tasa_variable = 'N' then 'TASA FIJA' else 'TASA VARIABLE' end,
		op_mnemonico_tasa,
		isnull((select pp_descripcion from cob_pfijo..pf_ppago where pp_codigo = op_ppago), 'VENCIMIENTO'),
		isnull(op_operador,'0') + convert(varchar,isnull(op_spread,0)),
		op_base_calculo,
		op_fecha_valor,
		round(op_tasa_efectiva,4),
		op_fecha_ven,
		(select convert(varchar, valor) from cobis..cl_tabla T, cobis..cl_catalogo C where T.codigo = C.tabla and T.tabla like 'pf_estado' and C.codigo = P.op_estado),
		convert(varchar,(select td_descripcion from pf_tipo_deposito where td_mnemonico  = op_toperacion)),
		op_total_int_ganados,
		op_total_int_pagados,
		op_oficina,
		(select of_nombre from cobis..cl_oficina where of_oficina = op_oficina),
		isnull(	(select tr_ofi_usu from cob_pfijo..pf_transaccion where tr_operacion = P.op_operacion  and tr_estado <> 'RV' and tr_tipo_trn in ('APE') and tr_tran = 14901 and tr_secuencial = 1), op_oficina),
		op_ente,
		op_dias_reales,
		round(op_tasa,4),
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) > 0 then op_fecha_ingreso else  op_fecha_valor  end,
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) < 0 then 'S' else  'N' end,
		op_fecha_ingreso,
		op_fecha_cancela,
		op_num_dias,
		op_num_prorroga,
		op_renovaciones,
		op_retenido,
		isnull(op_bloqueo_legal,'N'),
		op_fpago,
		op_int_ganado,
		op_int_pagados,
		op_int_estimado,
		op_total_int_estimado,
		op_captador,
		(select case c_tipo_compania when 'OF' then 'O' else 'P' end from cobis..cl_ente where en_ente = P.op_ente),
		isnull(op_desmaterializa,'N'),
		op_isin,
		(select case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end from cobis..cl_ente where  en_ente = P.op_ente),
		op_dia_pago,
		isnull(op_operador,'0') + convert(varchar,isnull(op_puntos,0)),
  		op_tasa_mer 
	from 	cob_pfijo..pf_operacion P,
		cobis..cl_ente
	where 	op_ente = en_ente
	and	((op_estado in ('ACT', 'VEN') ) 
	or 	(op_estado = 'CAN' and op_fecha_cancela between @w_fecha_ini and @w_fecha_fin))
	order by op_oficina, op_estado, op_fecha_ingreso, op_toperacion


	-- 'Operaciones PRORROGADAS AUTOMATICAMENTE  del ' + cast(@w_fecha_ini as varchar) + ' al ' + cast(@w_fecha_fin as varchar)
	
print 'w_fecha_ini ' + cast(@w_fecha_ini as varchar)
print 'w_fecha_fin ' + cast(@w_fecha_fin as varchar)
	
	insert into pf_maestro_aux
	select 	@w_fecha,
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_regional) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_zona) from cobis..cl_oficina O where of_oficina = op_oficina),
		'PRORROGA',
		op_num_banco,
		case when en_nomlar is null then en_nombre  + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end,
		(select (case when en_subtipo  = 'P' then 'PERSONA' else 'COMPANIA' end) from cobis..cl_ente where en_ente = op_ente),	
		en_tipo_ced,
		en_ced_ruc,
		pa_monto_renovar,
		case when op_tasa_variable = 'N' then 'TASA FIJA' else 'TASA VARIABLE' end,
		op_mnemonico_tasa,
		isnull((select pp_descripcion from cob_pfijo..pf_ppago where pp_codigo = op_ppago), 'VENCIMIENTO'),
		isnull(op_operador,'0') + convert(varchar,isnull(op_spread,0)),
		op_base_calculo,
		pa_fecha_valor,
		round(op_tasa_efectiva,4),
		case when P.op_dias_reales = 'S' then dateadd(dd,isnull(pa_plazo,0),pa_fecha_valor) else null end,
		(select convert(varchar, valor) from cobis..cl_tabla T, cobis..cl_catalogo C where T.codigo = C.tabla and T.tabla like 'pf_estado' and C.codigo = P.op_estado),
		convert(varchar,(select td_descripcion from pf_tipo_deposito where td_mnemonico  = op_toperacion)),
		pa_tot_int,
		pa_total_int_pagados,
		pa_oficina,
		(select of_nombre from cobis..cl_oficina where of_oficina = pa_oficina),
		isnull(	(select tr_ofi_usu from cob_pfijo..pf_transaccion where tr_operacion = P.op_operacion  and tr_estado <> 'RV' and tr_tipo_trn in ('APE') and tr_tran = 14901 and tr_secuencial = 1), op_oficina),
		op_ente,
		op_dias_reales,
		round(pa_tasa,4),
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) > 0 then op_fecha_ingreso else  op_fecha_valor  end,
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) < 0 then 'S' else  'N' end,
		op_fecha_ingreso,
		op_fecha_cancela,
		pa_plazo,
		op_num_prorroga,
		op_renovaciones,
		op_retenido,
		isnull(op_bloqueo_legal,'N'),
		op_fpago,
		op_int_ganado,
		op_int_pagados,
		op_int_estimado,
		op_total_int_estimado,
		op_captador,
		(select case c_tipo_compania when 'OF' then 'O' else 'P' end from cobis..cl_ente where en_ente = P.op_ente),
		isnull(op_desmaterializa,'N'),
		op_isin,
		(select case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end from cobis..cl_ente where  en_ente = P.op_ente),
		op_dia_pago,
		isnull(op_operador,'0') + convert(varchar,isnull(op_puntos,0)),
  		op_tasa_mer 
	from	pf_prorroga_aut,
		pf_operacion P,
		cobis..cl_ente
	where	op_operacion 	= pa_operacion
	and	op_ente 	= en_ente
	and	pa_fecha_valor	between @w_fecha_ini and @w_fecha_fin
	and	pa_estado	= 'A'
	

	-- 'Operaciones RENOVADAS del ' + cast(@w_fecha_ini as varchar) + ' al ' + cast(@w_fecha_fin as varchar)
	
	insert into pf_maestro_aux
	select 	@w_fecha,
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_regional) from cobis..cl_oficina O where of_oficina = op_oficina),
		(select (select of_nombre from cobis..cl_oficina where of_oficina = O.of_zona) from cobis..cl_oficina O where of_oficina = op_oficina),
		'RENOVACION',
		op_num_banco,
		case when en_nomlar is null then en_nombre  + ' ' + p_p_apellido + ' ' + p_s_apellido else en_nomlar end,
		(select (case when en_subtipo  = 'P' then 'PERSONA' else 'COMPANIA' end) from cobis..cl_ente where en_ente = op_ente),	
		en_tipo_ced,
		en_ced_ruc,
		re_monto + re_incremento, --op_monto_pg_int,
		case when op_tasa_variable = 'N' then 'TASA FIJA' else 'TASA VARIABLE' end,
		op_mnemonico_tasa,
		isnull((select pp_descripcion from cob_pfijo..pf_ppago where pp_codigo = op_ppago), 'VENCIMIENTO'),
		isnull(op_operador,'0') + convert(varchar,isnull(op_spread,0)),
		op_base_calculo,
		re_fecha_valor,
		round((select or_tasa_efectiva from pf_operacion_renov where or_operacion = R.re_operacion  and or_renovaciones  = R.re_renovacion + 1),4),
		case when P.op_dias_reales = 'S' then dateadd(dd,isnull(re_plazo,0),re_fecha_valor) else null end,
		(select convert(varchar, valor) from cobis..cl_tabla T, cobis..cl_catalogo C where T.codigo = C.tabla and T.tabla like 'pf_estado' and C.codigo = P.op_estado),
		convert(varchar,(select td_descripcion from pf_tipo_deposito where td_mnemonico  = op_toperacion)),
		(select or_total_int_ganados from pf_operacion_renov where or_operacion = R.re_operacion  and or_renovaciones = R.re_renovacion + 1),
		(select or_total_int_pagados from pf_operacion_renov where or_operacion = R.re_operacion  and or_renovaciones = R.re_renovacion + 1),
		(select or_oficina from pf_operacion_renov where or_operacion = R.re_operacion  and or_renovaciones = R.re_renovacion + 1),
		(select of_nombre from cobis..cl_oficina where of_oficina = op_oficina),
		isnull(	(select tr_ofi_usu from cob_pfijo..pf_transaccion where tr_operacion = P.op_operacion  and tr_estado <> 'RV' and tr_tipo_trn in ('APE') and tr_tran = 14901 and tr_secuencial = 1), op_oficina),
		op_ente,
		op_dias_reales,
		round(re_tasa,4),
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) > 0 then op_fecha_ingreso else  op_fecha_valor  end,
		case when datediff(dd,op_fecha_valor, op_fecha_ingreso) < 0 then 'S' else  'N' end,
		op_fecha_ingreso,
		op_fecha_cancela,
		re_plazo,
 		op_num_prorroga,
		op_renovaciones,
		op_retenido,
		isnull(op_bloqueo_legal,'N'),
		op_fpago,
		op_int_ganado,
		op_int_pagados,
		op_int_estimado,
		op_total_int_estimado,
		op_captador,
		(select case c_tipo_compania when 'OF' then 'O' else 'P' end from cobis..cl_ente where en_ente = P.op_ente),
		isnull(op_desmaterializa,'N'),
		op_isin,
		(select case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end from cobis..cl_ente where  en_ente = P.op_ente),
		re_dia_pago,
		isnull(op_operador,'0') + convert(varchar,isnull(op_puntos,0)),
  		op_tasa_mer 
	from 	pf_renovacion R, 
		pf_operacion P,
		cobis..cl_ente
	where  	op_operacion 	= re_operacion
	and	op_ente 	= en_ente
	and	re_fecha_valor 	between  @w_fecha_ini  and @w_fecha_fin
	and	re_estado 	= 'A'


	insert into pf_maestro
		(Fecha_Reporte,      Territorial,     Zona,              Transaccion,       Num_Deposito,          Titular,
		Tipo_Cliente,        Tipo_id,         Num_Id,            Valor_Nominal,     Tipo_Tasa,             Nemonico_tasa, 
		Periodo_pago,        Spread,          Base_calculo,      Fecha_apertura,    Tasa_efectiva,         Fecha_vencimiento, 
		Estado,              Tipo_Producto,   Total_int_ganados, Total_int_pagados, Cod_oficina_captadora, Desc_oficina, 
		Oficina_Recaudadora, Codigo_cliente,  Dias_reales,       Tasa,              Fecha_cont_ing,        Fecha_valor, 
		Fecha_ingreso,       Fecha_cancela,   Plazo,             Num_prorroga,      Num_renovaciones,      Bloqueado, 
		Bloqueo_legal,       Forma_pago,      Int_ganado,        Int_pagados,       Int_estimado,          Total_int_estimado, 
		Captador,            Tipo_compania,   Desmaterializado,  Isin,              Tipo_Compania,         mp_dia_pago, 
		mp_puntos,           mp_tasa_mer)
	select	
		convert(varchar,mp_fecha,103), mp_territorial, mp_zona, mp_tran, mp_num_banco, mp_titular,
		mp_tipo_ente, mp_tipo_id,mp_ced_ruc,mp_monto,mp_desc_tipo_tasa,mp_mnemonico_tasa,
		mp_periodo_pago,mp_spread,mp_base_calculo,convert(varchar,mp_fecha_valor,103),convert(varchar,round(mp_tasa_efectiva,4)),convert(varchar,mp_fecha_ven,103),
		mp_estado, mp_toperacion, mp_total_int_ganados, mp_total_int_pagados, mp_oficina, mp_desc_oficina,
		mp_oficina_cap, mp_ente, mp_dias_reales, convert(varchar,round(mp_tasa,4)), convert(varchar,mp_fecha_cont_ing,103), mp_es_fecha_valor	, 
		convert(varchar,mp_fecha_ingreso,103), convert(varchar,mp_fecha_cancela,103), mp_num_dias, mp_num_prorroga, mp_renovaciones, mp_retenido,
		mp_bloqueo_legal, mp_fpago, mp_int_ganado, mp_int_pagados, mp_int_estimado, mp_total_int_estimado,
		mp_captador, mp_tipo_cia, mp_desmaterializado, mp_isin, mp_tipo_compania, mp_dia_pago,
		mp_puntos, mp_tasa_mer
	from	pf_maestro_aux
	order by mp_territorial, mp_zona ,mp_num_banco, mp_fecha_valor


/* actualilzo fecha ven segun  sea el caso */
declare cursor_operacion cursor
for 	select 	Transaccion, 
		Fecha_apertura, 
		Dias_reales, 
		Plazo,
		mp_dia_pago
	from	pf_maestro, pf_operacion
	where	Num_Deposito = op_num_banco
	and     Transaccion in ('RENOVACION','PRORROGA')
	and	Fecha_vencimiento is NULL
	and	Dias_reales <> 'S'		
for update

open cursor_operacion
fetch cursor_operacion into  	@w_Transaccion,
				@w_Fecha_apertura,
				@w_Dias_reales,
				@w_Plazo,
				@w_op_dia_pago
while @@fetch_status = 0
begin

	select @w_dia= substring(@w_Fecha_apertura,1,2 )
	select @w_mes = substring(@w_Fecha_apertura,4,2 )
	select @w_ano  = substring(@w_Fecha_apertura,7,4 )

print'w_dia' + cast(@w_dia as varchar)
print'w_mes' + cast(@w_mes as varchar)
print'w_ano' + cast(@w_ano as varchar)

	select @w_Fecha_apertura =   @w_mes + '/' + @w_dia + '/'  + @w_ano 

   	select @w_Fecha_apertura_aux = convert(datetime,@w_Fecha_apertura)
print'w_Fecha_apertura_aux' + cast(@w_Fecha_apertura_aux as varchar)

	exec sp_funcion_1 @i_operacion = 'SUMDIA',
        @i_fechai   = @w_Fecha_apertura_aux,
        @i_dias     = @w_Plazo,
        @i_dia_pago  = @w_op_dia_pago, 
        @i_batch  = 0,
        @o_fecha    = @w_fecha_ven_aux out

print'w_fecha_ven_aux' + cast(@w_fecha_ven_aux as varchar)


	update 	pf_maestro 
	set 	Fecha_vencimiento = convert(varchar,@w_fecha_ven_aux,103)
	where current of cursor_operacion

	fetch cursor_operacion into  	@w_Transaccion,
				@w_Fecha_apertura,
				@w_Dias_reales,
				@w_Plazo,
				@w_op_dia_pago

end 

if @@fetch_status =  -2
begin
   close cursor_operacion
   deallocate  cursor_operacion
   raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
   return 0
end

close cursor_operacion
deallocate  cursor_operacion

--Adici¾n de Informaci¾n de Traslados REQ 432

	--se obtiene la solicitud mas reciente de Traslados exceptuando los de estado I
	select 	max(td_solicitud) as Maxima, 
			td_operacion      as TROperacion
			into #TrasladoReciente
	from cobis..cl_traslado_detalle, cobis..cl_traslado
	where tr_estado <> 'I'
	and   td_producto = 14
	and   td_solicitud  = tr_solicitud
	group by td_operacion

	select * into #temp from #TrasladoReciente

	-- se obtienen el numero de traslados Procesados y se unen los traslados no efectivos que si van en el reporte
	select 	COUNT(1)     as Cantidad, 
			td_operacion as CTOperacion  
			into #CantidadTraslados
	from cobis..cl_traslado_detalle, cobis..cl_traslado
	where tr_estado not in ('I')
	and   td_producto = 14
	and   td_solicitud  = tr_solicitud
	group by td_operacion

	select  Cantidad as Cantidad_Traslados,
			td_ofi_orig      as Oficina_Origen,
			td_ofi_dest      as Oficina_Destino,
			(select c.valor
				from cobis..cl_tabla t, cobis..cl_catalogo c
				where t.codigo = c.tabla
				and t.tabla = 'cl_tipo_traslado'
				and c.codigo = tr_tipo_traslado) as Tipo_Traslado,
			(select c.valor
				from cobis..cl_tabla t, cobis..cl_catalogo c
				where t.codigo = c.tabla
				and t.tabla = 'pf_estado'
				and c.codigo = td_estado_ope )    as Estado_Operacion,
			td_monto         as Monto_Operacion,
			tr_usr_ingresa   as Usuario_solicitud,
			tr_ofi_solicitud as Oficina_Solicitud,
			tr_fecha_sol     as Fecha_Solicitud,
			(select c.valor
				from cobis..cl_tabla t, cobis..cl_catalogo c
				where t.codigo = c.tabla
				and t.tabla = 'cl_estado_traslado'
				and c.codigo = tr_estado) as Estado_Traslado,
			tr_usr_autoriza  as Usuario_Autorizador,
			tr_ofi_autoriza  as Oficina_Autorizacion,
			tr_fecha_auto    as Fecha_Autorizacion,
			(select c.valor
				from cobis..cl_tabla t, cobis..cl_catalogo c
				where t.codigo = c.tabla
				and t.tabla = 'cl_rechazo_traslado'
				and c.codigo = tr_causa_rechazo) as Causal_Rechazo,
			td_operacion     as Operacion

			into #InfoTraslado

	from cobis..cl_traslado, 
		 cobis..cl_traslado_detalle, 
		 #temp, 
		 #CantidadTraslados  

	where     td_solicitud  = tr_solicitud
		and   td_producto   = 14
		and   td_solicitud  = Maxima
		and   td_operacion  = CTOperacion
		and   td_operacion  = TROperacion
	
	update pf_maestro
		set 
		Cantidad_Traslados   = a.Cantidad_Traslados, 
		Oficina_Origen       = a.Oficina_Origen,
		Oficina_Destino      = a.Oficina_Destino,
		Tipo_Traslado        = a.Tipo_Traslado,
		Estado_Ope_Traslado  = a.Estado_Operacion,
		Monto_Ope_Traslado   = a.Monto_Operacion,
		Usuario_Solicitud    = a.Usuario_solicitud,
		Oficina_Solicitud    = a.Oficina_Solicitud,
		Fecha_Solicitud      = a.Fecha_Solicitud,
		Usuario_Autorizador  = a.Usuario_Autorizador,
		Oficina_Autorizacion = a.Oficina_Autorizacion,
		Fecha_Autorizacion   = a.Fecha_Autorizacion,
		Causal_Rechazo       = a.Causal_Rechazo,
		Estado_Traslado      = a.Estado_Traslado
	from #InfoTraslado a, cob_pfijo..pf_maestro
	where a.Operacion = Num_Deposito	
	
--FIN Adici¾n de Informaci¾n de Traslados REQ 432


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

select	@w_archivo_bcp 	= @w_path  + 'Contenido', --@w_sp_name + @w_mes + @w_dia + @w_ano + '_' + @w_hora + @w_min,
	@w_errores     	= @w_path  + 'error_' + @w_sp_name + '_' + @w_mes + @w_dia + @w_ano + '_' + @w_hora + @w_min,
	@w_cmd         	= @w_s_app + ' bcp -auto -login cob_pfijo..pf_maestro out '
select	@w_comando 	= @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini ' + '-t;' 
print 'w_comando ' + cast (@w_comando as varchar)
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
	select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo+ ' '+ convert(varchar, @w_error)
	goto ERROR
end

-- Genero archivo con datos de cabecera segun campos de tabla pf_maestro

select 	@w_tabla = 'cob_pfijo..pf_maestro'
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


GO

