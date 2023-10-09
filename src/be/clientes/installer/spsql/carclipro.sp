/************************************************************************/
/*    Archivo            :     carclipro.sp                             */
/*    Stored procedure   :     sp_cliente_producto                      */
/*    Base de datos      :     cobis                                    */
/*    Producto           :     Clientes                                 */
/*    Disenado por       :     Santiago Alban                           */
/*    Fecha de escritura :     01/10/2008                               */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Este programa procesa las transacciones del stored procedure      */
/*      Insercion, Borrado, Modificacion de las caracterisiticas        */
/*    que cumplen para entregar obsequios por cliente                   */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*    01/10/2008   FSAP            EmisionInicial                       */
/*    May/02/2016  DFu             Migracion CEN                        */
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
           where  name = 'sp_cliente_producto')
  drop proc sp_cliente_producto
go

create proc sp_cliente_producto
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_cod_caract    smallint = 0,
  @i_tipo          char(1) = null,
  @i_descripcion   varchar(35) = null,
  @i_desde         float = null,
  @i_hasta         float = null,
  @i_fecha1        datetime = null,
  @i_fecha2        datetime = null,
  @i_operador      char(10) = null,
  @i_cadena        varchar(10) = null,
  @i_proceso       varchar(1) = null,
  @i_rutina        smallint = null,
  @i_modulo        varchar(20) = null,
  @i_tabla         varchar(25) = null,
  @i_campo         varchar(20) = null,
  @i_indice_n      varchar(15) = null,
  @i_modo          int = null,
  @i_bd_cliente    varchar(24) = null,
  @i_tabla_cliente varchar(24) = null,
  @i_campo_cliente varchar(24) = null,
  @o_siguiente     smallint = null out
)
as
  declare
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_cod_carct   smallint,
    @w_tipo        char(1),
    @e_descripcion varchar(35),
    @w_desde       float,
    @w_hasta       float,
    @w_fecha1      datetime,
    @w_fecha2      datetime,
    @w_operador    char(10),
    @w_cadena      varchar(10),
    @w_proceso     varchar(1),
    @w_rutina      smallint,
    @w_base_datos  varchar(20),
    @w_tabla       varchar(25),
    @w_campo       varchar(20),
    @w_siguiente   smallint,
    @w_ho_bd       varchar(20),
    @w_ho_tabla    varchar(20),
    @w_ho_campo    varchar(20),
    @w_ho_cliente  varchar(20)

  select
    @w_sp_name = 'sp_cliente_producto'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_siguiente = max(cc_cod_caract)
  from   cr_caract_cli_prod

  if @w_siguiente is null
  begin
    select
      @w_siguiente = 0
  end

  select
    @w_siguiente = @w_siguiente + 1
  select
    @o_siguiente = @w_siguiente

  if @i_operacion in ('I', 'U')
  begin
    /* verificar los datos de clientes en modulos, campos y tablas*/
    select
      @w_ho_bd = ho_bd
    from   cl_hom_obsequios
    where  ho_bd_cliente = @i_modulo

    select
      @w_ho_tabla = ho_tabla
    from   cl_hom_obsequios
    where  ho_tabla_cliente = @i_tabla

    select
      @w_ho_campo = ho_campo
    from   cl_hom_obsequios
    where  ho_campo_cliente = @i_campo

    select
      @w_ho_cliente = ho_cliente
    from   cl_hom_obsequios
    where  ho_bd_cliente    = @i_modulo
       and ho_tabla_cliente = @i_tabla
       and ho_campo_cliente = @i_campo

  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1010 --salban
    --   if @t_trn = 1193
    begin
      begin tran

      /* insertar los datos */
      insert into cr_caract_cli_prod
                  (cc_cod_caract,cc_tipo,cc_descripcion,cc_desde,cc_hasta,
                   cc_fecha1,cc_fecha2,cc_operador,cc_cadena,cc_proceso,
                   cc_rutina,cc_base_datos,cc_tabla,cc_campo,cc_indice_n)
      values      (@w_siguiente,@i_tipo,@i_descripcion,@i_desde,@i_hasta,
                   @i_fecha1,@i_fecha2,@i_operador,@i_cadena,@i_proceso,
                   @i_rutina,@w_ho_bd,@w_ho_tabla,@w_ho_campo,@w_ho_cliente )

      /* si no se puede insertar, error */
      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103084
        /* 'Error en creacion de otros ingresos'*/
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
    --   if @t_trn = 1193
    if @t_trn = 1010 -- salban
    begin
      begin tran
      /* modificar los datos */
      update cr_caract_cli_prod
      set    cc_tipo = @i_tipo,
             cc_descripcion = @i_descripcion,
             cc_desde = @i_desde,
             cc_hasta = @i_hasta,
             cc_fecha1 = @i_fecha1,
             cc_fecha2 = @i_fecha2,
             cc_operador = @i_operador,
             cc_cadena = @i_cadena,
             cc_proceso = @i_proceso,
             cc_rutina = @i_rutina,
             cc_base_datos = @w_ho_bd,
             cc_tabla = @w_ho_tabla,
             cc_campo = @w_ho_campo,
             cc_indice_n = @w_ho_cliente
      from   cr_caract_cli_prod
      where  cc_cod_caract = @i_cod_caract

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
    if @t_trn = 1010 --salban
    --   if @t_trn = 1193
    begin
      delete cr_caract_cli_prod
      where  cc_cod_caract = @i_cod_caract
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
  end
  /** Search **/
  if @i_operacion = 'S'
  begin
    --   if @t_trn = 1194
    if @t_trn = 1011 --salban
    begin
      if @i_modo = 0
      begin
        select
          'Cod C' = cc_cod_caract,
          'Tipo' = cc_tipo,
          'Descripcion Caracteristica' = cc_descripcion,
          'Valor Inicial' = cc_desde,
          'Valor Final' = cc_hasta,
          'Fecha Desde' = convert(varchar(10), cc_fecha1, 101),
          'Fecha Hasta' = convert(varchar(10), cc_fecha2, 101),
          'Operador   ' = cc_operador,
          'Cadena' = cc_cadena,
          'Proceso' = cc_proceso,
          'Rutina' = cc_rutina,
          'Base de Datos' = (select
                               ho_bd_cliente
                             from   cl_hom_obsequios b
                             where  a.cc_base_datos = b.ho_bd
                                and a.cc_tabla      = b.ho_tabla
                                and a.cc_campo      = b.ho_campo),
          'Tabla' = (select
                       ho_tabla_cliente
                     from   cl_hom_obsequios b
                     where  a.cc_tabla = b.ho_tabla
                        and a.cc_campo = b.ho_campo),
          'Campo' = (select
                       ho_campo_cliente
                     from   cl_hom_obsequios b
                     where  a.cc_campo = b.ho_campo)
        --,                 'Indice'                = cc_indice_n       
        from   cr_caract_cli_prod a
        order  by cc_cod_caract
      end

      --busca combo hmologaciones Modulos
      if @i_modo = 1
      begin
        select distinct
          'bd' = ho_bd,
          'bd_cliente' = ho_bd_cliente
        from   cl_hom_obsequios
        where  ho_bd_cliente = isnull(@i_bd_cliente,
                                      ho_bd_cliente)
           and ho_tabla      = isnull(@i_tabla,
                                      ho_tabla)
           and ho_campo      = isnull(@i_campo,
                                      ho_campo)

      end

      --busca combo hmologaciones Tablas
      if @i_modo = 2
      begin
        select distinct
          'tabla' = ho_tabla,
          'tabla_clie' = ho_tabla_cliente
        from   cl_hom_obsequios
        where  ho_bd_cliente    = isnull(@i_bd_cliente,
                                         ho_bd_cliente)
           and ho_tabla_cliente = isnull(@i_tabla_cliente,
                                         ho_tabla_cliente)

      end
      --busca combo hmologaciones Campos
      if @i_modo = 3
      begin
        select distinct
          'tabla' = ho_campo,
          'tabla_clie' = ho_campo_cliente
        from   cl_hom_obsequios
        where  ho_bd_cliente    = isnull (@i_bd_cliente,
                                          ho_bd_cliente)
           and ho_tabla_cliente = isnull(@i_tabla_cliente,
                                         ho_tabla_cliente)
           and ho_campo_cliente = isnull(@i_campo_cliente,
                                         ho_campo_cliente)
      end
      --busca combo hmologaciones
      if @i_modo = 4
      begin
        select
          'bd' = ho_bd,
          'bd_cliente' = ho_bd_cliente,
          'tabla' = ho_tabla,
          'tabla_clie' = ho_tabla_cliente,
          'campo' = ho_campo,
          'camp clie' = ho_campo_cliente,
          'indice' = ho_cliente
        from   cl_hom_obsequios
        where  ho_bd_cliente = @i_bd_cliente
           and ho_tabla      = @i_tabla
           and ho_campo      = @i_campo
      end

    end --fin trans
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 1887605
      /*  No existen datos de variables */
      return 1
    end
  end

  return 0

go

