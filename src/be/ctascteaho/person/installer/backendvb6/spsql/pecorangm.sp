/****************************************************************************/
/*     Archivo:     pecorangm.sp                                            */
/*     Stored procedure: sp_corango_ma                                      */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 14-Ene-1997                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
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
/*     Este programa inserta/elimina/actualiza/consulta de productos        */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
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
           where  name = 'sp_corango_ma')
  drop proc sp_corango_ma
go

create proc sp_corango_ma
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint=null,
  @i_rango        tinyint = null,
  @i_tipo_rango   tinyint = null,
  @i_grupo_rango  smallint = null
)
as
  declare
    @w_sp_name     varchar(32),
    @w_tipo_rango  tinyint,
    @w_grupo_rango smallint,
    @w_return      int

  select
    @w_sp_name = 'sp_corango_ma'

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
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_rango = @i_rango
    exec cobis..sp_end_debug
  end

  /* Consulta */
  if @i_operacion = 'S'
  begin
    if @t_trn != 4080
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    set rowcount 15
    select
      '1678' = ra_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1333' = ra_estado
    from   pe_rango
    where  ra_tipo_rango  = @i_tipo_rango
       and ra_grupo_rango = @i_grupo_rango
       and ra_estado      = 'V'
       and ra_rango       > @i_rango
    order  by ra_rango

    set rowcount 0

    return 0
  end

  /* Query */
  if @i_operacion = 'Q'
  begin
    if @t_trn != 4081
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    select
      ra_desde,
      ra_hasta,
      ra_estado
    from   pe_rango
    where  ra_rango       = @i_rango
       and ra_estado      = 'V'
       and ra_tipo_rango  = @i_tipo_rango
       and ra_grupo_rango = @i_grupo_rango

    if @@rowcount = 0
    begin
      /*No existe rango para ese tipo*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351526
      return 351526
    end

    return 0
  end

GO 
