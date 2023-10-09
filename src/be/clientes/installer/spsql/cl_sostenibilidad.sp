/************************************************************************/
/*     Archivo:                   sostenibilidad.sp                     */
/*     Stored procedure:          sp_sostenibilidad                     */
/*     Base de Datos:             cobis                                 */
/*     Producto:                  Clientes                              */
/*     Disenado por:              Edwin Rodriguez                       */
/************************************************************************/
/*                         IMPORTANTE                                   */
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
/*                         PROPOSITO                                    */
/*     Generar procedimiento de Creaci¢n, Actualizaci¢n y Consulta      */
/*     para detalles de Sostenibilidad                                  */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*      FECHA          AUTOR               RAZON                        */
/*     22/Nov/2012    Edwin Rodriguez     Emision inicial               */
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
           where  name = 'sp_sostenibilidad')
  drop proc sp_sostenibilidad
go

create proc sp_sostenibilidad
(
  @s_ssn              int = null,
  @s_date             datetime = null,
  @s_user             login = null,
  @s_term             descripcion = null,
  @s_ofi              smallint = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_sesn             int = null,
  @t_rty              char(1) = null,
  @t_trn              smallint = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(14) = null,
  @t_from             varchar(30) = null,
  @t_show_version     bit = 0,
  @i_cliente          int = null,
  @i_viv_mat          catalogo = null,
  @i_viv_comb         catalogo = null,
  @i_viv_dorm         int = null,
  @i_viv_conforman    int = null,
  @i_viv_aportan      int = null,
  @i_edu_financiera   catalogo = null,
  @i_grupo_etnico     catalogo = null,
  @i_viv_serv_pub     varchar(10) = null,
  @i_viv_vias_llegar  varchar(10) = null,
  @i_viv_equipo       varchar(10) = null,
  @i_viv_tema_tratado varchar(10) = null,
  @i_operacion        char(1) = null,
  @i_tpersona         int = null
)
as
  declare
    /*Secci¢n de Variable s de Trabajo*/
    @w_existe         char(1),/* CARACTER QUE VALIDA LA EXISTENCIA*/
    @w_return         int,/* VALOR QUE RETORNA       */
    @w_sp_name        varchar(32),/* NOMBRE STORED PROCEDURE */
    @w_msg            varchar(200),
    @w_fecha_modif    datetime,
    @w_error          int,
    @w_viv_comb       varchar(30),
    @w_viv_mat        varchar(30),
    @w_edu_financiera varchar(30),
    @w_grupo_etnico   varchar(30),
    @w_parametro      varchar(30)
  /**/
  select
    @w_sp_name = 'sp_sostenibilidad',
    @w_fecha_modif = getdate()

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if exists (select
               1
             from   cl_sostenibilidad
             where  so_cliente = @i_cliente)
  begin
    select
      @w_existe = 'S'
  end
  else
  begin
    select
      @w_existe = 'N'
  end

  if @i_operacion = 'I'
  begin
    if @t_trn <> 1600
    begin
      select
        @w_return = 101183,
        @w_msg =
      'NO CORRESPONDE CODIGO DE TRANSACCION DE INSERCION DE SOSTENIBILIDAD'
      goto ERROR_FIN
    end

    if @w_existe = 'S'
    begin
      select
        @w_return = 103104
      goto ERROR_FIN
    end

    else
    begin
      --Cambio para envio a dispositivos moviles
      select
        @i_viv_serv_pub = replace((replace(@i_viv_serv_pub,
                                           '1',
                                           'X')),
                                  '0',
                                  ' ')
      select
        @i_viv_vias_llegar = replace((replace(@i_viv_vias_llegar,
                                              '1',
                                              'X')),
                                     '0',
                                     ' ')
      select
        @i_viv_equipo = replace((replace(@i_viv_equipo,
                                         '1',
                                         'X')),
                                '0',
                                ' ')
      select
        @i_viv_tema_tratado = replace((replace(@i_viv_tema_tratado,
                                               '1',
                                               'X')),
                                      '0',
                                      ' ')

      exec @w_return = sp_sostenibilidad_log
        @s_user             = @s_user,
        @i_cliente          = @i_cliente,
        @i_viv_mat          = @i_viv_mat,
        @i_viv_comb         = @i_viv_comb,
        @i_viv_dorm         = @i_viv_dorm,
        @i_viv_conforman    = @i_viv_conforman,
        @i_viv_aportan      = @i_viv_aportan,
        @i_edu_financiera   = @i_edu_financiera,
        @i_grupo_etnico     = @i_grupo_etnico,
        @i_viv_serv_pub     = @i_viv_serv_pub,
        @i_viv_vias_llegar  = @i_viv_vias_llegar,
        @i_viv_equipo       = @i_viv_equipo,
        @i_viv_tema_tratado = @i_viv_tema_tratado,
        @i_fecha_modif      = @w_fecha_modif

      if @w_return <> 0
        goto ERROR_FIN
      insert into cobis..cl_sostenibilidad
                  (so_cliente,so_viv_mat,so_viv_comb,so_viv_dorm,
                   so_viv_conforman,
                   so_viv_aportan,so_edu_financiera,so_grupo_etnico,
                   so_viv_serv_pub,
                   so_viv_vias_llegar,
                   so_viv_equipo,so_viv_tema_tratado,so_fecha_modif)
      values      ( @i_cliente,@i_viv_mat,@i_viv_comb,@i_viv_dorm,
                    @i_viv_conforman
                    ,
                    @i_viv_aportan,@i_edu_financiera,null,
                    --@i_grupo_etnico,
                    null,null,
                    @i_viv_equipo,@i_viv_tema_tratado,@w_fecha_modif)

      if @@error <> 0
      begin
        select
          @w_return = 103108
        goto ERROR_FIN /* Error al ingresar el registro en Sostenibilidad */
      end
    end
  end

  if @i_operacion = 'U'
  begin
    if @t_trn <> 1601
    begin
      select
        @w_return = 101183,
        @w_msg =
        'NO CORRESPONDE CODIGO DE TRANSACCION DE MODIFICACION DE SOSTENIBILIDAD'
      goto ERROR_FIN
    end

    if @w_existe = 'N'
       and @i_tpersona = '001'
    begin
      select
        @w_return = 103105
      goto ERROR_FIN
    end
    else
    begin
      --Cambio para envio a dispositivos moviles
      select
        @i_viv_serv_pub = null
      --replace((replace(@i_viv_serv_pub, '1', 'X')),  '0', ' ')
      select
        @i_viv_vias_llegar = null
      --replace((replace(@i_viv_vias_llegar, '1', 'X')),  '0', ' ')
      select
        @i_viv_equipo = replace((replace(@i_viv_equipo,
                                         '1',
                                         'X')),
                                '0',
                                ' ')
      select
        @i_viv_tema_tratado = replace((replace(@i_viv_tema_tratado,
                                               '1',
                                               'X')),
                                      '0',
                                      ' ')

      exec @w_return = sp_sostenibilidad_log
        @s_user             = @s_user,
        @i_cliente          = @i_cliente,
        @i_viv_mat          = @i_viv_mat,
        @i_viv_comb         = @i_viv_comb,
        @i_viv_dorm         = @i_viv_dorm,
        @i_viv_conforman    = @i_viv_conforman,
        @i_viv_aportan      = @i_viv_aportan,
        @i_edu_financiera   = @i_edu_financiera,
        @i_grupo_etnico     = @i_grupo_etnico,
        @i_viv_serv_pub     = @i_viv_serv_pub,
        @i_viv_vias_llegar  = @i_viv_vias_llegar,
        @i_viv_equipo       = @i_viv_equipo,
        @i_viv_tema_tratado = @i_viv_tema_tratado,
        @i_fecha_modif      = @w_fecha_modif

      if @w_return <> 0
        goto ERROR_FIN

      update cobis..cl_sostenibilidad
      set    so_viv_mat = @i_viv_mat,
             so_viv_comb = @i_viv_comb,
             so_viv_dorm = @i_viv_dorm,
             so_viv_conforman = @i_viv_conforman,
             so_viv_aportan = @i_viv_aportan,
             so_edu_financiera = @i_edu_financiera,
             so_grupo_etnico = @i_grupo_etnico,
             so_viv_serv_pub = @i_viv_serv_pub,
             so_viv_vias_llegar = @i_viv_vias_llegar,
             so_viv_equipo = @i_viv_equipo,
             so_viv_tema_tratado = @i_viv_tema_tratado,
             so_fecha_modif = @w_fecha_modif
      where  so_cliente = @i_cliente

      if @@error <> 0
      begin
        select
          @w_return = 103109
        goto ERROR_FIN /* Error al Modificar el registro en Sostenibilidad */
      end
    end
  end

  if @i_operacion = 'Q'
     and @i_tpersona = '001'
  begin
    if @t_trn <> 1602
    begin
      select
        @w_return = 101183,
        @w_msg =
      'NO CORRESPONDDE CODIGO DE TRANSACCION DE CONSULTA DE SOSTENIBILIDAD'
      goto ERROR_FIN
    end
    if @w_existe = 'N'
    begin
      select
        @w_return = 103105
      goto ERROR_FIN
    end
    else
    begin
      select
        @w_viv_comb = b.valor
      from   cobis..cl_tabla a,
             cl_catalogo b,
             cobis..cl_sostenibilidad
      where  b.tabla    = a.codigo
         and a.tabla    = 'cl_tipo_combustible'
         and b.codigo   = so_viv_comb
         and so_cliente = @i_cliente

      select
        @w_viv_mat = b.valor
      from   cobis..cl_tabla a,
             cl_catalogo b,
             cobis..cl_sostenibilidad
      where  b.tabla    = a.codigo
         and a.tabla    = 'cl_tipo_material'
         and b.codigo   = so_viv_mat
         and so_cliente = @i_cliente

      select
        @w_edu_financiera = b.valor
      from   cobis..cl_tabla a,
             cl_catalogo b,
             cobis..cl_sostenibilidad
      where  b.tabla    = a.codigo
         and a.tabla    = 'cl_tiempo_edu_finan'
         and b.codigo   = so_edu_financiera
         and so_cliente = @i_cliente

      select
        @w_grupo_etnico = b.valor
      from   cobis..cl_tabla a,
             cl_catalogo b,
             cobis..cl_sostenibilidad
      where  b.tabla    = a.codigo
         and a.tabla    = 'cl_grupo_etnico'
         and b.codigo   = so_grupo_etnico
         and so_cliente = @i_cliente

      select
        so_viv_mat,
        so_viv_comb,
        so_viv_dorm,
        so_viv_conforman,
        so_viv_aportan,
        so_edu_financiera,
        null,--so_grupo_etnico ,
        null,--replace((replace(so_viv_serv_pub,'X','1')),' ', '0'),
        null,--replace((replace(so_viv_vias_llegar,'X','1')),' ', '0'),
        replace((replace(so_viv_equipo,
                         'X',
                         '1')),
                ' ',
                '0'),
        replace((replace(so_viv_tema_tratado,
                         'X',
                         '1')),
                ' ',
                '0'),
        so_fecha_modif,
        @w_viv_mat,
        @w_viv_comb,
        @w_edu_financiera,
        @w_grupo_etnico
      from   cobis..cl_sostenibilidad
      where  so_cliente = @i_cliente

      if @@error <> 0
      begin
        select
          @w_return = 103110
        goto ERROR_FIN /* Error al Consultar el registro en Sostenibilidad */
      end
    end
  end
  return 0

  ERROR_FIN:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_return,
    @i_msg   = @w_msg
  /*  'No corresponde codigo de transaccion' */
  return @w_return

go

