/************************************************************************/
/*  Archivo:            ahtblqva.sp                                     */
/*  Stored procedure:   sp_bloq_val_ah                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 02-Mar-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de bloqueos a valores y        */
/*  levantamiento de bloqueos de valores de cuentas de ahorros.         */
/*  217 = Bloqueos de valores a la cuenta                               */
/*  218 = Levantamiento de bloqueos de valores                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA           AUTOR           RAZON                           */
/*   02/Mar/1993    P Mena           Emision inicial                    */
/*   16/Set/1998    G. George        Aumento del parametro @i_observacion*/
/*   02/Nov/1999    V.Molina E..     Aumento del prod_banc y categoria  */
/*   11/Sep/2000    Juan F. Cadena   Validacion de causa al levantar    */
/*   18/02/2005     D. Villagomez    No Pignorar cuentas de menores     */
/*   15/jUN/2006    P. COELLO        PERMITIR BLOQUEAR CUENTAS INACTIVAS*/
/*   07/Ago/2006    R. Ramos         Cotrol para causa de pignoracion   */
/*                                   lineas de sobregiro y pig. prest   */
/*   16/Sep/2006    R. Ramos         Cambiar causal 8 por 9 que es      */
/*                                   para tarj. de credito              */
/*   14/Dic/2006    P. COELLO        Validar que si el bloqueo es de    */
/*                                   una garantia no se pueda levantar  */
/*                                   manualmente                        */
/*   15/Ene/2010    O. Usiña         Agrega funcionalidad Embargos      */
/*   02/May/2016    J. Calderon      Migración a CEN                    */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_bloq_val_ah')
  drop proc sp_bloq_val_ah
go

