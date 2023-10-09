/************************************************************************/
/*  Archivo:                archcarg.sp                                 */
/*  Stored procedure:       sp_archivos_cargados                        */
/*  Base de datos:          cobis                                       */
/*  Producto:               MIS                                         */
/*  Disenado por:           Patricia Garzon Rojas                       */
/*  Fecha de escritura:     Diciembre 1999                              */
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
/*  Permite buscar y eliminar datos de la tabla de archivos cargados    */
/*  desde diskette en la migracion de entes                             */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR               RAZON                           */
/*  10Dic99         Patricia Garzon     Emision Inicial                 */
/*  02May16         DFu                 Migracion CEN                   */
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
           where  name = 'sp_archivos_cargados')
  drop proc sp_archivos_cargados
go

create proc sp_archivos_cargados
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_corr         char(1) = null,
  @s_ssn_corr     int = null,
  @s_ofi          smallint = null,
  @s_sesn         int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_archivo      varchar(30) = null,
  @i_archivo_ente varchar(30) = null
)
as
  declare
    @w_sp_name    char(30),
    @w_fecha      datetime,
    @w_secuencial int

  select
    @w_sp_name = 'sp_archivos_cargados'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if (@i_operacion = 'S'
      and @t_trn <> 1394)
      or -- 1280) or
     (@i_operacion = 'D'
      and @t_trn <> 1396)
      or -- 1281) or
     (@i_operacion = 'I'
      and @t_trn <> 1395) --1282)
  begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107098
    return 1
  end

  -- Buscar los datos
  if @i_operacion = 'S'
  begin
    --print 'operacion S'
    set rowcount 20

    select
      'ARCHIVO' = ac_archivo,
      'CARGADO POR' = ac_user,
      'FECHA' = convert(char(10), ac_date, 103)
    from   cl_archivos_cargados_mig
    where  ac_user = @s_user
    set rowcount 0
  end

  -- Eliminar un dato de archivos cargados
  if @i_operacion = 'D'
  begin
    --print '@i_archivo_ente %1!',@i_archivo_ente
    --print '@i_archivo_dire %1!',@i_archivo_dire
    --print '@i_archivo_tele %1!',@i_archivo_tele
    --print '@i_archivo %1!',@i_archivo
    --  print 'operacion D'

    /*Datos para transaccion de servicio*/
    select
      @w_fecha = ac_date,
      @w_secuencial = ac_sesn
    from   cl_archivos_cargados_mig
    where  ac_archivo = @i_archivo
       and ac_user    = @s_user

    delete cl_archivos_cargados_mig
    where  ac_archivo = @i_archivo
       and ac_user    = @s_user

    /*  Transaccion de Servicio  */
    insert into ts_archivos_cargados_mig
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,archivo,usuario2,
                 fecha2,secuencial2)
    values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_archivo,@s_user,
                 @w_fecha,@w_secuencial)

    if @@error <> 0
    begin
      /*  Error en creacion de transaccion de servicio  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

  end

  -- Ingresar los datos del archivo cargado
  if @i_operacion = 'I'
  begin
    --print '@i_archivo_ente %1!',@i_archivo_ente
    --print '@i_archivo_dire %1!',@i_archivo_dire
    --print '@i_archivo_tele %1!',@i_archivo_tele

    insert into cl_archivos_cargados_mig
                (ac_archivo,ac_user,ac_date,ac_sesn)
    values      (@i_archivo_ente,@s_user,@s_date,@s_sesn)

    /*  Transaccion de Servicio  */
    insert into ts_archivos_cargados_mig
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,archivo,usuario2,
                 fecha2,secuencial2)
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_archivo_ente,@s_user,
                 @s_date,@s_sesn)

    if @@error <> 0
    begin
      /*  Error en creacion de transaccion de servicio  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

  end
  return 0

go

