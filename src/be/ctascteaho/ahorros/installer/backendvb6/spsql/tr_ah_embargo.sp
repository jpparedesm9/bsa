use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_ah_embargo.sp                                */
/*  Stored procedure:   sp_tr_ah_embargo                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:               Cuentas Corrientes                          */
/*  Disenado por:           Carmen Milan                                */
/*  Fecha de escritura:     10-Jul-2002                                 */
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
/*  Este programa realiza las operaciones necesarias sobre la tabla     */
/*      de embargos.                                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Jul/2002 A. Pazminio Emision inicial                             */
/*  08/Abr/2005 D. Villagomez   Embargo Pendiente                       */
/*  12/Abr/2005 D. Villagomez   Embargo sobre el disponible             */
/*  11/May/2005 D. Villagomez   No embargar ctas de menores             */
/*  18/May/2005 D. Villagomez   Levantar embargos con valor             */
/*                                      pendientes                      */
/*  14/Jul/2006 R. Ramos    Adicion de fideicomiso                      */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_ah_embargo')
  drop proc sp_tr_ah_embargo
go

create proc sp_tr_ah_embargo
(
  @s_ssn             int=null,
  @s_ssn_branch      int=null,
  @s_srv             varchar(30)=null,
  @s_lsrv            varchar(30)=null,
  @s_user            varchar(30)=null,
  @s_sesn            int=null,
  @s_term            varchar(10)=null,
  @s_date            datetime=null,
  @s_ofi             smallint=null,/* Localidad origen transaccion */
  @s_rol             smallint=null,
  @s_org_err         char(1) = null,/* Origen de error:[A], [S] */
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_org             char(1)=null,
  @s_msg             mensaje = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_rty             char(1) = 'N',
  @t_trn             smallint=null,
  @t_corr            char(1)= 'N',
  @t_show_version    bit = 0,
  @t_ssn_corr        int= null,
  @i_nombre          descripcion=null,
  @i_opcion          char(1),
  @i_cta_banco       cuenta,
  @i_mon             tinyint,
  @i_tembargo        char(1)=null,
  @i_monto           money=null,
  @i_juez            varchar(64)=null,
  @i_juzgado         varchar(64)=null,
  @i_referencia      varchar(64)=null,
  @i_notificador     varchar(64)=null,
  @i_oficial         varchar(64)=null,
  @i_promovido_por   varchar(64)=null,
  @i_comentario      varchar(64)=null,
  @i_secuencial      int=null,
  @i_id_embargo      char(1) =null,
  @i_fechaoficio     datetime=null,
  @i_autoridad       char(4)=null,
  @i_turno           smallint = null,
  @i_corresponsal    char(1) = 'N',--Req. 381 CB Red Posicionada
  @o_valor_emb       money = 0 out,
  @o_valor_pendiente money = 0 out
)
as
  declare
    @w_usadeci         char(1),
    @w_sp_name         varchar(30),
    @w_numdeci         tinyint,
    @w_estado          char(1),
    @w_disponible      money,
    @w_categoria       char(1),
    @w_prod_ban        smallint,
    @w_tipocta_super   char(1),
    @w_oficina_cta     smallint,
    @w_tipocta         char(1),
    @w_saldo_a_girar   money,
    @w_saldo_contable  money,
    @w_monto_emb       money,
    @w_seq_embargo     int,
    @w_return          int,
    @w_cuenta          int,
    @w_saldo_minemb    money,
    @w_moneda          tinyint,
    @w_moneda_local    tinyint,
    @w_msg             char(80),
    @w_monto_pendiente money,
    @w_oficina_cta2    smallint,
    @w_porcion         money,
    @w_tipo_ente       char(1),
    @w_ente            int,
    @w_fecha_nac       datetime,
    @w_mayor_edad      tinyint,
    @w_fecha_hoy       datetime,
    @w_dia_hoy         smallint,
    @w_num_anios       tinyint,
    @w_mes_hoy         tinyint,
    @w_mes_nac         tinyint,
    @w_dia_nac         tinyint,
    @w_det_prod        int,
    @w_producto        tinyint,
    @w_oficina         smallint,
    @w_tipo            char(1),
    @w_continuar       tinyint,
    @w_fideicomiso     varchar(15),
    @w_prod_bancario   varchar(50) --Req. 381 CB Red Posicionada

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_tr_ah_embargo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_fecha_hoy = convert(varchar(10), @s_date, 101)

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  --Modo de debug
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
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
      t_trn = @t_trn,
      i_nombre = @i_nombre
    exec cobis..sp_end_debug
  end

  select
    @w_moneda_local = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201196
    return 1
  end

  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'
    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201196
      return 1
    end
  end
  else
    select
      @w_numdeci = 0

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado,
      @w_categoria = ah_categoria,
      @w_prod_ban = ah_prod_banc,
      @w_tipocta_super = ah_tipocta_super,
      @w_tipocta = ah_tipocta,
      @w_oficina_cta = ah_oficina,
      @w_tipocta = ah_tipocta,
      @w_moneda = ah_moneda,
      @w_ente = ah_cliente,
      @w_producto = ah_producto,
      @w_oficina = ah_oficina,
      @w_tipo = ah_tipo,
      @w_disponible = (ah_disponible - ah_monto_bloq - ah_monto_emb
                       - ah_monto_consumos),
      @w_fideicomiso = ah_fideicomiso
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado,
      @w_categoria = ah_categoria,
      @w_prod_ban = ah_prod_banc,
      @w_tipocta_super = ah_tipocta_super,
      @w_tipocta = ah_tipocta,
      @w_oficina_cta = ah_oficina,
      @w_tipocta = ah_tipocta,
      @w_moneda = ah_moneda,
      @w_ente = ah_cliente,
      @w_producto = ah_producto,
      @w_oficina = ah_oficina,
      @w_tipo = ah_tipo,
      @w_disponible = (ah_disponible - ah_monto_bloq - ah_monto_emb
                       - ah_monto_consumos),
      @w_fideicomiso = ah_fideicomiso
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
  end

  if @w_estado <> 'A'
  begin
    /* Error Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101128
    return 101128
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_a_girar out,
    @o_saldo_contable   = @w_saldo_contable out

  if @w_return <> 0
    return @w_return

  -- VALIDA QUE LA CUENTA NO TENGA UN MENOR DE EDAD
  -- Obtencion de datos del ente propietario de la cuenta

  select
    @w_det_prod = dp_det_producto
  from   cobis..cl_det_producto
  where  dp_cuenta   = @i_cta_banco
     and dp_producto = @w_producto
     and dp_oficina  = @w_oficina
     and dp_tipo     = @w_tipo
     and dp_moneda   = @i_mon
  set transaction isolation level read uncommitted

  --print '@w_det_prod %1!',@w_det_prod

  select
    @w_continuar = 2,
    @w_ente = 0

  while (@w_continuar > 1)
  begin
    --print '@w_continuar %1!',@w_continuar
    set rowcount 1
    select
      @w_ente = en_ente,
      @w_fecha_nac = p_fecha_nac,
      @w_tipo_ente = en_subtipo
    from   cobis..cl_ente,
           cobis..cl_cliente
    where  cl_det_producto = @w_det_prod
       and en_ente         = cl_cliente
       and en_ente         > @w_ente
    set transaction isolation level read uncommitted

    if @@rowcount = 0
    begin
      set rowcount 0
      select
        @w_continuar = 0
    end
    set rowcount 0

    --print '@w_ente %1!',@w_ente

    if @w_tipo_ente = 'P'
    begin -- 1
      --print 'valida'
      select
        @w_mayor_edad = pa_tinyint
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'MDE'

      if @@rowcount <> 1
      begin /* Error en lectura de SSN */
        exec cobis..sp_cerror
          @i_num = 111020,
          @i_msg = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
        return 111020
      end

      --print '@w_mayor_edad %1!',@w_mayor_edad

      select
        @w_dia_hoy = datepart(dd,
                              @w_fecha_hoy)
      -- Valida la mayoria de edad

      select
        @w_num_anios = datediff(yy,
                                @w_fecha_nac,
                                @w_fecha_hoy)

      --print '@w_num_anios %1!',@w_num_anios

      if @w_num_anios < @w_mayor_edad
      begin
        -- print 'menos anios'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251085
        return 251085 -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
      end
      else
      begin -- 2
        if @w_num_anios = @w_mayor_edad
        begin -- 3
          --print 'igual anos'
          select
            @w_mes_hoy = datepart(mm,
                                  @w_fecha_hoy)
          select
            @w_mes_nac = datepart(mm,
                                  @w_fecha_nac)
          if @w_mes_hoy < @w_mes_nac
          begin
            -- print 'mes menor'
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 251085
            return 251085
          -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
          end
          else
          begin -- 4
            if @w_mes_hoy = @w_mes_nac
            begin
              select
                @w_dia_nac = datepart(dd,
                                      @w_fecha_nac)
              if @w_dia_hoy < @w_dia_nac
              begin
                exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 251085
                return 251085
              -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
              end
            end
          end -- 4
        end -- 3
      end -- 2
    end -- 1
    select
      @w_continuar = @w_continuar + 1

  end -- while

  if @t_trn = 327
  begin
    if @w_tipocta = 'P'
    begin
      select
        @w_saldo_minemb = pa_money
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'SMEAH'

      if @@rowcount = 0
        select
          @w_saldo_minemb = 0

      if @w_moneda <> @w_moneda_local
      begin
        select
          @w_saldo_minemb = isnull(round(@w_saldo_minemb / ct_valor,
                                         @w_numdeci),
                                   0)
        from   cob_conta..cb_cotizacion
        where  /*ct_empresa = 1
                                             and */
          ct_fecha  = convert(char(10), @s_date, 101)
        and ct_moneda = @w_moneda
      end

      if @w_disponible < @w_saldo_minemb
      begin
        /* El saldo para girar es menor al monto minimo legal de embargo */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'SALDO LIQ DISPONIBLE MENOR A MONTO MINIMO LEGAL ('
                   + ltrim(convert(char(30), @w_saldo_minemb)) + ')'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 201072
        return 1
      end
    end

    if @i_opcion = 'I'
    begin
      if exists (select
                   1
                 from   cob_ahorros..ah_embargo
                 where  he_cta_banco       = @i_cta_banco
                    and he_fecha_lev is null
                    and he_monto_pendiente > 0)
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                   'EXISTE UN EMBARGO CON MONTO PENDIENTE'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 201072
        return 201072
      end

      if @w_fideicomiso is not null
      begin
        /* Fideicomiso existente */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'EXISTE UN FIDEICOMISO, NO SE PUEDE REALIZAR EMBARGO'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 201072
        return 201072
      end
      --print '@w_disponible %1!',@w_disponible
      if @w_disponible <= 0
      begin
        /* No existe disponible para realizar el Embargo */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                   'NO EXISTEN FONDOS PARA REALIZAR EL EMBARGO'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 201072
        return 201072
      end

      if @i_tembargo = 'T'
      begin
        if @i_monto > @w_disponible
        begin
          /* No corresponde el monto total al monto a embargar */
          select
            @w_msg = '[' + @w_sp_name + '] ' +
                            'EMBARGO EXCEDE SALDO, DEFINIR COMO EMBARGO PARCIAL'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 201072
          return 201072
        end

      end

      if @i_tembargo = 'T'
      begin
        if @w_disponible <> @i_monto
        begin
          /* No corresponde el monto total al monto a embargar */
          select
            @w_msg = '[' + @w_sp_name + '] '
                     +
            'EMBARGO TOTAL: SALDO DISPONIBLE NO COINCIDE CON MONTO A EMBARGAR'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 201072
          return 201072
        end
      end

      if @i_tembargo = 'P'
      begin
        if @w_disponible = @i_monto
        begin
          /* No corresponde el monto total al monto a embargar */
          select
            @w_msg = '[' + @w_sp_name + '] '
                     +
  'EMBARGO COINCIDE CON SALDO DISP. LIQUIDO. DEFINA COMO EMBARGO TOTAL'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 201072
          return 201072
        end
      end

      -- TIENE SALDO POSITIVO
      if @w_disponible < @i_monto
        -- EL SALDO A GIRAR ES MENOR QUE EL MONTO DE EMBARGO, SE EMBARGA POR EL MONTO A GIRAR
        -- Y DEJAMOS MONTO DE EMBARGO PENDIENTE.
        select
          @w_monto_emb = @w_disponible,
          @w_monto_pendiente = @i_monto - @w_disponible
      else
        select
          @w_monto_emb = @i_monto,
          @w_monto_pendiente = 0

      select
        @o_valor_emb = @w_monto_emb
      select
        @o_valor_pendiente = @w_monto_pendiente

      exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'ah_embargo',
        @o_siguiente = @w_seq_embargo out

      if @w_return <> 0
        return @w_return

      begin tran
      insert into cob_ahorros..ah_embargo
                  (he_secuencial,he_cta_banco,he_tipo_embargo,he_monto,he_juez,
                   he_juzgado,he_referencia,he_notificador,he_oficial,
                   he_promovido_por
                   ,
                   he_comentario,he_fecha_embargo,he_monto_pendiente,
                   he_monto_solicitado,he_id_embargo,
                   he_fecha_oficio,he_autoridad)
      values      ( @w_seq_embargo,@i_cta_banco,@i_tembargo,@w_monto_emb,@i_juez
                    ,
                    @i_juzgado,@i_referencia,@i_notificador
                    ,@i_oficial,
                    @i_promovido_por,
                    @i_comentario,@s_date,@w_monto_pendiente,@i_monto,
                    @i_id_embargo,
                    @i_fechaoficio,@i_autoridad)

      if @@error <> 0
      begin
        /* Error en creacion de registro en ah_embargo */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                   'ERROR EN CREACION DE REGISTRO EN ah_embargo'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 203070 --NO TIENE MENSAJE ASOCIADO
        return 203070
      end

      update cob_ahorros..ah_cuenta
      set    ah_monto_emb = ah_monto_emb + @w_monto_emb
      where  ah_cta_banco = @i_cta_banco

      if @@error <> 0
      begin
        /* Error en creacion de registro en ah_cuenta */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'ERROR EN ACTUALIZACION DE REGISTRO EN ah_cuenta'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 2600030
        return 2600030
      end

      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   fecha,valor,accion,autorizante,moneda,
                   hora,solicitante,oficina_cta,observacion,prod_banc,
                   categoria,tipocta_super,turno)
      values      (@s_ssn,isnull(@s_ssn_branch,
                          @s_ssn),@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta_banco,
                   @s_date,@w_monto_emb,'B',@s_user,@i_mon,
                   getdate(),@i_promovido_por,@w_oficina_cta,@i_comentario,
                   @w_prod_ban
                   ,
                   @w_categoria,@w_tipocta_super,@i_turno)

      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 203005
        return 1
      end

      -- bloquea la cuenta contra debitos si hay un valor pendiente
      if @w_monto_pendiente > 0
      begin
        -- bloquear la cuenta contra debitos
        exec @w_return = sp_bloqueo_mov_ah
          @s_ssn         = @s_ssn,
          @s_date        = @s_date,
          @s_sesn        = @s_sesn,
          @s_org         = @s_org,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_user        = @s_user,
          @s_term        = @s_term,
          @s_ofi         = @s_ofi,
          @s_rol         = @s_rol,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_ssn_branch  = @s_ssn_branch,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @t_from,
          @t_rty         = @t_rty,
          @t_trn         = 211,
          @i_cta         = @i_cta_banco,
          @i_mon         = @i_mon,
          @i_tbloq       = '2',
          @i_aut         = @s_user,
          @i_solicit     = 'EMBARGO LEGAL AUTOMATICO',
          @i_causa       = '5',
          @i_observacion = @s_user,
          @o_oficina_cta = @w_oficina_cta2 out
        if @w_return <> 0
        begin
          rollback tran
          return @w_return
        end

      end

      commit tran
    end

    -- OPCION PARA DISMINUIR EL MONTO PENDIENTE
    if @i_opcion = 'P'
    begin
      if exists (select
                   1
                 from   cob_ahorros..ah_embargo
                 where  he_cta_banco       = @i_cta_banco
                    and he_fecha_lev is null
                    and he_monto_pendiente > 0
                    and he_secuencial      = @i_secuencial)
      begin
        --print '@w_disponible %1!',@w_disponible

        if @w_disponible <= 0
        begin
          /* No existe disponible para realizar el Embargo */
          select
            @w_msg = '[' + @w_sp_name + '] ' +
                     'NO EXISTEN FONDOS PARA REALIZAR EL EMBARGO'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 201072
          return 201072
        end
        -- TIENE SALDO POSITIVO
        if @w_disponible < @i_monto
          -- EL SALDO A GIRAR ES MENOR QUE EL MONTO DE EMBARGO, SE EMBARGA POR EL MONTO A GIRAR
          -- Y DEJAMOS MONTO DE EMBARGO PENDIENTE.
          select
            @w_porcion = @w_disponible,
            @w_monto_pendiente = @i_monto - @w_disponible
        else
          select
            @w_porcion = @i_monto,
            @w_monto_pendiente = 0

        begin tran
        update cob_ahorros..ah_embargo
        set    he_monto_pendiente = he_monto_pendiente - @w_porcion,
               he_monto = he_monto + @w_porcion
        where  he_cta_banco  = @i_cta_banco
           and he_secuencial = @i_secuencial

        if @@error <> 0
        begin
          /* Error en actualización en ah_embargo */
          select
            @w_msg = '[' + @w_sp_name + '] ' +
                            'ERROR EN ACTUALIZACION DE REGISTRO EN ah_embargo'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 205053
          return 205053
        end

        update cob_ahorros..ah_cuenta
        set    ah_monto_emb = ah_monto_emb + @w_porcion
        where  ah_cta_banco = @i_cta_banco

        if @@error <> 0
        begin
          /* Error en creacion de registro en ah_cuenta */
          select
            @w_msg = '[' + @w_sp_name + '] ' +
                            'ERROR EN ACTUALIZACION DE REGISTRO EN ah_cuenta'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 2600030
          return 2600030
        end
        /* Creacion de transaccion de servicio */
        insert into cob_ahorros..ah_tsbloqueo
                    (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                     terminal,oficina,reentry,origen,cta_banco,
                     fecha,valor,accion,autorizante,moneda,
                     hora,solicitante,oficina_cta,observacion,prod_banc,
                     categoria,tipocta_super,turno)
        values      (@s_ssn,isnull(@s_ssn_branch,
                            @s_ssn),@t_trn,@s_date,@s_user,
                     @s_term,@s_ofi,@t_rty,@s_org,@i_cta_banco,
                     @s_date,@w_porcion,'B',@s_user,@i_mon,
                     getdate(),@i_promovido_por,@w_oficina_cta,@i_comentario,
                     @w_prod_ban
                     ,
                     @w_categoria,@w_tipocta_super,@i_turno)

        if @@error <> 0
        begin
          /* Error en creacion de transaccion de servicio */
          select
            @w_msg = '[' + @w_sp_name + '] ' +
                            'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg,
            @i_num   = 203005
          return 1
        end
        -- desbloquea la cuenta contra debitos
        if @w_monto_pendiente = 0
        begin
          exec @w_return = sp_bloqueo_mov_ah
            @s_ssn         = @s_ssn,
            @s_date        = @s_date,
            @s_sesn        = @s_sesn,
            @s_org         = @s_org,
            @s_srv         = @s_srv,
            @s_lsrv        = @s_lsrv,
            @s_user        = @s_user,
            @s_term        = @s_term,
            @s_ofi         = @s_ofi,
            @s_rol         = @s_rol,
            @s_org_err     = @s_org_err,
            @s_error       = @s_error,
            @s_sev         = @s_sev,
            @s_msg         = @s_msg,
            @s_ssn_branch  = @s_ssn_branch,
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @t_from,
            @t_rty         = @t_rty,
            @t_trn         = 212,
            @i_cta         = @i_cta_banco,
            @i_mon         = @i_mon,
            @i_tbloq       = '2',
            @i_aut         = @s_user,
            @i_solicit     = 'LEVANTAR EMBARGO LEGAL AUTOMATICO',
            @i_causa       = '4',
            @i_observacion = @s_user,
            @o_oficina_cta = @w_oficina_cta2 out
          if @w_return <> 0
          begin
            rollback tran
            return @w_return
          end
        end

        commit tran
      end
      else
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
          'NO EXISTE VALOR PENDIENTE PARA EL REGISTRO SELECCIONADO'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 201072
        return 201072
      end -- existe
    end
  -- FIN OPCION PARA DISMINUIR EL MONTO PENDIENTE

  end

  if @t_trn = 328
  begin
    if @i_opcion = 'L'
    begin
      --      if exists (select 1 from cob_ahorros..ah_embargo
      --              where he_cta_banco=@i_cta_banco
      --                   and he_fecha_lev is null
      --                   and he_monto_pendiente > 0
      --                   and he_secuencial=@i_secuencial)
      --      begin
      --         select @w_msg = '[' + @w_sp_name + '] ' + 'EMBARGO TIENE MONTO PENDIENTE'
      --            exec cobis..sp_cerror
      --            @t_debug     = @t_debug,
      --            @t_file      = @t_file,
      --            @t_from      = @w_sp_name,
      --            @i_msg       = @w_msg,
      --            @i_num       = 201072
      --         return 201072
      --      end

      begin tran

      update cob_ahorros..ah_embargo
      set    he_fecha_lev = @s_date
      where  he_cta_banco  = @i_cta_banco
         and he_secuencial = @i_secuencial
         and he_fecha_lev is null

      if @@error <> 0
      begin
        /* Error en actualización en ah_embargo */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'ERROR EN ACTUALIZACION DE REGISTRO EN ah_embargo'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 205053
        return 205053
      end

      select
        @w_monto_emb = @i_monto

      update cob_ahorros..ah_cuenta
      set    ah_monto_emb = ah_monto_emb - @w_monto_emb
      where  ah_cta_banco = @i_cta_banco

      if @@error <> 0
      begin
        /* Error en creacion de registro en ah_embargo */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'ERROR EN ACTUALIZACION DE REGISTRO EN ah_cuenta'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 2600030
        return 2600030

      end

      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   fecha,valor,accion,autorizante,moneda,
                   hora,solicitante,oficina_cta,observacion,prod_banc,
                   categoria,tipocta_super,turno)
      values      (@s_ssn,isnull(@s_ssn_branch,
                          @s_ssn),@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta_banco,
                   @s_date,@w_monto_emb,'L',@s_user,@i_mon,
                   getdate(),@i_promovido_por,@w_oficina_cta,@i_comentario,
                   @w_prod_ban
                   ,
                   @w_categoria,@w_tipocta_super,@i_turno)

      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 203005
        return 1
      end

      if exists (select
                   1
                 from   cob_ahorros..ah_ctabloqueada
                 where  cb_cuenta       = @w_cuenta
                    and cb_estado       = 'V'
                    and cb_tipo_bloqueo = '2')
      begin
        exec @w_return = sp_bloqueo_mov_ah
          @s_ssn         = @s_ssn,
          @s_date        = @s_date,
          @s_sesn        = @s_sesn,
          @s_org         = @s_org,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_user        = @s_user,
          @s_term        = @s_term,
          @s_ofi         = @s_ofi,
          @s_rol         = @s_rol,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_ssn_branch  = @s_ssn_branch,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @t_from,
          @t_rty         = @t_rty,
          @t_trn         = 212,
          @i_cta         = @i_cta_banco,
          @i_mon         = @i_mon,
          @i_tbloq       = '2',
          @i_aut         = @s_user,
          @i_solicit     = 'LEVANTAR EMBARGO LEGAL AUTOMATICO',
          @i_causa       = '4',
          @i_observacion = @s_user,
          @o_oficina_cta = @w_oficina_cta2 out
        if @w_return <> 0
        begin
          rollback tran
          return @w_return
        end
      end
      commit tran
    end
  end

  return 0

go

