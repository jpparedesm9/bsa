/*************************************************************************/
/*   Archivo:             clestfatca.sp                                  */
/*   Stored procedure:    sp_estados_fatca                               */
/*   Base de datos:       cobis                                          */
/*   Producto:            Cleintes                                       */
/*   Disenado por:        Pedro A. Rojas                                 */
/*   Fecha de escritura:  Nov. 2014.                                     */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                              PROPOSITO                                */
/*   Cambiar la calificacion de los cleitnes FATCA segun parametros      */
/*   parametros definidos                                                */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*    FECHA           AUTOR                RAZON                         */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*************************************************************************/

use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists(select
            1
          from   sysobjects
          where  name = 'sp_estados_fatca')
  drop proc sp_estados_fatca
go

create proc sp_estados_fatca
(
  @t_show_version bit = 0,
  @i_param1       datetime
)
as
  declare
    @w_error      int,
    @w_sp_name    varchar(64),
    @w_msg        varchar(255),
    @w_s_app      varchar(50),
    @w_comando    varchar(255),
    @w_fecha      datetime,
    @w_dias_p     int,
    @w_dias_j     int,
    /*REPORTE*/
    @w_tablac     varchar(254),--Tabla cabecera
    @w_path_s_app varchar(254),
    @w_cmd        varchar(254),
    @w_destinoc   varchar(254),--Comando shell
    @w_path       varchar(60)

    --CARGA DE VARIABLES DE TRABAJO

  select
    @w_sp_name = 'sp_estados_fatca'

    if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  
  select
    @w_fecha = @i_param1

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP',
      @w_error = 1
    goto ERROR_FIN
  end

  select
    @w_s_app = @w_s_app + 's_app'

  /*Path destino archivo BCP*/
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  if @w_path is null
  begin
    select
      @w_msg =
    'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 4000002
    goto ERROR_FIN
  end

  select
    @w_dias_p = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'DFTCAP'

  if @@rowcount = 0
  begin
    select
      @w_error = 1,
      @w_msg =
    'ERROR AL OBTENER EL PARAMETRO DE DIAS RECALCITRANTE PERSONA NATURAL'
    goto ERROR_FIN
  end

  select
    @w_dias_j = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'DFTCAJ'

  if @@rowcount = 0
  begin
    select
      @w_error = 1,
      @w_msg =
    'ERROR AL OBTENER EL PARAMETRO DE DIAS RECALCITRANTE PERSONA JURIDICA'
    goto ERROR_FIN
  end

  -----OOOOOOJJJJOOOOO ACTUALIZAR LOS CAMPOS SEGUN DCUMENTO DE SANTIAGO --------------

  /* CREA LA TABLA TEMPORAL DONDE SE EXPORTARA LA INFORMACION DE LOS ARCHIVOS PROCESADOS */

  create table #fatca_recalcitrante
  (
    ft_tipo_id         char (2),
    ft_num_id          numero,
    ft_tipo_persona    char(3),
    ft_calificacionAnt varchar(2),
    ft_calificacionAct varchar(2),
    ft_fecha_solici    date,
    ft_fec_mod         date
  )

  /* INSERTA LA INFORMACION DE COMO SE ENCUENTRA EL REGISTRO ANTES DE LA EJECUCION */

  insert into #fatca_recalcitrante
    select
      fa_tipo_id,fa_num_id,fa_tipo_persona,fa_calificacion,'00',
      fa_fecha_solici,fa_fec_mod
    from   cl_fatca
    where  fa_calificacion                        = '02'
       and fa_subtipo_persona                     = 'P'
       and datediff(day,
                    fa_fecha_solici,
                    @w_fecha) > @w_dias_p

  insert into #fatca_recalcitrante
    select
      fa_tipo_id,fa_num_id,fa_tipo_persona,fa_calificacion,'00',
      fa_fecha_solici,fa_fec_mod
    from   cl_fatca
    where  fa_calificacion                        = '04'
       and fa_subtipo_persona                     = 'C'
       and datediff(day,
                    fa_fecha_solici,
                    @w_fecha) > @w_dias_j

  /* ACTUALIZA LOS DATOS EN LA TABLA DE FATCA */

  update cl_fatca
  set    fa_calificacion = '03',
         fa_fec_mod = getdate()
  where  fa_calificacion                        = '02'
     and fa_subtipo_persona                     = 'P'
     and datediff(day,
                  fa_fecha_solici,
                  @w_fecha) > @w_dias_p

  update cl_fatca
  set    fa_calificacion = '05',
         fa_fec_mod = getdate()
  where  fa_calificacion                        = '04'
     and fa_subtipo_persona                     = 'C'
     and datediff(day,
                  fa_fecha_solici,
                  @w_fecha) > @w_dias_p

  /* ACTUALIZA EL ESTADO DE COMO QUEDO DESPUES DEL UPDATE */

  update #fatca_recalcitrante
  set    ft_calificacionAct = fa_calificacion
  from   cl_fatca
  where  ft_num_id       = fa_num_id
     and ft_tipo_id      = fa_tipo_id
     and ft_tipo_persona = fa_tipo_persona

