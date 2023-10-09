/************************************************************************/
/*      Archivo:                ahndcaut.sp                             */
/*      Stored procedure:       sp_ahndc_automatica                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     12-Ene-1993                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*                                                                      */
/*      Este programa procesa las transacciones de ND y NC otras        */
/*      fuentes (automaticas).                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR         RAZON                            */
/*      12/Jul/1994      X. Gellibert  Emision inicial                  */
/*      12/Oct/1994      P. Mena       Inclusion del contador de        */
/*                                     transacciones                    */
/*      17/Ago/1995      E. Guerrero   Emision inicial Cursores         */
/*      17/Jun/1999      M. Sanguino   Personalizacion B. del Caribe    */
/*      07/Jul/1999      J. Gordillo   ATM                              */
/*      14/Oct/1999      J. Gordillo   Comisiones por cajero            */
/*      20/Jul/2000      Y. Rivero     Programacion para que no che--   */
/*                                     queara si la cuenta esta blo--   */
/*                                     queada para el caso de Inager y  */
/*                                     Pensionados                      */
/*      21/Jul/2000      Y. Rivero     Programacion para que activara   */
/*                                     la cuenta, en caso de que este   */
/*                                     inactiva, para el caso de Fidei- */
/*                                     comiso                           */
/*      14/ene/2004      M. Gaona      Homologacion offline branch III  */
/*      18/Mar/2005      L. Bernuil    Validacion de Fecha de Ultimo    */
/*                                     Movimiento.                      */
/*      22/Mar/2005      L. Bernuil    Manejo del Stand In              */
/*      28/Abr/2005      M. Gaona      Campo para causa de la comision  */
/*      05/Ene/2005      R. Ramos      Cuando es invocado por batch     */
/*      06/Feb/2006      D. Vasquez    Inserta el numero de cheque      */
/*      19/May/2006      P. Coello     Valida que exista el valor en    */
/*                                     suspenso antes de reversalo      */
/*      30/May/2006      P. Coello     No Validar el @s_user            */
/*      17/Nov/2006      R. Ramos      Correccion de if en reverso de un*/
/*                                     valor en suspenso                */
/*      11/Abr/2007      R. Ramos      Correccion de if en reverso de   */
/*                                     otros bancos                     */
/*      04/Sep/2009      A. Correa     Funcionalidad Impuesto GMF       */
/*                                     Colombia                         */
/*      21/ene/2010      CMunoz        FRC-AHO-017-CobroComisiones      */
/*      04/Feb/2010      J.Loyo        Validacion de Saldo Maximo       */
/*                                     para la cuenta                   */
/*      14/Feb/2013      L.Moreno      NC Generacion de GMF a cargo de  */
/*                                     Bancamia para algunas causales   */
/*      11/Abr/2013      J.Colorado    Alianza Cormecial                */
/*      12/Ago/2013      C. Avendaño   Se agrega variable para controlar*/
/*                                     si se ejecuta desde un WS        */
/*      28/Feb/2014      C. Avendaño   Se redondea la variable @w_val al*/
/*                                     segun param. Req 371             */
/*      02/May/2016      J. Calderon   Migración a CEN                  */
/************************************************************************/

use cob_ahorros
GO
/****** Object:  StoredProcedure [dbo].[sp_ahndc_automatica]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

if exists (select 1
			from sysobjects
			where name = 'sp_ahndc_automatica')
	drop proc sp_ahndc_automatica
go

create proc sp_ahndc_automatica
(
	@s_srv               varchar(30),
	@s_ofi               smallint,
	@s_ssn               int,
	@s_ssn_branch        int 			= null,
	@s_user              varchar(30) 	= null,
	@s_term              varchar(10) 	= 'consola',
	@s_org               char(1) 		= 'C',
	@s_rol               smallint 		= null,
	@t_show_version      bit 			= 0,
	@t_trn               int,
	@t_corr              char(1) 		= 'N',
	@t_ssn_corr          int 			= null,
	@t_debug             char(1) 		= 'N',
	@t_file              varchar(14) 	= null,
	@t_from              varchar(32) 	= null,
	@i_cta               cuenta,
	@i_val               money,
	@i_cau               char(3),
	@i_mon               tinyint,
	@i_fecha             smalldatetime 	= null,
	@i_alt               int 			= 0,
	@i_change_ofi        char(1) 		= 'N',
	@i_cobsus            char(1) 		= 'N',
	@i_inmovi            char(1) 		= 'N',
	@i_imp               char(1) 		= 'N',
	@i_devolucion_imp    money 			= 0,
	@i_atm_server        char(1) 		= 'N',
	@i_srvorg            varchar(8) 	= ' ',
	@i_comision          money 			= 0,
	@i_num_trans         int 			= 0,
	@i_cliente           int 			= null,
	@i_verificar_blq     char (1) 		= 'S',
	@i_activar_cta       char (1) 		= 'N',
	@i_serial            varchar(20) 	= null,
	@i_nomtrn            varchar(10) 	= null,
	@i_referencia        varchar(17) 	= null,
	@i_turno             smallint		= null,
	@i_canal             smallint		= 4,
	@i_cotiz_atm         float 			= null,
	@i_codope_tes        int 			= 0,
	@t_ejec              char(1)		= 'N',
	@i_fecha_valor_a     datetime 		= null,
	@i_sld_caja          money 			= 0,
	@i_idcierre          int 			= 0,
	@i_filial            smallint 		= 1,
	@i_idcaja            int 			= 0,
	@i_stand_in          char(1) 		= 'N',
	@i_is_batch          char(1) 		= 'N',
	@i_cheque            int 			= null,
	@i_concepto          varchar(40) 	= null,
	@i_cau_comi          char(3) 		= null,
	@i_cobiva            char(1) 		= 'N',
	@i_clase_clte        char(1) 		= 'P',
	@i_valida_saldo      char(1) 		= 'S',
	@i_alt_corr          int 			= null,
	@i_titular_prods     int 			= null,
	@i_titularidad_prods char(1) 		= null,
	@i_reintegro         char(1) 		= 'N',
	@i_posteo            char(1) 		= 'S',
	@i_tran_ext          char(1) 		= 'N',--CAV Valida que la transaccion sea por WS
	@i_corresponsal      char(1) 		= 'N',

	--Req. 381 CB Red Posicionada CAV 15/01/2014    
	@o_monto_imp         money 			= 0 out,
	@o_saldo_para_girar  money 			= null out,
	@o_ssn               int 			= null out,
	@o_tipocta_super     char(1) 		= null out,
	@o_val_2x1000        money 			= 0 out,
	@o_valiva            money 			= null out
)
as
declare
	@w_return             int,
    @w_cuenta             int,
    @w_sp_name            varchar(30),
    @w_oficial            smallint,
    @w_filial_p           smallint,
    @w_oficina_p          smallint,
    @w_tipo_promedio      char(1),
    @w_alicuota           float,
    @w_alic_int           float,
    @w_interes            float,
    @w_sec                int,
    @w_lp_sec             int,
    @w_control            int,
    @w_debitos            money,
    @w_mov_deb            money,
    @w_creditos           money,
    @w_mov_cre            money,
    @w_alic               money,
    @w_disponible         money,
    @w_val                money,
    @w_promedio1          money,
    @w_mon                tinyint,
    @w_suspensos          smallint,
    @w_valor              money,
    @w_val_efe            money,
    @w_acum               money,
    @w_numdeci            tinyint,
    @w_numdeci_imp        tinyint,
    @w_contador           smallint,
    @w_lineas             smallint,
    @w_secuencial         int,
    @w_mensaje            mensaje,
    @w_tipo_bloqueo       varchar(3),
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_tipo_int           char(1),
    @w_categoria          char(1),
    @w_clase_clte         char(1),
    @w_capitalizacion     char(1),
    @w_tfactor            smallint,
    @w_trn_sus            smallint,
    @w_trn                smallint,
    @w_signo              char(1),
    @w_tipo1              char(1),
    @w_nemo               char(4),
    @w_nemo2              char(4),
    @w_accion             char(1),
    @w_usadeci            char(1),
    @w_debhoy             money,
    @w_credhoy            money,
    @w_prom_disp          money,
    @w_causa_vs           int,
    @w_causa_vs_c         varchar(3),
    @w_estado             char(1),
    @w_prod_banc          smallint,
    @w_tipo_exonerado_imp char(2),
    @w_monto_imp          money,
    @w_monto_dev          money,
    @w_tasa_imp           float,
    @w_corr               char(1),
    @w_val2               money,
    @w_sus_flag           tinyint,
    @w_flag               tinyint,
    @w_val_mon            money,
    @w_disp2              money,
    @w_cont2              money,
    @w_monto_imp_atm      money,
    @w_val_efe_atm        money,
    @w_val_atm            money,
    @w_val2_atm           money,
    @w_val_mon_atm        money,
    @w_est                varchar(3),
    @w_funcionario        varchar(10),
    @w_nemonico           varchar(4),
    @w_num_trans          int,
    @w_comision           money,
    @w_causa_atm          varchar(3),
    @w_contador_trx       int,
    @w_12h                money,
    @w_24h                money,
    @w_48h                money,
    @w_remesas            money,
    @w_monto_blq          money,
    @w_monto_consumos     money,
    @w_valor1             money,
    @w_valor2             money,
    @w_fecha_sistema      datetime,
    @w_act_fecha          char(1),
    @w_fecha_ult_mov      datetime,
    @w_fecha_ult_mov_int  datetime,
    @w_saldo_cero         char(1),
    @w_concepto           varchar(40),
    @w_producto           tinyint,
    @w_codigo_pais        catalogo,
    @w_val_2x1000         money,
    @w_acumu_deb          money,
    @w_actualiza          char(1),
    @w_base_gmf           money,
    @w_concep_exc         smallint,
    @w_com_iva            char(1),
    @w_imp_gmf            char(1),
    @w_cliente            int,
    @w_iva_dev            money,
    @o_exento             char(1),
    @o_base               money,
    @o_porcentaje         float,
    @w_impuesto           money,
    @w_timpuesto          float,
    @w_piva               float,
    @w_val_total          money,
    @w_concto_iva         char(4),
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_numdeb             int,
    @w_ndebmes            int,
    @w_ncredmes           int,
    @w_numtot             int,
    @w_numero             int,
    @w_numcre             int,
    @w_numco              int,
    @w_tipo               char(1),
    @w_tipocta            char(1),
    @w_rol_ente           char(1),
    @w_cobro_comision     money,
    @w_tipo_def           char(1),
    @w_codigo             int,
    @w_personaliza        char(1),
    /** Validacion saldo Maximo ***/
    @w_saldo_max          money,
    @w_tipocobro          char(1),
    @w_rowcount           int,
    @w_cauemb             varchar(10),
    @w_debug              char(1),
    @w_monblq             char(1),
    @w_tabla              char(30),
    @w_error              int,
    @w_total_val_imp      money,
    @w_tasa_gmf           float,
    @w_fecha_trn          datetime,
    @w_his                char(1),
    @w_cau_his            varchar(10),
    @w_monto_imp_his      money,
    @w_iva_dev_his        money,
    @w_signo_his          char(1),
    @w_corr_his           char(1),
    @w_tfactor_his        smallint,
    @w_tabla_his          char(30),
    @w_concepto_his       varchar(40),
    @w_sev                tinyint,
    @w_posteo             char(1),
    @w_pro_final          smallint,
    @w_sucursal           smallint,
    @w_ah_ctitularidad    char(1),
    @w_login_ope          varchar(10),
    @w_tasa_reintegro     float,
    @w_gmf_reintegro      money,
    @w_saldomin           char(1),
    @w_prodbanc           int,
    @w_trancount          int,
    @w_rollback           char(1)

select @w_sp_name = 'sp_ahmensual'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
	print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
	return 0
end

if @i_alt_corr is null
	select @i_alt_corr = @i_alt

/*  Captura nombre de Stored Procedure  */
select
	@w_sp_name 	= 'sp_ahndc_automatica',
	@o_ssn 		= @s_ssn,
	@o_monto_imp = 0,
	@w_rowcount = 0,
	@w_sev 		= 1,
	@w_rollback = 'N'

/* Lectura para login operador batch*/
select @w_login_ope = pa_char
	from cobis..cl_parametro
	where pa_nemonico = 'LOB'
	and pa_producto = 'ADM'

if (@s_user is null or @s_user = 'sa')
	select @s_user = @w_login_ope

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prodbanc = isnull(pa_smallint, 0)
	from cobis..cl_parametro
	where pa_nemonico = 'PBCB'
	and pa_producto = 'AHO'
	
if @@rowcount = 0
begin
	select  @w_error = 101190,
			@w_sev = 0
	goto ERROR
end

select @w_debug = 'N'

if @w_debug = 'S' and @i_tran_ext = 'N'
begin
    print '@i_cta: ' + @i_cta + ' @i_val: ' + cast (@i_val as varchar) + ' @i_cau: ' + @i_cau + ' @i_alt ' + cast(@i_alt as varchar)
end

-- Captura de fecha del sistema           -- mgt
select @w_fecha_sistema = getdate() -- mgt

