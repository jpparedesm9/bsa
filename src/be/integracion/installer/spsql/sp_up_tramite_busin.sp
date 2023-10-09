/************************************************************************/
/*   Archivo:                sp_up_tramite_busin.sp                     */
/*   Stored procedure:       sp_up_tramite_busin                        */
/*   Base de datos:          cob_pac                                    */
/*   Producto:               Credito                                    */
/*   Disenado por:           Adriana Chiluisa                           */
/*   Fecha de escritura:     08/Jun./2017                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Consulta de los datos de un tramite busin                          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA               AUTOR               CAMBIO                     */
/*   JUN-08-2017        Adriana Chiluisa   Version tomada del ambiente  */
/*                                         de pruebas Santander         */
/************************************************************************/
use cob_pac
go

if exists (select 1 from sysobjects where name = 'sp_up_tramite_busin')
   drop proc sp_up_tramite_busin
go

create proc sp_up_tramite_busin (
   @s_ssn		 int = null,
   @s_user		 login = null,
   @s_sesn		 int = null,
   @s_term		 varchar(30) = null,
   @s_date		 datetime = null,
   @s_srv		 varchar(30) = null,
   @s_lsrv		 varchar(30) = null,
   @s_rol		 smallint =  NULL,
   @s_ofi		 smallint = NULL,
   @s_org_err		 char(1) = NULL,
   @s_error		 int = NULL,
   @s_sev		 tinyint = NULL,
   @s_msg		 descripcion = NULL,
   @s_org		 char(1) = NULL,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,   
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion		 char(1) = null,
   @i_tramite            int  = null,
   /* nuevo registro */
   @i_tipo		 char(1) = null,
   @i_truta		 tinyint = null,
   @i_oficina_tr	 smallint = null,
   @i_usuario_tr	 login = null,
   @i_fecha_crea 	 datetime = null,
   @i_oficial		 smallint = null,
   @i_sector		 catalogo = null,
   @i_ciudad		 smallint = null,
   @i_parroquia 	 catalogo = null,   --ITO: 13/12/2011
   @i_estado		 char(1) = null,
   @i_nivel_ap		 tinyint = null,
   @i_fecha_apr		 datetime = null,
   @i_usuario_apr	 login = null,
   @i_numero_op_banco    cuenta  = null,
   @i_proposito		 catalogo = null, 
   @i_razon		 catalogo = null,
   @i_txt_razon		 varchar(255) = null,
   @i_efecto	  	 catalogo = null,
   @i_cliente            int = null,
   @i_grupo              int = null,
   @i_fecha_inicio       datetime = null,
   @i_num_dias           smallint = 0,
   @i_per_revision       catalogo = null,
   @i_condicion_especial varchar(255) = null,
   @i_rotativa		 char(1) = null,
   @i_linea_credito	 cuenta = null,	  
   @i_toperacion	 catalogo = null,
   @i_producto           catalogo = null,
   @i_monto              money = 0,
   @i_moneda             tinyint = 0,  
   @i_periodo            catalogo = null,
   @i_num_periodos       smallint = 0,
   @i_destino            catalogo = null,
   @i_ciudad_destino     smallint = null,
   @i_cuenta_corriente   cuenta = null,
   @i_garantia_limpia    char(1) = null,
   @i_monto_desembolso	 money = null,
   @i_reajustable        char(1) = null,
   @i_per_reajuste       tinyint = null,   
   @i_reajuste_especial	 char(1) = null,
   @i_fecha_reajuste	 datetime = null,
   @i_cuota_completa     char(1) = null,
   @i_tipo_cobro	 char(1) = null,
   @i_tipo_reduccion     char(1) = null,
   @i_aceptar_anticipos  char(1) = null,
   @i_precancelacion     char(1) = null,  
   @i_tipo_aplicacion    char(1) = null,
   @i_renovable		 char(1) = null,   
   @i_fpago		 catalogo = null,
   @i_cuenta		 cuenta = null,
   @i_renovacion	 smallint = null,
   @i_cliente_cca	 int = null,
   @i_op_renovada	 cuenta = null,   
   @i_deudor		 int = null,
   @i_cuenta_certificado cuenta = null,
   @i_alicuota           catalogo = null,
   @i_alicuota_aho	 catalogo = null, 
   @i_doble_alicuota	 char(1) = null,  --DMO Personalizacion Coop.
   
   -- Etapa Rechazo CPN
	
	@i_tipo_cartera    catalogo    = null,   
	@i_destino_descripcion descripcion   =null,   
	@i_patrimonio         money=null,         --JMA, 02-Marzo-2015
	@i_ventas               money=null,         --JMA, 02-Marzo-2015
	@i_num_personal_ocupado    int=null,      --JMA, 02-Marzo-2015
	@i_tipo_credito catalogo =  null,
	@i_indice_tamano_actividad float=null,    --JMA, 02-Marzo-2015
	@i_objeto catalogo = null,                --JMA, 02-Marzo-2015
	@i_actividad catalogo = null,             --JMA, 02-Marzo-2015
	@i_descripcion_oficial descripcion= null, --JMA, 02-Marzo-2015 
	@i_ventas_anuales         money         = null,    --NMA, 10-Abril-2015
	@i_activos_productivos money         = null,     --NMA, 10-Abril-2015   
	@i_level_indebtedness    char(1)  =null,   --DCA
	@i_asigna_fecha_cic      char(1)  =null,
	@i_convenio                 char(1)      = null,
	@i_codigo_cliente_empresa  varchar(10)          = null,
	@i_reprogramingObserv  varchar(255)          = null,
	@i_motivo_uno  varchar(255)          = null, 
	@i_motivo_dos  varchar(255)          = null, 
	@i_motivo_rechazo    catalogo      =null,
	@i_tamanio_empresa      varchar(5)   = null,
	@i_producto_fie         catalogo     = null,
	@i_num_viviendas        tinyint      = null,
	@i_calificacion         catalogo     = null,
	@i_es_garantia_destino  char(1)      = null,
   
   
   -- reestructuracion
   @i_op_reestructurar	 cuenta = null,
   @i_actividad_destino  catalogo = null, --SPO Campo actividad destino de la op.
   @i_compania           int =null,       --SPO Compania del cliente
   @i_tipo_cca           catalogo = null,   --SPO Clase de cartera del credito
   @i_verificador        catalogo = null,
   @i_seg_cre            catalogo = null, --SRA SEGMENTO TRAMITE 17/09/2007
   /* registro anterior */
   @i_w_tipo		 char(1) = null,
   @i_w_truta		 tinyint = null,
   @i_w_oficina_tr	 smallint = null,
   @i_w_usuario_tr	 login = null,
   @i_w_fecha_crea 	 datetime = null,
   @i_w_oficial		 smallint = null,
   @i_w_sector		 catalogo = null,
   @i_w_ciudad		 smallint = null,
   @i_w_estado		 char(1) = null,
   @i_w_nivel_ap	 tinyint = null,
   @i_w_fecha_apr	 datetime = null,
   @i_w_usuario_apr	 login = null,
   @i_w_numero_op_banco  cuenta  = null,
   @i_w_numero_op	 int = null,
   @i_w_proposito	 catalogo = null, 
   @i_w_razon		 catalogo = null,
   @i_w_txt_razon	 varchar(255) = null,
   @i_w_efecto	  	 catalogo = null,
   @i_w_cliente          int = null,
   @i_w_grupo            int = null,
   @i_w_fecha_inicio     datetime = null,   
   @i_w_num_dias         smallint = 0,
   @i_w_per_revision     catalogo = null,
   @i_w_condicion_especial varchar(255) = null,
   @i_w_linea_credito	 int = null,	  
   @i_w_toperacion	 catalogo = null,
   @i_w_producto         catalogo = null,
   @i_w_monto            money = 0,
   @i_w_moneda           tinyint = 0,  
   @i_w_periodo          catalogo = null,
   @i_w_num_periodos     smallint = 0,
   @i_w_destino          catalogo = null,
   @i_w_ciudad_destino   smallint = null,
   @i_w_cuenta_corriente cuenta = null,
   @i_w_garantia_limpia  char(1) = null,
   @i_w_renovacion	 smallint = null,
   @i_w_doble_alicuota	 char(1) = null,  --DMO Personalizacion Coop.
   @i_w_verificador      catalogo = null,
   @i_vinculado          char(1) = 'N',
   @i_causal_vinculacion catalogo = null,
   @i_w_seg_cre          catalogo = null,
   @i_w_alicuota         catalogo = null,
   @i_w_alicuota_aho     catalogo = null,
   @i_ssn            int = null,  --AC SSN PARA ALMACENAR LOS DEUDORES
   @i_toperacion_ori	 catalogo = null, --Policia Nacional: Se incrementa por tema de interceptor   
   @i_tplazo             catalogo = null,   --Parámetro para crear la operación con el plazo ingresado desde la Originación
   @i_plazo              smallint = null,	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
   @i_activa_TirTea      char(1)  = 'S'    -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
)
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite            int,
   @w_linea_credito	 int ,	/* renovaciones y operaciones */
   @w_numero_linea	 int, 
   @w_numero_operacion	 int,
   @w_numero_op_banco    cuenta,
   /** cambios al registro anterior **/
   @w_cambio		 char(1),	/* existe un cambio */
   @w_cambio_def	 char(1),	/* existe cambio en parametros default */
   @w_default		 char(1),
   /** valores default para operaciones de cartera **/
   @w_dt_reajustable		char(1),
   @w_dt_periodo_reaj		tinyint,
   @w_dt_reajuste_especial	char(1),
   @w_dt_cuota_completa		char(1),
   @w_dt_tipo_cobro		char(1),
   @w_dt_tipo_reduccion		char(1),
   @w_dt_aceptar_anticipos	char(1),
   @w_dt_precancelacion		char(1),
   @w_dt_tipo_aplicacion	char(1),
   @w_dt_renovacion		char(1),
   @w_monto_desembolso		money,
   /* numero de banco e interno para tabla temporal de cartera */
   @w_banco			cuenta,
   @w_operacion			int,
   @w_fecha_fin			varchar(10),
   @w_fecha_ini			varchar(10),
   @w_periodo            	catalogo,
   @w_des_periodo        	descripcion,
   @w_num_periodos       	int,
   @w_val_tasaref        	float,
   @w_nombre_cli_cca	 	varchar(64),		--optimizacion de CCA
   @w_op_reestructurar   	cuenta,			--operacion anterior
   @w_tramite_rest	 	int,			-- tramite de operacion a reestructurar
   @w_cliente_rest	 	int,			-- deudor de operacion a reestructurar
   @w_monto_rest	 	money, 			-- monto inicial de operacion a reestructurar
   @w_moneda_rest	 	tinyint,		-- moneda de operacion a reestructurar
   @w_saldo_rest	 	money, 			-- saldo de operacion a reestructurar
   @w_fecha_liq_rest	 	datetime,		-- fecha de liquidacion de op. a reestructurar 
   @w_toperacion_rest	 	catalogo,		-- tipo de prestamo de operacion a reestructurar
   @w_operacion_rest	 	int,			-- numero secuencial de operacion a reestructurar
   @w_operacion_rest_ant 	int,			-- numero secuencial de operacion a reestructurar anterior
   @w_monto_renov               money,                  -- DMO 29/11/99 por renovaciones
   @w_operacionca               int,
   @w_tea                       float,
   @w_valor_alicuota            float,
   @w_valor_alicuota_aho        float,
   @w_operacion_da              char(1)

