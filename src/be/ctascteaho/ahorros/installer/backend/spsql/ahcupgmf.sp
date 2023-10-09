use cob_ahorros
go

/************************************************************************/
/*      Archivo:            ahcupgmf.sp                                 */
/*      Stored procedure:   sp_upd_gmf_ac                               */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Claudia Ballen                              */
/*      Fecha de escritura: 30-Abril-2009                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de actualizacion GMF       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    04/05/2009        c.ballen        req 1110                        */
/*    08/10/2010        A.Zuluaga       Control de Cambio 172           */
/*    17/02/2012        L.Moreno        Control de Cambio 315           */
/*    02/May/2016       Walther Toledo  Migración a CEN                 */
/*    08/Jul/2016       Jorge Salazar   Correccion Bug 77083            */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_upd_gmf_ac')
  drop proc sp_upd_gmf_ac
go

create proc sp_upd_gmf_ac
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           smallint = 0,
  @i_nxmil         char(1) = 'N',-- EAA 16/Abr/2001 CC00179
  @i_pit           char(1) = 'N',
  @i_descripcion   varchar(70) = null,
  @i_gmfmarca      char(1) = 'N',
  @i_fecmarca      datetime = null,
  @i_formato_fecha int = 101,--ccb
  @i_concepto      smallint = 0,
  @i_operacion     char(1),
  @i_oficina       int = null,
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada

)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_est           char(1),
    @w_cuenta        int,
    @w_cliente       int,
    @w_producto      tinyint,
    @w_filial        tinyint,
    @w_ced_ruc       numero,
    @w_nombre        descripcion,
    @w_oficial       smallint,
    @w_categoria     char(1),
    @w_oficina_cta   smallint,
    @w_clase_clte    char(1),
    @w_prod_banc     tinyint,
    @w_nxmil         char(1),
    @v_nxmil         char(1),
    @w_camnmil       char(1),
    @w_cammarca      char(1),
    @w_camconce      char(1),
    @w_marca         char(1),
    @w_fecha_marca   char(10),
    @w_reg_gmf       char(1),
    @w_concepto      smallint,
    @w_otra_cta      smallint,
    @w_otra_exe      char(1),
    @w_otro_conc     smallint,
    @w_exento_gmf    char(1),--s/N ccb
    @w_tipo_per      char(1),
    @w_unic_tit      char(1),
    @w_nemon         char(5),
    @w_categ         char(1),
    @w_rol_ente      char(1),
    @w_concepto_eg   smallint,-- concepto pensionado o dtn para gmf ccb
    @w_observacion   varchar(40),
    @w_ind_dtn       char(1),--ccb
    @w_gmfmarca      char(1),
    @w_usuario       varchar(20),
    @w_ind_DTN       char(1),
    @w_subtipo       char(1),
    @w_tipo_cta      char(1),
    @w_det_producto  int,
    @w_titalter      int,
    @w_error         int,
    @w_mensaje       mensaje,
    @w_sev           int,
    @w_msg           mensaje,
    @w_estado        char(1),
    @w_oficina_marca int,
    @w_oficina_actua int,
    @w_nom_ofi_marca varchar(30),
    @w_nom_ofi_actua varchar(30),
    @w_fecha_desm    char(10),
    @w_usuario_desm  varchar(20),
    @w_oficina_desm  int,
    @w_nom_ofi_desm  varchar(30),
    @w_orden         int,-- REQ 315: Consumo WS CIFIN
    @w_resp_cifin    char(1),-- REQ 315: Consumo WS CIFIN
    @w_msg_cifin     varchar(255),-- REQ 315: Consumo WS CIFIN
    @w_exentaws      tinyint,-- REQ 315: Consumo WS CIFIN
    @w_tiene_cifin   char(1),-- REQ 315: Consumo WS CIFIN
    @w_ente          int,-- REQ 315: Consumo WS CIFIN
    @w_tipo_ced      char(2),-- REQ 315: Consumo WS CIFIN
    @w_cedula        char(15),-- REQ 315: Consumo WS CIFIN
    @w_ced_ruc_env   char(15),-- REQ 315: Consumo WS CIFIN
    @w_sec_error     int,-- REQ 315: Consumo WS CIFIN
    @w_fecha         datetime,-- REQ 315: Consumo WS CIFIN
    @w_cod_msg       varchar(2),-- REQ 315: Consumo WS CIFIN
    @w_msg_exencion  varchar(260),-- REQ 315: Consumo WS CIFIN
    @cod_trn_gmf     int,-- REQ 315: Consumo WS CIFIN
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

