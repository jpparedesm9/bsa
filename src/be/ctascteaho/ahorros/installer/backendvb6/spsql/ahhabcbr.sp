/********************************************************************/
/*  Archivo:            ahhabcbr.sp                                 */
/*  Stored procedure:   sp_hab_cbr                                  */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Ahorros                                     */
/*  Fecha de escritura:                                             */
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
/*                                                                  */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA         AUTOR           RAZON                             */
/*  04/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO      */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_hab_cbr')
  drop proc sp_hab_cbr
go

/****** Object:  StoredProcedure [dbo].[sp_hab_cbr]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc [dbo].[sp_hab_cbr]
  @t_show_version bit = 0,
  @i_param1       char(1) = 'N'
as
  declare
    @w_msg       descripcion,
    @w_fecha     datetime,
    @w_parametro descripcion,
    @w_tipo      char(1),
    @w_char      char(1),
    @w_producto  char(3),
    @v_parametro descripcion,
    @v_tipo      char(1),
    @v_char      char(1),
    @v_producto  char(3),
    @w_ssn       int = null,
    @s_ofi       smallint = null,
    @s_srv       varchar(30) = null,
    @w_sp_name   varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_hab_cbr'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  /* CAPTURA EL NOMBRE DEL SERVIDOR */
  select
    @s_srv = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'SRVR'

  /* CAPTURA DE SECUENCIAL */
  exec @w_ssn = ADMIN...rp_ssn

  /* Guardar los datos anteriores */
  select
    @w_parametro = pa_parametro,
    @w_tipo = pa_tipo,
    @w_char = pa_char,
    @w_producto = pa_producto
  from   cobis..cl_parametro
  where  pa_nemonico = 'HCBRPO'

  if @@rowcount = 0
  begin
    /* No existe parametro */
    select
      @w_msg = 'No existe parametro'
    goto ERROR
  end

  /* Guardar en transacciones de servicio solo los datos que han cambiado */
  select
    @v_parametro = @w_parametro,
    @v_tipo = @w_tipo,
    @v_char = @w_char,
    @v_producto = @w_producto

  if @w_char = @i_param1
    select
      @w_char = null,
      @v_char = null
  else
    select
      @w_char = @i_param1

  update cobis..cl_parametro
  set    pa_char = @i_param1
  where  pa_nemonico = 'HCBRPO'

  if @@error <> 0
  begin
    select
      @w_msg = 'NO SE PUDO ACTUALIZAR'
    goto ERROR
  end

  /* transaccion servicios - previo */
  insert into cobis..ts_parametro
              (secuencia,tipo_transaccion,clase,fecha,oficina_s,
               usuario,terminal_s,srv,lsrv,parametro,
               nemonico,tipo,pa_char,producto)
  values      (@w_ssn,577,'P',@w_fecha,1,
               'opbatch','CONSOLA',@s_srv,@s_srv,@v_parametro,
               'HCBRPO',@v_tipo,@v_char,@v_producto)

  if @@error <> 0
  begin
    /* 'Error en creacion de transaccion de servicios'*/
    select
      @w_msg = 'Error en creacion de transaccion de servicios'
    goto ERROR
  end

  /* transaccion servicios - anterior */
  insert into cobis..ts_parametro
              (secuencia,tipo_transaccion,clase,fecha,oficina_s,
               usuario,terminal_s,srv,lsrv,parametro,
               nemonico,tipo,pa_char,producto)
  values      (@w_ssn,577,'A',@w_fecha,1,
               'opbatch','CONSOLA',@s_srv,@s_srv,@w_parametro,
               'HCBRPO',@w_tipo,@w_char,@w_producto)

  if @@error <> 0
  begin
    /* 'Error en creacion de transaccion de servicios'*/
    select
      @w_msg = 'Error en creacion de transaccion de servicios'
    goto ERROR
  end

  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg

  return 1

go

