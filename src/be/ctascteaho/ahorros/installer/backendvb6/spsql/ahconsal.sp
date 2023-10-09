/********************************************************************/
/*  Archivo:            ahconsal.sp                                 */
/*  Stored procedure:   sp_consulta_saldos_ah                       */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Ahorros                                     */
/*  Fecha de escritura: 08-Jun-2005                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
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
/*                         PROPOSITO                                */
/*      Este programa realiza lo SIGUIENTE:                         */
/*  1. Pasa los datos de la cabecera del estado de cuenta a la      */
/*     tabla cl_cons_saldo a las cuentas que tienen transacciones   */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA         AUTOR           RAZON                             */
/*  08/Jun/2005   R. Benavides    Cursores de cl_cons_saldo         */
/*  03/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO      */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consulta_saldos_ah')
  drop proc sp_consulta_saldos_ah
go

/****** Object:  StoredProcedure [dbo].[sp_consulta_saldos_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_consulta_saldos_ah
(
  @t_show_version bit = 0,
  @i_filial       tinyint,
  @i_fecha        smalldatetime,
  @o_procesadas   int out
)
as
  declare
    @w_ah_cta_banco    cuenta,
    @w_ah_disponible   money,
    @w_ah_oficina      smallint,
    @w_ofi             smallint,
    @w_sp_name         varchar(30),
    @w_ah_moneda       int,
    @w_ah_cliente      int,
    @w_contador        int,
    @w_ced             varchar(13),
    @w_oficial         smallint,
    @w_nombre          varchar(55),
    @w_moneda          tinyint,
    @w_producto        smallint,
    @w_fecha_aper      datetime,
    @w_ciudad_matriz   int,
    @w_ah_contador_trx int,
    @w_ah_12h          money,
    @w_ah_24h          money,
    @w_ret_bancos      money,
    @w_ah_remesas      money,
    @w_consumos        money,
    @w_contable        money,
    @w_saldo_interes   money,
    @w_cod_grupo       int

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_consulta_saldos_ah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

/* Obtencion del codigo de la ciudad de feriados nacionales para el */
  /* calculo de la fecha de proximo corte                             */

  select
    @w_contador = 0

  declare cursor_conssald cursor for
    select
      ah_cta_banco,
      ah_disponible,
      ah_nombre,
      ah_oficina,
      ah_contador_trx,
      ah_moneda,
      ah_cliente,
      ah_ced_ruc,
      ah_oficial,
      ah_fecha_aper,
      ah_saldo_interes
    from   cob_ahorros..ah_cuenta
    for read only

  open cursor_conssald
  fetch cursor_conssald into @w_ah_cta_banco,
                             @w_ah_disponible,
                             @w_nombre,
                             @w_ah_oficina,
                             @w_ah_contador_trx,
                             @w_ah_moneda,
                             @w_ah_cliente,
                             @w_ced,
                             @w_oficial,
                             @w_fecha_aper,
                             @w_saldo_interes

  while (@@fetch_status <> -2)
  begin
    /* Control de error de lectura del cursor */

    if @@fetch_status = -1
    begin
      /* Error en lectura del cursor */
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 351037

      /* Grabar en la tabla de errores */

      insert cob_remesas..re_error_batch
      values ('0','ERROR EN LECTURA DE TABLA DE CONSULTA DE SALDOS')

      /* Cerrar y liberar cursor */
      close cursor_conssald
      deallocate cursor_conssald

      select
        @o_procesadas = @w_contador
      return 201151
    end

    if @w_contador % 300 = 0
      begin tran

    select
      @w_ret_bancos = @w_ah_12h + @w_ah_24h
    select
      @w_contable = @w_ret_bancos + @w_ah_remesas + @w_ah_disponible +
                    @w_consumos

    select
      @w_cod_grupo = 0

    select
      @w_cod_grupo = isnull(en_grupo,
                            0)
    from   cobis..cl_ente
    where  en_ente = @w_ah_cliente

    /* Insercion de la cabecera en cl_cons_saldos */
    insert into cob_reportes..cl_cons_saldos
                (cs_ente,cs_nomlar,cs_ced_ruc,cs_oficial,cs_producto,
                 cs_fecha_apertura,cs_cuenta,cs_saldo,cs_fecha_vecimiento,
                 cs_saldo_capital,
                 cs_int_cte,cs_int_mora,cs_feci,cs_seg_vida,cs_seg_incendio,
                 cs_seg_auto,cs_tasa_int,cs_tasa_mora,cs_condi_esp,
                 cs_lim_tarjeta,
                 cs_saldo_adeudado,cs_fecha_saldo,cs_grupo)
    values      (@w_ah_cliente,@w_nombre,@w_ced,@w_oficial,'AHO',
                 @w_fecha_aper,@w_ah_cta_banco,@w_ah_disponible,null,null,
                 @w_saldo_interes,null,null,null,null,
                 null,null,null,null,null,
                 null,@i_fecha,@w_cod_grupo)

    if @@error <> 0
    begin
      rollback tran
      /* Error de insercion - Grabar en la tabla de errores */
      insert cob_ahorros..re_error_batch
      values (@w_ah_cta_banco,'ERROR EN LA INSERCION DEL ESTADO DE CUENTA')

      if @@error <> 0
      begin
        /* Error en grabacion de archivo de errores */
        exec cobis..sp_cerror
          @i_num = 203035

        /* Cerrar y liberar cursor */
        close cursor_conssald
        deallocate cursor_conssald

        select
          @o_procesadas = @w_contador
        return 203035
      end
      goto CUENTAS_CUR
    end

    select
      @w_contador = @w_contador + 1

    if @w_contador % 300 = 0
      commit tran

    CUENTAS_CUR:
    fetch cursor_conssald into @w_ah_cta_banco,
                               @w_ah_disponible,
                               @w_nombre,
                               @w_ah_oficina,
                               @w_ah_contador_trx,
                               @w_ah_moneda,
                               @w_ah_cliente,
                               @w_ced,
                               @w_oficial,
                               @w_fecha_aper,
                               @w_saldo_interes
  end

  commit tran
  close cursor_conssald
  deallocate cursor_conssald
  select
    @o_procesadas = @w_contador

  return 0

go

