/************************************************************************/
/*  Archivo           :   plan.sp                                       */
/*  Stored procedure  :   sp_plan                                       */
/*  Base de datos     :   cobis                                         */
/*  Producto          :   Clientes                                      */
/*  Disenado por      :   Sandra Ortiz                                  */
/*  Fecha de escritura:   08-Sep-1993                                   */
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
/*  Mantenimiento de registros de la tabla cl_plan, que corres-         */
/*  ponde a las cuentas asignadas a un balance particular de un         */
/*  cliente.                                                            */
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  08-Sep-1993   S Ortiz     Emision inicial                           */
/*  18-Mar-2003   E Laguna    Cuenta int                                */
/*  11-Jun-2003   D.Duran     Agrego Insert en Opcion. Update           */
/*  21-Feb-2004   D.Duran     Optimizacion siguiente                    */
/*  14-Jun-2006   M.Rincon    Valida Otros Ingresos x Tpo Per           */
/*  05/May/2016   T. Baidal   Migracion a CEN                           */
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
           where  name = 'sp_plan')
    drop proc sp_plan
go

create proc sp_plan
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
  @t_from         varchar(30) = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_cliente      int = null,
  @i_balance      smallint = null,
  @i_tbalance     char(3) = null,
  @i_cuenta       int = null,
  @i_categoria    char(1) = null,
  @i_valor        money = null,
  @i_secuencial   int = null,
  @i_cuenta_b     varchar(30) = null
)
as
  declare
    @w_sp_name  varchar(30),
    @w_balance  smallint,
    @w_valor    money,
    @v_valor    money,
    @w_subtipo  char(1),
    @w_otringr  char(12),
    @w_contador int,
    @w_cta_pnat varchar(30),
    @w_cta_pjur varchar(30)

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_plan'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --MGV 17/07/2006 Validaci¾n a cuentas de balance 15

  if (@t_trn = 128
      and (@i_operacion = 'I'))
      or (@t_trn = 129
          and @i_operacion = 'U')
      or (@t_trn = 1188
          and @i_operacion = 'R')
  begin
    if @i_tbalance = '15'
        or @i_tbalance = '015'
    begin
      /* Recuperar el tipo de persona y la descripcion de otros ingresos del cliente' */
      select
        @w_subtipo = en_subtipo
      from   cobis..cl_ente
      where  en_ente = @i_cliente

      /* Recuperar Cuenta para validar valor Otros Ingresos Persona Nat o valor Ingresos No Operacionales Persona Jur' */
      select
        @w_cta_pnat = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'COIPNA'

      select
        @w_cta_pjur = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'CIOPJU'

      /* Validar que la cuenta tenga valor */
      if (@w_subtipo = 'P'
          and @i_cuenta_b <> @w_cta_pjur
          and @i_valor is null)
          or (@w_subtipo = 'C'
              and @i_cuenta_b <> @w_cta_pnat
              and @i_valor is null)
      begin
        /*  No existe cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101158
        return 1
      end
    end
  end

  /*  Valida Otros Ingresos Transaccion Creacion o Actualizacion Informacion Financiera */

  if @t_trn = 128
  begin
    if @i_operacion = 'V'
    begin
      /* Recuperar el tipo de persona y la descripcion de otros ingresos del cliente' */
      select
        @w_subtipo = en_subtipo,
        @w_otringr = convert(char, en_otringr)
      from   cobis..cl_ente
      where  en_ente = @i_cliente

      /* Recuperar Cuenta para validar valor Otros Ingresos Persona Nat o valor Ingresos No Operacionales Persona Jur' */
      select
        @w_cta_pnat = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'COIPNA'

      select
        @w_cta_pjur = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'CIOPJU'

      /* Verificar Otros Ingresos > 0 si la cuenta ingresada esta parametrizada para validar Otros Ingresos' */
      if @w_otringr is not null
         and ltrim(rtrim(@w_otringr)) <> ''
         and ltrim(rtrim(@w_otringr)) not like
