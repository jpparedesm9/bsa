/************************************************************************/
/*  Archivo:            sp_catalogo_tbl.sp                              */
/*  Stored procedure:   sp_catalogo_tbl                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR          RAZON                                    */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_catalogo_tbl')
           drop proc sp_catalogo_tbl
go

create proc sp_catalogo_tbl
(
  @t_show_version bit = 0,
  @i_server       varchar(10),
  @i_oficina      smallint
)
as
  declare @w_sp_name    varchar(30)

  select
    @w_sp_name = 'sp_catalogo_tbl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    tabla=cl_tabla.codigo,
    nombre=rtrim(cl_tabla.tabla),
    valor_default=rtrim(cl_default.codigo),
    cl_default.srv
  from   cl_tabla
         left outer join cl_default
                      on cl_tabla.codigo = cl_default.tabla
                         and cl_default.srv = @i_server
                         and cl_default.oficina = @i_oficina
  order  by convert(varchar(5), cl_tabla.codigo)

  return 0

go

