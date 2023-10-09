/************************************************************************/
/*      Archivo:                arch_est_cta_masivo.sp                  */
/*      Stored procedure:       sp_archivo_cta_masivo_ah                */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Creado por:             Mario Algarin                           */
/*      Fecha de escritura:     21-Juino-2010                           */
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
/*      BATCH: Crea Archivo plano con el estado de cuenta de ahorros    */
/*             de forma Masiva.                                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*                                                                      */
/*  02/May/2016 Javier Calderon     Migración a CEN                     */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_archivo_cta_masivo_ah')
  drop proc sp_archivo_cta_masivo_ah
go

create proc sp_archivo_cta_masivo_ah
(
  @t_show_version bit = 0,
  @i_fecha        datetime = null,
  @i_param1       datetime,--Fecha Proceso
  @i_param2       varchar(15) = '0',--Cuenta
  @i_param3       char(1) = 'T',

  --D = Saldo Disponible / P = Saldo Promedio / C = Saldo Contable
  @i_param4       money = 0,--Saldo para Validar  
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada        
)
as
  declare
    @w_sp_name               varchar(64),
    @w_return                int,
    @w_fecha                 datetime,
    @w_fecha_crea            varchar(8),
    @w_fecha_envia           varchar(8),
    @w_saldo_total           money,
    @w_remuneracion          money,
    @w_num_reg               int,
    @w_registro              varchar(255),
    @w_tn_cuenta             varchar(24),
    @w_tn_ced_ruc            varchar(13),
    @w_tn_tipo_cta           tinyint,
    @w_tn_grupo              char(2),
    @w_tn_saldo_inicial      money,
    @w_tn_remuneracion       money,
    @w_msg                   descripcion,
    @w_sec_env               int,
    @w_archivo               descripcion,
    @w_archivo_bcp           descripcion,
    @w_errores               descripcion,
    @w_tot_reg               int,
    @w_path_s_app            varchar(30),
    @w_path                  varchar(250),
    @w_s_app                 varchar(250),
    @w_cmd                   varchar(250),
    @w_error                 int,
    @w_comando               varchar(250),
    @w_fecha_aux             datetime,
    --Campos cursor Transacciones    
    @w_hm_fecha              varchar(12),
    @w_hm_oficina            int,
    @w_hm_nombre             descripcion,
    @w_hm_correccion         char (1),
    @w_hm_descripcion        descripcion,
    @w_hm_signo              char (1),
    @w_hm_valor              money,
    @w_hm_saldo_contable     money,
    @w_hm_monto_imp          money,
    @w_hm_interes            money,
    @w_hm_secuencial         int,
    @w_hm_cod_alterno        int,
    @w_hm_tipo_tran          int,
    @w_hm_serial             varchar(30),
    @w_hm_serial_tmp         varchar(30),
    @w_hm_concepto           varchar(40),
    @w_hm_ctadestino         cuenta,
    @w_hm_causa              char(3),
    @w_hm_estado             char(1),
    @w_hm_ssn_branch         int,
    @w_hm_hora               datetime,
    @w_hm_valor_comision     money,
    --Campos cursor cuentas
    @w_en_tipo_ced           char(2),
    @w_ec_ced_ruc            char(13),
    @w_ec_nombre             char(55),
    @w_ec_oficina            int,
    @w_ec_cta_banco          char(16),
    @w_ec_fecha_prx_corte    datetime,
    @w_ec_tasa_hoy           real,
    @w_ec_fecha_ult_corte    datetime,
    @w_ec_fecha_prx_corte1   datetime,
    @w_ec_tipo_dir           char(1),
    @w_ec_prod_banc          smallint,
    @w_ec_saldo_contable     money,
    @w_ec_saldo_promedio     money,
    --Campos Varios
    @w_pipe                  char(1),
    @w_tabla_nc              int,
    @w_tabla_nd              int,
    @w_formato_fecha         smallint,
    @w_sec                   int,
    @w_sec_alt               int,
    @w_hora                  datetime,
    @w_saldo_contable        money,
    @w_abpais                varchar(10),
    @w_nombre_of             varchar(15),
    @w_num_dep               int,
    @w_depositos             money,
    @w_num_nc                int,
    @w_total_nc              money,
    @w_num_nd                int,
    @w_total_nd              money,
    @w_total_int             money,
    @w_saldo_cont_tmp        money,
    @w_flag_ofi              int,
    @w_flag_prod_banc        int,
    @w_me_mensaje            varchar(260),
    @w_valord                varchar(30),
    @w_valorc                varchar(30),
    @w_ec_saldo_ult_corte    money,
    @w_acum_total_retiros    money,
    @w_acum_total_depositos  money,
    @w_contador_total_reg_01 int,
    @w_nom_banco             varchar(30),
    @w_ec_descripcion_ec     varchar(120),
    @w_prod_bancario         varchar(50) --Req. 381 CB Red Posicionada

   /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_archivo_cta_masivo_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  set Ansi_Warnings off

  select
    @w_pipe = char(124),--SE LE ASIGANA A LA VARIABLE @w_pipe, EL CARACTER PIPE
    @w_formato_fecha = 103,
    @w_flag_ofi = 0,
    @w_flag_prod_banc = 0

  /* Carga de Parametro del Pais */
  select
    @w_abpais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  /* Carga de Parametro Nombre Banco*/
  select
    @w_nom_banco = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'BANCO'
     and pa_producto = 'CRE'

  if @w_abpais is null
    select
      @w_abpais = 'CO'

  if @i_param1 is null
     and @i_fecha is null
  begin
    --Falta parametro obligatorio
    select
      @w_msg = 'NO SE HA INGRESADO PARAMETRO OBLIGATORIO EJECUCION BATCH'
    goto ERROR
  end

  if @i_fecha is null
    select
      @i_fecha = @i_param1

  if @i_param3 not in ('D', 'P', 'C', 'T')
  begin
    --Parametro Errado
    select
      @w_msg = 'PARAMETRO DE VALIDACION DE MONTOS INVALIDO'
    goto ERROR
  end

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @i_fecha,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'N',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  if @w_return <> 0
      or @@error <> 0
  begin
    --Error al determinar ultimo dia habil del mes
    select
      @w_msg = 'ERROR AL DETERMINAR EL ULTIMO DIA HABIL DEL MES'
    goto ERROR
  end

  /* Validacion de la periodicidad de ejecucion */
  if convert(varchar(2), (datepart(mm,
                                   @w_fecha_aux))) = convert(varchar(2),
                                                     (datepart(mm,
                                                               @i_fecha)))
  begin
    goto FIN
  end

  /* Determinacion de las tablas de NC y ND  */
  select
    @w_tabla_nc = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nc'

  select
    @w_tabla_nd = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nd'

  /* Borrado de datos existentes en Tablas utilizadas de los Extractos Masivos */
  truncate table cob_ahorros..ah_ext_masivos
  truncate table cob_ahorros..ah_ext_masivos_tmp

  /* Inicializacion del secuencial de la tabla ah_ext_masivos_tmp */
  dbcc CHECKIDENT (ah_ext_masivos_tmp, RESEED, 0)

  /* Inicializacion de Variables con los totales generales del archivo plano */
  select
    @w_contador_total_reg_01 = 0,
    @w_acum_total_retiros = 0,
    @w_acum_total_depositos = 0

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /* Cursor que me permite recorrer cada una de la cuentas sujetas a generarle Extracto*/
    declare cuentas_extracto cursor for
      select
        en_tipo_ced,
        ec_ced_ruc,
        ec_nombre,
        ec_oficina,
        ec_cta_banco,
        ec_fecha_prx_corte,
        ec_tasa_hoy,
        ec_fecha_ult_corte,
        ec_fecha_prx_corte,
        ec_tipo_dir,
        ec_prod_banc,
        ec_saldo_contable,
        ec_saldo_promedio,
        ec_saldo_ult_corte,
        ec_descripcion_ec
      from   cob_ahorros..ah_estado_cta,
             cobis..cl_ente
      where  en_ente            = ec_cliente
         and ec_tipo_dir        = 'D'
         and ec_fecha_prx_corte = @i_fecha
         and (ec_cta_banco       = @i_param2
               or @i_param2          = '0')
         and ((@i_param3          = 'D'
               and ec_disponible      >= @i_param4) --Valida Saldo Disponble
               or (@i_param3          = 'P'
                   and ec_saldo_promedio  >= @i_param4) --Valida Saldo Promedio
               or (@i_param3          = 'C'
                   and ec_saldo_contable  >= @i_param4) --Valida Saldo Contable
               or @i_param3          = 'T')
         and ec_prod_banc       <> @w_prod_bancario
      -- Req. 381 CB Red Posicionada
      order  by ec_oficina,
                ec_moneda,
                ec_prod_banc,
                ec_oficial,
                ec_cta_banco
  end
  else
  begin
    /* Cursor que me permite recorrer cada una de la cuentas sujetas a generarle Extracto*/
    declare cuentas_extracto cursor for
      select
        en_tipo_ced,
        ec_ced_ruc,
        ec_nombre,
        ec_oficina,
        ec_cta_banco,
        ec_fecha_prx_corte,
        ec_tasa_hoy,
        ec_fecha_ult_corte,
        ec_fecha_prx_corte,
        ec_tipo_dir,
        ec_prod_banc,
        ec_saldo_contable,
        ec_saldo_promedio,
        ec_saldo_ult_corte,
        ec_descripcion_ec
      from   cob_ahorros..ah_estado_cta,
             cobis..cl_ente
      where  en_ente            = ec_cliente
         and ec_tipo_dir        = 'D'
         and ec_fecha_prx_corte = @i_fecha
         and (ec_cta_banco       = @i_param2
               or @i_param2          = '0')
         and ((@i_param3          = 'D'
               and ec_disponible      >= @i_param4) --Valida Saldo Disponble
               or (@i_param3          = 'P'
                   and ec_saldo_promedio  >= @i_param4) --Valida Saldo Promedio
               or (@i_param3          = 'C'
                   and ec_saldo_contable  >= @i_param4) --Valida Saldo Contable
               or @i_param3          = 'T')
      order  by ec_oficina,
                ec_moneda,
                ec_prod_banc,
                ec_oficial,
                ec_cta_banco
  end

