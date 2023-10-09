/********************************************************************/
/*  Archivo:                depura_linpendientes.sp                 */
/*  Stored procedure:       sp_depura_linpendientes                 */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           Juan C. Gordillo                        */
/*  Fecha de escritura:     08-Mar-1999                             */
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
/*                          PROPOSITO                               */
/*  Este programa selecciona aquellas cuentas de ahorro de          */
/*  categorias que no postean lineas pendientes, verifica si        */
/*  existen lineas pendientes para estas cuentas y elimina estas    */
/*  lineas de la tabla de lineas pendientes.                        */
/********************************************************************/
/*                        MODIFICACIONES                            */
/*  FECHA            AUTOR           RAZON                          */
/*  08/Mar/1999      J. Salazar      Emision inicial                */
/*  03/May/2016      J. Salazar      Migracion COBIS CLOUD MEXICO   */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_depura_linpendientes')
  drop proc sp_depura_linpendientes
go

/****** Object:  StoredProcedure [dbo].[sp_depura_linpendientes]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_depura_linpendientes
(
  @t_show_version bit = 0,
  @i_filial       tinyint,
  @o_procesadas   int out
)
as
  declare
    @w_cuenta        int,
    @w_cta_banco     char(16),
    @w_control       int,
    @w_linea         smallint,
    @w_ult_linea     smallint,
    @w_saldo_libreta money,
    @w_disponible    money,
    @w_12h           money,
    @w_24h           money,
    @w_remesas       money,
    @w_sp_name       varchar(30),
    @w_contador      int

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_depura_linpendientes'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_contador = 0

  insert into tempdb..tmp_categoria_profinal
    select
      pf_filial,of_oficina,me_pro_bancario,me_tipo_ente,pf_producto,
      pf_moneda,cp_categoria,cp_posteo
    from   cob_remesas..pe_pro_final,
           cob_remesas..pe_mercado,
           cob_remesas..pe_categoria_profinal,
           cobis..cl_oficina
    where  pf_mercado  = me_mercado
       and cp_profinal = pf_pro_final
       and pf_producto = 4
       and cp_posteo   = 'N'
       and pf_sucursal = isnull(of_sucursal,
                                of_oficina)

  if @@error <> 0
  begin
    /* ERROR EN LA CREACION DE LA TABLA TEMPORAL */
    exec cobis..sp_cerror
      @i_num = 909000

    select
      @o_procesadas = @w_contador
    return 909000
  end

  declare cuentas cursor for
    select
      ah_cuenta,
      ah_cta_banco,
      ah_control,
      ah_linea,
      ah_ult_linea,
      ah_saldo_libreta,
      ah_disponible,
      ah_12h,
      ah_24h,
      ah_remesas
    from   cob_ahorros..ah_cuenta,
           tempdb..tmp_categoria_profinal
    where  ah_filial    = tmp_filial
       and ah_filial    = @i_filial
       and ah_oficina   = tmp_sucursal
       and ah_oficina   >= 0
       and ah_prod_banc = tmp_pro_bancario
       and ah_tipocta   = tmp_tipo_ente
       and ah_producto  = tmp_producto
       and ah_producto  = 4
       and ah_moneda    = tmp_moneda
       and ah_moneda    >= 0
       and ah_categoria = tmp_categoria
    for read only

  open cuentas
  fetch cuentas into @w_cuenta,
                     @w_cta_banco,
                     @w_control,
                     @w_linea,
                     @w_ult_linea,
                     @w_saldo_libreta,
                     @w_disponible,
                     @w_12h,
                     @w_24h,
                     @w_remesas

  if @@fetch_status = -1
  begin
    close cuentas
    deallocate cuentas

    /* ERROR EN EJECUCION DEL CURSOR */
    exec cobis..sp_cerror
      @i_num = 708157

    select
      @o_procesadas = @w_contador
    return 708157
  end
  else if @@fetch_status = -2
  begin
    close cuentas
    deallocate cuentas
    select
      @o_procesadas = @w_contador
    return 0
  end

  while @@fetch_status = 0
  begin
    if @w_linea > 0
    begin
      if @w_contador % 20000 = 0
        begin tran

      update cob_ahorros..ah_linea_pendiente
      set    lp_enviada = 'S'
      where  lp_enviada = 'N'
         and lp_cuenta  = @w_cuenta

      if @@error <> 0
      begin
        print 'Procesando 1....'

        rollback tran

        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,
                     'ERROR EN LA ACTUALIZACION DE LINEAS PENDIENTES'
        )

        if @@error <> 0
        begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
            @i_num = 253013

          /* Cerrar y liberar cursor */
          close cuentas
          deallocate cuentas

          select
            @o_procesadas = @w_contador
          return 253013
        end

        goto LEER
      end

      update ah_cuenta
      set    ah_control = 0,
             ah_linea = 0,
             ah_ult_linea = 0,
             ah_saldo_libreta = @w_disponible + @w_12h + @w_24h + @w_remesas
      where  ah_cta_banco = @w_cta_banco

      if @@error <> 0
      begin
        /* ERROR AL ACTUALIZAR CUENTA DE AHORROS */
        exec cobis..sp_cerror
          @i_num = 255001

        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,
                     'ERROR EN LA ACTUALIZACION DE LINEAS PENDIENTES'
        )

        if @@error <> 0
        begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
            @i_num = 253013

          /* Cerrar y liberar cursor */
          close cuentas
          deallocate cuentas

          select
            @o_procesadas = @w_contador
          return 253013
        end

        goto LEER
      end

      select
        @w_contador = @w_contador + 1

      if @w_contador % 20000 = 0
        commit tran
    end

    LEER:

    fetch cuentas into @w_cuenta,
                       @w_cta_banco,
                       @w_control,
                       @w_linea,
                       @w_ult_linea,
                       @w_saldo_libreta,
                       @w_disponible,
                       @w_12h,
                       @w_24h,
                       @w_remesas

    if @@fetch_status = -1
    begin
      close cuentas
      deallocate cuentas

      /* ERROR EN EJECUCION DEL CURSOR */
      exec cobis..sp_cerror
        @i_num = 708157

      select
        @o_procesadas = @w_contador
      return 708157
    end

  end

  close cuentas
  deallocate cuentas

  commit tran

  select
    @o_procesadas = @w_contador

  return 0

go

