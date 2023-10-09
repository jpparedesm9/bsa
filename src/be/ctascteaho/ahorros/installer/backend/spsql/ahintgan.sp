/********************************************************************/
/*  Archivo:                ahintgan.sp                             */
/*  Stored procedure:       sp_cont_int_ganados                     */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           Juan Carlos Gordillo                    */
/*  Fecha de escritura:     26-Oct-1999                             */
/********************************************************************/
/*                           IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                           PROPOSITO                              */
/*  BATCH:  Cursor que permite ingresar transacciones de servicio   */
/*  por el calculo de intereses ganados al inicio de mes            */
/********************************************************************/
/*                        MODIFICACIONES                            */
/*  FECHA         AUTOR            RAZON                            */
/*  07/Dic/1999   Juan F. Cadena   Emision Inicial                  */
/*  03/May/2016   J. Salazar       Migracion COBIS CLOUD MEXICO     */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cont_int_ganados')
  drop proc sp_cont_int_ganados
go

/****** Object:  StoredProcedure [dbo].[sp_cont_int_ganados]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_cont_int_ganados
(
  @s_rol          smallint = null,
  @t_show_version bit = 0,
  @i_filial       tinyint,
  @i_fecha        datetime,
  @i_turno        smallint = null,
  @o_num_reg      int out
)
as
  declare
    @w_sp_name            varchar(64),
    @w_procesadas         int,
    @w_ant_fec_lab        datetime,
    @w_ini_mes_act        datetime,
    @w_dias               smallint,
    @w_ssn                int,
    @w_trn_cont           smallint,
    @w_ciudad             int,
    @w_ofi_cont           smallint,
    @w_mon_cont           tinyint,
    @w_proban_cont        smallint,
    @w_cat_cont           catalogo,
    @w_valor_cont         money,
    @w_tipocta_super_cont char(1),
    @w_login_ope          varchar(10)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_cont_int_ganados'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Inicializar el contador de registros procesados */

  select
    @w_procesadas = 0

  /* Lectura para login operador batch*/
  select
    @w_login_ope = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  /* Encuentra el codigo de la ciudad de feriados nacionales */
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    /* Error en lectura de parametro de dias del anio */
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN LECTURA DE PARAMETRO DE CIUDAD'

    select
      @o_num_reg = @w_procesadas
    return 201196
  end

  /* Determinar el SSN */
  select
    @w_ssn = max(ts_secuencial)
  from   cob_ahorros..ah_tran_servicio
  where  ts_secuencial < 0

  if @w_ssn is null
    select
      @w_ssn = -10000000

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Fecha laborable anterior */
  select
    @w_ant_fec_lab = max(dl_fecha)
  from   cob_ahorros..ah_dias_laborables
  where  dl_ciudad   = @w_ciudad
     and dl_num_dias = -1

  select
    @w_dias = datediff(dd,
                       @w_ant_fec_lab,
                       @i_fecha)

  if datepart(mm,
              @w_ant_fec_lab) <> datepart(mm,
                                          @i_fecha)
     and @w_dias > 1
  begin
    select
      @w_dias = (datepart(dd,
                          @i_fecha) - 1) * (-1)

    if @w_dias = 0
      return 0
    else
      select
        @w_ini_mes_act = dateadd(dd,
                                 @w_dias,
                                 @i_fecha)
  end
  else
    return 0

  select
    @w_ssn = @w_ssn + 1

  begin tran

  -- Grabar transacciones de servicio por el calculo de interes ganados
  -- durante el inicio de mes feriado

  declare intereses cursor for
    select
      ac_oficina,
      ac_moneda,
      ac_prod_banc,
      ac_categoria,
      ac_trn,
      ac_intereses,
      ac_tipocta_super
    from   cob_ahorros..ah_acumulador
    where  ac_fecha = @w_ini_mes_act
       and ac_trn in (271)
    for read only

  open intereses

  fetch intereses into @w_ofi_cont,
                       @w_mon_cont,
                       @w_proban_cont,
                       @w_cat_cont,
                       @w_trn_cont,
                       @w_valor_cont,
                       @w_tipocta_super_cont

  while @@fetch_status <> -2
  begin
    /* Control de error de lectura del cursor */
    if @@fetch_status = -1
    begin
      /* Error en lectura de tabla de acumulados */
      exec cobis..sp_cerror
        @i_num = 351037,
        @i_sev = 1

      /* Grabar en la tabla de errores */
      insert cob_ahorros..re_error_batch
      values ('0','ERROR EN LECTURA DE TABLA DE ACUMULADOS')

      /* Cerrar y liberar cursor */
      close intereses
      deallocate intereses

      select
        @o_num_reg = @w_procesadas
      return 351037
    end

    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                 ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,ts_turno)
    values      (@w_ssn,@w_ssn,@w_trn_cont,@i_fecha,@w_login_ope,
                 'consola',@w_ofi_cont,'N','U','0',
                 @w_valor_cont,@w_mon_cont,@w_ofi_cont,@w_proban_cont,
                 @w_cat_cont,
                 @w_tipocta_super_cont,@i_turno)

    if @@error <> 0
    begin
      print 'Procesando 1 ..... Error Insercion Transaccion'
      rollback tran

      insert into cob_ahorros..re_error_batch
      values      ('0','ERROR EN INSERCION DE TRANSACCION DE SERVICIO')

      if @@error <> 0
      begin
        /* Error en grabacion de archivo de errores */
        exec cobis..sp_cerror
          @i_num = 203056
        /* Cerrar y liberar cursor */
        close intereses
        deallocate intereses

        select
          @o_num_reg = @w_procesadas
        return 203056
      end

      return 1
    end

    select
      @w_ssn = @w_ssn + 1,
      @w_procesadas = @w_procesadas + 1

    fetch intereses into @w_ofi_cont,
                         @w_mon_cont,
                         @w_proban_cont,
                         @w_cat_cont,
                         @w_trn_cont,
                         @w_valor_cont,
                         @w_tipocta_super_cont

  end

  -- Cerrar y liberar el cursor
  close intereses
  deallocate intereses

  /* Retornar el numero de registros procesados */
  select
    @o_num_reg = @w_procesadas

  commit tran

  return 0

go