/* CREA LA TABLA QUE SE VA A EXPORTAR */
  --ELIMINA SI EXISTE LA TABLA TEMPORAL LA CUAL CONTENDRA LA INFOMACION A EXPORTAR
  if exists (select
               1
             from   sysobjects
             where  name = 'rec_fatca')
    drop table rec_fatca

  --CREA LA TABLA QUE CONTENDRA LA INFORMACION A EXPORTAR
  create table rec_fatca
  (
    finagro_descripcion varchar(2000)
  )

  --INSERTA EL ENCABEZADO DEL ARCHIVO
  insert into rec_fatca
    select
'TIPO IDE|NUM IDENTIFICACION|TIPO PERSONA|CALIFICACION ANTERIOR|CALIFICACION ACTUAL|FECHA DE SOLICITUD|FECHA MODIFICACION'

  --INSERTA EL DETALLE DEL ARCHIVO
  insert into rec_fatca
    select
      convert(varchar, ft_tipo_id) + '|' + convert(varchar, ft_num_id) + '|'
      + convert(varchar, ft_tipo_persona) + '|' + convert(varchar,
      ft_calificacionAnt)
      + '|'
      + convert(varchar, ft_calificacionAct) + '|'
      + convert(varchar, convert(varchar(10), ft_fecha_solici, 103)) + '|'
      + convert(varchar, convert(varchar(10), ft_fec_mod, 103))
    from   #fatca_recalcitrante

  select
    *
  from   rec_fatca

  select
    @w_cmd = @w_s_app + ' bcp -auto -login'
  select
    @w_tablac = ' cobis..rec_fatca'
  select
    @w_destinoc = @w_path + 'PROCESO_RECALCITRANTE_' + convert(varchar, datepart
                  (
                                                             dd, @i_param1))
                  + right('00'+convert(varchar, datepart(mm, @i_param1)), 2)
                  + convert(varchar, datepart(yyyy, @i_param1)) + '.txt'

  select
       @w_comando = @w_cmd + @w_tablac + ' out ' + @w_destinoc +
                    ' -b5000 -c -t"|" '
                    + '-config ' +
                    @w_s_app + '.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_destinoc + ' ' + convert(varchar
               ,
                      @w_error)
    goto ERROR_FIN
  end

  select
    en_tipo_ced,
    en_ced_ruc
  into   #clientes
  from   cl_ente

  create table #fatca
  (
    fa_tipo_id char(2),
    fa_num_id  numero,
    fa_existe  int
  )

  insert into #fatca
    select
      fa_tipo_id,fa_num_id,0
    from   cl_fatca

  update #fatca
  set    fa_existe = 1
  from   #clientes
  where  fa_tipo_id = en_tipo_ced
     and fa_num_id  = en_ced_ruc

  delete f
  from   cl_fatca f
         inner join #fatca
                 on f.fa_tipo_id = #fatca.fa_tipo_id
                    and f.fa_num_id = #fatca.fa_num_id
                    and #fatca.fa_existe = 0

  return 0

  ERROR_FIN:
  print @w_error
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_usuario     = 'optbatch',
    @i_tran_name   = @w_sp_name,
    @i_error       = @w_error,
    @i_tran        = 1624,
    @i_descripcion = @w_msg,
    @i_rollback    = 'S'

  --Registro del error en un archivo
  select
    @w_comando = 'echo ' + convert(varchar, @w_error) + '-' + @w_msg + '>>' +
                        @w_path
                 + 'ERRORES_PROCESO_RECALCITRANTE__' + convert(varchar, datepart
                 (
                        dd, @w_fecha))
                 + right('00'+convert(varchar, datepart(mm, @w_fecha)), 2)
                 + convert(varchar, datepart(yyyy, @w_fecha)) + '.txt'
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print convert(varchar, @w_error)
          + '-ERROR AL GENERAR ARCHIVO ERRORES ERRORES_PROCESO_RECALCITRANTE__'
          + convert(varchar, datepart(dd, @w_fecha))
          + right('00'+convert(varchar, datepart(mm, @w_fecha)), 2)
          + convert(varchar, datepart(yyyy, @w_fecha)) + '.txt'
    return @w_error
  end

  return 0

go

