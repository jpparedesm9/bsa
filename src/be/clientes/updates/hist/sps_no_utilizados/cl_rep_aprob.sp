/************************************************************************/
/*  Archivo:            cl_rep_aprob.sp                                 */
/*  Stored procedure:   sp_rep_aprob                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:                                                       */
/*  Fecha de escritura: Agosto-2010                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Genera reporte de aprobaciones                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_rep_aprob')
  drop proc sp_rep_aprob
go

create proc sp_rep_aprob
(
  @t_show_version bit = 0,
  @i_param1       varchar(10),-- FECHA INICIAL
  @i_param2       varchar(10) -- FECHA FINAL
)
as
  declare
    @w_sp_name   char(30),
    @i_fecha_ini datetime,
    @i_fecha_fin datetime,
    @w_codigo    smallint,
    @w_parlista  varchar(10),
    @w_return    int,
    @w_s_app     varchar(255),
    @w_destino   varchar(255),
    @w_errores   varchar(255),
    @w_comando   varchar(255),
    @w_error     int,
    @w_path_lis  varchar(255),
    @w_ruta      varchar(100),
    @w_archivo   varchar(255)

  select
    @w_sp_name = 'sp_rep_aprob'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha_ini = convert(datetime, @i_param1)
  select
    @i_fecha_fin = convert(datetime, @i_param2)

  select
    @w_path_lis = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  truncate table cobis..cl_rep_aprob

  select
    @w_ruta = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_codigo = codigo
  from   cl_tabla
  where  tabla = 'cl_refinh_sarlaft'

  select
    @w_parlista = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LNRES'

  select
    @w_archivo = 'cl_rep_aprob'

  insert into cobis..cl_rep_aprob
    select
      'Secuencial' = as_sec_refinh,'Ente      ' = en_ente,'Tipo_ID' = as_tipo_id
      ,
      'Descrip_Documento' = (select
                               ct_descripcion
                             from   cobis..cl_tipo_documento
                             where  ct_codigo = as_tipo_id),
      'Número_ID' = as_nro_id,
      'Nombre' = en_nomlar,'Origen' = as_origen_refinh,
      'Descripcion_Origen' = (select
                                valor
                              from   cl_catalogo
                              where  codigo = a.as_origen_refinh
                                 and tabla  = @w_codigo),'Oficina' = en_oficina,
      'Fecha_Referencia' = convert(char(10), as_fecha_refinh, 103),
      'Maneja_Rec_Publico(PEP)' = en_recurso_pub,
      'Influye_Politica(PEP)' = en_influencia,
      'Personaje_Publico(PEP)' = en_persona_pub
    from   cobis..cl_autoriza_sarlaft_lista a,
           cobis..cl_ente
    where  as_aut_sarlaft in ('S', 'N')
       and as_aut_cial in ('S', 'N')
       and as_origen_refinh in
           (select
              ms_origen
            from   cl_manejo_sarlaft
            where  ms_restrictiva = @w_parlista)
       and as_nro_id       = en_ced_ruc
       and as_fecha_refinh >= @i_fecha_ini
       and as_fecha_refinh <= @i_fecha_fin
    order  by as_sec_refinh

  select
    @w_comando = 'echo '
  select
    @w_comando = @w_comando
                 +
'Secuencial;Ente;Tipo_ID;Descrip_Documento;Número_ID;Nombre;Origen;Descripcion_Origen;Oficina;Fecha_Referencia;Maneja_Rec_Publico(PEP);Influye_Politica(PEP);Personaje_Publico(PEP)'
  select
    @w_comando = @w_comando + ' > ' + @w_path_lis + @w_archivo + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo'
    print @w_comando
    return 1
  end

  select
    @w_s_app = 's_app bcp -auto -login cobis..cl_rep_aprob out '
  select
    @w_destino = @w_path_lis + 'temporal.bcp',
    @w_errores = @w_path_lis + @w_archivo + '.err'
  select
    @w_comando =
       @w_s_app + @w_path_lis + 'temporal.bcp' + ' -b5000 -c -e' + @w_errores +
       ' -t";" ' + '-config '+
                 + @w_ruta + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo'
    print @w_comando
    return 1
  end

  select
    @w_comando = 'type ' + @w_path_lis + 'temporal.bcp' + ' >> ' + @w_path_lis +
                 '\'
                              + @w_archivo
                              + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando Archivo: ' + @w_archivo
    print @w_comando
    print @w_error
  end

  return 0

go

