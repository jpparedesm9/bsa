/************************************************************************/
/*  Archivo:            errormic.sp                                     */
/*  Stored procedure:       sp_cerror_mig_cl                            */
/*  Base de datos:      cobis                                           */
/*  Producto:               MIS                                         */
/*  Disenado por:           Patricia Garzon Rojas                       */
/*  Fecha de escritura:     Noviembre 1999                              */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*      Ingresa datos a la tabla de errores de migracion                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  09Nov99         Patricia Garzon Emision Inicial                     */
/*  14/Dic/2000     E. Laguna       Cracion Masiva - Bantequendama      */
/*  04/May/2016     T. Baidal       Migracion a CEN                     */
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
           where  name = 'sp_cerror_mig_cl') 
              drop proc sp_cerror_mig_cl
go

create proc sp_cerror_mig_cl
(
  @s_user         login,
  @s_sesn         int,
  @s_date         datetime,
  @s_ssn          int = null,
  @s_term         varchar(30) = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_msg          varchar(255) = null,
  @i_sp           varchar(30) = null,
  @i_secuencia    int = null,
  @i_modo         tinyint = null,
  @i_er_num       int = null,
  @i_tm_sp        varchar(30) = null,
  @i_tm_archivo   varchar(30) = null,
  @i_operacion    char(1)
)
as
  declare
    @w_num     int,
    @w_sp_name char(30)

  select
    @w_sp_name = 'sp_cerror_mig_cl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ejlr Dic 20/2000 Bantequendama creacion masiva
     if (@t_trn <> 1284) */

  if (@t_trn <> 1391)
  begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 1901006
    return 1
  end

  if @i_operacion = 'I'
  begin
    select
      @w_num = max(er_num)
    from   cobis..cl_error_mig
    where  er_user = @s_user
       and er_sesn = @s_sesn
       and er_date = @s_date

    if @w_num is null
      select
        @w_num = 0
    else
      select
        @w_num = @w_num + 1

    -- Insertar el error
    --   print ' secuencial  %1! ', @i_secuencia
    insert into cl_error_mig
                (er_user,er_sesn,er_date,er_num,er_msg,
                 er_sp,er_secuencia)
    values      (@s_user,@s_sesn,@s_date,@w_num,@i_msg,
                 @i_sp,@i_secuencia)
  end

  /*  Transaccion de Servicio  */
  insert into ts_error_mig
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,usuario2,secuencial2,
               fecha2,codigo,observacion,secuecia,sp)
  values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
               @s_term,@s_srv,@s_lsrv,@s_user,@s_sesn,
               @s_date,@w_num,@i_msg,@i_secuencia,@i_sp)

  if @@error != 0
  begin
    /*  Error en creacion de transaccion de servicio  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 103005
    return 1
  end

  if @i_operacion = 'A'
  begin
    -- Insertar el tiempo
    insert into cl_tiempo_mig
                (tm_archivo,tm_date,tm_sp,tm_user,tm_sesn)
    values      (@i_tm_archivo,getdate(),@i_tm_sp,@s_user,@s_sesn)

  end

  if @i_operacion = 'S'
  begin
    set rowcount 20
    --print ' @i_modo %1! ', @i_modo
    if @i_modo = 0
    begin
      select
        'NUMERO' = er_num,
        'SECUENCIA' = er_secuencia,
        'MENSAJE' = er_msg,
        'PROGRAMA' = er_sp
      from   cobis..cl_error_mig
      where  er_user = @s_user
         and er_date = @s_date
         and er_sesn = @s_sesn
    end
    if @i_modo = 1
    --   print ' @i_er_num %1! ', @i_er_num
    begin
      select
        'NUMERO' = er_num,
        'SECUENCIA' = er_secuencia,
        'MENSAJE' = er_msg,
        'PROGRAMA' = er_sp
      from   cobis..cl_error_mig
      where  er_user = @s_user
         and er_date = @s_date
         and er_sesn = @s_sesn
         and er_num  > @i_er_num
    end
  end

go

