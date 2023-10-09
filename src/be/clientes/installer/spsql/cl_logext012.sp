/************************************************************************/
/*  Archivo:                cl_logext012.sp                             */
/*  Stored procedure:       sp_log_ext012                               */
/*  Base de datos:          cobis                                       */
/*  Producto:       `       Clientes                                    */
/*  Disenado por:           D.Pulido                                    */
/*  Fecha de escritura:     07-Nov-1992                                 */
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
/*  Este programa procesa las transacciones DML de direcciones          */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA           AUTOR         RAZON                                 */
/*  20/Feb/2013     D.Pulido      REQ 349 Extractos costos financieros  */
/*  02/May/2016     DFu           Migracion CEN                         */
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
           where  name = 'sp_log_ext012')
  drop proc sp_log_ext012
go

create proc sp_log_ext012
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_subtipo      char(1) = null,
  @i_tipo         tinyint = null,
  @i_modo         tinyint = null,
  @i_ente         int = null,
  @i_anio         int = null,
  @i_operacion    char (1),
  @i_contador     smallint = null
)
as
  declare
    @w_sp_name   varchar(32),
    @w_nombre    varchar(150),
    @w_criterio  varchar(20),
    @w_fecha_gen datetime,
    @w_usuario   int

  select
    @w_sp_name = 'sp_log_ext012'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'S'
  begin
    select
      'Fecha Generacion' = le_fecha_gen,
      'Usuario' = le_usuario,
      'Oficina' = le_oficina,
      'Desc. Oficina' = (select
                           of_nombre
                         from   cl_oficina
                         where  of_oficina = @s_ofi),
      'Contador' = le_contador
    from   cl_log_ext012
    where  le_fecha_gen = (select
                             max(le_fecha_gen)
                           from   cl_log_ext012
                           where  le_ente = @i_ente
                              and le_anio = @i_anio)
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103117
      /* 'No existe dato solicitado'*/
      return 1
    end
    return 0
  end

  if @i_operacion = 'I'
  begin
    insert into cl_log_ext012
                (le_fecha_gen,le_usuario,le_oficina,le_contador,le_ente,
                 le_anio)
    values      (getdate(),@s_user,@s_ofi,@i_contador + 1,@i_ente,
                 @i_anio)
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103118
      return 1
    end
    return 0
  end

go

