/****************************************************************************/
/*     Archivo           : pe_mercado.sp                                    */
/*     Stored procedure  : sp_mercado                                       */
/*     Base de datos     : cob_remesas                                      */
/*     Producto          : Personalizacion                                  */
/*     Disenado por      :                                                  */
/*     Fecha de escritura: 02-Ene-1994                                      */
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
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    30/Sep/2003    Gloria Rueda   Retornar c¢digos de error               */
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
           where  name = 'sp_mercado')
  drop proc sp_mercado
go

create proc sp_mercado
(
  @s_ssn           int,
  @s_srv           varchar(30)=null,
  @s_lsrv          varchar(30)=null,
  @s_user          varchar(30)=null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char (1),
  @s_ofi           smallint,
  @s_rol           smallint =1,
  @s_org_err       char(1)=null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1)='N',
  @t_file          varchar(14)=null,
  @t_from          varchar(32)=null,
  @t_rty           char(1)='N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_modo          tinyint = null,
  @i_tipo_ente     char(1) = null,
  @i_estado        char (1) = null,
  @i_mercado       smallint = null,
  @i_cod_prod      smallint = 0,
  @i_formato_fecha int = 101
)
as
  declare
    @w_sp_name  varchar(32),
    @w_return   int,
    @w_fecha    datetime,
    @w_pro_ente int /*secuencial*/

  select
    @w_sp_name = 'sp_mercado',
    @w_fecha = getdate()

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
      'sp_mercado' = @w_sp_name
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_mercado = @i_mercado,
      i_cod_prod = @i_cod_prod,
      i_tipo_ente = @i_tipo_ente,
      i_estado = @i_estado

    exec cobis..sp_end_debug
  end
/*Operaciones */
  /**Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn != 4004
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if not exists(select
                    *
                  from   pe_pro_bancario
                  where  pb_pro_bancario = @i_cod_prod)
    begin
      /*no existe producto bancario asociado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351508
      return 351508
    end

    if exists (select
                 *
               from   pe_mercado
               where  me_pro_bancario = @i_cod_prod
                  and me_tipo_ente    = @i_tipo_ente
                  and me_estado       = @i_estado)
    begin
      /*Ya existe mercado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351517
      return 351517
    end
    begin tran
    /*Encontramos el secuencial para el producto bancario ente */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_mercado',
      @o_siguiente = @w_pro_ente out
    if @w_return != 0
      return @w_return

    /*Insertar un nuevo producto ente*/
    insert into pe_mercado
                (me_pro_bancario,me_tipo_ente,me_mercado,me_estado,
                 me_fecha_estado
    )
    values      (@i_cod_prod,@i_tipo_ente,@w_pro_ente,@i_estado,@w_fecha)
    /*Ocurrio un error en la insercion de mercado*/
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353505
      return 353505
    end
    commit tran
    select
      @w_pro_ente

    return 0
  end

  /**ACTUALIZACION**/
  if @i_operacion = 'U'
  begin
    if @t_trn != 4005
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    if not exists(select
                    *
                  from   pe_pro_bancario
                  where  pb_pro_bancario = @i_cod_prod)
    begin
      /*no existe producto bancario asociado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351508
      return 351508
    end

    if exists (select
                 *
               from   pe_mercado
               where  me_pro_bancario = @i_cod_prod
                  and me_tipo_ente    = @i_tipo_ente
                  and me_estado       = @i_estado)
    begin
      /*Ya existe mercado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351517
      return 351517
    end

    /**ACTUALIZACION DEL ESTADO EN LA TABLA DE SERVICIOS BASICOS **/

    begin tran
    update pe_basico
    set    ba_estado = @i_estado
    where  ba_mercado = @i_mercado
    if @@error != 0
    /*error en actualizacion de servicio basico*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355504
      return 355504
    end

    /**ACTUALIZACION EN LA TABLA DE MERCADO **/
    update pe_mercado
    set    me_estado = @i_estado,
           me_fecha_estado = @w_fecha
    where  me_pro_bancario = @i_cod_prod
       and me_tipo_ente    = @i_tipo_ente
    if @@error != 0
    /*error en actualizacion de mercado*/
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355505
      return 355505
    end
    commit tran
    return 0
  end

  /**BUSQUEDA **/

  if @i_operacion = 'S'
  begin
    if @t_trn != 4006
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15
    select
      '1475' = me_mercado,
      '1647' = me_pro_bancario,
      '1195' = substring(pb_descripcion,
                                               1,
                                               35),
      /* CHM Y2K */
      /*'FECHA DE ESTADO' = convert(char(10), me_fecha_estado, 101),*/
      '1358' = convert(char(10), me_fecha_estado, @i_formato_fecha),
      '1333'= me_estado
    from   pe_mercado,
           pe_pro_bancario
    where  me_tipo_ente    = @i_tipo_ente
       and me_pro_bancario = pb_pro_bancario
       and me_mercado      > @i_mercado
	    order  by me_mercado
    set rowcount 0
    return 0
  end

  /**CONSULTA **/

  if @i_operacion = 'H'
  begin
    if @t_trn != 4023
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    set rowcount 15
    if @i_modo = 0
      select
        '1647'= me_pro_bancario,
        '1195' = substring(pb_descripcion,
                                                 1,
                                                 35)
      from   pe_pro_bancario,
             pe_mercado
      where  me_pro_bancario = pb_pro_bancario
         and me_tipo_ente    <> @i_tipo_ente
      order  by me_mercado
    else if @i_modo = 1
    begin
      select
        '1647' = me_pro_bancario,
        '1195' = substring(pb_descripcion,
                                                 1,
                                                 35)
      from   pe_mercado,
             pe_pro_bancario
      where  me_pro_bancario > @i_cod_prod
         and me_tipo_ente    <> @i_tipo_ente
      order  by me_pro_bancario
    end
    set rowcount 0
    return 0
  end

/**QUERY**/
  /*Consulta de un registro especifico */
  if @i_operacion = 'Q'
  begin
    if @t_trn != 4007
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    select
      me_pro_bancario,
      me_mercado,
      me_tipo_ente,
      me_estado,
      /*CHM Y2K */
      /*convert(char(10),me_fecha_estado,101)*/
      convert(char(10), me_fecha_estado, @i_formato_fecha)
    from   pe_mercado
    where  me_pro_bancario = @i_cod_prod
       and me_tipo_ente    = @i_tipo_ente
    if @@rowcount = 0
    /*error en consulta */
    begin
      /*No existe mercado solicitado*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351509
      return 351509
    end
  end
  return 0

go 
