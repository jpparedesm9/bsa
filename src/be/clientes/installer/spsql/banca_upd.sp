/************************************************************************/
/*      Archivo:                banca_upd.sp                            */
/*      Stored procedure:       sp_actualiza_banca                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Johana Laguna R.                   */
/*      Fecha de escritura:     28-Sep-2001                             */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*    Este programa realiza la actualizacion del campo en_banca de la   */
/*    tabla cl_ente colocando el valor del sector que tiene el gerente  */
/*    asignado  -- La salida de este sp genera el ente que se actualiza */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    28/Sep/2001     E. Laguna        Emision Inicial                  */
/*    May/02/2016     DFu              Migracion CEN                    */
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
           where  name = 'sp_actualiza_banca')
  drop proc sp_actualiza_banca
go

create proc sp_actualiza_banca
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = 'consola',
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
  @t_trn          smallint = null,
  @t_show_version bit = 0
)
as
  declare
    /** GENERALES **/
    @w_return        int,
    @w_error         int,
    @w_parametro     money,
    @w_sp_name       descripcion,
    @w_ente          int,
    @w_oficial       smallint,
    @w_sector        catalogo,
    @w_banca         catalogo,
    @w_fecha_proceso datetime,
    @w_ente_aux      int

  select
    @w_sp_name = 'sp_actualiza_banca'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_ente_aux = 0

  select
    @w_fecha_proceso = fp_fecha
  from   ba_fecha_proceso

  /** LECTURA DE EMBARGOS PENDIENTES **/
  declare cursor_bancaupd cursor for
    select
      en_ente,
      en_oficial,
      en_banca,
      oc_sector
    from   cl_ente,
           cc_oficial
    where  en_oficial = oc_oficial
       and oc_oficial <> 815
       and en_banca is null
       and en_subtipo = oc_sector

  open cursor_bancaupd

  fetch cursor_bancaupd into @w_ente, @w_oficial, @w_banca, @w_sector

  while @@fetch_status <> -1
  begin
    if (@@fetch_status = -2)
    begin
      select
        @w_error = 143049
    --      goto ERROR
    end

    begin tran

    update cobis..cl_ente
    set    en_banca = @w_sector
    where  en_ente = @w_ente

    print 'Ente que se actualizo la banca ' + @w_ente

    /*ERROR:
        
        exec sp_errorlog
        @i_fecha         = @w_fecha_proceso,
        @i_error         = @w_error,
        @i_usuario       = 'misbatch',
        @i_tran          = 1423,
        @i_tran_name     = @w_sp_name,
        @i_cuenta        = @w_ente,
        @i_descripcion    
        @i_rollback      = 'S' 
        while @@trancount > 0 rollback tran
        goto SIGUIENTE*/

    commit tran

    /* SIGUIENTE:
     select @w_ente_aux = @w_ente*/

    fetch cursor_bancaupd into @w_ente, @w_oficial, @w_banca, @w_sector

  end /** cursor_bancaupd **/
  close cursor_bancaupd
  deallocate cursor_bancaupd

  return 0

go

