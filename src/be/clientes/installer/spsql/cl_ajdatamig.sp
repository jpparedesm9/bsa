/************************************************************************/
/*      Archivo:                cl_ajdatamig.sp                         */
/*      Stored procedure:       sp_ajusta_datmig                        */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Laguna                             */
/*      Fecha de escritura:     05/01/2009                              */
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
/*    Este programa toma la data de los campos retencion, gran contribu-*/
/*    yente y regimen fiscal para homologar de acuerdo a nuevo catalogo */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
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
           where  name = 'sp_ajusta_datmig')
  drop proc sp_ajusta_datmig
go

create proc sp_ajusta_datmig
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_bandera      tinyint
)
as
  declare
    @w_return        int,
    @w_error         int,
    @w_sp_name       varchar(32),/* NOMBRE STORED PROC */
    @w_ente_ini      int,
    @w_ente_fin      int,
    @w_ente          int,
    @w_retencion     char(1),
    @w_contribuyente char(1)

  /*ASIGNACIONES*/
  select
    @w_sp_name = 'sp_ajusta_datmig'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_bandera = 1
  begin
    select
      @w_ente_ini = 1
    select
      @w_ente_fin = 50000
  end

  if @i_bandera = 2
  begin
    select
      @w_ente_ini = 50001
    select
      @w_ente_fin = 100000
  end

  if @i_bandera = 3
  begin
    select
      @w_ente_ini = 100001
    select
      @w_ente_fin = 150000
  end

  if @i_bandera = 4
  begin
    select
      @w_ente_ini = 150001
    select
      @w_ente_fin = 200000
  end

  if @i_bandera = 5
  begin
    select
      @w_ente_ini = 200001
    select
      @w_ente_fin = 250000
  end

  if @i_bandera = 6
  begin
    select
      @w_ente_ini = 250001
    select
      @w_ente_fin = 300000
  end

  if @i_bandera = 7
  begin
    select
      @w_ente_ini = 300001
    select
      @w_ente_fin = 350000
  end

  if @i_bandera = 8
  begin
    select
      @w_ente_ini = 350001
    select
      @w_ente_fin = 400000
  end

  if @i_bandera = 9
  begin
    select
      @w_ente_ini = 400001
    select
      @w_ente_fin = 450000
  end

  if @i_bandera = 10
  begin
    select
      @w_ente_ini = 450001
    select
      @w_ente_fin = 500000
  end

  if @i_bandera = 11
  begin
    select
      @w_ente_ini = 500001
    select
      @w_ente_fin = 900000
  end

  declare cursor_ajusta_datmig cursor for
    select
      en_ente,
      en_retencion,
      en_gran_contribuyente
    from   cobis..cl_ente
    where  en_ente between @w_ente_ini and @w_ente_fin
       and en_asosciada = "0003"
    order  by en_ente
    for read only

  open cursor_ajusta_datmig

  fetch cursor_ajusta_datmig into @w_ente, @w_retencion, @w_contribuyente

  while (@@fetch_status <> -1)
  begin
    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close cursor_ajusta_datmig
      deallocate cursor_ajusta_datmig
      print 'Aborta ... cursor_ajusta_datmig'
      return 2
    end

    if @w_ente > 0
    begin
      update cobis..cl_ente
      set    en_retencion = 'S',
             en_gran_contribuyente = 'N'
      where  en_ente = @w_ente

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105026
        /* 'Error en actualizacion de persona'*/
        return 1
      end

      goto SIGUIENTE

    end --@w_ente > 0 and @w_hijo > 0   

    ------                 
    SIGUIENTE:
    fetch cursor_ajusta_datmig into @w_ente, @w_retencion, @w_contribuyente
  end -- while 
  close cursor_ajusta_datmig
  deallocate cursor_ajusta_datmig
  return 0
--end

go