select @w_today  = @s_date
select @w_sp_name = 'sp_up_tramite_busin',
       @i_activa_TirTea = isnull(@i_activa_TirTea, 'S')  -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE


/******* Verificaciones Previas **********/
/*****************************************/
/* Chequeo de Linea de Credito */
If @i_linea_credito <> null
begin
	select	@w_numero_linea = li_numero
	from   	cob_credito..cr_linea
	where	li_num_banco = @i_linea_credito
	If @@rowcount = 0
	begin
	/** registro no existe **/
	exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file  = @t_file, 
	    @t_from  = @w_sp_name,
	    @i_num   = 2101010
	    return 1 	
	end
end

/* Chequeo de Numero de operacion */
If @i_numero_op_banco <> null
begin
	If @i_producto = 'CCA'
	begin
		select	@w_numero_operacion = op_operacion
		from   	cob_cartera..ca_operacion
		where	op_banco = @i_numero_op_banco
		If @@rowcount = 0
		begin
		/** operacion referenciada no existe **/
		    exec cobis..sp_cerror
		    @t_debug = @t_debug,
		    @t_file  = @t_file, 
		    @t_from  = @w_sp_name,
		    @i_num   = 2101021
		    return 1 	
		end
	end

	/*If @i_producto = 'CEX'
	begin
		select	@w_numero_operacion = op_operacion
		from   	cob_comext..ce_operacion
		where	op_operacion_banco = @i_numero_op_banco
		If @@rowcount = 0
		begin
		/** operacion referenciada no existe **/
		    exec cobis..sp_cerror
		    @t_debug = @t_debug,
		    @t_file  = @t_file, 
		    @t_from  = @w_sp_name,
		    @i_num   = 2101021
		    return 1 	
		end
	end*/
end

/* optimizacion de cartera */
if @i_producto = 'CCA'
   select @w_nombre_cli_cca = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre)
   from	  cobis..cl_ente
   where  en_ente = @i_cliente_cca


--PRON:23FEB2007 Valida que la actividad sea la reportada por la SUPER
if @i_actividad_destino is not null
begin
   if not exists (select 1 from cobis..cl_act_economica_bce
                  where ae_codigo = @i_actividad_destino 
                  and ae_nivel = 6)
   begin
      /* No es actividad asignada por la SUPER */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file, 
	@t_from  = @w_sp_name,
	@i_num   = 2101073
	return 1 	
   end
end