create proc sp_bloq_val_ah
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_accion        char(1),
  @i_causa         char(3),
  @i_valor         money,
  @i_sec           int = null,
  @i_aut           descripcion,
  @i_solicit       descripcion = null,
  @i_plazo         smallint = null,
  @i_observacion   varchar(120) = null,
  @i_automatico    char(1) = 'N',
  @i_turno         smallint = null,

  --@i_ngarantia        int = null,
  @i_ngarantia     char(25) = null,
  @i_nlinea_sob    varchar(24) = null,
  @i_numcte        varchar(24) = null,
  @i_valida_saldo  char(1) = null,
  @i_corresponsal  char(1) = 'N',--Req. 381 CB Red Posicionada        
  @o_fecha_ven     smalldatetime = null out,
  @o_oficina_cta   smallint=null out,
  @o_prod_banc     tinyint = null out,
  @o_categoria     char(1) = null out,
  @o_siguiente     int = null out,
  @o_tipocta_super char(1) = null out,
  @o_no_bloq       char(1)= null out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_est              char(1),
    @w_covivencia       char(1),
    @w_filial           tinyint,
    @w_num_bloqueos     smallint,
    @w_secuencial       int,
    @w_monto_bloq       money,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_saldo            money,
    @w_saldo1           money,
    @w_monto            money,
    @w_monto1           money,
    @w_dif              money,
    @w_bloqueo          money,
    @w_causa            varchar(3),
    @w_causa_p          varchar(3),
    @w_fecha_ven        smalldatetime,
    @w_oficina_cta      smallint,
    @w_mayor_edad       tinyint,
    @w_tipo_ente        char(1),
    @w_fecha_nac        datetime,
    @w_fecha_hoy        datetime,
    @w_dia_hoy          smallint,
    @w_num_anios        tinyint,
    @w_mes_hoy          tinyint,
    @w_mes_nac          tinyint,
    @w_dia_nac          tinyint,
    @w_ente             int,
    @w_det_prod         int,
    @w_producto         tinyint,
    @w_oficina          smallint,
    @w_tipo             char(1),
    @w_continuar        tinyint,
    @w_pais             varchar(10),
    @w_cau              varchar(3),
    @w_monto_emb        money,
    @w_sql_up           varchar(255),
    @w_valor_tmp        money,
    @w_monblq           char(1),
    @w_prod_bancario    varchar(50), --Req. 381 CB Red Posicionada
    @w_prod_banc_pcaasa int,     
    @w_prod_banc_pcaaso int,
    @w_no_bloq          char(1),
    @w_causa_cont       char(3)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_bloq_val_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  select
    @w_fecha_hoy = convert(varchar(10), @s_date, 101)

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
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
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_accion = @i_accion,
      i_valor = @i_valor,
      i_aut = @i_aut,
      i_observa = @i_observacion
    exec cobis..sp_end_debug
  end

  if @t_trn not in (217, 218)
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /***** PCOELLO CONSULTAR CAUSA DE BLOQUEO DE GARANTIAS *****/
  select
    @w_causa_p = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'PIGAHO'
     and pa_producto = 'GAR'

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /***** PCOELLO CONSULTAR CAUSA DE BLOQUEO DE GARANTIAS *****/

    select
      @w_cuenta = ah_cuenta,
      @w_est = ah_estado,
      @w_oficina_cta = ah_oficina,
      @w_ente = ah_cliente,
      @w_producto = ah_producto,
      @w_oficina = ah_oficina,
      @w_tipo = ah_tipo
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end
  else
  begin
    /***** PCOELLO CONSULTAR CAUSA DE BLOQUEO DE GARANTIAS *****/

    select
      @w_cuenta = ah_cuenta,
      @w_est = ah_estado,
      @w_oficina_cta = ah_oficina,
      @w_ente = ah_cliente,
      @w_producto = ah_producto,
      @w_oficina = ah_oficina,
      @w_tipo = ah_tipo
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end

  -- VALIDA QUE LA CUENTA NO TENGA UN MENOR DE EDAD
  -- Obtencion de datos del ente propietario de la cuenta */

  select
    @w_det_prod = dp_det_producto
  from   cobis..cl_det_producto --(3)
  where  dp_cuenta   = @i_cta
     and dp_producto = @w_producto
     and dp_oficina  = @w_oficina
     and dp_tipo     = @w_tipo
     and dp_moneda   = @i_mon
  --set transaction isolation level read uncommitted

  select
    @w_continuar = 2,
    @w_ente = 0

  /*** REQ 217 SE COMENTA PORQUE ES PERMITIDO BLOQUEAR CUENTA DE MENOR DE EDAD
  while (@w_continuar > 1)
  begin
    set rowcount 1
    select 
       @w_ente = en_ente,
       @w_fecha_nac   = p_fecha_nac,
       @w_tipo_ente   = en_subtipo
    from  cobis..cl_ente,
      cobis..cl_cliente --(2)
     where  cl_det_producto = @w_det_prod
     and  en_ente = cl_cliente
     and en_ente > @w_ente 
     --set transaction isolation level read uncommitted
  
  
     if @@rowcount = 0
     begin
       set rowcount 0
       select @w_continuar = 0
     end
     set rowcount 0
  
     if @w_tipo_ente = 'P' and @t_trn = 217
     begin -- 1
        select @w_mayor_edad = pa_tinyint
        from cobis..cl_parametro
        where pa_producto ='ADM'
        and pa_nemonico='MDE'
  
  
        if @@rowcount <> 1
        begin             /* Error en lectura de SSN */
           exec cobis..sp_cerror
              @i_num       = 111020,
              @i_msg       = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
              return 111020
        end
  
        select @w_dia_hoy = datepart(dd,@w_fecha_hoy)
        -- Valida la mayoria de edad
  
        select @w_num_anios = datediff(yy,@w_fecha_nac,@w_fecha_hoy)
  
        if @w_num_anios < @w_mayor_edad
        begin
           exec cobis..sp_cerror
              @t_debug     = @t_debug,
              @t_file      = @t_file,
              @t_from      = @w_sp_name,
              @i_num       = 251085
           return 251085 -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
        end
        else
        begin -- 2
           if @w_num_anios = @w_mayor_edad
           begin  -- 3
              select @w_mes_hoy = datepart(mm,@w_fecha_hoy)
              select @w_mes_nac = datepart(mm,@w_fecha_nac)
              if @w_mes_hoy < @w_mes_nac
              begin
                  exec cobis..sp_cerror
                    @t_debug     = @t_debug,
                    @t_file      = @t_file,
                    @t_from      = @w_sp_name,
                    @i_num       = 251085
                  return 251085 -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
              end
              else
              begin  -- 4
                 if @w_mes_hoy = @w_mes_nac
                 begin
                    select @w_dia_nac = datepart(dd,@w_fecha_nac)
                    if @w_dia_hoy < @w_dia_nac
                    begin
                       exec cobis..sp_cerror
                          @t_debug     = @t_debug,                                        
                          @t_file      = @t_file,                                        
                          @t_from      = @w_sp_name,
                          @i_num       = 251085                                        
                       return 251085 -- 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR'
                    end
                 end
              end -- 4
           end -- 3
        end -- 2
     end -- 1
     select @w_continuar = @w_continuar + 1
  
  end -- while
   FIN: REQ 217 COMENTADO PARA PERMITIR BLOQUEO PARA MENORES DE EDAD ***/

  select
    @o_oficina_cta = @w_oficina_cta
  select
    @w_fecha_ven = dateadd(day,
                           @i_plazo,
                           @s_date)
  select
    @o_fecha_ven = @w_fecha_ven

  -- PAIS
  select
    @w_pais = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'ABPAIS'

  if @w_pais <> 'CO'
  begin
    /* Validaciones */
    if @w_est <> 'A'
       and @w_est <> 'I'
    --PCOELLO A LAS INACTIVAS TAMBIEN SE LES PUEDE HACER ESTE MOVIMIENTO
    begin
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251057
      return 1
    end
  end
  else
  begin
    if @i_causa <> '1'
       and @i_causa <> '3' /*  permitir embargos ctas inactivas */
      if @w_est <> 'A'
      begin
        exec cobis..sp_cerror1
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251002
        return 251002
      end
      else /* CLE Para embargos no se verifica ctas inactivas */
      begin
        if @w_est = 'C'
        begin
          /* Cuenta cancelada */
          exec cobis..sp_cerror1
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251057
          return 251057
        end
      end
  end

  if @i_accion not in ('B', 'L')
  begin
    /* No existe tipo de accion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251019
    return 1
  end

  select
    @w_monblq = 'S'

  if @t_trn = 217
     and @i_causa = '1'
     and @w_pais = 'CO'--Debito embargos Colombia
    select
      @w_monblq = 'N'

  /*  calcula los saldos  */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @i_valida_saldo     = @i_valida_saldo,
    @i_monblq           = @w_monblq,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      @w_num_bloqueos = ah_num_blqmonto,
      @w_monto_bloq = ah_monto_bloq,
      @o_prod_banc = ah_prod_banc,
      @o_categoria = ah_categoria,
      @o_tipocta_super = ah_tipocta_super,
      @w_monto_emb = ah_monto_emb
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta    = @w_cuenta
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
  end
  else
  begin
    select
      @w_num_bloqueos = ah_num_blqmonto,
      @w_monto_bloq = ah_monto_bloq,
      @o_prod_banc = ah_prod_banc,
      @o_categoria = ah_categoria,
      @o_tipocta_super = ah_tipocta_super,
      @w_monto_emb = ah_monto_emb
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta
  end

  /* Transaccion de bloqueos a la cuenta de ahorros */

  if @t_trn = 217
  begin
  --jca  
  select @w_prod_banc_pcaasa = pa_int 
  from  cobis..cl_parametro 
  where  pa_producto = 'AHO' 
     and pa_nemonico = 'PCAASA' 
  
  select @w_prod_banc_pcaaso = pa_int 
  from  cobis..cl_parametro 
  where  pa_producto = 'AHO' 
     and pa_nemonico = 'PCAASO'

  if  @o_prod_banc = @w_prod_banc_pcaasa or @o_prod_banc = @w_prod_banc_pcaaso
  begin
   
    print 'Las Ctas. de Aporte Social Ordinario y Adicional -->' + 'No se pueden Realizar Bloqueos de Valores ' 
   
    select @w_return = 1
     select @o_no_bloq = 'S'
     if @w_return <> 0
     begin
      return @w_return
     end  
  END
  --jca fin
    select
      @w_dif = @w_saldo_para_girar - @i_valor

    if @w_saldo_para_girar < @i_valor
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251045
      return 1
    end
    -- Control de verificacion de causa de pignacion
    if @i_causa in('10', '11', '9', '5') and (@s_term <> 'APPX') -- ROL 09012006
    begin
      if @i_causa = '5' --Lineas de sobregiro
      begin
        if not exists(select
                        1
                      from   cob_cuentas..cc_ctacte
                      where  cc_cta_banco = @i_numcte)
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251045,
            @i_msg   = 'NO EXISTE CUENTA CORRIENTE'
          return 1
        end
      end
      --      if @i_causa = '9' --Tarjetas de credito
      --      begin 
      --        if not exists(select 1 from cob_tarj_cre..vpsplastico where numtarjeta=@i_ngarantia)
      --        begin
      --           exec cobis..sp_cerror
      --              @t_debug     = @t_debug,
      --              @t_file      = @t_file,
      --              @t_from      = @w_sp_name,
      --              @i_num       = 251045,
      --              @i_msg       = 'NO EXISTE TARJETA DE CREDITO'
      --           return 1
      --         end       
      --      end

      if @i_causa in ('10', '11')
      begin
        -- Pignoracion para prestamos
        select
          @w_covivencia = pa_char
        from   cobis..cl_parametro
        where  pa_nemonico = 'INTCON'
        if @w_covivencia = 'S'
        begin
          if not exists(select
                          1
                        from   cob_remesas..re_prestamo_convivencia
                        where  pc_prestamo = @i_ngarantia)
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 251045,
              @i_msg   = 'NO EXISTE PRESTAMO'
            return 1
          end
        end
        else
        begin
          if not exists(select
                          1
                        from   cob_cartera..ca_operacion
                        where  op_banco = @i_ngarantia)
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 251045,
              @i_msg   = 'NO EXISTE PRESTAMO'
            return 1
          end
        end
      end
    end

    select
      @w_saldo_para_girar = @w_saldo_para_girar - @i_valor

    if @w_pais <> 'CO'
    begin
      select
        @w_num_bloqueos = @w_num_bloqueos + 1
      select
        @w_monto_bloq = @w_monto_bloq + @i_valor
      select
        @w_sql_up = 'update cob_ahorros..ah_cuenta set ah_num_blqmonto = '
                    + convert(varchar(10), @w_num_bloqueos) +
                    ', ah_monto_bloq    = '
                    + convert(varchar(20), @w_monto_bloq) +
                    ' where ah_cuenta    ='
                    + convert(varchar(10), @w_cuenta)
    end
    else
    BEGIN
    if @i_causa <> '1'
      begin
        select
          @w_num_bloqueos = @w_num_bloqueos + 1
        if @i_causa <> '3'
        begin
          select
            @w_monto_bloq = @w_monto_bloq + @i_valor
          select
            @w_sql_up = 'update cob_ahorros..ah_cuenta set ah_num_blqmonto   = '
                        + convert(varchar(10), @w_num_bloqueos) +
                        ', ah_monto_bloq    = '
                        + convert(varchar(20), @w_monto_bloq) +
                        ' where ah_cuenta    ='
                        + convert(varchar(10), @w_cuenta)
          select
            @w_monto_bloq = @w_monto_bloq + @w_monto_emb
        end
        else
        begin
          select
            @w_valor_tmp = @w_monto_bloq,
            @w_monto_bloq = @w_monto_emb + @i_valor
          select
            @w_sql_up = 'update cob_ahorros..ah_cuenta set ah_num_blqmonto   = '
                        + convert(varchar(10), @w_num_bloqueos) +
                        ', ah_monto_emb = '
                        + convert(varchar(20), @w_monto_bloq) +
                        ' where ah_cuenta    ='
                        + convert(varchar(10), @w_cuenta)
          select
            @w_monto_bloq = @w_monto_bloq + @w_valor_tmp
        end
      end
      else
        select
          @w_monto_bloq = @w_monto_bloq + @w_monto_emb + @i_valor
    end

    /* Generacion del secuencial para la insercion en la tabla */

    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_his_bloqueo',
      @o_siguiente = @w_secuencial out
    if @w_return <> 0
      return @w_return

    /* Actualizacion de las tablas: ah_his_bloqueo y ah_cuenta */

    begin tran

    select
      @o_siguiente = @w_secuencial

    insert into ah_his_bloqueo
                (hb_cuenta,hb_secuencial,hb_accion,hb_monto_bloq,hb_valor,
                 hb_fecha,hb_autorizante,hb_oficina,hb_saldo,hb_causa,
                 hb_levantado,hb_fecha_ven,hb_hora,hb_solicitante,hb_observacion
                 ,
                 hb_ngarantia,hb_nlinea_sob,hb_numcte)
    values      (@w_cuenta,@w_secuencial,'B',@w_monto_bloq,@i_valor,
                 @s_date,@i_aut,@s_ofi,@w_dif,@i_causa,
                 'NO',@w_fecha_ven,getdate(),@i_solicit,@i_observacion,
                 @i_ngarantia,@i_nlinea_sob,@i_numcte)

    if @@error <> 0
    begin
      /* Error en creacion de registro en ah_his_bloqueo */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203009
      return 1
    end

    /* EMBARGOS  'OUS */
    if @i_causa = '1'  and @w_pais = 'CO'
    BEGIN
     select
        @w_cau = null

      select
        @w_cau = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'NDAHO'

      if @w_cau is null
      begin
        /* No existe parametro ND Embargo */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101077
        return 101077
      end

      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv           = @s_srv,
        @s_ofi           = @s_ofi,
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_rol           = @s_rol,
        @s_user          = @s_user,
        @s_term          = @s_term,
        @t_trn           = 264,
        @i_cta           = @i_cta,
        @i_val           = @i_valor,
        @i_cau           = @w_cau,
        @i_mon           = @i_mon,
        @t_corr          = 'N',
        @i_alt           = 10,
        @i_fecha         = @s_date,
        @i_imp           = 'S',
        @i_turno         = @i_turno,
        @i_cobiva        = 'S',
        @i_verificar_blq = 'N',
        @i_inmovi        = 'S',
        @i_valida_saldo  = @i_valida_saldo

      if @w_return <> 0
        return @w_return

      exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'ah_his_bloqueo',
        @o_siguiente = @w_secuencial out

      if @w_return <> 0
        return @w_return

      select
        @w_monto_bloq = @w_monto_bloq - @i_valor

      insert into ah_his_bloqueo
                  (hb_cuenta,hb_secuencial,hb_accion,hb_monto_bloq,hb_valor,
                   hb_fecha,hb_autorizante,hb_oficina,hb_saldo,hb_causa,
                   hb_levantado,hb_fecha_ven,hb_hora,hb_solicitante,
                   hb_observacion
                   ,
                   hb_ngarantia,hb_nlinea_sob,hb_numcte,
                   hb_sec_asoc)
      values      (@w_cuenta,@w_secuencial,'L',@w_monto_bloq,@i_valor,
                   @s_date,@i_aut,@s_ofi,@w_dif,@i_causa,
                   'OK',@w_fecha_ven,getdate(),@i_solicit,@i_observacion,
                   @i_ngarantia,@i_nlinea_sob,@i_numcte,@o_siguiente)

      if @@error <> 0
      begin
        exec cobis..sp_cerror1
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = '255008'
        return 255008
      end

      update cob_ahorros..ah_his_bloqueo
      set    hb_levantado = 'SI',
             hb_solicitante = 'AUTOMATICO CTAS-EMBARGOS'
      where  hb_cuenta     = @w_cuenta
         and hb_secuencial = @o_siguiente

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror1
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255008
        return 255008
      end
    end
    else
    begin
      exec (@w_sql_up)

      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro en ah_cuenta */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255001
        return 1
      end
    end

    /* Creacion de transaccion de servicio */
    insert into cob_ahorros..ah_tsbloqueo
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,oficina,reentry,origen,cta_banco,
                 fecha,valor,accion,causa,autorizante,
                 moneda,hora,solicitante,fecha_vencim,oficina_cta,
                 observacion,prod_banc,categoria,tipocta_super,turno)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                 @s_date,@i_valor,'B',@i_causa,@i_aut,
                 @i_mon,getdate(),@i_solicit,@w_fecha_ven,@w_oficina_cta,
                 @i_observacion,@o_prod_banc,@o_categoria,@o_tipocta_super,
                 @i_turno)

    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    end
    commit tran
    return 0
  end

  /* Transaccion de levantamiento de bloqueos a la cuenta */
  if @t_trn = 218
  begin
    /* Generacion del secuencial para la insercion en la tabla */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_his_bloqueo',
      @o_siguiente = @w_secuencial out

    if @w_return <> 0
      return @w_return

    select
      @w_bloqueo = hb_valor,
      @w_saldo = hb_saldo,
      @w_monto = hb_monto_bloq,
      @w_causa = hb_causa
    from   cob_ahorros..ah_his_bloqueo
    where  hb_cuenta     = @w_cuenta
       and hb_secuencial = @i_sec

    if @i_automatico = 'N'
       and @w_causa = @w_causa_p
    begin
      --No se puede levantar el bloqueo de forma manual
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251082
      return 1
    end

    if @i_valor > @w_bloqueo
    begin
      /* Valor a levantar execede a monto bloqueado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251046
      return 1
    end

  /*if @i_causa <> @w_causa    lgr
   begin
    -- CAUSA NO COINCIDE CON LA DEL BLOQUEO
    exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 251079
        return 1
   end
  */
  
      select @w_causa_cont = hb_causa
       from   cob_ahorros..ah_his_bloqueo
       where  hb_cuenta     = @w_cuenta
       and    hb_secuencial = @i_sec
      
      if @@rowcount = 0
      begin
        exec cobis..sp_cerror1
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255008
        return 255008
      end      
    

      if exists (SELECT 1 FROM cobis..cl_tabla t, cobis..cl_catalogo c
                          WHERE t.tabla = 'ah_causa_desbloq_contb'  AND t.codigo = c.tabla AND c.codigo = @i_causa)
      begin
            if not exists(SELECT 1 FROM cobis..cl_tabla t, cobis..cl_catalogo c
                          WHERE t.tabla = 'ah_causa_bloq_contb' AND t.codigo = c.tabla AND c.codigo = @w_causa_cont)
              begin
                  exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 251045,
                    @i_msg   = 'LA CAUSA DEL BLOQUEO Y DEL LEVANTAMIENTO NO COINCIDEN (-- ESCOGER CAUSA NO CONTABILIZABLE)'
                  return 1
              
              end
            
      end
      else
      begin
            if exists(SELECT 1 FROM cobis..cl_tabla t, cobis..cl_catalogo c
                          WHERE t.tabla = 'ah_causa_bloq_contb' AND t.codigo = c.tabla AND c.codigo = @w_causa_cont)
              begin
                  exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 251045,
                    @i_msg   = 'LA CAUSA DEL BLOQUEO Y DEL LEVANTAMIENTO NO COINCIDEN (--ESCOGER CAUSA CONTABILIZABLE)'
                  return 1
              
              end         
      
      end

    /* Actualizacion de las tablas: ah_his_bloqueo y ah_cuenta */
    begin tran
    if @i_valor = @w_bloqueo
    begin
      update cob_ahorros..ah_his_bloqueo
      set    hb_levantado = 'SI'
      where  hb_cuenta     = @w_cuenta
         and hb_secuencial = @i_sec

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = '255008'
        return 1
      end

      if (@w_causa = 1
           or @w_causa = 3)
         and @w_pais = 'CO'
      begin
        if @w_causa = '1'
        begin
          select
            @w_saldo1 = @w_saldo + @w_bloqueo,
            @w_monto1 = @w_monto
        end
        if @w_causa = '3'
        begin
          update cob_ahorros..ah_cuenta
          set    ah_num_blqmonto = @w_num_bloqueos - 1,
                 ah_monto_emb = @w_monto_emb - @i_valor
          where  ah_cuenta = @w_cuenta

          if @@rowcount <> 1
          begin
            /* Error en actualizacion de registro en ah_cuenta */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 255001
            return 1
          end
          select
            @w_saldo1 = @w_saldo + @w_bloqueo,
            @w_monto1 = @w_monto - @w_bloqueo
        end
      end
      else
      begin
        update cob_ahorros..ah_cuenta
        set    ah_num_blqmonto = @w_num_bloqueos - 1,
               ah_monto_bloq = @w_monto_bloq - @i_valor
        where  ah_cuenta = @w_cuenta

        if @@rowcount <> 1
        begin
          /* Error en actualizacion de registro en ah_cuenta */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 255001
          return 1
        end
        select
          @w_saldo1 = @w_saldo + @w_bloqueo,
          @w_monto1 = @w_monto - @w_bloqueo
      end

      select
        @o_siguiente = @w_secuencial
      /* Generacion del registro del levantameinto */

      insert into cob_ahorros..ah_his_bloqueo
                  (hb_cuenta,hb_secuencial,hb_accion,hb_monto_bloq,hb_valor,
                   hb_fecha,hb_autorizante,hb_oficina,hb_saldo,hb_causa,
                   hb_levantado,hb_fecha_ven,hb_hora,hb_solicitante,hb_sec_asoc,
                   hb_observacion)
      values      (@w_cuenta,@w_secuencial,'L',@w_monto1,@i_valor,
                   @s_date,@i_aut,@s_ofi,@w_saldo1,@i_causa,
                   'OK',@w_fecha_ven,getdate(),@i_solicit,@i_sec,
                   @i_observacion)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = '255008'
        return 1
      end

      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   fecha,valor,accion,causa,autorizante,
                   moneda,hora,solicitante,fecha_vencim,oficina_cta,
                   prod_banc,categoria,tipocta_super,turno)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                   @s_date,@i_valor,'L',@i_causa,@i_aut,
                   @i_mon,getdate(),@i_solicit,@w_fecha_ven,@w_oficina_cta,
                   @o_prod_banc,@o_categoria,@o_tipocta_super,@i_turno)

      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 203005
        return 1
      end
      commit tran
      return 0
    end
  end

  return 0

go

