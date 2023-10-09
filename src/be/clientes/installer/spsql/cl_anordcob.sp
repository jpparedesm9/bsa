/****************************************************************************/
/*     Archivo:          cl_anordcob.sp                                     */
/*     Stored procedure: sp_anu_orden_cert                                  */
/*     Base de datos:    cobis                                              */
/*     Producto:         Clientes                                           */
/*     Disenado por:     Andres Diab                                        */
/*     Fecha de escritura: 07-Oct-2011                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa se encarga de anular las ordenes de cobro de           */
/*     certificaciones que no fueron pagadas y/o impresas.                  */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*       May/02/2016    DFu             Migracion CEN                       */
/****************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_anu_orden_cert')
  drop proc sp_anu_orden_cert
go

create proc sp_anu_orden_cert
  @i_param1       varchar(255),-- Fecha Proceso
  @t_show_version bit = 0
as
  declare
    @i_fecha         datetime,
    @w_sp_name       varchar(32),
    @w_error         int,
    @w_return        int,
    @w_mensaje       varchar(1000),
    @w_idorden       int,
    @w_rowcount      int,
    @w_archivo       varchar(50),
    @w_comando       varchar(1000),
    @w_cmd           varchar(500),
    @w_path_listados varchar(500),
    @w_errores       varchar(500),
    @w_s_app         varchar(200),
    @w_fecha         datetime

  select
    @w_sp_name = 'sp_anu_orden_cert'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha = convert(datetime, @i_param1),
    @w_rowcount = 0

  create table #error_orden_anulada
  (
    idorden int
  )

  truncate table cl_rep_anu_orden

  select
    pc_id_orden
  into   #ordenes_x_anular
  from   cobis..cl_pagos_certificaciones
  where  pc_fec_sol = @i_fecha
     and pc_estado  <> 'IMP'

  while 1 = 1
  begin
    select top 1
      @w_idorden = pc_id_orden
    from   #ordenes_x_anular
    order  by pc_id_orden asc
    if @@rowcount = 0
      break

    exec @w_return = cob_remesas..sp_genera_orden
      @s_date      = @i_fecha,--> Fecha de proceso
      @s_user      = 'batch',--> Usuario
      @i_operacion = 'A',--> Operacion ('I' -> Insercion, 'A' Anulaci¾n)
      @i_idorden   = @w_idorden,--> C¾d Orden cuando operaci¾n 'A',         
      @i_interfaz  = 'S'
    if @@error <> 0
        or @w_return <> 0
    begin
      print 'ERROR ANULANDO ORDENES DE COBRO CERTIFICACIONES. ORDEN: '
            + convert(varchar, @w_idorden) + ' FECHA: ' + convert(varchar(10),
            @i_fecha, 103)

      insert into #error_orden_anulada
      values      (@w_idorden)

      goto SIGUIENTE
    end

    update cobis..cl_pagos_certificaciones
    set    pc_estado = 'ANU'
    where  pc_id_orden = @w_idorden
    if @@error <> 0
    begin
      print 'ERROR ANULANDO ORDENES DE IMPRESION CERTIFICACIONES. ORDEN: '
            + convert(varchar, @w_idorden) + ' FECHA: ' + convert(varchar(10),
            @i_fecha, 103)

      insert into #error_orden_anulada
      values      (@w_idorden)

      goto SIGUIENTE
    end

    SIGUIENTE:

    delete from #ordenes_x_anular
    where  pc_id_orden = @w_idorden
  end

  select
    @w_return = 0

  select
    @w_rowcount = count(1)
  from   #error_orden_anulada

  if @w_rowcount > 0
  begin
    select
      @w_mensaje =
'ERROR ANULANDO ORDENES DE IMPRESION CERTIFICACIONES. REVISAR EL ARCHIVO .OUT PARA MAS INFORMACION: '
             + ' FECHA: ' + convert(varchar(10), @i_fecha, 103),
@w_error = 205001

  select
    usuario = oc_usuario,
    oficina = oc_oficina,
    zona = (select
              of_zona
            from   cobis..cl_oficina
            where  of_oficina = oc_oficina),
    cliente = oc_cliente,
    fecha = oc_fecha_cambio
  into   #datos_log
  from   cob_remesas..re_orden_caja,
         #error_orden_anulada
  where  idorden = oc_idorden

  goto ERROR
end

  return 0

  ERROR:

  insert into cl_rep_anu_orden
              (nom_zona,nom_oficina,oficina,usuario,cliente,
               fecha)
  values      ( 'ZONA','NOM_OFICINA','OFICINA','USUARIO','NOM_CLIENTE',
                'FECHA')

  insert into cl_rep_anu_orden
              (nom_zona,nom_oficina,oficina,usuario,cliente,
               fecha)
    select
      (select
         of_nombre
       from   cobis..cl_oficina
       where  of_oficina = zona),(select
         of_nombre
       from   cobis..cl_oficina
       where  of_oficina = oficina),oficina,(select
         fu_nombre
       from   cobis..cl_funcionario
       where  fu_login = usuario),(select
         en_nomlar
       from   cobis..cl_ente
       where  en_ente = cliente),
      convert(varchar(10), fecha, 103)
    from   #datos_log

  select
    @w_path_listados = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_archivo = 'cl_rep_anu_orden_' + convert(varchar(4), datepart(yy, @w_fecha
                 )
                 )
                 + convert(varchar(2), datepart(mm, @w_fecha))
                 + convert(varchar(4), datepart(dd, @w_fecha))

  select
    @w_errores = @w_path_listados + @w_archivo + '.err'
  select
    @w_cmd = @w_s_app + 's_app bcp cobis..cl_rep_anu_orden out '
  select
       @w_comando = @w_cmd + @w_path_listados + @w_archivo + '.txt' +
                    ' -b5000 -c -e' + @w_errores +
                    ' -t' + '"' + '|' + '"'
                 + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando Archivo: ' + @w_archivo
    print @w_comando
  end

  return 0

go