/** Control de modificaciones una vez que el tramite ya ha sido aprobado **/
/**************************************************************************/
If @i_w_estado = 'A'
begin
	/* inicializacion de variables */
	select @w_cambio = 'N'
	select @w_cambio_def = 'N'
	select @w_default = 'N'

	/* COMPARAR CAMPOS ANTERIORES CON NUEVOS */
	if (@i_sector <> @i_w_sector) and  @i_sector is not null select @w_cambio = 'S'
	if (@i_verificador <> @i_w_verificador) and  @i_verificador is not null  select @w_cambio = 'S'

	/* garantias */
	if (@i_proposito <> @i_w_proposito) and  @i_proposito is not null  select @w_cambio = 'S'
	if (@i_razon <> @i_w_razon) and  @i_razon is not null  select @w_cambio = 'S'
	if (@i_efecto <> @i_w_efecto) and  @i_efecto is not null  select @w_cambio = 'S'

	/* lineas de credito */
	if (@i_cliente <> @i_w_cliente) and  @i_cliente is not null select @w_cambio = 'S'
	if (@i_grupo <> @i_w_grupo) and  @i_grupo is not null select @w_cambio = 'S'
	if (@i_num_dias > @i_w_num_dias) and  @i_num_dias is not null select @w_cambio = 'S'
	if (@i_per_revision <> @i_w_per_revision) and  @i_per_revision is not null select @w_cambio = 'S'
	if (@i_condicion_especial <> @i_w_condicion_especial) and  @i_condicion_especial is not null select @w_cambio = 'S'


	/* originales y renovaciones */
	if @i_w_linea_credito <> null and @i_linea_credito = null select @w_cambio = 'S'
	if (@i_toperacion <> @i_w_toperacion) and  @i_toperacion is not null select @w_cambio = 'S'
	if (@i_producto <> @i_w_producto) and  @i_producto is not null select @w_cambio = 'S'
	if (@i_monto > @i_w_monto) and  @i_monto is not null select @w_cambio = 'S'
	if (@i_moneda <> @i_w_moneda) and  @i_moneda is not null select @w_cambio = 'S'
	if (@i_periodo <> @i_w_periodo) and  @i_periodo is not null select @w_cambio_def = 'S'
	if (@i_num_periodos <> @i_w_num_periodos) and  @i_num_periodos is not null select @w_cambio_def = 'S'
	if (@i_destino <> @i_w_destino) and  @i_destino is not null select @w_cambio = 'S'
	if (@i_garantia_limpia <> @i_w_garantia_limpia) and  @i_garantia_limpia is not null select @w_cambio = 'S'
	if (@i_doble_alicuota <> @i_w_doble_alicuota) and  @i_doble_alicuota is not null select @w_cambio = 'S'
	if (@i_renovacion <> @i_w_renovacion) and  @i_renovacion is not null select @w_cambio = 'S', @w_default = 'N'

	if @i_producto = 'CCA'
	begin
		select @w_default = 'S'

		/* comparar con los valores de cartera */

		/* (1) traer los valores anteriores de cartera */
		select
		@w_dt_reajustable = op_reajustable,	
		@w_dt_periodo_reaj = op_periodo_reajuste,
		@w_dt_reajuste_especial = op_reajuste_especial,
		@w_dt_renovacion = op_renovacion,
		@w_dt_precancelacion = op_precancelacion,
		@w_dt_cuota_completa = op_cuota_completa,
		@w_dt_tipo_cobro = op_tipo_cobro,
		@w_dt_tipo_reduccion = op_tipo_reduccion,
		@w_dt_aceptar_anticipos = op_aceptar_anticipos,
		@w_dt_tipo_aplicacion = op_tipo_aplicacion

		from cob_cartera..ca_operacion
		where op_tramite = @i_tramite


		if @@rowcount > 0
		  if 			
		     @w_dt_reajustable = @i_reajustable and	
		     @w_dt_periodo_reaj = @i_per_reajuste and
		     @w_dt_reajuste_especial = @i_reajuste_especial and
		     @w_dt_renovacion = @i_renovable and
		     @w_dt_precancelacion = @i_precancelacion and
		     @w_dt_cuota_completa = @i_cuota_completa and
		     @w_dt_tipo_cobro = @i_tipo_cobro and
		     @w_dt_tipo_reduccion = @i_tipo_reduccion and
		     @w_dt_aceptar_anticipos = @i_aceptar_anticipos and
		     @w_dt_tipo_aplicacion = @i_tipo_aplicacion 
   		  	select @w_cambio_def = 'N'
		  else
		     	select @w_cambio_def = 'S'

	end
	if @w_cambio_def = 'S'	select @w_cambio = 'S'

	/* si ha existido cambio, entonces cambiar el estado a 'N' (no aprobado) */
	if @w_cambio = 'S'
		select @i_estado = 'N'
	else
		select @i_estado = @i_w_estado

end
else
	select @i_estado = @i_w_estado

if (@i_w_oficina_tr <> @i_oficina_tr) and @i_oficina_tr is not null
   print 'Aviso: La Oficina Original del Tramite fue cambiada. Verificar las oficinas de las garantias relacionadas.'

