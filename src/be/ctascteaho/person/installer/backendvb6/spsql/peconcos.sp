/****************************************************************************/
/*     Archivo:     peconcos.sp                                             */
/*     Stored procedure: sp_consulta_costos                                 */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa encarga de realizar la consulta de tabla de costos     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    15/DIC/94       G.Calderon    Emision Inicial                         */
/*      JUN/95        J.Gordillo    Personalizacion Bco.Produccion          */
/*    Nov 07 2002     Jorge Galeano Cambia texto medio por base             */
/*    30/Sep/2003     Gloria Rueda  Retornar c¢digos de error               */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consulta_costos')
  drop proc sp_consulta_costos
go

create proc sp_consulta_costos
(
  @s_ssn           int = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_user          varchar(30) = null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,
  @s_rol           smallint,
  @s_org_err       char(1)= null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint=null,
  @t_show_version  bit = 0,
  @i_tipo          char(1)=null,
  @i_modo          tinyint=null,
  @i_servicio_per  smallint =null,
  @i_categoria     char(1)=null,
  @i_tipo_rango    tinyint=null,
  @i_rango         tinyint =null,
  @i_formato_fecha int = 101
)
as
  declare
    @w_sp_name     varchar(32),
    @w_today       datetime,
    @w_grupo_rango smallint,
    @w_return      int

  select
    @w_sp_name = 'sp_consulta_costos',
    @w_today = getdate()

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      i_modo = @i_modo
    exec cobis..sp_end_debug
  end

  /* Consulta */
  if @t_trn != 4052
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  set rowcount 15
  if @i_tipo = 'A'
  begin
    select
      '1063' = a.co_categoria,
      '1759' = substring(tr_descripcion,
                               1,
                               35),
      '1381' = a.co_grupo_rango,
      '1678' = a.co_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1026' = a.co_val_medio,
      '1478' = a.co_minimo,
      '1471' = a.co_maximo,
      /*CHM Y2K */
      /*'FEC. VIGEN.'  = convert(char(10), a.co_fecha_vigencia, 101)*/
      '1355' = convert(char(10), a.co_fecha_vigencia, @i_formato_fecha)
    from   pe_costo a,
           pe_tipo_rango,
           pe_rango
    where  a.co_servicio_per = @i_servicio_per
       and tr_tipo_rango     = a.co_tipo_rango
       and ra_tipo_rango     = a.co_tipo_rango
       and ra_grupo_rango    = a.co_grupo_rango
       and ra_rango          = a.co_rango
       and a.co_fecha_vigencia in
           (select
              max(b.co_fecha_vigencia)
            from   pe_costo b
            where  b.co_servicio_per = a.co_servicio_per
               and b.co_categoria    = a.co_categoria
               and b.co_tipo_rango   = a.co_tipo_rango
               and b.co_grupo_rango  = a.co_grupo_rango
               and b.co_rango        = a.co_rango)
       and a.co_secuencial in
           (select
              max(c.co_secuencial)
            from   pe_costo c
            where  c.co_servicio_per = a.co_servicio_per
               and c.co_categoria    = a.co_categoria
               and c.co_tipo_rango   = a.co_tipo_rango
               and c.co_grupo_rango  = a.co_grupo_rango
               and c.co_rango        = a.co_rango)
       and (a.co_categoria    > @i_categoria
             or (a.co_categoria    = @i_categoria
                 and a.co_rango        > @i_rango))
    order  by a.co_categoria,
              a.co_rango
  end

  if @i_tipo = 'I'
  begin
    select
      '1381' = a.co_grupo_rango,
      '1678' = a.co_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1026' = a.co_val_medio,
      '1478' = a.co_minimo,
      '1471' = a.co_maximo,
      /*CHM Y2K*/
      /*'FEC. VIGEN.'  = convert(char(10), a.co_fecha_vigencia, 101)*/
      '1355' = convert(char(10), a.co_fecha_vigencia, @i_formato_fecha)
    from   pe_costo a,
           pe_rango
    where  a.co_servicio_per = @i_servicio_per
       and ra_tipo_rango     = @i_tipo_rango
       and ra_grupo_rango    = a.co_grupo_rango
       and ra_rango          = a.co_rango
       and a.co_tipo_rango   = @i_tipo_rango
       and a.co_categoria    = @i_categoria
       and a.co_fecha_vigencia in
           (select
              max(b.co_fecha_vigencia)
            from   pe_costo b
            where  b.co_servicio_per = a.co_servicio_per
               and b.co_categoria    = a.co_categoria
               and b.co_tipo_rango   = a.co_tipo_rango
               and b.co_grupo_rango  = a.co_grupo_rango
               and b.co_rango        = a.co_rango)
       and a.co_secuencial in
           (select
              max(c.co_secuencial)
            from   pe_costo c
            where  c.co_servicio_per = a.co_servicio_per
               and c.co_categoria    = a.co_categoria
               and c.co_tipo_rango   = a.co_tipo_rango
               and c.co_grupo_rango  = a.co_grupo_rango
               and c.co_rango        = a.co_rango)
       and a.co_rango        > @i_rango
    order  by a.co_rango
  end

  set rowcount 0
  return 0

GO 
