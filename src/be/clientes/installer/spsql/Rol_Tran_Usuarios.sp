/************************************************************************/
/*      Stored procedure:       sp_rol_tran_usuarios                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Andres Muñoz                            */
/*      Fecha de escritura:     07-Diciembre-2012                       */
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
/*      Extraer datos de los roles autorizados para cada usuario y      */
/*      las transacciones asociadas a cada rol.                         */
/*                              MODIFICACIONES                          */
/************************************************************************/
/*    FECHA            AUTOR               RAZON                        */
/*  07/12/2012     A. Muñoz        Emision inicial                      */
/*  05/May/2016    T. Baidal       Migracion a CEN                      */
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
           where  name = 'sp_rol_tran_usuarios')
           drop proc sp_rol_tran_usuarios
go

create proc sp_rol_tran_usuarios
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name      varchar(30),
    @w_s_app        varchar(255),
    @w_path         varchar(255),
    @w_nombre       varchar(255),
    @w_destino      varchar(2500),
    @w_errores      varchar(1500),
    @w_error        int,
    @w_comando      varchar(3500),
    @w_nombre_plano varchar(2500),
    @w_msg          varchar(255),
    @w_col_id       int,
    @w_columna      varchar(100),
    @w_cabecera     varchar(2500),
    @w_nom_tabla    varchar(100)

  select
    @w_sp_name = 'sp_rol_tran_usuarios'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*** INSERTA LOS DATOS DE LOS ROLES ASOCIADOS A CADA USUARIO ***/
  select
    'USUARIO' = fu_login,
    'NOMBRE_EMPLEADO' = fu_nombre,
    'CEDULA' = fu_nomina,
    'ROL' = ur_rol,
    'ESTADO_LOGIN' = us_estado,
    'ESTADO_FUN' = fu_estado,
    'NOMBRE_ROL' = ro_descripcion
  into   ORS_521_Usuario_Rol
  from   cl_funcionario with (nolock),
         ad_usuario_rol with (nolock),
         ad_rol with (nolock),
         ad_usuario with (nolock)
  where  fu_login = ur_login
     and fu_login = us_login
     and ur_rol   = ro_rol
  order  by fu_login

  if @@error <> 0
  begin
    select
      @w_error = 2805004,
      @w_msg = 'Error en insercion ORS_521_Usuario_Rol'
    goto ERRORFIN
  end

  /*** INSERTA LOS DATOS DE LOS TRANSACCIONES ASOCIADOS A CADA ROL ***/
  select
    'COD_ROL' = ro_rol,
    'DESC_ROL' = ro_descripcion,
    'PRODUCTO' = ta_producto,
    'COD_TRANSACCION' = ta_transaccion,
    'DESC_TRANSACCION' = tn_descripcion
  into   ORS_521_Rol_Transaccion
  from   ad_rol with (nolock),
         cl_ttransaccion with(nolock),
         ad_tr_autorizada with(nolock)
  where  ta_transaccion = tn_trn_code
     and ro_rol         = ta_rol

  if @@error <> 0
  begin
    select
      @w_error = 2805004,
      @w_msg = 'Error en insercion ORS_521_Rol_Transaccion'
    goto ERRORFIN
  end

  /*** GENERAR BCP ***/

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2
  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_nombre = 'USUARIOS_VS_ROL',
    @w_nom_tabla = 'ORS_521_Usuario_Rol',
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), '')

  select
    @w_nombre_plano =
       @w_path + @w_nombre + '_' + convert(varchar(2), datepart(dd,
       getdate())) + '_'
                      + convert(varchar(2), datepart(mm, getdate())) + '_'
                      + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cobis..sysobjects o,
           cobis..syscolumns c
    where  o.id    = c.id
       and o.name  = @w_nom_tabla
       and c.colid > @w_col_id
    order  by c.colid

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    select
      @w_cabecera = @w_cabecera + @w_columna + '^|'
  end

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  --Ejecucion para Generar Archivo Datos
  select
    @w_comando =
    @w_s_app + 's_app bcp -auto -login cobis..ORS_521_Usuario_Rol out '

  select
    @w_destino = @w_path + 'USUARIOS_VS_ROL.txt',
    @w_errores = @w_path + 'USUARIOS_VS_ROL.err'

  select
       @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                    ' -t"|" '
                    + '-config '
                    + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo USUARIOS_VS_ROL'
  end

  ----------------------------------------
  --Union de archivos (cab) y (dat)
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'USUARIOS_VS_ROL.txt'
                        + ' ' +
                        @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end
  else
    drop table cobis..ORS_521_Usuario_Rol

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_nombre = 'TRANSACCIONES_VS_ROL',
    @w_nom_tabla = 'ORS_521_Rol_Transaccion',
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), '')

  select
    @w_nombre_plano =
       @w_path + @w_nombre + '_' + convert(varchar(2), datepart(dd,
       getdate())) + '_'
                      + convert(varchar(2), datepart(mm, getdate())) + '_'
                      + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cobis..sysobjects o,
           cobis..syscolumns c
    where  o.id    = c.id
       and o.name  = @w_nom_tabla
       and c.colid > @w_col_id
    order  by c.colid

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    select
      @w_cabecera = @w_cabecera + @w_columna + '^|'
  end

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  --Ejecucion para Generar Archivo Datos
  select
    @w_comando =
           @w_s_app +
           's_app bcp -auto -login cobis..ORS_521_Rol_Transaccion out '

  select
    @w_destino = @w_path + 'TRANSACCIONES_VS_ROL.txt',
    @w_errores = @w_path + 'TRANSACCIONES_VS_ROL.err'

  select
       @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                    ' -t"|" ' + '-config '
                    + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo TRANSACCIONES_VS_ROL'
  end

  ----------------------------------------
  --Union de archivos (cab) y (dat)
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                        'TRANSACCIONES_VS_ROL.txt' + ' ' +
                        @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end
  else
    drop table cobis..ORS_521_Rol_Transaccion

  return 0

  ERRORFIN:
  print @w_msg

go

