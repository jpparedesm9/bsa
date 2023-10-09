/************************************************************************/
/*      Archivo:                apertura.sp                             */
/*      Stored procedure:       sp_apertura_ah                          */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     29-Nov-1993                             */
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
/*      Este programa realiza la transaccion de apertura de cuenta      */
/*      de ahorros.                                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      29/Nov/1993     P. Mena         Emision inicial para Banco      */
/*                                      de Credito                      */
/*      25/Oct/1994     J. Bucheli      Personalizacion Banco de la     */
/*                                      Produccion                      */
/*      07/Abr/2005     L. Bernuil      Permitir saldo cero             */
/*      04/May/2005     J. Cadena       No se puede aperturar cuentas   */
/*                                      de planilla                     */
/*      14/Jul/2005     L. Bernuil      Ajustes a validacion de casilla */
/*      27/Jul/2005     L. Bernuil      Obtencion de la casilla completa*/
/*      03/Ago/2005     L. Bernuil      Inclusion de Campo de Patente   */
/*      13/Feb/2006     D. Vasquez      Control de Producto-Funcionario */
/*      12/Jul/2006     R. Ramos        Adicion de fideicomiso          */
/*      25/Ago/2006     H.Ayarza        Control Sin Direccion de Est.   */
/*                                      de Cta.                         */
/*      17/Feb/2010     J. Loyo     Manejo de la fecha de efectivizacion*/
/*                                  teniendo el sabado como habil       */
/*      03/May/2011     S. Molano   Manejo Apertura Cuentas Especiales  */
/*      21/Nov/2013     C. Avendaño Agregar var @i_corresponsal Req 381 */
/*      02/May/2016     J. Calderon Migración a CEN                     */
/*      03/Ago/2016     J. Tagle        Productos Dependientes          */
/*      09/Ago/2016     T. Baidal   Se guarda param. @i_estado_cuenta   */
/*      25/Ago/2016     J. Tagle    Guarda campos de ah_cuenta_aux      */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_apertura_ah')
  drop proc sp_apertura_ah
go

