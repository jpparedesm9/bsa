/*******************************************************************/
/*   Archivo            : cl_homodata.sp                           */
/*   Stored procedure   : sp_homologa_data                         */
/*   Base de datos      : Cobis                                    */
/*   Producto           : Clientes                                 */
/*   Disenado por       : Harvey Montes                            */
/*   Fecha de escritura : 2012/10/18                               */
/*******************************************************************/
/*                        IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de */
/*   "MACOSA", representantes exclusivos para el Ecuador de la     */
/*   "NCR CORPORATION".                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como    */
/*   cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la       */
/*   Presidencia Ejecutiva de MACOSA o su representante.           */
/*******************************************************************/
/*                        PROPOSITO                                */
/*   Proceso para actualizar la información en la BD.              */
/*   Se actualiza la información anterior de  actividades          */
/*     y sectores  a las tablas cobis..cl_ente y                   */
/*     cobis..cl_asociacion_actividad                              */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*   FECHA                AUTOR              RAZON                 */
/*   2012/10/18           Harvey Montes      Emision Inicial       */
/*   2016/05/02/          DFu                Migracion CEN         */
/*******************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_homologa_data')
  drop proc sp_homologa_data
go

create proc sp_homologa_data
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name                char(30),
    @w_pa_fecha               datetime,
    @w_error                  int,
    @w_msg                    varchar(255),
    @w_act_no_actualizadas    int,
    @w_act_sin_relacion       int,
    @w_sect_no_actualizadas   int,
    @w_sect_sin_relacion      int,
    @w_garact_no_actualizadas int,
    @w_s_app                  varchar(30),
    @w_path                   varchar(255),
    @w_comando                varchar(1000),
    @w_comando1               varchar(1000),
    @w_archivo1               varchar(255),
    @w_archivo2               varchar(255),
    @w_archivo3               varchar(255),
    @w_archivo4               varchar(255),
    @w_fecha_act              datetime,
    @w_commit                 char(1)

  select
    @w_sp_name = 'sp_homologa_data'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set ansi_warnings off

  /*SE OBTIENE EL PARAMETRO DE LA FECHA */

  select
    @w_pa_fecha = pa_datetime
  from   cobis..cl_parametro
  where  pa_nemonico = 'FECIIU'
     and pa_producto = 'ADM'

  if @@error <> 0
  begin
    select
      @w_msg = 'NO EXISTE PARAMETRO FECHA CODIGO CIIU',
      @w_error = 101077
    goto ERROR
  end

  /* SE OBTIENE FECHA ACTUAL */
  select
    @w_fecha_act = getdate()

  if @@trancount = 0
  begin
    begin tran
    select
      @w_commit = 'S'
  end

  print 'SE ACTUALIZA LA ACTIVIDAD ECONOMICA CON LA NUEVA INFORMACION'
  /* SE ACTUALIZA LA ACTIVIDAD ECONOMICA CON LA NUEVA INFORMACION */
  update cobis..cl_asociacion_actividad
  set    aa_actividad = isnull(hc_actividad_actual,
                               ' '),
         aa_descripcion = isnull (hc_descrip_act_actual,
                                  ' ')
  from   cobis..cl_homologa_ciiu
  where  convert(int, aa_actividad) = hc_actividad_anterior

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR LA ACTIVIDAD ECONOMICA',
      @w_error = 105147
    goto ERROR
  end

  print 'SE ACTUALIZA EL SECTOR ECONOMICO CON LA NUEVA INFORMACION'
  /* SE ACTUALIZA EL SECTOR ECONOMICO CON LA NUEVA INFORMACION */
  update cobis..cl_asociacion_actividad
  set    aa_sector = hc_sector_actual
  from   cobis..cl_homologa_ciiu
  where  convert(int, aa_actividad) = hc_actividad_actual

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR LA ACTIVIDAD ECONOMICA',
      @w_error = 105147
    goto ERROR
  end

/* SE GENERA REPORTE DE LOS REGISTROS QUE NO SE ACTUALIZARON POR ACTIVIDADES ECONOMICAS NI SECTORES */
  /* ACTIVIDADES */

  print