/*** Actualizacion del Registro ***/
begin tran

	--Se incrementa para policia debido a que no se estaba guadando los deudores
    if  @i_tipo <> 'M' and @i_tipo <> 'C' -- ABE Flujo Moratoria
    begin
		insert cob_credito..cr_deudores
			select @i_tramite,   dt_cliente,   dt_rol,    en_ced_ruc , null , 'N'
			from cob_pac..cr_deudores_tmp, cobis..cl_ente
			where dt_ssn = @i_ssn
			and en_ente = dt_cliente

		if @@error <> 0
		begin
			rollback tran
			return 2103001
		end
        if @i_motivo_rechazo is not null
		  begin
		    if exists(select 1
		                from cob_credito..cr_tr_datos_adicionales
		               where tr_tramite = @i_tramite)
			  select @w_operacion_da = 'U'
		    else
			  select @w_operacion_da = 'I'

			/*  SE ACTUALIZAN LOS DATOS ADICIONALES DEL TRAMITE*/
			exec @w_return = cob_pac..sp_tr_datos_adicionales_busin
						@s_ssn = @s_ssn,
						@s_user = @s_user,
						@s_sesn = @s_sesn,
						@s_term = @s_term,
						@s_date = @s_date,
						@s_srv  = @s_srv,
						@s_lsrv    = @s_lsrv,
						@s_rol  = @s_rol,
						@s_ofi  = @s_ofi,
						@s_org_err = @s_org_err,
						@s_error = @s_error,
						@s_sev = @s_sev,
						@s_msg = @s_msg,
						@s_org = @s_org,
						@t_rty = @t_rty,
						@t_trn = 21118,
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @t_from,
						@t_show_version = 0, -- Mostrar la version del programa
						@i_operacion   =@w_operacion_da,
						@i_tramite     =@i_tramite,
						@i_tipo_cartera  = @i_tipo_cartera,
						@i_destino_descripcion =@i_destino_descripcion,
						@i_patrimonio =@i_patrimonio,
						@i_ventas  = @i_ventas,
						@i_num_personal_ocupado =@i_num_personal_ocupado,
						@i_tipo_credito = @i_tipo_credito,
						@i_indice_tamano_actividad =@i_indice_tamano_actividad,
						@i_objeto  = @i_objeto ,
						@i_actividad  = @i_actividad ,
						@i_descripcion_oficial = @i_descripcion_oficial,
						@i_ventas_anuales = @i_ventas_anuales,        --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales
						@i_activos_productivos = @i_activos_productivos,        --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales

						@i_level_indebtedness=@i_level_indebtedness,--DCA
						@i_asigna_fecha_cic = @i_asigna_fecha_cic,

						@i_convenio                 = @i_convenio    ,
						@i_codigo_cliente_empresa=@i_codigo_cliente_empresa,
						@i_reprogramingObserv=@i_reprogramingObserv, -- MCA - se ingresa observación de la reprogramación
						@i_motivo_uno = @i_motivo_uno,        -- Etapa Rechazo
						@i_motivo_dos = @i_motivo_dos,        -- Etapa Rechazo
						@i_motivo_rechazo = @i_motivo_rechazo, -- Etapa Rechazo
						@i_tamanio_empresa = @i_tamanio_empresa,
						@i_producto_fie    = @i_producto_fie,
						@i_num_viviendas   = @i_num_viviendas,
						@i_calificacion    = @i_calificacion,
						@i_es_garantia_destino = @i_es_garantia_destino

				if @w_return != 0
						return @w_return
				
		  end
	end

	update 	cob_credito..cr_tramite
	set	tr_estado              = isnull(@i_estado,             tr_estado            ),
		tr_oficina             = isnull(@i_oficina_tr,         tr_oficina           ),
		tr_oficial             = isnull(@i_oficial,            tr_oficial           ),
		tr_ciudad              = isnull(@i_ciudad,             tr_ciudad            ),
		tr_numero_op           = isnull(@w_numero_operacion,   tr_numero_op         ),
		tr_numero_op_banco     = isnull(@i_numero_op_banco,    tr_numero_op_banco   ),
		tr_destino             = isnull(@i_destino,            tr_destino           ),
		tr_sector              = isnull(@i_sector,             tr_sector            ),
		tr_proposito           = isnull(@i_proposito,          tr_proposito         ),
		tr_razon               = isnull(@i_razon,              tr_razon             ),
		tr_txt_razon           = isnull(@i_txt_razon,          tr_txt_razon         ),
		tr_efecto              = isnull(@i_efecto,             tr_efecto            ),
		tr_cliente             = isnull(@i_cliente,            tr_cliente           ),
		tr_grupo               = isnull(@i_grupo,              tr_grupo             ),
		tr_fecha_inicio        = isnull(@i_fecha_inicio,       tr_fecha_inicio      ),
		tr_num_dias            = isnull(@i_num_dias,           tr_num_dias          ),
		tr_per_revision        = isnull(@i_per_revision,       tr_per_revision      ),
		tr_condicion_especial  = isnull(@i_condicion_especial, tr_condicion_especial),
		tr_linea_credito       = isnull(@w_numero_linea,       tr_linea_credito     ),
		tr_toperacion          = isnull(@i_toperacion,         tr_toperacion        ),
		tr_producto            = isnull(@i_producto,           tr_producto          ),
		tr_monto               = isnull(@i_monto,              tr_monto             ),
		tr_moneda              = isnull(@i_moneda,             tr_moneda            ),
		tr_periodo             = isnull(@i_periodo,            tr_periodo           ),
		tr_num_periodos        = isnull(@i_num_periodos,       tr_num_periodos      ),
		tr_ciudad_destino      = isnull(@i_ciudad_destino,     tr_ciudad_destino    ),
		tr_cuenta_corriente    = isnull(@i_cuenta_corriente,   tr_cuenta_corriente  ),
		-- JTA tr_garantia_limpia     = isnull(@i_garantia_limpia,    tr_garantia_limpia   ),
		tr_renovacion          = isnull(@i_renovacion,         tr_renovacion        ) -- JTA ,
		-- JTA tr_cuenta_certificado  = isnull(@i_cuenta_certificado, tr_cuenta_certificado),
		-- JTA tr_alicuota            = isnull(@i_alicuota,           tr_alicuota          ),
   		-- JTA tr_alicuota_aho        = isnull(@i_alicuota_aho,       tr_alicuota_aho      ),
		-- JTA tr_doble_alicuota      = isnull(@i_doble_alicuota,     tr_doble_alicuota    ),
		-- JTA tr_actividad_destino   = isnull(@i_actividad_destino,  tr_actividad_destino ),   --SPO
		-- JTA tr_tipo_cca            = isnull(@i_tipo_cca,           tr_tipo_cca          ),   --SPO
		-- JTA tr_verificador         = isnull(@i_verificador,        tr_verificador       ),
		-- JTA tr_seg_cre             = isnull(@i_seg_cre,            tr_seg_cre           )    --SRA SEGMENTO CREDITO 17/09/2007
	where	tr_tramite = @i_tramite


  	select @w_tramite = @i_tramite

	If @@error <> 0
	begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1 

	end
	/* Transaccion de Servicio Registro Anterior */
	insert into cob_credito..ts_tramite
	(secuencial, tipo_transaccion, clase, fecha, usuario, terminal,
	 oficina, tabla, lsrv, srv, tramite, tipo, oficina_tr, usuario_tr,
	 fecha_crea, oficial, sector, ciudad, estado, nivel_ap, fecha_apr,
	 usuario_apr, truta, numero_op, numero_op_banco, proposito, razon,
	 txt_razon, efecto, cliente, grupo, fecha_inicio, num_dias, per_revision,
         condicion_especial, linea_credito, toperacion, producto,
	 monto, moneda, periodo, num_periodos, destino, ciudad_destino,
	 cuenta_corriente, renovacion
     -- JTA cuenta_corriente, garantia_limpia, renovacion, verificador,seg_cre
	)
	values
	(@s_ssn, @t_trn, 'P', @s_date, @s_user, @s_term,
	 @s_ofi, 'cr_tramite', @s_lsrv, @s_srv, @i_tramite, @i_w_tipo, @i_w_oficina_tr, @i_w_usuario_tr, 
	 @i_w_fecha_crea, @i_w_oficial, @i_w_sector, @i_w_ciudad, @i_w_estado, @i_w_nivel_ap, @i_w_fecha_apr,
	 @i_w_usuario_apr, @i_w_truta, @i_w_numero_op, @i_w_numero_op_banco, @i_w_proposito, @i_w_razon,
	 @i_w_txt_razon, @i_w_efecto, @i_w_cliente, @i_w_grupo, @i_w_fecha_inicio, @i_w_num_dias, @i_w_per_revision,
         @i_w_condicion_especial, @i_w_linea_credito, @i_w_toperacion, @i_w_producto,
	 @i_w_monto, @i_w_moneda, @i_w_periodo, @i_w_num_periodos, @i_w_destino, @i_w_ciudad_destino,
	 @i_w_cuenta_corriente, @i_w_renovacion
	 -- JTA@i_w_cuenta_corriente, @i_w_garantia_limpia, @i_w_renovacion, @i_w_verificador,@i_seg_cre 	 
	)
	if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end    

	/* Transaccion de Servicio Registro Actual */
	insert into cob_credito..ts_tramite
	(secuencial, tipo_transaccion, clase, fecha, usuario, terminal,
	 oficina, tabla, lsrv, srv, tramite, tipo, oficina_tr, usuario_tr,
	 fecha_crea, oficial, sector, ciudad, estado, nivel_ap, fecha_apr,
	 usuario_apr, truta, numero_op, numero_op_banco, proposito, razon,
	 txt_razon, efecto, cliente, grupo, fecha_inicio, num_dias, per_revision,
         condicion_especial, linea_credito, toperacion, producto,
	 monto, moneda, periodo, num_periodos, destino, ciudad_destino,
	 cuenta_corriente, renovacion
	 -- JTA cuenta_corriente, garantia_limpia, renovacion, verificador, seg_cre
	)
	values
	(@s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term,
	 @s_ofi, 'cr_tramite', @s_lsrv, @s_srv, @i_tramite, @i_tipo, @i_oficina_tr, @i_w_usuario_tr,
	 @i_w_fecha_crea, @i_oficial, @i_sector, @i_ciudad, @i_estado, @i_nivel_ap, @i_fecha_apr,
	 @i_usuario_apr, @i_w_truta, @w_numero_operacion, @i_numero_op_banco, @i_proposito, @i_razon,
	 @i_txt_razon, @i_efecto, @i_cliente, @i_grupo, @i_fecha_inicio, @i_num_dias, @i_per_revision,
         @i_condicion_especial, @w_numero_linea, @i_toperacion, @i_producto,
	 @i_monto, @i_moneda, @i_periodo, @i_num_periodos, @i_destino, @i_ciudad_destino,
	 @i_cuenta_corriente, @i_renovacion
	 -- JTA @i_cuenta_corriente, @i_garantia_limpia, @i_renovacion, @i_verificador,@i_seg_cre 
	)
	if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
            @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end    


	/* SI EL TRAMITE ES DE LINEA DE CREDITO ==> ACTUALIZAR REGISTRO DE LINEA */
	/********************************************************************/
  /*	If @i_tipo = 'L'
	begin
		exec @w_return = cob_credito..sp_linea
  		  @s_ssn = @s_ssn,
	          @s_user = @s_user,
	    	  @s_sesn = @s_sesn,
        	  @s_term = @s_term,
            	  @s_date = @s_date,
	    	  @s_srv  = @s_srv,
        	  @s_lsrv = @s_lsrv,
	   	  @s_rol  = @s_rol,
	    	  @s_ofi  = @s_ofi,
        	  @s_org_err = @s_org_err,
	   	  @s_error = @s_error,
	    	  @s_sev = @s_sev,
        	  @s_msg = @s_msg,
	   	  @s_org = @s_org,
	    	  @t_debug = @t_debug,
		  @t_file = @t_file,
	   	  @t_from = @t_from  ,	    	  
		  @t_trn = 21126,   
   		  @i_operacion = 'U',
	   	  @i_numero = null,
	    	  @i_num_banco = null,
		  @i_oficina = @i_oficina_tr,
	   	  @i_tramite = @i_tramite,
		  @i_cliente = @i_cliente,
		  @i_grupo   = @i_grupo,
	   	  @i_original = null,
	    	  @i_fecha_aprob = @i_fecha_apr,
		  @i_fecha_inicio = @i_fecha_inicio,
 		  @i_per_revision = @i_per_revision,
 	  	  @i_fecha_vto = null,
		  @i_dias = @i_num_dias,
	   	  @i_condicion_especial = @i_condicion_especial,
		  @i_monto = @i_monto,
		  @i_moneda = @i_moneda,
		  @i_rotativa = @i_rotativa

		if @w_return != 0
		  return @w_return
	end*/
	/* SI EL TRAMITE ES ORIGINAL/RENOVACION Y DE CARTERA */
	/*****************************************************/
	if (@i_tipo = 'O' or @i_tipo = 'R') and (@i_producto = 'CCA')
	begin

		/****mapeo al front end de periodo, tasa , etc  *********/
 		select @w_banco = op_banco,
		       @w_monto_desembolso =op_monto,
		       @w_periodo = td_tdividendo,
		       @w_des_periodo = td_descripcion,
		       @w_num_periodos = op_plazo,
		       @w_val_tasaref = ro_porcentaje
		from   cob_cartera..ca_operacion,
		       cob_cartera..ca_tdividendo,cob_cartera..ca_rubro_op 
		where  op_tramite = @w_tramite
		and    td_tdividendo = op_tplazo
	        and    ro_concepto = 'INT'
		and    ro_operacion = op_operacion	

 		select @w_periodo
		select @w_des_periodo
		select @w_num_periodos
		select @w_val_tasaref 

	   /* llamada al sp que crea los datos en tablas temporales */
           if (@i_tipo = 'R') 
              select @w_monto_renov = @i_monto
           if (@i_tipo = 'O')
              select @w_monto_renov = @i_monto_desembolso

  	   /* valido si ha cambiado el tipo de operacion, la moneda, el monto o el sector*/
	   select @w_cambio = 'N'
