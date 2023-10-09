/************************************************************************/
/*   Archivo:             cl_ordext_fallida.sp                          */
/*   Stored procedure:    sp_ordext_fallida                             */
/*   Base de datos:       Cobis                                         */
/*   Producto:            Clientes                                      */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  07 de Noviembre de 2013                       */
/************************************************************************/
/*                             IMPORTANTE                               */
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
/*                             PROPOSITO                                */
/*   Proceso Batch que Refresca la Puntuacion de los Tramites           */
/*   Encontrados en el archivo (BCP) brindado por el usuario            */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   07/Nov/2013        Oscar Saavedra    Emision Inicial INC 117684    */
/*   02/May/2016        DFu               Migracion CEN                 */
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
           where  name = 'sp_ordext_fallida')
  drop proc sp_ordext_fallida
go

create proc sp_ordext_fallida
(
  @t_show_version bit = 0,
  @i_param1       datetime,-- Fecha Proceso
  @i_param2       char(1),-- P = Plano, T = Todos
  @i_param3       varchar(140) = null -- Nombre del Archivo
)
as
  declare
    @w_sp_name         char(30),
    @w_path            varchar(256),
    @w_table           varchar(256),
    @w_file            varchar(256),
    @w_msg             varchar(256),
    @w_sql             varchar(1024),
    @w_backup          varchar(128),
    @w_error           int,
    @w_cmd             sysname,
    @w_ente            int,
    @w_ced             varchar(16),
    @w_observacion     varchar(140),
    @w_secuencial      int,
    @w_tconsulta       char(2),
    @w_fecha_ing       datetime,
    @w_fecha_real_resp datetime,
    @w_estado          char(3),
    @w_sec_ejec        int,
    @w_usuario         varchar(12),
    @w_oficina         int,
    @w_operacion       char(1)

  select
    @w_sp_name = 'sp_ordext_fallida'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*Parametro de Ubicacion del Archivo*/
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2221

  /*Variables de Trabajo*/
  select
    @w_operacion = @i_param2,
    @w_file = @i_param3,
    @w_table = 'cobis..cl_orden_ext_fallida'

  if @w_operacion = 'T'
  begin
    begin tran

    insert into ts_orden_consulta_ext
                (ts_operacion,ts_fecha_op,ts_usuario_op,ts_secuencial,
                 ts_tipo_ced,
                 ts_ced_ruc,ts_p_apellido,ts_ente,ts_tconsulta,ts_fecha_ing,
                 ts_fecha_resp,ts_usuario,ts_oficina,ts_intentos,ts_estado,
                 ts_fecha_real_ing,ts_fecha_real_resp,ts_sec_ejec,ts_observacion
    )
      select
        @w_operacion,getdate(),'op_batch',oc_secuencial,oc_tipo_ced,
        oc_ced_ruc,oc_p_apellido,oc_ente,oc_tconsulta,oc_fecha_ing,
        oc_fecha_resp,oc_usuario,oc_oficina,oc_intentos,oc_estado,
        oc_fecha_real_ing,oc_fecha_real_resp,oc_sec_ejec,oc_observacion
      from   cobis..cl_orden_consulta_ext
      where  oc_estado in ('PPR', 'EIT')
         and oc_fecha_real_ing >= dateadd(week,
                                          -2,
                                          getdate())
         and oc_fecha_real_ing <= dateadd(hour,
                                          -1,
                                          getdate())
      order  by isnull(oc_fecha_real_resp,
                       dateadd(dd,
                               1,
                               getdate())) desc,
                oc_fecha_real_ing desc

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL INSERTAR RESPALDO ts_orden_consulta_ext Error: '
                 + convert(varchar(12), @@error),
        @w_error = 201243
      goto ERROR
    end

    select
      ce_ente = oc_ente,
      ce_secuencial = oc_secuencial,
      ce_tconsulta = oc_tconsulta
    into   #ConsultaExterna
    from   cobis..cl_orden_consulta_ext
    where  oc_estado in ('PPR', 'EIT')
       and oc_fecha_real_ing >= dateadd(week,
                                        -2,
                                        getdate())
       and oc_fecha_real_ing <= dateadd(hour,
                                        -1,
                                        getdate())
    order  by isnull(oc_fecha_real_resp,
                     dateadd(dd,
                             1,
                             getdate())) desc,
              oc_fecha_real_ing desc

    insert into ts_informacion_ext
                (ts_operacion,ts_fecha_op,ts_usuario_op,ts_tipo_ced,ts_ced_ruc,
                 ts_ente,ts_tconsulta,ts_fecha,ts_orden,ts_trama_xml,
                 ts_version_xml,ts_respuesta_con,ts_estado_doc,ts_fecha_real)
      select
        @w_operacion,getdate(),'op_batch',in_tipo_ced,in_ced_ruc,
        in_ente,in_tconsulta,in_fecha,in_orden,in_trama_xml,
        in_version_xml,in_respuesta_con,in_estado_doc,in_fecha_real
      from   cobis..cl_informacion_ext,
             #ConsultaExterna
      where  in_ente      = ce_ente
         and in_orden     = ce_secuencial
         and in_tconsulta = ce_tconsulta

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL INSERTAR RESPALDO ts_informacion_ext Error: '
                 + convert(varchar(12), @@error),
        @w_error = 201242
      goto ERROR
    end

    delete from cobis..cl_orden_consulta_ext
    where  oc_estado in ('PPR', 'EIT')
       and oc_fecha_real_ing >= dateadd(week,
                                        -2,
                                        getdate())
       and oc_fecha_real_ing <= dateadd(hour,
                                        -1,
                                        getdate())

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL ELIMINAR REGISTRO cl_orden_consulta_ext Error: '
                 + convert(varchar, @@error),
        @w_error = 208107
      goto ERROR
    end

    delete cl_informacion_ext
    from   cobis..cl_informacion_ext,
           #ConsultaExterna
    where  in_ente      = ce_ente
       and in_orden     = ce_secuencial
       and in_tconsulta = ce_tconsulta

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL ELIMINAR REGISTRO cl_informacion_ext Error: ' +
                 convert
                 (
                                        varchar,
                                        @@error),
        @w_error = 208107
      goto ERROR
    end

    commit tran

  end

  if @w_operacion = 'P'
  begin
    truncate table cl_orden_ext_fallida

    /*Inserta en la tabla cr_tramites_mir los tramites contenidos en el archivo BCP*/
    select
      @w_cmd = 'bcp ' + @w_table + ' in ' + @w_path + @w_file + ' -c -T -t"|"'

    exec @w_error = master..xp_cmdshell
      @w_cmd

    if @w_error <> 0
    begin
      select
        @w_msg = 'ERROR AL AL CARGAR ARCHIVO ' + @w_file + ' ' + convert(varchar
                 ,
                        @w_error),
        @w_error = 208160
      goto ERROR
    end

    begin tran

    insert into ts_orden_consulta_ext
                (ts_operacion,ts_fecha_op,ts_usuario_op,ts_secuencial,
                 ts_tipo_ced,
                 ts_ced_ruc,ts_p_apellido,ts_ente,ts_tconsulta,ts_fecha_ing,
                 ts_fecha_resp,ts_usuario,ts_oficina,ts_intentos,ts_estado,
                 ts_fecha_real_ing,ts_fecha_real_resp,ts_sec_ejec,ts_observacion
    )
      select
        @w_operacion,getdate(),'op_batch',oc_secuencial,oc_tipo_ced,
        oc_ced_ruc,oc_p_apellido,oc_ente,oc_tconsulta,oc_fecha_ing,
        oc_fecha_resp,oc_usuario,oc_oficina,oc_intentos,oc_estado,
        oc_fecha_real_ing,oc_fecha_real_resp,oc_sec_ejec,(
        isnull(oc_observacion, '') + ' ' + isnull(oe_observacion, ''))
      from   cobis..cl_orden_consulta_ext,
             cobis..cl_orden_ext_fallida,
             cobis..cl_ente
      where  en_ced_ruc        = oe_ced_ruc
         and en_ente           = oc_ente
         and oc_estado in ('PPR', 'EIT')
         and oc_fecha_real_ing < dateadd(minute,
                                         -10,
                                         getdate())
      union
      select
        @w_operacion,getdate(),'op_batch',oc_secuencial,oc_tipo_ced,
        oc_ced_ruc,oc_p_apellido,oc_ente,oc_tconsulta,oc_fecha_ing,
        oc_fecha_resp,oc_usuario,oc_oficina,oc_intentos,oc_estado,
        oc_fecha_real_ing,oc_fecha_real_resp,oc_sec_ejec,(
        isnull(oc_observacion, '') + ' ' + isnull(oe_observacion, ''))
      from   cobis..cl_orden_consulta_ext,
             cobis..cl_orden_ext_fallida,
             cobis..cl_ente
      where  en_ced_ruc        = oe_ced_ruc
         and en_ente           = oc_ente
         and oc_estado         = 'PRO'
         and oc_tconsulta      <> '05'
         and oc_secuencial not in(select
                                    in_orden
                                  from   cobis..cl_informacion_ext
                                  where  oc_ente = in_ente)
         and oc_fecha_real_ing < dateadd(minute,
                                         -10,
                                         getdate())

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL INSERTAR RESPALDO ts_orden_consulta_ext Error:'
                 + convert(varchar(12), @@error),
        @w_error = 201243
      goto ERROR
    end

    select
      ce_ente = oc_ente,
      ce_secuencial = oc_secuencial,
      ce_tconsulta = oc_tconsulta
    into   #ConsultaExternaPlano
    from   cobis..cl_orden_consulta_ext,
           cobis.. cl_orden_ext_fallida,
           cobis..cl_ente
    where  en_ced_ruc        = oe_ced_ruc
       and en_ente           = oc_ente
       and oc_estado in ('PPR', 'EIT')
       and oc_fecha_real_ing < dateadd(minute,
                                       -10,
                                       getdate())
    order  by isnull(oc_fecha_real_resp,
                     dateadd(dd,
                             1,
                             getdate())) desc,
              oc_fecha_real_ing desc

    insert into ts_informacion_ext
                (ts_operacion,ts_fecha_op,ts_usuario_op,ts_tipo_ced,ts_ced_ruc,
                 ts_ente,ts_tconsulta,ts_fecha,ts_orden,ts_trama_xml,
                 ts_version_xml,ts_respuesta_con,ts_estado_doc,ts_fecha_real)
      select
        @w_operacion,getdate(),'op_batch',in_tipo_ced,in_ced_ruc,
        in_ente,in_tconsulta,in_fecha,in_orden,in_trama_xml,
        in_version_xml,in_respuesta_con,in_estado_doc,in_fecha_real
      from   cobis..cl_informacion_ext,
             #ConsultaExternaPlano
      where  in_ente      = ce_ente
         and in_orden     = ce_secuencial
         and in_tconsulta = ce_tconsulta

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL INSERTAR RESPALDO ts_informacion_ext Error:'
                 + convert(varchar(12), @@error),
        @w_error = 201242
      goto ERROR
    end

    delete cl_orden_consulta_ext
    from   cobis..cl_orden_consulta_ext,
           cobis.. cl_orden_ext_fallida,
           cobis..cl_ente
    where  en_ced_ruc        = oe_ced_ruc
       and en_ente           = oc_ente
       and oc_estado in ('PPR', 'EIT')
       and oc_fecha_real_ing < dateadd(minute,
                                       -10,
                                       getdate())

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL ELIMINAR REGISTRO cl_orden_consulta_ext Error:'
                 + convert(varchar, @@error),
        @w_error = 208107
      goto ERROR
    end

    delete cl_orden_consulta_ext
    from   cobis..cl_orden_consulta_ext,
           cobis.. cl_orden_ext_fallida,
           cobis..cl_ente
    where  en_ced_ruc        = oe_ced_ruc
       and en_ente           = oc_ente
       and oc_estado         = 'PRO'
       and oc_tconsulta      <> '05'
       and oc_secuencial not in(select
                                  in_orden
                                from   cobis..cl_informacion_ext
                                where  oc_ente = in_ente)
       and oc_fecha_real_ing < dateadd(minute,
                                       -10,
                                       getdate())

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL ELIMINAR REGISTRO cl_orden_consulta_ext Pro Error:'
                 + convert(varchar, @@error),
        @w_error = 208107
      goto ERROR
    end

    delete cl_informacion_ext
    from   cobis..cl_informacion_ext,
           #ConsultaExternaPlano
    where  in_ente      = ce_ente
       and in_orden     = ce_secuencial
       and in_tconsulta = ce_tconsulta

    if @@error <> 0
    begin
      rollback tran
      select
        @w_msg = 'ERROR AL ELIMINAR REGISTRO cl_informacion_ext Error:' +
                 convert(
                                        varchar,
                                        @@error),
        @w_error = 208107
      goto ERROR
    end

    commit tran

  end

  return 0

  ERROR:
  print @w_msg
  exec @w_error = cob_credito..sp_errorlog
    @i_fecha       = @i_param1,
    @i_error       = @w_error,
    @i_usuario     = 'op_ordenext',
    @i_tran        = 29412,
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  return @w_error

go