'SE GENERA UN REPORTE DE LAS ACTIVIDADES  QUE NO SE HAYAN ACTUALIZADO CORRECTAMENTE'
  /* SE GENERA UN REPORTE DE LAS ACTIVIDADES  QUE NO SE HAYAN ACTUALIZADO CORRECTAMENTE */

  select
    @w_act_no_actualizadas = count(distinct(aa_actividad))
  from   cobis..cl_asociacion_actividad
  where  aa_actividad not in (select
                                hc_actividad_actual
                              from   cobis..cl_homologa_ciiu)

  print
'SE GENERA UN REPORTE DE LAS NUEVAS ACTIVIDADES  QUE NO  HAYAN ENCONTRADO RELACIËN'
  /* SE GENERA UN REPORTE DE LAS NUEVAS ACTIVIDADES  QUE NO  HAYAN ENCONTRADO RELACIËN */

  select
    @w_act_sin_relacion = count(distinct(hc_actividad_actual))
  from   cobis..cl_homologa_ciiu
  where  hc_actividad_actual not in (select
                                       aa_actividad
                                     from   cobis..cl_asociacion_actividad)

  /* SECTORES */
  print
'SE GENERA UN REPORTE DE LOS SECTORES QUE NO SE HAYAN ACTUALIZADO CORRECTAMENTE'
  /* SE GENERA UN REPORTE DE LOS SECTORES QUE NO SE HAYAN ACTUALIZADO CORRECTAMENTE */

  select
    @w_sect_no_actualizadas = count(distinct(aa_sector))
  from   cobis..cl_asociacion_actividad
  where  aa_sector not in (select
                             hc_sector_actual
                           from   cobis..cl_homologa_ciiu)

  /* SE GENERA UN REPORTE DE LOS NUEVOS SECTORES  QUE NO  HAYAN ENCONTRADO RELACIËN */
  print
'SE GENERA UN REPORTE DE LOS NUEVOS SECTORES  QUE NO  HAYAN ENCONTRADO RELACIËN'
  select
    @w_sect_sin_relacion = count(distinct(hc_sector_actual))
  from   cobis..cl_homologa_ciiu
  where  hc_sector_actual not in (select
                                    aa_sector
                                  from   cobis..cl_asociacion_actividad)

  /* SE ACTUALIZA LA ACTIVIDAD ECONOMICA CON LA NUEVA INFORMACION */
  print 'SE ACTUALIZA LA ACTIVIDAD ECONOMICA CON LA NUEVA INFORMACION '
  update cob_custodia..cu_gar_actividad
  set    ga_actividad = hc_actividad_actual
  from   cobis..cl_homologa_ciiu
  where  convert(int, ga_actividad) = hc_actividad_anterior

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL ACTUALIZAR LA ACTIVIDAD ECONOMICA',
      @w_error = 105148
    goto ERROR
  end

  print 'SE REPORTAN LOS REGISTROS NO ACTUALIZADOS POR ACTIVIDADES ECONOMICAS'
  /* SE REPORTAN LOS REGISTROS NO ACTUALIZADOS POR ACTIVIDADES ECONOMICAS */
  select
    @w_garact_no_actualizadas = count(distinct(ga_actividad))
  from   cob_custodia..cu_gar_actividad
  where  ga_actividad not in (select
                                hc_actividad_actual
                              from   cobis..cl_homologa_ciiu)

  print 'inserta HISTORICO'
  /* SE ACTUALIZA LA TABLA cl_ente */

  insert into cobis..cl_historico_ciiu
    select
      hc_ente = isnull (en_ente,
                        99999),hc_sector_act = isnull (hc_sector_actual,
                              99999),hc_sector_ant = isnull (en_sector,
                              99999),
      hc_actividad_act = isnull (hc_actividad_actual,
                                 99999),hc_actividad_ant = isnull (en_actividad,
                                 99999),
      hc_fecha = @w_pa_fecha
    from   cobis..cl_homologa_ciiu,
           cobis..cl_ente
    where  hc_actividad_anterior = convert(int, en_actividad)

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cl_historico_ciiu',
      @w_error = 103103
    goto ERROR
  end

  print 'SE ACTUALIZA LA TABLA cl_ente'
  /* SE ACTUALIZA LA TABLA cl_ente */
  update cobis..cl_ente
  set    en_actividad = hc_actividad_actual,
         en_sector = hc_sector_actual
  from   cobis..cl_homologa_ciiu
  where  hc_actividad_anterior = convert(int, en_actividad)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR AL ACTUALIZAR LA ACTIVIDAD ECONOMICA Y EL SECTOR EN LA TABLA cl_ente'