--print '0.- @w_cambio: %1!', @w_cambio

           if (@i_toperacion_ori <> @i_w_toperacion) and  @i_toperacion is not null 
	      select @w_cambio = 'S'
--print '1.- @w_cambio: %1!, @i_toperacion_ori: [%2!], @i_w_toperacion: [%3!]', @w_cambio, @i_toperacion_ori, @i_w_toperacion

     	   if (@i_moneda <> @i_w_moneda) and  @i_moneda is not null 
	      select @w_cambio = 'S'
--print '2.- @w_cambio: %1!, @i_moneda: [%2!], @i_w_moneda: [%3!]', @w_cambio, @i_moneda, @i_w_moneda

	   if (@i_monto <> @i_w_monto) and  @i_monto is not null 
	      select @w_cambio = 'S'
--print '3.- @w_cambio: %1!, @i_monto: [%2!], @i_w_monto: [%3!]', @w_cambio, @i_monto, @i_w_monto

  	   if (@i_sector <> @i_w_sector) and  @i_sector is not null 
	      select @w_cambio = 'S'
--print '4.- @w_cambio: %1!, @i_sector: [%2!], @i_w_sector: [%3!]', @w_cambio, @i_sector, @i_w_sector

	 --if @i_monto_desembolso <> @w_monto_desembolso
	 --   select @w_cambio = 'S'

         --PRON:24JUN08 Se reemplaza por las lineas de arriba
           if @w_monto_renov <> @w_monto_desembolso
	      select @w_cambio = 'S'
print '5.- @w_cambio: ['+ @w_cambio +'] @w_monto_renov: ['+ @w_monto_renov +'], @w_monto_desembolso: ['+ @w_monto_desembolso +']'

	   if (@i_doble_alicuota <> @i_w_doble_alicuota) and @i_doble_alicuota is not null
	      select @w_cambio = 'S'
--print '6.- @w_cambio: %1!, @i_doble_alicuota: [%2!],@i_w_doble_alicuota: [%3!]', @w_cambio, @i_doble_alicuota, @i_w_doble_alicuota

           if (@i_seg_cre <> @i_w_seg_cre) and @i_seg_cre is not null  --Si cambia el segmento de credito y se lo está actualizando PRON:19SEP07
              select @w_cambio = 'S'