'[A-Z,a-z,'''','' '',''   '',''.'',''0-9'',''ñ'',''Ñ'',-],''Á'',''A'',''N'',''Z'',''O'',''0'''
and ltrim(rtrim(@w_otringr)) <> 'NO'
and ltrim(rtrim(@w_otringr)) <> 'NA'
and ltrim(rtrim(@w_otringr)) <> 'SIN'
and ltrim(rtrim(@w_otringr)) <> 'NINGUNO'
and ltrim(rtrim(@w_otringr)) <> 'NO TIENE'
and ltrim(rtrim(@w_otringr)) <> 'NO APLICA'
and ltrim(rtrim(@w_otringr)) <> 'NO MANEJA'
and ltrim(rtrim(@w_otringr)) <> 'NO A APLICVA'
and ltrim(rtrim(@w_otringr)) <> 'NO TIENE OTROS INGRESOS'
  if (@i_valor is null)
      or (@i_valor <= 0)
  begin
    if @w_subtipo = 'P'
    begin
      if @w_cta_pnat = @i_cuenta_b
      begin
        /* Cuenta Otros Ingresos es obligatoria */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107104
        return 1
      end
    end
    else
    begin
      if @w_cta_pjur = @i_cuenta_b
      begin
        /* Cuenta Ingresos no Operacionales es obligatoria */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107105
        return 1
      end
    end
  end
  else
  begin
    if (@w_subtipo = 'P')
       and (@i_cuenta_b = @w_cta_pjur)
       and (@i_valor > 0)
    begin
      /* Valor ingresos no operacionales invalido para Ente Persona Natural */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 107108
      return 1
    end
    if (@w_subtipo <> 'P')
       and (@i_cuenta_b = @w_cta_pnat)
       and (@i_valor > 0)
    begin
      /* Valor otros ingresos invalido para Ente Persona juridica */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 107109
      return 1
    end
  end
else
begin
  if ((@w_subtipo = 'P')
      and (@i_cuenta_b = @w_cta_pnat)
      and (@i_valor > 0))
      or ((@w_subtipo <> 'P')
          and (@i_cuenta_b = @w_cta_pnat)
          and (@i_valor > 0))
  begin
    /* Otros ingresos no permitido - Ente SIN marca Otros Ingresos */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107110
    return 1
  end
  if ((@w_subtipo <> 'P')
      and (@i_cuenta_b = @w_cta_pjur)
      and (@i_valor > 0))
      or ((@w_subtipo = 'P')
          and (@i_cuenta_b = @w_cta_pjur)
          and (@i_valor > 0))
  begin
    /* Ingresos no operacionales no permitido - Ente SIN marca Ingresos No Operacionales */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 107111
    return 1
  end
end
  return 0