,
@w_error = 150001
goto ERROR
end

  if @w_commit = 'S'
  begin
    commit tran
    select
      @w_commit = 'N'
  end

  /* SE GENERA UN REPORTE DEL NUMERO DE REGISTROS ACTUALIZADOS CORRECTAMENTE Y DE LOS QUE NO PUDIERON SER ACTUALIZADOS*/

  print 'SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR EL REPORTE'
  /* SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR EL REPORTE */
  if exists (select
               1
             from   sysobjects
             where  name = 'cl_reporte_total_tmp')
    drop table cl_reporte_total_tmp

  create table cobis..cl_reporte_total_tmp
  (
    rt_etiqueta varchar(250) null,
    rt_valor    int null
  )

  print
'SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR DETALLE DEL REPORTE'
  /* SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR DETALLE DEL REPORTE */
  if exists (select
               1
             from   sysobjects
             where  name = 'cl_reporte_det_tmp')
    drop table cl_reporte_det_tmp

  create table cobis..cl_reporte_det_tmp
  (
    rt_actividad catalogo null,
    rt_etiqueta  varchar(250) null
  )

  insert into cobis..cl_reporte_total_tmp
              (rt_etiqueta,rt_valor)
  values      (
'ACTIVIDADES EN TABLA DE ASOCIACION ACTIVIDAD Y QUE NO ESTAN EN HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
,@w_act_no_actualizadas )

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_total_tmp',
      @w_error = 150000
    goto ERROR
  end

  print 'GENERA DETALLES'
  /*GENERA DETALLES 1*/
  insert into cobis..cl_reporte_det_tmp
    select distinct
      (aa_actividad),
'ACTIVIDADES EN TABLA DE ASOCIACION ACTIVIDAD Y QUE NO ESTAN EN HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
from   cobis..cl_asociacion_actividad
where  aa_actividad not in (select
                              hc_actividad_actual
                            from   cobis..cl_homologa_ciiu)

  insert into cobis..cl_reporte_total_tmp
              (rt_etiqueta,rt_valor)
  values      (
'ACTIVIDADES EN HOMOLOGACION ENTREGADA POR EL BANCO Y QUE NO ESTAN EN TABLA DE ASOCIACION ACTIVIDAD ; POR FAVOR REVISAR'
,@w_act_sin_relacion )

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_total_tmp',
      @w_error = 150000
    goto ERROR
  end

  print 'GENERA DETALLES'
  /*GENERA DETALLES 2*/
  insert into cobis..cl_reporte_det_tmp
    select distinct
      (hc_actividad_actual),
'ACTIVIDADES EN HOMOLOGACION ENTREGADA POR EL BANCO Y QUE NO ESTAN EN TABLA DE ASOCIACION ACTIVIDAD ; POR FAVOR REVISAR'
from   cobis..cl_homologa_ciiu
where  hc_actividad_actual not in (select
                                     aa_actividad
                                   from   cobis..cl_asociacion_actividad)

  insert into cobis..cl_reporte_total_tmp
              (rt_etiqueta,rt_valor)
  values      (
'SECTORES EN TABLA DE ASOCIACION ACTIVIDAD Y QUE NO ESTAN EN HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
,@w_sect_no_actualizadas )

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_total_tmp',
      @w_error = 150000
    goto ERROR
  end

  /*GENERA DETALLES 3*/
  insert into cobis..cl_reporte_det_tmp
    select distinct
      (aa_sector),
