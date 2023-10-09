/************************************************************************/
/*  Archivo:            cobro_comision_mensual.sp                       */
/*  Stored procedure:   sp_cobrocob_mens_ah                             */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Carlos Munoz                                    */
/*  Fecha de escritura: 22 - ene - 2010                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa consulta las parametrizaciones para cobro             */
/*  de comisiones                                                       */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  22/Ene/2010     Carlos Munoz    Emision inicial                     */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
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
           where  name = 'sp_cobrocob_mens_ah')
  drop proc sp_cobrocob_mens_ah
go

create proc sp_cobrocob_mens_ah
(
  @t_show_version bit = 0,
  @s_user         varchar(30) = null,
  @i_param1       datetime -- Fecha de Proceso
)
as
  declare
    @w_return          int,
    @w_cuenta          int,
    @w_sp_name         varchar(30),
    @w_fecha           datetime,
    @w_filial          tinyint,
    @w_oficina         smallint,
    @w_promedio        char(1),
    @w_promdisp        money,
    @w_val             money,
    @w_valor           money,
    @w_alic            money,
    @w_numdeci         tinyint,
    @w_fldeci          char(1),
    @w_lineas          smallint,
    @w_clave           int,
    @w_control         int,
    @w_linpen          int,
    @w_personalizada   char(1),
    @w_categoria       char(1),
    @w_tipocta         char(1),
    @w_rol_ente        char(1),
    @w_tipo_def        char(1),
    @w_prod_banc       smallint,
    @w_producto        tinyint,
    @w_moneda          tinyint,
    @w_tipo            char(1),
    @w_disponible      money,
    @w_saldo_cont      money,
    @w_promedio1       money,
    @w_prom_disponible money,
    @w_codigo          int,
    @w_cobro_comision  money,
    @w_ssn             int,
    @w_procesadas      int,
    @w_srv             varchar(12),
    @w_cta_banco       cuenta,
    @w_valiva          money,
    @w_fecha_aux       datetime,
    @w_error           int,
    @w_msj             varchar(255)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_cobrocob_mens_ah',
    @w_fecha = @i_param1,
    @w_filial = 1

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Lectura para login operador batch*/
  select
    @s_user = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fecha,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'N',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  if convert(tinyint, datepart(mm,
                               @w_fecha_aux)) =
     convert(tinyint, datepart(mm,
                               @w_fecha
                      ))
    return 0

  /* Encuentra el SSN inicial */

  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    select
      @w_error = 201163,
      @w_msj = 'ERROR AL LEER SECUENCIAL'
    goto ERRORFIN
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 1000000

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    select
      @w_error = 205031,
      @w_msj = 'ERROR AL ACTUALIZAR SECUENCIAL'
    goto ERRORFIN
  end

  select
    @w_procesadas = 0

  select
    @w_srv = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  print ' Empieza el sp: ' + @w_sp_name
  select
    @w_cuenta = 0

  while 1 = 1
  begin
    select
      @w_cobro_comision = 0

    set rowcount 1

    select
      @w_cuenta = ah_cuenta,
      @w_cta_banco = ah_cta_banco,
      @w_personalizada = ah_personalizada,
      @w_oficina = ah_oficina,
      @w_categoria = ah_categoria,
      @w_tipocta = ah_tipocta,
      @w_codigo = ah_default,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_moneda = ah_moneda,
      @w_tipo = ah_tipo,
      @w_disponible = ah_disponible,
      @w_saldo_cont = (ah_disponible + ah_12h + ah_24h),
      @w_promedio1 = ah_promedio1,
      @w_prom_disponible = ah_prom_disponible
    from   cob_ahorros..ah_cuenta,
           cob_remesas..pe_pro_final,
           cob_remesas..pe_mercado,
           cob_remesas..pe_par_comision,
           cobis..cl_oficina
    where  ah_estado    = 'A'
       and ah_prod_banc = me_pro_bancario
       and ah_tipocta   = me_tipo_ente
       and pf_mercado   = me_mercado
       and me_estado    = 'V'
       and ah_moneda    = pf_moneda
       and ah_tipo      = pf_tipo
       and ah_filial    = pf_filial
       and ah_oficina   = of_oficina
       and pf_sucursal  = of_regional
       and pc_profinal  = pf_pro_final
       and pc_categoria = ah_categoria
       and pc_tipo      = 'M' --Mensual
       and pc_estado    = 'V'
       and ah_cuenta    > @w_cuenta
    order  by ah_cuenta

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end
    set rowcount 0
    print ' -'

    -- SE BUSCA COSTOS DE COBRO COMISIONES

    print ' La cuenta es ' + @w_cta_banco

    exec @w_return = cob_remesas..sp_genera_costos
      @s_srv         = @w_srv,
      @s_ofi         = @w_oficina,
      @s_ssn         = @w_ssn,
      @s_user        = @s_user,
      @t_from        = @w_sp_name,
      @i_fecha       = @w_fecha,
      @i_valor       = 1,
      @i_batch       = 'S',
      @i_categoria   = @w_categoria,
      @i_tipo_ente   = @w_tipocta,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_def,
      @i_prod_banc   = @w_prod_banc,
      @i_producto    = @w_producto,
      @i_moneda      = @w_moneda,
      @i_tipo        = @w_tipo,
      @i_codigo      = @w_codigo,
      @i_servicio    = 'COCO',
      @i_rubro       = '3',
      @i_disponible  = @w_disponible,
      @i_contable    = @w_saldo_cont,
      @i_promedio    = @w_promedio1,
      @i_prom_disp   = @w_prom_disponible,
      @i_personaliza = @w_personalizada,
      @i_filial      = @w_filial,
      @i_oficina     = @w_oficina,
      @o_valor_total = @w_cobro_comision out

    if @w_return <> 0
    begin
      while @@trancount > 0
        rollback
      select
        @w_error = @w_return,
        @w_msj = 'ERROR EN BUSQUEDA DE COSTO - Servicio COCO Rubro 3'
      goto ERROR
    end

    -- COBRO COMISIONES
    if isnull(@w_cobro_comision,
              0) > 0
    begin
      print ' La comision a cobrar es ' + cast (@w_cobro_comision as varchar)

      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv        = @w_srv,
        @s_ofi        = @w_oficina,
        @s_ssn        = @w_ssn,
        @s_ssn_branch = @w_ssn,
        @s_user       = @s_user,
        @t_trn        = 264,
        @i_cta        = @w_cta_banco,
        @i_val        = @w_cobro_comision,
        @i_cau        = '90',-- cobro de comisiones
        @i_mon        = @w_moneda,
        @i_alt        = 2,
        @i_fecha      = @w_fecha,
        @i_canal      = 4,
        @o_valiva     = @w_valiva out
      if @w_return <> 0
      begin
        select
          @w_error = @w_return,
          @w_msj = 'ERROR EN COBRO DE COMISION'
        goto ERROR
      end

      while @@trancount > 0
        commit tran
      select
        @w_procesadas = @w_procesadas + 1,
        @w_ssn = @w_ssn + 1

    end

    goto SIGUIENTE

    ERROR:
    while @@trancount > 0
      rollback

    exec sp_errorlog
      @i_cuenta      = @w_cta_banco,
      @i_fecha       = @w_fecha,
      @i_error       = @w_error,
      @i_usuario     = 'batch',
      @i_tran        = 264,
      @i_descripcion = @w_msj,
      @i_programa    = @w_sp_name
    SIGUIENTE:
  end
  print ' Total procesadas ' + cast (@w_procesadas as varchar)
  return 0

  ERRORFIN:
  while @@trancount > 0
    rollback
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = @s_user,
    @i_tran        = 264,
    @i_descripcion = @w_msj,
    @i_programa    = @w_sp_name
  return @w_error

go

