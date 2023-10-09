/************************************************************************/
/*  Archivo:                blncetmp.sp                                 */
/*  Stored procedure:       sp_balance_tmp                              */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Sandra Ortiz                                */
/*  Fecha de escritura:     09-Sep-1993                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Realiza la creacion de balances financieros de empresas             */
/*  clientes del banco (en una tabla temporal:cl_balance_tmp)           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  09-Sep-1993     S Ortiz         Emision inicial                     */
/*  18/Nov/93       R. Minga V.     insercion en tabla temporal         */
/*  09/May/93       R. Minga V.     reconocimiento de usuario           */
/*                                  para evitar conflictos              */
/*  30/Mar/95       Bco. Prestamos  Req. del Banco                      */
/*  25/Nov/96       Bco. del Estado Ocultar el campo ano.               */
/*  05/Ago/2004     E. Laguna       Tunning                             */
/*  May/02/2016     DFu             Migracion CEN                       */
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
           where  name = 'sp_balance_tmp')
  drop proc sp_balance_tmp
go

create proc sp_balance_tmp
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
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cliente      int = null,
  @i_tbalance     char(3) = null,
  @i_anio         smallint = null,
  @i_clase_ba     char(1) = null,
  @i_fecha_corte  datetime = null,
  @i_secuencial   int = null,
  @i_trn_ext      char(1) = 'N'
)
as
  declare
    @w_sp_name    varchar(30),
    @w_return     int,
    @w_fecha_nac  datetime,
    @w_fecha_cons datetime,
    @w_tipo       char(1),
    @w_error      int

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_balance_tmp'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1166
  begin
    /* Verificar que exista el cliente */
    select
      @w_fecha_cons = c_fecha_const,
      @w_fecha_nac = p_fecha_nac,
      @w_tipo = en_subtipo
    from   cl_ente
    where  en_ente = @i_cliente

    if @@rowcount = 0
    begin
      /*  No existe cliente  */
      select
        @w_error = 101146
      goto ERROR
    end

    /* verificar que exista el tipo de balance */
    if not exists (select
                     1
                   from   cobis..cl_tbalance
                   where  tb_tbalance = @i_tbalance)
      if @w_return <> 0
      begin
        /*  No existe Tipo de Balance  */
        select
          @w_error = 101125
        goto ERROR
      end
    if @w_tipo = 'P'
      if @w_fecha_nac >= @i_fecha_corte
      begin
        select
          @w_error = 107093
        goto ERROR
      end

    if @w_tipo = 'C'
      if (@w_fecha_cons >= @i_fecha_corte)
      begin
        select
          @w_error = 107079
        goto ERROR
      end

    begin tran

    /* borrar los datos anteriores de las tablas temporales (para el usuario actual) */

    delete cl_balance_tmp
    where  ba_user = @s_user
       and ba_term = @s_term

    delete cl_plan_tmp
    where  pl_user = @s_user
       and pl_term = @s_term

    /* insertar los nuevos datos */
    insert into cl_balance_tmp
                (ba_tbalance,ba_cliente,ba_anio,ba_user,ba_term,
                 ba_clase,ba_fecha_corte)
    values      (@i_tbalance,@i_cliente,@i_anio,@s_user,@s_term,
                 @i_clase_ba,@i_fecha_corte)

    if @@error <> 0
    begin
      /*  Error en insercion en tabla temporal de Balance  */
      select
        @w_error = 103075
      goto ERROR
    end

    /*  Transaccion de Servicio  */
    insert into ts_balance_tmp
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,tbalance,cliente,
                 anio,usuario2,term,clase2,fecha_corte,
                 alterno)
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_tbalance,@i_cliente,
                 @i_anio,@s_user,@s_term,@i_clase_ba,@i_fecha_corte,
                 @i_secuencial)

    if @@error <> 0
    begin
      /*  Error en creacion de transaccion de servicio  */
      select
        @w_error = 103005
      goto ERROR
    end
    commit tran
    return 0
  end
  else
  begin
    select
      @w_error = 151051
    goto ERROR
  end
  ERROR:
  if @i_trn_ext = 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error

    return @w_error
  end
  else
    return @w_error

go

