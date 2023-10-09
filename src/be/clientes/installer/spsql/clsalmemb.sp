/************************************************************************/
/*      Archivo:                clsalmemb.sp                            */
/*      Stored procedure:       sp_saldo_min_embargado                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Cobis                                   */
/*      Disenado por:           Jaime Loyo                              */
/*      Fecha de escritura:     17-Jun-2010                             */
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
/*      SP que tiene a su cargo el mantenimiento de las tablas que      */
/*      validan el saldo minimo embargable                              */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      17/Jun/2010     J. Loyo         Personalizacion Bancamia        */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
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
           where  name = 'sp_saldo_min_embargado')
  drop proc sp_saldo_min_embargado
go

create proc sp_saldo_min_embargado
(
  @s_srv          varchar(16) = null,
  @s_user         varchar(30),
  @s_term         varchar(10),
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @s_ofi          int = null,
  @s_date         datetime,
  @i_debug        char(1) = 'N',
  @t_trn          int,
  @i_oper         char(1),
  @i_fecha        smalldatetime = null,
  @i_cod_emb      int = null,
  @i_cliente      int,
  @i_param_emb    char(8) = null,
  @i_tipo_emb     char(1) = null,
  @i_producto     tinyint = null,
  @i_num_cta      cuenta = null,
  @i_val          money = null
)
as
  declare
    @w_sev           tinyint,
    @w_error         int,
    @w_return        int,
    @w_sp_name       varchar(30),
    @i_num_ctas      tinyint,
    @w_causa         char(12),
    @w_concepto      char(16),
    @w_tipo_imp      varchar(1),
    @w_indicador     tinyint,
    @w_tipo_emb      char(1),
    @w_num_ctas      smallint,
    @w_num_emb       smallint,
    @w_param_emb     char(8),
    @w_monto_emb     money,
    @w_param_emb2    char(8),
    @w_monto_emb2    money,
    @w_monparam_emb  money,
    @w_monparam_emb2 money,
    @w_cont_ctas     smallint,
    @w_existe        tinyint,
    @w_producto      tinyint,
    @w_cant_esp      smallint,
    @w_cant_tod      smallint,
    @w_cant_tot      smallint,
    @w_num_cta       cuenta,
    @w_primera       cuenta,
    @w_ssn           int,
    @i_msg           varchar(132),
    @w_codigo_emb    int,
    @w_clase         char(1),
    @w_fecha_aper    datetime

  select
    @i_msg = null

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- if @i_debug is null
  select
    @i_debug = 'N'

  if @t_trn not in (1423, 1432, 201)
  /** EMbargo -- Desembargo -- Creacion Cuenta Nueva -- ***/
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @i_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  if @i_oper = 'I'
  begin
    /* LECTURA DE PARAMETROS */
    select
      @w_monparam_emb = pa_money
    from   cobis..cl_parametro
    where  pa_nemonico = @i_param_emb
       and pa_producto = 'MIS'

    if @@rowcount <> 1
    begin
      select
        @w_error = 251067,
        @w_sev = 0
      goto ERROR
    end
  end

  select
    @w_clase = en_subtipo
  from   cobis..cl_ente
  where  en_ente = @i_cliente

  /* Inicializar el SSN para el proceso de notas de debito */

  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    rollback tran
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
  end
  begin tran
  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 10

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    rollback tran
    exec cobis..sp_cerror
      @i_num = 201163
  end
  commit tran

  begin tran

  /**** Insert de un nuevo embargo ****/
  if @i_oper = 'I'
  begin --1
    select
      @w_num_emb = 0

    if exists (select
                 1
               from   cobis..cl_saldo_embargo
               where  se_cliente    = @i_cliente
                  and se_estado     = 'V'
                  and se_codigo_emb = @i_cod_emb)
    begin --2
      /** REGISTRO DE BLOQUEO YA EXISTE **/
      select
        @w_error = 2902545,
        @w_sev = 0,
        @i_msg = 'REGISTRO DE BLOQUEO YA EXISTE EN cl_saldo_embargo'
      goto ERROR

    end --2
    else
    begin --2
      insert into cobis..cl_saldo_embargo
                  (se_cliente,se_codigo_emb,se_fecha_crea,se_fecha_mod,
                   se_fecha_cierre,
                   se_tipo_emb,se_estado,se_valor_emb,se_parametro_emb,
                   se_cta_banco)
      values      (@i_cliente,@i_cod_emb,getdate(),getdate(),null,
                   @i_tipo_emb,'V',@w_monparam_emb,@i_param_emb,@i_num_cta)

      if @@error != 0
      begin
        rollback tran
        /*** No se pudo insertar Embargo ***/
        select
          @w_error = 101207,
          @w_sev = 0,
          @i_msg = ' No se pudo insertar Embargo en cl_saldo_embargo'
        goto ERROR
      end

      select
        @w_num_emb = count(*),
        @w_monparam_emb2 = min(se_valor_emb)
      from   cobis..cl_saldo_embargo
      where  se_cliente  = @i_cliente
         and se_tipo_emb = 'T'
         and se_estado   = 'V'

      if @w_monparam_emb2 > @w_monparam_emb
          or @w_monparam_emb2 is null
        select
          @w_monparam_emb2 = @w_monparam_emb

      if @i_tipo_emb = 'E'
      begin --3
        --print '****  INGRESA POR EMBARGO ESPECIFICO'
        if not exists(select
                        1
                      from   cobis..cl_cuentas_embargo
                      where  ce_cliente   = @i_cliente
                         and ce_cta_banco = @i_num_cta)
        begin --4
          /*** Si no existe la cuenta, se crea en la tabla ***/

          if @i_debug = 'S'
            print ' Inserta la cuenta en cl_cuenta_embargo 1'

          insert into cl_cuentas_embargo
                      (ce_cliente,ce_fecha_crea,ce_fecha_mod,ce_fecha_cierre,
                       ce_tipo_emb
                       ,
                       ce_estado,ce_cta_banco,ce_num_emb,ce_valor_ret,
                       ce_producto,
                       ce_valor_emb,ce_parametro_emb)
          values      (@i_cliente,@s_date,@s_date,null,@i_tipo_emb,
                       'V',@i_num_cta,@w_num_emb + 1,0,@i_producto,
                       @w_monparam_emb2,@i_param_emb)

          if @@error != 0
          begin /*** No se pudo insertar Embargo ***/
            rollback tran
            select
              @w_error = 101207,
              @i_msg = ' No se pudo insertar Embargo en cl_cuentas_embargo'
            goto ERROR
          end
        end--4

        else /*** Si la cuenta existe actualizo el registro ***/
        begin
          if @i_debug = 'S'
            print ' Actualiza la cuenta en cl_cuenta_embargo 1'

          update cl_cuentas_embargo
          set    ce_num_emb = ce_num_emb + 1,
                 ce_parametro_emb = @i_param_emb,
                 ce_valor_emb = @w_monparam_emb2,
                 ce_fecha_mod = getdate(),
                 ce_estado = 'V',
                 ce_valor_ret = 0
          where  ce_cliente   = @i_cliente
             and ce_cta_banco = @i_num_cta

          if @@error != 0
          begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
            rollback tran
            select
              @w_error = 2902542,
              @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
            goto ERROR
          end
        end
      end --3   FIn del Embargo Especifico
      else
      begin --3       /** EL TIPO DE EMBARGO ES PARA TODAS LAS CUENTAS  **/
      /*** INGRESA CUENTAS DEL NUEVO EMBARGO */
        /*** Si el Embargo es DIAN debo buscar la cuenta mas antigua, y las demas quedarian con embargo en cero ****/

        if @i_debug = 'S'
          print '***       Parametro de Embargo TODAS LAS CUENTAS @i_param_emb '
                +
                                  @i_param_emb

        if @i_param_emb = 'MMIDIA'
        begin
          --print '***         Parametro de Embargo DIAN'
          /* LECTURA DE PARAMETROS */
          select
            @w_monparam_emb = pa_money
          from   cobis..cl_parametro
          where  pa_nemonico = 'MMIDIA'
             and pa_producto = 'MIS'

          if @@rowcount <> 1
          begin
            rollback tran
            select
              @w_error = 251067,
              @w_sev = 0
            goto ERROR
          end

          /** print ' Valor del parametro  para DIAN es :@w_monparam_emb :' + cast (@w_monparam_emb  as varchar)
           >> Buscar la cuenta mas antigua sea> Titular o Cotitular, y a esa cuenta colocarle el monto DIAN el resto en ceros   ****/
          set rowcount 1
          select
            @w_primera = ah_cta_banco,
            @w_fecha_aper = ah_fecha_aper
          from   cob_ahorros..ah_cuenta
          where  ah_cta_banco in
                 (select
                    dp_cuenta
                  from   cobis..cl_det_producto,
                         cobis..cl_cliente
                  where  dp_producto     = 4
                     and cl_det_producto = dp_det_producto
                     and cl_cliente      = @i_cliente
                     and cl_rol in ('C', 'T')
                     and dp_estado_ser   = 'V')
          order  by ah_fecha_aper
          set rowcount 0
          --print '***         Cuentas mas antigua' + @w_primera

          if exists (select
                       1
                     from   cobis..cl_cuentas_embargo
                     where  ce_cliente   = @i_cliente
                        and ce_cta_banco = @w_primera)
          begin
            --print '***         actualiza Cuentas mas antigua' + @w_primera
            update cobis..cl_cuentas_embargo
            set    ce_valor_emb = @w_monparam_emb,
                   ce_tipo_emb = @i_param_emb,-- MMIDIA',
                   ce_fecha_mod = getdate(),
                   ce_num_emb = isnull(ce_num_emb, 0) + 1,
                   ce_estado = 'V'
            where  ce_cliente   = @i_cliente
               and ce_cta_banco = @w_primera

            if @@error != 0
            begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
              rollback tran
              select
                @w_error = 2902542,
                @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
              goto ERROR
            end
          end
          else /**** Insertar la cuenta mas antigua y colocarla ***/
          begin
            --print '***               insert Cuentas mas antigua'
            insert into cl_cuentas_embargo
                        (ce_cliente,ce_fecha_crea,ce_fecha_mod,ce_fecha_cierre,
                         ce_tipo_emb
                         ,
                         ce_estado,ce_cta_banco,ce_num_emb,ce_valor_ret,
                         ce_producto,
                         ce_valor_emb,ce_parametro_emb)
            values      (@i_cliente,@s_date,@s_date,null,@i_tipo_emb,
                         'V',@w_primera,1,0,@i_producto,
                         @w_monparam_emb,@i_param_emb)

            if @@error != 0
            begin /*** No se pudo insertar Embargo ***/
              rollback tran
              select
                @w_error = 101207,
                @i_msg = ' No se pudo insertar Embargo en cl_cuentas_embargo'
              goto ERROR
            end

          end

          /* Ingresa las demas cuentas */
          declare cuentas cursor for
            select
              dp_producto,
              dp_cuenta
            from   cobis..cl_cliente,
                   cobis..cl_det_producto
            where  cl_cliente      = @i_cliente
               and cl_det_producto = dp_det_producto
               and dp_producto in(4, 3)
               and dp_estado_ser   = 'V'
               and cl_rol in ('T', 'C')
               and dp_cuenta       <> @w_primera

          open cuentas

          fetch cuentas into @w_producto, @w_num_cta

          if @@fetch_status = -2
          begin
            close cuentas
            deallocate cuentas
            rollback
            select
              @w_error = 201157
            goto ERROR
          end

          while @@fetch_status = 0
          begin --4
            if not exists(select
                            1
                          from   cobis..cl_cuentas_embargo
                          where  ce_cliente   = @i_cliente
                             and ce_cta_banco = @w_num_cta)
            begin
              --5    /***  Valido para Cuentas que no existan en la tabla de cl_cuentas_embargo ***/
              --print '***              INsert cuentas secundarias'
              insert cl_cuentas_embargo
                     (ce_cliente,ce_fecha_crea,ce_fecha_mod,ce_fecha_cierre,
                      ce_tipo_emb,
                      ce_estado,ce_cta_banco,ce_num_emb,ce_valor_ret,ce_producto
                      ,
                      ce_parametro_emb,ce_valor_emb)
              values(@i_cliente,@s_date,@s_date,null,'T',
                     'V',@w_num_cta,1,0,@w_producto,
                     @i_param_emb,@w_monparam_emb2)

              if @@error != 0
              begin /*** No se pudo insertar Embargo ***/
                rollback tran
                select
                  @w_error = 101207,
                  @i_msg = ' No se pudo insertar Embargo en cl_cuentas_embargo'
                goto ERROR
              end
            end --5
            else
            /** Si ya existen las cuentas creadas solo actualizo los valores ***/
            begin --5
              --print '***              UPdate secundarias cuenta '+@w_num_cta +' monto ' + cast (@w_monparam_emb2 as varchar)
              update cl_cuentas_embargo
              set    ce_num_emb = ce_num_emb + 1,
                     ce_estado = 'V',
                     ce_fecha_mod = getdate(),
                     ce_tipo_emb = 'T',
                     ce_parametro_emb = @i_param_emb,
                     ce_valor_emb = 0
              where  ce_cliente   = @i_cliente
                 and ce_cta_banco = @w_num_cta

              if @@error != 0
              begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
                rollback tran
                select
                  @w_error = 2902542,
                  @i_msg =
                ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
                goto ERROR
              end
            end --5

            fetch cuentas into @w_producto, @w_num_cta
          end --4
          close cuentas
          deallocate cuentas

        end -- FIN PARAMETRO DIAN
        else
        begin
          -- print '***      Cuentas tipo SUPER / NOAPLICA'
          declare cuentas cursor for
            select
              dp_producto,
              dp_cuenta
            from   cobis..cl_cliente,
                   cobis..cl_det_producto
            where  cl_cliente      = @i_cliente
               and cl_det_producto = dp_det_producto
               and dp_producto in(4, 3)
               and dp_estado_ser   = 'V'
               and cl_rol in ('T', 'C')

          /* Abro el Cursor para todas las cuentas del cliente */
          open cuentas

          /* Ubico el primer registro para el cursor */
          fetch cuentas into @w_producto, @w_num_cta

          if @@fetch_status = -2
          begin
            /* Cerrar y liberar cursor */
            close cuentas
            deallocate cuentas
            rollback
            /* Error en lectura de todas las cuentas del cliente */
            select
              @w_error = 201157
            goto ERROR
          end

          while @@fetch_status = 0
          begin --4
            if not exists(select
                            1
                          from   cobis..cl_cuentas_embargo
                          where  ce_cliente   = @i_cliente
                             and ce_cta_banco = @w_num_cta)
            begin
              --5    /***  Valido para Cuentas que no existan en la tabla de cl_cuentas_embargo ***/
              -- print '***              INsert '
              insert cl_cuentas_embargo
                     (ce_cliente,ce_fecha_crea,ce_fecha_mod,ce_fecha_cierre,
                      ce_tipo_emb,
                      ce_estado,ce_cta_banco,ce_num_emb,ce_valor_ret,ce_producto
                      ,
                      ce_parametro_emb,ce_valor_emb)
              values(@i_cliente,@s_date,@s_date,null,'T',
                     'V',@w_num_cta,@w_num_emb,0,@w_producto,
                     @i_param_emb,@w_monparam_emb2)

              if @@error != 0
              begin /*** No se pudo insertar Embargo ***/
                rollback tran
                select
                  @w_error = 101207,
                  @i_msg = ' No se pudo insertar Embargo en cl_cuentas_embargo'
                goto ERROR
              end
            end --5
            else
            /** Si ya existen las cuentas creadas solo actualizo los valores ***/
            begin --5
              --print '***              UPdate cuenta '+@w_num_cta +' monto ' + cast (@w_monparam_emb2 as varchar)
              update cl_cuentas_embargo
              set    ce_num_emb = ce_num_emb + 1,
                     ce_estado = 'V',
                     ce_fecha_mod = getdate(),
                     ce_tipo_emb = 'T',
                     ce_parametro_emb = @i_param_emb,
                     ce_valor_emb = @w_monparam_emb2
              where  ce_cliente   = @i_cliente
                 and ce_cta_banco = @w_num_cta

              if @@error != 0
              begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
                rollback tran
                select
                  @w_error = 2902542,
                  @i_msg =
                ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
                goto ERROR
              end
            end --5

            fetch cuentas into @w_producto, @w_num_cta
          end --4
          close cuentas
          deallocate cuentas
        end
      end --3
    end --2

    insert into cobis..cl_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
                 ts_terminal,ts_ente,ts_oficina,ts_descripcion,ts_saldo_minimo,
                 ts_toperacion,ts_observaciones)
    values      (@w_ssn,@t_trn,@w_clase,getdate(),@s_user,
                 @s_term,@i_cliente,@s_ofi,'CREACION DE EMBARGO',@w_monparam_emb
                 ,
                 'I','PARAMETRO :' + @i_param_emb +
                 ' TIPO EMBARGO: ' +
                 @i_tipo_emb )

    if @@error != 0
    begin /*** Error en creacion de transaccion de servicio  ***/
      rollback tran
      select
        @w_error = 103005,
        @i_msg = 'Error en creacion de transaccion de servicio'
      goto ERROR
    end

  end --1

  /**** Nueva Cuenta ****/
  if @i_oper = 'N'
  begin
    select
      @w_num_emb = 0

    /*** Calculamos el numero de embargos vigentes para todas las cuentas de ese cliente ***/
    select
      @w_num_emb = count(*),
      @w_monparam_emb2 = min(se_valor_emb)
    from   cobis..cl_saldo_embargo
    where  se_cliente  = @i_cliente
       and se_estado   = 'V'
       and se_tipo_emb = 'T'

    if @w_num_emb > 0
    begin
      if @w_monparam_emb2 > @w_monparam_emb
        select
          @w_monparam_emb2 = @w_monparam_emb

      set rowcount 1
      select
        @i_param_emb = se_parametro_emb
      from   cobis..cl_saldo_embargo
      where  se_cliente   = @i_cliente
         and se_valor_emb = @w_monparam_emb2
         and se_estado    = 'V'
         and se_tipo_emb  = 'T'

      set rowcount 0

      /**** Insertamos la nueva cuenta para los embargos *****/
      insert into cl_cuentas_embargo
                  (ce_cliente,ce_fecha_crea,ce_fecha_mod,ce_fecha_cierre,
                   ce_tipo_emb
                   ,
                   ce_estado,ce_cta_banco,ce_num_emb,ce_valor_ret,
                   ce_producto,
                   ce_valor_emb,ce_parametro_emb)
      values      ( @i_cliente,@s_date,@s_date,null,'T',
                    'V',@i_num_cta,@w_num_emb,0,@i_producto,
                    @w_monparam_emb2,@i_param_emb)

      if @@error <> 0
      begin /*** No se pudo insertar Embargo ***/
        rollback tran
        select
          @w_error = 101207,
          @i_msg = ' No se pudo insertar Embargo en cl_cuentas_embargo'
        goto ERROR
      end
      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,
                   ts_usuario,
                   ts_terminal,ts_ente,ts_oficina,ts_descripcion,ts_saldo_minimo
                   ,
                   ts_toperacion,ts_observaciones)
      values      (@w_ssn,214,@w_clase,getdate(),@s_user,
                   @s_term,@i_cliente,@s_ofi,
                   'CREACION DE CUENTA NUEVA CLIENTE EMBARGADO',null,
                   'N','CUENTA :' + @i_num_cta )
      if @@error != 0
      begin /*** Error en creacion de transaccion de servicio  ***/
        rollback tran
        select
          @w_error = 103005,
          @i_msg =
        'Error en creacion de transaccion de servicio en cuenta nueva'
        goto ERROR
      end
    end
  end

  if @i_oper = 'C' /** Cancelacion de embargo de un cliente **/
  begin
    if exists (select
                 1
               from   cobis..cl_saldo_embargo
               where  se_cliente    = @i_cliente
                  and se_estado     = 'V'
                  and se_codigo_emb = @i_cod_emb)
    begin
      if @i_debug = 'S'
        print
    ' Empieza con la actualizacion inicial en la cancelacion de Embargo '

      /** Actualizo el embargo para la tabla de saldo_embargo **/
      update cobis..cl_saldo_embargo
      set    se_estado = 'C',
             se_fecha_cierre = getdate()
      where  se_cliente    = @i_cliente
         and se_estado     = 'V'
         and se_codigo_emb = @i_cod_emb

      if @@error != 0
      begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
        rollback tran
        select
          @w_error = 2902542,
          @w_sev = 0,
          @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
        goto ERROR
      end

      /* Defino que tipo de embargo es Especifico o Total para actualizar las cuentas ***/
      select
        @w_tipo_emb = se_tipo_emb,
        @w_num_cta = se_cta_banco
      from   cobis..cl_saldo_embargo
      where  se_cliente    = @i_cliente
         and se_codigo_emb = @i_cod_emb

      if @i_debug = 'S'
        print ' EL tipo de embargo es :' + @w_tipo_emb

      if @w_tipo_emb = 'T'
      begin
        update cobis..cl_cuentas_embargo
        set    ce_num_emb = ce_num_emb - 1
        where  ce_cliente = @i_cliente
           and ce_num_emb > 0
      end
      else /** Si el tipo de Embargo es Especifico ***/
      begin
        update cobis..cl_cuentas_embargo
        set    ce_num_emb = ce_num_emb - 1
        where  ce_cliente   = @i_cliente
           and ce_cta_banco = @w_num_cta
           and ce_num_emb   > 0
      end

      if @@error != 0
      begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
        rollback tran
        select
          @w_error = 2902542,
          @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
        goto ERROR
      end

      select
        @w_cant_esp = isnull(count(*),
                             0)
      from   cobis..cl_saldo_embargo
      where  se_cliente  = @i_cliente
         and se_estado   = 'V'
         and se_tipo_emb = 'E'

      select
        @w_cant_tod = isnull(count(*),
                             0)
      from   cobis..cl_saldo_embargo
      where  se_cliente  = @i_cliente
         and se_estado   = 'V'
         and se_tipo_emb = 'T'

      select
        @w_cant_tot = @w_cant_esp + @w_cant_tod
      if @w_cant_tot = 0
      begin
        if @i_debug = 'S'
          print
