/************************************************************************/
/*      Archivo:                xxnombre.sp xx: Iniciales de base datos */
/*      Stored procedure:       sp_traslado_pasivo                      */
/*      Base de datos:          Cobis                                   */
/*      Producto: Producto Cobis                                        */
/*      Disenado por:  Pedro Rojas                                      */
/*      Fecha de escritura: 10-02-2015                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Permite administrar las solicitudes de traslado de productos    */
/*      pasivos de oficina a oficina                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10/02/2015      P. Rojas        Emision inicial                 */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_traslado_pasivo')
  drop proc sp_traslado_pasivo
go

create proc sp_traslado_pasivo
(
  /* VARIABLES DE SESION DE COBIS KERNEL */
  @s_ssn            int = null,
  @s_user           login = null,
  @s_sesn           int = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_rol            smallint = null,
  @s_ofi            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,

  /* VARIABLES DE TRANSACCION */
  @t_debug          char(1) = 'N',
  @t_trn            smallint = null,
  @t_show_version   bit = 0,

  /* VARIABLES DE ENTRADA MINIMAS */
  @i_operacion      char(2),
  @i_modo           smallint = null,
  @i_estado         varchar(1) = 'V',
  @i_formato_fecha  int = 103,

  /* VARIABLES DE ENTRADA DE LOGICA DE NEGOCIO */
  @i_cliente        int = null,
  @i_ofi_dest       int = null,
  @i_causa_rechazo  char(3) = null,
  @i_tipo_tras      varchar(10) = null,
  @i_estado_tras    char(1) = null,
  @i_num_solicitud  int = null,
  @i_fecha_sol      datetime = null,--Variable para buscar por fecha
  @i_ofi_sol        int = null,--Variable para buscar por oficina
  @i_identificacion varchar(64) = null,

  --Variable para buscar por num identificacion
  @i_nombre         varchar(255) = null,--Variable para buscar por nombre
  @i_autoriza       char(1) = 'N',
  @i_cuenta         varchar(16) = null
/* VARIABLES DE SALIDA */
--@o_funcionario          smallint   out,
--@o_nombre_fun           descripcion out
)
as
  declare
    /* VARIABLES DE TRABAJO */
    @w_sp_name        varchar(32),
    @w_cuenta         int,
    @w_saldo_total    money,
    @w_saldo_dispo    money,
    @w_estado         char(1),
    @w_cta_banco      varchar(16),
    @w_ofi_prod       int,
    @w_tipo_oper      int,
    @w_fecha_aper     datetime,
    @w_cliente        int,
    @w_estado_tras    char(1),
    @w_num_solicitud  int,
    @w_cantidad_sol   int,
    @w_canje          money,
    @w_reg_ahorros    int = 0,
    @w_reg_cdt        int = 0,
    @tr_tipo_traslado varchar(25),
    @traslado         char(1),
    @w_secuencial     int

  /*inicializacion variables de trabajo*/
  select
    @w_sp_name = 'sp_traslado_pasivo',
    @traslado = 'N'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1631
    begin
      /* VALIDA SI YA EXISTE UNA ORDEN DE TRASLADO */
      if exists(select
                  1
                from   cobis..cl_traslado
                where  tr_ente   = @i_cliente
                   and tr_estado = 'I')
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101262
        /* 'Error, ya existe una solicitud de traslado vigente */
        return 101262
      end
      else
      begin
        exec sp_cseqnos
          @i_tabla     = 'cl_traslado',
          @o_siguiente = @w_secuencial out

        if @w_secuencial is null
            or @w_secuencial = 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 190059
          /* 'ERROR EN LA OBTENCION DEL SECUENCIAL */
          return 190059
        end
        begin tran
        /* INGRESA LA NUEVA SOLICITUD DE TRASLADO */

        insert into cobis..cl_traslado
                    (tr_solicitud,tr_ente,tr_tipo_traslado,tr_estado,
                     tr_causa_rechazo,
                     tr_fecha_sol,tr_ofi_solicitud,tr_usr_ingresa,tr_fecha_auto,
                     tr_usr_autoriza,
                     tr_ofi_autoriza,tr_oficina_dest)
        values      (@w_secuencial,@i_cliente,@i_tipo_tras,@i_estado_tras,null,
                     @s_date,@s_ofi,@s_user,null,null,
                     null,@i_ofi_dest)

        if @@error <> 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 101263
          /*  'Error al ingresar la solicitud' */
          return 101263
        end

        /* transaccion de servicio */

        insert into cobis..cl_tran_servicio
                    (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_fecha,
                     ts_usuario,
                     ts_terminal,ts_srv,ts_lsrv,ts_ente,ts_oficina,
                     ts_estado,ts_toperacion,ts_clase,ts_fecha_registro)
        values      (@w_secuencial,1,@t_trn,@s_date,@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_cliente,@s_ofi,
                     @i_estado_tras,@i_operacion,'N',getdate())

        if @@error <> 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 101264
          /*  'Error al insertar en la transervicio' */
          return 101264
        end

      /* INGRESA EL DETALLE DE LA NUEVA SOLICITUD DE TRANSLADO */
        /* Ahorros */

        select
          *
        into   #cuentas_cliente
        from   cob_ahorros..ah_cuenta
        where  ah_cliente = @i_cliente
           and ah_estado in ('A', 'I', 'C', 'G')

        /*ciclo que recorre cada cuenta y toma el valor total del saldo*/

        while 1 = 1
        begin
          select top 1
            @w_cuenta = ah_cuenta,
            @w_cta_banco = ah_cta_banco,
            @w_estado = ah_estado,
            @w_ofi_prod = ah_oficina,
            @w_tipo_oper = ah_prod_banc,
            @w_fecha_aper = ah_fecha_aper,
            @w_canje = (ah_12h + ah_24h + ah_48h)
          from   #cuentas_cliente

          if @@rowcount = 0
            break

          delete #cuentas_cliente
          where  ah_cuenta = @w_cuenta

          /* SI LA CUENTA ESTA CANCELADA, VALIDA QUE TENGA ORDEN DE PAGO */
          if @w_estado = 'C'
          begin
            if not exists(select
                            1
                          from   cob_remesas..re_orden_caja
                          where  oc_ref3   = @w_cta_banco
                             and oc_estado = 'I'
                             and (oc_tipo   = 'P'
                                  and oc_causa in ('035', '014', '012')))
            begin
              goto SIGUIENTE
            end
          end
          /* EJECUTA EL SP QUE PROPORCIONA EL VALOR DEL SALDO TOTAL Y DISPONIBLE */
          exec cob_ahorros..sp_ahcalcula_saldo
            @i_fecha            = @s_date,
            @i_cuenta           = @w_cuenta,
            @o_saldo_para_girar = @w_saldo_dispo out,
            @o_saldo_contable   = @w_saldo_total out

          /* INSERTA EN LA TABLA DEL DETALLE */
          insert into cobis..cl_traslado_detalle
                      (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,
                       td_operacion
                       ,
                       td_tipo_operacion,td_estado_ope,
                       td_saldo_total,td_saldo_dispo,
                       td_fecha_cons,
                       td_fecha_ven,td_monto,td_intereses,td_encanje,
                       td_estado_batch
          )
          values      (@w_secuencial,'4',@w_ofi_prod,@i_ofi_dest,@w_cta_banco,
                       convert(varchar(2), @w_tipo_oper),@w_estado,
                       @w_saldo_total,
                       @w_saldo_dispo,@w_fecha_aper,
                       null,null,null,@w_canje,'I')

          if @@error <> 0
          begin
            exec sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 101265
            /*  'Error al insertar el detalle de la cuenta' */
            return 101265
          end
          SIGUIENTE:
        end /* end while */

        /* CDTS */

        insert into cobis..cl_traslado_detalle
                    (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,
                     td_operacion
                     ,
                     td_tipo_operacion,td_estado_ope,
                     td_saldo_total,td_saldo_dispo,
                     td_fecha_cons,
                     td_fecha_ven,td_monto,td_intereses,td_estado_batch)
          select
            @w_secuencial,'14',op_oficina,@i_ofi_dest,op_num_banco,
            convert(varchar(3), op_toperacion),op_estado,null,null,
            op_fecha_ingreso,
            op_fecha_ven,op_monto,op_int_provision,'I'
          from   cob_pfijo..pf_operacion
          where  op_ente   = @i_cliente
             and op_estado = 'ACT'

        if exists(select
                    1
                  from   cobis..cl_traslado_detalle
                  where  td_solicitud = @w_secuencial
                     and td_producto  = 4
                     and td_encanje   > 0)
           and @i_estado = 'I'
          print 'TRASLADO INGRESADO DE CUENTA DE AHORRO CON CANJE'

        commit tran

      end /*end validacion si existe la solicitud */

    end
    else
    begin /*else de la t_trn */
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 141112
      /*  'Error, la transaccion no permitida' */
      return 141112

    end /* end de la @t_trn */

    return 0

  end /* end operacion I */

