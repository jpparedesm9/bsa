USE cob_pac
go
IF OBJECT_ID ('sp_in_tramite_busin') IS NOT NULL
    DROP PROCEDURE sp_in_tramite_busin
GO

CREATE PROCEDURE [dbo].[sp_in_tramite_busin] (
   @s_ssn                int = null,
   @s_user               login = null,
   @s_sesn               int = null,
   @s_term               varchar(30) = null,
   @s_date               datetime = null,
   @s_srv                varchar(30) = null,
   @s_lsrv               varchar(30) = null,
   @s_rol                smallint = NULL,
   @s_ofi                smallint = NULL,
   @s_org_err            char(1) = NULL,   -- 10
   @s_error              int = NULL,
   @s_sev                tinyint = NULL,
   @s_msg                descripcion = NULL,
   @s_org                char(1) = NULL,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1) = null,    --20
   @i_tramite            int  = null,
   @i_tipo               char(1) = null,
   @i_truta              tinyint = 88,
   @i_oficina_tr         smallint = null,
   @i_usuario_tr         login = null,
   @i_fecha_crea         datetime = null,
   @i_oficial            smallint = null,
   @i_sector             catalogo = null,
   @i_ciudad             smallint = null,
   @i_estado             char(1) = null,   -- 30
   @i_nivel_ap           tinyint = null,
   @i_fecha_apr          datetime = null,
   @i_usuario_apr        login = null,
   @i_numero_op_banco    cuenta  = null,
   /* campos para tramites de garantias */
   @i_proposito          catalogo = null,
   @i_razon              catalogo = null,
   @i_txt_razon          varchar(255) = null,
   @i_efecto             catalogo = null,
   /* campos para lineas de credito */
   @i_cliente            int = null,
   @i_grupo              int = null,    --40
   @i_fecha_inicio       datetime = null,
   @i_num_dias           smallint = 0,
   @i_per_revision       catalogo = null,
   @i_condicion_especial varchar(255) = null,
   @i_rotativa           char(1) = null,
   /* operaciones originales y renovaciones */
   @i_linea_credito      cuenta = null,
   @i_toperacion         catalogo = null,
   @i_producto           catalogo = null,
   @i_monto              money = 0,
   @i_moneda             tinyint = 0,
   @i_periodo            catalogo = null, --50
   @i_num_periodos       smallint = 0,
   @i_destino            catalogo = null,
   @i_ciudad_destino     smallint = null,
   @i_parroquia          catalogo = null,      --ITO:13/12/2011
   @i_cuenta_corriente   cuenta = null,
   @i_garantia_limpia    char(1) = null,
   -- solo para prestamos de cartera
   @i_monto_desembolso   money = null,
   @i_reajustable        char(1) = null,
   @i_per_reajuste       tinyint = null,
   @i_reajuste_especial  char(1) = null,
   @i_fecha_reajuste     datetime = null,  --60
   @i_cuota_completa     char(1) = null,
   @i_tipo_cobro         char(1) = null,
   @i_tipo_reduccion     char(1) = null,
   @i_aceptar_anticipos  char(1) = null,
   @i_precancelacion     char(1) = null,
   @i_tipo_aplicacion    char(1) = null,
   @i_renovable          char(1) = null,
   @i_fpago              catalogo = null,
   @i_cuenta             cuenta = null,
   -- generales
   @i_renovacion         smallint = null, -- 70
   @i_cliente_cca        int = null,
   @i_op_renovada        cuenta = null,
   @i_deudor             int = null,
   -- reestructuracion
   @i_op_reestructurar   cuenta = null,
   @i_cuenta_certificado cuenta = null,
   @i_alicuota           catalogo = null,
   @i_alicuota_aho       catalogo = null,
   @i_doble_alicuota     char(1) = null,
   @i_actividad_destino  catalogo=null,     -- SPO Actividad economica
   @i_compania           int=null,          -- SPO Nombre compa¤ia - grupo
   @i_tipo_cca           catalogo = null,   --SPO Clase de cartera del credito
   @i_vinculado          char(1)  = 'N',
   @i_causal_vinculacion catalogo = null,
   @i_verificador        catalogo = null,
   @i_seg_cre            catalogo = null,
   @i_val_act            char(1) = 'N',
   @i_activa_TirTea      char(1) = 'S',     -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
   @i_ssn                int = null,  --AC SSN PARA ALMACENAR LOS DEUDORES
   @i_toperacion_ori	 catalogo 	  = null, --Policia Nacional: Se incrementa por tema de interceptor
   @i_tplazo             catalogo     = null,   --Parámetro para crear la operación con el plazo ingresado desde la Originación
   @i_plazo              smallint     = null,	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
   @o_retorno            int = null out
)
as