create proc sp_apertura_ah
(
  @s_ssn             int,
  @s_ssn_branch      int = null,
  @s_srv             varchar(30),
  @s_lsrv            varchar(30),
  @s_user            varchar(30),
  @s_sesn            int,
  @s_term            varchar(10),
  @s_date            datetime,
  @s_ofi             smallint,/* Localidad origen transaccion */
  @s_rol             smallint = 1,
  @s_org_err         char(1) = null,/* Origen de error:[A], [S] */
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_msg             mensaje = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_rty             char(1) = 'N',
  @t_trn             smallint,
  @t_show_version    bit = 0,
  @i_ofl             smallint = null,
  @i_cli             int,
  @i_nombre          descripcion = null,
  @i_nombre1         descripcion = null,
  @i_cedruc1         varchar(30)= null,
  @i_cedruc          varchar(30),
  @i_cli_ec          int = null,
  @i_direc           tinyint = null,
  @i_tprom           char(1) = null,
  @i_categ           char(1) = null,
  @i_mon             tinyint = null,
  @i_tdef            char(1) = null,
  @i_def             int = null,
  @i_rolcli          char(1),
  @i_rolente         char(1) = '1',
  @i_dprod           int = null,
  @i_ciclo           char(1) = null,
  @i_capit           char(1) = null,
  @i_pers            char(1) = 'N',
  @i_tipodir         char(1) = null,
  @i_casillero       varchar(10) = null,
  @i_agencia         smallint = 11,
  @i_prodbanc        smallint = null,
  @i_origen          varchar(3) = null,
  @i_numlib          int = null,
  @i_valor           money = null,
  @i_cli1            int,
  @i_dep_ini         int = 0,
  @i_promotor        smallint = 0,
  @i_direc_dv        tinyint = null,
  @i_tipodir_dv      char(1) = null,
  @i_casillero_dv    varchar(10) = null,
  @i_agencia_dv      smallint = 0,
  @i_cli_dv          int = null,
  @i_turno           smallint = null,
  @i_estado_cuenta   char(1) = null,
  @i_cuota           money = 0,
  @i_permite_sldcero char(1) = 'N',
  @i_tipocta_super   char(1),
  @i_titularidad     char(1) = 'S',
  @i_numsol          int = null,
  @i_patente         varchar(40),
  @i_atm             char(1) = 'N',
  @i_fideicomiso     varchar(15) = null,--RRB
  @i_cta_banco       cuenta = null,
  @i_plazo           int = null,
  @i_puntos          float = null,
  @i_periodicidad    varchar(10) = null,
  @i_monto_final     money = null,
  @i_contractual     char(1) = null,
  @i_deposito        money = 0,
  @i_profinal        tinyint = null,

  --@i_dias_mora          smallint = null,
  @i_estado          char(1) = null,
  @i_cta_banco_rel   cuenta = null,
  @o_funcio          tinyint = null out,
  @o_cta             cuenta = null out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_cuenta             int,
    @w_cta_banco          varchar(20),
    @w_cliente            int,
    @w_cliente_ec         int,
    @w_actual             int,
    @w_filial             tinyint,
    @w_producto           tinyint,
    @w_tipo               char(1),
    @w_moneda             tinyint,
    @w_autorizante        smallint,
    @w_det_producto       int,
    @w_comentario         descripcion,
    @o_cta_banco          cuenta,/* No out por problema DB LIBRARY */
    @o_det_producto       int,
    @w_descdir_ec         direccion,
    @w_zona               smallint,
    @w_parroquia          int,
    @w_dia_ciclo          varchar(2),
    @w_prx_mes            varchar(10),
    @w_fecha_prx_ec       datetime,
    @w_fecha_prx_corte    varchar(10),
    @w_fecha_nac          datetime,
    @w_fecha_hoy          datetime,
    @w_num_anios          tinyint,
    @w_mayor_edad         tinyint,
    @w_mes_hoy            tinyint,
    @w_mes_nac            tinyint,
    @w_dia_nac            tinyint,
    @w_tmp                tinyint,
    @w_funcionario        char(10),
    @w_aux                char(10),
    @w_dia_hoy            smallint,
    @w_mes_sig            datetime,
    @w_mes_sigc           varchar(10),
    @w_dia_pri            varchar(10),
    @w_ult_dia_mes        datetime,
    @w_ciudad_matriz      int,
    @w_funcio             char(1),
    @w_tipo_ente          char(1),
    @w_telefono           varchar(12),
    @w_cedruc             varchar(30),
    @w_validar            char(1),
    @w_sucursal           smallint,
    @w_sector             smallint,
    @w_tipo_exonerado_imp char(2),
    @w_descdir_dv         direccion,
    @w_zona_dv            smallint,
    @w_parroquia_dv       int,
    @w_meses_prx_capita   integer,
    @w_fecha_prx_capita   datetime,
    @w_cod_super          varchar(2),
    @w_cta_gobierno       char(1),
    @w_tipocta_super      char(1),
    @w_pro_final          smallint,
    @w_ofi_cifrada        smallint,
    @w_oficina_social     tinyint,
    @w_prod_tpl           smallint,
    @w_tipo_documento     varchar(2),
    @w_estado_sol         char(2),
    @w_sol_aprobada       char(1),
    @w_tipo_cedula        varchar(2),
    @w_row                tinyint,
    @w_row1               tinyint,
    @w_sector_barrio      smallint,
    @w_error              int,
    @w_rollback           char(1),
    @w_msg                varchar(64),
    @w_tipo_compania      varchar(10),
    @w_sucursal_t         smallint,
    --Req 381
    @w_estado             char(1),  --Estado de la cuenta de ahorro
    @w_dep_ini            int,  
    @w_me_mercado         smallint,    --codigo de mercado
    @w_prod_fin_dep       smallint,    --producto final dependiente
    @w_producto_ban       smallint,    --producto bancario
    @w_cod_ente           varchar(10),
    @w_cta                cuenta,      -- cta del cliente
    @w_subtipo            char(1),
	@w_dias_plazo          smallint,
	@w_cta_banco_rel      cuenta,
	@w_saldo_max          money

    /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_apertura_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select @i_cedruc = isnull(@i_cedruc,'Sin Identificacion')

  select @w_fecha_hoy = @s_date

  select @i_dep_ini = 1

  if @i_turno is null --FES modificaci¢n por E:SP-TNG-03
    select @i_turno = @s_rol

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_ofl = @i_ofl,
      i_cli = @i_cli,
      i_nombre = @i_nombre,
      i_cli1 = @i_cli1,
      i_nombre1 = @i_nombre1,
      i_cedruc1 = @i_cedruc1,
      i_cedruc = @i_cedruc,
      i_direc = @i_direc,
      i_tprom = @i_tprom,
      i_categ = @i_categ,
      i_mon = @i_mon,
      i_tdef = @i_tdef,
      i_def = @i_def,
      i_rolcli = @i_rolcli,
      i_rolente = @i_rolente,
      i_dprod = @i_dprod,
      i_ciclo = @i_ciclo,
      i_capit = @i_capit,
      i_tipodir = @i_tipodir,
      i_agencia = @i_agencia,
      i_casillero = @i_casillero

    exec cobis..sp_end_debug
  end

  /* Validacion del tipo de transaccion */

  if @t_trn not in (201, 320)
  begin
    /* Error en codigo de transaccion */
    select @w_error = 201048
    goto ERROR
  end

  /* Valida el producto para la oficina */
  if isnull(@s_ofi,0) <> 0
  begin
    exec @w_return = cobis..sp_val_prodofi
      @i_modulo  = 4,
      @i_oficina = @s_ofi
    if @w_return <> 0
      return @w_return
  end

  select
    @w_comentario = 'APERTURA CUENTA DE AHORROS REGIONAL'

  /*Req. 381 21/11/2013 - CAV - Validar que el cliente sea Corresponsal Bancario*/
  if exists(select top 1 *
            from   cobis..cl_catalogo C,
                   cobis..cl_tabla T
            where  T.tabla  = 're_pro_banc_cb'
               and T.codigo = C.tabla
               and C.codigo = convert(char(1), @i_prodbanc))
  begin
    if not exists (select top 1 (1)
                   from   cobis..cl_asoc_clte_serv
                   where  ac_cliente = @i_cli)
    begin
      select
        @w_msg = 'Cliente no es Corresponsal Bancario Red Posicionada',
        @w_error = 253001
      goto ERROR
    end
  end

  /* Se obtiene la filial */
  select @w_filial = of_filial,
         @w_sucursal = isnull(of_sucursal,of_oficina)
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

/* Obtencion del codigo de la ciudad de feriados nacionales para el */
  /* calculo de la fecha de proximo corte                             */

  select @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
  and    pa_nemonico = 'CMA'
  if @@rowcount <> 1
  begin
    /* Error Parametro no encontrado */
    select @w_error = 201196
    goto ERROR
  end

/* VALIDACION PARA QUE LA CUENTA DE SERVICIO SOCIAL (origen = '9') */
  /* SOLO SE APERTURE EN LA OFICINA MATRIZ */

  select @w_oficina_social = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
  and    pa_nemonico = 'OMAT'
  if @@rowcount <> 1
  begin
    /* Error Parametro no encontrado */
    select @w_error = 201196
    goto ERROR
  end

  if @i_origen = '9' and @s_ofi <> @w_oficina_social
  begin
    select @w_error = 251084
    goto ERROR
  end

  if @i_atm = 'S'
    select @i_numsol = 0

  if @i_atm = 'N'
  begin
    -- Validacion de cuentas de tarjetas de planilla
		select @w_prod_tpl = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
		and    pa_nemonico = 'TPL'

    if @@rowcount <> 1
    begin
      /* Error Parametro no encontrado */
		  select @w_error = 201196
      goto ERROR
    end

    if (@i_prodbanc = @w_prod_tpl)
    begin
      /* No se pueden aperturar cuentas de tarjetas de planilla */
		  select @w_error = 251087
      goto ERROR
    end
  end

  /* CHEQUEO DE EXISTENCIAS */
  select
    @w_cliente = en_ente,
    @w_fecha_nac = p_fecha_nac,
    @w_tipo_ente = en_subtipo,
    @w_funcionario = en_tipo_vinculacion,
    @w_tipo_compania = c_tipo_compania
  from   cobis..cl_ente
  where  en_ente = @i_cli
  if @@rowcount = 0
  begin
    /* No existe ente o cedula incorrecta */
    select @w_error = 101042
    goto ERROR
  end

  if @w_tipo_ente = 'I'
  begin
    select @w_ofi_cifrada = oc_oficina
    from   cob_ahorros..ah_oficina_ctas_cifradas
    where  oc_oficina = @s_ofi
    and    oc_estado  = 'V'
    if @@rowcount = 0
    begin
      -- Oficina no autorizada para cuentas cifradas
      select @w_error = 251081
      goto ERROR
    end
  end

  /* Valida si el cliente es oficial o privado INTEGRACION BANCAMIA*/
  if @w_tipo_ente = 'P'
    select @w_tipocta_super = 'P'
  else
  begin
    if @w_tipo_compania = 'PA'
      select @w_tipocta_super = 'P'
    else
      select @w_tipocta_super = 'O'
  end

  /*  Determina parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    @o_producto     = @w_producto out
  if @w_return <> 0
    return @w_return

  select
    @w_dia_hoy = datepart(dd,@w_fecha_hoy)

  ----------------------------------------------------------------------------------
  --Buscar Cuenta de cliente que sea de ese tipo de Prod. Final (solo al Titular)
  ----------------------------------------------------------------------------------   
  if @i_rolcli = 'T'
  begin
  --Buscar Producto Bancario Dependiente
  select @w_producto_ban = @i_prodbanc    
  --Producto bancario
  if not exists (select 1 from cob_remesas..pe_pro_bancario
					 where  pb_pro_bancario = @w_producto_ban
					 and    pb_estado       = 'V')
  begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 351508 --No existe producto bancario    
      return 351508
  end
  --Mercado
  select @w_me_mercado = me_mercado
	  from   cob_remesas..pe_mercado
	  where  me_pro_bancario = @w_producto_ban
	  and    me_tipo_ente    = @w_tipo_ente
	  and    me_estado       = 'V'
  if @@rowcount = 0
  begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 351553 --No existe mercado para el producto bancario y el tipo de ente
      return 351553
  end
	  select @w_subtipo = of_subtipo
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  if @w_subtipo = 'O'
		  select @w_sucursal = of_regional
      from   cobis..cl_oficina
      where  of_oficina = @s_ofi
  else
		  select @w_sucursal = @s_ofi

  --Producto final y Dependiente
	  select @w_prod_fin_dep = pf_depende
	  from   cob_remesas..pe_pro_final
	  where  pf_mercado  = @w_me_mercado
	  and    pf_moneda   = @i_mon
	  and    pf_producto = @w_producto
	  and    pf_sucursal = @w_sucursal
  if @@rowcount = 0
  begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 351553 --No existe mercado para el producto bancario y el tipo de ente
      return 351553
  end  
  if not (@w_prod_fin_dep is null) -- si tiene dependencia
  begin
      ----------------------------------------------------------------------------------
      --Buscar Cuenta de cliente que sea de ese tipo de Prod. Final
      --Producto Dependiente como base
      select 
      @w_prod_fin_dep = pf_pro_final,
      @w_me_mercado   = pf_mercado,
      @w_producto     = pf_producto
      from cob_remesas..pe_pro_final
      where pf_pro_final = @w_prod_fin_dep
      if @@rowcount = 0
      begin
          exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 357564 --NO EXISTE PRODUCTO FINAL DEPENDIENTE
          return 357564
      end  
      --Mercado
      select @w_producto_ban  = me_pro_bancario,
             @w_tipo_ente     = me_tipo_ente
      from cob_remesas..pe_mercado
      where me_mercado = @w_me_mercado
        and me_estado       = 'V'
      if @@rowcount = 0
      begin
          exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 357565 --NO EXISTE MERCADO PARA PRODUCTO FINAL DEPENDIENTE
          return 357565
      end        
      --Producto bancario
      if not exists (select 1 from cob_remesas..pe_pro_bancario
                     where pb_pro_bancario = @w_producto_ban
                       and pb_estado       = 'V')
      begin
          exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 357566 --NO EXISTE PRODUCTO BANCARIO DEPENDIENTE
          return 357566
      end
      ----------------------------------------------------------------------------------
      --Buscar Cuenta de ese tipo de Prod Bancario
		  select @w_cta = ah_cuenta
		  from   cob_ahorros..ah_cuenta
		  where  ah_cliente   = @i_cli -- @w_cod_ente
		  and    ah_moneda    = @i_mon
		  and    ah_prod_banc = @w_producto_ban
		  and    ah_estado    = 'A'
      if @@rowcount < 1
      begin
          /* CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA */
          exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
				  @i_msg   = 'CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA',
              @i_num   = 357563
          return 357563
      end
  end
  end
  ----------------------------------------------------------------------------------
  --FIN Buscar Cuenta de cliente que sea de ese tipo de Prod. Final
  ----------------------------------------------------------------------------------      
                          
                          
  begin tran

/* 1era. llamada al SP debe ser con 'T' por det_producto con el */
  /* titular de la cuenta                                         */

  if @i_rolcli = 'T'
  begin
    /* Verificacion de que si la categoria es E (Extranjera) entonces el numero de solicitud debe ser verificado */
    if (@w_tipo_documento <> @w_tipo_cedula and @w_tipo_ente = 'P')
    begin
		  select @w_estado_sol = ''

		  select @w_estado_sol = sc_estado
      from   ah_solicitud_cuenta,
             ah_clicta_solicitud
      where  sc_numsol = cs_numsol
		  and    cs_tipo   = 'T'
		  and    cs_codigo = @i_cli
		  and    sc_numsol = @i_numsol
		  and    sc_estado in ('AP')

      if @w_estado_sol = ''
      begin
			select @w_sol_aprobada = 'N'
        /* El Numero de Solicitud no esta aprobada */
			select @w_error = 201304
        goto ERROR
      end
      else
			select @w_sol_aprobada = 'S'
    end

    /* Validacion que el cliente titular de la cuenta sea un funcionario */
    select @w_aux = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
    and    pa_nemonico = 'CFU'

    if @w_funcionario <> @w_aux
    begin
		  if (select count(1)
          from   cobis..cl_catalogo
			  where  tabla in (select codigo
                  from   cobis..cl_tabla
                  where  tabla = 'ah_producto_funcionario')
							   and    codigo = convert(varchar(10), @i_prodbanc)
							   and    estado = 'V') > 0
      begin
				select @w_error = 201108
        goto ERROR
      end
      else
      begin
				select @o_funcio = 0
				select @w_funcio = 'N'
      end
    end
    else
    begin
		  if (select count(1)
          from   cobis..cl_catalogo
			  where  tabla in (select codigo
                  from   cobis..cl_tabla
                  where  tabla = 'ah_producto_funcionario')
							   and    codigo = convert(varchar(10), @i_prodbanc)
							   and    estado = 'V') > 0
      begin
				select @o_funcio = 1
				select @w_funcio = 'S'
      end
      else
      begin
				select @o_funcio = 0
				select @w_funcio = 'N'
      end
    end

    select @w_sucursal_t = isnull(of_sucursal,of_regional)
    from   cobis..cl_oficina
    where  of_oficina = @w_sucursal

    select distinct @w_pro_final = pf_pro_final
    from   cob_remesas..pe_pro_final,
           cob_remesas..pe_mercado,
           cob_remesas..pe_pro_bancario
    where  pf_filial       = @w_filial
    and    pf_sucursal     = @w_sucursal_t
    and    pf_producto     = @w_producto
    and    pf_moneda       = @i_mon
    and    me_tipo_ente    = @w_tipo_ente
    and    pf_tipo         = 'R'
    and    me_mercado      = pf_mercado
    and    me_pro_bancario = pb_pro_bancario
    and    me_pro_bancario = @i_prodbanc

    if @@rowcount <> 1
    begin
      /* Error Producto para tipo ente Titular  */
      select @w_error = 201203
      goto ERROR
    end

    /* Validacion de la existencia del oficial de credito */
    if @i_ofl = 0
    begin
      /* Oficial no puede ser cero */
      select @w_error = 101036
      if @i_atm = 'S'
        select @w_rollback = 'S'
      goto ERROR
    end

    if not exists (select oc_oficial
                   from   cobis..cc_oficial
                   where  oc_oficial = @i_ofl)
    begin
      /* No existe oficial */
      select @w_error = 101036
      if @i_atm = 'S'
        select @w_rollback = 'S'
      goto ERROR
    end

    /* Validacion de la categoria */
    exec @w_return = cobis..sp_catalogo
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_categoria',
      @i_operacion = 'E',
      @i_codigo    = @i_categ
    if @w_return <> 0
    begin
      /* No existe categoria */
      select @w_error = 201018
      goto ERROR
    end

    /* Validacion de la moneda */
    if not exists (select mo_moneda
                   from   cobis..cl_moneda
                   where  mo_moneda = @i_mon)
    begin
      /* No existe moneda */
      select @w_error = 101045
      if @i_atm = 'S'
        select @w_rollback = 'S'
      goto ERROR
    end

    /* Validacion del tipo de promedio */
    exec @w_return = cobis..sp_catalogo
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_tpromedio',
      @i_operacion = 'E',
      @i_codigo    = @i_tprom
    if @w_return <> 0
    begin
      /* No existe tipo de promedio */
      select @w_error = 201019
      goto ERROR
    end

  /* Obtencion de la descripcion de la direccion del estado de cuenta */
    /* la zona y la parroquia (subzona)                                 */
    select
      @w_zona = 0,
      @w_parroquia = 0,
      @w_sector = 0

    if @i_tipodir = 'D'
    begin
      select @w_descdir_ec = rtrim(ltrim(di_descripcion)),
             @w_parroquia = isnull(di_ciudad,0)
      from   cobis..cl_direccion
      where  di_ente      = @i_cli_ec
      and    di_direccion = @i_direc
    end

    if @i_tipodir = 'C'
    begin
      select
        @w_descdir_ec = cs_emp_postal + ' - ' + cs_valor + char(13) +
                            pv_descripcion
                                   + ' REP. ' +
                                   pa_descripcion,
        @w_parroquia = isnull(cs_ciudad,
                              0),
        @w_zona = cs_provincia,
        @w_sector_barrio = 0
      from   cobis..cl_casilla x,
             cobis..cl_provincia,
             cobis..cl_pais
      where  cs_ente    = @i_cli_ec
      and    cs_casilla = @i_direc
      and    cs_provincia is not null
    end

    if @i_tipodir = 'R'
    begin
      select @w_descdir_ec = 'RETENCION EN ' + of_nombre
      from   cobis..cl_oficina
      where  of_filial  = @w_filial
      and    of_oficina = @i_agencia

      select @i_cli_ec = 0,
        @i_direc = 0
    end

    if @i_tipodir = 'S'
    begin
      if @i_casillero is not null
        select @w_descdir_ec = 'CASILLERO # ' + @i_casillero

      select @i_cli_ec = 0,
        @i_direc = 0
    end

    if @i_tipodir = 'N'
    begin
      select @w_descdir_ec = 'NO IMPRIME ESTADO CUENTA'
      select @i_cli_ec = 0,
        @i_direc = 0
    end

    if isnull(@w_descdir_ec,' ') = ' ' and @i_estado_cuenta = 'S' --HA20060831
    begin
      select @w_error = 252072
      goto ERROR
    end

  /* Obtencion de la descripcion de la direccion de cheques devueltos */
  /* zona = provincia = departamento                                  */
    /* parroquia = ciudad = municipio                                   */

    select @w_zona_dv = 0
    select @w_parroquia_dv = 0

    if @i_tipodir_dv = 'D'
    begin
      select @w_descdir_dv = rtrim(ltrim(di_descripcion)),
             @w_parroquia_dv = isnull(di_ciudad,0)
      from   cobis..cl_direccion
      where  di_ente      = @i_cli_dv
      and    di_direccion = @i_direc_dv
    end

    if @i_tipodir_dv = 'C'
    begin
      select
        @w_descdir_dv = cs_valor + ' | '
                        + (select
                             zp_descripcion
                           from   cobis..cl_codpos
                           where  zp_coddep  = x.cs_provincia
                              and zp_codzona = x.cs_emp_postal)
                        + ' | '
                        + (select
                             pv_descripcion
                           from   cobis..cl_provincia
                           where  pv_provincia = x.cs_provincia),
        @w_parroquia_dv = isnull(cs_ciudad,
                                 0),
        @w_zona_dv = cs_provincia
      from   cobis..cl_casilla x,
             cobis..cl_provincia,
             cobis..cl_pais
      where  cs_ente    = @i_cli_dv
      and    cs_casilla = @i_direc_dv
      and    cs_provincia is not null

    /*         select @w_descdir_dv    = cs_valor+' | '+sc_descripcion,
                    @w_parroquia_dv  = isnull(cs_ciudad,0),
                    @w_zona_dv       = cs_provincia
             from  cobis..cl_casilla, cobis..cl_suc_correo
             where cs_ente      = @i_cli_dv
             and   cs_casilla   = @i_direc_dv
             and   cs_sucursal  = sc_sucursal
             and   cs_provincia = sc_provincia
             and   cs_provincia is not null
    
             if @@rowcount = 0
             begin
                select @w_descdir_dv = cs_valor +' | ' + pv_descripcion,
                       @w_parroquia_dv   = isnull(cs_ciudad,0),
                       @w_zona_dv        = isnull(cs_provincia,0)
                from   cobis..cl_casilla,
                       cobis..cl_provincia
                where  cs_ente       = @i_cli_dv
                and    cs_casilla    = @i_direc_dv
                and    pv_provincia  = cs_provincia
                --and    cs_provincia is null
                --and    ci_pais       = pa_pais
    
                if @@rowcount = 0
                begin
                   select @w_error = 201098 
                   goto ERROR
                end
             end*/
    end

    if @i_tipodir_dv = 'R'
    begin
      select @w_descdir_dv = 'RETENCION EN ' + of_nombre
      from   cobis..cl_oficina
      where  of_filial  = @w_filial
      and    of_oficina = @i_agencia_dv

      select @i_cli_dv = 0,
        @i_direc_dv = 0
    end

    if @i_tipodir_dv = 'S'
    begin
      if @i_casillero_dv is not null
        select @w_descdir_dv = 'CASILLERO # ' + @i_casillero_dv
      select
        @i_cli_dv = 0,
        @i_direc_dv = 0
    end

    if isnull(@w_descdir_dv,' ') = ' ' --HA20060831
    begin
      select @w_error = 252073
      goto ERROR
    end

    select
      @w_telefono = null

    --Consulta telefono de Cliente registrado para enviar estado de cuenta
    select @w_telefono = te_valor
    from   cobis..cl_telefono
    where  te_ente       = @i_cli_ec
    and    te_direccion  = @i_direc
    and    te_secuencial = 1

    if @w_telefono is null
    begin
      set rowcount 1
      select @w_telefono = te_valor
      from   cobis..cl_telefono
      where  te_ente = @i_cli_ec

      if @w_telefono is null
      begin
        --Si Cliente registrado para enviar estado de cuenta no tiene telefono se toma primer telefono del titular
        set rowcount 1
        select @w_telefono = te_valor
        from   cobis..cl_telefono
        where  te_ente = @i_cli

        if @w_telefono is null
          select @w_telefono = 'XXXXXX'
      end
      set rowcount 0
    end

    /* Calculo de la fecha del proximo corte de estado de cuenta */
    if @i_ciclo = '3'
    begin
      select @w_mes_sig = dateadd(mm,1,@w_fecha_hoy)
      select @w_mes_sigc = convert(varchar(10), @w_mes_sig, 101)
      select @w_dia_pri = substring(@w_mes_sigc, 1, 3) + '01' + substring(@w_mes_sigc,6,5)

    /*** La determinacion del anterior dia laboral  se           ****/
      /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
      exec @w_return = cob_remesas..sp_fecha_habil
        @i_val_dif       = 'N',
        @i_efec_dia      = 'S',
        @i_fecha         = @w_dia_pri,
        @i_oficina       = @s_ofi,
        @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
        @w_dias_ret      = -1,/*** Dia anterior habil          ***/
        @i_finsemana     = 'N',
        /*** No tiene en cuenta el sabado como festivo ***/
        @o_ciudad_matriz = @w_ciudad_matriz out,
        @o_fecha_sig     = @w_ult_dia_mes out

      if @w_return <> 0
        return @w_return

      select
        @w_fecha_prx_corte = convert(varchar(10), @w_ult_dia_mes, 101)

    end
    else
    begin
      select @w_dia_ciclo = substring(valor,1,2)
      from   cobis..cl_catalogo
      where  tabla  = (select codigo
                       from   cobis..cl_tabla --    EGA10AGO95    
                       where  tabla = 'cc_ciclo')
      and    codigo = @i_ciclo

      select @w_tmp = convert(tinyint, @w_dia_ciclo)
      if @w_dia_hoy < @w_tmp
      begin
        select @w_prx_mes = convert(varchar(10), @w_fecha_hoy, 101)
        select @w_fecha_prx_corte = substring(@w_prx_mes, 1, 3) + @w_dia_ciclo + substring(@w_prx_mes, 6, 5)
      end
      else
      begin
        select @w_prx_mes = convert(varchar(10), dateadd(month,1,@w_fecha_hoy), 101)
        select @w_fecha_prx_corte = substring(@w_prx_mes, 1, 2) + '/' + @w_dia_ciclo + '/' + substring(@w_prx_mes, 7, 4)
      end

    /****** En este caso envian a validar la fecha actual y si es festivo se regresan un dia *****/
      /****** Por ello a la fecha le sumamos un dia e invocamos el sp restando un dia          *****/

      select @w_fecha_prx_ec = dateadd(dd,1,convert(datetime, @w_fecha_prx_corte, 101))

    /*** La determinacion del anterior dia laboral  se          ****/
      /*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
      exec @w_return = cob_remesas..sp_fecha_habil
        @i_val_dif       = 'N',
        @i_efec_dia      = 'S',
        @i_fecha         = @w_fecha_prx_ec,
        @i_oficina       = @s_ofi,
        @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
        @w_dias_ret      = -1,/*** Dia anterior habil          ***/
        @i_finsemana     = 'N',
        /*** No tiene en cuenta el sabado como festivo ***/
        @o_ciudad_matriz = @w_ciudad_matriz out,
        @o_fecha_sig     = @w_fecha_prx_ec out

      if @w_return <> 0 or @@error <> 0
        return @w_return

      select @w_fecha_prx_corte = convert(varchar(10), @w_fecha_prx_ec, 101)
    end

    if @i_capit = 'D'
    begin
      select @w_fecha_prx_capita = @w_fecha_hoy
    end
    else
    begin
      if @i_capit = 'M'
        select @w_meses_prx_capita = datepart(mm,@w_fecha_hoy)
      if @i_capit = 'B'
        select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 2) + 1
      if @i_capit = 'T'
        select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 3) + 1
      if @i_capit = 'S'
        select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 6) +1

      select @w_ult_dia_mes = pe_fecha_fin
      from   cob_ahorros..ah_periodo
      where  pe_capitalizacion = @i_capit
      and    pe_periodo        = @w_meses_prx_capita

      if @w_ult_dia_mes is null
      begin
        select
          @w_error = 251010,
          @w_msg = 'NO EXISTE PERIODO DE CAPITALIZACION'
        goto ERROR
      end

    /****** En este caso envian a validar la fecha actual y si es festivo se regresan un dia *****/
      /****** Por ello a la fecha le sumamos un dia e invocamos el sp restando un dia          *****/
      select
        @w_ult_dia_mes = convert(datetime, dateadd(dd,1,@w_ult_dia_mes), 101)

    /*** La determinacion del anterior dia laboral  se             ****/
      /*** hace mediante el llamado al siguiente sp  - JLOYO         ****/
      exec @w_return = cob_remesas..sp_fecha_habil
        @i_val_dif       = 'N',
        @i_efec_dia      = 'S',
        @i_fecha         = @w_ult_dia_mes,
        @i_oficina       = @s_ofi,
        @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
        @w_dias_ret      = -1,/*** Dia anterior habil          ***/
        @i_finsemana     = 'N',
        /*** No tiene en cuenta el sabado como festivo ***/
        @o_ciudad_matriz = @w_ciudad_matriz out,
        @o_fecha_sig     = @w_ult_dia_mes out

      if @w_return <> 0 or @@error <> 0
        return @w_return
      select
        @w_fecha_prx_capita = @w_ult_dia_mes
    end

    /* CREACION DEL NUMERO DE CUENTA DE AHORROS */
    select
      @w_aux = convert(char(10), @w_producto)

  /**EN @i_tipo_cta SE DEBE ENVIAR EL PRODUCTO FINAL; YA QUE LOS PREFIJOS DE NUMEROS DE CUENTA**/
    /**SE DEFINEN POR PRODUCTO FINAL. ANTES SE ENVIABA EL PRODUCTO BANCARIO**/

    exec @w_return = cob_ahorros..sp_crea_num_ctah
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_cli        = @i_cli,
      @i_filial     = @w_filial,
      @i_oficina    = @s_ofi,
      @i_producto   = @w_producto,
      @i_tipo_cta   = @i_prodbanc,
      @i_mon        = @i_mon,
      @o_cuenta_int = @w_cuenta out,
      @o_cta_banco  = @w_cta_banco out
    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end
    /* Retorno del numero de cuenta al frontend  */
    select
      @o_cta_banco = @w_cta_banco
    select
      @o_cta = @w_cta_banco

    /* REQ 381 Activa la cuenta de corresponsalÝa sin necesidad de deposito inicial */
    if exists(select (1)
              from   cobis..cl_asoc_clte_serv
              where  ac_cliente = @i_cli
              and    @i_prodbanc in (select C.codigo
                      from   cobis..cl_tabla T,
                             cobis..cl_catalogo C
                      where  T.tabla  = 're_pro_banc_cb'
                                     and    T.codigo = C.tabla))
    begin
      select @w_dep_ini = 0,
        @w_estado = 'A'
    end
    else
    begin
      select @w_dep_ini = @i_dep_ini,
        @w_estado = 'G'
    end

    select @w_validar = 'S'
    /* INSERCION EN LA TABLA AH_CUENTA */

    -- print '@w_cuenta:' + cast(@w_cuenta as varchar)
    -- print '@o_cta_banco:' + @o_cta_banco
    insert into cob_ahorros..ah_cuenta
                (ah_cuenta,ah_cta_banco,ah_filial,--1
                 ah_oficina,ah_oficial,
                 ah_fecha_aper,--2
                 ah_cliente,ah_ced_ruc,ah_estado,--3
                 ah_ciclo,
                 ah_categoria,ah_disponible,--4
                 ah_12h,ah_24h,--5
                 ah_remesas,
                 ah_rem_hoy,--6
                 ah_fecha_ult_mov,ah_fecha_ult_upd,--7
                 ah_producto,ah_tipo,--8
                 ah_control,ah_ult_linea,ah_moneda,--9
                 ah_default,ah_tipo_def,--10
                 ah_tipo_promedio,ah_promedio1,ah_promedio2,--11
                 ah_promedio3,ah_promedio4,
                 ah_promedio5,--12
                 ah_promedio6,ah_bloqueos,ah_suspensos,--13
                 ah_nombre,
                 ah_interes,ah_saldo_libreta,--14
                 ah_saldo_ult_corte,ah_48h,ah_condiciones,--15
                 ah_saldo_ayer,ah_monto_bloq,ah_descripcion_ec,--16
                 ah_direccion_ec,ah_fecha_prx_corte,
                 ah_zona,--17
                 ah_parroquia,ah_cliente_ec,--18
                 ah_rol_ente,ah_num_blqmonto,
                 ah_saldo_interes,--19
                 ah_creditos,ah_debitos,ah_linea,--20
                 ah_capitalizacion,
                 ah_saldo_anterior,--21
                 ah_fecha_ult_corte,ah_personalizada,ah_interes_ganado,--22
                 ah_cta_funcionario,
                 ah_cred_24,ah_cred_rem,--23
                 ah_tipocta,ah_tipo_dir,ah_agen_ec,--24
                 ah_contador_trx,ah_creditos_hoy,ah_debitos_hoy,--25
                 ah_fecha_ult_capi,ah_prom_disponible,
                 ah_prod_banc,--26
                 ah_fecha_ult_mov_int,ah_origen,ah_numlib,--27
                 ah_dep_ini,
                 ah_contador_firma,ah_telefono,ah_int_hoy,--28
                 ah_12h_dif,ah_min_dispmes,
                 ah_fecha_ult_ret,ah_cliente1,--29
                 ah_nombre1,ah_cedruc1,--30
                 ah_sector,
                 ah_tasa_hoy,--31
                 ah_monto_imp,ah_monto_consumos,ah_promotor,--32
                 ah_direccion_dv,
                 ah_tipodir_dv,ah_descripcion_dv,ah_parroquia_dv,-- 33
                 ah_zona_dv,ah_agen_dv,
                 ah_cliente_dv,ah_traslado,ah_fecha_prx_capita,-- 34
                 ah_tipocta_super,ah_int_mes,
                 ah_aplica_tasacorp,ah_monto_emb,--35
                 ah_monto_ult_capi,ah_saldo_mantval,ah_cuota,--36
                 ah_creditos2,ah_creditos3,ah_creditos4,ah_creditos5,
                 ah_creditos6,
                 --37
                 ah_debitos2,ah_debitos3,ah_debitos4,ah_debitos5,ah_debitos6,
                 --38
                 ah_ctitularidad,ah_tasa_ayer,ah_estado_cuenta,
                 ah_permite_sldcero,
                 --39
                 ah_rem_ayer,
                 ah_numsol,ah_patente,ah_fideicomiso,ah_clase_clte) --40
    values      (@w_cuenta,@o_cta_banco,@w_filial,--1
                 @s_ofi,@i_ofl,
                 @s_date,--2
                 @i_cli,@i_cedruc,@w_estado,--3
                 @i_ciclo,
                 @i_categ,$0,--4
                 $0,$0,--5
                 $0,
                 $0,--6
                 @s_date,@s_date,--7
                 @w_producto,'R',--8
                 0,0,@i_mon,--9
                 @i_def,@i_tdef,--10
                 @i_tprom,$0,$0,--11
                 $0,$0,
                 $0,--12
                 $0,0,0,--13
                 @i_nombre,
                 $0,$0,--14
                 $0,$0,0,--15
                 $0,$0,@w_descdir_ec,--16
                 @i_direc,@w_fecha_prx_corte,
                 @w_zona,--17
                 @w_parroquia,@i_cli_ec,--18
                 @i_rolente,0,
                 $0,--19
                 $0,$0,0,--20
                 @i_capit,
                 $0,--21
                 dateadd(dd,-1,@s_date),@i_pers,$0,--22
                 @w_funcio,'N','N',--23
                 @w_tipo_ente,@i_tipodir,@i_agencia,--24
                 0,0,0,--25
                 dateadd(dd,-1,@w_fecha_hoy),$0,
                 @i_prodbanc,--26  
                 dateadd(dd,-1,@s_date),@i_origen,@i_numlib,--27
                 @w_dep_ini,
                 0,@w_telefono,$0,--28
                 $0,-1,
                 @s_date,@i_cli1,--29
                 @i_nombre1,@i_cedruc1,--30
                 @w_sector,
                 0,--31
                 $0,$0,@i_promotor,--32
                 @i_direc_dv,
                 @i_tipodir_dv,@w_descdir_dv,@w_parroquia_dv,-- 33
                 @w_zona_dv,@i_agencia_dv,
                 @i_cli_dv,'N',@w_fecha_prx_capita,-- 34
                 @i_tipocta_super,0,
                 'N',0,--35    lgr tipo_super
                 $0,$0,@i_cuota,--36
                 $0,$0,$0,$0,$0,--37
                 $0,$0,$0,$0,$0,--38
                 @i_titularidad,0.0,@i_estado_cuenta,@i_permite_sldcero,
                 --39    REQ 306 ESTADO INGRESADA
                 $0,
                 @i_numsol,@i_patente,@i_fideicomiso,@w_tipocta_super) --40
    select @w_error = @@error
    if @w_error <> 0
    begin
      /* Error en creacion de registro en ah_cuenta */
      print '@ERROR_MESSAGE:' + cast(@w_error as varchar)
      select @w_error = 253001
      goto ERROR
    end

	-- //////////////////////////////////////////////////////////
	-- Busqueda de valores para ah_cuenta_aux
	-- Si producto bancario es de aporte social adicional
	if (@i_prodbanc in (select pa_int from   cobis..cl_parametro where  pa_producto = 'AHO' and  (pa_nemonico = 'PCAASO' OR pa_nemonico = 'PCAASA' )))
	begin
		-- guardar cta_banco_rel
		select @w_cta_banco_rel = @i_cta_banco_rel
		-- guardar dias_capi
		select @w_dias_plazo = isnull(cp_dias_plazo,0)
		from cob_remesas..pe_categoria_profinal
		where cp_profinal in ( select pf_pro_final 
		                       from   cob_remesas..pe_pro_final
		                       where  pf_mercado in (select me_mercado
							                         from   cob_remesas..pe_mercado
							                         where  me_pro_bancario = @i_prodbanc
							                         and    me_tipo_ente    = @w_tipo_ente
							                         and    me_estado       = 'V'
							                         )
							   )							   
		and cp_categoria = @i_categ
		
		if (@w_dias_plazo = 0) and (@i_prodbanc in (select pa_int from   cobis..cl_parametro where  pa_producto = 'AHO' and pa_nemonico = 'PCAASA' ))
		begin
		 -- En cuentas de aporte social es necesario el plazo en dias
			exec cobis..sp_cerror --  NO EXISTE PLAZO EN DIAS PARA PRODUCTO BANCARIO 
				 @t_from = @w_sp_name,
				 @i_num  = 357568,  
				 @i_sev  = 0,
				 @i_msg  = 'NO EXISTE PLAZO EN DIAS PARA PRODUCTO BANCARIO'
			return 357568		
		end
		
		-- guardar saldo_max
		/* VERIFICACION MONTO APORTE SOCIAL */      
		exec @w_return = cob_remesas..sp_genera_costos
		@i_categoria   = @i_categ,
		@i_tipo_ente   = @w_tipo_ente,
		@i_rol_ente    = @i_rolente,
		@i_tipo_def    = @i_tdef,
		@i_prod_banc   = @i_prodbanc,
		@i_producto    = @w_producto,
		@i_moneda      = @i_mon,
		@i_tipo        = 'R',
		@i_codigo      = @i_def,
		@i_servicio    = 'SMC',   -- SALDO
		@i_rubro       = 'SMA',   -- SALDO MAXIMO
		@i_disponible  = 0,
		@i_contable    = 0,
		@i_promedio    = 0,
		@i_personaliza = @i_pers,
		@i_filial      = @w_filial,
		@i_oficina     = @s_ofi,
		@i_fecha       = @s_date,
		@o_valor_total = @w_saldo_max out
		if @w_return <> 0
		return @w_return
	  
		if @w_saldo_max is null
		begin
			exec cobis..sp_cerror -- MONTO DE APORTE SOCIAL NO EXISTE
				 @t_from = @w_sp_name,
				 @i_num  = 357568,  
				 @i_sev  = 0,
				 @i_msg  = 'MONTO DE APORTE SOCIAL NO EXISTE'
			return 357568
		end		
		insert into cob_ahorros..ah_cuenta_aux
		            (ca_cuenta,        ca_cta_banco,
					 ca_cta_banco_rel, ca_dias_plazo,
					 ca_saldo_max)
		values      (@w_cuenta,        @w_cta_banco,
					 @w_cta_banco_rel, @w_dias_plazo,
					 @w_saldo_max)
        select @w_error = @@error
    if @w_error <> 0
    begin
      /* Error en creacion de registro en ah_cuenta */
      print '@ERROR_MESSAGE:' + cast(@w_error as varchar)
            select @w_error = 253001
      goto ERROR
    end
    
	end	
	-- //////////////////////////////////////////////////////////

    /* Creacion de transaccion de servicio */
    insert into cob_ahorros..ah_tsapertura
                (secuencial,ssn_branch,tipo_transaccion,oficina,usuario,
                 terminal,reentry,clase,tsfecha,origen,
                 cuenta,cta_banco,filial,oficial,fecha_aper,
                 cliente,ced_ruc,estado,direccion_ec,ciclo,
                 categoria,producto,tipo,moneda,def,
                 tipo_def,rol_ente,tipo_promedio,alterno,descripcion_ec,
                 cliente_ec,capitalizacion,ctafun,mercantil,tipocta,
                 producto_bancario,origen_cta,numlib,oficina_cta,nombre1,
                 cedula1,promotor,direccion_dv,tipodir_dv,descripcion_dv,
                 tipocta_super,turno,prod_banc,fideicomiso,
				 valor, dias_plazo, cta_relacionada)
    values      ( @s_ssn,isnull(@s_ssn_branch,@s_ssn),@t_trn,@s_ofi,@s_user,
                  @s_term,@t_rty,'N',@s_date,'L',
                  @w_cuenta,@o_cta_banco,@w_filial,@i_ofl,@s_date,
                  @i_cli,@i_cedruc,'G',@i_direc,@i_ciclo,
                  @i_categ,@w_producto,'R',@i_mon,@i_def,
                  @i_tdef,@i_rolente,@i_tprom,10,@w_descdir_ec,
                  @i_cli_ec,@i_capit,@w_funcio,'N',@w_tipo_ente,
                  @i_prodbanc,@i_origen,@i_numlib,@s_ofi,@i_nombre1,
                  @i_cedruc1,@i_promotor,@i_direc_dv,@i_tipodir_dv,@w_descdir_dv,
                  @i_tipocta_super,@i_turno,@i_prodbanc,@i_fideicomiso,
				  @w_saldo_max, @w_dias_plazo, @w_cta_banco_rel)

    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicio */
      select @w_error = 203005
      goto ERROR
    end

    /* Update a la tabla de solicitudes como aperturada */
    if @i_numsol is not null
    begin
      update cob_ahorros..ah_solicitud_cuenta
      set    sc_estado = 'PR'
      where  sc_numsol = @i_numsol

      if @@error <> 0
      begin
        /* Error en actualizacion de solicitud */
        select @w_error = 203005
        goto ERROR
      end
    end

    /* Insercion en la tabla cl_det_producto */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_det_producto',
      @o_siguiente = @w_det_producto out
    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end

    /* Insercion de la tabla cl_det_producto */
    select @w_autorizante = fu_funcionario
    from   cobis..cl_funcionario
    where  fu_login = @s_user

    insert into cobis..cl_det_producto
                (dp_det_producto,dp_filial,dp_oficina,dp_producto,dp_tipo,
                 dp_moneda,dp_fecha,dp_comentario,dp_monto,dp_tiempo,
                 dp_cuenta,dp_estado_ser,dp_autorizante,dp_oficial_cta,dp_cliente_ec,
                 dp_direccion_ec,dp_descripcion_ec)
    values      ( @w_det_producto,@w_filial,@s_ofi,@w_producto,'R',
                  @i_mon,@s_date,@w_comentario,@i_valor,null,
                  @o_cta_banco,'V',@w_autorizante,@i_ofl,@i_cli,
                  @i_direc,@w_descdir_ec)

    if @@error <> 0
    begin
      /* Error en creacion de registro en cl_det_producto */
      select @w_error = 103050
      goto ERROR
    end

    /* Insercion en la tabla cl_cliente */
    exec @w_return = cobis..sp_in_cliente
      @i_cli     = @i_cli,
      @i_dprod   = @w_det_producto,
      @i_rol     = @i_rolcli,
      @i_cedruc  = @i_cedruc,
      @i_fecha   = @s_date,
      @i_validar = @w_validar
    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end

    if @i_contractual = 'S'
    begin
      exec @w_return = cob_remesas..sp_mto_aho_contractual
        @s_ssn          = @s_ssn,
        @s_date         = @s_date,
        @s_user         = @s_user,
        @s_term         = @s_term,
        @t_trn          = 723,
        @i_oficina      = @s_ofi,
        @i_prodban      = @i_prodbanc,
        @i_modulo       = @w_producto,
        @i_profinal     = @i_profinal,
        @i_cta_banco    = @o_cta_banco,
        @i_tipoente     = @w_tipo_ente,
        @i_categoria    = @i_categ,
        @i_operacion    = 'I',
        @i_plazo        = @i_plazo,
        @i_puntos       = @i_puntos,
        @i_cuota        = @i_deposito,
        @i_periodicidad = @i_periodicidad,
        @i_monto_final  = @i_monto_final,
        --@i_dias_mora    = @i_dias_mora,
        @i_estado       = @i_estado

      if @w_return <> 0
      begin
        if @i_atm = 'S'
          rollback tran
        return @w_return
      end
    end
    /* Actualizacion en cl_ente */
    update cobis..cl_ente
    set    en_cliente = 'S'
    where  en_ente = @i_cli

    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end

    /* 10/01/2002  -- Verificar si se va a usar
    
    /* Inserta en la tabla de exonerados del IDB */
    select @w_tipo_exonerado_imp = ei_tipo_exonerado
    from   cobis..cl_exonerado_idb
    where  ei_rif = @i_cedruc
    
    if @@rowcount = 1
    begin
      insert into cob_remesas..re_exoneracion_impuesto
              (ei_producto, ei_cuenta, ei_tipo_exonerado_imp)
      values ('AHO', @w_cuenta, @w_tipo_exonerado_imp)
    
      if @@error <> 0
      begin
         /* Error en creacion de registro en re_exoneracion_imp */
         select @w_error = 203060 
         goto ERROR
      end
    end
    
    ----   */
    if exists (select 1
               from   cobis..cl_saldo_embargo
               where  se_cliente = @i_cli
               and    se_estado  = 'V')
    begin /** Si existe algun embargo para el cliente ***/
      exec @w_return = cobis..sp_saldo_min_embargado
        @s_srv      = @s_srv,
        @s_user     = @s_user,
        @s_term     = @s_term,
        @s_ofi      = @s_ofi,
        @s_date     = @s_date,
        @t_trn      = 1423,
        @i_oper     = 'N',
        @i_cliente  = @i_cli,
        @i_producto = 4,
        @i_num_cta  = @o_cta_banco
      if @w_return <> 0
      begin
        select @w_error = @w_return
        goto ERROR
      end
    end

    select @o_det_producto = @w_det_producto

    select
      @o_cta_banco,
      @w_fecha_prx_corte,
      @o_det_producto

    /*Insercion de clientes para firma de tarjeta */
    if exists(select 1 
                from cobis..cl_producto 
               WHERE pd_producto = 5)
    begin
        if not exists(select 1 
                      from   firmas..fi_control_impresion
                      where  ci_producto  = @w_producto
                      and    ci_cta_banco = @o_cta_banco
                      and    ci_cliente   = @i_cli)
        begin
          insert into firmas..fi_control_impresion
                      (ci_cta_banco,ci_producto,ci_cliente,ci_firma,ci_condicion,
                       ci_combinacion,ci_fec_ult_imp,ci_fec_ult_mod,ci_usuario_imp,
                       ci_usuario_mod,
                       ci_estado)
          values      (@o_cta_banco,@w_producto,@i_cli,'S','N',
                       'N',null,@s_date,null,@s_user,
                       'V')

        end
        else
        begin
          /* OJO .. REVISAR ERROR */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 303007
          return 1
        end
    end
  end
  else
  begin
  /* Insercion en la tabla de embargos para el resto de clientes */
    /* Cotitulares                                               */

    if @i_rolcli = 'C'
    begin
      if exists (select 1
                 from   cobis..cl_saldo_embargo
                 where  se_cliente = @i_cli
                    and se_estado  = 'V')
      begin /** Si existe algun embargo para el cliente ***/
        exec @w_return = cobis..sp_saldo_min_embargado
          @s_srv      = @s_srv,
          @s_user     = @s_user,
          @s_term     = @s_term,
          @s_ofi      = @s_ofi,
          @s_date     = @s_date,
          @t_trn      = 1423,
          @i_oper     = 'N',
          @i_cliente  = @i_cli,
          @i_producto = 4,
          @i_num_cta  = @i_cta_banco
        if @w_return <> 0
        begin
          select @w_error = @w_return
          goto ERROR
        end
      end
    end
  /* Insercion en la tabla cl_cliente para el resto de clientes */
    /* Cotitulares                                               */

    exec @w_return = cobis..sp_in_cliente
      @i_cli    = @i_cli,
      @i_dprod  = @i_dprod,
      @i_rol    = @i_rolcli,
      @i_cedruc = @i_cedruc,
      @i_fecha  = @s_date
    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end

    /* Actualizacion en cl_ente */
    update cobis..cl_ente
    set    en_cliente = 'S'
    where  en_ente = @i_cli

    if @w_return <> 0
    begin
      if @i_atm = 'S'
        rollback tran
      return @w_return
    end
    
    if exists(select 1 
                from cobis..cl_producto 
               WHERE pd_producto = 5)
    begin
        /*Insercion de clientes para firma de tarjeta */
        if not exists(select 1
                      from   firmas..fi_control_impresion
                      where  ci_producto  = @w_producto
                         and ci_cta_banco = @i_cta_banco
                         and ci_cliente   = @i_cli)
        begin
          insert into firmas..fi_control_impresion
                      (ci_cta_banco,ci_producto,ci_cliente,ci_firma,ci_condicion,
                       ci_combinacion,ci_fec_ult_imp,ci_fec_ult_mod,ci_usuario_imp,
                       ci_usuario_mod,
                       ci_estado)
          values      (@i_cta_banco,@w_producto,@i_cli,'S','N',
                       'N',null,@s_date,null,@s_user,
                       'V')

        end
        else
        begin
          /* OJO .. REVISAR ERROR */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 303007
          return 1
        end
    end
  end
  commit tran
  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error,
    @i_msg  = @w_msg

  if @w_rollback = 'S'
    rollback tran

  return @w_error

go

