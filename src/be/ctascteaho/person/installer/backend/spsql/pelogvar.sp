/****************************************************************************/
/*     Archivo:     pelogvar.sp                                              */
/*     Stored procedure: sp_reg_personalizacion                        */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta las transacciones a realizar sobre la tabla    */
/*     pe_costos.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    15/DIC/94       G.Calderon    Emision Inicial                         */
/*    30/Sep/2003     Gloria Rueda  Retornar c¢digos de error               */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_reg_personalizacion')
  drop proc sp_reg_personalizacion
go

create proc sp_reg_personalizacion
(
  @s_ssn            int = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_user           varchar(30) = null,
  @s_sesn           int,
  @s_term           varchar(10),
  @s_date           datetime,
  @s_org            char(1),
  @s_ofi            smallint,
  @s_rol            smallint,
  @s_org_err        char(1)= null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            mensaje = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           varchar(32) = null,
  @t_rty            char(1) = 'N',
  @t_trn            smallint= null,
  @t_show_version   bit = 0,
  @i_operacion      char(1) = null,
  @i_tipo           char(1) = null,
  @i_tipo_default   char(1) = null,
  @i_rol            char(1) = null,
  @i_codigo         int = null,
  @i_servicio_per   smallint = null,
  @i_categoria      catalogo= null,
  @i_valor_con      float = null,
  @i_tipo_variacion char(1) = null,
  @i_signo          char(1) = null,
  @i_cuenta         cuenta = null,
  @i_tipo_cuenta    char(1)= null
)
as
  declare
    @w_sp_name    varchar(32),
    @w_today      datetime,
    @w_secuencial int,
    @w_codigo     int,
    @w_producto   tinyint,
    @w_minimo     float,
    @w_maximo     float,
    @w_tipo_dato  char(1),
    @w_valor_con  float,
    @w_return     int

  select
    @w_sp_name = 'sp_reg_personalizacion',
    @w_today = getdate(),
    @w_producto = null

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
      t_from = @t_from
    exec cobis..sp_end_debug
  end

  /*Validaciones*/

  if @t_trn not in (4053, 4054, 4055)
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @t_trn != 4053
     and @i_operacion = 'I'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @t_trn != 4054
     and @i_operacion = 'U'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @t_trn != 4055
     and @i_operacion = 'D'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @i_tipo_default not in ('C', 'E', 'G', 'P')
  begin
    /* No existe tipo default */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351521
    return 351521
  end

  if @i_signo not in ('+', '-')
  begin
    /* No existe signo */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351525
    return 351525
  end

  select
    @w_tipo_dato = vs_tipo_dato
  from   pe_var_servicio,
         pe_servicio_per
  where  vs_servicio_dis = sp_servicio_dis
     and vs_rubro        = sp_rubro
     and sp_servicio_per = @i_servicio_per

  if @i_tipo_variacion = 'M'
     and @w_tipo_dato = 'P'
  begin
    /* Tipo de variacion no permitido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351549
    return 351549
  end

  select
    @w_minimo = min(co_val_medio),
    @w_maximo = max(co_val_medio)
  from   pe_costo
  where  co_servicio_per = @i_servicio_per
     and co_categoria    = @i_categoria

  if @@rowcount = 0
  begin
    /* No existe costo para el servicio y categoria dado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351548
    return 351548
  end

  if @i_tipo_variacion = 'M'
      or @w_tipo_dato = 'P'
    select
      @w_valor_con = @i_valor_con

  else if @i_tipo_variacion = 'P'
     and @w_tipo_dato = 'M'
  begin
    if @i_signo = '-'
      select
        @w_valor_con = @i_valor_con * @w_minimo
    else if @i_signo = '+'
      select
        @w_valor_con = @i_valor_con * @w_maximo
  end

  if @i_signo = '-'
  begin
    select
      @w_minimo = @w_minimo - @w_valor_con
    if not exists (select
                     *
                   from   pe_limite
                   where  li_servicio_per = @i_servicio_per
                      and li_categoria    = @i_categoria
                      and li_minimo       < @w_minimo)
    begin
      /* Valor contratado no permitido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351544
      return 351544
    end
  end
  else if @i_signo = '+'
  begin
    select
      @w_maximo = @w_maximo + @w_valor_con
    if not exists (select
                     *
                   from   pe_limite
                   where  li_servicio_per = @i_servicio_per
                      and li_categoria    = @i_categoria
                      and li_maximo       > @w_maximo)
    begin
      /* Valor contratado no permitido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351544
      return 351544
    end
  end

  if @i_tipo_default = 'C'
  begin
    if @i_tipo_cuenta = 'C'
    begin
      select
        @w_codigo = cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cuenta

      if @@rowcount = 0
      begin
        /* No existe cuenta corriente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351522
        return 351522
      end

      select
        @w_producto = 3
    end
    else if @i_tipo_cuenta = 'A'
    begin
      select
        @w_codigo = ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta

      if @@rowcount = 0
      begin
        /* No existe cuenta ahorro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351523
        return 351523
      end

      select
        @w_producto = 4
    end
  end
  else
    select
      @w_codigo = @i_codigo

  exec @w_return = cobis..sp_cseqnos
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'pe_cambio_val_contr',
    @o_siguiente = @w_secuencial out
  if @w_return != 0
    return @w_return

  /******[ Insertar un nuevo registro de cambio de costo]*********/

  insert into cob_remesas..pe_cambio_val_contr
              (vv_servicio_per,vv_categoria,vv_tipo_default,vv_rol,vv_producto,
               vv_codigo,vv_valor_con,vv_signo,vv_tipo_variacion,vv_fecha_apli,
               vv_fecha_cambio,vv_operacion,vv_tipo,vv_secuencial)
  values      (@i_servicio_per,@i_categoria,@i_tipo_default,@i_rol,@w_producto,
               @w_codigo,@i_valor_con,@i_signo,@i_tipo_variacion,null,
               @w_today,@i_operacion,@i_tipo,@w_secuencial)

  /*Ocurrio un error en la insercion de cambio de valor contratado*/
  if @@error != 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 353513
    return 353513
  end
  return 0

GO 