/* PREGUNTAR SI LO MANEJO EN UN BEGIN TRAN commit tran */
  /* ** Update ** */
  if @i_operacion = 'U'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1632
        or @t_trn = 1633
    begin
      /* VERIFICAR SIEMPRE QUE LAS VARIABLES DE ENTRADA REQUERIDAS PARA LA OPERACION TENGAN INFORMACION */
      if (@i_num_solicitud is null)
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101266
        /*  'No se llenaron todos los campos' */
        return 101266
      end

      /* Se valida que la solicitud se encuentre */
      select
        @w_cliente = tr_ente,
        @w_estado_tras = tr_estado
      from   cobis..cl_traslado
      where  tr_solicitud = @i_num_solicitud

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 149094
        /*  'No existe solicitud'*/
        return 149094
      end

      /* Verificacion si el estado de la solicitu es permitido actualizar */

      if @w_estado_tras = 'R'
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101267
        /* 'Estado a actualiar no permitido'*/
        return 101267
      end

      if @w_estado_tras = 'A'
         and @i_estado_tras <> 'R'
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101268
        /* 'Estado a actualiar no permitido'*/
        return 101267
      end

      if @w_estado_tras = 'I'
         and @i_estado_tras not in ('A', 'R')
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101267
        /* 'Estado a actualiar no permitido'*/
        return 101267
      end

      begin tran

      /* Guarda en la transervicio el estado anterior de la solicitud */

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_fecha,
                   ts_usuario,
                   ts_terminal,ts_srv,ts_lsrv,ts_ente,ts_oficina,
                   ts_estado,ts_toperacion,ts_clase)
      values      (@i_num_solicitud,2,@t_trn,@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_cliente,@s_ofi,
                   @w_estado_tras,'U','P')

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101264
        /*  'Error al insertar en la transervicio' */
        return 101264
      end

      /* Realiza la actualizacion del estado del traslado */

      update cobis..cl_traslado
      set    tr_causa_rechazo = @i_causa_rechazo,
             tr_fecha_auto = @s_date,
             tr_usr_autoriza = @s_user,
             tr_ofi_autoriza = @s_ofi,
             tr_estado = @i_estado_tras
      where  tr_solicitud = @i_num_solicitud

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 152001
        /*  'Error en actualizacion del traslado' */
        return 152001
      end

      if @i_estado_tras = 'R'
      begin
        update cobis..cl_traslado_detalle
        set    td_estado_batch = @i_estado_tras
        where  td_solicitud = @i_num_solicitud

        if @@error <> 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 152001
          /*  'Error en actualizacion del traslado' */
          return 152001
        end
      end
      /* Guarda en la transervicio el estado posterior de la solicitud */

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_fecha,
                   ts_usuario,
                   ts_terminal,ts_srv,ts_lsrv,ts_ente,ts_oficina,
                   ts_estado,ts_toperacion,ts_clase,ts_fecha_modificacion)
      values      (@i_num_solicitud,2,@t_trn,@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_cliente,@s_ofi,
                   @i_estado_tras,'U','A',getdate())

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101264
        /*  'Error al insertar en la transervicio' */
        return 101264
      end

      if exists(select
                  1
                from   cobis..cl_traslado_detalle
                where  td_solicitud = @i_num_solicitud
                   and td_producto  = 4
                   and td_encanje   > 0)
         and @i_estado = 'A'
        print 'TRASLADO AUTORIZADO DE CUENTA DE AHORRO CON CANJE'

      commit tran

    end
    else
    begin /* else validacion transaccion */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 141112
        /* 'Error en transaccion no permitida' */
        return 141112
      end
    end /* end validacion transaccion */
  end /* end operacion U */

  /* ** buscar un registro por cliente **  */

  if @i_operacion = 'S1'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1630
    begin
      /* Valida si el cliente es null */
      if @i_cliente is null
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 101266
        /* 'Error cliente no puede ser null' */
        return 101266
      end
      else
      begin
        /* Valida las solicitudes del cliente */

        select
          @w_cantidad_sol = isnull(count(tr_ente),
                                   0)
        from   cobis..cl_traslado
        where  tr_ente   = @i_cliente
           and tr_estado <> 'I'
        group  by tr_ente

        /* Select la informacion de la ultima solicitu de traslado */
        select top 1
          'CANTIDAD DE TRASLADOS' = @w_cantidad_sol,
          'ULTIMO TRASLADO' = convert(varchar(10), tr_fecha_sol, 103),
          'TIPO TRASLADO' = tr_tipo_traslado,
          'DESC TIPO TRASLADO' = (select
                                    c.valor
                                  from   cobis..cl_tabla t,
                                         cobis..cl_catalogo c
                                  where  t.codigo = c.tabla
                                     and t.tabla  = 'cl_tipo_traslado'
                                     and c.codigo = tr_tipo_traslado),
          'COD OFICINA AUTO' = tr_ofi_autoriza,
          'OFICINA AUTORIZACION' = (select
                                      of_nombre
                                    from   cobis..cl_oficina
                                    where  of_oficina = tr_ofi_autoriza),
          'ESTADO TRASLADO' = tr_estado,
          'DESC ESTADO TRASLADO' = (select
                                      c.valor
                                    from   cobis..cl_tabla t,
                                           cobis..cl_catalogo c
                                    where  t.codigo = c.tabla
                                       and t.tabla  = 'cl_estado_traslado'
                                       and c.codigo = tr_estado),
          'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
          'USUARIO AUTORIZANTE' = tr_usr_autoriza,
          'OFICINA SOLICITUD' = tr_ofi_solicitud,
          'DESC OFICINA SOLICITUD'= (select
                                       of_nombre
                                     from   cobis..cl_oficina
                                     where  of_oficina = tr_ofi_solicitud),
          'OFICINA DESTINO' = tr_oficina_dest,
          'DESC OFICINA DESTINO' = (select
                                      of_nombre
                                    from   cobis..cl_oficina
                                    where  of_oficina = tr_oficina_dest),
          'CAUSAL RECHAZO' = tr_causa_rechazo,
          'DESC CAUSAL RECHAZO' = (select
                                     c.valor
                                   from   cobis..cl_tabla t,
                                          cobis..cl_catalogo c
                                   where  t.codigo = c.tabla
                                      and t.tabla  = 'cl_rechazo_traslado'
                                      and c.codigo = tr_causa_rechazo)
        from   cobis..cl_traslado
        where  tr_ente = @i_cliente
           and tr_estado in ('A', 'P')
        order  by tr_fecha_sol,
                  tr_solicitud desc

        /* Select de los productos ahorros */

        select
          *
        into   #cuentas_clienteS1
        from   cob_ahorros..ah_cuenta
        where  ah_cliente = @i_cliente
           and ah_estado in ('A', 'I', 'C', 'G')

        /*crea copia de la tabla detalle*/
        select
          *
        into   #cl_traslado_detalle
        from   cobis..cl_traslado_detalle
        where  1 = 2

        /*ciclo que recorre cada cuenta y toma el valor total del saldo*/

        while 1 = 1
        begin
          select top 1
            @w_cuenta = ah_cuenta,
            @w_cta_banco = ah_cta_banco,
            @w_estado = ah_estado,
            @w_ofi_prod = ah_oficina,
            @w_tipo_oper = ah_prod_banc,
            @w_fecha_aper = ah_fecha_aper,
            @w_canje = (ah_12h + ah_24h + ah_48h)
          from   #cuentas_clienteS1

          if @@rowcount = 0
            break

          delete #cuentas_clienteS1
          where  ah_cuenta = @w_cuenta

          /* SI LA CUENTA ESTA CANCELADA, VALIDA QUE TENGA ORDEN DE PAGO */
          if @w_estado = 'C'
          begin
            if not exists(select
                            1
                          from   cob_remesas..re_orden_caja
                          where  oc_ref3   = @w_cta_banco
                             and oc_estado = 'I'
                             and (oc_tipo   = 'P'
                                  and oc_causa in ('035', '014', '012')))
            begin
              goto SIGUIENTE1
            end
          end

          /* EJECUTA EL SP QUE PROPORCIONA EL VALOR DEL SALDO TOTAL Y DISPONIBLE */
          exec cob_ahorros..sp_ahcalcula_saldo
            @i_fecha            = @s_date,
            @i_cuenta           = @w_cuenta,
            @o_saldo_para_girar = @w_saldo_dispo out,
            @o_saldo_contable   = @w_saldo_total out

          /* INSERTA EN LA TABLA DEL DETALLE */
          insert into #cl_traslado_detalle
                      (td_solicitud,td_producto,td_ofi_orig,td_ofi_dest,
                       td_operacion
                       ,
                       td_tipo_operacion,td_estado_ope,
                       td_saldo_total,td_saldo_dispo,
                       td_fecha_cons,
                       td_fecha_ven,td_monto,td_intereses,td_encanje)
          values      (@w_secuencial,'4',@w_ofi_prod,@i_ofi_dest,@w_cta_banco,
                       convert(varchar(2), @w_tipo_oper),@w_estado,
                       @w_saldo_total,
                       @w_saldo_dispo,@w_fecha_aper,
                       null,null,null,@w_canje)

          if @@error <> 0
          begin
            exec sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 101265
            /*  'Error al insertar el detalle de la cuenta' */
            return 101265
          end
          SIGUIENTE1:
        end /* end while */

        /* CDTS */
        insert into #cl_traslado_detalle
                    (td_solicitud,td_producto,td_ofi_orig,td_operacion,
                     td_tipo_operacion,
                     td_estado_ope,td_saldo_total,td_saldo_dispo,td_fecha_cons,
                     td_fecha_ven,
                     td_monto,td_intereses)
          select
            @w_secuencial,'14',op_oficina,op_num_banco,
            convert(varchar(3), op_toperacion
            ),
            op_estado,null,null,op_fecha_ingreso,op_fecha_ven,
            op_monto,op_int_provision
          from   cob_pfijo..pf_operacion
          where  op_ente   = @i_cliente
             and op_estado = 'ACT'
      end

      select
        'PRODUCTO' = td_producto,
        'NUMERO PRODUCTO' = td_operacion,
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'TIPO PRODUCTO' = (select
                             pb_descripcion
                           from   cob_remesas..pe_pro_bancario
                           where  pb_pro_bancario = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2453
                                and codigo = td_estado_ope),
        'SALDO TOTAL' = td_saldo_total,
        'SALDO DISPONIBLE' = td_saldo_dispo,
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   #cl_traslado_detalle
      where  td_producto = '4'

      select
        @w_reg_ahorros = @@rowcount

      select
        'PRODUCTO' = td_producto,
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'NUMERO PRODUCTO' = td_operacion,
        'TIPO PRODUCTO' = (select
                             td_descripcion
                           from   cob_pfijo..pf_tipo_deposito
                           where  td_estado    = 'A'
                              and td_mnemonico = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2348
                                and codigo = td_estado_ope),
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'FECHA VENCIMIENTO' = convert(varchar(10), td_fecha_ven, 103),
        'MONTO' = td_monto,
        'PROVISION INTERES' = td_intereses,
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   #cl_traslado_detalle
      where  td_producto = '14'

      select
        @w_reg_cdt = @@rowcount

      if @w_reg_ahorros = 0
         and @w_reg_cdt = 0
      begin
        print 'Cliente sin productos en estado disponible para trasladar'
      end

      return 0
    end
    else
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 141112
      /*  'Transaccion no permitida' */
      return 141112
    end
  end

  if @i_operacion = 'S2'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1630
    begin
      /* POR ESTANDAR SE DEBE SETEAR LA CANTIDAD DE REGISTROS A MAPEAR AL FRONTEND EN 20 */
      set rowcount 20
      /* SE ESTABLECE MODO 0 COMO LA PRESENTACION DE LOS PRIMEROS 20 REGISTROS */
      if @i_modo = 0
      begin
        if @i_autoriza = 'S'
        begin
          select
            '   ' = '   ',
            'NUM SOLICITUD' = tr_solicitud,
            'COD CLIENTE' = tr_ente,
            'NUM IDENTIFICACION' = en_ced_ruc,
            'NOMBRE DEL CLIENTE' = en_nomlar,
            'OFICINA DESTINO' = tr_oficina_dest,
            'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
            'ESTADO SOLICITUD' = tr_estado,
            'OFICINA SOLICITANTE' = tr_ofi_solicitud,
            'USUARIO SOLICITANTE' = tr_usr_ingresa,
            'CAUSA RECHAZO' = tr_causa_rechazo,
            'TIPO TRASLADO' = tr_tipo_traslado
          from   cobis..cl_traslado,
                 cobis..cl_ente
          where  tr_ente      = en_ente
             and (en_ente      = @i_cliente
                   or @i_cliente is null)
             and (en_ced_ruc   = @i_identificacion
                   or @i_identificacion is null)
             and (en_nomlar like '%' + @i_nombre + '%'
                   or en_nomlar    <> isnull(@i_nombre,
                                             ' '))
             and (tr_fecha_sol <= @i_fecha_sol
                   or @i_fecha_sol is null)
             and tr_estado in('I', 'A')
          order  by tr_solicitud desc
          /*SE DEBE LIBERAR LA CANTIDAD DE FILAS, PARA NO IMPACTAR LA EJECUCIËN EN MODOS SIGUIENTES */

          set rowcount 0
        end
        else
        begin
          select
            '   ' = '   ',
            'NUM SOLICITUD' = tr_solicitud,
            'COD CLIENTE' = tr_ente,
            'NUM IDENTIFICACION' = en_ced_ruc,
            'NOMBRE DEL CLIENTE' = en_nomlar,
            'OFICINA DESTINO' = tr_oficina_dest,
            'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
            'ESTADO SOLICITUD' = tr_estado,
            'OFICINA SOLICITANTE' = tr_ofi_solicitud,
            'USUARIO SOLICITANTE' = tr_usr_ingresa,
            'CAUSA RECHAZO' = tr_causa_rechazo,
            'TIPO TRASLADO' = tr_tipo_traslado
          from   cobis..cl_traslado,
                 cobis..cl_ente
          where  tr_ente      = en_ente
             and (en_ente      = @i_cliente
                   or @i_cliente is null)
             and (en_ced_ruc   = @i_identificacion
                   or @i_identificacion is null)
             and (en_nomlar like '%' + @i_nombre + '%'
                   or en_nomlar    <> isnull(@i_nombre,
                                             ' '))
             and (tr_fecha_sol <= @i_fecha_sol
                   or @i_fecha_sol is null)
          order  by tr_solicitud desc
          /*SE DEBE LIBERAR LA CANTIDAD DE FILAS, PARA NO IMPACTAR LA EJECUCIËN EN MODOS SIGUIENTES */

          set rowcount 0
        end
      end

      if @i_modo = 1
      begin
        if @i_autoriza = 'S'
        begin
          select
            '   ' = '   ',
            'NUM SOLICITUD' = tr_solicitud,
            'COD CLIENTE' = tr_ente,
            'NUM IDENTIFICACION' = en_ced_ruc,
            'NOMBRE DEL CLIENTE' = en_nomlar,
            'OFICINA DESTINO' = tr_oficina_dest,
            'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
            'ESTADO SOLICITUD' = tr_estado,
            'OFICINA SOLICITANTE' = tr_ofi_solicitud,
            'USUARIO SOLICITANTE' = tr_usr_ingresa,
            'CAUSA RECHAZO' = tr_causa_rechazo,
            'TIPO TRASLADO' = tr_tipo_traslado
          from   cobis..cl_traslado,
                 cobis..cl_ente
          where  tr_ente      = en_ente
             and (en_ente      = @i_cliente
                   or @i_cliente is null)
             and (en_ced_ruc   = @i_identificacion
                   or @i_identificacion is null)
             and (en_nomlar like '%' + @i_nombre + '%'
                   or en_nomlar    <> isnull(@i_nombre,
                                             ' '))
             and (tr_fecha_sol <= @i_fecha_sol
                   or @i_fecha_sol is null)
             and tr_estado in('I', 'A')
             and tr_solicitud > @i_num_solicitud
          /*SE DEBE LIBERAR LA CANTIDAD DE FILAS, PARA NO IMPACTAR LA EJECUCIËN EN MODOS SIGUIENTES */
          order  by tr_solicitud desc
          set rowcount 0
        end
        else
        begin
          select
            '   ' = '   ',
            'NUM SOLICITUD' = tr_solicitud,
            'COD CLIENTE' = tr_ente,
            'NUM IDENTIFICACION' = en_ced_ruc,
            'NOMBRE DEL CLIENTE' = en_nomlar,
            'OFICINA DESTINO' = tr_oficina_dest,
            'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
            'ESTADO SOLICITUD' = tr_estado,
            'OFICINA SOLICITANTE' = tr_ofi_solicitud,
            'USUARIO SOLICITANTE' = tr_usr_ingresa,
            'CAUSA RECHAZO' = tr_causa_rechazo,
            'TIPO TRASLADO' = tr_tipo_traslado
          from   cobis..cl_traslado,
                 cobis..cl_ente
          where  tr_ente      = en_ente
             and (en_ente      = @i_cliente
                   or @i_cliente is null)
             and (en_ced_ruc   = @i_identificacion
                   or @i_identificacion is null)
             and (en_nomlar like '%' + @i_nombre + '%'
                   or en_nomlar    <> isnull(@i_nombre,
                                             ' '))
             and (tr_fecha_sol <= @i_fecha_sol
                   or @i_fecha_sol is null)
             and tr_solicitud > @i_num_solicitud
          /*SE DEBE LIBERAR LA CANTIDAD DE FILAS, PARA NO IMPACTAR LA EJECUCIËN EN MODOS SIGUIENTES */
          order  by tr_solicitud desc
          set rowcount 0
        end
      end
    end
    else
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 141112
      /*  'No corresponde codigo de transaccion' */
      return 141112
    end
  end

  if @i_operacion = 'S3'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1630
    begin
      /* POR ESTANDAR SE DEBE SETEAR LA CANTIDAD DE REGISTROS A MAPEAR AL FRONTEND EN 20 */
      set rowcount 20

      select
        @w_cantidad_sol = isnull(count(tr_ente),
                                 0)
      from   cobis..cl_traslado
      where  tr_ente   = @i_cliente
         and tr_estado <> 'I'
      group  by tr_ente

      --print 'Sol ' + cast(@w_cantidad_sol as varchar)
      /* Select la informacion de la ultima solicitu de traslado */
      select top 1
        'CANTIDAD DE TRASLADOS' = @w_cantidad_sol,
        'ULTIMO TRASLADO' = convert(varchar(10), tr_fecha_sol, 103),
        'TIPO TRASLADO' = tr_tipo_traslado,
        'DESC TIPO TRASLADO' = (select
                                  c.valor
                                from   cobis..cl_tabla t,
                                       cobis..cl_catalogo c
                                where  t.codigo = c.tabla
                                   and t.tabla  = 'cl_tipo_traslado'
                                   and c.codigo = tr_tipo_traslado),
        'COD OFICINA AUTO' = tr_ofi_autoriza,
        'OFICINA AUTORIZACION' = (select
                                    of_nombre
                                  from   cobis..cl_oficina
                                  where  of_oficina = tr_ofi_autoriza),
        'ESTADO TRASLADO' = tr_estado,
        'DESC ESTADO TRASLADO' = (select
                                    c.valor
                                  from   cobis..cl_tabla t,
                                         cobis..cl_catalogo c
                                  where  t.codigo = c.tabla
                                     and t.tabla  = 'cl_estado_traslado'
                                     and c.codigo = tr_estado),
        'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
        'USUARIO AUTORIZANTE' = tr_usr_autoriza,
        'OFICINA SOLICITUD' = tr_ofi_solicitud,
        'DESC OFICINA SOLICITUD'= (select
                                     of_nombre
                                   from   cobis..cl_oficina
                                   where  of_oficina = tr_ofi_solicitud),
        'OFICINA DESTINO' = tr_oficina_dest,
        'DESC OFICINA DESTINO' = (select
                                    of_nombre
                                  from   cobis..cl_oficina
                                  where  of_oficina = tr_oficina_dest),
        'CAUSAL RECHAZO' = tr_causa_rechazo,
        'DESC CAUSAL RECHAZO' = (select
                                   c.valor
                                 from   cobis..cl_tabla t,
                                        cobis..cl_catalogo c
                                 where  t.codigo = c.tabla
                                    and t.tabla  = 'cl_rechazo_traslado'
                                    and c.codigo = tr_causa_rechazo)
      from   cobis..cl_traslado
      where  tr_solicitud = @i_num_solicitud
      order  by tr_fecha_sol,
                tr_solicitud desc

      /* SE ESTABLECE MODO 0 COMO LA PRESENTACION DE LOS PRIMEROS 20 REGISTROS */
      select
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'NUMERO PRODUCTO' = td_operacion,
        'TIPO PRODUCTO' = (select
                             pb_descripcion
                           from   cob_remesas..pe_pro_bancario
                           where  pb_pro_bancario = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2453
                                and codigo = td_estado_ope),
        'SALDO TOTAL' = td_saldo_total,
        'SALDO DISPONIBLE' = td_saldo_dispo,
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   cobis..cl_traslado_detalle
      where  td_producto  = '4'
         and td_solicitud = @i_num_solicitud

      select
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'NUMERO PRODUCTO' = td_operacion,
        'TIPO PRODUCTO' = (select
                             td_descripcion
                           from   cob_pfijo..pf_tipo_deposito
                           where  td_estado    = 'A'
                              and td_mnemonico = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2348
                                and codigo = td_estado_ope),
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'FECHA VENCIMIENTO' = convert(varchar(10), td_fecha_ven, 103),
        'MONTO' = td_monto,
        'PROVISION INTERES' = td_intereses,
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   cobis..cl_traslado_detalle
      where  td_producto  = '14'
         and td_solicitud = @i_num_solicitud
    end
    else
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 141112
      /*  'No corresponde codigo de transaccion' */
      return 141112
    end
  end

  if @i_operacion = 'S4'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 4162
    begin
      select top 1
        @traslado = 'S',
        @tr_tipo_traslado = (select
                               c.valor
                             from   cobis..cl_tabla t,
                                    cobis..cl_catalogo c
                             where  t.codigo = c.tabla
                                and t.tabla  = 'cl_tipo_traslado'
                                and c.codigo = tr_tipo_traslado),
        @w_num_solicitud = tr_solicitud,
        @w_cliente = tr_ente
      from   cobis..cl_traslado,
             cobis..cl_traslado_detalle
      where  tr_solicitud = td_solicitud
         and td_operacion = @i_cuenta
      order  by tr_fecha_traslado desc

      select
        @traslado,
        @tr_tipo_traslado,
        @w_num_solicitud,
        @w_cliente
    end
  end

  if @i_operacion = 'S5'
  begin
    /* VALIDACION DE OPERACION Y CODIGO DE TRANSACCION */
    if @t_trn = 1630
    begin
      /* POR ESTANDAR SE DEBE SETEAR LA CANTIDAD DE REGISTROS A MAPEAR AL FRONTEND EN 20 */
      set rowcount 20

      select
        @w_cantidad_sol = isnull(count(tr_ente),
                                 0)
      from   cobis..cl_traslado
      where  tr_ente   = @i_cliente
         and tr_estado <> 'I'
      group  by tr_ente

      --print 'Sol ' + cast(@w_cantidad_sol as varchar)
      /* Select la informacion de la ultima solicitu de traslado */
      select top 1
        'CANTIDAD DE TRASLADOS' = @w_cantidad_sol,
        'ULTIMO TRASLADO' = convert(varchar(10), tr_fecha_sol, 103),
        'TIPO TRASLADO' = tr_tipo_traslado,
        'DESC TIPO TRASLADO' = (select
                                  c.valor
                                from   cobis..cl_tabla t,
                                       cobis..cl_catalogo c
                                where  t.codigo = c.tabla
                                   and t.tabla  = 'cl_tipo_traslado'
                                   and c.codigo = tr_tipo_traslado),
        'COD OFICINA AUTO' = tr_ofi_autoriza,
        'OFICINA AUTORIZACION' = (select
                                    of_nombre
                                  from   cobis..cl_oficina
                                  where  of_oficina = tr_ofi_autoriza),
        'ESTADO TRASLADO' = tr_estado,
        'DESC ESTADO TRASLADO' = (select
                                    c.valor
                                  from   cobis..cl_tabla t,
                                         cobis..cl_catalogo c
                                  where  t.codigo = c.tabla
                                     and t.tabla  = 'cl_estado_traslado'
                                     and c.codigo = tr_estado),
        'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
        'USUARIO AUTORIZANTE' = tr_usr_autoriza,
        'OFICINA SOLICITUD' = tr_ofi_solicitud,
        'DESC OFICINA SOLICITUD'= (select
                                     of_nombre
                                   from   cobis..cl_oficina
                                   where  of_oficina = tr_ofi_solicitud),
        'OFICINA DESTINO' = tr_oficina_dest,
        'DESC OFICINA DESTINO' = (select
                                    of_nombre
                                  from   cobis..cl_oficina
                                  where  of_oficina = tr_oficina_dest),
        'CAUSAL RECHAZO' = tr_causa_rechazo,
        'DESC CAUSAL RECHAZO' = (select
                                   c.valor
                                 from   cobis..cl_tabla t,
                                        cobis..cl_catalogo c
                                 where  t.codigo = c.tabla
                                    and t.tabla  = 'cl_rechazo_traslado'
                                    and c.codigo = tr_causa_rechazo)
      from   cobis..cl_traslado
      where  tr_solicitud = @i_num_solicitud
      order  by tr_fecha_sol,
                tr_solicitud desc

      /* SE ESTABLECE MODO 0 COMO LA PRESENTACION DE LOS PRIMEROS 20 REGISTROS */
      select
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'NUMERO PRODUCTO' = td_operacion,
        'TIPO PRODUCTO' = (select
                             pb_descripcion
                           from   cob_remesas..pe_pro_bancario
                           where  pb_pro_bancario = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2453
                                and codigo = td_estado_ope),
        'SALDO TOTAL' = td_saldo_total,
        'SALDO DISPONIBLE' = td_saldo_dispo,
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   cobis..cl_traslado_detalle
      where  td_producto  = '4'
         and td_solicitud = @i_num_solicitud

      select
        'OFICINA' = (select
                       of_nombre
                     from   cobis..cl_oficina
                     where  of_oficina = td_ofi_orig),
        'NUMERO PRODUCTO' = td_operacion,
        'TIPO PRODUCTO' = (select
                             td_descripcion
                           from   cob_pfijo..pf_tipo_deposito
                           where  td_estado    = 'A'
                              and td_mnemonico = td_tipo_operacion),
        'ESTADO PRODUCTO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = 2348
                                and codigo = td_estado_ope),
        'FECHA APERTURA' = convert(varchar(10), td_fecha_cons, 103),
        'FECHA VENCIMIENTO' = convert(varchar(10), td_fecha_ven, 103),
        'MONTO' = td_monto,
        'PROVISION INTERES' = td_intereses,
        'SALDO EN CANJE' = isnull(td_encanje,
                                  0)
      from   cobis..cl_traslado_detalle
      where  td_producto  = '14'
         and td_solicitud = @i_num_solicitud

      select
        '   ' = '   ',
        'NUM SOLICITUD' = tr_solicitud,
        'COD CLIENTE' = tr_ente,
        'NUM IDENTIFICACION' = en_ced_ruc,
        'NOMBRE DEL CLIENTE' = en_nomlar,
        'OFICINA DESTINO' = tr_oficina_dest,
        'FECHA SOLICITUD' = convert(varchar(10), tr_fecha_sol, 103),
        'ESTADO SOLICITUD' = tr_estado,
        'OFICINA SOLICITANTE' = tr_ofi_solicitud,
        'USUARIO SOLICITANTE' = tr_usr_ingresa,
        'CAUSA RECHAZO' = tr_causa_rechazo,
        'TIPO TRASLADO' = tr_tipo_traslado
      from   cobis..cl_traslado,
             cobis..cl_ente
      where  tr_ente      = en_ente
         and tr_solicitud = @i_num_solicitud
      /*SE DEBE LIBERAR LA CANTIDAD DE FILAS, PARA NO IMPACTAR LA EJECUCIÓN EN MODOS SIGUIENTES */
      order  by tr_solicitud desc
    end
    else
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 141112
      /*  'No corresponde codigo de transaccion' */
      return 141112
    end
  end

  return 0

go