end
end

  /*  Insert en tabla temporal,
      la insercion en la tabla permanente la realiza sp_balance
      o la operacion 'R' en el caso de nuevos registros que
      se adicionan a un balance ya existente */

  if @i_operacion = 'I'
  begin
    if @t_trn = 128
    begin
      /* Verificar que exista la cuenta */
      if not exists (select
                       1
                     from   cl_tplan
                     where  tp_tbalance = @i_tbalance
                        and tp_cuenta   = @i_cuenta)
      begin
        /*  No existe cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101162
        return 1
      end

      begin tran
      /* insertar datos de entrada */
      insert into cl_plan_tmp
                  (pl_cuenta,pl_valor,pl_user,pl_term)
      values      (@i_cuenta,@i_valor,@s_user,@s_term)

      if @@error != 0
      begin
        /*  Error en insercion de plan temporal  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103078
        return 1
      end

      /*  Transaccion de servicio , actual */
      insert into ts_plan
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cliente,balance,
                   cuenta,valor,alterno)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cliente,@i_balance,
                   @i_cuenta,@i_valor,@i_secuencial)
      if @@error != 0
      begin
        /*  Error en la insercion de Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      commit tran
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Insert en tabla real,
      en el caso de nuevos registros que se adicionan a un balance
      ya existente */
  if @i_operacion = 'R'
  begin
    if @t_trn = 1188
    begin
      /* Verificar que exista el balance */
      if not exists (select
                       1
                     from   cl_balance
                     where  ba_balance = @i_balance
                        and ba_cliente = @i_cliente)
      begin
        /*  No existe estado financiero */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101160
        return 1
      end

      /* Verificar que exista la cuenta */
      if not exists (select
                       1
                     from   cl_tplan
                     where  tp_tbalance = @i_tbalance
                        and tp_cuenta   = @i_cuenta)
      begin
        /*  No existe cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101162
        return 1
      end
      else /* Si existe verificar que previamente no se haya usado */
      if exists (select
                   1
                 from   cl_plan
                 where  pl_cuenta  = @i_cuenta
                    and pl_balance = @i_balance
                    and pl_cliente = @i_cliente)
      begin
        /* cuenta duplicada  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101163
        return 1
      end

      begin tran
      /* insertar datos de entrada */
      insert into cl_plan
                  (pl_cliente,pl_balance,pl_cuenta,pl_valor)
      values      (@i_cliente,@i_balance,@i_cuenta,@i_valor)

      if @@error != 0
      begin
        /*  Error en insercion de cuenta de estado financiero */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103076
        return 1
      end

      /*  Transaccion de servicio , actual */
      insert into ts_plan
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cliente,balance,
                   cuenta,valor,alterno)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cliente,@i_balance,
                   @i_cuenta,@i_valor,@i_secuencial)
      if @@error != 0
      begin
        /*  Error en la insercion de Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /* Enviar totales de activo o pasivo */
      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('A', 'I', 'S', 'C')

      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('P', 'T', 'E', 'O') /* RIA01 */

      commit tran
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Update en tabla permanente */
  if @i_operacion = 'U'
  begin
    if @t_trn = 129
    begin
      /* Verificar que exista la cuenta  DDU JUN/11/2003*/
      if not exists (select
                       1
                     from   cl_plan
                     where  pl_cliente = @i_cliente
                        and pl_balance = @i_balance
                        and pl_cuenta  = @i_cuenta)
      begin
        /* insertar datos de entrada */
        insert into cl_plan
                    (pl_cliente,pl_balance,pl_cuenta,pl_valor)
        values      (@i_cliente,@i_balance,@i_cuenta,@i_valor)
      end
      else
        select
          @w_valor = pl_valor
        from   cl_plan
        where  pl_cliente = @i_cliente
           and pl_balance = @i_balance
           and pl_cuenta  = @i_cuenta

      if @w_valor != @i_valor
      begin
        begin tran
        update cl_plan
        set    pl_valor = @i_valor
        where  pl_cliente = @i_cliente
           and pl_balance = @i_balance
           and pl_cuenta  = @i_cuenta
        if @@rowcount != 1
        begin
          /*  Error en actualizacion de Cuenta de Estado Financiero  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 105069
          return 1
        end

        /*  Transaccion de servicio , previo */
        insert into ts_plan
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,cliente,balance,
                     cuenta,valor,alterno)
        values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_cliente,@i_balance,
                     @i_cuenta,@v_valor,@i_secuencial)
        if @@error != 0
        begin
          /*  Error en la insercion de Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end

        /*  Transaccion de servicio , actual */
        insert into ts_plan
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,cliente,balance,
                     cuenta,valor,alterno)
        values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_cliente,@i_balance,
                     @i_cuenta,@w_valor,@i_secuencial)

        if @@error != 0
        begin
          /*  Error en la insercion de Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end

        /* Enviar totales de activo o pasivo */
        select
          sum(pl_valor)
        from   cl_plan,
               cl_cuenta
        where  pl_cuenta  = ct_cuenta
           and pl_cliente = @i_cliente
           and pl_balance = @i_balance
           and ct_categoria in ('A', 'I', 'S', 'C')

        select
          sum(pl_valor)
        from   cl_plan,
               cl_cuenta
        where  pl_cuenta  = ct_cuenta
           and pl_cliente = @i_cliente
           and pl_balance = @i_balance
           and ct_categoria in ('P', 'T', 'E', 'O') /* RIA01 */
        commit tran
      end
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Delete, en tabla temporal  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 130
    begin
      select
        @w_valor = pl_valor
      from   cl_plan
      where  pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and pl_cuenta  = @i_cuenta
      if @@rowcount = 0
      begin
        /*  No existe Cuenta en Estado Financiero  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101164
        return 1
      end

      /* verificar que el balance no se quede sin cuentas */
      if (select
            count (1)
          from   cl_plan,
                 cl_cuenta
          where  pl_cuenta    = ct_cuenta
             and ct_categoria = @i_categoria) = 1
      begin
        /*  Por lo menos debe existir un cuenta en el balance */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101145
        return 1
      end

      begin tran
      delete cl_plan
      where  pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and pl_cuenta  = @i_cuenta
      if @@error != 0
      begin
        /*  Error en eliminacion de Cuenta de Estado Financiero  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107065
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_plan
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,cliente,balance,
                   cuenta,valor,alterno)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cliente,@i_balance,
                   @i_cuenta,@w_valor,@i_secuencial)
      if @@error != 0
      begin
        /*  Error en la insercion de Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      /* Enviar totales de activo o pasivo */
      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('A', 'I', 'S', 'C')

      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('P', 'T', 'E', 'O') /* RIA01 */
      commit tran
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

