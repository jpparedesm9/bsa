/************************************************************************/
/*      Archivo:                cl_incliext.sp                          */
/*      Stored procedure:       sp_invoca_masivo_cliext                 */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Saira Molano                            */
/*      Fecha de escritura:     20/Dic/2011                             */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      BATCH:  Cursor que lee las tablas ex_ente y ex_instancia de la  */
/*              BD cob_externo y carga en cl_ente y cl_instancia        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      20/12/2011      SMolano         Emision Inicial                 */
/*      02/05/2016      DFu             Migracion CEN                   */
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
           where  name = 'sp_invoca_masivo_cliext')
  drop proc sp_invoca_masivo_cliext
go

create proc sp_invoca_masivo_cliext
(
  @t_show_version bit = 0,
  @i_param1       varchar(255),-- Fecha Inicio,
  @i_param2       varchar(255) -- Tipo Cliente
)
as
  declare
    @i_fecha    datetime,
    @i_tipo_per char(3),
    @w_sp_name  varchar(64),
    @w_total    int,
    @w_sec      int,
    @w_subtipo  char(1),
    @w_count    int,
    @w_error    int

  select
    @w_sp_name = 'sp_invoca_masivo_cliext'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Captura del nombre del Stored Procedure
  select
    @i_fecha = convert(datetime, @i_param1),
    @i_tipo_per = @i_param2

  truncate table cl_sub_tipo

  select
    @w_count = count(1)
  from   cob_externos..ex_ente

  if @w_count = 0
  begin
    print 'sp_invoca_masivo_cliext   No hay data cargada para procesar'
    return 105146
  end

  insert into cl_sub_tipo
    select
      en_subtipo
    from   cob_externos..ex_ente
    group  by en_subtipo

  select
    @w_total = max(en_secuencia)
  from   cobis..cl_sub_tipo

  if @w_total = 0
      or @w_total is null
  begin
    print
'sp_invoca_masivo_cliext   el valor del subtipo de cliente es obligatorio, no se proceso ningun registro'
  return 105147
end

  set rowcount 1
  select
    @w_sec = en_secuencia
  from   cobis..cl_sub_tipo
  order  by en_secuencia

  while @w_sec <= @w_total
  begin
    select
      @w_subtipo = en_subtipo
    from   cobis..cl_sub_tipo
    order  by en_secuencia

    --Invoca proceso masivo creacion de clientes
    exec @w_error = sp_carga_masivo_cliext
      @i_param1 = @i_fecha,-- Fecha Inicio
      @i_param2 = @i_tipo_per,-- Tipo Cliente 
      @i_param3 = @w_subtipo -- Tipo Persona

    if @w_error <> 0
        or @@error <> 0
    begin
      exec sp_errorlog
        @i_fecha     = @i_fecha,
        @i_error     = @w_error,
        @i_usuario   = 'batch',
        @i_tran      = 132,
        @i_tran_name = @w_sp_name,
        @i_cuenta    = @i_tipo_per,
        @i_rollback  = 'N'
      return @w_error
    end

    set rowcount 1
    select
      @w_sec = en_secuencia
    from   cobis..cl_sub_tipo
    where  en_secuencia > @w_sec
    order  by en_secuencia

    if @@rowcount = 0
      select
        @w_sec = @w_total + 1

    set rowcount 0
  end

  return 0

go

