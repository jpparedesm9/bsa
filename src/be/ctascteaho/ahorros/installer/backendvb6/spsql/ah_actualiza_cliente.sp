/************************************************************************/
/*      Archivo:                ah_actualiza_cliente.sp                 */
/*      Stored procedure:       sp_ah_actualiza_cliente                 */
/*      Base de datos:          cob_cuentas                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Macosa                                  */
/*      Fecha de escritura:     01-Dic-1998                             */
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
/*      Actualizacion de datos desde clientes al maestro de ahorros     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR               RAZON                       */
/*    03/23/2006      D. Vasquez       Actualizacion de nombre solo     */
/*                                     cuando el ente es empresa        */
/*    19/10/2006      P. Coello       Considerar que tambien se pueden  */
/*                                    la zona postal ademas actualizar  */
/*                                    informaci¢n modificada en cabecera*/
/*                                    de estado de cuenta y detalle de  */
/*                                    producto                          */
/*    02/Mayo/2016    Ignacio Yupa    Migración a CEN                   */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_actualiza_cliente')
  drop proc sp_ah_actualiza_cliente
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_actualiza_cliente
(
  @t_show_version bit = 0,
  @i_fecha        smalldatetime,
  @o_procesadas   int out
)
as
  declare
    @w_cliente       int,
    @w_sp_name       varchar(64),
    @w_direccion     tinyint,
    @w_dir_aux       tinyint,
    @w_descripcion   varchar(120),
    @w_telefono      varchar(12),
    @w_cta           char(16),
    @w_mensaje       varchar(64),
    @w_tabla         varchar(64),
    @w_campo         varchar(64),
    @w_valor         varchar(64),
    @w_transaccion   char(1),
    @w_zona          char(3),
    @w_parroquia     smallint,
    @w_prx_fec_lab   datetime,
    @w_ciudad        int,
    @w_contador      int,
    @w_tipoc         char(1),
    @w_casilla       smallint,
    @w_valor_casilla varchar(120),
    @w_cliente_ant   int,
    @w_flag          char(1),
    @w_fecha_ini     datetime

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_ah_actualiza_cliente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_contador = 0

  select
    @w_fecha_ini = convert(varchar, datepart(mm, @i_fecha)) + '/01/'
                   + convert(varchar, datepart(yy, @i_fecha))

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
      @o_procesadas = @w_contador
    return 201196
  end

  /* Proxima fecha laborable */
  select
    @w_prx_fec_lab = min(dl_fecha)
  from   cob_ahorros..ah_dias_laborables
  where  dl_ciudad   = @w_ciudad
     and dl_num_dias = 1

  select
    @w_cliente_ant = 0

  /* Declaro el cursor */
  declare clientes cursor for
    select
      ac_ente,
      ac_tabla,
      ac_campo,
      ac_valor_nue,
      ac_transaccion,
      ac_secuencial1 --PCOELLO CODIGO DE CASILLA POSTAL SE GRABA EN ESTE CAMPO
    from   cobis..cl_actualiza
    where  ac_fecha >= @i_fecha
       and ac_fecha < @w_prx_fec_lab
    order  by ac_ente

  open clientes
  fetch clientes into @w_cliente,
                      @w_tabla,
                      @w_campo,
                      @w_valor,
                      @w_transaccion,
                      @w_casilla

  while @@fetch_status <> -2
  begin
    /* Control de error de lectura del cursor */
    if @@fetch_status = -1
    begin
      /* Error en lectura de tabla de camara */
      exec cobis..sp_cerror
        @i_num = 351017

      /* Cerrar y liberar cursor */
      close clientes
      deallocate clientes
      return 351017
    end

    if @w_cliente_ant <> @w_cliente
      select
        @w_cliente_ant = @w_cliente,
        @w_flag = 'N'

    if @w_tabla = 'cl_ente'
    begin
      begin tran
      if @w_campo = 'en_ced_ruc'
      begin
        if @w_valor is null
        begin
          select
            @w_mensaje = 'ERROR CAMPO CEDULA NULO'
          insert into cob_ahorros..re_error_batch
          values      (convert(varchar(10), @w_cliente),@w_mensaje)
          goto LEER
        end

        update cob_ahorros..ah_cuenta
        set    ah_ced_ruc = @w_valor
        where  ah_cliente = @w_cliente

        if @@error <> 0
        begin
          rollback tran
          select
            @w_mensaje = 'ERROR EN ACTUALIZACION DE CEDULA'
          insert into cob_ahorros..re_error_batch
          values      (convert(varchar(10), @w_cliente),@w_mensaje)
        end
        select
          @w_contador = @w_contador + 1
        goto LEER
      end

      if @w_campo = 'en_nomlar'
      begin
        select
          @w_tipoc = en_subtipo
        from   cobis..cl_ente
        where  en_ente = @w_cliente

        if @w_tipoc <> 'C'
        begin
          goto LEER
        end

        if @w_valor is null
        begin
          select
            @w_mensaje = 'ERROR CAMPO NOMBRE NULO'
          insert into cob_ahorros..re_error_batch
          values      (convert(varchar(10), @w_cliente),@w_mensaje)
          goto LEER
        end

        update cob_ahorros..ah_cuenta
        set    ah_nombre = @w_valor
        where  ah_cliente = @w_cliente

        if @@error <> 0
        begin
          rollback tran
          select
            @w_mensaje = 'ERROR EN ACTUALIZACION DE NOMBRE'
          insert into cob_ahorros..re_error_batch
          values      (convert(varchar(10), @w_cliente),@w_mensaje)
        end
        select
          @w_contador = @w_contador + 1
        goto LEER
      end

    end

    if @w_tabla = 'cl_direccion'
    begin
      if @w_campo = 'di_direccion'
          or @w_campo = 'di_descripcion'
      begin
        select
          dp_cuenta
        into   #cuentas_dir
        from   cobis..cl_cliente,
               cobis..cl_det_producto
        where  cl_cliente      = @w_cliente
           and dp_det_producto = cl_det_producto
           and dp_producto     = 4
        --and dp_cliente_ec = @w_cliente

        begin tran
        declare direcciones cursor for
          select
            dp_cuenta
          from   #cuentas_dir

        open direcciones /* Cursor para ctas del perfil */
        fetch direcciones into @w_cta

        while @@fetch_status <> -2
        begin
          if @@fetch_status = -1
          begin
          /* Error en lectura de tabla de Clientes */
            /* Cerrar y liberar cursor */
            close direcciones
            deallocate direcciones
            goto LEER
          end

          if @w_campo = 'di_direccion'
          begin
            if @w_valor is null
            begin
              select
                @w_mensaje = 'ERROR CAMPO CODIGO DIRECCION NULO'
              insert into cob_ahorros..re_error_batch
              values      (convert(varchar(10), @w_cliente),@w_mensaje)
              goto LEER_CLI
            end

            update cob_ahorros..ah_cuenta
            set    ah_direccion_ec = convert(tinyint, @w_valor)
            where  ah_cta_banco = @w_cta

            if @@error <> 0
            begin
              rollback tran
              select
                @w_mensaje = 'ERROR EN ACTUALIZACION DE CODIGO DE DIRECCION'
              insert into cob_ahorros..re_error_batch
              values      (convert(varchar(10), @w_cliente),@w_mensaje)
            end
            select
              @w_contador = @w_contador + 1
            goto LEER_CLI
          end

          if @w_campo = 'di_descripcion'
          begin
            if @w_valor is null
            begin
              select
                @w_mensaje = 'ERROR CAMPO DIRECCION NULO'
              insert into cob_ahorros..re_error_batch
              values      (convert(varchar(10), @w_cliente),@w_mensaje)
              goto LEER_CLI
            end

            update cob_ahorros..ah_cuenta
            set    ah_descripcion_ec = @w_valor
            where  ah_cta_banco    = @w_cta
               and ah_direccion_ec = @w_casilla
               and ah_tipo_dir     = 'D'

            if @@error <> 0
            begin
              rollback tran
              select
                @w_mensaje =
                'ERROR EN ACTUALIZACION DE DIRECCION ESTADO DE CUENTA'
              insert into cob_remesas..re_error_batch
              values      (convert(varchar(10), @w_cliente),@w_mensaje)
            end

            /******PCOELLO SE ACTUALIZA LA DESCRIPCION TAMBIEN EN LA TABLA DE CABECERA DE ESTADO DE CUENTA Y DETALLE DE PRODUCTO***/
            update ah_estado_cta
            set    ec_descripcion_ec = @w_valor
            where  ec_cta_banco    = @w_cta
               and ec_fecha_prx_corte between @w_fecha_ini and @i_fecha
               and ec_direccion_ec = @w_casilla
               and ec_tipo_dir     = 'D'

            if @@error <> 0
            begin
              rollback tran
              select
                @w_mensaje =
