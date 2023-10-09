/************************************************************************/
/*  Archivo:            cl_sostenibilidad_log.sp                        */
/*  Stored procedure:   sp_sostenibilidad_log                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Edwin Rodriguez                                 */
/*  Fecha de escritura: 23/Nov/2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Reprocesar ordenes de consulta externas                             */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA               AUTOR               RAZON                       */
/*  26/Nov/2012        Edwin Rodriguez     Emision inicial              */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
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
           where  name = 'sp_sostenibilidad_log')
  drop proc sp_sostenibilidad_log
go

create proc sp_sostenibilidad_log
(
  @s_user             varchar(30) = null,
  @t_show_version     bit = 0,
  @i_cliente          int = null,
  @i_viv_mat          catalogo = null,
  @i_viv_comb         catalogo = null,
  @i_viv_dorm         int = null,
  @i_viv_conforman    int = null,
  @i_viv_aportan      int = null,
  @i_edu_financiera   catalogo = null,
  @i_grupo_etnico     catalogo = null,
  @i_viv_serv_pub     varchar(20) = null,
  @i_viv_vias_llegar  varchar(20) = null,
  @i_viv_equipo       varchar(20) = null,
  @i_viv_tema_tratado varchar(20) = null,
  @i_fecha_modif      datetime = null
)
as
  declare
    @w_sp_name           varchar(32),
    @w_nombre_campo      varchar(20),
    @w_nombre_tabla_Orig varchar(20),
    @w_nombre_tabla_Nuev varchar(20),
    @w_comando           varchar (255),
    @w_error             int,
    @w_cedula            int,
    @w_nombre            varchar(60)

  select
    @w_sp_name = 'sp_sostenibilidad_log'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_nombre_tabla_Orig = 'cl_sostenibilidad'
  select
    @w_nombre_tabla_Nuev = '#Pantalla'

  select
    *
  into   #Pantalla
  from   cl_sostenibilidad
  where  1 = 2

  insert into #Pantalla
  values      (@i_cliente,@i_viv_mat,@i_viv_comb,@i_viv_dorm,@i_viv_conforman,
               @i_viv_aportan,@i_edu_financiera,@i_grupo_etnico,@i_viv_serv_pub,
               @i_viv_vias_llegar,
               @i_viv_equipo,@i_viv_tema_tratado,@i_fecha_modif)

  select
    Tabla=a.name,
    Campo=b.name,
    Valor_Orig = convert(varchar(30), ''),
    Valor_Nuevo = convert(varchar(30), ''),
    'Procesada'= convert(varchar(30), 'N')
  into   #cambios
  from   sysobjects a,
         syscolumns b
  where  a.name = @w_nombre_tabla_Orig
     and a.id   = b.id
  select
    *
  from   #cambios

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_nombre_campo = Campo
    from   #cambios
    where  Tabla     = @w_nombre_tabla_Orig
       and Procesada = 'N'

    if @@rowcount > 0
    begin
      select
        @w_comando = 'update #cambios ' +
                     'set Valor_Orig = convert(varchar(30), '
                     +
                            @w_nombre_campo
                     + '), Procesada  = ' + '''S''' + ' from ' +
                     @w_nombre_tabla_Orig
                     +
                            ' where Campo = ' + ''''
                     + @w_nombre_campo + '''' + ' and so_cliente = ' + cast (
                     @i_cliente
                            as varchar)
      select
        isnull(@w_comando,
               'Error en CADENA DE EJECUCION ORIGINAL')
      exec @w_error = sp_sqlexec
        @w_comando

      if @w_error <> 0
        goto ERROR

      select
        @w_comando = 'update #cambios ' +
                     'set Valor_Nuevo = convert(varchar(30), '
                     +
                                           @w_nombre_campo
                     + '), Procesada  = ' + '''S''' + ' from ' +
                     @w_nombre_tabla_Nuev
                     +
                                           ' where Campo = ' + ''''
                     + @w_nombre_campo + ''''
      select
        isnull(@w_comando,
               'Error en CADENA DE EJECUCION NUEVA')
      exec @w_error = sp_sqlexec
        @w_comando

      if @w_error <> 0
        goto ERROR

    end
    else
    begin
      set rowcount 0
      break
    end
  end

  select
    @w_cedula = en_ced_ruc,
    @w_nombre = en_nombre
  from   cobis..cl_ente
  where  en_ente = @i_cliente

  insert into cl_sostenibilidad_log
    select
      cs_cliente = @i_cliente,cs_ced_ruc = @w_cedula,cs_nom_cliente = @w_nombre,
      cs_nom_campo = Campo,cs_valor_anterior = case Valor_Orig
                            when '' then 'Ninguno'
                            when null then 'Ninguno'
                            else Valor_Orig
                          end,
      cs_valor_actual = Valor_Nuevo,cs_fecha_actualizacion = @i_fecha_modif,
      cs_usuario = @s_user
    from   #cambios

  return 0

  ERROR:
  select
    @w_error
  set rowcount 0

go