declare
   @w_today              datetime,     /* fecha del dia */
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_numero_op          int,
   @w_linea_credito      int ,	       /* renovaciones y operaciones */
   @w_numero_linea       int,
   @w_numero_operacion   int,
   @w_numero_op_banco    cuenta,
   @w_prioridad          tinyint,
   @o_tramite            int,
   @o_linea_credito      cuenta,
   @o_numero_op          cuenta,
   /* variables para ingreso en cr_ruta_tramite */
   @w_estacion           smallint,
   @w_etapa              tinyint,
   @w_login              login,
   @w_paso               tinyint,
   @w_login_oficial      login,
   @w_estacion_ofi       smallint,
   @w_etapa_ofi          tinyint,
   @w_paso_ofi           tinyint,
   @w_banco              cuenta,
   @w_fecha_fin          varchar(10),
   @w_fecha_ini          varchar(10),
/* nueva variable DIEGO A 09/01/97*/
   @w_tramite            int,
   @w_des_periodo        descripcion,
   @w_num_periodos       int,
   @w_val_tasaref        float,
   @w_periodo            catalogo,
   @w_hora_0             varchar(8),
   @w_hora_1             varchar(8),
   @w_nombre_cli_cca     varchar(64),		--optimizacion de CCA
   @w_tramite_rest       int,			-- tramite de operacion a reestructurar
   @w_cliente_rest       int,			-- deudor de operacion a reestructurar
   @w_monto_rest         money, 		-- monto inicial de operacion a reestructurar
   @w_moneda_rest        tinyint,		-- moneda de operacion a reestructurar
   @w_saldo_rest         money, 		-- saldo de operacion a reestructurar
   @w_fecha_liq_rest     datetime,		-- fecha de liquidacion de op. a reestructurar
   @w_toperacion_rest    catalogo,		-- tipo de prestamo de operacion a reestructurar
   @w_operacion_rest     int,			-- numero secuencial de operacion a reestructurar
   @w_monto_renov        money,                 -- MVI 22/12/98 por renovaciones
   @w_operacionca        int,
   @w_tea                float


select @w_today  = getdate()
select @w_sp_name = 'sp_in_tramite_busin',
       @i_activa_TirTea = isnull(@i_activa_TirTea, 'S')   -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE

/******* Verificaciones Previas **********/
/*****************************************/

/* Chequeo de Linea de Credito */
/*
If @i_linea_credito is not null
begin
	select  @w_numero_linea = li_numero
	from    cob_credito..cr_linea
	where   li_num_banco = @i_linea_credito
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
*/
/* Chequeo de Numero de operacion */
If @i_numero_op_banco is not null
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

/** Chequeo de Operacion a Reestructurar **/
If @i_tipo = 'E'

begin
   if @i_op_reestructurar is null
   begin
      /** Parametro con valor null **/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2101001
      return 1
   end

   select @w_tramite_rest = op_tramite,
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

end

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

--/**** Verificacion de estaciones ****/
--/* obtener el login del oficial */
--select @w_login_oficial = fu_login
--from   cobis..cc_oficial, cobis..cl_funcionario
--where  oc_oficial = @i_oficial
--and    oc_funcionario = fu_funcionario
--if @@rowcount = 0
--begin
--/* oficial no existe en funcionarios */
--	exec cobis..sp_cerror
--	@t_debug = @t_debug,
--	@t_file  = @t_file,
--	@t_from  = @w_sp_name,
--	@i_num   = 2101022
--	return 1
--end

--/* obtener la etapa inicial de la ruta */
--select @w_etapa = pa_etapa,
--       @w_paso  = pa_paso
--from   cr_pasos, cr_etapa
--where  pa_etapa = et_etapa
--and    pa_truta = @i_truta
--and    et_tipo = 'I'

--/* Comprobar que exista una estacion valida para usuario_tr,
--   en la etapa inicial de la ruta */
--select @w_estacion = ee_estacion
--from   cr_etapa_estacion, cr_estacion
--where  ee_etapa = @w_etapa
--and    ee_estacion = es_estacion
--and    es_usuario = @i_usuario_tr
--and    ee_estado = 'A'
--If @@rowcount = 0
--begin