' EL Cliente no tiene mas embargos, se pasa a actualizaion final y transaccion de servicio'
  goto TRAN_SERVICIO
end
  if @i_debug = 'S'
    print '***    COMIENZA LOS EMBARGOS *****'

  /*** Si existe un embargo para todas las cuentas con Monto Minimo No aplica, todas las cuentas el saldo a retirar es cero ***/
  if exists (select
               1
             from   cobis..cl_saldo_embargo
             where  se_cliente       = @i_cliente
                and se_estado        = 'V'
                and se_tipo_emb      = 'T'
                and se_parametro_emb = 'MMINAP')
  begin --- INICIO CODIGO MMINAP Codigo Embargo ('T')odas las cuentas
    if @i_debug = 'S'
      print ' MMINAP Codigo Embargo (T)odas las cuentas '

    update cobis..cl_cuentas_embargo
    set    ce_valor_ret = 0,-- MMINAP
           ce_tipo_emb = 'MMINAP',
           ce_fecha_mod = getdate()
    where  ce_cliente = @i_cliente
       and ce_num_emb > 0

    if @@error != 0
    begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
      rollback tran
      select
        @w_error = 2902542,
        @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
      goto ERROR
    end
  end --- TERMINA CODIGO MMINAP Codigo Embargo ('T')odas las cuentas
  else
  begin --- INICIO CODIGO MMIDIA Codigo Embargo ('T')odas las cuentas
    if @i_debug = 'S'
      print '***  No hay codigo TIPO No APlica **/ '

    /** Si no hay embargo de tipo No Aplica, y hay Embargos Dian, este es el que predomina en todas las cuentas ***/
    if exists (select
                 1
               from   cobis..cl_saldo_embargo
               where  se_cliente    = @i_cliente
                  and se_estado     = 'V'
                  and se_codigo_emb = 'T'
                  and se_tipo_emb   = 'MMIDIA')
    begin --- INICIO CODIGO MMIDIA Codigo Embargo ('T')odas las cuentas
      if @i_debug = 'S'
        print '***     CODIGO MMIDIA Codigo Embargo (T)odas las cuentas **'
      /* LECTURA DE PARAMETROS */
      select
        @w_monparam_emb = pa_money
      from   cobis..cl_parametro
      where  pa_nemonico = 'MMIDIA'
         and pa_producto = 'MIS'

      if @@rowcount <> 1
      begin
        rollback tran
        select
          @w_error = 251067,
          @w_sev = 0
        goto ERROR
      end

      /** print ' Valor del parametro  para DIAN es :@w_monparam_emb :' + cast (@w_monparam_emb  as varchar)
       >> Buscar la cuenta mas antigua y a esa cuenta colocarle el monto DIAN el resto en ceros   ****/
      set rowcount 1
      select
        @w_primera = ah_cta_banco
      from   cob_ahorros..ah_cuenta
      where  ah_cliente    = 4500
         and ah_fecha_aper = (select
                                min(ah_fecha_aper)
                              from   cob_ahorros..ah_cuenta
                              where  ah_cliente = 4500
                                 and ah_estado  <> 'C')
         and ah_estado     <> 'C'
      set rowcount 0

      --print '***     Cuenta mas antigua : ' +  @w_primera

      update cobis..cl_cuentas_embargo
      set    ce_valor_ret = @w_monparam_emb,-- MMIDIA
             ce_tipo_emb = 'MMIDIA',
             ce_fecha_mod = getdate()
      where  ce_cliente   = @i_cliente
         and ce_cta_banco = @w_primera
         and ce_num_emb   > 0

      if @@error != 0
      begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
        rollback tran
        select
          @w_error = 2902542,
          @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
        goto ERROR
      end

      update cobis..cl_cuentas_embargo
      set    ce_valor_ret = 0,
             -- MMIDIA -- La cuenta mas antigua se actualiza con el parametro las demas en ceros
             ce_tipo_emb = 'MMIDIA',
             ce_fecha_mod = getdate()
      where  ce_cliente   = @i_cliente
         and ce_cta_banco <> @w_primera
         and ce_num_emb   > 0

      if @@error != 0
      begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
        rollback tran
        select
          @w_error = 2902542,
          @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
        goto ERROR
      end
    end --- TERMINA CODIGO MMIDIA Codigo Embargo ('T')odas las cuentas
    else
    begin
      --print '***          Embargos Tipo SUPER '
      /** Si no hay embargo de tipo DIAN, y hay Embargos SUPER, este es el que predomina en todas las cuentas ***/
      if exists (select
                   1
                 from   cobis..cl_saldo_embargo
                 where  se_cliente    = @i_cliente
                    and se_estado     = 'V'
                    and se_codigo_emb = 'T'
                    and se_tipo_emb   = 'MMISUP')
      begin --- INICIO CODIGO MMISUP Codigo Embargo ('T')odas las cuentas
        /* LECTURA DE PARAMETROS */
        select
          @w_monparam_emb = pa_money
        from   cobis..cl_parametro
        where  pa_nemonico = 'MMISUP'
           and pa_producto = 'MIS'

        if @@rowcount <> 1
        begin
          rollback tran
          select
            @w_error = 251067,
            @w_sev = 0
          goto ERROR
        end
        -- print ' Valor del parametro  para SUPER es :@w_monparam_emb :' + cast (@w_monparam_emb  as varchar)

        update cobis..cl_cuentas_embargo
        set    ce_valor_ret = @w_monparam_emb,-- MMISUP
               ce_tipo_emb = 'MMISUP',
               ce_fecha_mod = getdate()
        where  ce_cliente = @i_cliente
           and ce_num_emb > 0

        if @@error != 0
        begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
          rollback tran
          select
            @w_error = 2902542,
            @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
          goto ERROR
        end
      end --- TERMINA CODIGO MMISUP Codigo Embargo ('T')odas las cuentas
    end
  --print ' PÄso por embargos totales '
  end --- TERMINA CODIGO MMINAP Codigo Embargo ('T')odas las cuentas

