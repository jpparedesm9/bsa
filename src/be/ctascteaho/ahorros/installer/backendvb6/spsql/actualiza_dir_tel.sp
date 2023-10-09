/************************************************************************/
/*  Archivo:            actualiza_dir_tel.sp                            */
/*  Stored procedure:   sp_actualiza_dir_tel                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 25-Jul-1996                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa las transaccion de actualizacion de           */
/*  direccion y telefono de las cuentas de ahorros                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Jul/1996     Juan F. Cadena  Emision inicial                     */
/*  04/Mar/1999     Marco Sanguino  Personalizacion B. Caribe           */
/*  20/Oct/1999     Marco Sanguino  Agregar campos de cotitular         */
/*  12/Jun/2000     Yenny Rivero    Se programo para que actualice      */
/*                                  el nombre del cliente               */
/*  02/Mayo/2016    Ignacio Yupa    Migración a CEN                     */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_actualiza_dir_tel')
  drop proc sp_actualiza_dir_tel
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_actualiza_dir_tel
(
  @t_show_version bit = 0,
  @i_filial       tinyint,
  @i_fecha        smalldatetime,
  @o_procesadas   int out
)
as
  declare
    @w_sp_name         varchar(30),
    @w_ente            int,
    @w_direccion       tinyint,
    @w_dir_aux         tinyint,
    @w_descripcion     varchar(120),
    @w_telefono        varchar(12),
    @w_cliente         int,
    @w_cliente_ec      int,
    @w_zona            int,
    @w_parroquia       int,
    @w_sector          int,
    @w_contador        int,
    @w_tipo_dir        varchar(2),
    @w_cta             varchar(24),
    @w_mensaje         varchar(64),
    @w_tipo_persona    varchar(10),
    @w_aux             varchar(10),
    @w_cta_funcionario varchar(1),
    @w_nombre          char(64),
    @w_ced_ruc         char(13),
    @w_cliente1        int,
    @w_nombre1         char(64),
    @w_prodbanc        smallint

  select
    @w_contador = 0

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_actualiza_dir_tel'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Declaro el cursor */
  declare cuentas_cursor cursor for
    select
      ah_cliente_ec,
      ah_cliente1,
      ah_direccion_ec,
      ah_tipo_dir,
      ah_cta_banco,
      ah_cliente,
      ah_prod_banc
    from   cob_ahorros..ah_cuenta
    where  ah_estado <> 'C'
    for update of ah_nombre, ah_ced_ruc, ah_nombre1, ah_descripcion_ec,
    ah_telefono,
    ah_zona, ah_parroquia, ah_sector, ah_cta_funcionario

  open cuentas_cursor
  fetch cuentas_cursor into @w_cliente_ec,
                            @w_cliente1,
                            @w_direccion,
                            @w_tipo_dir,
                            @w_cta,
                            @w_cliente,
                            @w_prodbanc

  if @@fetch_status = -1
  begin
    close cuentas_cursor
    deallocate cuentas_cursor
    exec cobis..sp_cerror
      @i_num = 201157
    select
      @o_procesadas = @w_contador
    return 201157
  end
  else if @@fetch_status = -2
  begin
    close cuentas_cursor
    deallocate cuentas_cursor
    select
      @o_procesadas = @w_contador
    return 0
  end

  while @@fetch_status = 0
  begin
    /* Obtencion de datos del ente propietario de la cuenta */

    select
      @w_nombre = substring(en_nomlar,
                            1,
                            60),
      @w_ced_ruc = isnull(en_ced_ruc,
                          p_pasaporte),
      @w_tipo_persona = en_tipo_vinculacion
    from   cobis..cl_ente
    where  en_ente = @w_cliente

    /* Obtencion de datos del ente copropietario de la cuenta */

    if @w_cliente1 is not null
       and @w_cliente1 > 0
      select
        @w_nombre1 = substring(en_nomlar,
                               1,
                               60)
      from   cobis..cl_ente
      where  en_ente = @w_cliente1
    else
      select
        @w_nombre1 = ' '

    select
      @w_aux = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
       and pa_nemonico = 'CFU'

    if @w_tipo_persona = @w_aux
    begin
      if (select
            count(1)
          from   cobis..cl_catalogo
          where  tabla in
                 (select
                    codigo
                  from   cobis..cl_tabla
                  where  tabla = 'ah_producto_funcionario')
                 and codigo = convert(varchar(10), @w_prodbanc)
                 and estado = 'V') > 0
      begin
        select
          @w_cta_funcionario = 'S'
      end
      else
      begin
        select
          @w_cta_funcionario = 'N'
      end
    end
    else
      select
        @w_cta_funcionario = 'N'

    select
      @w_descripcion = ''

    -- si la direccion es tipo Domicilio

    if @w_tipo_dir = 'D'
    begin
      if @w_direccion <> 0
      begin
        select
          @w_descripcion = isnull(di_descripcion,
                                  ''),
          @w_zona = 0,
          @w_parroquia = isnull(di_ciudad,
                                0),
          @w_sector = 0
        from   cobis..cl_direccion
        where  di_ente      = @w_cliente_ec
           and di_direccion = @w_direccion

        select
          @w_dir_aux = @w_direccion
      end
      else
      begin
        select
          @w_dir_aux = 1
        select
          @w_descripcion = isnull(di_descripcion,
                                  ''),
          @w_zona = 0,
          @w_parroquia = isnull(di_ciudad,
                                0),
          @w_sector = 0
        from   cobis..cl_direccion
        where  di_ente      = @w_cliente_ec
           and di_direccion = 1
      end
    end
    else
    -- si la direccion es tipo Casilla
    if @w_tipo_dir = 'C'
    begin
      if @w_direccion <> 0
      begin
        select
          @w_descripcion = isnull(cs_valor, '') + ' | ' + sc_descripcion,
          @w_zona = isnull(cs_provincia,
                           0),
          @w_parroquia = isnull(cs_ciudad,
                                0),
          @w_sector = 0
        from   cobis..cl_casilla,
               cobis..cl_suc_correo
        where  cs_ente      = @w_cliente
           and cs_casilla   = @w_direccion
           and cs_sucursal  = sc_sucursal
           and cs_provincia = sc_provincia
           and cs_provincia is not null

        select
          @w_dir_aux = @w_direccion
      end
      else
      begin
        select
          @w_dir_aux = 1
        select
          @w_descripcion = isnull(cs_valor,
                                  ''),
          @w_zona = isnull(cs_provincia,
                           0),
          @w_parroquia = isnull(cs_ciudad,
                                0),
          @w_sector = 0
        from   cobis..cl_casilla
        where  cs_ente    = @w_cliente_ec
           and cs_casilla = 1
      end
    end

    select
      @w_telefono = null

    select
      @w_telefono = te_valor
    from   cobis..cl_telefono
    where  te_ente       = @w_cliente
       and te_direccion  = @w_dir_aux
       and te_secuencial = 1

    if @w_telefono is null
    begin
      set rowcount 1
      select
        @w_telefono = te_valor
      from   cobis..cl_telefono
      where  te_ente = @w_cliente

      if @w_telefono is null
        select
          @w_telefono = 'XXXXXX'
    end
    set rowcount 0

    begin tran

    if @w_direccion <> 0
    begin
      update cob_ahorros..ah_cuenta
      set    ah_nombre = @w_nombre,
             ah_ced_ruc = @w_ced_ruc,
             ah_nombre1 = @w_nombre1,
             ah_telefono = @w_telefono,
             ah_descripcion_ec = @w_descripcion,
             ah_cta_funcionario = @w_cta_funcionario,
             ah_zona = @w_zona,
             ah_parroquia = @w_parroquia,
             ah_sector = @w_sector
      where  current of cuentas_cursor

      if @@error <> 0
      begin
        select
          @w_mensaje = 'ERROR EN ACTUALIZACION DE DIRECCION Y TELEFONO'

        rollback tran
        insert into cob_ahorros..re_error_batch
        values      (@w_cta,@w_mensaje)

        if @@error <> 0
        begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
            @i_num = 203035

          /* Cerrar y liberar cursor */
          close cuentas_cursor
          deallocate cuentas_cursor

          select
            @o_procesadas = @w_contador
          return 203035
        end
        goto LEER
      end
    end
    else
    begin
      update cob_ahorros..ah_cuenta
      set    ah_nombre = @w_nombre,
             ah_ced_ruc = @w_ced_ruc,
             ah_nombre1 = @w_nombre1,
             ah_telefono = @w_telefono,
             ah_cta_funcionario = @w_cta_funcionario
      where  current of cuentas_cursor

      if @@error <> 0
      begin
        select
          @w_mensaje = 'ERROR EN ACTUALIZACION DE TELEFONO'

        rollback tran
        insert into cob_ahorros..re_error_batch
        values      (@w_cta,@w_mensaje)

        if @@error <> 0
        begin
          /* Error en grabacion de archivo de errores */
          exec cobis..sp_cerror
            @i_num = 203035

          /* Cerrar y liberar cursor */
          close cuentas_cursor
          deallocate cuentas_cursor

          select
            @o_procesadas = @w_contador
          return 203035
        end

        goto LEER
      end
    end

    select
      @w_contador = @w_contador + 1

    commit tran

    LEER:
    fetch cuentas_cursor into @w_cliente_ec,
                              @w_cliente1,
                              @w_direccion,
                              @w_tipo_dir,
                              @w_cta,
                              @w_cliente,
                              @w_prodbanc
  end
  close cuentas_cursor
  deallocate cuentas_cursor
  return 0

go

