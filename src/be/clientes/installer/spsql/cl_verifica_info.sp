/************************************************************************/
/*  Archivo:          cl_verifica_info.sp                               */
/*  Stored procedure: sp_verifica_info                                  */
/*  Base de datos:    cobis                                             */
/*  Producto:         Clientes                                          */
/*  Disenado por:     Erika Alexandra Alvarez Gomez                     */
/*  Fecha de escritura:     18-FEb-2009                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*     Este programa verifica la informacion del cliente para credito   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA         AUTOR             RAZON                           */
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
           where  name = 'sp_verifica_info')
  drop proc sp_verifica_info
go

create proc sp_verifica_info
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_tramite      int,
  @o_retorno      int output
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_ente        int,
    @w_rol         varchar(10),
    @w_indicador   int,
    @w_valida_ente char(1),
    @w_nom_ente    varchar(254),
    @w_error       int

  select
    @w_sp_name = 'sp_verifica_info'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_indicador = 0,
    @o_retorno = 0

  declare info_deudores cursor for
    select
      de_cliente,
      de_rol
    from   cob_credito..cr_deudores
    where  de_tramite = @i_tramite
    order  by de_cliente
    for read only

  open info_deudores
  /* Localizar el primer registro */
  fetch info_deudores into @w_ente, @w_rol

  -------------------
  --LAZO DEL CURSOR
  -------------------
  while (@@fetch_status = 0)
  begin
    if @@fetch_status = -2
    begin
      close cursor_ente_mig
      deallocate cursor_ente_mig
      /* Error en recuperacion de datos del cursor */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107099
      return 1
    end

    select
      @w_valida_ente = 'N'

    exec @w_error = cobis..sp_ente_bloqueado
      @t_trn       = 175,
      @i_operacion = 'B',
      @i_ente      = @w_ente,
      @o_retorno   = @w_valida_ente output

    if @w_error <> 0
    begin
      goto ERROR
    end

    if @w_valida_ente <> 'N'
    begin
      select
        @w_indicador = 2101052

      select
        @w_nom_ente = en_nomlar
      from   cobis..cl_ente
      where  en_ente = @w_ente

      print 'EL CLIENTE ' + ' ' + convert(varchar(10), @w_ente) + ' ' +
            @w_nom_ente
            + ' NO TIENE ACTUALIZADOS SUS DATOS'
    end

    leer:

    fetch info_deudores into @w_ente, @w_rol

  end

  close info_deudores
  deallocate info_deudores

  select
    @o_retorno = @w_indicador

  return @o_retorno

  ERROR:

  exec cobis..sp_cerror
    @t_debug = 'N',
    @t_file  = null,
    @t_from  = @w_sp_name,
    @i_num   = @w_error
  return @w_error

go

