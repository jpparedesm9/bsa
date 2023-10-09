/************************************************************************/
/*      Archivo                 :       oingreso.sp                     */
/*      Stored procedure        :       sp_otros_ingresos               */
/*      Base de datos           :       cobis                           */
/*      Producto                :       Clientes                        */
/*      Disenado por            :       Santiago Alban                  */
/*      Fecha de escritura      :       05-Oct-2008                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones del stored procedure    */
/*      Insercion, Borrado, Modificacion de valores de otros ingresos   */
/*      reportados por un ente, Query de ingreso generico y especifico  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  05/10/2008  FSAP           req. otros ingresos                        */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_otros_ingresos')
    drop proc sp_otros_ingresos
go

create proc sp_otros_ingresos
(
  @s_ssn                int = null,
  @s_user               login = null,
  @s_term               varchar(30) = null,
  @s_date               datetime = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @s_rol                smallint = null,
  @s_org_err            char(1) = null,
  @s_error              int = null,
  @s_sev                tinyint = null,
  @s_msg                descripcion = null,
  @s_org                char(1) = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char(1),
  @i_ente               int = null,
  @i_ingreso            money = null,
  @i_descripcion        varchar(64) = null,
  @i_otros_ingresos     money = null,
  @i_des_otros_ingresos varchar(64) = null,
  @i_des_seguro         varchar(64) = null,
  @i_compania           descripcion = null,
  @i_poliza             varchar(14) = null,
  @i_tipo               char(1) = null,
  @i_moneda             tinyint = null,
  @i_formato_fecha      int = null,
  @i_estado             char(1) = null,
  @i_estado_ant         char(1) = null,
  @i_des_anterior       varchar(64) = null,
  @i_moneda_ant         tinyint = null,
  @i_ingreso_ant        money = null,
  @i_cod_desc           char(3) = null --FSAP 29/09/2008

)
as
  declare
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_codigo             int,
    @w_empresa            int,
    @w_ingreso            money,
    @w_otros_ingresos     money,
    @w_des_otros_ingresos varchar(64),
    @w_cod_desc           char(3),--FSAP 29/09/2008
    --      @w_des_seguro           catalogo,
    @w_des_seguro         varchar(64),
    @w_fecha_ingreso      datetime,
    @w_fecha              datetime,
    @w_fecha_modifi       datetime,
    @w_compania           char(36),
    @w_poliza             char(14),
    @w_estado             char(1),
    @w_estado_ant         char(1),
    @v_empresa            int,
    @v_cargo              descripcion,
    @v_ingreso            money,
    @v_des_otros_ingresos varchar(64),
    @v_fecha_ingreso      datetime,
    @v_fecha_modifi       datetime,
    @v_compania           char(36),
    @v_poliza             char(14),
    @v_estado             char(1),
    @v_estado_ant         char(1),
    @o_ente               int,
    @o_trabajo            tinyint,
    @o_compania           varchar(36),
    @o_poliza             varchar(14),
    @o_ingreso            money,
    @o_des_otros_ingresos varchar(64),
    @o_des_seguro         varchar(64),
    @o_fecha_ingreso      datetime,
    @o_moneda             tinyint,
    @o_estado             char(1),
    @o_fecha_modifi       datetime,
    @o_funcionario        login,
    @o_cod_desc           char(3) --FSAP

  select
    @w_sp_name = 'sp_otros_ingresos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = getdate()

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1319
    begin
      begin tran

      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_persona
      where  persona = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* 'No existe persona'*/
        return 1
      end

      /*FSAP --control de existencia de codigo descripcion*/
      if exists (select
                   1
                 from   cobis..cl_otros_ingresos
                 where  oi_ente            = @i_ente
                    and oi_cod_descripcion = @i_cod_desc
                    and oi_estado          = 'V')
      begin
        print
'YA EXISTE CODIGO DE OTROS INGRESOS PARA EL CLIENTE. INGRESO SOLAMENTE UNO POR TIPO DE INGRESO'
  return 1
