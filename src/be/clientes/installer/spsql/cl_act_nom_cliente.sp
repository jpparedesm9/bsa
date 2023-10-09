/************************************************************************/
/*      Archivo:                ah_act_nom_cliente.sp                   */
/*      Stored procedure:       sp_act_nom_cliente                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               clientes                                */
/*      Disenado por:           Edwin Jimenez                           */
/*      Fecha de escritura:     10/08/2013                              */
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
/*      Actualiza el nombre del cliente desde un archivo plano, ingreso */
/*      CODIGO cliente.                                                 */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_act_nom_cliente')
  drop proc sp_act_nom_cliente
go

create proc sp_act_nom_cliente
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name          char(30),
    @w_fechaproceso     datetime,
    @w_sp               varchar(26),
    @w_prod_cliente     int,
    @w_ente             int,
    @w_path_error_s_app varchar(250),
    @w_bd               varchar(250),
    @w_file             varchar(250),
    @w_tabla            varchar(250),
    @w_fuente           varchar(250),
    @w_errores          varchar(255),
    @w_comando          varchar(500),
    @w_mensaje          varchar(255),
    @w_slm              money,
    @w_s_app            varchar(50),
    @w_path             varchar(60),
    @w_error            int,
    @w_ssn              int,
    @w_nombre           varchar(255),
    @w_cmd              varchar(255),
    @w_nombre_solo      varchar(64),
    @w_apellido_solo    varchar(255),
    @w_cedula           varchar(30)

  select
    @w_sp_name = 'sp_act_nom_cliente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fechaproceso = fp_fecha
  from   cobis..ba_fecha_proceso with(nolock)

  /* CREACION DE LA TABLA PARA ORS613*/
  if exists (select
               1
             from   sysobjects
             where  name = 'cl_clientes_act_ORS613')
    drop table cl_clientes_act_ORS613

  create table cobis..cl_clientes_act_ORS613
  (
    ca_ente int
  )

  select
    @w_sp = 'cobis..sp_act_nom_cliente'

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp

  select
    @w_path_error_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    print @@rowcount
    print @w_path_error_s_app
    print @w_path
    print 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    return 1
  end

  /* Carga Parametros para el bcp */
  select
    @w_s_app = @w_path_error_s_app + 's_app',
    @w_cmd = @w_s_app + ' bcp ',
    @w_bd = 'cobis'

  select
    @w_file = 'ACT_NOMBRE_CLIENTE.txt',
    @w_tabla = 'cl_clientes_act_ORS613',
    @w_fuente = @w_path + @w_file,
    @w_errores = @w_path + @w_file + '.err'

  select
       @w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' in ' + @w_fuente +
                    ' -c -t"|" -auto -login '
                    + '-config '
                 + @w_s_app + '.ini > ' + @w_errores
  print @w_comando
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print @w_error
    return @w_error
  end

  select
    dp_producto,
    dp_cliente_ec
  into   #productos
  from   cobis..cl_det_producto,
         cobis..cl_clientes_act_ORS613
  where  ca_ente = dp_cliente_ec
  order  by dp_cliente_ec desc

  while 1 = 1
  begin
    /* OBTIENE NOMBRE DE CADA UNO DE LOS ENTES A PROCESAR */
    select top 1
      @w_ente = ca_ente,
      @w_cedula = en_ced_ruc,
      @w_nombre = en_nomlar,
      @w_nombre_solo = en_nombre,
      @w_apellido_solo = isnull(p_p_apellido, ' ') + ' ' + isnull(p_s_apellido,
                         ' ')
    from   cl_clientes_act_ORS613,
           cl_ente
    where  ca_ente = en_ente
       and ca_ente is not null

    if @@rowcount = 0
      break

    while 1 = 1
    begin
      /* OBTIENE SECUENCIAL PARA LOG */
      exec @w_ssn = ADMIN...rp_ssn

      select top 1
        @w_prod_cliente = dp_producto
      from   #productos
      where  dp_cliente_ec = @w_ente

      if @@rowcount = 0
        break

      set rowcount 0

      if @w_prod_cliente = 4
      begin
        update cob_ahorros..ah_cuenta
        set    ah_nombre = @w_nombre
        where  ah_cliente = @w_ente

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA AH_CUENTA'
          goto ERRORFIN
        end

        /** SE REGISTRA LOG DEL CAMBIO DE NOMBRE **/
        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                     ts_fecha,
                     ts_usuario,ts_terminal,ts_ente,ts_oficina,
                     ts_nombre_completo,
                     ts_observacion,ts_fecha_modificacion,ts_toperacion,
                     ts_tclase)
        values      (@w_ssn,1,15257,'A',getdate(),
                     'consola','consola',@w_ente,1,@w_nombre,
                     'ACT_PRODUCTO_4',getdate(),'A','Actualizacion')

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje =
            'ERROR AL ACTUALIZAR TRN SERVICIO, TABLA cl_tran_servicio'
          goto ERRORFIN
        end

      end

      if @w_prod_cliente = 7
      begin
        update cob_cartera..ca_operacion
        set    op_nombre = @w_nombre
        where  op_cliente = @w_ente

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA AH_CUENTA'
          goto ERRORFIN
        end

        /** SE REGISTRA LOG DEL CAMBIO DE NOMBRE **/
        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                     ts_fecha,
                     ts_usuario,ts_terminal,ts_ente,ts_oficina,
                     ts_nombre_completo,
                     ts_observacion,ts_fecha_modificacion,ts_toperacion,
                     ts_tclase)
        values      (@w_ssn,2,15257,'A',getdate(),
                     'consola','consola',@w_ente,1,@w_nombre,
                     'ACT_PRODUCTO_7',getdate(),'A','Actualizacion')

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje =
            'ERROR AL ACTUALIZAR TRN SERVICIO, TABLA cl_tran_servicio'
          goto ERRORFIN
        end

        --actualizacion para polizas
        update cob_credito..cr_asegurados
        set    as_apellidos = @w_apellido_solo,
               as_nombres = @w_nombre_solo
        where  as_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_ASEGURADOS'
          goto ERRORFIN
        end

        update cob_credito..cr_aseg_microseguro
        set    am_nombre_comp = @w_nombre
        where  am_identificacion = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_ASEG_MICROSEGURO'
          goto ERRORFIN
        end

        update cob_credito..cr_beneficiarios
        set    be_apellidos = @w_apellido_solo,
               be_nombres = @w_nombre_solo
        where  be_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_BENEFICIARIOS'
          goto ERRORFIN
        end

        update cob_conta_super..sb_asegurados
        set    as_apellidos = @w_apellido_solo,
               as_nombres = @w_nombre_solo
        where  as_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA SB_ASEGURADOS'
          goto ERRORFIN
        end

        /** SE REGISTRA LOG DEL CAMBIO DE NOMBRE **/
        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                     ts_fecha,
                     ts_usuario,ts_terminal,ts_ente,ts_oficina,
                     ts_nombre_completo,
                     ts_observacion,ts_fecha_modificacion,ts_toperacion,
                     ts_tclase)
        values      (@w_ssn,3,15257,'A',getdate(),
                     'consola','consola',@w_ente,1,@w_nombre,
                     'ACT_PRODUCTO_21',getdate(),'A','Actualizacion')

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje =
            'ERROR AL ACTUALIZAR TRN SERVICIO, TABLA cl_tran_servicio'
          goto ERRORFIN
        end

      end

      if @w_prod_cliente = 14
      begin
        update cob_pfijo..pf_operacion
        set    op_descripcion = @w_nombre
        where  op_ente = @w_ente

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA AH_CUENTA'
          goto ERRORFIN
        end

        /** SE REGISTRA LOG DEL CAMBIO DE NOMBRE **/
        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                     ts_fecha,
                     ts_usuario,ts_terminal,ts_ente,ts_oficina,
                     ts_nombre_completo,
                     ts_observacion,ts_fecha_modificacion,ts_toperacion,
                     ts_tclase)
        values      (@w_ssn,3,15257,'A',getdate(),
                     'consola','consola',@w_ente,1,@w_nombre,
                     'ACT_PRODUCTO_14',getdate(),'A','Actualizacion')

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje =
            'ERROR AL ACTUALIZAR TRN SERVICIO, TABLA cl_tran_servicio'
          goto ERRORFIN
        end

      end

      if @w_prod_cliente = 21
      begin
        update cob_credito..cr_asegurados
        set    as_apellidos = @w_apellido_solo,
               as_nombres = @w_nombre_solo
        where  as_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_ASEGURADOS'
          goto ERRORFIN
        end

        update cob_credito..cr_aseg_microseguro
        set    am_nombre_comp = @w_nombre
        where  am_identificacion = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_ASEG_MICROSEGURO'
          goto ERRORFIN
        end

        update cob_credito..cr_beneficiarios
        set    be_apellidos = @w_apellido_solo,
               be_nombres = @w_nombre_solo
        where  be_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA CR_BENEFICIARIOS'
          goto ERRORFIN
        end

        update cob_conta_super..sb_asegurados
        set    as_apellidos = @w_apellido_solo,
               as_nombres = @w_nombre_solo
        where  as_ced_ruc = @w_cedula

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje = 'ERROR AL ACTUALIZAR NOMBRE, TABLA SB_ASEGURADOS'
          goto ERRORFIN
        end

        /** SE REGISTRA LOG DEL CAMBIO DE NOMBRE **/
        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                     ts_fecha,
                     ts_usuario,ts_terminal,ts_ente,ts_oficina,
                     ts_nombre_completo,
                     ts_observacion,ts_fecha_modificacion,ts_toperacion,
                     ts_tclase)
        values      (@w_ssn,3,15257,'A',getdate(),
                     'consola','consola',@w_ente,1,@w_nombre,
                     'ACT_PRODUCTO_21',getdate(),'A','Actualizacion')

        if @@error <> 0
        begin
          select
            @w_error = 1000086,
            @w_mensaje =
            'ERROR AL ACTUALIZAR TRN SERVICIO, TABLA cl_tran_servicio'
          goto ERRORFIN
        end

      end

      delete #productos
      where  dp_producto   = @w_prod_cliente
         and dp_cliente_ec = @w_ente

    end --while     

    set rowcount 1
    delete cl_clientes_act_ORS613
    where  ca_ente = @w_ente
  end
  set rowcount 0

  return 0

  ERRORFIN:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fechaproceso,
    @i_error       = @w_error,
    @i_usuario     = 'op_batch',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp

  return @w_error

go

