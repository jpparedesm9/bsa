/************************************************************************/
/*     Archivo:          ahretofi.sp                                    */
/*     Stored procedure: sp_aut_retiro_oficina                          */
/*     Base de datos:    cob_ahorros                                    */
/*     Producto:         Ahorros                                        */
/*     Disenado por:     Andres Diab                                    */
/*     Fecha de escritura: 24-Jun-2011                                  */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*       FECHA          AUTOR           RAZON                           */
/*    24/Jun/2011       Andres Diab         Emision Inicial             */
/*    02/May/2016       J. Calderon         Migración a CEN             */
/************************************************************************/

use cob_ahorros
go

set ANSI_NULLS off
GO 
set QUOTED_IDENTIFIER off
GO 

if exists (select
             1
           from   sysobjects
           where  id = object_id('sp_aut_retiro_oficina'))
  drop proc sp_aut_retiro_oficina
go

create proc sp_aut_retiro_oficina
  @s_ssn          int,
  @t_debug        char(1) = 'N',
  @t_file         char(1) = null,
  @t_show_version bit = 0,
  @s_user         login = null,
  @s_date         datetime,
  @s_term         varchar(10),-- = 'consola',
  @s_ofi          smallint,
  @t_trn          smallint,
  @i_operacion    char(1),
  @i_cta_banco    cuenta = '0',
  @i_forma_pago   char(1) = 'E',
  @i_valor        money = 0,
  @i_secuencial   int = null,
  @i_ofi_radica   char(1) = null
