/************************************************************************/
/*  Archivo:            cas_imp.sp                                      */
/*  Stored procedure:   sp_impresion_casillas                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Jaime Loyo                                      */
/*  Fecha de escritura: 08-Jul-1998                                     */
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
/*  Permite llevar los datos para imprimir las casillas postales        */
/*  de un cliente                                                       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR       RAZON                                   */
/*  08-Jul-1998     J. Loyo     Emision inicial                         */
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
           where  name = 'sp_impresion_casillas')
  drop proc sp_impresion_casillas
go

create proc sp_impresion_casillas
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_ente         int
)
as
  declare @w_sp_name varchar (30)

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_impresion_casillas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1373
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @t_from,
      @i_num   = 101147
    return 1
  end

  /*   Extrae Apartados Postales de un ente  */

  select
    cs_casilla,
    cs_valor,
    cs_tipo,
    cs_ciudad,
    cs_provincia,
    pv_descripcion,
    ci_descripcion,
    convert(char(10), cs_fecha_registro, 101),
    convert(char(10), cs_fecha_modificacion, 101),
    cs_verificado
  from   cl_casilla
         left outer join cl_ciudad
                      on cs_ciudad = ci_ciudad
         left outer join cl_provincia
                      on cs_provincia = pv_provincia
  where  cs_ente = @i_ente
  --   and   ci_ciudad    = * cs_ciudad
  --   and   pv_provincia = * cs_provincia

  select
    cs_casilla,
    cs_valor,
    cs_tipo,
    cs_provincia,
    cs_sucursal,
    pv_descripcion,
    sc_descripcion
  from   cl_casilla,
         cl_suc_correo,
         cl_provincia
  where  cs_ente      = @i_ente
     and cs_provincia = pv_provincia
     and cs_provincia = sc_provincia
     and cs_sucursal  = sc_sucursal
  order  by cs_casilla

go