--	/** registro no existe **/
--		exec cobis..sp_cerror
--		@t_debug = @t_debug,
--		@t_file  = @t_file,
--		@t_from  = @w_sp_name,
--		@i_num   = 2101012
--		return 1
--end
--select @w_paso = 1

--/* Comprobar que el oficial tenga una estacion */
--select 	@w_estacion_ofi = es_estacion
--from	cr_estacion
--where	es_usuario = @w_login_oficial
--If @@rowcount = 0
--begin
--	/* oficial no tiene estacion de trabajo asignada */
--		exec cobis..sp_cerror
--		@t_debug = @t_debug,
--		@t_file  = @t_file,
--		@t_from  = @w_sp_name,
--		@i_num   = 2101023
--		return 1
--end

--/* Verificar si el oficial esta haciendo el ingreso de datos */
--if @i_usuario_tr = @w_login_oficial
--begin
--/*comprobar si la estacion del oficial est  en la ruta*/
--        if not exists (select 1
--                       from   cr_etapa_estacion
--                       where  ee_etapa = @w_etapa
--                       and    ee_estacion = @w_estacion_ofi)
--
--	if @@rowcount = 0
--	begin
--	/* estacion de oficial no esta en ruta del tr mite */
--		exec cobis..sp_cerror
--		@t_debug = @t_debug,
--		@t_file  = @t_file,
--		@t_from  = @w_sp_name,
--		@i_num   = 2101024
--		return 1
--	end
	 /* select 	@w_etapa = @w_etapa_ofi,
		@w_estacion = @w_estacion_ofi,
		@w_paso = @w_paso_ofi */
--end


/** Obtener prioridad **/
SELECT @w_prioridad = tt_prioridad
from   cob_credito..cr_tipo_tramite
where  tt_tipo = @i_tipo
if @@rowcount = 0
begin
   select @w_prioridad = 1
end


/**** INSERCION DEL REGISTRO *******/
/***********************************/

begin tran
	/* Numero secuencial de tramite */
	exec cobis..sp_cseqnos
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
	@i_tabla = 'cr_tramite',
	@o_siguiente = @o_tramite out

	if @o_tramite = NULL
	begin
	    /* No existe tabla en tabla de secuenciales*/
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file  = @t_file,
	    @t_from  = @w_sp_name,
	    @i_num   = 2101007
	    return 1
	end
	select @i_tramite = @o_tramite


	--Se incrementa para policia debido a que no se estaba guadando los deudores
    /* LGU: homologando fuente compilado en pruebas
    if  @i_tipo <> 'M' and @i_tipo <> 'C' -- ABE Flujo Moratoria
    begin
      insert cob_credito..cr_deudores
      select @i_tramite,   dt_cliente,   dt_rol,    en_ced_ruc
      from cob_pac..cr_deudores_tmp, cobis..cl_ente
      where dt_ssn = @i_ssn
        and en_ente = dt_cliente

       if @@error <> 0
       begin
              rollback tran
              return 2103001
       end
    end
     */
	/* insercion en la tabla cr_tramite */

   	INSERT INTO cob_credito..cr_tramite
   	(
	tr_tramite, tr_tipo, tr_oficina, tr_usuario, tr_fecha_crea,
	tr_oficial, tr_sector, tr_ciudad, tr_estado, tr_nivel_ap,
	tr_fecha_apr,tr_usuario_apr, tr_truta, tr_secuencia,
	tr_numero_op, tr_numero_op_banco,
	tr_proposito, tr_razon, tr_txt_razon, tr_efecto, tr_cliente,
	tr_grupo, tr_fecha_inicio, tr_num_dias, tr_per_revision,
	tr_condicion_especial,
    tr_linea_credito,tr_toperacion, tr_producto, tr_monto,
	tr_moneda, tr_periodo,tr_num_periodos, tr_destino,
	tr_ciudad_destino, tr_cuenta_corriente/*,
	tr_garantia_limpia, tr_renovacion, tr_cuenta_certificado,
	tr_alicuota, tr_alicuota_aho, tr_doble_alicuota, --DMO Personalizacion Coop.
	tr_actividad_destino,  tr_tipo_cca,  tr_verificador, tr_seg_cre*/
   	)
   	VALUES
   	(
	@i_tramite, @i_tipo, @i_oficina_tr, @i_usuario_tr, @w_today,
	@i_oficial, @i_sector, @i_ciudad, 'N', @i_nivel_ap,
	@i_fecha_apr, @i_usuario_apr, @i_truta, 1,
	@w_numero_operacion, @i_numero_op_banco,
	@i_proposito, @i_razon, @i_txt_razon, @i_efecto, @i_cliente,
	@i_grupo, @i_fecha_inicio, @i_num_dias, @i_per_revision,
	@i_condicion_especial,
	@w_numero_linea, @i_toperacion, @i_producto, @i_monto,
	@i_moneda, @i_periodo, @i_num_periodos, @i_destino,
	@i_ciudad_destino, @i_cuenta_corriente/*,
	@i_garantia_limpia, @i_renovacion,
	@i_cuenta_certificado,
	@i_alicuota, @i_alicuota_aho, @i_doble_alicuota,  --DMO Personalizacion Coop.
        @i_actividad_destino,  @i_tipo_cca,  @i_verificador, @i_seg_cre*/
   	)
         if @@error <> 0
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103001
             return 1
         end

