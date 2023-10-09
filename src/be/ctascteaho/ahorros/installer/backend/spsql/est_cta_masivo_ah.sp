/************************************************************************/
/*      Archivo:                est_cta_masivo_ah.sp                    */
/*      Stored procedure:       sp_est_cta_masivo_ah                    */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Creado por:             Pedro Romero                            */
/*      Fecha de escritura:     07-Septiembre-2016                      */
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
/* BATCH: Genera el detalle de los estados de cuenta de forma masiva    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*                                                                      */
/*  07/Sept/2016        P. Romero     Version Inicial                   */
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
           where  name = 'sp_est_cta_masivo_ah')
  drop proc sp_est_cta_masivo_ah
go

create proc sp_est_cta_masivo_ah
(
  @t_show_version bit = 0,
  @i_fecha        datetime = null,
  @i_param1       datetime,--Fecha Proceso ,
  @i_param2       int,--filial
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

  select
    @w_formato_fecha = 103,
    @w_flag_ofi = 0,
    @w_flag_prod_banc = 0

  select
    @w_abpais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

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

   /* Determinacion de las tablas de NC y ND  */
  select
    @w_tabla_nc = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nc'

  select
    @w_tabla_nd = codigo
  from   cobis..cl_tabla
  where  tabla = 'ah_causa_nd'

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

    select
      @w_nombre_of = isnull(substring (of_nombre,
                                       1,
                                       15),
                            'OFICINA SIN NOMBRE')
    from   cobis..cl_oficina
    where  of_filial  = 1
       and of_oficina = @w_ec_oficina

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
	  
	--Truncado de tabla
	truncate table cob_ahorros..ah_det_estado_cuenta

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
		insert into ah_det_estado_cuenta 
				(de_fecha,
				de_cta_banco, 
				de_oficina,
				de_nombre,
				de_correcion,
				de_transaccion, 
				de_signo,
				de_valor,
				de_saldo_contable,
				de_impuesto,
				de_interes,
				de_secuencial,   
				de_cod_alterno,
				de_tipotran,   
				de_serial,   
				de_destino,
				de_causa,  
				de_estado,
				de_ssnbranch,
				de_hora,
				de_valcomision)
         select
          convert(varchar(12), hm_fecha, @w_formato_fecha),
		  hm_cta_banco,
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
                                         and  hm_correccion = 'S')),
				cob_ahorros..ah_estado_cta
        where  hm_cta_banco = ec_cta_banco
           and hm_fecha     > ec_fecha_ult_corte
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
        select
          convert(varchar(12), hm_fecha, @w_formato_fecha),
		  hm_cta_banco,
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
        from   cob_ahorros_his..ah_his_movimiento X
               inner join cobis..cl_ttransaccion
                       on tn_trn_code = hm_tipo_tran
               inner join cobis..cl_oficina
                       on of_oficina = hm_oficina
                          and of_filial = @i_param2
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