/* HAgo un cursor sobre los embargos especificos y por cada embargo reviso los valores para ver si es menor y actualizar los datos **/
/* Cursor para cobis..cl_saldo_embargo */
  --print '***  Cursor sobre los embargos Especificcos'
  declare embargos_especificos cursor for
    select
      se_cta_banco,
      se_parametro_emb,
      se_codigo_emb
    from   cobis..cl_saldo_embargo
    where  se_cliente  = @i_cliente
       and se_estado   = 'V'
       and se_tipo_emb = 'E'
    order  by se_codigo_emb

  open embargos_especificos
  fetch embargos_especificos into @w_num_cta, @w_param_emb2, @w_codigo_emb
  if @@fetch_status = -2
  begin
    --print 'Error en la apertura de cursor -2'
    /** error en la apertura ***/
    rollback tran
    close embargos_especificos
    deallocate embargos_especificos
    return 111111
  end

  if @@fetch_status = -1
  begin
    if @i_debug = 'S'
      print 'NO hay datos para el cursor'
    /*** No hay registros ***/
    commit tran
    goto TRAN_SERVICIO
    close embargos_especificos
    deallocate embargos_especificos
    return 0
  end

  while @@fetch_status = 0
  begin
    /* LECTURA DE PARAMETROS */
    select
      @w_monparam_emb2 = pa_money
    from   cobis..cl_parametro
    where  pa_nemonico = @w_param_emb2
       and pa_producto = 'MIS'

    if @@rowcount <> 1
    begin
      --print 'Error lectura de parametros'
      select
        @w_error = 251067,
        @w_sev = 0
      rollback tran
      close embargos_especificos
      deallocate embargos_especificos
      goto ERROR
    end

    select
      @w_monparam_emb = ce_valor_emb
    from   cobis..cl_cuentas_embargo
    where  ce_cta_banco = @w_num_cta
    -- print'ok........'  +     @w_num_cta  + ' codigo embargo ' + cast (@w_codigo_emb as varchar)
    if @w_monparam_emb2 < @w_monparam_emb
    begin
      --print '***            Actualizacion de embaergos especificos '
      update cobis..cl_cuentas_embargo
      set    ce_valor_emb = @w_monparam_emb2,
             ce_parametro_emb = @w_param_emb2
      where  ce_cta_banco = @w_num_cta

      if @@error != 0
      begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
        select
          @w_error = 2902542,
          @i_msg = ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo '
        rollback tran
        close embargos_especificos
        deallocate embargos_especificos
        goto ERROR
      end

    end

    leer:
    /* Localizar el siguiente registro de cuenta embargada */
    fetch embargos_especificos into @w_num_cta, @w_param_emb2, @w_codigo_emb
    /* Validar el Status del Cursor */

    if @@fetch_status = -2
    begin
      print 'ERROR EN LECTURA DE SALDOS DE EMBARGOS..'
      rollback tran
      close embargos_especificos
      deallocate embargos_especificos
      return 251061
    end
  end

  /* Cerrar y liberar cursor */
  close embargos_especificos
  deallocate embargos_especificos
  --print ' Cierra el cursor '

  TRAN_SERVICIO:

  /*** Actalizamos las cuentas cuyo numero de embargos = 0     ****/
  update cobis..cl_cuentas_embargo
  set    ce_estado = 'C',
         ce_fecha_mod = getdate()
  where  ce_cliente = @i_cliente
     and ce_num_emb = 0

  if @@error != 0
  begin /*** NO SE PUEDE MODIFICAR BLOQUEO   ***/
    select
      @w_error = 2902542,
      @i_msg =
      ' NO SE PUEDE MODIFICAR BLOQUEO EN cl_cuentas_embargo Para Cancelacion '
    rollback tran
    goto ERROR
  end
  --print ' Insercion de servicio '
  insert into cobis..cl_tran_servicio
              (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
               ts_terminal,ts_ente,ts_oficina,ts_descripcion,ts_saldo_minimo,
               ts_toperacion,ts_observaciones)
  values      (@w_ssn,@t_trn,@w_clase,getdate(),@s_user,
               @s_term,@i_cliente,@s_ofi,'CIERRE/LEVANTAMIENTO EMBARGO ',null,
               'C','CODIGO EMBARGO: ' + cast (@i_cod_emb as varchar))
  if @@error != 0
  begin /*** Error en creacion de transaccion de servicio  ***/
    select
      @w_error = 103005,
      @i_msg = 'Error en creacion de transaccion de servicio en cuenta nueva'
    goto ERROR
  end
/**** HACER EL RECALCULO DE LOS DATOS   *****/

end

end

  commit tran
  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_debug = null,
    @t_file  = null,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @i_msg,
    @i_sev   = @w_sev
  return @w_error

go

