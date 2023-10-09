/************************************************************************/
/*    Archivo:                cl_err_masivos.sp                         */
/*    Stored Procedure:       sp_err_masivos                            */
/*    Base de datos:          cobis                                     */
/*    Disenado por:           Jose Julian Cortes                        */
/*    Fecha de escritura:     15/04/2013                                */
/*    Producto:               Clientes                                  */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                            PROPOSITO                                 */
/*   Generar reporte de procesos masivos para los errores encontrados   */
/*   en la creacion de Clientes, Tramites y Desembolsos                 */
/*                                                                      */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA                    AUTOR               RAZON                */
/*  15/04/2013                 Jose Cortes       Emision Inicial        */
/*  02/05/2016                 DFu               Migracion CEN          */
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
           where  name = 'sp_err_masivos')
  drop proc sp_err_masivos
go

create proc sp_err_masivos
(
  @i_param1       varchar(255),-- Fecha del Proceso
  @i_param2       char(1) = null,-- Tipo de proceso   : T Todos,  A Ahorros 
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name        varchar(32),/* NOMBRE STORED PROC*/
    @w_msg            varchar(124),
    @w_error          int,
    @w_fecha_proceso  datetime,
    @w_fecha_pro_txt  varchar(10),
    @w_fecha_arch     varchar(10),
    @w_hora_arch      varchar(4),
    @w_sp_name_batch  varchar(40),
    @w_s_app          varchar(30),
    @w_path           varchar(255),
    @w_cmd            varchar(255),
    @w_comando        varchar(1000),
    @w_nombre_archivo varchar(255),
    @w_tipo_proceso   char(1)

  select
    @w_sp_name = 'sp_err_masivos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = @i_param1

  if @i_param2 = 'A'
    select
      @w_tipo_proceso = @i_param2
  else
    select
      @w_tipo_proceso = null -- 

  if not object_id('errores_alianza_tmp') is null
    drop table errores_alianza_tmp

  create table errores_alianza_tmp
  (
    ea_registro varchar(500) null
  )

  /* INSERTA DATOS PARA LA GENERACION DEL REPORTE */
  insert into errores_alianza_tmp
  values      (
'Fecha Proceso|Id Carga|Id Alianza|Referencia|Tipo Proceso|Procedimiento|Cod Interno|Cod Error|Descripcion                                  |'
  )

  if @w_tipo_proceso is null
  begin
    insert into errores_alianza_tmp
      select
        convert(varchar(40), me_fecha, 103) + ' '
        + substring( convert( varchar(40), me_fecha, 113), charindex( ':',
        convert
        (
        varchar(40), me_fecha, 113))-2, 8)
        + '|' + isnull(convert(varchar, me_id_carga), '') + '|' + case
        me_id_alianza
        when 0 then '' else isnull(convert(varchar, me_id_alianza), '') end +
        '|'
        +
        case
        me_referencia when 'C' then 'CUPO' when 'U' then 'UNIFIC / UTILIZ' when
        'T'
        then
        'UNIFIC / UTILIZ' when 'O' then 'ORIGINAL' when 'R' then 'RENOVACION'
        when
        'Tipo Tramite: C' then 'UTILIZACION' else isnull(me_referencia, '') end
        +
        '|'
        +
        case me_tipo_proceso when 'T' then 'TRAMITES' when 'C' then 'CLIENTES'
        else
        isnull(me_referencia, '') end + '|'
        + isnull(me_procedimiento, '') + '|' + case me_codigo_interno when 0
        then
        ''
        else isnull(convert(varchar, me_codigo_interno), '') end + '|' + case
        me_codigo_err when 0 then '1' else isnull(convert(varchar, me_codigo_err
        )
        ,
        ''
        )
        end + '|' + isnull(me_descripcion, '')
      from   cobis..ca_msv_error
      where  convert(varchar, me_fecha, 103) =
             convert(varchar, @w_fecha_proceso,
             103)
      order  by me_id_carga
  end
  else
  begin
    insert into errores_alianza_tmp
      select
        convert(varchar(40), me_fecha, 103) + ' '
        + substring( convert( varchar(40), me_fecha, 113), charindex( ':',
        convert
        (
        varchar(40), me_fecha, 113))-2, 8)
        + '|' + isnull(convert(varchar, me_id_carga), '') + '|' + case
        me_id_alianza
        when 0 then '' else isnull(convert(varchar, me_id_alianza), '') end +
        '|'
        +
        case
        me_referencia when 'C' then 'CUPO' when 'U' then 'UNIFIC / UTILIZ' when
        'T'
        then
        'UNIFIC / UTILIZ' when 'O' then 'ORIGINAL' when 'R' then 'RENOVACION'
        when
        'Tipo Tramite: C' then 'UTILIZACION' else isnull(me_referencia, '') end
        +
        '|'
        +
        case me_tipo_proceso when 'T' then 'TRAMITES' when 'C' then 'CLIENTES'
        else
        isnull(me_referencia, '') end + '|'
        + isnull(me_procedimiento, '') + '|' + case me_codigo_interno when 0
        then
        ''
        else isnull(convert(varchar, me_codigo_interno), '') end + '|' + case
        me_codigo_err when 0 then '1' else isnull(convert(varchar, me_codigo_err
        )
        ,
        ''
        )
        end + '|' + isnull(me_descripcion, '')
      from   cobis..ca_msv_error
      where  convert(varchar, me_fecha, 103) =
             convert(varchar, @w_fecha_proceso,
             103)
         and me_tipo_proceso               = @w_tipo_proceso
      order  by me_id_carga
  end

  /* GENERACION ARCHIVO PLANO */
  select
    @w_fecha_pro_txt = convert(varchar, @w_fecha_proceso, 101),
    @w_fecha_arch = substring(convert(varchar(10), @w_fecha_pro_txt), 1, 2)
                    + substring(convert(varchar(10), @w_fecha_pro_txt), 4, 2)
                    + substring(convert(varchar(10), @w_fecha_pro_txt), 7, 4),
    @w_hora_arch = substring(convert(varchar, getdate(), 108), 1, 2)
                   + substring(convert(varchar, getdate(), 108), 4, 2),
    @w_sp_name_batch = 'cobis..sp_err_masivos'

  /* RUTA DE DESTINO DEL ARCHIVO A GENERAR */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @w_path is null
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERRORFIN
  end

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 720014,
      @w_msg = 'NO EXISTE RUTA DEL S_APP'
    goto ERRORFIN
  end

  /*GENERACION PLANO DE REGISTROS CON ERROR*/
  select
    @w_nombre_archivo = @w_path + 'Procesados_error' + '_' + @w_fecha_arch + '_'
                        +
                               @w_hora_arch + '.txt'

  select
    @w_cmd = ' bcp "select * from cobis..errores_alianza_tmp"' + ' queryout '

  --if @w_tipo_proceso is null
  --   select @w_cmd       =  ' bcp "select * from cobis..ca_msv_error where convert(varchar,me_fecha,103)= ''' + convert(varchar,@w_fecha_proceso,103) + '''"' + ' queryout '
  --else
  --   select @w_cmd       =  ' bcp "select * from cobis..ca_msv_error where convert(varchar,me_fecha,103)= ''' + convert(varchar,@w_fecha_proceso,103) + ''' and me_tipo_proceso = ''' + @w_tipo_proceso + '''"' + ' queryout '

  select
    @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S' +
                        @@servername
                 + ' -eProcesados_error.err'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando BCP' + @w_comando
    goto ERRORFIN
  end

  return 0

  ERRORFIN:
  exec cobis..sp_error_proc_masivos
    @i_referencia     = 'No_Id',
    @i_tipo_proceso   = 'C',
    @i_procedimiento  = @w_sp_name,
    @i_codigo_interno = 0,
    @i_codigo_err     = @w_error,
    @i_descripcion    = @w_msg

  return 1

go