'ERROR EN ACTUALIZACION DE DIRECCION ESTADO DE CUENTA EN LA CABECERA DE ESTADO DE CUENTA'
  insert into cob_remesas..re_error_batch
  values      (convert(varchar(10), @w_cliente),@w_mensaje)
end

  update cobis..cl_det_producto
  set    dp_descripcion_ec = @w_valor
  where  dp_cuenta       = @w_cta
     and dp_producto     = 4
     and dp_direccion_ec = @w_casilla

  if @@error <> 0
  begin
    rollback tran
    select
      @w_mensaje =
'ERROR EN ACTUALIZACION DE DIRECCION ESTADO DE CUENTA EN EL DETALLE DEL PRODUCTO'
  insert into cob_remesas..re_error_batch
  values      (convert(varchar(10), @w_cliente),@w_mensaje)
end
  /******PCOELLO SE ACTUALIZA LA DESCRIPCION TAMBIEN EN LA TABLA DE CABECERA DE ESTADO DE CUENTA Y DETALLE DE PRODUCTO***/
  select
    @w_contador = @w_contador + 1
  goto LEER_CLI
end
  LEER_CLI:
  commit tran

  fetch direcciones into @w_cta
end
  close direcciones
  commit tran
  deallocate direcciones
  drop table #cuentas_dir
  goto LEER