/* Observacion : Cuando se modifique la categoria, tambien se modificara
                 el tipo de interes, con el mismo valor */
  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_upd_gmf_ac',
    @w_gmfmarca = 'N',
    @w_tiene_cifin = 'N'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso with (nolock)

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  if @i_operacion = 'S'
  begin
    /* Valida el producto para la oficina */
    if isnull(@s_ofi,
              0) <> 0
    begin
      exec @w_return = cobis..sp_val_prodofi
        @i_modulo  = 4,
        @i_oficina = @s_ofi
      if @w_return <> 0
        return @w_return
    end

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_ente = ah_cliente,
        @w_nombre = ah_nombre,
        @w_ind_DTN = '',
        @w_tipo_cta = ah_tipocta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

      if @@rowcount = 0
      begin
        select
          @w_error = 251001,
          @w_mensaje = 'No existe Cuenta de Ahorros',
          @w_sev = 0
        goto ERROR
      end
    end
    else
    begin
      select
        @w_ente = ah_cliente,
        @w_nombre = ah_nombre,
        @w_ind_DTN = '',
        @w_tipo_cta = ah_tipocta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cta

      if @@rowcount = 0
      begin
        select
          @w_error = 251001,
          @w_mensaje = 'No existe Cuenta de Ahorros',
          @w_sev = 0
        goto ERROR
      end
    end

    select
      @w_cedula = en_ced_ruc
    from   cobis..cl_ente with (nolock)
    where  en_ente = @w_ente

    if @@rowcount = 0
    begin
      select
        @w_error = 251001,
        @w_mensaje = 'No existe Cliente',
        @w_sev = 0
      goto ERROR
    end

    select
      @w_gmfmarca = eg_marca,
      @w_fecha_marca = convert(varchar(10), eg_fecha_marca, @i_formato_fecha),
      @w_concepto = eg_concepto,
      @w_usuario = eg_usuario,
      @w_oficina_marca = eg_oficina_marca,
      @w_oficina_actua = eg_oficina_actua,
      @w_fecha_desm = convert(varchar(10), eg_fecha_desm, @i_formato_fecha),
      @w_usuario_desm = eg_usuario_desm,
      @w_oficina_desm = eg_oficina_desm
    from   cob_ahorros..ah_exenta_gmf
    where  eg_cta_banco = @i_cta

    select
      @w_det_producto = dp_det_producto
    from   cobis..cl_det_producto --(INDEX i_dp_cuenta)
    where  dp_cuenta = @i_cta

    select
      @w_subtipo = en_subtipo
    from   cobis..cl_ente,
           cobis..cl_catalogo,
           cobis..cl_cliente --(INDEX icl_det_producto)
    where  cl_det_producto = @w_det_producto
       and en_ente         = cl_cliente
       and cl_rol          = codigo
       and tabla           = (select
                                cobis..cl_tabla.codigo
                              from   cobis..cl_tabla
                              where  tabla = 'cl_rol')
       and cl_rol not in ('U', 'F') -- Excluye Firmantes y Tutores

    select
      @w_titalter = @@rowcount --cantidad de titulares-alternos

    if @@rowcount = 0
    begin
      select
        @w_error = 101061,
        @w_mensaje = 'No existe cliente',
        @w_sev = 0
      goto ERROR
    end

    select
      @w_nom_ofi_marca = of_nombre
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina_marca

    select
      @w_nom_ofi_actua = of_nombre
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina_actua

    select
      @w_nom_ofi_desm = of_nombre
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina_desm

    /* Busca si la cuenta tiene una respuesta de CIFIN */
    if exists (select
                 1
               from   cobis..cl_marc_cifin_gen,
                      cobis..cl_marc_cifin_ctas
               where  mcg_num_ide = @w_cedula
                  and mcg_cod     = mcc_cod)
      select
        @w_tiene_cifin = 'S'

    select
      @w_nombre,
      @w_gmfmarca,
      @w_fecha_marca,
      @w_concepto,
      @w_usuario,
      @w_ind_DTN,
      @w_tipo_cta,
      @w_titalter,
      @w_oficina_marca,
      @w_oficina_actua,
      @w_nom_ofi_marca,
      @w_nom_ofi_actua,
      @w_fecha_desm,
      @w_usuario_desm,
      @w_oficina_desm,
      @w_nom_ofi_desm,
      @w_tiene_cifin

  end

  if @i_operacion = 'U'
  begin
    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_cuenta = ah_cuenta,
        @w_cliente = ah_cliente,
        @w_ente = ah_cliente,
        @w_filial = ah_filial,
        @w_producto = ah_producto,
        @w_ced_ruc = ah_ced_ruc,
        @w_nombre = ah_nombre,
        @w_oficial = ah_oficial,
        @w_categoria = ah_categoria,
        @w_oficina_cta = ah_oficina,
        @w_prod_banc = ah_prod_banc,
        @w_clase_clte = ah_clase_clte,
        @w_nxmil = ah_nxmil,
        @w_rol_ente = ah_tipocta,
        @w_estado = ah_estado,
        @w_ind_dtn = ''
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

      if @@rowcount <> 1
      begin
        /* No existe cuenta_banco */
        select
          @w_error = 251001
        goto ERROR
      end
    end
    else
    begin
      select
        @w_cuenta = ah_cuenta,
        @w_cliente = ah_cliente,
        @w_ente = ah_cliente,
        @w_filial = ah_filial,
        @w_producto = ah_producto,
        @w_ced_ruc = ah_ced_ruc,
        @w_nombre = ah_nombre,
        @w_oficial = ah_oficial,
        @w_categoria = ah_categoria,
        @w_oficina_cta = ah_oficina,
        @w_prod_banc = ah_prod_banc,
        @w_clase_clte = ah_clase_clte,
        @w_nxmil = ah_nxmil,
        @w_rol_ente = ah_tipocta,
        @w_estado = ah_estado,
        @w_ind_dtn = ''
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cta

      if @@rowcount <> 1
      begin
        /* No existe cuenta_banco */
        select
          @w_error = 251001
        goto ERROR
      end
    end

    select
      @w_tipo_ced = en_tipo_ced,
      @w_cedula = en_ced_ruc
    from   cobis..cl_ente with (nolock)
    where  en_ente = @w_ente

    if @@rowcount = 0
    begin
      select
        @w_error = 251001,
        @w_mensaje = 'No existe Cliente',
        @w_sev = 0
      goto ERROR
    end

    if @w_estado = 'C'
       and @i_gmfmarca = 'S'
    begin
      select
        @w_error = 251057,
        @w_mensaje = 'Cuenta de Ahorros Cancelada',
        @w_sev = 0
      goto ERROR
    end

    select
      @w_camnmil = 'N',
      @w_cammarca = 'N',
      @w_camconce = 'N'

    if isnull(@i_nxmil,
              '') <> isnull(@w_nxmil,
                            '')
      select
        @v_nxmil = @w_nxmil,
        @w_nxmil = @i_nxmil,
        @w_camnmil = 'S'

    --******************************
    --Marcacion GMF
    --******************************
    select
      @w_reg_gmf = 'N'

    select
      @w_marca = eg_marca,
      @w_fecha_marca = eg_fecha_marca,
      @w_concepto = eg_concepto
    from   cob_ahorros..ah_exenta_gmf
    where  eg_cta_banco = @i_cta

    if @@rowcount = 0
    begin
      if @i_gmfmarca = 'S'
        select
          @w_reg_gmf = 'S'
    end
    else
    begin
      if @w_marca <> @i_gmfmarca
          or @w_concepto <> @i_concepto
        select
          @w_reg_gmf = 'S'

      if @w_marca = @i_gmfmarca
         and @w_marca = 'N'
        select
          @i_concepto = @w_concepto
    end

    if @w_reg_gmf = 'S'
    begin
      if @i_concepto is null
      begin
        select
          @w_error = 352079
        goto ERROR
      end
    end
    else
      return 0

    if @i_gmfmarca = 'S'
    begin
      select
        @w_tipo_per = ce_tipo_per,
        @w_unic_tit = ce_titular,
        @w_otra_exe = ce_otra_exen,
        @w_otro_conc = ce_otro_conc,
        @w_nemon = ce_nemonico
      from   cob_remesas..re_concep_exen_gmf
      where  ce_concepto = @i_concepto

      if @@rowcount = 0
      begin
        select
          @w_error = 352079
        goto ERROR
      end

      if @w_tipo_per <> 'Y'
         and @w_tipo_per <> @w_rol_ente
      begin
        select
          @w_error = 352087
        goto ERROR
      end

      if @w_otra_exe = 'N' /* No permite otra cuenta marcada como exenta */
      begin
        if (select
              count (1)
            from   cob_ahorros..ah_cuenta,
                   cob_ahorros..ah_exenta_gmf
            where  ah_cliente   = @w_cliente
               and eg_cuenta    = ah_cuenta
               and eg_marca     = 'S'
               and ah_estado    <> 'C'
               and eg_cta_banco <> @i_cta) > 0
        begin
          select
            @w_error = 352088
          goto ERROR
        end
      end
      else
      begin
        if (select
              count (1)
            from   cob_ahorros..ah_cuenta,
                   cob_ahorros..ah_exenta_gmf
            where  ah_cliente   = @w_cliente
               and eg_cuenta    = ah_cuenta
               and eg_marca     = 'S'
               and ah_estado    <> 'C'
               and eg_cta_banco <> @i_cta
               and eg_concepto  = @i_concepto) > 0
        begin
          select
            @w_error = 352088
          goto ERROR
        end
      end

      if @w_otra_exe = 'S' /* Si permite otra cuenta marcada como exenta */
      begin
        if @w_otro_conc is not null
        begin
          if exists (select
                       1
                     from   cob_ahorros..ah_cuenta,
                            cob_ahorros..ah_exenta_gmf
                     where  ah_cliente   = @w_cliente
                        and eg_cuenta    = ah_cuenta
                        and eg_marca     = 'S'
                        and ah_estado    <> 'C'
                        and eg_concepto  <> @w_otro_conc
                        and eg_cta_banco <> @i_cta)
          begin
            select
              @w_error = 352088
            goto ERROR
          end
        end
      end
    end

    if @i_gmfmarca <> @w_marca
      select
        @w_cammarca = 'S'
    if @i_concepto <> @w_concepto
      select
        @w_camconce = 'S'

    if @w_reg_gmf = 'S'
    begin
      if @i_gmfmarca = 'S'
        select
          @w_exentaws = 1
      else
        select
          @w_exentaws = 0

      /* EJECUTA WEB SERVICE CON CIFIN PARA MARCACIËN EN LINEA */
      exec @w_error = cob_interfase..sp_orden_consulta_cis
        @s_date      = @s_date,
        @s_user      = @s_user,
        @i_modo      = 'I',
        @i_tconsulta = '08',
        @i_cuenta    = @i_cta,
        @i_exenta    = @w_exentaws,
        @o_orden     = @w_orden out,
        @o_respuesta = @w_resp_cifin out,
        @o_msg       = @w_msg out

      if @w_error <> 0
      begin
        select
          @w_msg = 'Ejecutando web_service Error:' + convert(varchar(6), isnull(
                   @w_error,
                          0)) +
                          ' '
                   + isnull(@w_msg, '-'),
          @w_error = 101232
        goto ERROR
      end

      select
        @w_resp_cifin = null,
        @w_msg_cifin = null

      /* OBTIENE RESPUESTA DEL PROCESO DE MARCACION */
      exec @w_error = cob_interfase..sp_orden_consulta_cis
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_srv       = @s_srv,
        @s_ssn       = @s_ssn,
        @i_modo      = 'E',
        @i_tconsulta = '08',
        @i_orden     = @w_orden,
        @o_sec_error = @w_sec_error out,
        @o_msg       = @w_msg out

      if @w_error <> 0
          or isnull(@w_sec_error,
                    0) <> 0
      begin
        if @w_sec_error <> 0
          select
            @w_msg = wa_texto
          from   cobis..cl_ws_alerta_tmp
          where  wa_secuencial    = @w_sec_error
             and wa_tipo_registro = 'CTAMENSAJE'

        select
          @w_msg = 'Obteniendo respuesta de Marcacion Error:' + convert(varchar(
                   6
                   ),
                                                                     isnull (
                                                                     @w_error, 0
                   ))
                   + ' ' + isnull(@w_msg, '-'),
          @w_error = 101232

        goto ERROR
      end

      /* OBTIENE EL MENSAJE DE RESPUESTA DE CIFIN */

      if @w_tipo_ced in ('N', 'NI')
        select
          @w_ced_ruc_env = left(rtrim(ltrim(@w_cedula)),
                                len(rtrim(ltrim(@w_cedula))) - 1)
      -- SIN DIGITO DE VERIFICACION
      else
        select
          @w_ced_ruc_env = rtrim(ltrim(@w_cedula))

      select
        @w_cod_msg = '',
        @w_msg_exencion = ''
      select top 1
        @w_cod_msg = mcg_cod_msg,
        @w_msg_exencion = mcg_cod_msg + '-' + mcg_desc_msg
      from   cobis..cl_marc_cifin_gen with (nolock)
      where  mcg_num_ide = @w_ced_ruc_env
      order  by mcg_cod desc

      if @@rowcount = 0
      begin
        select
          @w_error = 101233
        goto ERROR
      end

    /* SI LA OPERACION ES MARCACION Y EL CODIGO DE RESPUESTA ES DIFERENTE DE 04 (REGISTRO EXENCION OK) Y DE 06 (CUENTA EXENTA YA REGISTRADA)*/
    /* O SI LA OPERACION ES DESMARCACION Y EL CODIGO DE RESPUESTA ES DIFERENTE DE 02 (TERCERO SIN CUENTA EXENTA) Y DE 07 (DESMARCACION DE CUENTA OK) */
      /* GENERA ERROR */
      if (@i_gmfmarca = 'S'
          and (@w_cod_msg <> '04'
               and @w_cod_msg <> '06'))
          or (@i_gmfmarca = 'N'
              and (@w_cod_msg <> '02'
                   and @w_cod_msg <> '07'))
      begin
        select
          @w_error = 101234,
          @w_msg = @w_msg_exencion
        goto ERROR
      end

      begin tran
      if @w_marca in ('N', 'S')
      begin
        if @w_marca = 'N'
        begin
          update cob_ahorros..ah_exenta_gmf
          set    eg_marca = @i_gmfmarca,
                 eg_fecha_actua = @w_fecha,
                 eg_fecha_marca = @w_fecha,
                 eg_concepto = @i_concepto,
                 eg_usuario = @s_user,
                 eg_oficina_marca = @s_ofi,
                 eg_oficina_actua = @s_ofi
          where  eg_cta_banco = @i_cta

          if @@error <> 0
          begin
            /* Error en actualizacion tabla de ctas exentas gmf */
            select
              @w_error = 258022
            goto ERROR
          end
        end
        else
        begin
          update cob_ahorros..ah_exenta_gmf
          set    eg_marca = @i_gmfmarca,
                 eg_fecha_actua = @w_fecha,
                 eg_fecha_desm = @w_fecha,
                 eg_usuario_desm = @s_user,
                 eg_oficina_desm = @s_ofi,
                 eg_oficina_actua = @s_ofi
          where  eg_cta_banco = @i_cta

          if @@error <> 0
          begin
            /* Error en actualizacion tabla de ctas exentas gmf */
            select
              @w_error = 258022
            goto ERROR
          end
        end
      end
      else
      begin
        if @i_gmfmarca = 'S'
          select
            @w_oficina_marca = @i_oficina
        else
          select
            @w_oficina_actua = @i_oficina

        insert cob_ahorros..ah_exenta_gmf
               (eg_cuenta,eg_cta_banco,eg_marca,eg_fecha_marca,eg_fecha_actua,
                eg_fecha_valor,eg_mes_01,eg_mes_02,eg_mes_03,eg_mes_04,
                eg_mes_05,eg_mes_06,eg_mes_07,eg_mes_08,eg_mes_09,
                eg_mes_10,eg_mes_11,eg_mes_12,eg_concepto,eg_usuario,
                eg_oficina_marca,eg_oficina_actua,eg_fecha_desm,eg_usuario_desm,
                eg_oficina_desm)
        values( @w_cuenta,@i_cta,@i_gmfmarca,@w_fecha,@w_fecha,
                null,0,0,0,0,
                0,0,0,0,0,
                0,0,0,@i_concepto,@s_user,
                @w_oficina_marca,@w_oficina_actua,null,null,null)

        if @@error <> 0
        begin
          /* Error en inserccion tabla de ctas exentas gmf */
          select
            @w_error = 258023
          goto ERROR
        end
      end
    end

    --*********************
    --GRABAR TX DE SERVICIO
    --*********************
    if @w_camnmil = 'S'
        or @w_cammarca = 'S'
        or @w_camconce = 'S'
    begin
      if @i_gmfmarca = 'S'
      begin
        select
          @w_observacion = 'EXENTO GMF'
        select
          @cod_trn_gmf = 4106
      end
      else
      begin
        select
          @w_observacion = 'NO EXENTO GMF'
        select
          @cod_trn_gmf = 4148
      end

      insert into cob_ahorros..ah_tsapertura
                  (secuencial,alterno,tipo_transaccion,oficina,usuario,
                   terminal,reentry,clase,tsfecha,cta_banco,
                   filial,oficial,origen,moneda,cliente,
                   cuenta,oficina_cta,prod_banc,clase_clte,nxmil,
                   observacion,hora,descripcion_ec,microficha,marca_gmf,
                   fec_marca_gmf)
      values      ( @s_ssn,40,@cod_trn_gmf,@s_ofi,@s_user,
                    @s_term,@t_rty,'A',@w_fecha,@i_cta,
                    @w_filial,@w_oficial,@s_org,@i_mon,@w_cliente,
                    @w_cuenta,@w_oficina_cta,@w_prod_banc,@w_clase_clte,
                    @w_reg_gmf
                    ,
                    @w_observacion,getdate(),@i_descripcion,
                    @i_concepto,@i_gmfmarca,
                    @w_fecha)

      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        select
          @w_error = 203005
        goto ERROR
      end
    end
    commit tran
  end --operacion
  return 0

  ERROR:
  /* No existe cuenta_banco */
  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error,
    @i_sev  = @w_sev,
    @i_msg  = @w_msg
  return 1

go

