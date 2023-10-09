/************************************************************************/
/*  Archivo:            cargofun.sp                                     */
/*  Stored procedure:   sp_cargo_funcionario                            */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 10-Nov-1993                                     */
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
/*  Este programa procesa la consulta por ALL y VALUE de los            */
/*  funcionarios cuyos cargos sean:                                     */
/*  - Oficial de Cuenta                                                 */
/*  - Oficial de Credito                                                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR       RAZON                                   */
/*  10/Nov/93       P  Mena     Emision Inicial.                        */
/*  May/02/2016     DFu         Migracion CEN                           */
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
           where  name = 'sp_cargo_funcionario')
  drop proc sp_cargo_funcionario
go

create proc sp_cargo_funcionario
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = null,
  @i_funcionario  smallint = null,
  @i_cargo        varchar(4)
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(32),
    @w_cod     varchar(3),
    @w_patron  descripcion

  select
    @w_sp_name = 'sp_cargo_funcionario'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Help ** */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1167
    begin
      /* Help para funcionario cuyo rol sea oficial de cuenta y de credito */
      if @i_cargo = 'OFCU'
        select
          @w_patron = 'OFICIAL%CUENTA'
      else if @i_cargo = 'OFCR'
        select
          @w_patron = 'OFICIAL%CREDITO'

      select
        @w_cod = codigo
      from   cobis..cl_catalogo
      where  tabla = (select
                        cobis..cl_tabla.codigo
                      from   cobis..cl_tabla
                      where  tabla = 'cl_cargo')
         and valor like @w_patron

      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
        begin
          select
            'Cod.' = fu_funcionario,
            'Funcionario' = fu_nombre
          from   cl_funcionario
          where  fu_funcionario > 0
             and fu_cargo       = convert(tinyint, @w_cod)
          order  by fu_funcionario
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101036
          /* 'No existe funcionario'*/
          end
        end
        if @i_modo = 1
        begin
          select
            'Cod.' = fu_funcionario,
            'Funcionario' = fu_nombre
          from   cl_funcionario
          where  fu_funcionario > @i_funcionario
             and fu_cargo       = convert(tinyint, @w_cod)
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101036
          /*    No existe funcionario */
          end
          set rowcount 0
        end
      end
      if @i_tipo = 'V'
      begin
        select
          fu_nombre
        from   cl_funcionario
        where  fu_funcionario = @i_funcionario
           and fu_cargo       = convert(tinyint, @w_cod)
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101036
        /*  'No existe funcionario'*/
        end
      end
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