end

  begin tran
  if @w_campo = 'di_parroquia'
  begin
    if @w_valor is null
    begin
      select
        @w_mensaje = 'ERROR CAMPO PARROQUIA NULO'
      insert into cob_ahorros..re_error_batch
      values      (convert(varchar(10), @w_cliente),@w_mensaje)
      goto LEER
    end

    update cob_ahorros..ah_cuenta
    set    ah_parroquia = convert(int, @w_valor)
    where  ah_cliente = @w_cliente

    if @@error <> 0
    begin
      rollback tran
      select
        @w_mensaje = 'ERROR EN ACTUALIZACION DE DIRECCION Y TELEFONO'
      insert into cob_ahorros..re_error_batch
      values      (convert(varchar(10), @w_cliente),@w_mensaje)
    end
    select
      @w_contador = @w_contador + 1
    goto LEER
  end

  if @w_campo = 'di_zona'
  begin
    if @w_valor is null
    begin
      select
        @w_mensaje = 'ERROR CAMPO ZONA NULO'
      insert into cob_ahorros..re_error_batch
      values      (convert(varchar(10), @w_cliente),@w_mensaje)
      goto LEER
    end

    update cob_ahorros..ah_cuenta
    set    ah_zona = convert(smallint, @w_valor)
    where  ah_cliente = @w_cliente

    if @@error <> 0
    begin
      rollback tran
      select
        @w_mensaje = 'ERROR EN ACTUALIZACION DE DIRECCION Y TELEFONO'
      insert into cob_ahorros..re_error_batch
      values      (convert(varchar(10), @w_cliente),@w_mensaje)
    end
    select
      @w_contador = @w_contador + 1
    goto LEER
  end
