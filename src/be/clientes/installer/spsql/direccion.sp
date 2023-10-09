/************************************************************************/
/*  Archivo:                direccion.sp                                */
/*  Stored procedure:       sp_direccion                                */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Nidia Nieto                                 */
/*  Fecha de escritura:     21-Abr-2008                                 */
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
/*                               PROPOSITO                              */
/*      Consulta de direcciones para un depto y una ciudad dados        */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA       AUTOR              RAZON                            */
/*  04/May/2016     T. Baidal     Migracion a CEN                       */
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
           where  name = 'sp_direccion')
           drop proc sp_direccion
go

create proc sp_direccion
(
  @s_ssn           int,
  @s_user          varchar(14) = null,
  @s_term          varchar(30) = null,
  @s_date          datetime,
  @s_srv           varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_modo          smallint = null,
  @i_operacion     char(1),
  @i_provincia     smallint = null,
  @i_ciudad        int = null,
  @i_direccion     varchar(40) = null,
  @i_tipo          varchar(3) = null,
  @i_valor         varchar(64) = null
)
as
  declare
    @w_transaccion int,
    @w_sp_name     varchar(32),
    @w_codigo      int,
    @w_error       int,
    @w_return      int

  select
    @w_sp_name = 'sp_direccion'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Query **/

  if @t_trn = 1192
  begin
    if @i_operacion = 'Q'
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'NOMBRE' = substring(en_nomlar,
                               1,
                               50),
          'IDENTIFICACION' = substring(en_ced_ruc,
                                       1,
                                       15),
          'DIRECCION' = substring(di_descripcion,
                                  1,
                                  30),
          'TIPO' = substring(x.valor,
                             1,
                             15),
          'AREA DIR.' = di_rural_urb
        from   cl_ente,
               cl_direccion,
               cl_catalogo x,
               cl_tabla y
        where  di_descripcion like @i_valor
           and en_ente      = di_ente
           and di_provincia = @i_provincia
           and di_ciudad    = @i_ciudad
           and y.tabla      = 'cl_tdireccion'
           and x.tabla      = y.codigo
           and di_tipo      = x.codigo
           and (di_tipo      = @i_tipo
                 or @i_tipo is null)
        order  by di_descripcion

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          set rowcount 0
          return 1
        end
        set rowcount 0
      end
      if @i_modo = 1
      begin
        select
          'NOMBRE' = substring(en_nomlar,
                               1,
                               50),
          'IDENTIFICACION' = substring(en_ced_ruc,
                                       1,
                                       15),
          'DIRECCION' = substring(di_descripcion,
                                  1,
                                  30),
          'TIPO' = substring(x.valor,
                             1,
                             15),
          'AREA DIR.' = di_rural_urb
        from   cl_ente,
               cl_direccion,
               cl_catalogo x,
               cl_tabla y
        where  substring(di_descripcion,
                         1,
                         40) > @i_direccion
           and di_descripcion like @i_valor
           and en_ente                        = di_ente
           and di_provincia                   = @i_provincia
           and di_ciudad                      = @i_ciudad
           and y.tabla                        = 'cl_tdireccion'
           and x.tabla                        = y.codigo
           and di_tipo                        = x.codigo
           and (di_tipo                        = @i_tipo
                 or @i_tipo is null)
        order  by di_descripcion

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          set rowcount 0
          return 1
        end
        set rowcount 0
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
  return 0

go

