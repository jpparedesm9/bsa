/****************************************************************************/
/*     Archivo           : pe_cons_perso.sp                                  */
/*     Stored procedure  : sp_cons_personalizacion                          */
/*     Base de datos     : cob_remesas                                      */
/*     Producto          : Personalizacion                                  */
/*     Disenado por      :                                                  */
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
/*     Este programa se encarga de realizar la consulta de los costos       */
/*     personalizados                                                       */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    08/DIC/94      G.Calderon     Emision Inicial                         */
/*    30/Sep/2003    Gloria Rueda   Retornar c¢digos de error               */
/*    02/Mayo/2016     Roxana Sánchez       Migración a CEN                 */
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
           where  name = 'sp_cons_personalizacion')
  drop proc sp_cons_personalizacion
go

create proc sp_cons_personalizacion
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
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_modo         tinyint = null,
  @i_servicio_per smallint = null,
  @i_tipo_default catalogo = null,
  @i_codigo       int = null,
  @i_categoria    catalogo = null,
  @i_rol          char(1) = null,
  @i_cuenta       cuenta = null,
  @i_tipo_cuenta  char(1) = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_today   datetime,
    @w_codigo  int,
    @w_estado  char (1)

  select
    @w_sp_name = 'sp_cons_personalizacion',
    @w_today = getdate()

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
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      t_trn = @t_trn,
      i_operacion = @i_operacion,
      i_modo = @i_modo
    exec cobis..sp_end_debug
  end
  /**BUSQUEDA **/
  if @i_operacion = 'S'
  begin
    if @t_trn != 4056
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_tipo_default = 'C'
    begin
      if @i_tipo_cuenta = 'C'
      begin
        select
          @w_codigo = cc_ctacte
        from   cob_cuentas..cc_ctacte
        where  cc_cta_banco = @i_cuenta
      end
      else if @i_tipo_cuenta = 'A'
      begin
        select
          @w_codigo = ah_cuenta
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cuenta
      end
    end
    else
      select
        @w_codigo = @i_codigo

    set rowcount 20
    if @i_modo = 0
      select
        '1710' = vc_servicio_per,
        '1890' = tr_tipo_atributo,
        '1685' = vc_rol,
        '1749' = vc_tipo_variacion,
        '1797' = vc_valor_con,
        '1891' = vc_signo
      from   pe_val_contratado,
             pe_servicio_per,
             pe_tipo_rango
      where  sp_servicio_per = vc_servicio_per
         and sp_tipo_rango   = tr_tipo_rango
         and vc_codigo       = @w_codigo
         and vc_categoria    = @i_categoria

    if @i_modo = 1
      select
        '1710' = vc_servicio_per,
        '1890' = tr_tipo_atributo,
        '1685' = vc_rol,
        '1749' = vc_tipo_variacion,
        '1797' = vc_valor_con,
        '1891' = vc_signo
      from   pe_val_contratado,
             pe_servicio_per,
             pe_tipo_rango
      where  sp_servicio_per = vc_servicio_per
         and sp_tipo_rango   = tr_tipo_rango
         and vc_codigo       = @w_codigo
         and vc_categoria    = @i_categoria
         and vc_servicio_per > @i_servicio_per
    return 0
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn != 4066
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      sd_descripcion,
      tr_tipo_atributo
    from   pe_servicio_per,
           pe_tipo_rango,
           pe_servicio_dis
    where  sd_servicio_dis = sp_servicio_dis
       and sp_tipo_rango   = tr_tipo_rango
       and sp_servicio_per = @i_servicio_per
    return 0
  end

  if @i_operacion = 'C'
  begin
    if @t_trn != 4067
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_modo = 0
    begin
      select
        '1710' = sp_servicio_per,
        '1896' = sd_descripcion,
        '1890' = tr_tipo_atributo
      from   pe_servicio_per,
             pe_tipo_rango,
             pe_servicio_dis
      where  sd_servicio_dis = sp_servicio_dis
         and sp_tipo_rango   = tr_tipo_rango
    end
    if @i_modo = 1
    begin
      select
        '1710' = sp_servicio_per,
        '1896' = sd_descripcion,
        '1890' = tr_tipo_atributo
      from   pe_servicio_per,
             pe_tipo_rango,
             pe_servicio_dis
      where  sd_servicio_dis = sp_servicio_dis
         and sp_tipo_rango   = tr_tipo_rango
         and sp_servicio_per > @i_servicio_per
    end

    return 0
  end

go 