end

  if @w_tabla = 'cl_telefono'
  begin
    begin tran
    if @w_campo = 'te_valor'
    begin
      if @w_valor is null
      begin
        select
          @w_mensaje = 'ERROR CAMPO TELEFONO NULO'
        insert into cob_ahorros..re_error_batch
        values      (convert(varchar(10), @w_cliente),@w_mensaje)
        goto LEER
      end

      update cob_ahorros..ah_cuenta
      set    ah_telefono = @w_valor
      where  ah_cliente = @w_cliente

      if @@error <> 0
      begin
        rollback tran
        select
          @w_mensaje = 'ERROR EN ACTUALIZACION DE TELEFONO'
        insert into cob_ahorros..re_error_batch
        values      (convert(varchar(10), @w_cliente),@w_mensaje)
      end
      select
        @w_contador = @w_contador + 1
      goto LEER
    end
  end

  if @w_tabla = 'cl_casilla'
  begin
    if @w_campo = 'cs_valor'
        or @w_campo = 'cs_provincia'
        or @w_campo = 'cs_emp_postal'
           and @w_flag = 'N' --PCOELLO EL FLAG ES PARA QUE SOLO ENTRE UNA VEZ
    begin
      if @w_valor is null
      begin
        select
          @w_mensaje = 'ERROR CAMPO CASILLA POSTAL NULO'
        insert into cob_remesas..re_error_batch
        values      (convert(varchar(10), @w_cliente),@w_mensaje)
        goto LEER
      end

      if @w_casilla is null
      begin
        select
          @w_mensaje = 'ERROR CAMPO CODIGO DE CASILLA POSTAL NULO'
        insert into cob_remesas..re_error_batch
        values      (convert(varchar(10), @w_cliente),@w_mensaje)
        goto LEER
      end

      select
        dp_cuenta
      into   #cuentas_casilla
      from   cobis..cl_cliente,
             cobis..cl_det_producto
      where  cl_cliente      = @w_cliente
         and dp_det_producto = cl_det_producto
         and dp_producto     = 4

      select
        @w_valor_casilla = cs_valor + ' | '
                           + (select
                                zp_descripcion
                              from   cobis..cl_codpos
                              where  zp_coddep  = x.cs_provincia
                                 and zp_codzona = x.cs_emp_postal)
                           + ' | '
                           + (select
                                pv_descripcion
                              from   cobis..cl_provincia
                              where  pv_provincia = x.cs_provincia)
                           + ' | '
                           + (select
                                pa_descripcion
                              from   cobis..cl_provincia,
                                     cobis..cl_pais
                              where  x.cs_provincia = pv_provincia
                                 and pv_pais        = pa_pais)
      from   cobis..cl_casilla x
      where  cs_ente    = @w_cliente
         and cs_casilla = @w_casilla

      begin tran
      declare direcciones cursor for
        select
          dp_cuenta
        from   #cuentas_casilla

      open direcciones /* Cursor para ctas del perfil */
      fetch direcciones into @w_cta

      while @@fetch_status <> -2
      begin
        if @@fetch_status = -1
        begin
        /* Error en lectura de tabla de Clientes */
          /* Cerrar y liberar cursor */
          close direcciones
          deallocate direcciones
          goto LEER
        end

        update ah_cuenta
        set    ah_descripcion_ec = @w_valor_casilla
        where  ah_cta_banco    = @w_cta
           and ah_direccion_ec = @w_casilla
           and ah_tipo_dir     = 'C'

        if @@error <> 0
        begin
          rollback tran
          select
            @w_mensaje =
            'ERROR EN ACTUALIZACION DE CASILLA POSTAL ESTADO DE CUENTA'

          insert into cob_remesas..re_error_batch
          values      (convert(varchar(10), @w_cliente),@w_mensaje)
        end

        /******PCOELLO SE ACTUALIZA LA DESCRIPCION TAMBIEN EN LA TABLA DE CABECERA DE ESTADO DE CUENTA Y DETALLE DE PRODUCTO***/
        update ah_estado_cta
        set    ec_descripcion_ec = @w_valor_casilla
        where  ec_cta_banco    = @w_cta
           and ec_fecha_prx_corte between @w_fecha_ini and @i_fecha
           and ec_direccion_ec = @w_casilla
           and ec_tipo_dir     = 'C'

        if @@error <> 0
        begin
          rollback tran
          select
            @w_mensaje =
'ERROR EN ACTUALIZACION DE DIRECCION ESTADO DE CUENTA EN LA CABECERA DE ESTADO DE CUENTA'
  insert into cob_remesas..re_error_batch
  values      (convert(varchar(10), @w_cliente),@w_mensaje)
end

  update cobis..cl_det_producto
  set    dp_descripcion_ec = @w_valor_casilla
  where  dp_cuenta       = @w_cta
     and dp_producto     = 4
     and dp_direccion_ec = @w_casilla

  if @@error <> 0
  begin
    rollback tran
    select
      @w_mensaje =
'ERROR EN ACTUALIZACION DE DIRECCION ESTADO DE CUENTA EN EL DETALLE DEL PRODUCTO'
  insert into cob_remesas..re_error_batch
  values      (convert(varchar(10), @w_cliente),@w_mensaje)
end
  /******PCOELLO SE ACTUALIZA LA DESCRIPCION TAMBIEN EN LA TABLA DE CABECERA DE ESTADO DE CUENTA Y DETALLE DE PRODUCTO***/

  select
    @w_contador = @w_contador + 1

  commit tran
  fetch direcciones into @w_cta
end
  close direcciones
  commit tran
  deallocate direcciones
  drop table #cuentas_casilla
  select
    @w_flag = 'S'
  goto LEER
end
end

  LEER:
  commit tran

  fetch clientes into @w_cliente,
                      @w_tabla,
                      @w_campo,
                      @w_valor,
                      @w_transaccion,
                      @w_casilla

end
  close clientes
  commit tran
  deallocate clientes
  select
    @o_procesadas = @w_contador
  return 0

go

