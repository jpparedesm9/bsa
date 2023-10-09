/****************************************************************************/
/*     Archivo:     pepercta.sp                                             */
/*     Stored procedure: sp_personaliza_cuenta                              */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 25-Ene-1994                                      */
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
/*     Este programa realiza la insercion o actualizacion de la personali-  */
/*     zacion de cuentas, ademas de las consultas de cuentas por titular.   */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*  25-Ene-1994 JGO     Emision inicial                                     */
/*   JUN/95     J.Gordillo      Personalizacion Bco. Produccion             */
/*      14/05/2003      Julissa Colorado Personalizacion Bco Agrario        */
/*      30/Sep/2003     Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_personaliza_cuenta')
  drop proc sp_personaliza_cuenta
go

create proc sp_personaliza_cuenta
(
  @s_ssn          int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1)= null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint= null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_filial       tinyint = null,
  @i_tipo         char(1)= null,
  @i_tipo_default char(1) = null,
  @i_cod_emp      int = null,
  @i_producto     tinyint = null,
  @i_moneda       tinyint = null,
  @i_pro_bancario smallint = null,
  @i_rol          char(1) = null,
  @i_cod_persona  int = null,
  @i_cuenta       int = 0
)
as
  declare
    @w_sp_name       varchar(32),
    @w_pro_banc      tinyint,
    @w_categoria     char(1),
    @w_personalizada char(1),
    @w_default       int,
    @w_return        int,
    @w_cuenta        cuenta,
    @w_filial        tinyint,
    @w_oficina       smallint,
    @w_tipo          char(1),
    @w_subtipo       char(1),
    @w_sucursal      smallint,
    @w_tipo_ente     char(1)

  select
    @w_sp_name = 'sp_personaliza_cuenta',
    @w_personalizada = 'S'

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

  if @i_operacion = 'U'
  begin
    if @t_trn != 4071
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
      if not exists (select
                       *
                     from   cobis..cl_pro_moneda
                     where  pm_producto = @i_producto
                        and pm_moneda   = @i_moneda)
      begin
        /* No existe producto moneda */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351518
        return 351518
      end

      if @i_producto = 3
      begin
        if not exists (select
                         *
                       from   cob_cuentas..cc_ctacte
                       where  cc_ctacte = @i_cuenta)
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
          @w_pro_banc = cc_prod_banc,
          @w_categoria = cc_categoria,
          @w_tipo_ente = cc_rol_ente
        /*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/
        from   cob_cuentas..cc_ctacte
        where  cc_ctacte = @i_cuenta

      end
      else if @i_producto = 4
      begin
        if not exists (select
                         *
                       from   cob_ahorros..ah_cuenta
                       where  ah_cuenta = @i_cuenta)
        begin
          /* No existe cuenta de ahorro */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351523
          return 351523
        end

        select
          @w_pro_banc = ah_prod_banc,
          @w_categoria = ah_categoria,
          @w_tipo_ente = ah_rol_ente
        /*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/
        from   cob_ahorros..ah_cuenta
        where  ah_cuenta = @i_cuenta
      end

      select
        @w_default = @i_cuenta
    end

    else if @i_tipo_default in ('E', 'G')
      select
        @w_default = @i_cod_emp
    else if @i_tipo_default = 'P'
      select
        @w_default = @i_cod_persona
    else if @i_tipo_default = 'D'
      select
        @w_default = 0,
        @w_personalizada = 'N'

    if @i_tipo_default in ('E', 'G', 'P')
    begin
      if not exists (select
                       *
                     from   pe_val_contratado
                     where  vc_tipo_default = @i_tipo_default
                        and vc_rol          = @w_tipo_ente
                        /*@i_rol Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/
                        and vc_codigo       = @w_default)
      begin
        /* No existe valor contratado para la personalizacion dada */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351554
        return 351554
      end
    end

    begin tran

    if @i_producto = 3
    begin
      update cob_cuentas..cc_ctacte
      set    cc_tipo_def = @i_tipo_default,
             cc_default = @w_default,
             --cc_rol_ente = @i_rol, fecha: 28/06/2002 Ing. Elkin Pulido (Banco)
             cc_personalizada = @w_personalizada
      where  cc_ctacte = @i_cuenta

      if @@rowcount != 1
      begin
        /* Error de actualizacion de cuenta corriente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355517
        rollback tran
        return 355517
      end

      select
        @w_cuenta = cc_cta_banco
      from   cob_cuentas..cc_ctacte
      where  cc_ctacte = @i_cuenta
    end

    if @i_producto = 4
    begin
      update cob_ahorros..ah_cuenta
      set    ah_tipo_def = @i_tipo_default,
             ah_default = @w_default,
             --ah_rol_ente = @i_rol, fecha: 28/06/2002 Ing. Elkin Pulido (Banco)
             ah_personalizada = @w_personalizada
      where  ah_cuenta = @i_cuenta

      if @@rowcount != 1
      begin
        /* Error de actualizacion de cuenta de ahorro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355518
        return 355518
      end

      select
        @w_cuenta = ah_cta_banco
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_cuenta
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_cod_alterno,ts_cuenta,ts_producto,ts_tipo_default
                 ,
                 ts_rol,ts_codigo)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 'N',0,
                 --@w_cuenta, @i_producto, @i_tipo_default, @i_rol, @w_default)
                 @w_cuenta,@i_producto,@i_tipo_default,
                 @w_tipo_ente,@w_default)
    /*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/

    if @@rowcount != 1
    begin
      /* Error de insercion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      rollback tran
      return 353515
    end

    commit tran
  end

  if @i_operacion = 'C'
  begin
    if @t_trn != 4072
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    set rowcount 15

    if @i_tipo = 'C'
    begin
      select
        '1131' = cc_ctacte,                      --CUENTA
        '1514' = cc_cta_banco,                   --No. CUENTA
        '1629' = cc_tipo_def,                    --PERSONALIZACION
        '1093' = cc_default,                     --CODIGO
        '1685' = cc_rol_ente,                    --ROL
        '1063' = cc_categoria,                   --CATEGORIA
        '1653' = cc_producto,                    --PRODUCTO
        '1481' = cc_moneda,                      --MONEDA
        '1194' = substring(pm_descripcion,       --DESCRIPCION DE PRO. MON.
                                               1,
                                               35),
        '1648' = cc_prod_banc,                   --PROD. BANCARIO
        '1204' = substring(pb_descripcion,       --DESCRIPCION PROD. BANC.
                                              1,
                                              35)
      from   cob_cuentas..cc_ctacte,
             cobis..cl_pro_moneda,
             pe_pro_bancario
      where  cc_cliente      = @i_cod_persona
         and pm_producto     = cc_producto
         and pm_moneda       = cc_moneda
         and pb_pro_bancario = cc_prod_banc
         and cc_ctacte       > @i_cuenta
         and cc_filial       = @i_filial
      order  by cc_ctacte
    end
    if @i_tipo = 'A'
    begin
      select
        '1131' = ah_cuenta,                       --CUENTA
        '1514' = ah_cta_banco,                    --No. CUENTA
        '1629' = ah_tipo_def,                     --PERSONALIZACION
        '1093' = ah_default,                      --CODIGO
        '1685' = ah_rol_ente,                     --ROL
        '1063' = ah_categoria,                    --CATEGORIA
        '1653' = ah_producto,                     --PRODUCTO
        '1481' = ah_moneda,                       --MONEDA
        '1194' = substring(pm_descripcion, 
                                             1,
                                            35),  --DESCRIPCION DE PRO. MON.
        '1648' = ah_prod_banc,                    --PROD. BANCARIO
        '1204' = substring(pb_descripcion,
                                              1,
                                              35) --DESCRIPCION PROD. BANC.
      from   cob_ahorros..ah_cuenta,
             cobis..cl_pro_moneda,
             pe_pro_bancario
      where  ah_cliente      = @i_cod_persona
         and pm_producto     = ah_producto
         and pm_moneda       = ah_moneda
         and pb_pro_bancario = ah_prod_banc
         and ah_cuenta       > @i_cuenta
         and ah_filial       = @i_filial
      order  by ah_cuenta
    end
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn != 4072
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_producto = 3
      select
        @w_filial = cc_filial,
        @w_oficina = cc_oficina,
        @w_tipo = cc_tipo,
        @w_tipo_ente = cc_tipocta
      from   cob_cuentas..cc_ctacte
      where  cc_ctacte = @i_cuenta

    if @i_producto = 4
      select
        @w_filial = ah_filial,
        @w_oficina = ah_oficina,
        @w_tipo = ah_tipo,
        @w_tipo_ente = ah_tipocta
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_cuenta

    select
      @w_subtipo = of_subtipo
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    if @w_subtipo = 'O'
      select
        @w_sucursal = of_regional /*of_oficina */
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

    if @w_subtipo = 'R'
      select
        @w_sucursal = @w_oficina

    select
      pf_pro_final,
      substring(pf_descripcion,
                1,
                35)
    from   pe_pro_final,
           pe_mercado
    where  pf_mercado      = me_mercado
       and me_pro_bancario = @i_pro_bancario
       and me_tipo_ente    = @w_tipo_ente
       and pf_producto     = @i_producto
       and pf_moneda       = @i_moneda
       and pf_filial       = @w_filial
       and pf_sucursal     = @w_sucursal
       and pf_tipo         = @w_tipo

    if @@rowcount = 0
    begin
      /*No existe producto final*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351527
      return 351527
    end
  end

  return 0

GO 
