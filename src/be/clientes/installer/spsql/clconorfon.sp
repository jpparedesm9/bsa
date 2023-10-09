/************************************************************************/
/*  Archivo           :   clconorfon.sp                                 */
/*  Stored procedure  :   sp_con_orifondos                              */
/*  Base de datos     :   cobis                                         */
/*  Producto          :   Clientes                                      */
/*  Disenado por      :   Etna Laguna                                   */
/*  Fecha de escritura:   28/Mayo/2003                                  */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
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
/*  Este programa procesa las operaciones de Creacion, Busqueda,        */
/*  Actualizacion y eliminacion de los registros de origen de fondos    */
/*  realizados para un Cliente x cada producto.                         */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  28/May/03   E.Laguna    Emision Inicial                             */
/*  03/Jun/08   A.Correa    Mensaje de error apropiado                  */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_con_orifondos')
  drop proc sp_con_orifondos
go
create proc sp_con_orifondos
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_ente         int = null,
  @i_producto     varchar(24) = null,
  @i_formato_f    tinyint = 101
)
as
  declare
    @w_sp_name        varchar(32),
    @w_codigo         int,
    @w_return         int,
    @o_siguiente      tinyint,
    @w_secuencial     tinyint,
    @w_servicio       catalogo,
    @v_servicio       catalogo,
    @o_ente           int,
    @o_producto       char(3),
    @o_cuenta         varchar(24),
    @o_detalle        varchar(255),
    @o_fecha_registro datetime,
    @o_fecha_modifi   datetime,
    @o_funcionario    login,
    @o_dproducto      varchar(64)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_con_orifondos'

  /** Search **/
  if @i_operacion = 'S'
  begin
    if @t_trn = 1105
    begin
      select
        'PRODUCTO    ' = of_producto,
        'CUENTA/OPERACION' = of_numero,
        'DESCRIPCION ' = of_origen_fondos,
        'FECHA DE REGISTRO' = convert(char(10), of_fecha_registro, @i_formato_f)
        ,
        'FUNCIONARIO ' = of_funcionario
      from   cl_origen_fondos,
             cl_producto
      where  of_producto = pd_abreviatura
         and of_ente     = @i_ente
      order  by of_numero
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105511
      /*  'Error en Busqueda de Origen de Fondos' */
      return 1
    end
  end

/** Query **/
  /* Datos especificos de una contacto */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1106
    begin
      if @i_producto is null
      begin
        select
          @o_producto = of_producto,
          @o_cuenta = of_numero,
          @o_detalle = of_origen_fondos,
          @o_fecha_registro = of_fecha_registro,
          @o_funcionario = of_funcionario,
          @o_fecha_modifi = of_fecha_modificacion,
          @o_dproducto = pd_descripcion
        from   cl_origen_fondos,
               cl_producto
        where  of_producto = pd_abreviatura
           and of_ente     = @i_ente
      end
      else
      begin
        select
          @o_producto = of_producto,
          @o_cuenta = of_numero,
          @o_detalle = of_origen_fondos,
          @o_fecha_registro = of_fecha_registro,
          @o_funcionario = of_funcionario,
          @o_fecha_modifi = of_fecha_modificacion,
          @o_dproducto = pd_descripcion
        from   cl_origen_fondos,
               cl_producto
        where  of_producto = pd_abreviatura
           and of_ente     = @i_ente
           and of_numero   = @i_producto
      end

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105512
        /* 'Error en Consulta de Origen de Fondos'*/
        return 1
      end

      select
        @o_producto,
        @o_cuenta,
        @o_detalle,
        convert (char(10), @o_fecha_registro, @i_formato_f),
        @o_funcionario,
        convert (char(10), @o_fecha_modifi, @i_formato_f),
        @o_dproducto
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

go

