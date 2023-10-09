/************************************************************************/
/*  Archivo         :   seclient.sp                                     */
/*  Stored procedure:   sp_se_cliente                                   */
/*  Base de datos   :   cobis                                           */
/*  Producto        :   Clientes                                        */
/*  Disenado por    :   Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 06-Nov-1992                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*      de servicios contratados por un cliente                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  06/Nov/92   M. Davila     Emision Inicial                           */
/*  15/Ene/93   L. Carvajal   Tabla de errores, variables de debug      */
/*  30/Nov/93   R. Minga V.   Verificacion y validacion                 */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_se_cliente')
           drop proc sp_se_cliente
go

create proc sp_se_cliente
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
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_ente         int = null,
  @i_det_producto int = null,
  @i_form_fecha   int = '101'
)
as
  declare @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_se_cliente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1195
  begin
    set rowcount 20
    if @i_modo = 0
      select
        'Filial' = fi_abreviatura,
        'Oficina' = substring(of_nombre,
                              1,
                              15),
        'Producto' = pd_abreviatura,
        'Moneda' = substring(mo_descripcion,
                             1,
                             10),
        'Servicio' = cl_det_producto,
        'Cuenta' = dp_cuenta,
        'Rol' = cl_rol,
        'Fecha' = convert(char(10), cl_fecha, @i_form_fecha)
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente      = @i_ente
         and dp_det_producto = cl_det_producto
         and fi_filial       = dp_filial
         and of_oficina      = dp_oficina
         and pd_producto     = dp_producto
         and mo_moneda       = dp_moneda
    if @i_modo = 1
      select
        'Filial' = fi_abreviatura + '  ',
        'Oficina' = substring(of_nombre,
                              1,
                              15),
        'Producto' = pd_abreviatura + '     ',
        'Moneda' = substring(mo_descripcion,
                             1,
                             10),
        'Servicio' = cl_det_producto,
        'Cuenta' = dp_cuenta,
        'Rol' = cl_rol,
        'Fecha' = convert(char(10), cl_fecha, @i_form_fecha)
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente      = @i_ente
         and cl_det_producto > @i_det_producto
         and dp_det_producto = cl_det_producto
         and fi_filial       = dp_filial
         and of_oficina      = dp_oficina
         and pd_producto     = dp_producto
         and mo_moneda       = dp_moneda
    set rowcount 0
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
  return 0

go