'SECTORES EN TABLA DE ASOCIACION ACTIVIDAD Y QUE NO ESTAN EN HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
from   cobis..cl_asociacion_actividad
where  aa_sector not in (select
                           hc_sector_actual
                         from   cobis..cl_homologa_ciiu)

  insert into cobis..cl_reporte_total_tmp
              (rt_etiqueta,rt_valor)
  values      (
'SECTORES EN HOMOLOGACION ENTREGADA POR EL BANCO Y QUE NO ESTAN EN TABLA DE ASOCIACION ACTIVIDAD; POR FAVOR REVISAR'
,@w_sect_sin_relacion )

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_total_tmp',
      @w_error = 150000
    goto ERROR
  end

  /*GENERA DETALLES 4*/
  insert into cobis..cl_reporte_det_tmp
    select distinct
      (hc_sector_actual),
'SECTORES EN HOMOLOGACION ENTREGADA POR EL BANCO Y QUE NO ESTAN EN TABLA DE ASOCIACION ACTIVIDAD; POR FAVOR REVISAR'
from   cobis..cl_homologa_ciiu
where  hc_sector_actual not in (select
                                  aa_sector
                                from   cobis..cl_asociacion_actividad)

  insert into cobis..cl_reporte_total_tmp
              (rt_etiqueta,rt_valor)
  values      (
'ACTIVIDADES EN TABLA DE GARANTIA Y QUE NO ESTAN EN LA HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
,@w_garact_no_actualizadas )

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_total_tmp',
      @w_error = 150000
    goto ERROR
  end

  /*GENERA DETALLES 5*/
  insert into cobis..cl_reporte_det_tmp
    select distinct
      (ga_actividad),
'ACTIVIDADES EN TABLA DE GARANTIA Y QUE NO ESTAN EN LA HOMOLOGACION ENTREGADA POR EL BANCO; POR FAVOR REVISAR'
from   cob_custodia..cu_gar_actividad
where  ga_actividad not in (select
                              hc_actividad_actual
                            from   cobis..cl_homologa_ciiu)

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..cl_reporte_det_tmp',
      @w_error = 150000
    goto ERROR
  end