/* Error en codigo de transaccion */
if @t_trn not in (253, 264)
begin
	select 	@w_error = 201048,
			@w_sev = 0
	goto ERROR
end

-- Fijar valor del concepto (detalle para el estado de cuenta)
if (@i_referencia is not null)
	select @w_concepto = @i_referencia
else
    select @w_concepto = @i_concepto

select @s_ssn_branch = isnull(@s_ssn_branch, @s_ssn)

/* LBM -- Colocarle el valor default a la variable @w_act_fecha */
select @w_act_fecha = 'S'

if @i_turno is null
	select @i_turno = @s_rol

/* Si la transaccion es NC automatica, grabar NC */
if @t_trn = 319
	select @t_trn = 253

/* Si la transaccion es ND automatica, grabar ND */
if @t_trn = 320
	select @t_trn = 264

select @w_codigo_pais = pa_char
	from cobis..cl_parametro
	where pa_nemonico = 'ABPAIS'
	and pa_producto = 'ADM'

if @@rowcount = 0
begin
	select 	@w_error = 101190,
			@w_sev = 0
	goto ERROR
end

if @w_codigo_pais = 'CO' and @t_trn = 264
	select @w_cauemb = pa_char
		from cobis..cl_parametro
		where pa_producto = 'AHO'
		and pa_nemonico = 'NDAHO'
else
    select @w_cauemb = '0'

/* Transaccion con Valor cero */
if @i_val = 0
begin
	if (@t_trn = 264 and @i_cau <> @w_cauemb) or @t_trn = 253
	begin
		select 	@w_error = 251068,
				@w_sev = 0
		goto ERROR
	end
end

if @i_atm_server = 'S'
begin
    if @i_srvorg in ('FX11NAC', 'FX11INT')
		select  @w_comision = @i_comision,
				@w_causa_atm = @i_cau_comi
    else
    begin
		/* Obtencion de datos del ente propietario de la cuenta */
		select @w_funcionario = p_tipo_persona
			from cobis..cl_ente
			where en_ente = @i_cliente

		if @@rowcount = 0
		begin
			/* No existe ente o cedula incorrecta */
			select 	@w_error = 101042,
					@w_sev = 0
			goto ERROR
		end

		/* Obtener el parametro de numero de transacciones exoneradas al mes */
		if @w_funcionario = 'F'
			select @w_nemonico = 'NTE'
		else
			select @w_nemonico = 'NTC'

		select @w_num_trans = pa_int
			from cobis..cl_parametro
			where pa_nemonico = @w_nemonico
			and pa_producto = 'ATM'

		if @@rowcount <> 1
			select @w_num_trans = -1

		if @i_num_trans >= @w_num_trans
			select @w_comision = @i_comision
		else
			select @w_comision = 0

		select @w_causa_atm = '141'
    end

    if @w_comision > 0
    begin
		if not exists (select 1
							from cobis..cl_catalogo
							where tabla in (select codigo
												from cobis..cl_tabla
												where tabla in ('ah_causa_nd'))
                            and codigo = @w_causa_atm)
		begin
			select  @w_error = 201030,
					@w_sev = 0
			goto ERROR
		end
    end
end

if @t_trn = 253
begin
    /* Determina factor para hacer credito o debito */
    if @t_corr = 'N'
		select 	@w_tfactor = 1,
				@w_tipo1 = '1',
				@w_signo = 'C'
	else
		select 	@w_tfactor = -1,
				@w_tipo1 = '1',
				@w_signo = 'D'
    
	select @w_tabla = 'ah_causa_nc'
end
else
begin
	if @t_corr = 'N'
		select 	@w_tfactor = 1,
				@w_tipo1 = '2',
				@w_signo = 'D'
    else
		select  @w_tfactor = -1,
				@w_tipo1 = '2',
				@w_signo = 'C'

	select @w_tabla = 'ah_causa_nd'
end

--VALIDACION TRANSACCIONES HISTORICAS 
if @t_corr = 'S'
begin
    exec @w_return = sp_val_trnhis
		@i_trn        = @t_trn,
		@i_ssn_corr   = @t_ssn_corr,
		@i_cta        = @i_cta,
		@i_val        = @i_val,
		@i_cau        = @i_cau,
		@i_mon        = @i_mon,
		@i_alt        = @i_alt_corr,
		@i_atm_server = @i_atm_server,
		@o_trn        = @w_trn out,
		@o_fecha_trn  = @w_fecha_trn out,
		@o_monto_imp  = @w_monto_imp_his out,
		@o_iva        = @w_iva_dev_his out,
		@o_valor      = @w_valor out,
		--@o_base_gmf          = @w_base_gmf      out,
		@o_signo      = @w_signo_his out,
		@o_his        = @w_his out,
		@o_cau        = @w_cau_his out,
		@o_corr       = @w_corr_his out,
		@o_factor     = @w_tfactor_his out,
		@o_tabla      = @w_tabla_his out,
		@o_concepto   = @w_concepto_his out

    if @w_return <> 0
    begin
		if @w_debug = 'S' and @i_tran_ext = 'N'
		begin
			print 'ERROR BUSCANDO TRN HISTORICA'
			print '@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
			print '@i_cta ' + @i_cta + ' @i_cau ' + @i_cau + ' @i_mon ' + cast(@i_mon as varchar)
			print '@i_val ' + cast(@i_val as varchar)
		end
		
		select 	@w_error = @w_return,
				@w_sev = 0
		goto ERROR
    end
    else
    begin
		if @w_debug = 'S' and @i_tran_ext = 'N'
		begin
			print 'DATOS TRN HISTORICA'
			select 	@w_fecha_trn, @w_monto_imp_his, @w_iva_dev_his, @w_valor,
					@w_signo_his, @t_trn, @w_cau_his, @w_corr_his
			
			select @w_tfactor_his, @w_tabla_his, @w_concepto_his--, @w_base_gmf  
		end
    end

    if @w_his = 'S'
    begin
		select 	@t_trn 		= @w_trn,
				@t_corr 	= @w_corr_his,
				@i_val 		= @w_valor,
				@i_cau 		= @w_cau_his,
				@w_monto_imp= @w_monto_imp_his,
				@w_iva_dev 	= @w_iva_dev_his,
				@w_signo 	= @w_signo_his,
				@w_corr 	= @w_corr_his,
				@w_tfactor 	= @w_tfactor_his,
				@w_tabla 	= @w_tabla_his,
				@w_concepto = @w_concepto_his,
				@o_monto_imp= @w_monto_imp_his
    end
end
else
	select @w_his = 'N'

if @t_corr = 'S' or @w_his = 'S'
	select @i_valida_saldo = 'N'

if @w_debug = 'S' and @i_tran_ext = 'N'
begin
	print '@w_monto_imp: ' + cast (@w_monto_imp as varchar)
	print '@w_iva_dev  : ' + cast (@w_iva_dev as varchar)
	print '@w_signo    : ' + cast (@w_signo as varchar)
	print '@w_corr     : ' + cast (@w_corr as varchar)
	print '@w_tfactor  : ' + cast (@w_tfactor as varchar)
	print '@w_tabla    : ' + cast (@w_tabla as varchar)
	print '@w_concepto : ' + cast (@w_concepto as varchar)
	print '@o_monto_imp: ' + cast (@o_monto_imp as varchar)
end

if @t_corr = 'S'
begin
    if @t_trn = 264
    begin
		select 	@w_val_mon = $0,
				@w_val = $0,
				@w_iva_dev = $0

		select 	@w_monto_dev = isnull(tm_monto_imp, 0),
				@w_iva_dev = isnull(tm_valor_comision, 0),
				@w_val_mon = isnull(tm_valor, 0)
			from cob_ahorros..ah_tran_monet
			where isnull(tm_ssn_branch, tm_secuencial) = @t_ssn_corr
			and tm_cod_alterno	= @i_alt_corr
			and tm_tipo_tran	= @t_trn
			and tm_cta_banco	= @i_cta
			and tm_causa		= @i_cau
			and tm_moneda		= @i_mon
			and tm_estado 		is null

		if @w_val_mon is null
			select @w_val_mon = $0
		
		if @w_monto_dev is null
			select @w_monto_dev = $0
		
		if @w_iva_dev is null
			select @w_iva_dev = $0

		if @w_val_mon <> @i_val -- generacion de valores en suspenso
		begin
			select @w_val = isnull(ts_valor, 0)
				from cob_ahorros..ah_tran_servicio
				where isnull(ts_ssn_branch, ts_secuencial) = @t_ssn_corr
				and ts_cod_alterno		= @i_alt_corr
				and ts_tipo_transaccion	= 258
				and ts_cta_banco		= @i_cta
				and ts_causa			= @i_cau
				and ts_moneda			= @i_mon

			if @w_val is null
				select @w_val = $0
		end
		
		if (@w_val_mon + @w_val) <> @i_val
		begin
			if @w_debug = 'S' and @i_tran_ext = 'N'
			begin
				print '0. @t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt ' + cast(@i_alt as varchar)
				print '@s_user ' + @s_user + ' @i_cta ' + @i_cta + ' @i_cau ' + @i_cau
				print '@i_mon ' + cast(@i_mon as varchar) + ' @w_val_mon ' + cast(@w_val_mon as varchar)
				print '@w_val ' + cast(@w_val as varchar) + ' @i_val ' + cast(@i_val as varchar)
			end
		
			select 	@w_error = 251067,
					@w_sev = 0
			goto ERROR
		end

		if @i_atm_server = 'S' and @w_comision > 0
		begin
			select 	@w_valor1 = $0,
					@w_valor2 = $0

			select 	@w_monto_imp_atm = isnull(tm_monto_imp, 0),
					@w_valor1 = isnull(tm_valor, 0)
				from cob_ahorros..ah_tran_monet
				where isnull(tm_ssn_branch, tm_secuencial) = @t_ssn_corr
				and tm_cod_alterno	= @i_alt_corr + 1
				and tm_tipo_tran    = @t_trn
				and tm_cta_banco    = @i_cta
				and tm_causa        = @w_causa_atm
				and tm_moneda		= @i_mon
				and tm_estado 		is null

			if @w_valor1 is null
				select @w_valor1 = $0
			
			if @w_monto_imp_atm is null
				select @w_monto_imp_atm = $0

			if @w_valor1 <> @w_comision
			begin
				select @w_valor2 = isnull(ts_valor, 0)
					from cob_ahorros..ah_tran_servicio
					where isnull(ts_ssn_branch, ts_secuencial) = @t_ssn_corr
					and ts_cod_alterno		= @i_alt_corr + 1
					and ts_tipo_transaccion	= 258
					and ts_cta_banco		= @i_cta
					and ts_causa			= @w_causa_atm
					and ts_moneda			= @i_mon

				if @w_valor2 is null
					select @w_valor2 = $0
			end
	
			if (@w_valor1 + @w_valor2) <> @w_comision
			begin
				if @w_debug = 'S' and @i_tran_ext = 'N'
				begin
					print '2.@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
					print '@s_user ' + @s_user + ' @i_cta ' + @i_cta + ' @w_causa_atm ' + @w_causa_atm
					print '@i_mon ' + cast(@i_mon as varchar) + ' @w_valor1 ' + cast(@w_valor1 as varchar)
					print '@w_valor2 ' + cast(@w_valor2 as varchar) + ' @i_val ' + cast(@i_val as varchar)
				end
				
				select 	@w_error = 251067,
						@w_sev = 0
				goto ERROR
			end
		end
	end
    
	if @t_trn = 253
    begin
		if @w_his = 'S'
		begin
			select @w_monto_dev = tm_monto_imp
				from cob_ahorros..ah_tran_monet
				where isnull(tm_ssn_branch, tm_secuencial) = @t_ssn_corr
				and tm_cod_alterno	= @i_alt_corr
				and tm_tipo_tran	= @t_trn
				and tm_cta_banco	= @i_cta
				and tm_causa		= @i_cau
				and tm_moneda		= @i_mon
				and tm_valor		= @i_val
				--and tm_usuario       = @s_user --PCOELLO ATM ENVIA USUARIOS DIFERENTES DEPENDIENDO DEL APL SERVER
				and tm_estado 		is null
				
			if @@rowcount <> 1
			begin
				if @w_debug = 'S' and @i_tran_ext = 'N'
				begin
					print '3.@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
					print '@s_user ' + @s_user + ' @i_cta ' + @i_cta + ' @i_cau ' + @i_cau
					print '@i_mon ' + cast(@i_mon as varchar) + ' @i_val ' + cast(@i_val as varchar)
					--print '3 @t_ssn_corr '  @i_alt %2! @s_user %3! @i_cta %4! @i_cau %5! @i_mon %6! @i_val %7!' , @t_ssn_corr, @i_alt, @s_user, @i_cta, @i_cau, @i_mon, @i_val
				end
				
				select 	@w_error = 251067, 
						@w_sev = 0
				goto ERROR
			end
		end
	end
end

/* Determinar si el cobro del valor en suspenso es por segunda vez */
/* ya que asi no se contabiliza                                    */
if @i_cobsus = 'N'
    select @w_trn_sus = 258
else
    select @w_trn_sus = 259

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
	from cobis..cl_moneda
	where mo_moneda = @i_mon

