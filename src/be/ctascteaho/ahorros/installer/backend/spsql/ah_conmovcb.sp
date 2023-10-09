/******************************************************************/
/*  Archivo:            ah_conmovcb.sp                            */
/*  Stored procedure:   sp_cons_mov_cb                            */
/*  Base de datos:      cob_ahorros                               */
/*  Producto:           Ahorros                                   */
/*  Disenado por:       Andrés Muñoz                              */
/*  Fecha de escritura: 09/ENE/2014                               */
/******************************************************************/
/*                      IMPORTANTE                                */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad     */
/*   de COBISCorp.                                                    */
/*   Su uso no autorizado queda expresamente prohibido asi como       */
/*   cualquier alteracion o agregado  hecho por alguno de sus         */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.  */
/*   Este programa esta protegido por la ley de derechos de autor     */
/*   y por las convenciones  internacionales   de  propiedad inte-    */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para */
/*   obtener ordenes  de secuestro o retencion y para  perseguir      */
/*   penalmente a los autores de cualquier infraccion.                */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*   Realiza las consultas a los movimientos monetarios               */
/*   correspondientes a de corresoponsales bancarios                  */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*  FECHA               AUTOR            RAZON                        */
/*  09/ENE/2014         Andrés Muñoz     Emision Inicial              */
/*                                       Req 381 Corresponsales       */
/*                                       Bancarios                    */
/*  29/ENE/2015         Andrés Diab      REQ 457 Ajuste consultas     */
/*                                       solo retiros 26519           */
/*   02/May/2016        J. Calderon     Migración a CEN               */
/**********************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cons_mov_cb')
  drop proc sp_cons_mov_cb
go

create proc sp_cons_mov_cb
  @s_user          login,
  @s_date          datetime,
  @s_ofi           smallint,
  @s_ssn           int,
  @s_term          varchar(10),
  @t_trn           int,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_rty           char(1) = 'N',
  @t_show_version  bit = 0,
  @s_org           char(1),
  @i_cta_banco     cuenta,
  @i_fchdsde       datetime,
  @i_fchhsta       datetime,
  @i_sec           int,
  @i_sec_alt       int,
  @i_operacion     char(1),
  @i_diario        int = null,
  @i_secuencial    int = 0,
  @i_hora          smalldatetime = null,
  @i_formato_fecha int,
  @o_hist          tinyint = null out
as
  declare
    @w_cuenta            cuenta,
    @w_funcionario       varchar(15),
    @w_disponible        int,
    @w_sp_name           varchar(50),
    @w_error             int,
    @w_mensaje           descripcion,
    @w_prod_bancario     varchar(10),
    @w_fecha_1           datetime,
    @w_fecha_2           datetime,
    @w_disponible_1      money,
    @w_disponible_2      money,
    @w_cupo_aprobado     money,
    @w_cupo_aprobado_1   money,
    @w_cupo_aprobado_2   money,
    @w_cupo_reintegrado  money,
    @w_cupo_utilizado    money,
    @w_cupo_utilizado_1  money,
    @w_cupo_utilizado_2  money,
    @w_fecha_3           varchar(10),
    @w_clase_clte        char(1),
    @w_oficina_p         smallint,
    @w_cliente           int,
    @w_tipocta           char(1),
    @w_categoria         char(1),
    @w_prod_banc         smallint,
    @w_registro_cupo     money,
    @w_ciudad            int,
    @w_fecha_vencimiento datetime,
    @w_id_cuenta         int,
    @w_numdeci           tinyint,
    @w_dias_vigencia     int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_cons_mov_cb'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 399
  begin
    select
      @w_error = 101077,--VERIFICAR EL CODIGO DE ERROR
      @w_mensaje = 'ERROR : CODIGO DE TRANSACCION NO CORRESPONDE'
    goto ERRORFIN
  end

  if @i_diario <> 0
     and @i_sec = 0
    select
      @i_sec = -2147483648

  /*Verificando los datos de entrada*/
  if (@i_cta_banco is null
       or @i_fchdsde is null
       or @i_fchhsta is null
       or @i_sec is null
       or @i_sec_alt is null)
  begin
    select
      @w_error = 101077,--DEBEN INGRESARSE LOS DATOS DE ENTRADA
      @w_mensaje = 'ERROR : DEBEN INGRESARSE LOS DATOS DE ENTRADA'
    goto ERRORFIN
  end

  select
    @w_numdeci = isnull(pa_tinyint,
                        0)
  from   cobis..cl_parametro
  where  pa_nemonico = 'DCI'
     and pa_producto = 'AHO'

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = isnull(pa_smallint,
                              0)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PBCB'

  /****** CUANDO ES OPERACION C SOLO CONSULTA EL DETALLE DEL MOVIMIENTO Y LO MANDA AL FRONT END *****/
  if @i_operacion = 'C'
  begin
    /*  Determinacion de la cuenta interna */
    select
      @w_cuenta = ah_cuenta,
      @w_funcionario = ah_cta_funcionario,
      @w_disponible = ah_disponible,
      @w_id_cuenta = ah_cuenta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
       and ah_prod_banc = @w_prod_bancario

    if @@rowcount = 0
    begin
      select
        @w_error = 251127,--CUENTA NO EXISTE
        @w_mensaje = 'ERROR : CUENTA NO EXISTE O NO ES DE CORRESPONSALIA'
      goto ERRORFIN
    end

    select
      @w_fecha_1 = dateadd(dd,
                           -1,
                           @s_date)
    while exists(select
                   1
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = @w_ciudad
                    and df_fecha  = @w_fecha_1)
    begin
      select
        @w_fecha_1 = dateadd(dd,
                             -1,
                             @w_fecha_1)
    end

    select
      @w_fecha_2 = dateadd(dd,
                           -1,
                           @w_fecha_1)
    while exists(select
                   1
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = @w_ciudad
                    and df_fecha  = @w_fecha_2)
    begin
      select
        @w_fecha_2 = dateadd(dd,
                             -1,
                             @w_fecha_2)
    end

    /* DATOS CUPO APROBADO */
    select top 1
      cc_tipo_mov,
      cc_valor_cupo,
      cc_fecha_ingreso
    into   #cupo
    from   cob_remesas..re_mantenimiento_cupo_cb
    where  cc_cta_banco     = @i_cta_banco
       and cc_fecha_ingreso <= @s_date
       and cc_tipo_mov      <> 'V'
    order  by cc_fecha_ingreso desc,
              cc_hora_ingreso desc

    select
      @w_cupo_aprobado = isnull(cc_valor_cupo,
                                0)
    from   #cupo
    where  cc_fecha_ingreso <= @s_date

    select top 1
      @w_fecha_vencimiento = cc_fecha_vencimiento,
      @w_dias_vigencia = cc_dias_vigencia
    from   cob_remesas..re_mantenimiento_cupo_cb
    where  cc_cta_banco     = @i_cta_banco
       and cc_fecha_ingreso <= @s_date
    order  by cc_hora_ingreso desc

    /* VALORES EN SUSPENSO POR USO DEL CUPO */
    select
      fecha = vs_fecha,
      procesada = vs_procesada,
      valor = sum(vs_valor)
    into   #val_suspenso
    from   cob_ahorros..ah_val_suspenso
    where  vs_cuenta = @w_id_cuenta
       and vs_fecha  <= @s_date
    group  by vs_fecha,
              vs_procesada

    select
      @w_cupo_utilizado = sum(round(isnull(valor,
                                           0),
                                    @w_numdeci))
    from   #val_suspenso
    where  fecha     <= @s_date
       and procesada = 'N'

    select
      @w_cupo_utilizado_1 = isnull(@w_cupo_aprobado,
                                   0) - isnull(@w_cupo_utilizado,
                                               0)

    if @i_sec = 0
    begin
      /* Datos de la cabecera */
      select
        convert(varchar(10), a.ah_fecha_ult_mov, @i_formato_fecha),
        convert(varchar(10), a.ah_fecha_ult_corte, @i_formato_fecha),
        mo_descripcion,
        a.ah_descripcion_ec,
        convert (varchar(10), a.ah_fecha_prx_corte, @i_formato_fecha),
        a.ah_parroquia,
        a.ah_zona,
        isnull(@w_cupo_utilizado_1,
               0),
        fu_nombre,
        a.ah_estado,
        desc_estado = isnull((select
                                c.valor
                              from   cobis..cl_catalogo c,
                                     cobis..cl_tabla t,
                                     cob_remesas..re_mantenimiento_cb m
                              where  c.tabla        = t.codigo
                                 and t.tabla        = 're_estado_servicio'
                                 and c.codigo       = m.mc_estado
                                 and m.mc_cta_banco = a.ah_cta_banco),
                             'N/A')
      from   cob_ahorros..ah_cuenta a,
             cobis..cl_moneda,
             cobis..cl_funcionario,
             cobis..cc_oficial
      where  a.ah_cuenta    = @w_cuenta
         and mo_moneda      = a.ah_moneda
         and oc_oficial     = a.ah_oficial
         and fu_funcionario = oc_funcionario

      select
        te_valor
      from   cob_ahorros..ah_cuenta,
             cobis..cl_direccion,
             cobis..cl_telefono
      where  ah_cuenta     = @w_cuenta
         and ah_prod_banc  = @w_prod_bancario
         -- Req. 381 CB Red Posicionada      
         and di_ente       = ah_cliente
         and di_direccion  = ah_direccion_ec
         and te_ente       = di_ente
         and te_direccion  = di_direccion
         and te_secuencial = di_telefono

    end

    /* ELIMINAR DATOS ANTERIORES DE CONSULTA DEL MISMO USUARIO */
    delete cob_ahorros..tmp_consulta_mov_cb
    where  user_consulta = @s_user

    /* TABLA DIARIA DE SERVICIO PARA BUSQUEDA DE REGISTRO Y COBRO DE VALORES EN SUSPENSO */

    create table #consulta_mov_cb
    (
      cuenta        varchar(16) not null,
      fecha         varchar(10) null,
      descripcion   varchar(132) null,
      debito        money null,
      credito       money null,
      punto_atn     varchar(64) null,
      referencia    varchar(36) null,
      hora          datetime null,
      estado        varchar(12) null,
      cod_alterno   int null,
      secuencial    int null,
      usuario       varchar(12) null,
      user_consulta varchar(12) null
    )

    insert into #consulta_mov_cb
      select
        cuenta = @i_cta_banco,fecha = convert(varchar(10), X.ts_tsfecha, 103),
        --@i_formato_fecha),   
        descripcion = (case X.ts_tipo_transaccion
                         when 258 then (select
                                          a.valor
                                        from
                         cobis..cl_catalogo a,cobis..cl_tabla
                         b
                                        where  a.tabla  = b.codigo
                                           and a.codigo = X.ts_causa
                                           and b.tabla  = 'ah_causa_nd')
                         when 303 then (select
                                          a.valor
                                        from
                         cobis..cl_catalogo a,cobis..cl_tabla
                         b
                                        where  a.tabla  = b.codigo
                                           and a.codigo = X.ts_causa
                                           and b.tabla  = 'ah_causa_nc')
                         else ' '
                       end),debito = (case X.ts_tipo_transaccion
                    when 258 then isnull(X.ts_valor,
                                         $0)
                    else 0
                  end),credito =(case X.ts_tipo_transaccion
                    when 303 then isnull(X.ts_valor,
                                         $0)
                    else 0
                  end),
        punto_atn = (select
                       pr_nombre
                     from   cob_remesas..re_punto_red_cb
                     where  ts_ssn          = X.ts_secuencial
                        and pr_codigo_punto = Y.ts_terminal
                        and pr_codigo_cb    = ts_codcorr),
        referencia = ts_sec_ext,
        hora
        = Y.ts_hora,estado = (case Y.ts_estado
                    when 'A' then 'EXITOSA'
                    when 'X' then 'DECLINADA'
                    when 'R' then 'REVERSADA'
                    else 'NO DEFINIDO'
                  end),cod_alterno = X.ts_cod_alterno,
        secuencial = convert(varchar(20), X.ts_secuencial),-- SSN
        usuario = X.ts_usuario,user_consulta = @s_user
      from   cob_ahorros..ah_tran_servicio X,
             cobis..ws_tran_servicio Y
      where  X.ts_tipo_transaccion in (258, 303)
         and X.ts_cta_banco   = @i_cta_banco
         and X.ts_tsfecha     >= @i_fchdsde
         and X.ts_tsfecha     <= @i_fchhsta
         and X.ts_secuencial  = ts_ssn
         and Y.ts_tipo_tran   = 26519
         -- DISMINUCIONES Y REVERSOS REGISTRAN COMO RETIROS EN LA WS_TRAN_SERVICIO
         and ((X.ts_hora        = @i_hora
               and X.ts_secuencial  = @i_sec
               and X.ts_cod_alterno > @i_sec_alt)
               or (X.ts_hora        = @i_hora
                   and X.ts_secuencial  > @i_sec)
               or (X.ts_hora > @i_hora))

    /* TABLA HISTORICA MONETARIA PARA BUSQUEDA DE MOVIMIENTOS */
    insert into #consulta_mov_cb
      select
        cuenta = @i_cta_banco,fecha = convert(varchar(10), hm_fecha,
                                      @i_formato_fecha)
        ,descripcion = (case hm_tipo_tran
                         when 253 then 'N/C POR: '
                                       + (select
                                            a.valor
                                          from   cobis..cl_catalogo a,
                                                 cobis..cl_tabla
                                                 b
                                          where  a.tabla  = b.codigo
                                             and a.codigo = hm_causa
                                             and b.tabla  = 'ah_causa_nc')
                         when 264 then 'N/D POR: '
                                       + (select
                                            a.valor
                                          from   cobis..cl_catalogo a,
                                                 cobis..cl_tabla
                                                 b
                                          where  a.tabla  = b.codigo
                                             and a.codigo = hm_causa
                                             and b.tabla  = 'ah_causa_nd')
                         else ' '
                       end),debito = (case hm_tipo_tran
                    when 264 then isnull(hm_valor,
                                         0)
                    else 0
                  end),credito = (case hm_tipo_tran
                     when 253 then isnull(hm_valor,
                                          0)
                     else 0
                   end),
        punto_atn = (select
                       pr_nombre
                     from   cob_remesas..re_punto_red_cb
                     where  ts_ssn          = hm_secuencial
                        and pr_codigo_punto = ts_terminal
                        and pr_codigo_cb    = ts_codcorr),
        referencia = ts_sec_ext,
        hora
        = hm_hora,estado = (case ts_estado
                    when 'A' then 'EXITOSA'
                    when 'X' then 'DECLINADA'
                    when 'R' then 'REVERSADA'
                    else 'NO DEFINIDO'
                  end),cod_alterno = hm_cod_alterno,
        secuencial = convert(varchar(20), hm_secuencial),-- SSN
        usuario = hm_usuario,user_consulta = @s_user
      from   cob_ahorros_his..ah_his_movimiento,
             cobis..ws_tran_servicio
      where  hm_tipo_tran in (253, 264)
         and hm_causa in ('260', '261')
         and hm_cta_banco   = @i_cta_banco
         and hm_fecha       >= @i_fchdsde
         and hm_fecha       <= @i_fchhsta
         and hm_secuencial  = ts_ssn
         and ts_tipo_tran   = 26519
         -- DISMINUCIONES Y REVERSOS REGISTRAN COMO RETIROS EN LA WS_TRAN_SERVICIO
         and ((hm_hora        = @i_hora
               and hm_secuencial  = @i_sec
               and hm_cod_alterno > @i_sec_alt)
               or (hm_hora        = @i_hora
                   and hm_secuencial  > @i_sec)
               or (hm_hora > @i_hora))

    /* TABLA DIARIA MONETARIA PARA BUSQUEDA DE MOVIMIENTOS */
    insert into #consulta_mov_cb
      select
        cuenta = @i_cta_banco,fecha = convert(varchar(10), tm_fecha,
                                      @i_formato_fecha)
        ,descripcion = (case tm_tipo_tran
                         when 253 then 'N/C POR: '
                                       + (select
                                            a.valor
                                          from   cobis..cl_catalogo a,
                                                 cobis..cl_tabla
                                                 b
                                          where  a.tabla  = b.codigo
                                             and a.codigo = tm_causa
                                             and b.tabla  = 'ah_causa_nc')
                         when 264 then 'N/D POR: '
                                       + (select
                                            a.valor
                                          from   cobis..cl_catalogo a,
                                                 cobis..cl_tabla
                                                 b
                                          where  a.tabla  = b.codigo
                                             and a.codigo = tm_causa
                                             and b.tabla  = 'ah_causa_nd')
                         else ' '
                       end),debito = (case tm_tipo_tran
                    when 264 then isnull(tm_valor,
                                         0)
                    else 0
                  end),credito = (case tm_tipo_tran
                     when 253 then isnull(tm_valor,
                                          0)
                     else 0
                   end),
        punto_atn = (select
                       pr_nombre
                     from   cob_remesas..re_punto_red_cb
                     where  ts_ssn          = tm_secuencial
                        and pr_codigo_punto = ts_terminal
                        and pr_codigo_cb    = ts_codcorr),
        referencia = ts_sec_ext,
        hora
        = tm_hora,estado = (case ts_estado
                    when 'A' then 'EXITOSA'
                    when 'X' then 'DECLINADA'
                    when 'R' then 'REVERSADA'
                    else 'NO DEFINIDO'
                  end),cod_alterno = tm_cod_alterno,
        secuencial = convert(varchar(20), tm_secuencial),-- SSN
        usuario = tm_usuario,user_consulta = @s_user
      from   cob_ahorros..ah_tran_monet,
             cobis..ws_tran_servicio
      where  tm_tipo_tran in (253, 264)
         and tm_causa in ('260', '261')
         and tm_cta_banco   = @i_cta_banco
         and tm_fecha       >= @i_fchdsde
         and tm_fecha       <= @i_fchhsta
         and tm_secuencial  = ts_ssn
         and ts_tipo_tran   = 26519
         -- DISMINUCIONES Y REVERSOS REGISTRAN COMO RETIROS EN LA WS_TRAN_SERVICIO
         and ((tm_hora        = @i_hora
               and tm_secuencial  = @i_sec
               and tm_cod_alterno > @i_sec_alt)
               or (tm_hora        = @i_hora
                   and tm_secuencial  > @i_sec)
               or (tm_hora > @i_hora))

    /* TABLA HISTORICA DE SERVICIO PARA BUSQUEDA DE REGISTRO Y COBRO DE VALORES EN SUSPENSO */
    insert into #consulta_mov_cb
      select
        cuenta = @i_cta_banco,fecha = convert(varchar(10), hs_tsfecha, 103),
        --@i_formato_fecha),   
        descripcion = (case hs_tipo_transaccion
                         when 258 then (select
                                          a.valor
                                        from
                         cobis..cl_catalogo a,cobis..cl_tabla
                         b
                                        where  a.tabla  = b.codigo
                                           and a.codigo = hs_causa
                                           and b.tabla  = 'ah_causa_nd')
                         when 303 then (select
                                          a.valor
                                        from
                         cobis..cl_catalogo a,cobis..cl_tabla
                         b
                                        where  a.tabla  = b.codigo
                                           and a.codigo = hs_causa
                                           and b.tabla  = 'ah_causa_nc')
                         else ' '
                       end),debito = (case hs_tipo_transaccion
                    when 258 then isnull(hs_valor,
                                         $0)
                    else 0
                  end),credito =(case hs_tipo_transaccion
                    when 303 then isnull(hs_valor,
                                         $0)
                    else 0
                  end),
        punto_atn = (select
                       pr_nombre
                     from   cob_remesas..re_punto_red_cb
                     where  ts_ssn          = hs_secuencial
                        and pr_codigo_punto = ts_terminal
                        and pr_codigo_cb    = ts_codcorr),
        referencia = ts_sec_ext,
        hora
        = hs_hora,estado = (case ts_estado
                    when 'A' then 'EXITOSA'
                    when 'X' then 'DECLINADA'
                    when 'R' then 'REVERSADA'
                    else 'NO DEFINIDO'
                  end),cod_alterno = hs_cod_alterno,
        secuencial = convert(varchar(20), hs_secuencial),-- SSN
        usuario = hs_usuario,user_consulta = @s_user
      from   cob_ahorros_his..ah_his_servicio,
             cobis..ws_tran_servicio
      where  hs_tipo_transaccion in (258, 303)
         and hs_cta_banco   = @i_cta_banco
         and hs_secuencial  = ts_ssn
         and hs_tsfecha     >= @i_fchdsde
         and hs_tsfecha     <= @i_fchhsta
         and ts_tipo_tran   = 26519
         -- DISMINUCIONES Y REVERSOS REGISTRAN COMO RETIROS EN LA WS_TRAN_SERVICIO
         and ((hs_hora        = @i_hora
               and hs_secuencial  = @i_sec
               and hs_cod_alterno > @i_sec_alt)
               or (hs_hora        = @i_hora
                   and hs_secuencial  > @i_sec)
               or (hs_hora > @i_hora))

    insert into cob_ahorros..tmp_consulta_mov_cb
                (id,cuenta,fecha,descripcion,debito,
                 credito,punto_atn,referencia,hora,estado,
                 cod_alterno,secuencial,usuario,user_consulta)
      select
        row_number()
          over(
            order by hora, secuencial, cod_alterno),cuenta,fecha,descripcion,
        debito,
        credito,punto_atn,referencia,hora,estado,
        cod_alterno,secuencial,usuario,user_consulta
      from   #consulta_mov_cb

    set rowcount 15

    select
      'FECHA' = fecha,
      'TRANSACCION' = descripcion,
      'DEBITOS' = debito,
      'CREDITOS' =credito,
      'PUNTO ATENCION' = punto_atn,
      'NUM. REFERENCIA' =referencia,
      'HORA' =convert(varchar, hora, 108),
      'ESTADO' =estado,
      'COD. ALTERNO' =cod_alterno,
      'SECUENCIAL' =secuencial,
      'USUARIO' =usuario,
      'ID' = id
    from   cob_ahorros..tmp_consulta_mov_cb
    where  user_consulta = @s_user
       and id            > 0
    order  by id

    if @@rowcount = 15
      select
        @o_hist = 1
    else
      select
        @o_hist = 0

    set rowcount 0

  end

  if @i_operacion = 'S'
  begin
    set rowcount 15

    select
      'FECHA' = fecha,
      'TRANSACCION' = descripcion,
      'DEBITOS' = debito,
      'CREDITOS' =credito,
      'PUNTO ATENCION' = punto_atn,
      'NUM. REFERENCIA' =referencia,
      'HORA' =convert(varchar, hora, 108),
      'ESTADO' =estado,
      'COD. ALTERNO' =cod_alterno,
      'SECUENCIAL' =secuencial,
      'USUARIO' =usuario,
      'ID' = id
    from   cob_ahorros..tmp_consulta_mov_cb
    where  user_consulta = @s_user
       and id            > @i_secuencial
    order  by id

    if @@rowcount = 15
      select
        @o_hist = 1
    else
      select
        @o_hist = 0

    set rowcount 0

  end

  return 0

  ERRORFIN:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_mensaje

  return @w_error

go