as
  declare
    @w_sp_name         varchar(32),
    @w_fecha           datetime,
    @w_nombre          varchar(60),
    @w_return          int,
    @w_ssn             int,
    @w_producto        tinyint,
    @w_error           int,
    @w_msg             varchar(255),
    @w_disponible      money,
    @w_cliente         int,
    @w_num_retiros     smallint,
    @w_num_debitos_hoy smallint,
    @w_num_debitos_efe smallint,
    @w_num_debitos_chq smallint,
    @w_debitos_hoy     money,
    @w_val_debhoy_efe  money,
    @w_val_debhoy_chq  money,
    @w_val_retiro_efec money,
    @w_val_retiro_chq  money,
    @w_retiro_add      smallint,
    @w_adicionar       char(1),
    @w_autoriza        char(1),
    @w_prod_banc       int,
    @w_prodbanc        int


  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_aut_retiro_oficina'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  
  select
    @w_retiro_add = 0,
    @w_num_retiros = 0,
    @w_num_debitos_hoy = 0,
    @w_num_debitos_efe = 0,
    @w_num_debitos_chq = 0,
    @w_debitos_hoy = 0,
    @w_val_debhoy_efe = 0,
    @w_val_debhoy_chq = 0,
    @w_val_retiro_efec = 0,
    @w_val_retiro_chq = 0,
    @w_autoriza = 'N'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_prod_banc = C.codigo
  from   cobis..cl_tabla T,
         cobis..cl_catalogo C
  where  T.tabla  = 're_pro_banc_cb'
     and T.codigo = C.tabla
     and C.estado = 'V'

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  if @i_operacion in ('I', 'U')
  begin
    /* VALIDAR EXISTENCIA DE LA CUENTA */
    select
      @w_nombre = ah_nombre,
      @w_cliente = ah_cliente,
      @w_producto = ah_producto,
      @w_disponible = ah_disponible,
      @w_prodbanc = ah_prod_banc
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
       and ah_estado    = 'A'
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      -- Cuenta no existe
      return 251001
    end
    if @w_prodbanc = @w_prod_banc
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2609863
      -- OPERACIËN NO VALIDA. PRODUCTO PERTENECE A CORRESPONSALES BANCARIOS REDES POSICIONADAS
      return 2609863
    end
  end

  /*** INSERCION DE AUTORIZACION ***/
  if @i_operacion = 'I'
  begin
    if exists (select
                 1
               from   cob_ahorros..ah_aut_retiro_ofic
               where  ar_cta_banco = @i_cta_banco
                  and ar_estado    = 'V')
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101002,
        @i_sev   = 0,
        @i_msg   = 'Ya existe una autorizacion de retiro vigente para la cuenta'
      -- Cuenta no existe
      return 2101002
    end

  /* EXTRAER TOPES PARA EL TIPO DE PRODUCTO */
    /*Incidencia PRM*/
    if @i_ofi_radica = 'S'
    begin
      select
        @w_num_retiros = isnull(to_cantidad,
                                0),
        @w_val_retiro_efec = (case
                                when to_mar_efec = 'S' then isnull(to_vlr_efec,
                                                                   0)
                                else 0
                              end),
        @w_val_retiro_chq = (case
                               when to_mar_chq = 'S' then isnull(to_vlr_chq,
                                                                 0)
                               else 0
                             end)
      from   cob_remesas..pe_tope_oficina
      where  to_tipo_prod = @w_producto
    end
    else
    begin
      select
        @w_num_retiros = isnull(to_cantidad,
                                0),
        @w_val_retiro_efec = (case
                                when to_mar_efec_otra = 'S' then
                                isnull(to_vlr_efec_otra,
                                       0)
                                else 0
                              end),
        @w_val_retiro_chq = (case
                               when to_mar_chq_otra = 'S' then isnull(
                               to_vlr_chq_otra,
                               0)
                               else 0
                             end)
      from   cob_remesas..pe_tope_oficina
      where  to_tipo_prod = @w_producto
    end
  /*Fin incidencia*/
    /* EXTRAER VALORES DEL DIA PARA LA CUENTA */

    select
      @w_num_debitos_efe = count(1),
      @w_val_debhoy_efe = (case tm_correccion
                             when 'N' then isnull(sum(isnull(tm_valor,
                                                             0)),
                                                  0)
                             when 'S' then isnull(sum(isnull(tm_valor * -1,
                                                             0)),
                                                  0)
                           end)
    from   cob_ahorros..ah_tran_monet
    where  tm_fecha     = @w_fecha
       and tm_tipo_tran in (263, 264, 371)
       and tm_estado is null
       and tm_cta_banco = @i_cta_banco
    group  by tm_correccion

    select
      @w_num_debitos_chq = count(1),
      @w_val_debhoy_chq = (case tm_correccion
                             when 'N' then isnull(sum(isnull(tm_valor,
                                                             0)),
                                                  0)
                             when 'S' then isnull(sum(isnull(tm_valor * -1,
                                                             0)),
                                                  0)
                           end)
    from   cob_ahorros..ah_tran_monet
    where  tm_fecha     = @w_fecha
       and tm_tipo_tran = 380
       and tm_estado is null
       and tm_cta_banco = @i_cta_banco
    group  by tm_correccion

    -- NUMERO DE RETIROS DEL DIA
    select
      @w_num_debitos_hoy = isnull(@w_num_debitos_efe, 0) + isnull(
                           @w_num_debitos_chq,
                                  0)

    /* VALIDAR FONDOS SUFICIENTES */
    if @w_disponible <= @i_valor
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357523
      -- Cuentas con Fondos Insuficientes
      return 357523
    end

    /* VALIDAR TOPE MAXIMO - NUMERO DEBITOS */
    if @w_num_debitos_hoy >= @w_num_retiros
      select
        @w_adicionar = 'S'
    else
      select
        @w_adicionar = 'N'

    /* VALIDAR TOPE MAXIMO - VALOR EFECTIVO */
    if @i_forma_pago = 'E'
    begin
      if ((@w_val_debhoy_efe + @i_valor) <= @w_val_retiro_efec
          and @w_val_retiro_efec is not null)
      begin
        if @w_adicionar = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357524
          -- Cuenta no ha superado tope de retiros
          return 357524
        end
      end
      else
        select
          @w_autoriza = 'S'
    end

    /* VALIDAR TOPE MAXIMO - VALOR CHEQUE */
    if @i_forma_pago = 'C'
    begin
      if ((@w_val_debhoy_chq + @i_valor) <= @w_val_retiro_chq
          and @w_val_retiro_chq is not null)
      begin
        if @w_adicionar = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357524
          -- Cuenta no ha superado tope de retiros
          return 357524
        end
      end
      else
        select
          @w_autoriza = 'S'
    end

    /* VALIDACION PARA INCREMENTO DE RETIROS SI LA AUTORIZACION ES SOLO POR MONTO */
    if @w_autoriza = 'S' -- AUTORIZACION POR MONTO
    begin
      if @w_adicionar = 'S' --NECESITO INCREMENTAR CANTIDAD DE RETIRO
      begin
        select
          @w_retiro_add = 1
        from   ah_aut_retiro_ofic
        where  ar_cta_banco = @i_cta_banco
           and ar_fecha     = @w_fecha
           and ar_estado    = 'V'
        if @@rowcount = 0
          select
            @w_retiro_add = 1
      end

    end
    else -- AUTORIZACION POR CANTIDAD DE RETIROS
    begin
      if @w_adicionar = 'S' --NECESITO INCREMENTAR CANTIDAD DE RETIRO
      begin
        select
          @w_retiro_add = 1
        from   ah_aut_retiro_ofic
        where  ar_cta_banco = @i_cta_banco
           and ar_fecha     = @w_fecha
           and ar_estado    = 'V'
        if @@rowcount = 0
          select
            @w_retiro_add = 1
      end
      else
      begin
        if @w_autoriza = 'N'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357524
        -- Cuenta no ha superado tope de retiros
        return 357524
      end

    end

    begin tran
    /* INSERTAR EXCEPCION DE RETIRO PARA CUENTA */
    insert into ah_aut_retiro_ofic
                (ar_cta_banco,ar_nombre,ar_forma_pago,ar_valor,ar_login,
                 ar_fecha,ar_hora,ar_estado,ar_retiro_add,ar_secuencial,
                 ar_oficina_radicadora)
    values      (@i_cta_banco,@w_nombre,@i_forma_pago,@i_valor,@s_user,
                 @w_fecha,getdate(),'V',@w_retiro_add,@s_ssn,
                 @i_ofi_radica)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357521
      -- Error en Insercion de Excepcion
      return 357521
    end

    /* INSERTAR TRANSACCION DE SERVICIO */
    insert into ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_filial,ts_oficina,ts_oficina_cta,ts_hora,
                 ts_estado,ts_cta_banco,ts_producto,ts_valor,ts_descripcion_ec,
                 ts_observacion,ts_tipo,ts_cliente)
    values      ( @s_ssn,0,@t_trn,@w_fecha,@s_user,
                  @s_term,1,@s_ofi,@s_ofi,getdate(),
                  'V',@i_cta_banco,@w_producto,@i_valor,
                  'INGRESO AUTORIZACION RETIRO',
                  @w_nombre,@i_forma_pago,@w_cliente)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      -- Error Insercion Transaccion de Servicio
      return 253004
    end
    commit tran
  end

  if @i_operacion = 'U'
  begin
    /* BLOQUEAR EXCEPCION DE RETIRO PARA CUENTA */
    begin tran

    update cob_ahorros..ah_aut_retiro_ofic
    set    ar_estado = 'B',
           ar_login = @s_user,
           ar_fecha = @w_fecha,
           ar_hora = getdate()
    where  ar_cta_banco  = @i_cta_banco
       and ar_secuencial = @i_secuencial
       and ar_estado     = 'V'
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357522
      -- Error Actualizacion Excepcion
      return 357522
    end

    /* INSERTAR TRANSACCION DE SERVICIO */
    insert into ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_filial,ts_oficina,ts_oficina_cta,ts_hora,
                 ts_estado,ts_cta_banco,ts_producto,ts_valor,ts_descripcion_ec,
                 ts_observacion,ts_tipo,ts_cliente,ts_cod_alterno)
    values      ( @s_ssn,0,@t_trn,@w_fecha,@s_user,
                  @s_term,1,@s_ofi,@s_ofi,getdate(),
                  'B',@i_cta_banco,@w_producto,@i_valor,
                  'ELIMINACION AUTORIZACION DE RETIRO',
                  @w_nombre,@i_forma_pago,@w_cliente,@i_secuencial)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      -- Error Insercin Transaccion de Servicio
      return 253004
    end
    commit tran
  end

  if @i_operacion = 'Q'
  begin
    select
      'CUENTA' = ar_cta_banco,
      'NOMBRE CUENTA' = convert(varchar(64), ah_nombre),
      'FORMA PAGO' = ar_forma_pago,
      'VALOR' = ar_valor,
      'ESTADO' = ar_estado,
      'OFI. RADICADORA' = ar_oficina_radicadora,
      'SECUENCIAL' = ar_secuencial
    from   cob_ahorros..ah_aut_retiro_ofic,
           cob_ahorros..ah_cuenta
    where  ar_cta_banco = ah_cta_banco
       and ar_cta_banco = @i_cta_banco
    order  by ar_hora desc,
              ar_cta_banco asc
    if @@rowcount = 0
      print 'NO EXISTEN AUTORIZACIONES PARA ESTA CUENTA'

  end

  if @i_operacion = 'S'
  begin
    set rowcount 20

    select
      'CUENTA' = ar_cta_banco,
      'NOMBRE CUENTA' = convert(varchar(64), ah_nombre),
      'FORMA PAGO' = ar_forma_pago,
      'VALOR' = ar_valor,
      'FECHA' = convert(varchar, ar_fecha, 101),
      'HORA' = ar_hora,
      'ESTADO' = ar_estado,
      'OFI. RADICADORA' = ar_oficina_radicadora,
      'SECUENCIAL' = ar_secuencial
    from   cob_ahorros..ah_aut_retiro_ofic,
           cob_ahorros..ah_cuenta
    where  ar_cta_banco = ah_cta_banco
    order  by ar_hora desc,
              ar_cta_banco asc
    if @@rowcount = 0
      print 'NO EXISTEN CUENTAS AUTORIZADAS'

    set rowcount 0
  end

  if @i_operacion = 'H'
  begin
    select
      @w_nombre,
      ar_forma_pago,
      ar_valor
    from   cob_ahorros..ah_aut_retiro_ofic
    where  ar_cta_banco  = @i_cta_banco
       and ar_forma_pago = @i_forma_pago
       and ar_valor      = @i_valor
       and ar_estado     = 'V'
    if @@rowcount = 0
      print 'NO EXISTEN AUTORIZACIONES PARA ESTA CUENTA'
  end

  if @i_operacion = 'C'
  begin
    select
      @w_nombre = ah_nombre,
      @w_prodbanc = ah_prod_banc
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
       and ah_estado    = 'A'
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      -- Cuenta no existe
      return 251001
    end
    if @w_prodbanc = @w_prod_banc
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2609863
      -- OPERACIËN NO VALIDA. PRODUCTO PERTENECE A CORRESPONSALES BANCARIOS REDES POSICIONADAS
      return 2609863
    end
  end

  return 0
  
  go