if @w_usadeci = 'S'
begin
	select @w_numdeci = pa_tinyint
		from cobis..cl_parametro
		where pa_nemonico = 'DCI'
		and pa_producto = 'AHO'

    select @w_numdeci_imp = pa_tinyint
		from cobis..cl_parametro
		where pa_nemonico = 'DIM'
		and pa_producto = 'AHO'
end
else
	select 	@w_numdeci = 0,
			@w_numdeci_imp = 0

if @i_cobsus = 'S' /* Cuando es cobro de valores en suspenso */
begin
    select @w_causa_vs = convert(int, @i_cau)
    select @w_causa_vs_c = @i_cau
end
else
	select @w_causa_vs_c = @i_cau

if not exists (select 1
					from cobis..cl_catalogo
					where tabla in (select codigo
										from cobis..cl_tabla
										where tabla = @w_tabla)
					and codigo = @w_causa_vs_c)
begin
    if @w_debug = 'S' and @i_tran_ext = 'N'
		print '@w_tabla: ' + @w_tabla + ' @w_causa_vs_c ' + @w_causa_vs_c
    select 	@w_error = 201030,
			@w_sev = 0
    goto ERROR
end

if @w_tfactor = 1 and @i_imp = 'S' and @t_trn = 264
begin
    /* Busqueda de la tasa del impuesto ya que es un debito a la cuenta*/
    select @w_tasa_imp = pa_float
		from cobis..cl_parametro
		where pa_producto = 'ADM'
		and pa_nemonico = 'TIDB'

    if @@rowcount <> 1
    begin
		select 	@w_error = 201196,
				@w_sev = 0
		goto ERROR
    end
end
else
    select @w_tasa_imp = 0.0

/* Determina el nemonico de la transaccion */
select @w_nemo = tn_nemonico
	from cobis..cl_ttransaccion
	where tn_trn_code = @t_trn

select @w_nemo2 = 'IDB'

select 	@w_cuenta 			= ah_cuenta,
		@w_estado 			= ah_estado,
		@w_filial_p 		= ah_filial,
		@w_oficina_p 		= ah_oficina,
		@w_tipo_promedio 	= ah_tipo_promedio,
		@w_oficial 			= ah_oficial,
		@w_mon 				= ah_moneda,
		@w_cliente 			= ah_cliente,
		@w_disponible 		= round(ah_disponible, @w_numdeci),
		@w_12h 				= ah_12h,
		@w_24h 				= ah_24h,
		@w_48h 				= ah_48h,
		@w_remesas 			= ah_remesas,
		@w_monto_blq 		= ah_monto_bloq,
		@w_suspensos 		= ah_suspensos,
		@w_categoria 		= ah_categoria,
		@w_promedio1 		= ah_promedio1,
		@w_debitos 			= round(ah_debitos, @w_numdeci),
		@w_creditos 		= round(ah_creditos, @w_numdeci),
		@w_capitalizacion 	= ah_capitalizacion,
		@w_lineas 			= ah_linea,
		@w_debhoy 			= round(ah_debitos_hoy, @w_numdeci),
		@w_credhoy 			= round(ah_creditos_hoy, @w_numdeci),
		@w_prom_disp 		= ah_prom_disponible,
		@w_prod_banc 		= ah_prod_banc,
		@w_producto 		= ah_producto,
		@w_monto_imp 		= ah_monto_imp,
		@w_contador_trx 	= ah_contador_trx,
		@w_monto_consumos 	= ah_monto_consumos,
		@w_fecha_ult_mov 	= ah_fecha_ult_mov,--LBM       
		@w_fecha_ult_mov_int= ah_fecha_ult_mov_int,
		@o_tipocta_super 	= ah_tipocta_super,
		/*FRC-AHO-017-CobroComisiones CMU 2102110*/
		@w_ndebmes 			= isnull(ah_num_deb_mes, 0),
		@w_ncredmes 		= isnull(ah_num_cred_mes, 0),
		@w_tipocta 			= ah_tipocta,
		@w_clase_clte 		= ah_clase_clte,
		@w_rol_ente 		= ah_rol_ente,
		@w_tipo_def 		= ah_tipo_def,
		@w_codigo 			= ah_default,
		@w_personaliza 		= ah_personalizada,
		@w_tipo 			= ah_tipo,
		@w_ah_ctitularidad 	= ah_ctitularidad
	from cob_ahorros..ah_cuenta
	where ah_cta_banco 	= @i_cta
	and ah_moneda    	= @i_mon

if @@rowcount = 0
begin
	select 	@w_error = 251001,
			@w_sev = 0
	goto ERROR
end

if @w_estado = 'C'
begin
	select  @w_error = 251057,
			@w_sev = 0
	goto ERROR
end

/* EXTRAER TOPES PARA EL TIPO DE PRODUCTO  REQ 412*/
if @t_corr = 'N'
begin
	-- [DS 16-05-2014] Limites transaccionales  -- Req 412  
	exec @w_return = cob_remesas..sp_valida_limites_canal
		@s_ofi       = @s_ofi,
		@i_cta       = @i_cta,
		@i_tipo_prod = @w_producto,
		@i_fecha     = @i_fecha,
		@i_trn       = @t_trn,
		@i_val       = @i_val,
		@i_causal    = @i_cau,
		@o_msg       = @w_mensaje out

    if @w_return <> 0 and @i_tran_ext = 'N'
    begin
		exec cobis..sp_cerror
			@t_from = @w_sp_name,
			@i_msg  = @w_mensaje,
			@i_num  = @w_return,
			@i_sev  = 0

		return @w_return
	end
	else
	begin
		if @w_return <> 0 and @i_tran_ext = 'S'
			return @w_return
	end
end

/* FIN -EXTRAER TOPES PARA EL TIPO DE PRODUCTO */
/* REQ 306 DEPOSITO INICIAL APERTURA AHO */
exec @w_return = cob_ahorros..sp_ah_trn_depo_inicial
	@t_file       = @t_file,
	@t_debug      = @t_debug,
	@i_correccion = @t_corr,
	@t_trn        = @t_trn,
	@i_ssn_branch = @s_ssn_branch,--SECUENCIAL BRANCH
	@i_ssn_corr   = @t_ssn_corr,--SECUENCIAL TRN REVERSADA
	@i_cta_banco  = @i_cta,
	@i_causal     = @i_cau,
	@i_moneda     = 0,
	@i_estado     = @w_estado,
	@i_oficina    = @w_oficina_p

if @w_return <> 0
begin
	select 	@w_error = 251101,
			@w_sev = 0
	goto ERROR
end
  
/* FIN - REQ 306 DEPOSITO INICIAL APERTURA AHO */
if @i_inmovi = 'N' and @w_estado = 'I'
begin
	if @i_is_batch = 'N'
    begin
		if @i_nomtrn is null
			if @i_activar_cta = 'N'
			begin
				/*  Cuenta de ahorros inmovilizada */
				if @i_tran_ext = 'N'
				begin
					exec cobis..sp_cerror
						@t_from = @w_sp_name,
						@i_num  = 251058
				end
			else
				return 251058
	end
	else
	begin
		exec @w_return = sp_tr_reactivacion_ah
			@s_ssn        = @s_ssn,
			@s_ssn_branch = @s_ssn_branch,
			@s_srv        = @s_srv,
			@s_lsrv       = @s_srv,
			@s_user       = @s_user,
			@s_sesn       = 1,
			@s_term       = @s_term,
			@s_date       = @i_fecha,
			@s_ofi        = @s_ofi,/* Localidad origen transaccion */
			@s_org        = @s_org,
			@t_debug      = @t_debug,
			@t_trn        = 203,
			@i_cta        = @i_cta,
			@i_mon        = @i_mon

		if @w_return <> 0
			return @w_return
	end
	else
		rollback tran @i_nomtrn
end

if @i_activar_cta = 'N'
	return 251058
end

if @w_cauemb = @i_cau and @t_trn = 264
	select @w_monblq = 'N'
else
	select @w_monblq = 'S'

if @w_debug = 'S' and @i_tran_ext = 'N'
	print '@w_monblq: ' + @w_monblq + ' @i_cau ' + @i_cau + ' @w_cauemb ' + cast(@w_cauemb as varchar)

if @t_trn = 264
begin
    /*** REQ 371 ***/
    select @w_saldomin = isnull(an_saldomin, 'S')
		from cob_remesas..re_accion_nd
		where an_producto 	= 4
		and an_causa    	= @i_cau

    if @@rowcount = 0
    begin
		if @i_tran_ext = 'N'
		begin
			exec cobis..sp_cerror
				@t_from = @w_sp_name,
				@i_num  = 251125
		end
		else
			return 251125
	end
end
else
	select @w_saldomin = 'S'

if @t_corr = 'N'
	select @i_valida_saldo = @w_saldomin
else
	select @i_valida_saldo = 'N'

/* Calcular el saldo */
if @w_prodbanc = @w_prod_banc --Evaluar si el producto es CB
	select @i_corresponsal = 'S'

exec @w_return = cob_ahorros..sp_ahcalcula_saldo
	@t_from             = @w_sp_name,
	@i_cuenta           = @w_cuenta,
	@i_fecha            = @i_fecha,
	@i_valida_saldo     = @i_valida_saldo,
	@i_monblq           = @w_monblq,
	@i_monto_trn        = @i_val,
	--REQ 381 Envio de monto para validación de cupo Cuenta Corresponsalia
	@i_trn              = @t_trn,
	--ORS 949 Envio de transaccion para validación de cupo Cuenta Corresponsalia
	@i_corresponsal     = @i_corresponsal,
	@i_tran_ext         = @i_tran_ext,
	@i_is_batch         = @i_is_batch,
	--ORS 949 Envio de variable batch para validación de cupo Cuenta Corresponsalia
	@o_saldo_para_girar = @w_saldo_para_girar out,
	@o_saldo_contable   = @w_saldo_contable out,
	@o_saldo_max        = @w_saldo_max out
	/* Recibimos  el saldo Maximo para la cuenta */
  
if @w_return <> 0
	return @w_return

if @w_debug = 'S' and @i_tran_ext = 'N'
	print '@w_saldo_para_girar: ' + cast(@w_saldo_para_girar as varchar)

/*LBM -- Verificamos la tabla re_propiedad_ndc para establecer si se afecta la fecha de ultimo movimiento */
select @w_act_fecha = pr_act_fecha
	from cob_remesas..re_propiedad_ndc
	where pr_producto 	= 4
	and pr_signo    	= @w_signo
	and pr_causa    	= @i_cau

if @@rowcount = 0
    select @w_act_fecha = 'S'

if @i_change_ofi = 'S'
    select @s_ofi = @w_oficina_p

/*  Determinacion de bloqueo de cuenta  */
if @i_verificar_blq = 'S'
begin
    select @w_tipo_bloqueo = cb_tipo_bloqueo
		from cob_ahorros..ah_ctabloqueada
		where cb_cuenta	= @w_cuenta
		and cb_estado	= 'V'
		and (cb_tipo_bloqueo = @w_tipo1 or cb_tipo_bloqueo = '3')

    if @@rowcount <> 0
    begin
		if @i_is_batch = 'N'
		begin
			if @i_nomtrn is null
			begin
				select @w_mensaje = rtrim(valor)
					from cobis..cl_catalogo
					where tabla  = (select codigo
									from cobis..cl_tabla
									where tabla = 'ah_tbloqueo')
					and codigo = @w_tipo_bloqueo

				select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
				
				if @i_tran_ext = 'N'
				begin
					exec cobis..sp_cerror
						@t_from = @w_sp_name,
						@i_num  = 201008,
						@i_sev  = 1,
						@i_msg  = @w_mensaje
				end
				else
					return 201008
			end
			else
				rollback tran @i_nomtrn
		end
		return 201008
	end
end

/* LBM -- verificar si se debe actualizar el campo con la causal */
if @w_act_fecha = 'S'
    select @w_fecha_ult_mov = @i_fecha

/* Instancia la variable para devolver siempre un saldo */
select @o_saldo_para_girar = @w_saldo_para_girar

if (@w_tasa_imp > 0 and @w_tfactor = 1)
begin
    /* Verificar que la cuenta este exonerada */
    select @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
		from cob_remesas..re_exoneracion_impuesto
		where ei_producto 	=	'AHO'
		and ei_cuenta   	= @w_cuenta

    if @@rowcount = 1
		select @w_tasa_imp = 0.0
end

if @w_tfactor = 1
begin
	if @w_tasa_imp > 0 or @i_devolucion_imp > 0
	begin
		if @i_devolucion_imp > 0
			select @o_monto_imp = @i_devolucion_imp
		else
		begin
			select @o_monto_imp = round((@i_val * @w_tasa_imp), @w_numdeci_imp)
			
			if @w_comision > 0
				select @w_monto_imp_atm = round((@w_comision * @w_tasa_imp), @w_numdeci_imp)
			else
				select @w_monto_imp_atm = 0
		end
	end
	else
		select 	@o_monto_imp = 0,
				@w_monto_imp_atm = 0
end
else
    select @o_monto_imp = @w_monto_dev

/* CALCULO IMPUESTO NX1000 */