--	/**** INSERTAR EL PRIMER REGISTRO EN cr_ruta_tramite ***/
--	insert into cr_ruta_tramite
--	    (rt_tramite,rt_secuencia,rt_truta,rt_paso,rt_etapa,
--	     rt_estacion, rt_llegada,rt_prioridad,rt_abierto
--	    )
--	values
--	    (@o_tramite,1,@i_truta,@w_paso,@w_etapa,
--             @w_estacion, getdate(), @w_prioridad,'C'
--	    )
--	If @@error <> 0
--	begin
--         /* Error en insercion de registro */
--             exec cobis..sp_cerror
--             @t_debug = @t_debug,
--             @t_file  = @t_file,
--             @t_from  = @w_sp_name,
--             @i_num   = 2103001
--             return 1
--        end

   	/**** TRANSACCION DE SERVICIO ***/
	insert into cob_credito..ts_tramite
	(secuencial, tipo_transaccion, clase, fecha, usuario, terminal,
	 oficina, tabla, lsrv, srv, tramite, tipo, oficina_tr, usuario_tr,
	 fecha_crea, oficial, sector, ciudad, estado, nivel_ap, fecha_apr,
	 usuario_apr, truta, secuencia, numero_op, numero_op_banco, proposito, razon,
	 txt_razon, efecto, cliente, grupo, fecha_inicio, num_dias, per_revision,
         condicion_especial, linea_credito, toperacion, producto,
	 monto, moneda, periodo, num_periodos, destino, ciudad_destino,
	 cuenta_corriente/*, garantia_limpia*/, renovacion /*verificador, seg_cre*/
	)
	values
	(@s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term,
	 @s_ofi, 'cr_tramite', @s_lsrv, @s_srv, @i_tramite, @i_tipo, @i_oficina_tr, @i_usuario_tr,
	 @w_today, @i_oficial, @i_sector, @i_ciudad, 'N', @i_nivel_ap, @i_fecha_apr,
	 @i_usuario_apr, @i_truta, 1, @w_numero_operacion, @i_numero_op_banco, @i_proposito, @i_razon,
	 @i_txt_razon, @i_efecto, @i_cliente, @i_grupo, @i_fecha_inicio, @i_num_dias, @i_per_revision,
         @i_condicion_especial, @w_numero_linea, @i_toperacion, @i_producto,
	 @i_monto, @i_moneda, @i_periodo, @i_num_periodos, @i_destino, @i_ciudad_destino,
	 @i_cuenta_corriente, /*@i_garantia_limpia,*/ @i_renovacion /*@i_verificador, @i_seg_cre*/
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


	/* RETORNO DE NUMERO DE TRAMITE AL FRONT END */
        select @i_tramite

        select  @w_tramite = @i_tramite,
                @o_retorno = @i_tramite

                --PRINT '[sp_in_tramite_busin] @o_retorno:%1!',@o_retorno
                PRINT '[sp_in_tramite_busin] @o_retorno: ' + @o_retorno

	/* SI EL TRAMITE ES DE LINEA DE CREDITO ==> CREAR REGISTRO DE LINEA */
	/********************************************************************/
    /* LGU: porque no existe este SP
	If @i_tipo = 'L'
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
	   	  @t_from = @t_from,
		  @t_trn = 21026,
   		  @i_operacion = 'I',
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

	end			-- FIN DE LINEA DE CREDITO
    */

	/* SI EL TRAMITE ES ORIGINAL/RENOVACION Y DE CARTERA */
	if (@i_tipo = 'O' or @i_tipo = 'R') and (@i_producto = 'CCA')
	begin

	   /* asigno el numero de banco como tramite */
	   select @w_banco = rtrim(convert(char(24), @i_tramite))

	   /* optimizacion de cartera */
	   select  @w_nombre_cli_cca = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre)
	   from	   cobis..cl_ente
	   where   en_ente = @i_cliente_cca

	   /* llamada al sp que crea los datos en tablas temporales */
           if (@i_tipo = 'R')
              select @w_monto_renov = @i_monto
           if (@i_tipo = 'O')
              select @w_monto_renov = @i_monto_desembolso

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
	   @i_parroquia = @i_parroquia,    -- ITO:13/12/2011
	   @i_forma_pago = @i_fpago,
	   @i_cuenta = @i_cuenta,
	   @i_formato_fecha = 103,
           @i_cta_ahorro = @i_cuenta_corriente, --DMO 12/10/99
	   @i_cta_certificado = @i_cuenta_certificado, --DMO 12/10/99
 	   @i_alicuota = @i_alicuota,
	   @i_alicuota_aho = @i_alicuota_aho,
	   @i_doble_alicuota = @i_doble_alicuota,
  	   @i_no_banco = 'N',
           @i_actividad_destino= @i_actividad_destino,  --SPO
           @i_compania = @i_compania,                   --SPO
           @i_tipo_cca = @i_tipo_cca,                   --SPO
   	   @i_seg_cre  = @i_seg_cre,
           @i_es_interno = 'S',                          --PRON:24OCT07 Es llamado como proceso interno:
           @i_val_act    = 'N',
       @i_activa_TirTea = @i_activa_TirTea,     -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
	   @i_toperacion_ori =  @i_toperacion_ori,
	   @i_plazo          = @i_plazo,	--Parámetro para crear la operación con el plazo ingresado desde la Originación
	   @i_tplazo         = @i_tplazo	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
	   if @w_return != 0
	      return @w_return

           /*---------------------------------*/
           --PRON:23OCT2007 Llama a programa que determina el TEA, para validar que la tasa no se pase de la maxima

           select @w_operacionca = opt_operacion
           from   cob_cartera..ca_operacion_tmp
           where  opt_banco = @w_banco