--print '7.- @w_cambio: %1!, @i_seg_cre: [%2!],@i_w_seg_cre: [%3!]', @w_cambio, @i_seg_cre, @i_w_seg_cre

           if @w_cambio = 'N'
	   begin                 
                   if @i_alicuota is not null 
                   begin
                      select @w_valor_alicuota = vl_valor 
                      from cob_cartera..ca_valor_alicuota
                      where vl_alicuota  = @i_alicuota
                      having vl_fecha_vig = max(vl_fecha_vig)

                      if @w_valor_alicuota is null 
                      begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
       	                 @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 701176
 	                 return 1
                      end
                   end 

                   if @i_alicuota_aho is not null 
                   begin
                      select @w_valor_alicuota_aho = vl_valor 
                      from cob_cartera..ca_valor_alicuota
                      where vl_alicuota  = @i_alicuota_aho
                      having vl_fecha_vig = max(vl_fecha_vig)

                      if @w_valor_alicuota_aho is null 
                     begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
        	         @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 701176
 	                 return 1
                      end
                    end 

			/* actualizo la tabla ca_operacion */
			update cob_cartera..ca_operacion
			set 
		    	op_cliente            = isnull(@i_cliente_cca,        op_cliente            ),
		        op_lin_credito        = isnull(@i_linea_credito,      op_lin_credito        ),
		        op_oficina            = isnull(@i_oficina_tr,         op_oficina            ),
			op_oficial            = isnull(@i_oficial,            op_oficial            ),
			op_destino            = isnull(@i_destino,            op_destino            ),
			op_ciudad             = isnull(@i_ciudad_destino,     op_ciudad             ),
			-- JTA op_parroquia          = isnull(@i_parroquia,          op_parroquia          ),		-- ITO:13/12/2011
			op_monto  = isnull(@w_monto_renov,        op_monto              ),
	   		op_fecha_reajuste     = isnull(@i_fecha_reajuste,     op_fecha_reajuste     ),
	       		op_periodo_reajuste   = isnull(@i_per_reajuste,       op_periodo_reajuste   ),
	       		op_reajuste_especial  = isnull(@i_reajuste_especial,  op_reajuste_especial  ),
	       		op_forma_pago         = isnull(@i_fpago,              op_forma_pago         ),
	       		op_cuenta             = isnull(@i_cuenta,             op_cuenta             ),
	       		op_cuota_completa     = isnull(@i_cuota_completa,     op_cuota_completa     ),
	       		op_tipo_cobro         = isnull(@i_tipo_cobro,         op_tipo_cobro         ),
	       		op_tipo_reduccion     = isnull(@i_tipo_reduccion,     op_tipo_reduccion     ),
	       		op_aceptar_anticipos  = isnull(@i_aceptar_anticipos,  op_aceptar_anticipos  ),
	       		op_precancelacion     = isnull(@i_precancelacion,     op_precancelacion     ),
	       		op_tipo_aplicacion    = isnull(@i_tipo_aplicacion,    op_tipo_aplicacion    ),
	       		op_renovacion	      = isnull(@i_renovable,          op_renovacion	    ),
	       		op_reajustable        = isnull(@i_reajustable,        op_reajustable        ),
	       		op_num_renovacion     = isnull(@i_renovacion,         op_num_renovacion     ),
			op_nombre             = isnull(@w_nombre_cli_cca,     op_nombre             ),
			op_anterior           = isnull(@i_op_renovada,        op_anterior           ),
			-- JTA op_actividad_destino  = isnull(@i_actividad_destino,  op_actividad_destino  ),		--SPO
            -- JTA op_compania           = isnull(@i_compania,           op_compania           ),		--SPO 
            -- JTA op_tipo_cca           = isnull(@i_tipo_cca,           op_tipo_cca           ),		--SPO
            -- JTA op_vinculado          = isnull(@i_vinculado,          op_vinculado          ),
            -- JTA op_rubro              = isnull(@i_causal_vinculacion, op_rubro              ),
            -- JTA op_seg_cre            = isnull(@i_seg_cre,            op_seg_cre            ),
            -- JTA op_alicuota           = isnull(@i_alicuota,           op_alicuota           ),
            -- JTA op_alicuota_aho       = isnull(@i_alicuota_aho,       op_alicuota_aho       ),
            -- JTA op_valor_alicuota     = isnull(@w_valor_alicuota,     op_valor_alicuota     ),
            -- JTA op_valor_alicuota_aho = isnull(@w_valor_alicuota_aho, op_valor_alicuota_aho ),
                        op_plazo              = isnull(@i_plazo,              op_plazo              ),
                        op_tplazo             = isnull(@i_tplazo,             op_tplazo             )
			where op_tramite      = @i_tramite

			if @@error <> 0
			begin
           		   /* Error en insercion  de registro */
             		   exec cobis..sp_cerror
             		   @t_debug = @t_debug,
             		   @t_file  = @t_file, 
             		   @t_from  = @w_sp_name,
             		   @i_num   = 2103001,
			   @i_msg	 = '[sp_up_tramite_busin] ERROR EN ACTUALIZACION DE FORMA DE PAGO EN TABLA DE CCA'   
              		   return 1 
			end

                        --PRON:23OCT2007 Llama a programa que determina el TEA, para validar que la tasa no se pase de la maxima
	        	if (@i_w_alicuota <> @i_alicuota) or (@i_w_alicuota_aho <> @i_alicuota_aho)
                        begin 

                           select @w_operacionca = op_operacion
                           from   cob_cartera..ca_operacion
                           where  op_tramite = @i_tramite


                        /*   exec @w_return = cob_pac..sp_TIR_TEA_busin
                             @s_user            = @s_user,
                             @s_sesn            = @s_sesn,
                             @i_operacionca     = @w_operacionca,
                             @i_fecha           = @i_fecha_inicio,
                             @i_calcula_TEA     = 'S',
                             @i_valida_maxima   = 'S',
  @i_temporal        = 'N',
                          @i_activa_TirTea   = @i_activa_TirTea,       -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
                             @o_tea             = @w_tea out

                           if @w_return != 0
                           begin
                              -- Error en insercion de registro 
                             exec cobis..sp_cerror
                             @t_debug = @t_debug,
        	             @t_file  = @t_file, 
                             @t_from  = @w_sp_name,
                             @i_num   = @w_return
 	                     return 1
                           */
                       end

  	   end /*w_cambio = 'N' */
	   else
	   begin   

		      if @i_numero_op_banco is not null
		      begin
			/*Cambios en Operacion Instrumentada */
             		exec cobis..sp_cerror
             		@t_debug = @t_debug,
              		@t_file  = @t_file, 
             		@t_from  = @w_sp_name,
             		@i_num   = 2105010
			return 1
		      end

			/*DMO si hay secuencia de aprobacion elimino*/
			delete cob_credito..cr_secuencia
			where se_tramite = @i_tramite			


	 	        /* Crear nuevamente las estructuras default de cartera */
			/* obtener el numero de operacion */
			select @w_operacion = op_operacion
			from cob_cartera..ca_operacion
			where op_banco = @w_banco 

			/* borrar las tablas de cartera */
			delete cob_cartera..ca_operacion 
			       where op_banco = @w_banco
			delete cob_cartera..ca_amortizacion 
			       where am_operacion = @w_operacion
			delete cob_cartera..ca_cuota_adicional 
			       where ca_operacion = @w_operacion
			delete cob_cartera..ca_dividendo 
			       where di_operacion = @w_operacion
			delete cob_cartera..ca_rubro_op 
			       where ro_operacion = @w_operacion
			delete cob_cartera..ca_tasas 
			       where ts_operacion = @w_operacion
			delete cob_cartera..ca_reajuste
		       where re_operacion = @w_operacion
			delete cob_cartera..ca_reajuste_det
			       where red_operacion = @w_operacion

			delete cob_cartera..ca_operacion_tmp
			       where opt_banco = @w_banco
			delete cob_cartera..ca_dividendo_tmp
			       where dit_operacion = @w_operacion
			delete cob_cartera..ca_amortizacion_tmp
			       where amt_operacion = @w_operacion
			delete cob_cartera..ca_cuota_adicional_tmp
			       where cat_operacion = @w_operacion
			delete cob_cartera..ca_rubro_op_tmp
			       where rot_operacion = @w_operacion


			/*** VOLVER A CREAR LAS ESTRUCTURAS TEMPORALES INICIALES */
	   		exec @w_return = cob_pac..sp_crear_operacion_busin
   	   		@s_user = @s_user,
	   		@s_sesn = @s_sesn,
	   		@s_ofi  = @s_ofi,
	   		@s_date = @s_date,
	   		@s_term = @s_term,
	   		@i_anterior = @i_op_renovada,
			@i_num_renovacion = @i_renovacion,
	   		@i_migrada = null,
	   		@i_tramite = @i_tramite,
	   		@i_cliente = @i_cliente_cca,
	   		@i_nombre = @w_nombre_cli_cca,
	   		@i_sector = @i_sector,
	   		@i_toperacion = @i_toperacion,
	   		@i_oficina = @i_oficina_tr,
	   		@i_moneda = @i_moneda,
	   		@i_comentario = null,
	   		@i_oficial = @i_oficial,
	   		@i_fecha_ini = @i_fecha_inicio,
	   		@i_monto = @w_monto_renov,
	   		@i_monto_aprobado = @i_monto,
	   		@i_destino = @i_destino,
	   		@i_lin_credito = @i_linea_credito,
	   		@i_ciudad = @i_ciudad_destino,
	   		@i_parroquia = @i_parroquia,     -- ITO: 13/12/2011
	   		@i_forma_pago = @i_fpago,
	   		@i_cuenta = @i_cuenta,
	   		@i_formato_fecha = 103,
	        @i_cta_ahorro = @i_cuenta_corriente, --DMO 12/10/99
     	    @i_cta_certificado = @i_cuenta_certificado, --DMO 12/10/99
	        @i_alicuota = @i_alicuota,
			@i_alicuota_aho = @i_alicuota_aho,
			@i_doble_alicuota = @i_doble_alicuota, --DMO Personalizacion Coop.
			@i_no_banco = 'N',
            @i_actividad_destino = @i_actividad_destino,   --SPO
            @i_compania          = @i_compania,            --SPO
            @i_tipo_cca          = @i_tipo_cca,            --SPO 
            @i_seg_cre    = @i_seg_cre,
            @i_es_interno        = 'S',                     --PRON:24OCT07 Es llamado como proceso interno
            @i_val_act    = 'N',
			@i_activa_TirTea  = @i_activa_TirTea,     -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
	        @i_plazo          = @i_plazo,	--Parámetro para crear la operación con el plazo ingresado desde la Originación
	        @i_tplazo         = @i_tplazo,	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
			@i_toperacion_ori = @i_toperacion_ori
	   		if @w_return != 0 
			      return @w_return

                        select @w_banco = rtrim(convert(char(24), @i_tramite))

                        /*---------------------------------*/
                        --PRON:23OCT2007 Llama a programa que determina el TEA, para validar que la tasa no se pase de la maxima

                        select @w_operacionca = opt_operacion
                        from   cob_cartera..ca_operacion_tmp
                        where  opt_banco = @w_banco

                       /* exec @w_return = cob_pac..sp_TIR_TEA_busin
                             @s_user            = @s_user,
                             @s_sesn            = @s_sesn,
                             @i_operacionca     = @w_operacionca,
                             @i_fecha           = @i_fecha_inicio,
                             @i_calcula_TEA     = 'S',
                             @i_valida_maxima   = 'S',
                             @i_temporal        = 'S',
                             @i_activa_TirTea   = @i_activa_TirTea,     -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
                             @o_tea             = @w_tea out

                        if @w_return != 0
                        begin
                          -- Error en insercion de registro 
                          exec cobis..sp_cerror
                          @t_debug = @t_debug,
        	          @t_file  = @t_file, 
                          @t_from  = @w_sp_name,
                          @i_num   = @w_return
 	                  return 1
                        end*/

 		/* llamada al sp que pasa los datos a tablas definitivas */
	   		exec @w_return = cob_cartera..sp_pasodef
	   		@i_banco = @w_banco,
	   		@i_operacionca = 'S',
	   		@i_dividendo = 'S',
	   		@i_amortizacion = 'S',
	   		@i_cuota_adicional = 'S',
	   		@i_rubro_op = 'S',
	   		@i_relacion_ptmo = 'S'

	   		if @w_return != 0 
	      		   return @w_return 

                        -- GENERACION DE LAS FECHAS DE REAJUSTE
                        if ISNULL(@i_per_reajuste,0) != 0 and @i_reajustable = 'S'
                        begin
                           exec @w_return = cob_cartera..sp_fecha_reajuste
                                @s_ssn         = @s_ssn,
                                @s_user        = @s_user,
                                @i_banco       = @w_banco,
                                @i_tipo        = 'I' 

                         if @w_return <> 0
                           begin
                              /* Error en insercion de registro */
                             exec cobis..sp_cerror
                             @t_debug = @t_debug,
               	             @t_file  = @t_file, 
 	                     @t_from  = @w_sp_name,
 	                     @i_num   = 710045
         	             return 1 
                           end
                        end 
                        else
                        begin
                          delete cob_cartera..ca_reajuste_det
                          from cob_cartera..ca_operacion
                          where red_operacion = op_operacion
                          and op_banco = @w_banco

                          if @@error !=0 
                          begin
                            /* Error en eliminacion de registro */
           	            exec cobis..sp_cerror
        	  @t_debug = @t_debug,
	  @t_file  = @t_file, 
	                    @t_from  = @w_sp_name,
	                    @i_num   = 710042
	                    return 1 
                          end

                          delete cob_cartera..ca_reajuste
                          from cob_cartera..ca_operacion
                          where re_operacion = op_operacion
                          and op_banco = @w_banco

                          if @@error != 0 
                          begin
                            /* Error en eliminacion de registro */
                            exec cobis..sp_cerror
           	            @t_debug = @t_debug,
	                    @t_file  = @t_file, 
 	                    @t_from  = @w_sp_name,
    	                    @i_num   = 710042
	                    return 1 
                          end                      
                        end

	   		/* borrado de las tablas temporales */
	   		exec @w_return = cob_cartera..sp_borrar_tmp
   			     @s_user   = @s_user,
  			     @s_sesn   = @s_sesn,
	   		     @i_banco  = @w_banco
	   		if @w_return != 0
	   		   return @w_return

                        print 'Los valores iniciales del tramite han sido cambiados. El sistema volvio a crear la tabla con los valores por DEFECTO. Verifique tasas y plazos'
	   end /*else w_cambio = 'N'*/
	end /* operacion de cartera */

	-- reestructuraciones
	if @i_tipo = 'E'
	begin
	   -- obtener la operacion a reestructurar
	   select @w_op_reestructurar = or_num_operacion
	   from   cob_credito..cr_op_renovar
	   where  or_tramite = @i_tramite

	   -- verificar si cambio la operacion a reestructurar
	   if @w_op_reestructurar = @i_op_reestructurar
	   begin
	   -- no cambio la operacion ==> actualizar ca_operacion
	      update cob_cartera..ca_operacion
	      set 
    	      op_cliente		= @i_cliente_cca,
              op_destino		= @i_destino,
	      op_ciudad			= @i_ciudad_destino,
	      -- JTA op_parroquia		= @i_parroquia,             -- ITO:13/12/2011
	      op_fecha_reajuste 	= @i_fecha_reajuste,
	      op_periodo_reajuste 	= @i_per_reajuste,
	      op_reajuste_especial 	= @i_reajuste_especial,
	      op_forma_pago  		= @i_fpago,
	      op_cuenta 		= @i_cuenta,
	      op_cuota_completa 	= @i_cuota_completa,
	      op_tipo_cobro 		= @i_tipo_cobro,
	      op_tipo_reduccion 	= @i_tipo_reduccion,
	      op_aceptar_anticipos 	= @i_aceptar_anticipos,
	      op_precancelacion 	= @i_precancelacion,
	      op_tipo_aplicacion 	= @i_tipo_aplicacion,
	      op_renovacion		= @i_renovable,
	      op_reajustable 		= @i_reajustable,
	      op_nombre			= @w_nombre_cli_cca -- JTA,
          -- JTA op_actividad_destino      = @i_actividad_destino,  --SPO
          -- JTA op_compania               = @i_compania,           --SPO
          -- JTA op_tipo_cca               = @i_tipo_cca,           --SPO 
          -- JTA op_seg_cre                = @i_seg_cre
	      where op_tramite = @i_tramite
	      if @@error <> 0
	      begin
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 2103001,
	         @i_msg	 = '[sp_up_tramite_busin] ERROR EN ACTUALIZACION DE OPERACION EN CARTERA'
   	         return 1 
	      end
	   end
	   else
	   begin

  	         -- si hubo cambio ==> regenerar los datos
		-- eliminar la operacion copia
		--(1) traer numero secuencial de operacion
		select @w_operacion_rest_ant = op_operacion
		from   cob_cartera..ca_operacion
		where  op_tramite = @i_tramite

		--(2) borrar las tablas
		delete cob_cartera..ca_operacion 
		 where op_tramite = @i_tramite
		delete cob_cartera..ca_amortizacion 
		 where am_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_cuota_adicional 
		 where ca_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_dividendo 
		 where di_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_rubro_op 
		 where ro_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_tasas 
		 where ts_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_relacion_ptmo
		 where rp_pasiva = @w_operacion_rest_ant
		delete cob_cartera..ca_operacion_tmp
		 where opt_banco = @w_op_reestructurar
		delete cob_cartera..ca_dividendo_tmp
		 where dit_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_amortizacion_tmp
		 where amt_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_cuota_adicional_tmp
	 where cat_operacion = @w_operacion_rest_ant
		delete cob_cartera..ca_rubro_op_tmp
		 where rot_operacion = @w_operacion_rest_ant

		delete cob_credito..cr_deudores
		where  de_tramite = @i_tramite
		delete cob_credito..cr_gar_propuesta
		where  gp_tramite = @i_tramite
		delete cob_credito..cr_op_renovar
		where  or_tramite = @i_tramite

		-- obtener los datos de la operacion a reestructurar
		select 	@w_tramite_rest = op_tramite,
		       	@w_cliente_rest = op_cliente,
		       	@w_monto_rest   = op_monto_aprobado,
			@w_moneda_rest  = op_moneda,
			@w_fecha_liq_rest = op_fecha_liq,
			@w_toperacion_rest = op_toperacion,
			@w_operacion_rest = op_operacion
		from cob_cartera..ca_operacion
		where op_banco = @i_op_reestructurar
		if @@rowcount = 0
		begin
		   /** registro no existe **/
		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2101010
		   return 1 	
		end


		-- llamar al sp que crea copia
	  /*	exec @w_return = cob_credito..sp_copia_operacion
		@s_ssn		= @s_ssn,
		@s_user		= @s_user,
		@s_sesn		= @s_sesn,
		@s_term		= @s_term,
		@s_date		= @s_date,
		@s_srv		= @s_srv,
		@s_lsrv		= @s_lsrv,
		@s_rol		= @s_rol,
		@s_ofi		= @s_ofi,
		@s_org_err	= @s_org_err,
		@s_error	= @s_error,
		@s_sev		= @s_sev,
		@s_msg		= @s_msg,
		@s_org		= @s_org,
		@t_rty		= @t_rty,
		@t_trn		= 21218,
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @t_from,
		@i_tramite	= @i_tramite,
		@i_banco	= @i_op_reestructurar
		if @w_return != 0
		   return @w_return
*/
		-- actualizar destino y ciudad
		update cob_cartera..ca_operacion
		set    
		op_destino = @i_destino,
		op_ciudad  = @i_ciudad_destino -- JTA,
		-- JTA op_parroquia = @i_parroquia,
        -- JTA op_actividad_destino =@i_actividad_destino  --SPO
		where op_tramite = @i_tramite
		if @@rowcount = 0
		begin
		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2103001,
		   @i_msg	 = '[sp_up_tramite_busin] ERROR EN ACTUALIZACION DE OPERACION EN CARTERA'
		   return 1 
		end



		-- copiar deudores
		insert into cob_credito..cr_deudores
		(de_tramite, de_cliente, de_rol, de_ced_ruc)
		select 
		@i_tramite, de_cliente, de_rol, de_ced_ruc
		from  cob_credito..cr_deudores
		where de_tramite = @w_tramite_rest
		if @@error != 0
		begin
		   /* Error en insercion de registro */
   		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2103001,
		   @i_msg   = '[sp_up_tramite_busin] ERROR EN INSERCION DE DEUDORES DE REESTRUCTURACION'
		   return 1 
		end

		-- copiar garantias propuestas
		insert into cob_credito..cr_gar_propuesta
		(gp_tramite, gp_garantia, gp_clasificacion, gp_exceso, gp_monto_exceso,
		 gp_abierta, gp_deudor, gp_est_garantia)
		select
		@i_tramite, gp_garantia, gp_clasificacion, gp_exceso, gp_monto_exceso,
		gp_abierta, @w_cliente_rest, gp_est_garantia
		from  cob_credito..cr_gar_propuesta
		where gp_tramite = @w_tramite_rest
		if @@error != 0
		begin
		/* Error en insercion de registro */
		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2103001,
		   @i_msg   = '[sp_up_tramite_busin] ERROR EN INSERCION DE GARANTIAS DE REESTRUCTURACION'
		   return 1 
		end

		-- crear registro en cr_op_renovar
		-- (1) obtener el saldo de la operacion a reestructurar
        -- JTA select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0) - isnull(am_exponencial,0))
		select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0))
		from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
		where  ro_operacion = @w_operacion_rest
		and    ro_tipo_rubro in ('C')    -- tipo de rubro capital
		and    am_operacion = ro_operacion
		and    am_concepto  = ro_concepto

		-- (2)insertar un registro en cr_op_renovar
		insert into cob_credito..cr_op_renovar
		(or_tramite,or_num_operacion,or_producto,or_abono,
		 or_moneda_abono,or_monto_original,or_moneda_original,
		 or_saldo_original,or_fecha_concesion,or_toperacion)
		values
		(@i_tramite, @i_op_reestructurar, 'CCA', 0,
		 null, @w_monto_rest, @w_moneda_rest,
		 @w_saldo_rest, @w_fecha_liq_rest, @w_toperacion_rest)
		if @@error != 0
		begin
		/* Error en insercion de registro */
		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2103001,
		   @i_msg   = '[sp_up_tramite_busin] ERROR EN INSERCION DE OPERACION A REESTRUCTURAR'
		   return 1 
		end
	   end -- hubo cambio en la operacion a reestructurar
	end -- reestructuracion
commit tran
return 0                                                                                                                                                       




GO