select 	@o_valiva = 0,
		@w_impuesto = 0

if @w_codigo_pais = 'CO' and @t_trn <> 253 -- Colombia
begin
	if @t_trn = 264
    begin
		select 	@w_com_iva = an_comision,
				@w_imp_gmf = an_impuesto,
				@w_accion = an_accion
			from cob_remesas..re_accion_nd
			where an_producto 	= 4
			and an_causa    	= @i_cau

		select @w_rowcount = @@rowcount

		if @w_rowcount = 0
		begin
			select	@w_impuesto 	= 0,
					@w_timpuesto 	= 0,
					@o_valiva 		= 0,
					@w_accion 		= 'E',
					@w_imp_gmf 		= 'N',
					@w_com_iva 		= 'N'
		end
	end
	else
		select 	@w_imp_gmf = 'S',
				@w_com_iva = 'N'

	if isnull(@t_corr, 'N') = 'N'
	begin--1
		select @w_val_2x1000 = $0

		if @w_saldo_para_girar <= 0
			select @w_valor = @i_val
		else
			select @w_valor = @w_saldo_para_girar

		-- Revisa si cobra el impuesto de IVA
		if @i_cobiva = 'S'
		begin--2
			if @w_rowcount = 0
				select @w_accion = 'V'

			if @w_com_iva = 'S'
			begin--3
				select @w_concto_iva = ci_concepto
					from cob_remesas..re_concepto_imp
					where ci_tran     = @t_trn
					and ci_causal   = @i_cau
					and ci_impuesto = 'V'

				if @@rowcount = 0
				begin
					print '@i_cau: ' + @i_cau + ' @t_trn' + cast(@t_trn as varchar)
					select	@w_error = 201232,
							@w_sev = 0
					goto ERROR
				end

				exec @w_return = cob_interfase..sp_icon_impuestos
					@i_empresa      = 1,
					@i_concepto     = @w_concto_iva,
					@i_debcred      = 'C',
					@i_monto        = @i_comision,
					@i_impuesto     = 'V',
					@i_oforig_admin = @s_ofi,
					@i_ofdest_admin = @w_oficina_p,
					@i_ente         = @w_cliente,
					@i_producto     = 4,
					@o_exento       = @o_exento out,
					@o_porcentaje   = @o_porcentaje out

				if @w_return <> 0
				begin
					rollback tran @i_nomtrn
					return @w_return
				end

				if @o_exento = 'N'
					select @w_piva = @o_porcentaje
				else
					select @w_piva = 0

				select @w_impuesto = round((@i_val * @w_piva / 100), @w_numdeci_imp)

				if @t_trn = 264 and (@i_val + @w_impuesto) > @w_saldo_para_girar
				begin
					select 	@w_valor = @w_saldo_para_girar
					select 	@w_piva = @w_piva / 100
					select 	@w_valor = @w_valor / (1 + @w_piva)
					select 	@w_impuesto = round((@w_valor * @w_piva), @w_numdeci_imp)
				end
				else
					select 	@w_timpuesto = @w_piva,
							@o_valiva = @w_impuesto
			end --3

			if @t_trn = 264
				if @t_corr = 'S'
					select @w_val_efe = isnull(@i_val, 0) - (isnull(@i_comision, 0) + isnull(@w_impuesto, 0))
				else if @i_val > @w_saldo_para_girar
					select 	@w_val_efe = isnull(@w_valor, 0) + (isnull(@i_comision, 0) + isnull(@w_impuesto, 0)), 
							@w_total_val_imp = @w_valor + @w_impuesto
				else
					select 	@w_val_efe = isnull(@i_val, 0) + (isnull(@i_comision, 0) + isnull(@w_impuesto, 0 )),
							@w_total_val_imp = @i_val + @w_impuesto

			select 	@w_val = $0,
					@w_val_total = @w_val_efe
		end--2
		else --   @i_cobiva = 'S'
			select 	@o_valiva = 0,
					@w_impuesto = 0,
					@w_total_val_imp = @i_val,
					@w_piva = 0
	end--1  isnull(@t_corr, 'N') = 'N'
	else
	select 	@w_total_val_imp = @w_val_mon + @w_iva_dev,
			@o_valiva = @w_iva_dev

	-- Si el titular de la cuenta es igial 
	-- al titular del producto que hace el debito 
	-- y son unicos titulares
	if (@i_titular_prods = @w_cliente) and (@i_titularidad_prods = 'I') and (@w_ah_ctitularidad = @i_titularidad_prods)
		select @w_imp_gmf = 'S' -- es exento de gravamen

	if @w_imp_gmf = 'N'
	begin
		--  Llama sp que calcula GMF de acuerdo a concepto exencion
		exec @w_return = sp_calcula_gmf
			@s_user            = @s_user,
			@s_date            = @i_fecha,
			@s_ofi             = @s_ofi,
			@t_trn             = @t_trn,
			@t_ssn_corr        = @t_ssn_corr,
			@i_factor          = @w_tfactor,
			@i_mon             = @i_mon,
			@i_cta             = @i_cta,
			@i_cuenta          = @w_cuenta,
			@i_val             = @w_total_val_imp,--@w_val_total, --@i_val,
			@i_val_tran        = @i_val,
			@i_numdeciimp      = @w_numdeci_imp,
			@i_producto        = @w_producto,
			@i_operacion       = 'Q',
			@i_cliente         = @w_cliente,--JCO
			@o_total_gmf       = @w_val_2x1000 out,
			@o_acumu_deb       = @w_acumu_deb out,
			@o_actualiza       = @w_actualiza out,
			@o_tasa            = @w_tasa_gmf out,
			@o_base_gmf        = @w_base_gmf out,
			@o_concepto        = @w_concep_exc out,
			@o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
			@o_valor_reintegro = @w_gmf_reintegro out -- JCO 

		if @w_return <> 0
			return @w_return
			-- Calculo valor total de impuestos

		if @w_tfactor = 1
		begin
			if @t_trn = 264 and ((@i_val + @w_impuesto + @w_val_2x1000) > @w_saldo_para_girar)
			begin
				if @w_impuesto = 0
					select 	@w_valor = @w_saldo_para_girar,
							@w_piva = 0

				select 	@w_valor = @w_valor / (1 + @w_tasa_gmf)
				select 	@w_val_2x1000 = round(((@w_valor + @w_impuesto) * @w_tasa_gmf), @w_numdeci_imp)
				select 	@w_impuesto = @w_valor * @w_piva
				select 	@w_timpuesto = @w_piva,
						@o_valiva = @w_impuesto
			end
			
			select 	@o_monto_imp = isnull(@o_monto_imp, 0) + isnull(@w_val_2x1000, 0) + isnull(@w_impuesto, 0),
					@w_nemo2 = 'GMF'
		end
		else
			select @o_valiva = @w_iva_dev

	end -- @w_imp_gmf = 'N'
	else if @t_corr = 'S'
	begin
		select	@w_val_2x1000 = @w_monto_dev,
				@o_monto_imp = @w_monto_dev,
				@w_impuesto = @w_iva_dev,
				@o_valiva = @w_iva_dev
	end
	else
		select 	@o_monto_imp = 0,
				@w_val_2x1000 = 0

	select @o_val_2x1000 = @w_val_2x1000
end -- @w_codigo_pais = 'CO'

/* Cuando es cobro de valores en suspenso, el contador debe disminuir */
if @i_cobsus = 'S'
    select @w_suspensos = @w_suspensos - 1

/*  Validacion de la moneda */
if @i_mon <> @w_mon
begin
    select	@w_error = 201025,
			@w_sev = 0
    goto ERROR
end

/* Encuentra alicuota del promedio */
select @w_alicuota = fp_alicuota
	from cob_ahorros..ah_fecha_promedio
	where fp_tipo_promedio = @w_tipo_promedio
	and fp_fecha_inicio  = @i_fecha

if @@rowcount = 0
begin
    select @w_error = 251012
    goto ERROR
end

select @w_sucursal = isnull(of_regional, of_oficina)
	from cobis..cl_oficina
	where of_oficina = @w_oficina_p

select @w_pro_final = pf_pro_final
	from cob_remesas..pe_pro_final,
		cob_remesas..pe_mercado
	where pf_mercado	= me_mercado
	and me_tipo_ente    = @w_tipocta
	and me_pro_bancario = @w_prod_banc
	and pf_filial       = @w_filial_p
	and pf_sucursal     = @w_sucursal
	and pf_producto     = @w_producto
	and pf_moneda       = @w_mon
	and pf_tipo         = @w_tipo

if @@rowcount = 0
begin
    --No existe producto final
    select 	@w_error = 351527,
			@w_sev = 0
    goto ERROR
end

select @w_posteo = cp_posteo
	from cob_remesas..pe_categoria_profinal
	where cp_profinal  = @w_pro_final
	and cp_categoria = @w_categoria

if @w_posteo is null
    select @w_posteo = 'N'

if @w_posteo = 'S'
begin
    /* Genera numero de control */
    update cobis..cl_seqnos
			set siguiente = siguiente + 4
		where tabla = 'ah_control'

    select @w_control = siguiente - 3
		from cobis..cl_seqnos
		where tabla = 'ah_control'

    if @w_control > = 9997
    begin
		update cobis..cl_seqnos
				set siguiente = 3
			where tabla = 'ah_control'
		select @w_control = 0
    end

    /*  Genera numero de linea Pendiente  */
    update cobis..cl_seqnos
			set siguiente = siguiente + 4
		where tabla = 'ah_lpendiente'

    select @w_lp_sec = siguiente - 3
		from cobis..cl_seqnos
		where tabla = 'ah_lpendiente'

    if @w_lp_sec > 2147483637
    begin
		update cobis..cl_seqnos
				set siguiente = 4
			where  tabla = 'ah_lpendiente'

		if @@error <> 0
		begin
			select 	@w_error = 105001,
					@w_sev = 0
			goto ERROR
		end
		
		select @w_lp_sec = 1
    end
end

/* Asigna variables de origen de la transaccion */
if @t_trn = 264 and (@o_monto_imp) > @w_saldo_para_girar
    select @w_val_efe = @w_valor
else
    select 	@w_val_efe = @i_val,
			@w_val_efe_atm = isnull(@w_comision, 0)

if @t_corr = 'S'
    select 	@w_corr = 'S',
			@w_est = 'R',
			@w_nemo = 'CORR',
			@w_nemo2 = 'CORR'
else
    select 	@w_corr = 'N',
			@w_est = null

/*FRC-AHO-017-CobroComisiones CMU 2102110*/
if @i_canal <> 4 --no caja
begin
	if @t_trn = 264
		select @w_ndebmes = @w_ndebmes + (1 * @w_tfactor)
    else
		select @w_ncredmes = @w_ncredmes + (1 * @w_tfactor)
end

/* Actualizacion de tabla de cuentas corrientes */
if @@trancount = 0
begin
    begin tran
    select @w_rollback = 'S'
end