end

  /* insertar los datos de Otros Ingresos*/

  insert into cl_otros_ingresos
              (oi_ente,oi_tipo,oi_valor,oi_descripcion,oi_compania,
               oi_num_poliza,oi_moneda,oi_usuario,oi_fecha_ingreso,
               oi_fecha_modifi
               ,
               oi_estado,oi_cod_descripcion) --FSAP
  values      (@i_ente,@i_tipo,@i_ingreso,@i_descripcion,@i_compania,
               @i_poliza,@i_moneda,@s_user,@w_fecha,@w_fecha,
               @i_estado,@i_cod_desc)

  /* si no se puede insertar, error */
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 103084
    /* 'Error en creacion de otros ingresos'*/
    return 1
  end

  /*  Transaccion de Servicio  */
  insert into ts_otros_ingresos
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ente,tipo,
               valor,descripcion,compania,num_poliza,moneda,
               usuario2,fecha_ingreso,fecha_modifi,estado,cdescr)
  values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
               @s_term,@s_srv,@s_lsrv,@i_ente,@i_tipo,
               @i_ingreso,@i_descripcion,@i_compania,@i_poliza,@i_moneda,
               @s_user,@w_fecha,@w_fecha,@i_estado,@i_cod_desc)

  if @@error <> 0
  begin
    /*  Error en creacion de transaccion de servicio  */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 103005
    return 1
  end
  commit tran
end
else
begin
  exec sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151051
  /*  'No corresponde codigo de transaccion' */
  return 1
end
end

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1320
    begin
      /*FSAP --control de existencia de codigo descripcion*/
      if exists (select
                   1
                 from   cobis..cl_otros_ingresos
                 where  oi_ente            = @i_ente
                    and oi_cod_descripcion = @i_cod_desc
                    and oi_estado          = 'V')
         and @i_estado = 'V'
      begin
        print
'YA EXISTE CODIGO DE OTROS INGRESOS PARA EL CLIENTE. INGRESO SOLAMENTE UNO POR TIPO DE INGRESO'
  return 1
end

  begin tran
  /* modificar los datos */
  update cl_otros_ingresos
  set    oi_valor = @i_ingreso,
         oi_tipo = @i_tipo,
         oi_descripcion = @i_descripcion,
         oi_moneda = @i_moneda,
         oi_usuario = @s_user,
         oi_fecha_modifi = @w_fecha,
         oi_estado = @i_estado,
         oi_cod_descripcion = @i_cod_desc --FSAP
  where  oi_ente        = @i_ente
     and oi_estado      = @i_estado_ant
     and oi_moneda      = @i_moneda_ant
     and oi_descripcion = @i_des_anterior

  /* si no se puede modificar, error */
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105075
    /* 'Error en actualizacion de empleo'*/
    return 1
  end

  commit tran
  return 0

end
else
begin
  exec sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151051
  /*  'No corresponde codigo de transaccion' */
  return 1
end

end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    delete cl_otros_ingresos
    where  oi_ente            = @i_ente
       and oi_cod_descripcion = @i_cod_desc
       and oi_valor           = @i_ingreso

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 101191,
        @i_msg  = 'Error al eliminar registro de otros ingresos'
      /* 'Error al eliminar otros ingresos'*/
      return 101191
    end

  end
/** Search **/
  /*Consulta de Otros Ingresos de un ente*/
  if @i_operacion = 'S'
  begin
    if @t_trn = 1321
    begin
      select
        'Codigo Cliente' = oi_ente,
        'Codigo Descripcion' = oi_cod_descripcion,
        'Valor del Ingreso' = oi_valor,
        'Descripcion del Ingreso'= oi_descripcion,
        'Moneda' = oi_moneda,
        'Estado' = oi_estado,
        'Fecha Registro' = convert(char(10), oi_fecha_ingreso, 101),
        'Fecha Revision' = convert(char(10), oi_fecha_modifi, 101)
      from   cl_otros_ingresos
      where  oi_ente = @i_ente
      order  by oi_cod_descripcion

      select
        'suma' = sum(oi_valor)
      from   cl_otros_ingresos
      where  oi_ente   = @i_ente
         and oi_estado = 'V'

      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101191
      /* 'No existe dato solicitado'*/
      return 1
    end
  end
  return 0

go