--print 'antes de cob_cartera..sp_TIR_TEA, parametros: @s_user: %1!, @s_sesn: %2!',  @s_user, @s_sesn
print 'antes de cob_cartera..sp_TIR_TEA, parametros: @s_user: ' + @s_user + ', @s_sesn: ' + @s_sesn
           exec @w_return = cob_pac..sp_TIR_TEA_busin
           @s_user            = @s_user,
           @s_sesn            = @s_sesn,
           @i_operacionca     = @w_operacionca,
           @i_fecha           = @i_fecha_inicio,
           @i_calcula_TEA     = 'S',
           @i_valida_maxima   = 'S',
           @i_temporal        = 'S',
           @i_activa_TirTea   = @i_activa_TirTea,   -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
           @o_tea             = @w_tea out

           if @w_return != 0
           begin
              /* Error en insercion de registro */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
        	 @t_file  = @t_file,
 	         @t_from  = @w_sp_name,
	         @i_num   = @w_return
 	         return 1
           end

print 'después de cob_cartera..sp_TIR_TEA'
	   /* llamada al sp que pasa los datos a tablas definitivas */
	   exec @w_return = cob_cartera..sp_pasodef
	        @i_banco           = @w_banco,
  	        @i_operacionca     = 'S',
	        @i_dividendo       = 'S',
	        @i_amortizacion    = 'S',
	        @i_cuota_adicional = 'S',
	        @i_rubro_op        = 'S',
	        @i_relacion_ptmo   = 'S'

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

           /* PRON:6MARZO2007 Se elimina la relacion automatica por la evaluacion de coberturas en las
                               garantias abiertas
	   /* insercion de las garantias abiertas del deudor principal a cr_gar_propuesta */
           insert into cob_credito..cr_gar_propuesta(
                 gp_tramite,
                 gp_garantia,
                 gp_clasificacion,		/* gp_clasificacion siempre igual 'a'  */
	         gp_exceso,
	         gp_monto_exceso,
	         gp_abierta,
	         gp_deudor,
	         gp_est_garantia)
            select distinct @i_tramite,gp_garantia,'a',NULL,NULL,
                            gp_abierta,@i_deudor ,gp_est_garantia
            from cob_credito..cr_gar_propuesta
           where gp_deudor          = @i_deudor
             and gp_est_garantia          not in ('A','C') -- No las Canceladas
             and gp_abierta = 'A'
             and gp_tramite <> @i_tramite
           PRON:6MARZO2007 */

	end /*@i_tipo = 'O' or @i_tipo = 'R'*/


	/* SI EL TRAMITE ES REESTRUCTURACION DE CARTERA */
	if (@i_tipo = 'E')
	begin

	   -- llamar a la creacion de la copia de la operacion
	   /* LGU: porque no existe este SP
       exec @w_return = cob_credito..sp_copia_operacion
	   @s_ssn	= @s_ssn,
	   @s_user	= @s_user,
	   @s_sesn	= @s_sesn,
	   @s_term	= @s_term,
	   @s_date	= @s_date,
	   @s_srv	= @s_srv,
	   @s_lsrv	= @s_lsrv,
	   @s_rol	= @s_rol,
	   @s_ofi	= @s_ofi,
	   @s_org_err	= @s_org_err,
	   @s_error	= @s_error,
	   @s_sev	= @s_sev,
	   @s_msg	= @s_msg,
	   @s_org	= @s_org,
	   @t_rty	= @t_rty,
	   @t_trn	= 21218,
	   @t_debug	= @t_debug,
	   @t_file	= @t_file,
	   @t_from	= @t_from,
	   @i_tramite	= @i_tramite,
	   @i_banco	= @i_op_reestructurar
	   if @w_return != 0
	      return @w_return
		*/

	   -- actualizar destino y ciudad
	   update cob_cartera..ca_operacion
	   set    op_destino = @i_destino,
 	          op_ciudad  = @i_ciudad_destino
 	          --op_parroquia  = @i_parroquia,    -- ITO: 13/12/2011
                --  op_actividad_destino = @i_actividad_destino, --SPO
                 -- op_tipo_cca =@i_tipo_cca                     --SPO
	   where op_tramite = @i_tramite
	   if @@rowcount = 0
	   begin
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2103001,
	      @i_msg	 = '[sp_in_tramite_busin] ERROR EN ACTUALIZACION DE OPERACION EN CARTERA'
	      return 1
	   end

	   -- copiar los deudores
	   insert into cob_credito..cr_deudores (de_tramite, de_cliente, de_rol, de_ced_ruc)
	   select @i_tramite, de_cliente, de_rol, de_ced_ruc
	   from   cob_credito..cr_deudores
	   where  de_tramite = @w_tramite_rest

	   if @@error != 0
	   begin
       	   /* Error en insercion de registro */
       	      exec cobis..sp_cerror
       	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2103001,
	      @i_msg	 = '[sp_in_tramite_busin] ERROR EN INSERCION DE DEUDORES DE REESTRUCTURACION'
	      return 1
	   end

	   -- copiar las garantias propuestas
	   insert into cob_credito..cr_gar_propuesta (gp_tramite, gp_garantia, gp_clasificacion, gp_exceso, gp_monto_exceso,
             	                         gp_abierta, gp_deudor, gp_est_garantia)
	   select @i_tramite, gp_garantia, gp_clasificacion, gp_exceso, gp_monto_exceso,
	          gp_abierta, @w_cliente_rest, gp_est_garantia
	   from   cob_credito..cr_gar_propuesta
	   where  gp_tramite = @w_tramite_rest

	   if @@error != 0
	   begin
       	   /* Error en insercion de registro */
       	      exec cobis..sp_cerror
       	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2103001,
	      @i_msg	 = '[sp_in_tramite_busin] ERROR EN INSERCION DE GARANTIAS DE REESTRUCTURACION'
	      return 1
	   end

	   -- obtener el saldo de la operacion a reestructurar
	   --select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0) - isnull(am_exponencial,0))
	   select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0) /*- isnull(am_exponencial,0)*/)
	   from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
	   where  ro_operacion = @w_operacion_rest
	   and    ro_tipo_rubro in ('C')    -- tipo de rubro capital
	   and    am_operacion = ro_operacion
	   and    am_concepto  = ro_concepto

	   -- insertar un registro en cr_op_renovar
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
	      @i_msg	 = '[sp_in_tramite_busin] ERROR EN INSERCION DE OPERACION A REESTRUCTURAR'
	      return 1
	   end

	end /* @i_tipo = 'E' */

commit tran

/* retorno de datos al frontend */
select @w_periodo = td_tdividendo,
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
 return 0



GO

