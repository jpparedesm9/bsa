/************************************************************************/
/*  Archivo:                         olainver.sp                        */
/*  Stored procedure:                sp_ola_invernal                    */
/*  Base de datos:                   cobis                              */
/*  Producto:                        CLIENTES                           */
/*  Disenado por:                    D.a.l.s                            */
/*  Fecha de escritura:              19/Dic/2011                        */
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
/*                          PROPOSITO                                   */
/*  Marcar clientes como de ola invernal                                */
/*                                                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA          AUTOR                  RAZON                         */
/*  Dic 19/11     D.A.L.S                 ORS                           */
/*  04/May/2016   T. Baidal      Migracion a CEN                        */
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
           where  name = 'sp_ola_invernal')
    drop proc sp_ola_invernal
go

create proc sp_ola_invernal
(
  @t_show_version bit = 0,
  @i_param1       tinyint,-- Empresa
  @i_param2       varchar(20),-- Archivo de entrada
  @i_param3       varchar(10) -- Marcacion / Desmarcacion (M/D)
)
as
  declare
    @w_sp_name     varchar(30),
    @w_comando     varchar(255),
    @w_archivo     varchar(64),
    @w_ruta        varchar(64),
    @w_path_lis    varchar(64),
    @w_errores     varchar(64),
    @w_fecha_hoy   varchar(10),
    @w_dia         smallint,
    @w_mes         smallint,
    @w_anio        smallint,
    @w_fecha_arch  varchar(20),
    @w_error       int,
    @w_archivo_err varchar(64),
    @w_path_arch   varchar(64),
    @w_tipo_ced    char(2),
    @w_documento   varchar(30)

  select
    @w_sp_name = 'sp_ola_invernal'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_hoy = convert(varchar(10), getdate(), 101)

  select
    @w_archivo = @i_param2

  truncate table cobis..cl_ola_invernal

  if @i_param3 not in ('M', 'D')
  begin
    print 'EL PARAMETRO DEBE SER <M> PARA MARCACION O <D> PARA DESMARCACION '
    return 1
  end

  select
    @w_dia = datepart(dd,
                      @w_fecha_hoy)
  select
    @w_mes = datepart(mm,
                      @w_fecha_hoy)
  select
    @w_anio = datepart(yyyy,
                       @w_fecha_hoy)
  select
    @w_fecha_arch = convert(varchar(4), @w_anio) + '_' + case when @w_mes < 10
                    then
                                                                ('0' + convert(
                                                                varchar(4),
                    @w_mes
                    ))
                                                                + '_' else
                    convert
                    (
                                                                varchar(4),
                    @w_mes
                    )
                                                                + '_' end + case
                                                                when @w_dia < 10
                                                                then ('0' +
                    convert(
                                                                varchar(4),
                    @w_dia
                    ))
                                                                + '_' else
                    convert
                    (
                                                                varchar(4),
                    @w_dia
                    )
                                                                + '_' end

  --subir archivo plano a tabla cl_ola_invernal

  select
    @w_ruta = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path_lis = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  select
    @w_path_arch = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'PATCOR'
     and pa_producto = 'MIS'

  select
    @w_errores = @w_path_lis + 'olainver' + '_' + @w_fecha_arch + '.err'
  select
    @w_comando = @w_ruta + 's_app bcp cobis..cl_ola_invernal in '
  select
       @w_comando = @w_comando + @w_path_arch + @w_archivo + ' -b5000 -c -e' +
                    @w_errores + ' -t' +
                    '"' + '|' + '"'
                 + ' -auto -login ' + '-config ' + @w_ruta + 's_app.ini'

  print 'comando: ' + @w_comando
  exec @w_error = xp_cmdshell
    @w_comando
  print 'Error: ' + cast ( @w_error as varchar)

  if @w_error <> 0
  begin
    print ''
    print 'Error generando Archivo: ' + @w_archivo
    print ''
    return 1
  end

  if not exists (select
                   1
                 from   cobis..cl_ola_invernal)
  begin
    print ' NO se subio ningun registro'
    return 1
  end

  --print ' Comienza el ciclo'

  select
    'tipodoc' = co_tipo_doc,
    'documento' = co_documento
  into   #clientes
  from   cobis..cl_ola_invernal

  --actualiza registros
  while 1 = 1
  begin
    select top 1
      @w_tipo_ced = tipodoc,
      @w_documento = documento
    from   #clientes

    if @@rowcount = 0
      break

    if exists (select
                 1
               from   cobis..cl_ente
               where  en_ced_ruc  = @w_documento
                  and en_tipo_ced = @w_tipo_ced)
    begin
      if @i_param3 = 'M' --Marcacion Ola Invernal
      begin
        update cobis..cl_ente
        set    en_casilla_def = '002'
        where  en_ced_ruc  = @w_documento
           and en_tipo_ced = @w_tipo_ced

        if @@error <> 0
        begin
          print 'Error en la Marcacion del Cliente con Cedula'
          print @w_documento
        end
      end
      else
      begin
        update cobis..cl_ente
        set    en_casilla_def = '001'
        where  en_ced_ruc  = @w_documento
           and en_tipo_ced = @w_tipo_ced

        if @@error <> 0
        begin
          print 'Error en la DesMarcacion del Cliente con Cedula'
          print @w_documento
        end
      end
    end
    else
    begin
      print 'Error en la Marcacion/Desmarcacion del Cliente con Cedula'
      print @w_documento
    end

    delete #clientes
    where  documento = @w_documento
  end --while

  return 0

go

