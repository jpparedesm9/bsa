use cob_ahorros
go

/************************************************************************/
/*   Archivo            : ah_traslado_ofi.sp                            */
/*   Stored procedure   : sp_traslado_oficina                           */
/*   Base de datos      : cob_ahorros                                   */
/*   Producto           : AHORROS                                       */
/*   Disenado por       : Andres Muñoz                                  */
/*   Fecha de escritura : 2013/12/16                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
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
/*                        PROPOSITO                                     */
/*   Trasladar oficina de costos de una oficina origen x a una          */
/*   oficina destino y, este programa se puede ejecutar en linea        */
/*   (oficina especifica) o fuera de linea(Batch Masivo)                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA                AUTOR              RAZON                      */
/*   2013/12/16           Andres Muñoz       Emision Inicial            */
/*   02/May/2016          Walther Toledo      Migración a CEN           */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_traslado_oficina')
  drop proc sp_traslado_oficina
go

create proc sp_traslado_oficina
(
  @i_param1       int,--Oficina Origen
  @i_param2       int,--Oficina Destino
  @i_param3       varchar(20) = null,--Cuenta
  @i_batch        char(1) = 'S',--ejecucion batch
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_ssn          int = null,
  @t_show_version bit = 0,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(32),
    @w_ofiorig          int,
    @w_ofidest          int,
    @w_ctabco           cuenta,
    @w_cuenta           int,
    @w_estado           char(1),
    @w_trasladada       char(1),
    @w_error            int,
    @w_msg              varchar(250),
    @w_srv              varchar(20),
    @w_usuario          varchar(20),
    @w_terminal         varchar(20),
    @w_tsfecha          datetime,
    @w_secuencial       int,
    @w_clase            char(1),
    @w_tipo_transaccion smallint,
    @w_causa            varchar(10),
    @w_archivo          varchar(60),
    @w_hora             datetime,
    @w_saldo            money,
    @w_interes          money,
    @w_cliente          int,
    @w_valor            money,
    @w_monto            money,
    @w_producto         smallint,
    @w_clase_clte       char(1),
    @w_s_app            varchar(255),
    @w_path             varchar(255),
    @w_nombre           varchar(255),
    @w_nombre_cab       varchar(255),
    @w_destino          varchar(2500),
    @w_errores          varchar(1500),
    @w_nombre_plano     varchar(2500),
    @w_col_id           int,
    @w_columna          varchar(100),
    @w_cabecera         varchar(2500),
    @w_nom_tabla        varchar(100),
    @w_comando          varchar(2500),
    @w_path_destino     varchar(30),
    @w_cmd              varchar(2500),
    @w_anio             varchar(4),
    @w_mes              varchar(2),
    @w_dia              varchar(2),
    @w_fecha1           varchar(10)

  --declaracion vaiables de trabajo
  select
    @w_ofiorig = @i_param1,
    @w_ofidest = @i_param2,
    @w_ctabco = @i_param3,
    @w_sp_name = 'sp_traslado_oficina',
    @w_hora = getdate(),
    @w_tsfecha = (select
                    fp_fecha
                  from   cobis..ba_fecha_proceso)

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @i_batch = 'S'
  begin
    select
      @w_tipo_transaccion = 374,
      @w_terminal = 'CONSOLA',
      @w_usuario = 'op_batch'

    select
      @w_secuencial = max(ts_secuencial) + 1
    from   cob_ahorros..ah_tran_servicio

    --GENERA SECUENCIAL AUTOMATTICO
    if @w_secuencial is null
      exec @w_secuencial = ADMIN...rp_ssn
  end
  else
  begin
    select
      @w_tipo_transaccion = @t_trn,
      @w_terminal = @s_term,
      @w_usuario = @s_user,
      @w_secuencial = @s_ssn
  end

  --Validaciones
  if (select
        count(1)
      from   cobis..cl_oficina
      where  of_oficina = @w_ofiorig) = 0
  begin
    select
      @w_error = 190519,
      @w_msg = 'OFICINA ORIGEN NO EXISTE'
    goto ERRORFIN
  end

  if (select
        count(1)
      from   cob_conta..cb_oficina
      where  of_oficina = @w_ofiorig) = 0
  begin
    select
      @w_error = 190519,
      @w_msg = 'OFICINA (CONTA) ORIGEN NO EXISTE'
    goto ERRORFIN
  end

  if (select
        count(1)
      from   cobis..cl_oficina
      where  of_oficina = @w_ofidest) = 0
  begin
    select
      @w_error = 190519,
      @w_msg = 'OFICINA (ADMIN) DESTINO NO EXISTE'
    goto ERRORFIN
  end

  if (select
        count(1)
      from   cob_conta..cb_oficina
      where  of_oficina = @w_ofidest) = 0
  begin
    select
      @w_error = 190519,
      @w_msg = 'OFICINA (CONTA) DESTINO NO EXISTE'
    goto ERRORFIN
  end

  --Crea tabla temporal de trabajo
  select
    cuenta = ah_cuenta,
    ofiorig = ah_oficina,
    ofidest = ah_oficina,
    ctabco = ah_cta_banco,
    estcta = ah_estado,
    trasla = ah_estado
  into   #cuenta
  from   cob_ahorros..ah_cuenta
  where  1 = 2

  if @w_ctabco is not null
     and @w_ctabco <> '0'
  begin
    --Busca Oficina Origen de la cuenta
    select
      @w_ofiorig = ah_oficina,
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado,
      @w_trasladada = 'N'
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @w_ctabco

    if @@rowcount = 0
    begin
      select
        @w_error = 251001,
        @w_msg = 'NO EXISTE CUENTA DE AHORROS'
      goto ERRORFIN
    end

    if (select
          count(1)
        from   cob_remesas..re_tesoro_nacional
        where  tn_cuenta = @w_ctabco
           and tn_estado = 'P') > 0
      select
        @w_trasladada = 'S'

    insert into #cuenta
    values      (@w_cuenta,@w_ofiorig,@w_ofidest,@w_ctabco,@w_estado,
                 @w_trasladada)
    if @@error <> 0
    begin
      select
        @w_error = 251030,
        @w_msg = 'ERROR AL INGRESAR CUENTAS A TRASLADAR'
      goto ERRORFIN
    end
  end
  else
  begin
    insert into #cuenta
      select
        ah_cuenta,ah_oficina,@w_ofidest,ah_cta_banco,ah_estado,
        'N'
      from   cob_ahorros..ah_cuenta
      where  ah_oficina = @w_ofiorig
         and ((ah_estado <> 'C')
               or (ah_estado  = 'C'
                   and ah_cta_banco in
                       (select
                          oc_ref3
                        from   cob_remesas..re_orden_caja
                        where  oc_oficina = @w_ofiorig
                           and oc_estado  = 'I'
                           and (oc_tipo    = 'P'
                                and oc_causa in ('035', '014')))))

    if @@error <> 0
    begin
      select
        @w_error = 251030,
        @w_msg = 'ERROR AL INGRESAR CUENTAS A TRASLADAR'
      goto ERRORFIN
    end

    update #cuenta
    set    trasla = 'S'
    from   #cuenta,
           cob_remesas..re_tesoro_nacional
    where  tn_cuenta = ctabco
       and tn_estado = 'P'

    if @@error <> 0
    begin
      select
        @w_error = 276002,
        @w_msg = 'ERROR AL ACTUALIZAR CUENTAS TRASLADADAS A DTN'
      goto ERRORFIN
    end
  end

  select
    *
  into   #cuantas_a_trasladar
  from   #cuenta
  order  by cuenta

  while 1 = 1
  begin
    --Inicializacion de variables
    select
      @w_cuenta = null,
      @w_ofiorig = null,
      @w_ofidest = null,
      @w_ctabco = null,
      @w_estado = null,
      @w_trasladada = null,
      @w_cliente = null,
      @w_saldo = null,
      @w_valor = null,
      @w_monto = null,
      @w_interes = null,
      @w_producto = null,
      @w_clase_clte = null

    select top 1
      @w_cuenta = cuenta,
      @w_ofiorig = ofiorig,
      @w_ofidest = ofidest,
      @w_ctabco = ctabco,
      @w_estado = estcta,
      @w_trasladada = trasla
    from   #cuantas_a_trasladar
    order  by cuenta

    if @@rowcount = 0
      break

    select
      @w_cliente = ah_cliente,
      @w_saldo = ah_disponible + ah_12h + ah_24h,
      @w_valor = ah_disponible,
      @w_monto = ah_12h + ah_24h,
      @w_interes = ah_saldo_interes,
      @w_producto = ah_prod_banc,
      @w_clase_clte = ah_clase_clte
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta

    if @w_estado = 'N'
      goto SIGUE

    -- Trn Servicio (debe incluir saldo en todos los estados - disponible - canje - pendiente de pago para las cuentas canceladas)

    if @w_estado = 'C'
    begin
      /** MOVIMIENTO SALDO CONTABLE PARA TRASLADO DE CUENTAS CON ESTADO CANCELADAS **/

      select
        @w_saldo = oc_valor,
        @w_valor = oc_valor,
        @w_monto = 0,
        @w_interes = 0
      from   cob_remesas..re_orden_caja
      where  oc_ref3    = @w_ctabco
         and oc_oficina = @w_ofiorig
         and oc_estado  = 'I'
         and (oc_tipo    = 'P'
              and oc_causa in ('035', '014'))

      if @@rowcount = 0
        goto SIGUE

      begin tran

      insert into cob_ahorros..ah_tran_servicio
                  (ts_usuario,ts_terminal,ts_tsfecha,ts_secuencial,ts_clase,
                   ts_hora,ts_tipo_transaccion,ts_cliente,ts_oficina,
                   ts_oficina_cta,
                   ts_cta_banco,ts_estado,ts_saldo,ts_valor,ts_monto,
                   ts_interes,ts_prod_banc,ts_moneda,ts_clase_clte,ts_causa)
      values      ( @w_usuario,@w_terminal,@w_tsfecha,@w_secuencial,'D',
                    @w_hora,@w_tipo_transaccion,@w_cliente,@w_ofiorig,@w_ofidest
                    ,
                    @w_ctabco,null,@w_saldo,@w_valor,
                    @w_monto,
                    @w_interes,@w_producto,0,@w_clase_clte,case @w_trasladada
                      when 'S' then 'T'
                      else @w_estado
                    end )

      if @@error <> 0
      begin
        select
          @w_error = 253004,
          @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO + TRASLADO '
        goto ERRORFIN
      end
    end
    else
    begin
      begin tran

      /** MOVIMIENTO SALDO CONTABLE PARA TRASLADO DE CUENTAS CON ESTADO DIFERENTE A CANCELADAS **/
      insert into cob_ahorros..ah_tran_servicio
                  (ts_usuario,ts_terminal,ts_tsfecha,ts_secuencial,ts_clase,
                   ts_hora,ts_tipo_transaccion,ts_cliente,ts_oficina,
                   ts_oficina_cta,
                   ts_cta_banco,ts_estado,ts_saldo,ts_valor,ts_monto,
                   ts_interes,ts_prod_banc,ts_moneda,ts_clase_clte,ts_causa)
      values      ( @w_usuario,@w_terminal,@w_tsfecha,@w_secuencial,'D',
                    @w_hora,@w_tipo_transaccion,@w_cliente,@w_ofiorig,@w_ofidest
                    ,
                    @w_ctabco,null,@w_saldo,@w_valor,
                    @w_monto,
                    @w_interes,@w_producto,0,@w_clase_clte,case @w_trasladada
                      when 'S' then 'T'
                      else @w_estado
                    end )

      if @@error <> 0
      begin
        select
          @w_error = 253004,
          @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO + TRASLADO '
        goto ERRORFIN
      end
    end

    -- Actualizacion oficina en maestro de ahorros
    update cob_ahorros..ah_cuenta
    set    ah_oficina = @w_ofidest
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta

    if @@error <> 0
    begin
      select
        @w_error = 276001,
        @w_msg = 'ERROR AL ACTUALIZAR OFICINA DE CUENTA DE AHORROS'
      goto ERRORFIN
    end

    -- Ordenes de pago en caja - Registros de cierre sin pagar
    update cob_remesas..re_orden_caja
    set    oc_oficina = @w_ofidest
    where  oc_ref3    = @w_ctabco
       and oc_oficina = @w_ofiorig
       and oc_estado  = 'I'

    if @@error <> 0
    begin
      select
        @w_error = 276003,
        @w_msg =
      'ERROR AL ACTUALIZAR OFIDEST EN ORDENES DE PAGO EN CAJA PENDIENTES'
      goto ERRORFIN
    end

    commit tran

    select
      @w_secuencial = @w_secuencial + 1

    goto SIGUE

    SIGUE:
    delete from #cuantas_a_trasladar
    where  cuenta = @w_cuenta
  end

  -- Cheques pendientes de emision
  select
    *
  into   Cheq_penemi
  from   cob_sbancarios..sb_impresion_lotes
  where  il_oficina_destino = @w_ofiorig
     and il_estado          = 'D' --Pendiente de impresion

  if @@error <> 0
  begin
    select
      @w_error = 276000,
      @w_msg = 'Error al guardar ChqGer pendientes de imprimir'
    goto ERRORFIN
  end

  if (select
        count(1)
      from   Cheq_penemi) = 0
  begin
    select
      @w_msg = 'NO HAY CHEQUES PENDIENTES DE IMPRESION PARA LA OFICINA: '
    drop table Cheq_penemi
    print cast(@w_msg as varchar(50)) + cast(@w_ofiorig as varchar)
    goto FIN
  end

  /* Iniciando BCP */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  --Generando la fecha para el nombre del archivo
  select
    @w_anio = convert(varchar(4), datepart(yyyy,
                                           getdate())),
    @w_mes = convert(varchar(2), datepart(mm,
                                          getdate())),
    @w_dia = convert(varchar(2), datepart(dd,
                                          getdate()))

  select
    @w_fecha1 = (@w_anio + right('00' + @w_mes, 2) + right('00'+ @w_dia, 2))

  --Seleccionando el path destino para archivo de salida
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 4

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_nombre = 'CHQGER_PENDIMP_OF' + cast(@w_ofiorig as varchar),
    @w_nom_tabla = 'Cheq_penemi',
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_cab = @w_nombre

  select
    @w_nombre_plano = @w_path + @w_nombre_cab + '_' + @w_fecha1 + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cob_ahorros..sysobjects o,
           cob_ahorros..syscolumns c
    where  o.id    = c.id
       and o.name  = @w_nom_tabla
       and c.colid > @w_col_id
    order  by c.colid

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    select
      @w_cabecera = @w_cabecera + @w_columna + '^|'
  end

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  --Ejecucion para Generar Archivo Datos
  select
    @w_comando =
    @w_s_app + 's_app bcp -auto -login cob_ahorros..Cheq_penemi out '

  select
    @w_destino = @w_path + 'CHQGER_PENDIMP.txt',
    @w_errores = @w_path + 'CHQGER_PENDIMP.err'

  select
    @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                 ' -t"|" '
                                                                        +
                 '-config '
                                                                        +
                 @w_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg =
'Error Generando Archivo Reporte de Cheques de gerencia Pendientes de Imprimir'
  goto ERRORFIN
end

  ----------------------------------------
  --Union de archivos (cab) y (dat)
  ----------------------------------------
  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'CHQGER_PENDIMP.txt'
                        + ' ' +
                        @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando

  select
    @w_cmd = 'del ' + @w_destino
  exec xp_cmdshell
    @w_cmd

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end
  else
    drop table cob_ahorros..Cheq_penemi

  goto FIN

  FIN:

  print 'TRASLADO DE OFICINA OK!'

  return 0

  ERRORFIN:

  if exists (select
               1
             from   sysobjects
             where  name = 'Cheq_penemi'
                and type = 'U')
    drop table cob_ahorros..Cheq_penemi

  if @i_batch = 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_msg   = @w_msg
  end
  else
  begin
    print cast(upper(@w_sp_name) as varchar) + ', ERROR: ' + cast(@w_error as
          varchar) +
          ', '
          + cast(@w_msg as varchar(255))
    print 'Cuenta: ' + cast(@w_cuenta as varchar)
  end

  return @w_error

go

