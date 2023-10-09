/************************************************************************/
/*   Archivo:             elim_msv_outdir.sp                            */
/*   Stored procedure:    sp_elim_msv_outdir                            */
/*   Base de datos:       cobis                                         */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Jorge Tellez C                                */
/*   Fecha de escritura:  Jun. 2013                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                         PROPOSITO                                    */
/*   Procedimiento que eoimina los archivos generados en el outdir      */
/*   por los procesos masivos                                           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA       AUTOR         RAZON                                 */
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
           where  name = 'sp_elim_msv_outdir')
           drop proc sp_elim_msv_outdir
go

create proc sp_elim_msv_outdir
  @s_ssn           int = null,
  @s_sesn          int = null,
  @s_date          datetime = null,
  @s_ofi           smallint = null,
  @s_user          login = null,
  @s_rol           smallint = null,
  @s_term          varchar(30) = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_org           char(1) = null,
  @t_show_version  bit = 0,
  @i_debug         char(1) = 'N',
  @i_sarta         int = null,
  @i_batch         int = null,
  @o_descripcion   varchar(200) = null output
as
  declare
    @w_return         int,
    @w_fecha_hoy      datetime,
    @w_comando        varchar(200),
    @w_sp_name_batch  varchar(200),
    @w_path           varchar(200),
    @w_descripcion    varchar(200),
    @w_dir_salida     varchar(100),
    @w_dias_elim      int,
    @w_fecha_ult_elim datetime,
    @w_sarta          varchar(30),
    @w_sp_name        varchar(30)

  select
    @w_sp_name = 'sp_elim_msv_outdir'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  select
    @w_fecha_hoy = getdate()
  select
    @w_sarta = convert(varchar(30), @i_sarta)
  select
    @w_return = 0

  ----------------------------------------------------------------------------------------------------------------------
  ---------- ELIMINACION DE ARHIVOS DE CARPETA OUTDIR ------------------------------------------------------------------
  select
    @w_dir_salida = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'MSVDIR'
     and pa_producto = 'MIS'
  if @@rowcount = 0
  begin
    select
      @o_descripcion =
             'Parametro: DIRECTORIO SALIDA DE OUTDIR DE PROCESOS MSV.,sarta: '
                       + cast( @i_sarta as varchar) + '. No existe'

    return 1

  end
  select
    @w_dias_elim = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'DIABOU'
     and pa_producto = 'MIS'
  if @@rowcount = 0
  begin
    select
      @o_descripcion =
      'Parametro: DIAS PARA ELIMIANAR ARCHIVOS .OUT DE PROCESOS MASIVOS.sarta: '
                + cast( @i_sarta as varchar) + '. No existe'

    return 1

  end
  select
    @w_fecha_ult_elim = pa_datetime
  from   cobis..cl_parametro
  where  pa_nemonico = 'FECELM'
     and pa_producto = 'MIS'
  if @@rowcount = 0
  begin
    select
      @o_descripcion =
'Parametro: FECHA ULTIMA ELIMINACIONDE ARCHIVOS .OUT DE PROCESOS MASIVOS.,sarta: '
          + cast( @i_sarta as varchar) + '. No existe'

  return 1

end

  ---------------------------------------------------------------------------------------------------------------------
  ------------  ELIMIACION DE ARCHIVOS DEL OUTDIR  --------------------------------------------------------------------

  select
    @w_sp_name_batch = ba_arch_fuente
  from   cobis..ba_batch
  where  ba_batch = @i_batch

  -- RUTA DE DESTINO DEL ARCHIVO A GENERAR

  select
    @w_path = ba_path_fuente -- F:\Vbatch\Clientes\Objetos\

  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @o_descripcion =
  'ERROR GENERANDO RUTA PARA MOVER ARCHIVOS DE SALIDA DEL OUTDIR,sarta: '
            + cast( @i_sarta as varchar)

    return 1

  end

  -- MUEVE ARCHIVOS execbatch.log_'+@w_sarta+'_*.log a CARPETA ESPECIFICA DE ESTA SARTA
  select
    @w_comando = 'move ' + @w_path + '..\..\Outdir\' + 'execbatch.log_' +
                 @w_sarta
                 +
                        '_*.log ' +
                        @w_path
                 + '..\..\Outdir\' + @w_dir_salida + '\'

  exec @w_return = xp_cmdshell
    @w_comando
  --if @w_return <> 0
  --   select @w_descripcion = 'ERROR GENERANDO RUTA PARA MOVER ARCHIVOS DE SALIDA DEL OUTDIR..sarta: '+ cast( @i_sarta as varchar)

  -- MUEVE ARCHIVOS 2013_*.out A CARPETA ESPECIFICA DE ESTA SARTA
  select
    @w_comando = 'move ' + @w_path + '..\..\Outdir\' + @w_sarta + '_*.out ' +
                        @w_path +
                        '..\..\Outdir\'
                 + @w_dir_salida + '\'
  exec @w_return = xp_cmdshell
    @w_comando
  --if @w_return <> 0
  --   select @w_descripcion = 'ERROR GENERANDO RUTA PARA MOVER ARCHIVOS DE SALIDA DEL OUTDIR_sarta: '+ cast( @i_sarta as varchar)

  -- BORRA ARCHIVOS execbatch.log_2013_*.log a CARPETA ESPECIFICA DE ESTA SARTA
  select
    @w_comando = 'del ' + @w_path + '..\..\Outdir\' + @w_dir_salida + '\' +
                        'execbatch.log_' +
                        @w_sarta + '_*.log '
  exec @w_return = xp_cmdshell
    @w_comando
  --if @w_return <> 0
  --   select @w_descripcion = 'ERROR GENERANDO RUTA PARA MOVER ARCHIVOS DE SALIDA DEL OUTDIR..sarta:'+ cast( @i_sarta as varchar)

  -- BORRA ARCHIVOS 2013_*.out A CARPETA ESPECIFICA DE ESTA SARTA. ESTO ES CADA DETERMINADO TIEMPO
  if datediff(dd,
              @w_fecha_ult_elim,
              getdate()) >= isnull(@w_dias_elim,
                                   0)
  begin
    select
      @w_comando = 'del ' + @w_path + '..\..\Outdir\' + @w_dir_salida + '\' +
                   @w_sarta
                          + '_*.out '
    exec @w_return = xp_cmdshell
      @w_comando
    --if @w_return <> 0
    --   select @w_descripcion = 'ERROR GENERANDO RUTA PARA MOVER ARCHIVOS DE SALIDA DEL OUTDIR.sarta. '+ cast( @i_sarta as varchar)

    update cobis..cl_parametro
    set    pa_datetime = getdate()
    where  pa_nemonico = 'FECELM'
       and pa_producto = 'MIS'

  end

  return 0

go