/* Abrir el cursor de cuentas_extracto */
  /* Ubicar el primer registro para el cursor cuentas_extracto */
  open cuentas_extracto
  fetch cuentas_extracto into @w_en_tipo_ced,
                              @w_ec_ced_ruc,
                              @w_ec_nombre,
                              @w_ec_oficina,
                              @w_ec_cta_banco,
                              @w_ec_fecha_prx_corte,
                              @w_ec_tasa_hoy,
                              @w_ec_fecha_ult_corte,
                              @w_ec_fecha_prx_corte1,
                              @w_ec_tipo_dir,
                              @w_ec_prod_banc,
                              @w_ec_saldo_contable,
                              @w_ec_saldo_promedio,
                              @w_ec_saldo_ult_corte,
                              @w_ec_descripcion_ec

  /* Validacion del estado del cursor cuentas_extracto */
  if @@fetch_status = -2
  begin
    close cuentas_extracto
    deallocate cuentas_extracto

    select
      @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
    goto ERROR
  end

  if @@fetch_status = -1
  begin
    close cuentas_extracto
    deallocate cuentas_extracto

    goto FIN
  end

  while @@fetch_status = 0
  begin
  /**********************/
  /*| REGISTRO TIPO 01 |*/
  /**********************/
    /* Busqueda de Mensajes Para los estados de Cuenta*/
    if @w_flag_ofi <> @w_ec_oficina
        or @w_flag_prod_banc <> @w_ec_prod_banc
    begin
      select
        @w_flag_ofi = @w_ec_oficina,
        @w_flag_prod_banc = @w_ec_prod_banc

      select
        @w_me_mensaje = ''
      select
        @w_me_mensaje = ltrim(rtrim(isnull(me_linea1, ''))) + ' ' + ltrim(rtrim(
                        isnull
                                                      ( me_linea2, '')
                                                      )) + ' '
                        + ltrim(rtrim(isnull(me_linea3, ''))) + ' ' + ltrim(
                        rtrim
                        (
                                                      isnull (me_linea4, ''))) +
                        ' '
                        + ltrim(rtrim(isnull(me_linea5, ''))) + ' ' + ltrim(
                        rtrim
                        (
                                                      isnull (me_linea6, '')))
      from   cob_remesas..cc_mensaje_estcta
      where  me_fecha     <= @i_fecha
         and me_fecha_fin >= @w_ec_fecha_ult_corte
         and me_prodban   = @w_flag_prod_banc
         and me_oficina   = @w_flag_ofi
    end

    select
      @w_nombre_of = isnull(substring (of_nombre,
                                       1,
                                       15),
                            'OFICINA SIN NOMBRE')
    from   cobis..cl_oficina
    where  of_filial  = 1
       and of_oficina = @w_ec_oficina

    select
      @w_registro = ''
    select
      @w_registro = '01' + @w_pipe + ltrim(rtrim(@w_en_tipo_ced)) + @w_pipe +
                    ltrim(
                                                rtrim(
                                                @w_ec_ced_ruc)) + @w_pipe
                    + ltrim(rtrim(@w_ec_nombre)) + @w_pipe + ltrim(rtrim(
                    @w_nombre_of
                                                ) ) + @w_pipe
                    + ltrim(rtrim(@w_ec_cta_banco)) + @w_pipe
                    + ltrim(rtrim(convert(varchar(12), @w_ec_fecha_prx_corte,
                                                @w_formato_fecha))) + @w_pipe
                    + ltrim(rtrim(convert(varchar, @w_ec_tasa_hoy))) + @w_pipe
                    + ltrim(rtrim(convert(varchar(12), @w_ec_fecha_ult_corte,
                                                @w_formato_fecha))) + @w_pipe
                    + ltrim(rtrim(convert(varchar(12), @w_ec_fecha_prx_corte1,
                                                @w_formato_fecha)))
                    + @w_pipe + ltrim(rtrim(@w_ec_descripcion_ec)) + @w_pipe

    insert into cob_ahorros..ah_ext_masivos_tmp
                (emt_registro,emt_cta_banco,emt_estado)
    values      (@w_registro,@w_ec_cta_banco,null)

    if @@error <> 0
    begin
      select
        @w_msg = 'No se pudo crear el registro Tipo 01, de la Cuenta = ' +
                        @w_ec_cta_banco
      goto ERROR_REG
    end

    /* Se cuentan los Registros Tipo 01 */
    select
      @w_contador_total_reg_01 = @w_contador_total_reg_01 + 1

    select
      @w_saldo_contable = 0,
      @w_saldo_cont_tmp = 0,
      @w_num_dep = 0,
      @w_depositos = 0,
      @w_num_nc = 0,
      @w_total_nc = 0,
      @w_num_nd = 0,
      @w_total_nd = 0,
      @w_tot_reg = 0,
      @w_total_int = 0

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      /* Cursor que me permite extraer las transacciones Historicas de Movimiento de cada Cuenta*/
      declare tran_his_ctas cursor for
        select
          convert(varchar(12), hm_fecha, @w_formato_fecha),
          hm_oficina,
          substring (of_nombre,
                     1,
                     15),
          hm_correccion,
          case
            when (X.hm_tipo_tran = 253) then 'N/C: '
                                             + (select
                                                  valor
                                                from   cobis..cl_catalogo A,
                                                       cobis..cl_tabla B
                                                where  B.codigo = A.tabla
                                                   and B.tabla  = 'ah_causa_nc'
                                                   and A.codigo = X.hm_causa)
                                             + isnull('-' + hm_concepto, '')
            when (X.hm_tipo_tran = 264) then 'N/D: '
                                             + (select
                                                  valor
                                                from   cobis..cl_catalogo A,
                                                       cobis..cl_tabla B
                                                where  B.codigo = A.tabla
                                                   and B.tabla  = 'ah_causa_nd'
                                                   and A.codigo = X.hm_causa)
                                             + isnull('-' + hm_concepto, '')
            when (X.hm_tipo_tran in (240)) then
            tn_descripcion + ' (No. ' + ltrim(rtrim(
            convert(varchar(255), isnull(hm_cheque,
            0)))) + ')'
            else tn_descripcion + isnull('-' + hm_concepto, '')
          end,
          case isnull(hm_chq_ot_plazas,
                      $0)
            when 0 then hm_signo
            else '*'
          end,
          (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
           + isnull(hm_chq_ot_plazas, $0)),
          hm_saldo_contable,
          hm_monto_imp,
          isnull(hm_interes,
                 $0),
          hm_secuencial,
          hm_cod_alterno,
          hm_tipo_tran,
          hm_serial,
          isnull((select
                    X.hm_serial
                  where  X.hm_tipo_tran in (253, 264)),
                 isnull((select
                           right (replicate ('0', 8) + convert(varchar(20),
                           X.hm_concepto), 8)
                           + right (replicate ('0', 3) + convert(varchar(5),
                           X.hm_banco),
                           3)
                           + right (replicate ('0', 2) + X.hm_causa, 2)
                         where  X.hm_tipo_tran in (240, 313, 311)),
                        isnull((select
                                  X.hm_ctadestino
                                where  X.hm_tipo_tran in (237, 239, 294, 300)),
                               convert(varchar(20), hm_secuencial)))),
          isnull((select
                    X.hm_causa
                  where  X.hm_tipo_tran in (253, 264)),
                 '000'),
          hm_estado,
          hm_ssn_branch,
          hm_hora,
          hm_valor_comision
        /*******************************************************                   
                      from cob_ahorros_his..ah_his_movimiento X,
                           cobis..cl_ttransaccion,
                           cobis..cl_oficina,
                           cobis..cl_catalogo A
                     where hm_cta_banco = @w_ec_cta_banco
                       and hm_fecha >  @w_ec_fecha_ult_corte
                       and hm_fecha <= @i_fecha 
                       and hm_estado is null
                       and tn_trn_code = hm_tipo_tran
                       and of_filial = 1 
                       and of_oficina = hm_oficina
                       and
                       (
                       (((hm_signo = 'C'  and tabla = @w_tabla_nc) or (hm_signo = 'D' and tabla = @w_tabla_nd)) and hm_correccion = 'N')
                       or
                       (((hm_signo = 'D'  and tabla = @w_tabla_nc) or (hm_signo = 'C' and tabla = @w_tabla_nd)) and hm_correccion = 'S')
                       )  
                       and hm_causa * =A.codigo 
                       order by hm_fecha, hm_hora, hm_secuencial, hm_cod_alterno
        ***********************************************************/

        from   cob_ahorros_his..ah_his_movimiento X
               inner join cobis..cl_ttransaccion
                       on tn_trn_code = hm_tipo_tran
               inner join cobis..cl_oficina
                       on of_oficina = hm_oficina
                          and of_filial = 1
               left outer join cobis..cl_catalogo A
                            on hm_causa = A.codigo
                               and ((((hm_signo = 'C'
                                       and tabla = @w_tabla_nc)
                                       or (hm_signo = 'D'
                                           and tabla = @w_tabla_nd))
                                     and hm_correccion = 'N')
                                     or (((hm_signo = 'D'
                                           and tabla = @w_tabla_nc)
                                           or (hm_signo = 'C'
                                               and tabla = @w_tabla_nd))
                                         and hm_correccion = 'S'))
        where  hm_cta_banco = @w_ec_cta_banco
           and hm_fecha     > @w_ec_fecha_ult_corte
           and hm_fecha     <= @i_fecha
           and hm_estado is null
           and hm_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
        order  by hm_fecha,
                  hm_hora,
                  hm_secuencial,
                  hm_cod_alterno
    end
    else
    begin
      /* Cursor que me permite extraer las transacciones Historicas de Movimiento de cada Cuenta*/
      declare tran_his_ctas cursor for
        select
          convert(varchar(12), hm_fecha, @w_formato_fecha),
          hm_oficina,
          substring (of_nombre,
                     1,
                     15),
          hm_correccion,
          case
            when (X.hm_tipo_tran = 253) then 'N/C: '
                                             + (select
                                                  valor
                                                from   cobis..cl_catalogo A,
                                                       cobis..cl_tabla B
                                                where  B.codigo = A.tabla
                                                   and B.tabla  = 'ah_causa_nc'
                                                   and A.codigo = X.hm_causa)
                                             + isnull('-' + hm_concepto, '')
            when (X.hm_tipo_tran = 264) then 'N/D: '
                                             + (select
                                                  valor
                                                from   cobis..cl_catalogo A,
                                                       cobis..cl_tabla B
                                                where  B.codigo = A.tabla
                                                   and B.tabla  = 'ah_causa_nd'
                                                   and A.codigo = X.hm_causa)
                                             + isnull('-' + hm_concepto, '')
            when (X.hm_tipo_tran in (240)) then
            tn_descripcion + ' (No. ' + ltrim(rtrim(
            convert(varchar(255), isnull(hm_cheque,
            0)))) + ')'
            else tn_descripcion + isnull('-' + hm_concepto, '')
          end,
          case isnull(hm_chq_ot_plazas,
                      $0)
            when 0 then hm_signo
            else '*'
          end,
          (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
           + isnull(hm_chq_ot_plazas, $0)),
          hm_saldo_contable,
          hm_monto_imp,
          isnull(hm_interes,
                 $0),
          hm_secuencial,
          hm_cod_alterno,
          hm_tipo_tran,
          hm_serial,
          isnull((select
                    X.hm_serial
                  where  X.hm_tipo_tran in (253, 264)),
                 isnull((select
                           right (replicate ('0', 8) + convert(varchar(20),
                           X.hm_concepto), 8)
                           + right (replicate ('0', 3) + convert(varchar(5),
                           X.hm_banco),
                           3)
                           + right (replicate ('0', 2) + X.hm_causa, 2)
                         where  X.hm_tipo_tran in (240, 313, 311)),
                        isnull((select
                                  X.hm_ctadestino
                                where  X.hm_tipo_tran in (237, 239, 294, 300)),
                               convert(varchar(20), hm_secuencial)))),
          isnull((select
                    X.hm_causa
                  where  X.hm_tipo_tran in (253, 264)),
                 '000'),
          hm_estado,
          hm_ssn_branch,
          hm_hora,
          hm_valor_comision
        /*******************************************************                   
                      from cob_ahorros_his..ah_his_movimiento X,
                           cobis..cl_ttransaccion,
                           cobis..cl_oficina,
                           cobis..cl_catalogo A
                     where hm_cta_banco = @w_ec_cta_banco
                       and hm_fecha >  @w_ec_fecha_ult_corte
                       and hm_fecha <= @i_fecha 
                       and hm_estado is null
                       and tn_trn_code = hm_tipo_tran
                       and of_filial = 1 
                       and of_oficina = hm_oficina
                       and
                       (
                       (((hm_signo = 'C'  and tabla = @w_tabla_nc) or (hm_signo = 'D' and tabla = @w_tabla_nd)) and hm_correccion = 'N')
                       or
                       (((hm_signo = 'D'  and tabla = @w_tabla_nc) or (hm_signo = 'C' and tabla = @w_tabla_nd)) and hm_correccion = 'S')
                       )  
                       and hm_causa * =A.codigo 
                       order by hm_fecha, hm_hora, hm_secuencial, hm_cod_alterno
        ***********************************************************/

        from   cob_ahorros_his..ah_his_movimiento X
               inner join cobis..cl_ttransaccion
                       on tn_trn_code = hm_tipo_tran
               inner join cobis..cl_oficina
                       on of_oficina = hm_oficina
                          and of_filial = 1
               left outer join cobis..cl_catalogo A
                            on hm_causa = A.codigo
                               and ((((hm_signo = 'C'
                                       and tabla = @w_tabla_nc)
                                       or (hm_signo = 'D'
                                           and tabla = @w_tabla_nd))
                                     and hm_correccion = 'N')
                                     or (((hm_signo = 'D'
                                           and tabla = @w_tabla_nc)
                                           or (hm_signo = 'C'
                                               and tabla = @w_tabla_nd))
                                         and hm_correccion = 'S'))
        where  hm_cta_banco = @w_ec_cta_banco
           and hm_fecha     > @w_ec_fecha_ult_corte
           and hm_fecha     <= @i_fecha
           and hm_estado is null
        order  by hm_fecha,
                  hm_hora,
                  hm_secuencial,
                  hm_cod_alterno
    end

  /* Abrir el cursor de tran_his_ctas */
    /* Ubicar el primer registro para el cursor tran_his_ctas */

    open tran_his_ctas
    fetch tran_his_ctas into @w_hm_fecha,--0    
                             @w_hm_oficina,--1
                             @w_hm_nombre,--2        
                             @w_hm_correccion,--3
                             @w_hm_descripcion,--4
                             @w_hm_signo,--5
                             @w_hm_valor,--6
                             @w_hm_saldo_contable,--7
                             @w_hm_monto_imp,--8 
                             @w_hm_interes,--9
                             @w_hm_secuencial,--10
                             @w_hm_cod_alterno,--11
                             @w_hm_tipo_tran,--12
                             @w_hm_serial,--13
                             @w_hm_serial_tmp,--14  
                             @w_hm_causa,--15
                             @w_hm_estado,--16
                             @w_hm_ssn_branch,--17
                             @w_hm_hora,--18
                             @w_hm_valor_comision --19          

    /* Validacion del estado del cursor tran_his_ctas */

    if @@fetch_status = -2
    begin
      close tran_his_ctas
      deallocate tran_his_ctas

      select
        @w_msg = 'ERROR AL LEER INFORMACION HIS. DE LA CUENTA = ' +
                 @w_ec_cta_banco
      goto ERROR_REG
    end

    if @@fetch_status = -1
    begin
      close tran_his_ctas
      deallocate tran_his_ctas

    /**********************/
    /*| REGISTRO TIPO 03 |*/
    /**********************/
      /* Se acumulan los Depositos a los Creditos */
      select
        @w_num_nc = @w_num_nc + @w_num_dep
      select
        @w_total_nc = @w_total_nc + @w_depositos

      select
        @w_registro = '',
        @w_registro = '03' + @w_pipe + ltrim(rtrim(convert(varchar(4),
                      @w_tot_reg)
                      )
                      )
                      +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_total_nd))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_total_nc))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_ec_saldo_contable)))
                      +
                      @w_pipe

      insert into cob_ahorros..ah_ext_masivos_tmp
                  (emt_registro,emt_cta_banco,emt_estado)
      values      (@w_registro,@w_ec_cta_banco,null)

      if @@error <> 0
      begin
        select
          @w_msg = 'No se pudo crear el registro Tipo 03, de la Cuenta = ' +
                          @w_ec_cta_banco
        goto ERROR_REG
      end

    /**********************/
    /*| REGISTRO TIPO 04 |*/
      /**********************/

      select
        @w_registro = '',
        @w_registro = '04' + @w_pipe + ltrim(rtrim(convert(varchar(15),
                      @w_ec_saldo_ult_corte))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_total_nd))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_total_nc))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_total_int))) +
                      @w_pipe
                      + ltrim(rtrim(convert(varchar(15), @w_ec_saldo_contable)))
                      +
                      @w_pipe

      insert into cob_ahorros..ah_ext_masivos_tmp
                  (emt_registro,emt_cta_banco,emt_estado)
      values      (@w_registro,@w_ec_cta_banco,null)

      if @@error <> 0
      begin
        select
          @w_msg = 'No se pudo crear el registro Tipo 04, de la Cuenta = ' +
                          @w_ec_cta_banco
        goto ERROR_REG
      end

    /**********************/
    /*| REGISTRO TIPO 05 |*/
      /**********************/

      select
        @w_registro = ''
      select
        @w_registro = '05' + @w_pipe + ltrim(rtrim(@w_me_mensaje)) + @w_pipe

      insert into cob_ahorros..ah_ext_masivos_tmp
                  (emt_registro,emt_cta_banco,emt_estado)
      values      (@w_registro,@w_ec_cta_banco,null)

      if @@error <> 0
      begin
        select
          @w_msg = 'No se pudo crear el registro Tipo 05, de la Cuenta = ' +
                          @w_ec_cta_banco
        goto ERROR_REG
      end

      /* Se acumulan los debitos y los creditos */
      select
        @w_acum_total_retiros = @w_acum_total_retiros + @w_total_nd,
        @w_acum_total_depositos = @w_acum_total_depositos + @w_total_nc

      goto LEER_CTAS
    end

    while @@fetch_status = 0 /* Cursor tran_his_ctas*/
    begin
    /**********************/
    /*| REGISTRO TIPO 02 |*/
    /**********************/
      /* Se cuentan los registros de movimiento para cada cuenta procesada */
      select
        @w_tot_reg = @w_tot_reg + 1

      if @w_hm_signo = 'C'
          or @w_hm_signo = '*'
      begin
        if @w_hm_signo = 'C'
          select
            @w_saldo_cont_tmp = @w_saldo_cont_tmp + @w_hm_valor
      end
      else
        select
          @w_saldo_cont_tmp = @w_saldo_cont_tmp - @w_hm_valor

      if @w_abpais = 'CO'
        select
          @w_saldo_contable = @w_saldo_cont_tmp
      else
        select
          @w_saldo_contable = @w_hm_saldo_contable

      if @w_hm_correccion = 'S'
        select
          @w_hm_descripcion = @w_hm_descripcion + 'REVERSO'

      if @w_hm_signo = '*'
        select
          @w_hm_descripcion = @w_hm_descripcion + 'REMESA'

      if @w_hm_tipo_tran in ('207', '246', '248', '251',
                             '252', '254')
      begin
        if @w_hm_signo <> '*'
        begin
          select
            @w_num_dep = @w_num_dep + 1
          select
            @w_depositos = @w_depositos + @w_hm_valor
        end
      end

      if @w_hm_tipo_tran in ('229', '253', '255', '257',
                             '2503', '221', '294', '300')
      begin
        select
          @w_num_nc = @w_num_nc + 1
        select
          @w_total_nc = @w_total_nc + @w_hm_valor
      end

      if @w_hm_tipo_tran in ('228', '240', '262', '264',
                             '266', '2502', '237', '239',
                             '263', '371', '213')
      begin
        select
          @w_num_nd = @w_num_nd + 1
        select
          @w_total_nd = @w_total_nd + @w_hm_valor
      end

      if @w_hm_tipo_tran = '221'
      begin
        select
          @w_total_int = @w_total_int + @w_hm_valor
      end

      if @w_hm_signo = 'D'
        select
          @w_valord = ltrim(rtrim(convert(varchar, @w_hm_valor))),
          @w_valorc = 0

      if @w_hm_signo = 'C'
          or @w_hm_signo = '*'
        select
          @w_valorc = ltrim(rtrim(convert(varchar, @w_hm_valor))),
          @w_valord = 0

      select
        @w_registro = ''
      select
        @w_registro = '02' + @w_pipe + ltrim(rtrim(@w_hm_fecha)) + @w_pipe +
                      ltrim
                      (
                                                  rtrim (
                                                  @w_hm_nombre) ) + @w_pipe
                      + @w_valord + @w_pipe + @w_valorc + @w_pipe + ltrim(rtrim(
                      convert
                                                  ( varchar, @w_saldo_contable))
                      )
                      + @w_pipe + ltrim(rtrim(@w_hm_descripcion)) + @w_pipe

      insert into cob_ahorros..ah_ext_masivos_tmp
                  (emt_registro,emt_cta_banco,emt_estado)
      values      (@w_registro,@w_ec_cta_banco,null)

      if @@error <> 0
      begin
        select
          @w_msg = 'No se pudo crear el registro Tipo 02, de la Cuenta = ' +
                          @w_ec_cta_banco
        goto ERROR_REG
      end

      if @w_abpais = 'CO' /* si es Colombia */
      begin
        if isnull(@w_hm_valor_comision,
                  0) > 0 /* IVA */
        begin
          if @w_hm_correccion = 'S'
          begin
            select
              @w_hm_descripcion = @w_hm_descripcion + 'IMPUESTO IVA - REVERSO'
            select
              @w_total_nd = @w_total_nd - isnull(@w_hm_valor_comision,
                                                 $0)
            select
              @w_saldo_cont_tmp = @w_saldo_cont_tmp + isnull(
                                  @w_hm_valor_comision
                                  ,
                                  $0
                                  )
          end
          else
          begin
            select
              @w_hm_descripcion = @w_hm_descripcion + 'IMPUESTO IVA'
            select
              @w_total_nd = @w_total_nd + isnull(@w_hm_valor_comision, $0)
            select
              @w_saldo_cont_tmp = @w_saldo_cont_tmp - isnull(
                                  @w_hm_valor_comision,
                                  $0)
          end
          select
            @w_saldo_contable = @w_hm_saldo_contable + @w_hm_monto_imp

          /* Se cuentan los registros de movimiento para cada cuenta procesada */
          select
            @w_tot_reg = @w_tot_reg + 1

          if @w_hm_correccion <> 'S'
            select
              @w_valord = ltrim(rtrim(convert(varchar, @w_hm_valor_comision))),
              @w_valorc = 0
          else
            select
              @w_valorc = ltrim(rtrim(convert(varchar, @w_hm_valor_comision))),
              @w_valord = 0

          select
            @w_registro = ''
          select
            @w_registro = '02' + @w_pipe + ltrim(rtrim(@w_hm_fecha)) + @w_pipe +
                          ltrim
                          (
                                                      rtrim (
                                                      @w_hm_nombre) ) + @w_pipe
                          + @w_valord + @w_pipe + @w_valorc + @w_pipe + ltrim(
                          rtrim
                          (
                                                      convert( varchar,
                          @w_saldo_contable
                          ))
                                                      )
                          + @w_pipe + ltrim(rtrim(@w_hm_descripcion)) + @w_pipe

          insert into cob_ahorros..ah_ext_masivos_tmp
                      (emt_registro,emt_cta_banco,emt_estado)
          values      (@w_registro,@w_ec_cta_banco,null)

          if @@error <> 0
          begin
            select
              @w_msg = 'No se pudo crear el registro Tipo 02, de la Cuenta = ' +
                              @w_ec_cta_banco
            goto ERROR_REG
          end
        end

        if isnull(@w_hm_monto_imp,
                  0) > 0 /* GMF */
        begin
          if @w_hm_correccion = 'S'
          begin
            select
              @w_hm_descripcion = @w_hm_descripcion +
                                  ' - IMPUESTO GMF - REVERSO'
            select
              @w_total_nd = @w_total_nd - isnull(@w_hm_monto_imp,
                                                 $0)
            select
              @w_saldo_cont_tmp = @w_saldo_cont_tmp + isnull(@w_hm_monto_imp, $0
                                  )
          end
          else
          begin
            select
              @w_hm_descripcion = @w_hm_descripcion + ' - IMPUESTO GMF'
            select
              @w_total_nd = @w_total_nd + isnull(@w_hm_monto_imp, $0)
            select
              @w_saldo_cont_tmp = @w_saldo_cont_tmp - isnull(@w_hm_monto_imp,
                                                             $0)
          end
          select
            @w_saldo_contable = @w_saldo_cont_tmp

          /* Se cuentan los registros de movimiento para cada cuenta procesada */
          select
            @w_tot_reg = @w_tot_reg + 1

          if @w_hm_correccion <> 'S'
            select
              @w_valord = ltrim(rtrim(convert(varchar, @w_hm_monto_imp))),
              @w_valorc = 0
          else
            select
              @w_valorc = ltrim(rtrim(convert(varchar, @w_hm_monto_imp))),
              @w_valord = 0

          select
            @w_registro = ''
          select
            @w_registro = '02' + @w_pipe + ltrim(rtrim(@w_hm_fecha)) + @w_pipe +
                          ltrim
                          (
                                                      rtrim (
                                                      @w_hm_nombre) ) + @w_pipe
                          + @w_valord + @w_pipe + @w_valorc + @w_pipe + ltrim(
                          rtrim
                          (
                                                      convert( varchar,
                          @w_saldo_contable
                          ))
                                                      )
                          + @w_pipe + ltrim(rtrim(@w_hm_descripcion)) + @w_pipe

          insert into cob_ahorros..ah_ext_masivos_tmp
                      (emt_registro,emt_cta_banco,emt_estado)
          values      (@w_registro,@w_ec_cta_banco,null)

          if @@error <> 0
          begin
            select
              @w_msg = 'No se pudo crear el registro Tipo 02, de la Cuenta = ' +
                              @w_ec_cta_banco
            goto ERROR_REG
          end
        end

      end /* Fin If si es Colombia*/

      /* Localizar el siguiente registro del cursor tran_his_ctas */
      leer_mvtos_his:
      fetch tran_his_ctas into @w_hm_fecha,
                               @w_hm_oficina,
                               @w_hm_nombre,
                               @w_hm_correccion,
                               @w_hm_descripcion,
                               @w_hm_signo,
                               @w_hm_valor,
                               @w_hm_saldo_contable,
                               @w_hm_monto_imp,
                               @w_hm_interes,
                               @w_hm_secuencial,
                               @w_hm_cod_alterno,
                               @w_hm_tipo_tran,
                               @w_hm_serial,
                               @w_hm_serial_tmp,
                               @w_hm_causa,
                               @w_hm_estado,
                               @w_hm_ssn_branch,
                               @w_hm_hora,
                               @w_hm_valor_comision

      if @@fetch_status = -2
      begin
        close tran_his_ctas
        deallocate tran_his_ctas
        select
          @w_msg = 'ERROR AL LEER INFORMACION HIS. DE LA CUENTA = ' +
                   @w_ec_cta_banco
        goto ERROR_REG
      end

      if @@fetch_status = -1
      begin
        close tran_his_ctas
        deallocate tran_his_ctas

      /**********************/
      /*| REGISTRO TIPO 03 |*/
      /**********************/
        /* Se acumulan los Depositos a los Creditos */
        select
          @w_num_nc = @w_num_nc + @w_num_dep
        select
          @w_total_nc = @w_total_nc + @w_depositos

        select
          @w_registro = '',
          @w_registro = '03' + @w_pipe + ltrim(rtrim(convert(varchar(4),
                        @w_tot_reg)
                        )
                        )
                        +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_total_nd))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_total_nc))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_ec_saldo_contable)
                        )
                        )
                        +
                        @w_pipe

        insert into cob_ahorros..ah_ext_masivos_tmp
                    (emt_registro,emt_cta_banco,emt_estado)
        values      (@w_registro,@w_ec_cta_banco,null)

        if @@error <> 0
        begin
          select
            @w_msg = 'No se pudo crear el registro Tipo 03, de la Cuenta = ' +
                            @w_ec_cta_banco
          goto ERROR_REG
        end

      /**********************/
      /*| REGISTRO TIPO 04 |*/
        /**********************/

        select
          @w_registro = '',
          @w_registro = '04' + @w_pipe + ltrim(rtrim(convert(varchar(15),
                        @w_ec_saldo_ult_corte))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_total_nd))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_total_nc))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_total_int))) +
                        @w_pipe
                        + ltrim(rtrim(convert(varchar(15), @w_ec_saldo_contable)
                        )
                        )
                        +
                        @w_pipe

        insert into cob_ahorros..ah_ext_masivos_tmp
                    (emt_registro,emt_cta_banco,emt_estado)
        values      (@w_registro,@w_ec_cta_banco,null)

        if @@error <> 0
        begin
          select
            @w_msg = 'No se pudo crear el registro Tipo 04, de la Cuenta = ' +
                            @w_ec_cta_banco
          goto ERROR_REG
        end

      /**********************/
      /*| REGISTRO TIPO 05 |*/
        /**********************/

        select
          @w_registro = ''
        select
          @w_registro = '05' + @w_pipe + ltrim(rtrim(@w_me_mensaje)) + @w_pipe

        insert into cob_ahorros..ah_ext_masivos_tmp
                    (emt_registro,emt_cta_banco,emt_estado)
        values      (@w_registro,@w_ec_cta_banco,null)

        if @@error <> 0
        begin
          select
            @w_msg = 'No se pudo crear el registro Tipo 05, de la Cuenta = ' +
                            @w_ec_cta_banco
          goto ERROR_REG
        end

        /* Se acumulan los debitos y los creditos */
        select
          @w_acum_total_retiros = @w_acum_total_retiros + @w_total_nd,
          @w_acum_total_depositos = @w_acum_total_depositos + @w_total_nc

        goto LEER_CTAS
      end
    end /* Fin Cursor tran_his_ctas*/

    /* Se descarta Extracto para cuentas que generen error en la insercion de alguno de los resgistros tipo: 01,02,03, ¾ 04 */
    ERROR_REG:
    exec sp_errorlog
      @i_fecha       = @i_fecha,
      @i_error       = 1,
      @i_usuario     = 'Operador',
      @i_tran        = 0,
      @i_cuenta      = @w_ec_cta_banco,
      @i_descripcion = @w_msg,
      @i_programa    = @w_sp_name

    /* Se actualiza el Registro con error*/
    update cob_ahorros..ah_ext_masivos_tmp
    set    emt_estado = 'E'
    where  emt_cta_banco = @w_ec_cta_banco
       and emt_estado is null

    /* Localizar el siguiente registro del cursor cuentas_extracto */
    LEER_CTAS:
    fetch cuentas_extracto into @w_en_tipo_ced,
                                @w_ec_ced_ruc,
                                @w_ec_nombre,
                                @w_ec_oficina,
                                @w_ec_cta_banco,
                                @w_ec_fecha_prx_corte,
                                @w_ec_tasa_hoy,
                                @w_ec_fecha_ult_corte,
                                @w_ec_fecha_prx_corte1,
                                @w_ec_tipo_dir,
                                @w_ec_prod_banc,
                                @w_ec_saldo_contable,
                                @w_ec_saldo_promedio,
                                @w_ec_saldo_ult_corte,
                                @w_ec_descripcion_ec

    if @@fetch_status = -2
    begin
      close cuentas_extracto
      deallocate cuentas_extracto

      select
        @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
      goto ERROR
    end

  end /* Fin del while cursor cuentas_extracto */

  /* Cerrar y liberar cursor */
  close cuentas_extracto
  deallocate cuentas_extracto

  /* Se Borra toda La informacion de la Cuenta que genero el Error en la insercion de alguno de los resgistros tipo: 01,02,03,04 ¾ 05*/
  delete cob_ahorros..ah_ext_masivos_tmp
  where  emt_estado = 'E'

  /* Se inserta el registro 00, del archivo plano, con los totales generales */
  select
    @w_registro = '',
    @w_registro = '00' + @w_pipe + ltrim(rtrim(@w_nom_banco)) + @w_pipe
                  + ltrim(rtrim(convert(varchar(12), @i_fecha, @w_formato_fecha)
                  )
                  )
                  + @w_pipe
                  + ltrim(rtrim(convert(varchar(15), @w_contador_total_reg_01)))
                  +
                  @w_pipe
                  + ltrim(rtrim(convert(varchar(15), @w_acum_total_retiros))) +
                  @w_pipe
                  + ltrim(rtrim(convert(varchar(15), @w_acum_total_depositos)))
                  +
                  @w_pipe

  insert into cob_ahorros..ah_ext_masivos
              (em_registro)
  values      (@w_registro)

  if @@error <> 0
  begin
    select
      @w_msg = 'No se pudo crear el registro Tipo 00'
    goto ERROR
  end

  /* Se Insertan los registros de la tabla Temporal a la tabla final de donde se hace el BCP */
  insert into cob_ahorros..ah_ext_masivos
              (em_registro)
    select
      emt_registro
    from   cob_ahorros..ah_ext_masivos_tmp

  /* Se valida de que hayan registros para poder generar BCP, del archivo de Extractos Masivos */
  select
    @w_tot_reg = count(1)
  from   cob_ahorros..ah_ext_masivos

  if @w_tot_reg > 1
  begin
    select
      @w_path_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'S_APP'

    if @w_path_s_app is null
    begin
      select
        @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
      goto ERROR
    end

    /* Se Realiza BCP */
    select
      @w_s_app = @w_path_s_app + 's_app'

    select
      @w_path = ba_path_destino
    from   cobis..ba_batch
    where  ba_batch = 4139 --OJO CAMBIAR CUANDO SE GENERE LA SARTA

    select
      @w_archivo = 'ext_masivo_ctas_' + convert(varchar, @i_fecha, 112) + '.prn'
      ,
      @w_errores = 'err_ext_masivo_ctas_' + convert(varchar, @i_fecha,
                   112) +
                   '.txt'

    select
      @w_archivo_bcp = @w_path + @w_archivo,
      @w_errores = @w_path + @w_errores,
      @w_cmd = @w_s_app + ' bcp -auto -login cob_ahorros..ah_ext_masivos out '

    select
      @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e' + @w_errores +
                   ' -config ' + @w_s_app
                   + '.ini'

    exec @w_error = xp_cmdshell
      @w_comando

    if @w_error <> 0
    begin
      select
        @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' ' + convert(
                 varchar
                 ,
                        @w_error)
      goto ERROR
    end

  end
  else
  begin
    select
      @w_msg = 'No Existen datos Para Generar Archivo Plano Extractos Masivos'
    goto ERROR
  end

  FIN:
  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return 1

go