/*  Search  */
  /* Enviar las cuentas de pasivo y activo para un balance */
  if @i_operacion = 'S'
  begin
    if @t_trn = 131
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        /*  Cuentas de Activo  */
        select
          'Cod.' = tp_cuenta,
          'Cuenta' = ct_descripcion,
          'Valor' = isnull(pl_valor,
                           0.00),
          'Secuencial'= tp_secuencial
        from   cl_tplan
               left outer join cl_plan
                            on tp_cuenta = pl_cuenta,
               cl_cuenta
        where  pl_cliente  = @i_cliente
           and pl_balance  = @i_balance
           and tp_tbalance = @i_tbalance
           and ct_cuenta   = tp_cuenta
           and ct_categoria in ('A', 'I', 'S', 'C')

        /*  Cuentas de Pasivo  */
        select
          'Cod.' = tp_cuenta,
          'Cuenta' = ct_descripcion,
          'Valor' = isnull(pl_valor,
                           0.00),
          'Secuencial' = tp_secuencial
        from   cl_tplan
               left outer join cl_plan
                            on tp_cuenta = pl_cuenta,
               cl_cuenta
        where  pl_cliente  = @i_cliente
           and pl_balance  = @i_balance
           and tp_tbalance = @i_tbalance
           and ct_cuenta   = tp_cuenta
           and ct_categoria in ('P', 'T', 'E', 'O') /* RIA01 */
      end

      if @i_modo = 1
      begin
        select
          'Cuenta' = tp_cuenta,
          'Descripcion' = ct_descripcion,
          'Valor' = isnull(pl_valor,
                           0.00),
          'Secuencial' = tp_secuencial
        from   cl_tplan
               left outer join cl_plan
                            on tp_cuenta = pl_cuenta,
               cl_cuenta
        where  pl_cliente    = @i_cliente
           and pl_balance    = @i_balance
           and tp_tbalance   = @i_tbalance
           and ct_cuenta     = tp_cuenta
           and ct_categoria in ('A', 'I', 'S', 'C')
           and tp_secuencial > @i_secuencial
      end

      if @i_modo = 2
      begin
        select
          'Cuenta' = tp_cuenta,
          'Descripcion' = ct_descripcion,
          'Valor' = isnull(pl_valor,
                           0.00),
          'Secuencial' = tp_secuencial
        from   cl_tplan
               left outer join cl_plan
                            on tp_cuenta = pl_cuenta,
               cl_cuenta
        where  pl_cliente    = @i_cliente
           and pl_balance    = @i_balance
           and tp_tbalance   = @i_tbalance
           and ct_cuenta     = tp_cuenta
           and ct_categoria in ('P', 'T', 'E', 'O')
           and tp_secuencial > @i_secuencial
      end

      set rowcount 0

      /* Enviar totales de activo o pasivo */
      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('A', 'I', 'S', 'C')

      select
        sum(pl_valor)
      from   cl_plan,
             cl_cuenta
      where  pl_cuenta  = ct_cuenta
         and pl_cliente = @i_cliente
         and pl_balance = @i_balance
         and ct_categoria in ('P', 'T', 'E', 'O') /* RIA01 */
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end
  return 0

go