/* REPORTE DETALLADO DE LOS REGISTROS QUE NO SE ACTUALIZARON */
  /* SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR EL REPORTE */
  print 'SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR EL REPORTE'
  create table #entes
  (
    ente int
  )

  insert into #entes
    select
      ente = en_ente
    from   cobis..cl_ente,
           cobis..cl_homologa_ciiu
    where  en_actividad     = hc_actividad_actual
       and hc_sector_actual = en_sector
    group  by en_ente

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA #entes',
      @w_error = 150000
    goto ERROR
  end

  if exists (select
               1
             from   sysobjects
             where  name = 'rpt_reg_no_act')
    drop table rpt_reg_no_act

  create table cobis..rpt_reg_no_act
  (
    cod_cliente int null,
    nom_cliente varchar(70) null,
    act_actual  int null,
    sect_act    int null
  )

  insert into cobis..rpt_reg_no_act
    select
      cod_cliente = en_ente,nom_cliente = en_nombre,act_actual = en_actividad,
      sect_act = en_sector
    from   cobis..cl_ente
    where  en_ente not in (select
                             ente
                           from   #entes)

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL INSERTAR EN LA TABLA cobis..rpt_reg_no_act',
      @w_error = 150000
    goto ERROR
  end

  /* GENERACION DEL bcp PARA TOTAL DE REGISTROS ACTUALIZADOS*/

  select
    @w_archivo1 = 'REPORTE_STATUS_REGISTROS_NO_ACTUALIZADOS.txt'

  /* S_APP */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_error = 400008,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
  end

  /*OBTIENES LA RUTA DONDE SE CARGA/DEJA ARCHIVO PLANO*/
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2 --DE ACUERDO A LA TABLA CL_PRODUCTO

  if @@trancount = 0
  begin
    select
      @w_msg = 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH',
      @w_error = 150000
  end

  /* CARGAS EN VARIABLE @W_COMANDO*/
  select
    @w_comando = @w_s_app + 's_app' +
                        ' bcp -auto -login cobis..cl_reporte_total_tmp out ' +
                        @w_path
                 + @w_archivo1 + ' -c -e' +
                        'REPORTE_STATUS_REGISTROS_NO_ACTUALIZADOS.err' +
                 ' -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando

  /* CONTROL DE ERRORES EN EJECUCION DE BCP*/
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo1 + ' ' + convert(varchar
               ,
                      @w_error)
    goto ERROR
  end

  /* GENERACION DEL bcp PARA TOTAL DE REGISTROS ACTUALIZADOS DETALLADO POR CLIENTE*/
  select
    @w_archivo2 =
    'REPORTE_STATUS_REGISTROS_NO_ACTUALIZADOS_DETALLADO_CLIENTE.txt'

  /* CARGAS EN VARIABLE @W_COMANDO*/
  select
    @w_comando1 = @w_s_app + 's_app' +
                         ' bcp -auto -login cobis..rpt_reg_no_act out ' +
                  @w_path
                  +
                         @w_archivo2
                  + ' -c -e' +
           'REPORTE_STATUS_REGISTROS_NO_ACTUALIZADOS_DETALLADO_CLIENTE.err'
                  + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando1

  /* CONTROL DE ERRORES EN EJECUCION DE BCP*/
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo2 + ' ' + convert(varchar
               ,
                      @w_error)
    goto ERROR
  end

  /* GENERACION DEL bcp PARA TOTAL DE REGISTROS ACTUALIZADOS DETALLADO POR CLIENTE*/
  select
    @w_archivo3 =
    'REPORTE_DETALLE_REGISTROS_NO_ACTUALIZADOS_DETALLADO_CLIENTE.txt'

  /* CARGAS EN VARIABLE @W_COMANDO*/
  select
    @w_comando1 = @w_s_app + 's_app' +
                         ' bcp -auto -login cobis..cl_reporte_det_tmp out ' +
                         @w_path
                  + @w_archivo3 + ' -c -e'
                  +
    'REPORTE_DETALLE_REGISTROS_NO_ACTUALIZADOS_DETALLADO_CLIENTE.err' +
                  ' -t"|" '
                  + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando1

  /* CONTROL DE ERRORES EN EJECUCION DE BCP*/
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo3 + ' ' + convert(varchar
               ,
                      @w_error)
    goto ERROR
  end

/*Adicionar Nueva informacion a la tabla cobis..cl_asociacion_actividad*/
/*SE CARGA LA INFORMACION DESDE EL ARCHIVO PLANO*/
  /*OBTIENE LA RUTA DEL S_APP*/
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_error = 400008,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
  end

  /*OBTIENE LA RUTA DONDE SE CARGA EL ARCHIVO PLANO*/
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  if @@trancount = 0
  begin
    select
      @w_msg = 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH',
      @w_error = 150000
  end

  select
    @w_archivo4 = 'Asociacion_Nueva.txt'

  /*CARGA EN VARIABLE @W_COMANDO*/
  select
    @w_comando = @w_s_app + 's_app' +
                        ' bcp -auto -login cobis..cl_asociacion_actividad in ' +
                        @w_path
                 + @w_archivo4 + ' -b100 -t"|" -c -e' + 'Asociacion_Nueva.err' +
                        ' -config ' + @w_s_app
                 + 's_app.ini'

  /*SE EJECUTA CON CMDSHELL*/
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo4 + ' ' + convert(varchar
               ,
                      @w_error)
    goto ERROR
  end

  /* SE ELIMINAN LAS TABLAS TEMPORALES CREADAS PARA GENERAR EL REPORTE */
  if exists (select
               1
             from   sysobjects
             where  name = 'cl_reporte_total_tmp')
    drop table cl_reporte_total_tmp

  if exists (select
               1
             from   sysobjects
             where  name = 'rpt_reg_no_act')
    drop table rpt_reg_no_act

  if exists (select
               1
             from   sysobjects
             where  name = 'cl_reporte_det_tmp')
    drop table cl_reporte_det_tmp

  return 0

  ERROR:

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

  exec sp_errorlog
    @i_fecha       = @w_fecha_act,
    @i_error       = @w_error,
    @i_usuario     = 'OBATCH',
    @i_tran        = @w_error,
    @i_tran_name   = 'sp_homologa_data.sp',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg
  print @w_msg

  return 1

go

