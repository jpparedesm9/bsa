/************************************************************************/
/*   Stored procedure:     sp_in_cliente                                */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                                  IMPORTANTE                          */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR               RAZON                               */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/* **********************************************************************/

use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_in_cliente')
  drop proc sp_in_cliente
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_in_cliente
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_cli          int,
  @i_dprod        int,
  @i_rol          char(1),
  @i_cedruc       varchar(35),
  @i_fecha        datetime,
  @i_validar      char(1) = 'S'
)
as
  declare
    @w_return       int,
    @w_sp_name      varchar(30),
    @w_ctacte       int,
    @w_cta_banco    varchar(20),
    @w_cliente      int,
    @w_det_producto int,
    @w_rol          char(1),
    @w_fecha        datetime

  /* Captura del nombre del Store Procedure */

  select
    @w_sp_name = 'sp_in_cliente'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file

    select
      '/** Store Procedure **/ ' = @w_sp_name,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_cli = @i_cli,
      i_dprod = @i_dprod,
      i_rol = @i_rol,
      i_cedruc = @i_cedruc,
      i_fecha = @i_fecha

    exec cobis..sp_end_debug

  end

/* Chequeo de existencias */
  -- El parametro @i_validar se aniade porque se  pueden crear cuentas

  -- a companias sin rif    MSA

  if @i_validar = 'N'
  begin
    select
      @w_cliente = en_ente
    from   cobis..cl_ente
    where  en_ente = @i_cli

    if @@rowcount = 0
    begin
      /* No existe ente */

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101042

      return 101042

    end

  end

  else if @i_validar = 'S'
  begin
    select
      @w_cliente = en_ente
    from   cobis..cl_ente
    where  en_ente    = @i_cli
       and en_ced_ruc = @i_cedruc

    if @@rowcount = 0
    begin
      select
        @w_cliente = en_ente
      from   cobis..cl_ente
      where  en_ente     = @i_cli
         and p_pasaporte = @i_cedruc

      if @@rowcount = 0
      begin
        /* No existe ente */

        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042

        return 101042

      end

    end

  end

  /* Insercion en la tabla cl_cliente */

  begin tran

  insert into cobis..cl_cliente
              (cl_cliente,cl_det_producto,cl_rol,cl_ced_ruc,cl_fecha)
  values      (@i_cli,@i_dprod,@i_rol,@i_cedruc,@i_fecha)

  if @@error <> 0
  begin
    /* Error en creacion de registro en cl_cliente */

    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 103001

    return 103001

  end

  commit tran

  return 0

go

