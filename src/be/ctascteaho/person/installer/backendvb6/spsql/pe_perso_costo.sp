/****************************************************************************/
/*     Archivo:     pe_perso_costo.sp                                       */
/*     Stored procedure: sp_personaliza_costos                              */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
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
/*     Es te programa se encarga de realizar la personalizacion de los      */
/*     costos                                                               */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    08/DIC/94      G.Calderon     Emision Inicial                         */
/*    30/Sep/2003    Gloria Rueda   Retornar códigos de error               */
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
           where  name = 'sp_personaliza_costos')
  drop proc sp_personaliza_costos
go

create proc sp_personaliza_costos
(
  @s_ssn          int= null,
  @s_user         varchar(30) = null,
  @s_term         varchar(10) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name        varchar(32),
    @w_return         int,
    @w_producto       tinyint,
    @w_codigo         int,
    @w_estado         char(1),
    @w_tipo_default   char(1),
    @w_rol            char(1),
    @w_servicio_per   int,
    @w_categoria      catalogo,
    @w_operacion      char(1),
    @w_tipo           char(1),
    @w_valor_con      money,
    @w_tipo_variacion char(1),
    @w_signo          char(1),
    @w_fecha          datetime,
    @w_fecha_cambio   datetime,
    @w_secuencial     int,
    @w_last_sec       int

  select
    @w_sp_name = 'sp_personaliza_costos',
    @w_fecha = getdate()

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn != 4061
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
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
      t_from = @t_from
    exec cobis..sp_end_debug
  end

  select
    @w_last_sec = 0

  while (1 = 1)
  begin
    begin tran

    set rowcount 1

    select
      @w_tipo_default = vv_tipo_default,
      @w_rol = vv_rol,
      @w_producto = vv_producto,
      @w_codigo = vv_codigo,
      @w_servicio_per = vv_servicio_per,
      @w_categoria = vv_categoria,
      @w_operacion = vv_operacion,
      @w_tipo = vv_tipo,
      @w_valor_con = vv_valor_con,
      @w_tipo_variacion = vv_tipo_variacion,
      @w_signo = vv_signo,
      @w_fecha_cambio = vv_fecha_cambio,
      @w_secuencial = vv_secuencial
    from   pe_cambio_val_contr
    where  vv_secuencial > @w_last_sec
       and vv_fecha_apli is null

    if @@rowcount = 0
    begin
      rollback tran
      break
    end

    /**************[ Insercion de nuevas instancias de personalizacion ]*********/
    if @w_operacion = 'I'
    begin
      insert into pe_val_contratado
                  (vc_tipo_default,vc_rol,vc_producto,vc_codigo,vc_servicio_per,
                   vc_categoria,vc_fecha,vc_signo,vc_valor_con,vc_tipo_variacion
      )
      values      (@w_tipo_default,@w_rol,@w_producto,@w_codigo,@w_servicio_per,
                   @w_categoria,@w_fecha,@w_signo,@w_valor_con,@w_tipo_variacion
      )
      if @@error != 0
      begin
        rollback tran
        continue
      end
    end

    /***************[ ACTUALIZACION DE COSTOS PERSONALIZADOS ]*****************/
    if @w_operacion = 'U'
    begin
      if not exists (select
                       *
                     from   pe_val_contratado
                     where  vc_codigo       = @w_codigo
                        and vc_servicio_per = @w_servicio_per
                        and vc_categoria    = @w_categoria
                        and vc_tipo_default = @w_tipo_default
                        and vc_rol          = @w_rol
                        and vc_producto     = @w_producto)
      begin
        rollback tran
        continue
      end
      update pe_val_contratado
      set    vc_tipo_variacion = @w_tipo_variacion,
             vc_valor_con = @w_valor_con,
             vc_signo = @w_signo
      where  vc_codigo       = @w_codigo
         and vc_servicio_per = @w_servicio_per
         and vc_tipo_default = @w_tipo_default
         and vc_rol          = @w_rol
         and vc_categoria    = @w_categoria
         and vc_producto     = @w_producto
      if @@rowcount != 1
      begin
        rollback tran
        continue
      end
    end
    /***********[ Eliminacion de costos personalizados ]*************/
    if @w_operacion = 'D'
    begin
      if not exists (select
                       *
                     from   pe_val_contratado
                     where  vc_codigo       = @w_codigo
                        and vc_servicio_per = @w_servicio_per
                        and vc_categoria    = @w_categoria
                        and vc_tipo_default = @w_tipo_default
                        and vc_producto     = @w_producto
                        and vc_rol          = @w_rol)
      begin
        rollback tran
        continue
      end

      delete pe_val_contratado
      where  vc_codigo       = @w_codigo
         and vc_servicio_per = @w_servicio_per
         and vc_categoria    = @w_categoria
         and vc_tipo_default = @w_tipo_default
         and vc_producto     = @w_producto
         and vc_rol          = @w_rol
      if @@rowcount != 1
      begin
        rollback tran
        continue
      end
    end
    update pe_cambio_val_contr
    set    vv_fecha_apli = @w_fecha
    where  vv_secuencial = @w_secuencial
    commit tran
    select
      @w_last_sec = @w_secuencial
    continue
  end

go 