if @w_tfactor = 1
begin
    select 	@w_val = $0,
			@w_saldo_cero = 'N'

    /* Validar Fondos para Notas de Debito */
    if @t_trn = 264
    begin
		/* Encuentra accion para la causa de las notas de debito */
		select @w_accion = an_accion
			from cob_remesas..re_accion_nd
			where an_producto = 4
			and an_causa    = @w_causa_vs_c

		if @@rowcount = 0 or @w_accion = 'S'
			select @w_accion = 'E'

		if @i_stand_in = 'S' --LBM
			select 	@w_accion = 'V'

		if (@i_val + @w_impuesto + @w_val_2x1000) > @w_saldo_para_girar and @w_accion = 'V'
		begin
			select @w_suspensos = @w_suspensos + 1
			
			if @w_saldo_para_girar <= 0
				select 	@w_val = @i_val,
						@w_val_efe = $0,
						@o_monto_imp = $0,
						@w_saldo_cero = 'S',
						@w_sus_flag = 2
			else
			begin
				/* pone solo el faltante en valores en suspenso */
				if @w_codigo_pais = 'CO'
					select @w_val2 = @w_valor
				else
					select @w_val2 = round((@w_saldo_para_girar / (1 + @w_tasa_imp)), @w_numdeci)

				--Req 371 CAV 28/02/2014 Se modifica @w_val para que calcule en base al numero de decimales parametrizados
				select  @w_val = round((@i_val - @w_val2), @w_numdeci)
				select  @o_monto_imp = @w_saldo_para_girar - @w_val2
				select	@w_val_efe = @i_val - @w_val,
						@w_sus_flag = 1
			end

			exec @w_return = cobis..sp_cseqnos
				@t_from      = @w_sp_name,
				@i_tabla     = 'ah_val_suspenso',
				@o_siguiente = @w_sec out

			if @w_return <> 0
				return @w_return

			if @w_sec > 2147483640
			begin
				select @w_sec = 1

				update cobis..cl_seqnos
						set siguiente = @w_sec
					where tabla = 'ah_val_suspenso'
			end

			insert into cob_ahorros..ah_val_suspenso
					(vs_cuenta, vs_secuencial, vs_servicio, vs_estado, vs_procesada,
					vs_valor, vs_fecha, vs_oficina, vs_hora, vs_ssn,
					vs_clave, vs_impuesto)
				values
					(@w_cuenta, @w_sec, @i_cau, 'N', 'N',
					@w_val, @i_fecha, @s_ofi, getdate(), @s_ssn_branch,
					0, @i_imp)

			if @@error <> 0
			begin
				select @w_error = 253004
				goto ERROR
			end

			insert into cob_ahorros..ah_tsval_suspenso
					(secuencial, ssn_branch, alterno, tipo_tran, oficina,
					usuario, terminal, correccion, ssn_corr, reentry,
					origen, nodo, fecha, cta_banco, moneda,
					valor, interes, indicador, servicio, remoto_ssn,
					prod_banc, categoria, oficina_cta, accion, tipocta_super,
					turno, serial, tipo_cliente, cliente)
					--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
				values
					(@s_ssn, @s_ssn_branch, @i_alt, @w_trn_sus, @s_ofi,
					@s_user, @s_term, 'N', null, 'N',
					'L', @s_srv, @i_fecha, @i_cta, @i_mon,
					@w_val, null, 1, @i_cau, @s_ssn_branch,
					@w_prod_banc, @w_categoria, @w_oficina_p, 'C', @o_tipocta_super,
					@i_turno, @i_serial, @w_clase_clte, @w_cliente)
				--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente

				if @@error <> 0
				begin
					select @w_error = 253004
					goto ERROR
				end

				if (@i_tran_ext = 'S' or @i_corresponsal = 'S') and exists(select 1
																			from cob_remesas..re_mantenimiento_cb
																			where mc_cod_cb	= @w_oficina_p
																			and @w_trn_sus 	= 258)
				begin
					--Se genera transacción de servicio para disminución 
					insert into cob_ahorros..ah_tran_servicio
							(ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
							ts_usuario, ts_terminal, ts_correccion, ts_ssn_corr,
							ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_cta_banco, ts_moneda,
							ts_valor, ts_interes, ts_indicador, ts_causa, ts_prod_banc,
							ts_categoria, ts_oficina_cta, ts_observacion,
							ts_tipocta_super, ts_clase_clte, ts_cliente,ts_hora)
						values
							(@s_ssn, @s_ssn, 1, 752, @w_oficina_p,
							@s_user, @s_term, 'N', null, 
							'N', 'L', @s_srv, @i_fecha, @i_cta, 0,
							@w_val, null, 1, '50', @w_prod_banc,
							@w_categoria, @w_oficina_p, ('DISMINUCION CUPO CB POSICIONADO ' + cast(@w_oficina_p as varchar)),
							@w_tipocta, @w_clase_clte, @w_cliente, getdate())

				if @@error <> 0
				begin
					select @w_error = 253004
					goto ERROR
				end
			end
		end
		else if (@i_val + @o_monto_imp) > @w_saldo_para_girar and @w_accion = 'E'
		begin /* Cuenta sin fondos */
			select @w_error = 251033
			goto ERROR
		end

		if @w_val_efe > 0
		begin
			if @w_posteo = 'S'
			begin
				select @w_lineas = @w_lineas + 1

				/* Inserta en linea pendiente */
				insert into cob_ahorros..ah_linea_pendiente
						(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
						lp_control, lp_signo, lp_enviada)
					values
						(@w_cuenta, @w_lp_sec, @w_nemo, @w_val_efe, @i_fecha,
						@w_control, @w_signo, 'N')

				if @@error <> 0
				begin
					select @w_error = 251033
					goto ERROR
				end

				if @o_monto_imp > 0
				begin
					/*  Genera numero de linea Pendiente  */
					select @w_lineas = @w_lineas + 1

					insert into cob_ahorros..ah_linea_pendiente
							(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
							lp_control, lp_signo, lp_enviada)
						values
							(@w_cuenta, @w_lp_sec + 1, @w_nemo2, @o_monto_imp, @i_fecha,
							@w_control + 1, 'D', 'N')

					if @@error <> 0
					begin
						select @w_error = 253002
						goto ERROR
					end
				end
			end

			select 	@w_debitos = round((@w_debitos + (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci)
			select 	@w_debhoy = round((@w_debhoy + (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci)
			select 	@w_alic = round((@w_val_efe + @o_monto_imp) * @w_alicuota, @w_numdeci)
			select 	@w_promedio1 = @w_promedio1 - @w_alic * @w_tfactor, 
					@w_prom_disp = @w_prom_disp - @w_alic * @w_tfactor,
					@w_disponible = round((@w_disponible - (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci),
					@w_saldo_contable = round((@w_saldo_contable - (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci),
					@w_saldo_para_girar = round((@w_saldo_para_girar - (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci)
			select @w_monto_imp = @w_monto_imp + (@w_val_2x1000 * @w_tfactor)
		end

		select 	@w_disp2 = round(@w_disponible, @w_numdeci),
				@w_cont2 = round(@w_saldo_contable, @w_numdeci)

		if @i_atm_server = 'S' and @w_comision > 0
		begin
			/* Encuentra accion para la causa de las notas de debito */
			select @w_accion = an_accion
				from cob_remesas..re_accion_nd
				where an_producto = 4
				and an_causa    	= @w_causa_atm

			if @@rowcount = 0 or @w_accion = 'S'
				select @w_accion = 'V'

			if @i_stand_in = 'S' --LBM
				select @w_accion = 'V'

			if (@w_comision + @w_monto_imp_atm) > @w_saldo_para_girar and @w_accion = 'V'
			begin
				select @w_suspensos = @w_suspensos + 1
				
				if @w_saldo_para_girar <= 0
					select 	@w_val_atm = @w_comision,
							@w_val_efe_atm = $0,
							@w_monto_imp_atm = $0
				else
				/* pone solo el faltante en valores en suspenso */
				begin
					select @w_val2_atm = round((@w_saldo_para_girar / (1 + @w_tasa_imp)), @w_numdeci)
					select @w_val_atm = @w_comision - @w_val2_atm
					select @w_monto_imp_atm = @w_saldo_para_girar - @w_val2_atm
					select @w_val_efe_atm = @w_comision - @w_val_atm
				end

				exec @w_return = cobis..sp_cseqnos
					@t_from      = @w_sp_name,
					@i_tabla     = 'ah_val_suspenso',
					@o_siguiente = @w_sec out

				if @w_return <> 0
					return @w_return
          
				if @w_sec > 2147483640
				begin
					select @w_sec = 1
					update cobis..cl_seqnos
							set siguiente = @w_sec
						where tabla = 'ah_val_suspenso'
				end

				insert into cob_ahorros..ah_val_suspenso
                      (vs_cuenta, vs_secuencial, vs_servicio, vs_estado, vs_procesada,
                       vs_valor, vs_fecha, vs_oficina, vs_hora, vs_ssn, vs_clave, vs_impuesto)
					values
						(@w_cuenta, @w_sec, @w_causa_atm, 'N', 'N',
                        @w_val_atm, @i_fecha, @s_ofi, getdate(), @s_ssn_branch, 0, @i_imp)
          
				if @@error <> 0
				begin
					select @w_error = 253004
					goto ERROR
				end

				insert into cob_ahorros..ah_tsval_suspenso
						(secuencial, ssn_branch, alterno, tipo_tran, oficina,
						usuario, terminal, correccion, ssn_corr, reentry,
						origen, nodo, fecha, cta_banco, moneda,
						valor, interes, indicador, servicio, remoto_ssn,
						prod_banc, categoria, oficina_cta, accion, tipocta_super,
						turno, serial, tipo_cliente, cliente)
						--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
					values
						(@s_ssn, @s_ssn_branch, @i_alt + 1, @w_trn_sus, @s_ofi,
						@s_user, @s_term, 'N', null, 'N',
						'L', @s_srv, @i_fecha, @i_cta, @i_mon,
						@w_val_atm, null, 1, @w_causa_atm, @s_ssn_branch,
						@w_prod_banc, @w_categoria, @w_oficina_p, 'C', @o_tipocta_super,
						@i_turno, @i_serial, @w_clase_clte, @w_cliente)
				
				--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
				if @@error <> 0
				begin
					select @w_error = 253004
					goto ERROR
				end
			end
			else if (@w_comision + @w_monto_imp_atm) > @w_saldo_para_girar and @w_accion = 'E'
			begin /* Cuenta sin fondos */
				select @w_error = 251033
				goto ERROR
			end

			if @w_val_efe_atm > 0
			begin
				if @w_posteo = 'S'
				begin
					select @w_lineas = @w_lineas + 1

					/* Inserta en linea pendiente */
					insert into cob_ahorros..ah_linea_pendiente
							(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
							lp_control, lp_signo, lp_enviada)
						values
							(@w_cuenta, @w_lp_sec + 2, @w_nemo, @w_val_efe_atm, @i_fecha,
							@w_control + 2, @w_signo, 'N')

					if @@error <> 0
					begin
						select @w_error = 253002
						goto ERROR
					end

					if @w_monto_imp_atm > 0
					begin
						/*  Genera numero de linea Pendiente  */
						select @w_lineas = @w_lineas + 1

						insert into cob_ahorros..ah_linea_pendiente
								(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
								lp_control, lp_signo, lp_enviada)
							values
								(@w_cuenta, @w_lp_sec + 3, @w_nemo2, @w_monto_imp_atm,
								@i_fecha, @w_control + 3, 'D', 'N')

						if @@error <> 0
						begin
							select @w_error = 253002
							goto ERROR
						end
					end
				end --@w_posteo = 'S'

				select 	@w_disponible = round((@w_disponible - (@w_val_efe_atm + @w_monto_imp_atm) * @w_tfactor), @w_numdeci),
						@w_saldo_contable = @w_saldo_contable - (@w_val_efe_atm + @w_monto_imp_atm) * @w_tfactor
				select	@w_debitos = round((@w_debitos + (@w_val_efe_atm + @w_monto_imp_atm) * @w_tfactor), @w_numdeci)
				select 	@w_debhoy = round((@w_debhoy + (@w_val_efe_atm + @w_monto_imp_atm) * @w_tfactor), @w_numdeci)
				select	@w_alic = round((@w_val_efe_atm + @w_monto_imp_atm) * @w_alicuota, @w_numdeci)
				select	@w_promedio1 = @w_promedio1 - (@w_alic * @w_tfactor),
						@w_prom_disp = @w_prom_disp - (@w_alic * @w_tfactor),
						@w_saldo_para_girar = round((@w_saldo_para_girar - (@w_val_efe_atm + @w_monto_imp_atm) * @w_tfactor), @w_numdeci)
				select 	@w_monto_imp = @w_monto_imp + (@w_monto_imp_atm * @w_tfactor)
				select	@w_contador_trx = @w_contador_trx + 1

				if @t_corr = 'S'
					select @w_impuesto = @w_iva_dev

				/* Transaccion Monetaria por ATM*/
				insert into cob_ahorros..ah_notcredeb
						(secuencial, alterno, tipo_tran, oficina, usuario,
						terminal, correccion, sec_correccion, reentry, origen,
						nodo, fecha, cta_banco, signo, indicador,
						remoto_ssn, moneda, causa, fecha_efec, saldo_lib,
						valor, control, interes, saldocont, saldodisp,
						saldoint, departamento, oficina_cta, prod_banc, categoria,
						monto_imp, tipo_exonerado, serial, ssn_branch, tipocta_super,
						turno, hora, stand_in, canal, clase_clte,
						monto_iva, cliente, base_gmf)
					values
						(@s_ssn, @i_alt + 1, @t_trn, @s_ofi, @s_user,
						@s_term, 'N', null, 'N', 'L',
						@s_srv, @i_fecha, @i_cta, @w_signo, 1,
						@s_ssn_branch, @i_mon, @w_causa_atm, null, null,
						@w_val_efe_atm, null, 0, @w_saldo_contable, round(@w_disponible, @w_numdeci),
						null, null, @w_oficina_p, @w_prod_banc, @w_categoria,
						@w_val_2x1000, @w_tipo_exonerado_imp, @i_serial, @s_ssn_branch, @o_tipocta_super,
						@i_turno, getdate(), @i_stand_in, @i_canal, @w_clase_clte,
						@w_impuesto, @w_cliente, @w_base_gmf)

				if @@error <> 0
				begin
					select @w_error = 253000
					goto ERROR
				end
			end
		end /* Fin de @i_atm_server */
	end -- de transaccion 264 y factor = 1
	else if @t_trn = 253
	begin
		if @w_posteo = 'S'
		begin
			select @w_lineas = @w_lineas + 1

			/* Inserta en linea pendiente */
			insert into cob_ahorros..ah_linea_pendiente
					(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
					lp_control, lp_signo, lp_enviada)
				values
					(@w_cuenta, @w_lp_sec, @w_nemo, @w_val_efe, @i_fecha,
					@w_control, @w_signo, 'N')

			if @@error <> 0
			begin
				select @w_error = 253002
				goto ERROR
			end
		end --@w_posteo = 'S'

		if isnull(@w_monto_imp_his, 0) > 0 and isnull(@w_val_2x1000, 0) = 0
			select 	@w_val_2x1000 = @w_monto_imp_his,
					@o_monto_imp = @w_monto_imp_his

		if @w_debug = 'S' and @i_tran_ext = 'N'
			print '@o_monto_imp: ' + cast(@o_monto_imp as varchar) + ' @w_val_2x1000: ' + cast(@w_val_2x1000 as varchar)

		select 	@w_alic = round((@w_val_efe + @o_monto_imp) * @w_alicuota, @w_numdeci)
		select 	@w_creditos = round((@w_creditos + (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci),
				@w_credhoy = round((@w_credhoy + (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci),
				@w_promedio1 = @w_promedio1 + (@w_alic * @w_tfactor),
				@w_prom_disp = @w_prom_disp + (@w_alic * @w_tfactor),
				@w_disponible = round((@w_disponible + (@w_val_efe + @o_monto_imp) * @w_tfactor), @w_numdeci),
				@w_saldo_contable = @w_saldo_contable + (@w_val_efe + @o_monto_imp) * @w_tfactor,
				@w_saldo_para_girar = @w_saldo_para_girar + (@w_val_efe + @o_monto_imp) * @w_tfactor
		select 	@w_monto_imp = @w_monto_imp - (@o_monto_imp * @w_tfactor)

		/*** Validamos el saldo maximo de la cuenta JLOYO *****/
		if @w_saldo_max > 0 and @w_disponible > @w_saldo_max
		begin
			/**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
			select @w_error = 252077
			goto ERROR
		end

		select	@w_disp2 = round(@w_disponible, @w_numdeci),
				@w_cont2 = round(@w_saldo_contable, @w_numdeci)

    end -- de trn = 253 
    else if @t_trn not in(264, 253) and (@i_val + @o_monto_imp) > @w_saldo_para_girar
		return 1

    --Actualiza datos de la cuenta
    if @w_saldo_cero = 'N'
		select @w_fecha_ult_mov_int = @i_fecha

    if isnull(@w_promedio1, -1) < 0
		select @w_promedio1 = 0

    if isnull(@w_prom_disp, -1) < 0
		select @w_prom_disp = 0

	update cob_ahorros..ah_cuenta with (rowlock)
		set	ah_disponible 		= @w_disponible,
			ah_promedio1 		= @w_promedio1,
			ah_suspensos 		= @w_suspensos,
			ah_creditos 		= @w_creditos,
			ah_debitos 			= @w_debitos,
			ah_linea 			= @w_lineas,
			ah_fecha_ult_mov_int = @w_fecha_ult_mov_int,
			ah_contador_trx 	= @w_contador_trx + 1,
			ah_debitos_hoy 		= @w_debhoy,
			ah_creditos_hoy 	= @w_credhoy,
			ah_prom_disponible 	= @w_prom_disp,
			ah_fecha_ult_mov 	= @w_fecha_ult_mov,--LBM
			ah_monto_imp 		= @w_monto_imp,
			/*FRC-AHO-017-CobroComisiones CMU 2102110*/
			ah_num_deb_mes 		= @w_ndebmes,
			ah_num_cred_mes		= @w_ncredmes
		where  ah_cuenta = @w_cuenta

	if @@rowcount <> 1
	begin
		select	@w_error = 255001
		goto ERROR
	end

    if @w_val_efe > 0
    begin
		if @t_corr = 'S'
			select @w_impuesto = @w_iva_dev
		
		/* Transaccion Monetaria */
		insert into cob_ahorros..ah_notcredeb
				(secuencial, alterno, tipo_tran, oficina, usuario,
				terminal, correccion, sec_correccion, reentry, origen,
				nodo, fecha, cta_banco, signo, indicador,
				remoto_ssn, moneda, causa, fecha_efec, saldo_lib,
				valor, control, interes, saldocont, saldodisp,
				saldoint, departamento, oficina_cta, prod_banc, categoria,
				monto_imp, tipo_exonerado, serial, concepto, ssn_branch,
				tipocta_super, turno, hora, stand_in, canal,
				cheque, clase_clte, monto_iva, cliente, base_gmf)
			values
				(@s_ssn, @i_alt, @t_trn, @s_ofi, @s_user,
				@s_term, 'N', null, 'N', 'L',
				@s_srv, @i_fecha, @i_cta, @w_signo, 1,
				@s_ssn_branch, @i_mon, @i_cau, @w_fecha_trn, null,
				@w_val_efe, null, @w_interes, @w_cont2, @w_disp2,
				null, null, @w_oficina_p, @w_prod_banc, @w_categoria,
				@w_val_2x1000, @w_tipo_exonerado_imp, @i_serial, @w_concepto, @s_ssn_branch,
				@o_tipocta_super, @i_turno, getdate(), @i_stand_in, @i_canal,
				@i_cheque, @w_clase_clte, @w_impuesto, @w_cliente, @w_base_gmf)

		if @@error <> 0
		begin
			select @w_error = 253000
			goto ERROR
		end

		if (@i_tran_ext = 'S' and @i_corresponsal = 'S') and @t_trn = 253 and @w_his <> 'S'
		begin
			--Se genera transacción de servicio para aumento de cupo 
			insert into cob_ahorros..ah_tran_servicio
					(ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
					ts_usuario, ts_terminal, ts_correccion, ts_ssn_corr, ts_reentry,
					ts_origen, ts_nodo, ts_tsfecha, ts_cta_banco, ts_moneda,
					ts_valor, ts_interes, ts_indicador, ts_causa, ts_prod_banc,
					ts_categoria, ts_oficina_cta, ts_observacion, ts_tipocta_super,
					ts_clase_clte, ts_cliente,ts_hora)
				values
					(@s_ssn, @s_ssn, 1, 751, @w_oficina_p,
					@s_user, @s_term, 'N', null, 'N',
					'L', @s_srv, @i_fecha, @i_cta, 0,
					@i_val, null, 1, '52', @w_prod_banc,
					@w_categoria, @w_oficina_p, ('AUMENTO CUPO CB POSICIONADO ' + cast(@w_oficina_p as varchar)), @w_tipocta,
					@w_clase_clte, @w_cliente, getdate())
		end

		/* Si es una NC y la causal genera cobro de GMF a cargo Bancamia se realiza el cobro correspondiente*/
		if @t_trn = 253
		begin
			if exists (select 1
						from cobis..cl_tabla t,
							cobis..cl_catalogo c
						where t.tabla  = 'ah_cau_nc_gmf_ba'
						and c.tabla  = t.codigo
						and c.codigo = @i_cau)
			begin
				exec @w_return = sp_ah_genera_gmf_bco
					@s_ssn          = @s_ssn,
					@s_ssn_branch   = @s_ssn_branch,
					@s_user         = @s_user,
					@s_term         = @s_term,
					@s_ofi          = @s_ofi,
					@t_trn          = @t_trn,
					@t_corr         = @t_corr,
					@t_ssn_corr     = @t_ssn_corr,
					@i_alt          = @i_alt,
					@i_cta_banco    = @i_cta,
					@i_fecha        = @i_fecha,
					@i_prod_banc    = @w_prod_banc,
					@i_categoria    = @w_categoria,
					@i_tipocta_super= @o_tipocta_super,
					@i_valor        = @w_val_efe,
					@i_moneda       = @w_mon,
					@i_clase_clte   = @w_clase_clte,
					@i_causal       = @i_cau,
					@i_cliente      = @w_cliente,
					@i_oficina      = @w_oficina_p

				if @w_return <> 0
				begin
					if @w_debug = 'S' and @i_tran_ext = 'N'
					begin
						print 'ERROR GENERANDO REGISTRO GMF PARA BANCAMIA'
						print '@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
						print '@i_cta ' + @i_cta + ' @i_cau ' + @i_cau + ' @i_mon ' + cast(@i_mon as varchar)
						print '@i_val ' + cast(@i_val as varchar)
					end
					
					select 	@w_error = @w_return,
							@w_sev = 0
					goto ERROR
				end
			end
		end
	end
end -- de factor = 1

if @w_tfactor = -1
begin
    /* Validar valor en suspenso */
    if @t_trn = 264
    begin
		select @w_signo = 'C'
		/**** PEDRO COELLO VALIDO PRIMERO QUE EXISTA EL VALOR EN SUSPENSO ****/
		if exists (select 1
					from cob_ahorros..ah_tran_servicio
					where ts_tipo_transaccion	= @w_trn_sus
					and isnull(ts_ssn_branch, ts_secuencial) = @t_ssn_corr
					and ts_oficina				= @s_ofi
					and ts_cod_alterno			= @i_alt_corr)
		begin
			/* actualizo como procesados los valores en suspenso*/
			update cob_ahorros..ah_val_suspenso
					set vs_estado = 'A',
						vs_procesada = 'S'
				where  vs_fecha = @i_fecha
				and vs_ssn   	= @t_ssn_corr

			if @@rowcount = 0
			begin
				select @w_error = 253000
				goto ERROR
			end

			update cob_ahorros..ah_tran_servicio
					set ts_estado = 'R'
				from cob_ahorros..ah_tran_servicio
				where ts_tipo_transaccion	= @w_trn_sus
				and isnull(ts_ssn_branch, ts_secuencial) = @t_ssn_corr
				and ts_oficina				= @s_ofi
				and ts_cod_alterno		= @i_alt_corr

			if @@rowcount = 0
			begin
				select @w_error = 253000
				goto ERROR
			end

			insert into cob_ahorros..ah_tran_servicio
					(ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
					ts_usuario, ts_terminal, ts_correccion, ts_ssn_corr, ts_reentry,
					ts_origen, ts_nodo, ts_tsfecha, ts_cta_banco, ts_moneda,
					ts_valor, ts_interes, ts_indicador, ts_causa, ts_remoto_ssn,
					ts_prod_banc, ts_categoria, ts_oficina_cta, ts_accion, ts_tipocta_super,
					ts_turno, ts_autoriz_aut, ts_clase_clte, ts_cliente, ts_estado)
					--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
				values
					(@s_ssn, @s_ssn_branch, @i_alt, @w_trn_sus, @s_ofi,
					@s_user, @s_term, 'S', @t_ssn_corr, 'N',
					'L', @s_srv, @i_fecha, @i_cta, @i_mon,
					@w_val, null, 1, @i_cau, @s_ssn_branch,
					@w_prod_banc, @w_categoria, @w_oficina_p, 'C', @o_tipocta_super,
					@i_turno, @i_serial, @w_clase_clte, @w_cliente, 'R')

			--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
			if @@error <> 0
			begin
				select @w_error = 253004
				goto ERROR
			end

			select @w_suspensos = @w_suspensos - 1

			--REQ 381 Validar si existe ts de la disminucion de cupo, para marcar como Reverso para no contabilizar
			if exists (select 1
							from cob_ahorros..ah_tran_servicio
							where  ts_tsfecha		= @i_fecha
							--Fecha de la transaccion (Solo del dia)
							and ts_tipo_transaccion = 752 --Tx Disminucion Cupo
							and ts_causa            = 50 --Causal Disminucion Cupo
							and ts_secuencial       = @t_ssn_corr
							and ts_valor            = @w_val)
			begin
				update cob_ahorros..ah_tran_servicio
						set ts_estado = 'R'
					where ts_tsfecha		= @i_fecha
					--Fecha de la transaccion (Solo del dia)
					and ts_tipo_transaccion = 752 --Tx Disminucion Cupo
					and ts_causa            = 50 --Causal Disminucion Cupo
					and ts_secuencial       = @t_ssn_corr
					and ts_valor            = @w_val

				--Se genera transacción de servicio para aumento de cupo 
				insert into cob_ahorros..ah_tran_servicio
						(ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
						ts_usuario, ts_terminal, ts_correccion, ts_ssn_corr, ts_reentry,
						ts_origen, ts_nodo, ts_tsfecha, ts_cta_banco, ts_moneda,
						ts_valor, ts_interes, ts_indicador, ts_causa, ts_prod_banc,
						ts_categoria, ts_oficina_cta, ts_observacion,
						ts_tipocta_super, ts_clase_clte, ts_cliente, ts_hora, ts_estado)
					values
						(@s_ssn, @s_ssn, 1, 752, @s_ofi,
						@s_user, @s_term, 'S', @t_ssn_corr, 'N',
						'L', @s_srv, @i_fecha, @i_cta, 0,
						@i_val, null, 1, '50', @w_prod_banc,
						@w_categoria, @w_oficina_p, ('CORR: ' + cast(@t_ssn_corr as varchar) + ' DISMINUCION CUPO CB POSICIONADO ' + cast(@s_ofi as varchar)),
						@w_tipocta, @w_clase_clte, @w_cliente, getdate(), 'R')
			end
			else
			begin
				select @w_return = @@error

				if @w_return <> 0
				begin
					if @w_debug = 'S' and @i_tran_ext = 'N'
					begin
						print '4 @w_return: ' + cast(@w_return as varchar)
						print '@s_ssn ' + cast(@s_ssn as varchar) + ' @i_alt ' + cast(@i_alt as varchar) + ' @s_ssn_branch ' + cast(@s_ssn_branch as varchar)
					end
					
					select @w_error = 251067
					goto ERROR
				end
			end
		end

		select 	@w_debitos = round((@w_debitos - (@w_val_mon + @o_monto_imp + @w_iva_dev)), @w_numdeci)
		select 	@w_debhoy = round((@w_debhoy - (@w_val_mon + @o_monto_imp + @w_iva_dev)), @w_numdeci)
		select 	@w_alic = round((@w_val_mon + @o_monto_imp + @w_iva_dev) * @w_alicuota, @w_numdeci)
		select 	@w_disponible = round((@w_disponible + (@w_val_mon + @o_monto_imp + @w_iva_dev)), @w_numdeci),
				@w_saldo_contable = round((@w_saldo_contable + (@w_val_mon + @o_monto_imp + @w_iva_dev)), @w_numdeci),
				@w_saldo_para_girar = round((@w_saldo_para_girar + (@w_val_mon + @o_monto_imp + @w_iva_dev)), @w_numdeci),
				@w_promedio1 = @w_promedio1 - round(@w_alic, @w_numdeci) * @w_tfactor,
				@w_prom_disp = @w_prom_disp - round(@w_alic, @w_numdeci) * @w_tfactor,
				@w_monto_imp = @w_monto_imp - @o_monto_imp
		select	@w_disp2 = round(@w_disponible, @w_numdeci),
				@w_cont2 = round(@w_saldo_contable, @w_numdeci)

		if @i_atm_server = 'S' and @w_comision > 0
		begin
			/**** PEDRO COELLO VALIDO PRIMERO QUE EXISTA EL VALOR EN SUSPENSO ****/
			if exists (select 1
					from cob_ahorros..ah_tran_servicio
					where ts_tipo_transaccion	= @w_trn_sus
					and isnull(ts_ssn_branch, ts_secuencial) = @t_ssn_corr
					and ts_oficina			= @s_ofi
					and ts_cod_alterno		= @i_alt + 1)
				--and @w_valor2 > 0
			begin
				/* actualizo como procesados los valores en suspenso*/
				--print '%1! %2!', @i_fecha, @t_ssn_corr
				update cob_ahorros..ah_val_suspenso
					set vs_estado	 = 'A',
						vs_procesada = 'S'
					where vs_fecha 	= @i_fecha
					and vs_ssn   	= @t_ssn_corr
         
				if @@rowcount = 0
				begin
					select @w_error = 203011
					goto ERROR
				end

				insert into cob_ahorros..ah_tsval_suspenso
						(secuencial, ssn_branch, alterno, tipo_tran, oficina,
						usuario, terminal, correccion, ssn_corr, reentry,
						origen, nodo, fecha, cta_banco, moneda,
						valor, interes, indicador, servicio, remoto_ssn,
						prod_banc, categoria, oficina_cta, accion, tipocta_super,
						turno, serial, tipo_cliente, cliente)
						--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente
					values
						(@s_ssn, @s_ssn_branch, @i_alt + 1, @w_trn_sus, @s_ofi,
						@s_user, @s_term, 'S', @t_ssn_corr, 'N',
						'L', @s_srv, @i_fecha, @i_cta, @i_mon,
						@w_valor2, null, 1, @w_causa_atm, @s_ssn_branch,
						@w_prod_banc, @w_categoria, @w_oficina_p, 'C', @o_tipocta_super,
						@i_turno, @i_serial, @w_clase_clte, @w_cliente)
          
				--Req 371 28/02/2014 Se agregan campos tipo_cliente, cliente		  
				if @@error <> 0
				begin
					select @w_error = 253004
					goto ERROR
				end
				
				select @w_suspensos = @w_suspensos - 1
			end

			select 	@w_debitos = round((@w_debitos - (@w_valor1 + @w_monto_imp_atm)), @w_numdeci)
			select 	@w_debhoy = round((@w_debhoy - (@w_valor1 + @w_monto_imp_atm)), @w_numdeci)
			select 	@w_alic = round((@w_valor1 + @w_monto_imp_atm) * @w_alicuota, @w_numdeci)
			select 	@w_disponible = round((@w_disponible + (@w_valor1 + @w_monto_imp_atm)), @w_numdeci),
					@w_saldo_contable = round((@w_saldo_contable + (@w_valor1 + @w_monto_imp_atm)), @w_numdeci),
					@w_saldo_para_girar = round((@w_saldo_para_girar + (@w_valor1 + @w_monto_imp_atm)), @w_numdeci),
					@w_promedio1 = @w_promedio1 - round(@w_alic, @w_numdeci) * @w_tfactor,
					@w_prom_disp = @w_prom_disp - round(@w_alic, @w_numdeci) * @w_tfactor,
					@w_monto_imp = @w_monto_imp - @w_monto_imp_atm

			if @w_valor1 > 0
			begin
				if @w_posteo = 'S'
				begin
					select @w_lineas = @w_lineas + 1

					insert into cob_ahorros..ah_linea_pendiente
							(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
							lp_control, lp_signo, lp_enviada)
						values
							(@w_cuenta, @w_lp_sec + 2, 'CORR', @w_valor1, @i_fecha,
							@w_control + 2, @w_signo, 'N')

					if @@error <> 0
					begin
						select @w_error = 253002
						goto ERROR
					end

					if @w_monto_imp_atm > 0
					begin
						select @w_lineas = @w_lineas + 1

						insert into cob_ahorros..ah_linea_pendiente
								(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
								lp_control, lp_signo, lp_enviada)
							values
								(@w_cuenta, @w_lp_sec + 3, 'CORR', @w_monto_imp_atm, @i_fecha,
								@w_control + 3, @w_signo, 'N')
					
						if @@error <> 0
						begin
							select @w_error = 253002
							goto ERROR
						end
					end
				end --@w_posteo = 'S'

				update cob_ahorros..ah_tran_monet
						set tm_estado = @w_est
					where isnull(tm_ssn_branch, tm_secuencial) = @t_ssn_corr
					and tm_cod_alterno	= @i_alt_corr + 1
					and tm_cta_banco	= @i_cta
					and tm_causa		= @w_causa_atm
					and tm_moneda		= @i_mon
					and tm_estado 		is null

				if @@rowcount <> 1
				begin
					if @w_debug = 'S' and @i_tran_ext = 'N'
					begin
						print '4.@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
						print '@i_cta ' + @i_cta + ' @w_causa_atm ' + @w_causa_atm
						print '@i_mon ' + cast(@i_mon as varchar)
						--print '4 @t_ssn_corr %1! @i_alt %2! @s_user %3! @i_cta %4! @w_causa_atm %5! @i_mon %6!' , @t_ssn_corr, @i_alt, @s_user, @i_cta, @w_causa_atm, @i_mon
					end
					
					select @w_error = 251067
					goto ERROR
				end

				if @t_corr = 'S'
					select @w_impuesto = @w_iva_dev

				/* Transaccion Monetaria */
				insert into cob_ahorros..ah_notcredeb
						(secuencial, alterno, tipo_tran, oficina, usuario,
						terminal, correccion, sec_correccion, reentry, origen,
						nodo, fecha, cta_banco, signo, indicador,
						remoto_ssn, moneda, causa, fecha_efec, saldo_lib,
						valor, control, interes, saldocont, saldodisp,
						saldoint, departamento, oficina_cta, prod_banc, categoria,
						estado, monto_imp, tipo_exonerado, serial, concepto,
						ssn_branch, tipocta_super, turno, hora, stand_in,
						canal, cliente, base_gmf, clase_clte)
					values
						(@s_ssn, @i_alt + 1, @t_trn, @s_ofi, @s_user,
						@s_term, @t_corr, @t_ssn_corr, 'N', 'L',
						@s_srv, @i_fecha, @i_cta, @w_signo, 1,
						@s_ssn_branch, @i_mon, @w_causa_atm, null, null,
						@w_valor1, null, 0, @w_saldo_contable, round(@w_disponible, @w_numdeci),
						null, null, @w_oficina_p, @w_prod_banc, @w_categoria,
						@w_est, @w_monto_imp_atm, @w_tipo_exonerado_imp, @i_serial, @w_concepto,
						@s_ssn_branch, @o_tipocta_super, @i_turno, getdate(), @i_stand_in,
						@i_canal, @w_cliente, @w_base_gmf, @w_clase_clte)

				if @@error <> 0
				begin
					select @w_error = 253000
					goto ERROR
				end
			end
		end /* Fin ATM */
	end
	else if @t_trn = 253
	begin
		/* verifica saldo para reverso de nota credito */
		if @t_corr = 'S' and @t_trn = 253
		begin
			if @w_val_efe + isnull(@o_monto_imp, 0) > @w_saldo_para_girar
			begin
				begin /* Cuenta sin fondos */
					select @w_error = 251033
					goto ERROR
				end
			end
		end

		select 	@w_val_mon = @i_val, 
				@w_signo = 'D'

		select	@w_creditos = round((@w_creditos + (@w_val_mon + isnull(@o_monto_imp, 0) + isnull(@w_iva_dev, 0)) * @w_tfactor), @w_numdeci)
		select	@w_credhoy = round((@w_credhoy + (@w_val_mon + isnull(@o_monto_imp, 0) + isnull(@w_iva_dev, 0)) * @w_tfactor), @w_numdeci)
		select	@w_alic = round((@w_val_mon + isnull(@o_monto_imp, 0) + isnull(@w_iva_dev, 0)) * @w_alicuota, @w_numdeci)
		select	@w_disponible = round((@w_disponible - (@w_val_mon + isnull(@o_monto_imp, 0))), @w_numdeci),
				@w_saldo_contable = @w_saldo_contable - (@w_val_mon + isnull(@o_monto_imp, 0)),
				@w_saldo_para_girar = @w_saldo_para_girar - (@w_val_mon + isnull(@o_monto_imp, 0) + isnull(@w_iva_dev, 0)),
				@w_promedio1 = @w_promedio1 + round(@w_alic, @w_numdeci) * @w_tfactor,
				@w_prom_disp = @w_prom_disp + round(@w_alic, @w_numdeci) * @w_tfactor,
				@w_monto_imp = @w_monto_imp + isnull(@o_monto_imp, 0)

		select	@w_cont2 = round(@w_saldo_contable, @w_numdeci),
				@w_disp2 = round(@w_disponible, @w_numdeci)
	end

    if @w_val_mon > 0 and @w_posteo = 'S'
    begin
		select @w_lineas = @w_lineas + 1

		insert into cob_ahorros..ah_linea_pendiente
				(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
				lp_control, lp_signo, lp_enviada)
			values
				(@w_cuenta, @w_lp_sec, 'CORR', @w_val_mon, @i_fecha,
				@w_control, @w_signo, 'N')
      
		if @@error <> 0
		begin
			select @w_error = 253002
			goto ERROR
		end

		if @o_monto_imp > 0
		begin
			select @w_lineas = @w_lineas + 1

			insert into cob_ahorros..ah_linea_pendiente
					(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
					lp_control, lp_signo, lp_enviada)
				values
					(@w_cuenta, @w_lp_sec + 1, 'CORR', @o_monto_imp, @i_fecha,
					@w_control + 1, @w_signo, 'N')

			if @@error <> 0
			begin
				select @w_error = 253002
				goto ERROR
			end
		end
	end

    if @w_saldo_cero = 'N'
		select @w_fecha_ult_mov_int = @i_fecha

	if isnull(@w_promedio1, -1) < 0
		select @w_promedio1 = 0

    if isnull(@w_prom_disp, -1) < 0
		select @w_prom_disp = 0

	/* Actualiza Maestro de Ahorro */
	update cob_ahorros..ah_cuenta with (rowlock)
		set ah_suspensos 		= @w_suspensos,
			ah_linea 			= @w_lineas,
			ah_debitos 			= @w_debitos,
			ah_debitos_hoy 		= @w_debhoy,
			ah_creditos 		= @w_creditos,
			ah_creditos_hoy 	= @w_credhoy,
			ah_promedio1 		= @w_promedio1,
			ah_prom_disponible 	= @w_prom_disp,
			ah_disponible 		= round(@w_disponible, @w_numdeci),
			ah_contador_trx 	= ah_contador_trx + @w_tfactor,
			ah_fecha_ult_ret 	= @i_fecha,
			ah_fecha_ult_mov_int = @w_fecha_ult_mov_int,
			ah_fecha_ult_mov 	= @w_fecha_ult_mov,--LBM
			ah_monto_imp		= @w_monto_imp		   
		where ah_cuenta = @w_cuenta
	
	if @@rowcount <> 1
	begin
		select @w_error = 255001
		goto ERROR
	end

    if exists (select 1
				from cob_ahorros..ah_tran_servicio
				where ts_tsfecha		= @i_fecha
				--Fecha de la transaccion (Solo del dia)
				and ts_tipo_transaccion = 751 --Tx AUMENTO Cupo
				and ts_causa            = 52 --Causal AUMENTO Cupo
				and ts_secuencial       = @t_ssn_corr
				and ts_valor            = @w_val)
    begin
		update cob_ahorros..ah_tran_servicio
				set ts_estado = 'R'
			where ts_tsfecha		= @i_fecha
			--Fecha de la transaccion (Solo del dia)
			and ts_tipo_transaccion = 751 --Tx AUMENTO Cupo
			and ts_causa            = 52 --Causal AUMENTO Cupo
			and ts_secuencial       = @t_ssn_corr
			and ts_valor            = @w_val

		--Se genera transacción de servicio para aumento de cupo 
		insert into cob_ahorros..ah_tran_servicio
				(ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
				ts_usuario, ts_terminal, ts_correccion, ts_ssn_corr, ts_reentry,
				ts_origen, ts_nodo, ts_tsfecha, ts_cta_banco, ts_moneda,
				ts_valor, ts_interes, ts_indicador, ts_causa, ts_prod_banc,
				ts_categoria, ts_oficina_cta, ts_observacion, ts_tipocta_super,
				ts_clase_clte, ts_cliente, ts_hora, ts_estado)
			values
				(@s_ssn, @s_ssn, 1, 751, @s_ofi,
				@s_user, @s_term, 'S', @t_ssn_corr, 'N',
				'L', @s_srv, @i_fecha, @i_cta, 0,
				@i_val, null, 1, '52', @w_prod_banc,
				@w_categoria, @w_oficina_p, ('CORR: ' + cast(@t_ssn_corr as varchar) + ' AUMENTO CUPO CB POSICIONADO ' + cast(@s_ofi as varchar)), @w_tipocta, 
				@w_clase_clte, @w_cliente, getdate(), 'R')

		select @w_val_mon = 0 --Para evitar que busque TX Monetaria
    end
    else
    begin
		select @w_return = @@error

		if @w_return <> 0
		begin
			if @w_debug = 'S' and @i_tran_ext = 'N'
			begin
				print '4 @w_return: ' + cast(@w_return as varchar)
				print '@s_ssn ' + cast(@s_ssn as varchar) + ' @i_alt ' + cast(@i_alt as varchar) + ' @s_ssn_branch ' + cast(@s_ssn_branch as varchar)
			end
			
			select @w_error = 251067
			goto ERROR
		end
	end
	
    /* Actualiza transaccion monetaria*/
    if @w_val_mon > 0
    begin
		update cob_ahorros..ah_tran_monet with (rowlock)
				set tm_estado = @w_est
			where isnull(tm_ssn_branch, tm_secuencial) = @t_ssn_corr
			and tm_cod_alterno	= @i_alt_corr
			and tm_cta_banco	= @i_cta
			and tm_causa		= @i_cau
			and tm_moneda		= @i_mon
			and tm_estado 		is null
		 
		if @@rowcount <> 1
		begin
			if @w_debug = 'S' and @i_tran_ext = 'N'
			begin
				print '5.@t_ssn_corr ' + cast(@t_ssn_corr as varchar) + ' @i_alt_corr ' + cast(@i_alt_corr as varchar)
				print '@i_cta ' + @i_cta + ' @i_cau ' + @i_cau
				print '@i_mon ' + cast(@i_mon as varchar) + ' @w_val_mon ' + cast(@w_val_mon as varchar)
				--print '5 @t_ssn_corr %1! @i_alt %2! @s_user %3! @i_cta %4! @w_causa_atm %5! @i_mon %6!' , @t_ssn_corr, @i_alt, @s_user, @i_cta, @w_causa_atm, @i_mon
			end
			
			select @w_error = 251067
			goto ERROR
		end

		if @t_corr = 'S'
			select @w_impuesto = @w_iva_dev
      
		/* Transaccion Monetaria */
		insert into cob_ahorros..ah_notcredeb
				(secuencial, alterno, tipo_tran, oficina, usuario,
				terminal, correccion, sec_correccion, reentry, origen,
				nodo, fecha, cta_banco, signo, indicador,
				remoto_ssn, moneda, causa, fecha_efec, saldo_lib,
				valor, control, interes, saldocont, saldodisp,
				saldoint, departamento, oficina_cta, prod_banc, categoria,
				estado, monto_imp, tipo_exonerado, serial, ssn_branch,
				tipocta_super, turno, hora, stand_in, canal,
				cheque, monto_iva, cliente, base_gmf, clase_clte)
			values
				(@s_ssn, @i_alt, @t_trn, @s_ofi, @s_user,
				@s_term, @t_corr, @t_ssn_corr, 'N', 'L',
				@s_srv, @i_fecha, @i_cta, @w_signo, 1,
				@s_ssn_branch, @i_mon, @i_cau, null, null,
				@w_val_mon, null, 0, @w_cont2, @w_disp2,
				null, null, @w_oficina_p, @w_prod_banc, @w_categoria,
				@w_est, @o_monto_imp, @w_tipo_exonerado_imp, @i_serial, @s_ssn_branch,
				@o_tipocta_super, @i_turno, getdate(), @i_stand_in, @i_canal,
				@i_cheque, @w_impuesto, @w_cliente, @w_base_gmf, @w_clase_clte)

		select @w_return = @@error

		if @w_return <> 0
		begin
			if @w_debug = 'S' and @i_tran_ext = 'N'
			begin
				print '4 @w_return: ' + cast(@w_return as varchar)
				print '@s_ssn ' + cast(@s_ssn as varchar) + ' @i_alt ' + cast(@i_alt as varchar) + ' @s_ssn_branch ' + cast(@s_ssn_branch as varchar)
			end
			
			select @w_error = 253000
			goto ERROR
		end
	end
end/*  factor = -1 */

-- JCO devolucion de gmf 
--if @w_gmf_reintegro > 0  and @i_reintegro  = 'N'  and @w_val_2x1000 > 0
if @o_monto_imp > 0 and @i_reintegro = 'N'
begin
	/* recalcular por valores en suspenso */
	/*select @w_gmf_reintegro = round(@w_val_2x1000 * (@w_tasa_reintegro /100),@w_numdeci_imp)  */
	if @w_tfactor <> 1
		select @w_gmf_reintegro = isnull(round(isnull(@o_monto_imp, 0) * (@w_tasa_reintegro / 100), @w_numdeci_imp), 0)

	if @w_gmf_reintegro > 0
	begin
		select @i_alt = @i_alt + 10

		execute @w_return = sp_reintegro_gmf
			@s_srv        = @s_srv,
			@s_ofi        = @s_ofi,
			@s_ssn        = @s_ssn,
			@s_ssn_branch = @s_ssn_branch,
			@s_user       = @s_user,
			@s_term       = @s_term,
			@s_date       = @i_fecha,
			@t_corr       = @t_corr,
			@t_ssn_corr   = @t_ssn_corr,
			@i_cuenta     = @w_cuenta,
			@i_valor      = @w_gmf_reintegro,
			@i_mon        = @i_mon,
			@i_alterno    = @i_alt,
			@i_factor     = @w_tfactor,
			@i_cliente    = @w_cliente,
			@i_posteo     = @w_posteo,
			@i_base_gmf   = @w_base_gmf

		/* if @w_return <> 0   
		begin       
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   =   252093
			return  252093
		end      */

		if @w_return <> 0
		begin
			select @w_error = 252093
			goto ERROR
		end
		
		select @w_saldo_para_girar = @w_saldo_para_girar + @w_gmf_reintegro
	end
end

select @o_saldo_para_girar = @w_saldo_para_girar

/*FRC-AHO-017-CobroComisiones CMU 2102110*/
-- SE BUSCA COSTOS DE COBRO COMISIONES
--Consulta si producto tienen parametrizado cobro tipo T o C        

/*if @i_canal <> 4 -- Req 363/371 - No se utiliza el manejo de canal actualmente a la 30/09/2013
begin              
	exec @w_return = cob_remesas..sp_tipo_comision
		@i_prodbanc     = @w_prod_banc,     
		@i_categoria    = @w_categoria,     
		@i_tipocta      = @w_tipocta,
		@i_tipo         = @w_tipo,
		@i_mon          = @w_mon,         
		@i_filial       = @w_filial_p,
		@i_oficina      = @w_oficina_p,
		@o_numcre       = @w_numcre     out,
		@o_numtot       = @w_numtot     out,
		@o_numco        = @w_numco      out,
		@o_numdeb       = @w_numdeb     out,
		@o_tipocobro    = @w_tipocobro  out       
		-- print ' Tipo Cobro ' + cast (@w_tipocobro as varchar)  +  '  total transacciones ' + cast (@w_numtot as varchar)                  
   
	if @w_tipocobro = 'C'
		select @w_numero = @w_numdeb
	else
		select @w_numero = @w_numtot
  
	if @w_ndebmes >= @w_numero and @w_tipocobro <> 'M'
	begin  
		exec @w_return = cob_remesas..sp_genera_costos
			@s_srv          = @s_srv,
			@s_ofi          = @s_ofi,
			@s_ssn          = @s_ssn,
			@s_user         = @s_user,
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_fecha        = @i_fecha,
			@i_valor        = 1,
			@i_categoria    = @w_categoria,
			@i_tipo_ente    = @w_tipocta,
			@i_rol_ente     = @w_rol_ente,
			@i_tipo_def     = @w_tipo_def,
			@i_prod_banc    = @w_prod_banc,
			@i_producto     = @w_producto,
			@i_moneda       = @i_mon,
			@i_tipo         = @w_tipo,
			@i_codigo       = @w_codigo,
			@i_servicio     = 'COCO',
			@i_rubro        = '3',
			@i_disponible   = @w_disponible,
			@i_contable     = @w_saldo_contable,
			@i_promedio     = @w_promedio1,
			@i_prom_disp    = @w_prom_disp,
			@i_personaliza  = @w_personaliza,
			@i_filial       = @w_filial_p,
			@i_oficina      = @w_oficina_p,
			@o_valor_total  = @w_cobro_comision out

		if @w_return <> 0
			return @w_return                
	end        
	else
		select @w_cobro_comision   = 0
     
	--FRC-AHO-017-CobroComisiones CMU 2102110
	-- COBRO COMISIONES
	if isnull(@w_cobro_comision, 0) > 0
	begin
		-- ND por  valor comision
		exec @w_return = cob_ahorros..sp_ahndc_automatica
			@s_srv          = @s_srv,
			@s_ofi          = @s_ofi,
			@s_ssn          = @s_ssn,
			@s_user         = @s_user,
			@t_trn          = 264,
			@i_cta          = @i_cta,
			@i_val          = @w_cobro_comision,
			@i_cau          = '90',
			@i_mon          = @i_mon,
			@i_fecha        = @i_fecha,
			@i_alt          = 10,
			@i_canal        = 4
            
		if @w_return <> 0
			return @w_return                                                                                                            
	end   
end
*/

/* ATM Server:  Actualizacion de tarjeta y envio de resultados */
if @i_atm_server = 'S' or substring(@s_user, 1, 3) = 'atm'
begin
    select
		'results_submit_rpc',
		r_ofi_cta_deb = @w_oficina_p,
		r_cta_deb = @i_cta,
		r_sld_disp_deb = @w_disponible,
		r_sld_cont_deb = @w_saldo_contable,
		r_sld_girar_deb = @w_saldo_para_girar,
		r_sld_12h_deb = @w_12h,
		r_sld_24h_deb = @w_24h,
		r_sld_48h_deb = @w_48h,
		r_sld_rem_deb = @w_remesas,
		r_promedio1 = @w_promedio1,
		r_monto_blq_deb = @w_monto_blq,
		r_estado_deb = @w_estado,
		r_ssn_host = @s_ssn,
		r_fecha_cont = @i_fecha,
		r_comision_host = @w_comision,
		r_val_deb = @i_val,
		r_mon_deb = @i_mon,
		r_prod_deb = 4,
		r_cotiz_atm = @i_cotiz_atm,
		r_codope_tes = @i_codope_tes,
		r_monto_sob_deb = $0,-- mgt
		r_fecha_host = @w_fecha_sistema -- mgt  
end

-- Actualizacion de Impuesto GMF causado 
if @w_codigo_pais = 'CO' -- Colombia
begin
    -- Actualiza acumulados topes gmf 
    if @w_actualiza = 'S'
    begin
		exec @w_return = sp_calcula_gmf
			@s_date      = @i_fecha,
			@i_cuenta    = @w_cuenta,
			@i_producto  = @w_producto,
			@i_operacion = 'U',
			@i_acum_deb  = @w_acumu_deb

		if @w_return <> 0
			return @w_return
    end
end

if @t_ejec = 'R'
begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
		@s_ssn_host    = @s_ssn,
		@i_cuenta      = @w_cuenta,
		@i_fecha       = @i_fecha,
		@i_ofi         = @s_ofi,
		@i_tipo_cuenta = 'O'
	
	if @w_return <> 0
		return @w_return
end

if @@trancount > 0 and @w_rollback = 'S'
	commit tran

return 0

ERROR:
if @i_tran_ext = 'N'
begin
    if @i_is_batch = 'N'
    begin
		if @i_nomtrn is null
			exec cobis..sp_cerror
				@t_debug = null,
				@t_file  = null,
				@t_from  = @w_sp_name,
				@i_num   = @w_error,
				@i_sev   = @w_sev
		else if @w_sev = 1
			rollback tran @i_nomtrn
    end
	
	return @w_error
end
else
begin
    print '@w_rollback ' + cast(@w_rollback as varchar) + ' @w_sev ' + cast(@w_sev as varchar)
    if @w_sev = 1
		if @w_rollback = 'S'
			rollback

    return @w_error
end

go
