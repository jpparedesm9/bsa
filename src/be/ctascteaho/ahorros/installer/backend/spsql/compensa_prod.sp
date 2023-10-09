/************************************************************************/
/*  Archivo:                compensa_prod.sp                            */
/*  Stored procedure:       sp_compensa_prod                            */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Migracion CEN                               */
/*  Fecha de escritura:     03/05/2016                                  */
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
/*    Este programa realiza la compensación de lso productos            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR           RAZON                               */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_compensa_prod')
    drop proc sp_compensa_prod
go

create proc sp_compensa_prod
(
  @t_show_version bit = 0
)
as
  declare
    @w_fecha           datetime,
    @w_registro        int,
    @w_tabla           int,
    @w_return          int,
    @w_cliente         int,
    @w_cliente_ec      int,
    @w_rol             char(1),
    @w_saldo           money,
    @w_banco           varchar(20),
    @w_cta_banco       varchar(20),
    @w_cuenta          int,
    @w_titularidad     char(1),
    @w_saldo_cta       money,
    @w_ah_oficina      smallint,
    @w_ah_oficina_dest smallint,
    @w_ah_moneda       tinyint,
    @w_iva_ret         money,
    @w_gmf_ret         money,
    @w_valor_aplicar   money,
    @w_numdeci         tinyint,
    @w_producto        tinyint,
    @w_acumu_deb       money,
    @w_actualiza       char(1),
    @w_base_gmf        money,
    @w_concep_exc      smallint,
    @w_tasa_reintegro  float,
    @w_gmf_reintegro   money,
    @w_val_nx1000      money,
    @w_mensaje         mensaje,
    @w_conjunta        int,
    @w_tipo_doc        char(2),
    @w_identificacion  varchar(30),
    @w_nombre_cliente  varchar(60),
    @w_secuencial      int,
    @w_prod_banc       char(1),
    @w_tipo_op         varchar(10),
    @w_ofi_desc        varchar(100),
    @w_sp_name         varchar(100),
    @w_error           int,
    @w_num_banco       int,
    @w_mayoriaEdad     int,
    @w_msg             varchar(100),
    @w_valor_minimo    money,
    @w_debug           char(1),
    @w_saldo_cuenta    money

  select
    @w_sp_name = 'sp_compensa_prod'
	
	 ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  
  Select @w_secuencial = 0,
         @w_debug = 'N' ----PARA SEGUIMIENTO

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_registro = count(1)
  from   cob_cartera..ca_universo_cartera

  if @w_registro = 0
  begin
    print 'NO SE HA GENERADO UN UNIVERSO DE OPERACIONES PARA APLICAR'
    return 0
  end

  select
    @w_tabla = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_prodah_compensacion'
  if @@rowcount = 0
  begin
    select
      @w_error = 208106,
      @w_msg = 'NO SE ENCUENTRA LA TABLA cl_prodah_compensacion'
    goto ERRORFIN
  end

  select
    @w_numdeci = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'DCI'
     and pa_producto = 'AHO'
  if @@rowcount = 0
  begin
    select
      @w_error = 201196,
      @w_msg = 'NO SE ENCUENTRA CREADO EL PARAMETRO - DCI'
    goto ERRORFIN
  end

  select
    @w_valor_minimo = pa_money
  from   cobis..cl_parametro
  where  pa_nemonico = 'MINCOM'
     and pa_producto = 'CCA'
  if @@rowcount = 0
  begin
    select
      @w_error = 201196,
      @w_msg = 'NO SE ENCUENTRA CREADO EL PARAMETRO - MINCOM'
    goto ERRORFIN
  end

  select
    @w_mayoriaEdad = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'MDE'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    select
      @w_error = 201196,
      @w_msg = 'NO SE ENCUENTRA CREADO EL PARAMETRO - MAYORIA DE EDAD'
    goto ERRORFIN
  end

  select
    uc_cliente,
    uc_operacion,
    uc_rol
  into   #ca_universo_cartera
  from   cob_cartera..ca_universo_cartera
  if @@rowcount = 0
  begin
    select
      @w_error = 201086,
      @w_msg = 'NO HAY REGISTROS EN  cob_cartera..ca_universo_cartera '
    goto ERRORFIN
  end

  truncate table cob_ahorros..ah_compensacion_actpas
  truncate table cob_ahorros..ah_saldoscompensa_actpas

  select
    ua_cliente = uc_cliente,
    ua_saldo = ah_disponible,
    ua_cta_banco = ah_cta_banco,
    ua_documento = ah_ced_ruc,
    ua_titularidad = ah_ctitularidad,
    ua_edad = datediff(yy,
                       p_fecha_nac,
                       @w_fecha),
    ua_tpersona = en_subtipo,
    ua_cuenta = ah_cuenta,
    ua_oficina = ah_oficina,
    ua_moneda = ah_moneda,
    ua_producto = ah_producto,
    ua_prod_banc = ah_prod_banc
  into   #universo_ahorros
  from   #ca_universo_cartera,
         cobis..cl_det_producto,
         cobis..cl_cliente,
         cobis..cl_ente,
         cob_ahorros..ah_cuenta
  where  cl_det_producto = dp_det_producto
     and dp_cuenta       = ah_cta_banco
     and cl_cliente      = en_ente
     and dp_producto     = 4 -- AHORROS
     and cl_cliente      = uc_cliente
     and (ah_estado in ('I', 'A'))
     and ah_disponible   > @w_valor_minimo
     and ah_prod_banc in
         (select
            codigo
          from   cobis..cl_catalogo
          where  tabla  = @w_tabla
             and estado = 'V')
     and ah_cta_banco not in (select
                                tn_cuenta
                              from   cob_remesas..re_tesoro_nacional
                              where  tn_estado = 'P')
     and ah_cta_banco not in (select
                                de_num_cuenta
                              from   cobis..cl_cab_embargo,
                                     cobis..cl_det_embargo
                              where  ca_ente         = de_ente
                                 and ca_secuencial   = de_secuencial
                                 and ca_tipo_proceso = 'B')

  if @@rowcount = 0
  begin
    select
      @w_error = 201086,
      @w_msg = 'NO HAY REGSTROS EN CUENTAS DE AHORROS PARA PROCESAR'
    goto ERRORFIN
  end

  insert into cob_ahorros..ah_saldoscompensa_actpas
              (sc_cliente,sc_saldo,sc_documento,sc_cta_banco,sc_titularidad,
               sc_oficina,sc_moneda,sc_producto,sc_prod_banc,sc_cuenta)
    select
      ua_cliente,ua_saldo,ua_documento,ua_cta_banco,ua_titularidad,
      ua_oficina,ua_moneda,ua_producto,ua_prod_banc,ua_cuenta
    from   #universo_ahorros
    where  ua_edad     > @w_mayoriaEdad
       and ua_tpersona = 'P'

  if (@@error <> 0
       or @@rowcount = 0)
  begin
    if @@error <> 0
    begin
      select
        @w_error = 263500,
        @w_msg = 'ERROR  INSERTANDO EN  ah_saldoscompensa_actpas'
      goto ERRORFIN
    end
    if @@rowcount = 0
    begin
      select
        @w_error = 201086,
        @w_msg = 'NO HAY REGSTROS QUE CUMPLAN LA MAYORIA DE EDAD PARA PROCESAR'
      goto ERRORFIN
    end
  end

  select
    uo_cliente = uc_cliente,
    uo_rol = uc_rol,
    uo_dia_mora = uc_dias_mora,
    uo_saldo_mora = uc_saldo_mora,
    uo_banco = uc_operacion,
    uo_toperacion = uc_tipo_op,
    uo_estado = uc_estado,
    uo_cuenta = uc_cuenta,
    uo_observacion = convert(varchar(255), null)
  into   #univ_operacion
  from   cob_cartera..ca_universo_cartera
  order  by uc_dias_mora,
            uc_rol desc
  if @@error <> 0
  begin
    select
      @w_error = 263500,
      @w_msg =
    'ERROR  INSERTANDO UNIVERSO DE PARA PROCESAR EN  #univ_operacion '
    goto ERRORFIN
  end

  while 1 = 1
  begin
    select
      @w_conjunta = 0

    select top 1
      @w_cliente = uo_cliente,
      @w_rol = uo_rol,
      @w_saldo = uo_saldo_mora,
      @w_banco = uo_banco,
      @w_tipo_op = uo_toperacion,
      @w_num_banco = uo_cuenta
    from   #univ_operacion
    where  uo_estado = 'I'
    order  by uo_dia_mora desc

    if @@rowcount = 0
      break

    if @w_debug = 'S'
      print 'Cliente ' + cast(@w_cliente as varchar) + ' Rol ' + cast(@w_rol as
                                        varchar)
            + '  Saldo Cartera ' + cast(@w_saldo as varchar) + ' Operacion '
            + cast(@w_banco as varchar) + '  Tipo Op ' + cast(@w_tipo_op as
            varchar)
            +
                                        ' Cuenta '
            + cast(@w_num_banco as varchar)

    if exists (select
                 1
               from   sysobjects
               where  name = 'saldo_compensa')
      drop table saldo_compensa

    select
      sc_cuenta,
      sc_saldo,
      sc_titularidad,
      sc_cliente,
      sc_oficina,
      sc_moneda,
      sc_producto,
      sc_prod_banc,
      sc_cta_banco
    into   saldo_compensa
    from   cob_ahorros..ah_saldoscompensa_actpas
    where  sc_cliente = @w_cliente
       and sc_saldo   > @w_valor_minimo
    order  by sc_saldo desc

    if @@rowcount = 0
      goto SIG_OPERACION

    while 1 = 1
    begin
      select top 1
        @w_cta_banco = sc_cta_banco,
        @w_saldo_cta = sc_saldo,
        @w_titularidad = sc_titularidad,
        @w_cuenta = sc_cuenta,
        @w_ah_oficina = sc_oficina,
        @w_ah_moneda = sc_moneda,
        @w_producto = sc_producto,
        @w_prod_banc = sc_prod_banc
      from   saldo_compensa
      where  sc_cliente = @w_cliente

      if @@rowcount = 0
        break

      select
        @w_saldo_cuenta = sum(co_valor_aplicado)
      from   cob_ahorros..ah_compensacion_actpas
      where  co_num_producto = @w_saldo_cta

      --Valido el valor aplicado que acumula la cuenta para verificar si todavÃa posee saldo
      select
        @w_saldo_cuenta = @w_saldo_cuenta - @w_saldo_cta

      if @w_valor_minimo >= @w_saldo_cuenta
        goto SIG_CTA

      if @w_debug = 'S'
        print 'Cliente ' + cast(@w_cliente as varchar) + ' Rol ' + cast(@w_rol
              as
                                                 varchar)
              + ' Saldo Cartera ' + cast(@w_saldo as varchar) + ' Operacion '
              + cast(@w_banco as varchar) + ' Cuenta ' + cast(@w_cta_banco as
              varchar)
              +
                                                 ' Saldo Aho '
              + cast(@w_saldo_cta as varchar) + ' Titularidad ' + cast(
              @w_titularidad
                                                 as varchar)

      ---INICION LA BUSQUEDA PARA EL ROD DEUDOR
      if @w_rol = 'D'
      begin
        if @w_titularidad = 'M' --Titularidad Conjunta
        begin
          if exists (select
                       1
                     from   sysobjects
                     where  name = 'cl_conjunta')
            drop table cl_conjunta

          select
            ac_ente = uc_cliente
          into   cl_conjunta
          from   cob_cartera..ca_universo_cartera
          where  uc_operacion = @w_banco
             and uc_cliente   <> @w_cliente

          while 1 = 1
          begin
            select top 1
              @w_cliente_ec = ac_ente
            from   cl_conjunta

            if @@rowcount = 0
              goto SIG_CTA

            select
              @w_conjunta = count(1)
            from   cobis..cl_cliente,
                   cobis..cl_det_producto
            where  cl_det_producto = dp_det_producto
               and cl_cliente      = @w_cliente_ec
               and dp_cuenta       = @w_cta_banco

            if @w_conjunta = 1
              goto ENCONTRO

            delete from cl_conjunta
            where  ac_ente = @w_cliente_ec
            if @@error <> 0
            begin
              print
          'ERROR  eliminando cl_conjunta titularidad M  Deudor  CLiente: '
          + cast ( @w_cliente_ec as varchar)
              goto SIG_CTA
            end

          end
        end
      end

      ---INICIO BUSQUEDA PARA CODEUDOR   
      if @w_rol = 'C'
      begin
        if @w_titularidad = 'M' --Titularidad Conjunta
        begin
          if exists (select
                       1
                     from   sysobjects
                     where  name = 'cl_conjunta')
            drop table cl_conjunta

          select
            ac_ente = uc_cliente
          into   cl_conjunta
          from   cob_cartera..ca_universo_cartera
          where  uc_operacion = @w_banco
             and uc_cliente   <> @w_cliente

          while 1 = 1
          begin
            select top 1
              @w_cliente_ec = ac_ente
            from   cl_conjunta

            if @@rowcount = 0
              goto SIG_CTA

            select
              @w_conjunta = count(1)
            from   cobis..cl_cliente,
                   cobis..cl_det_producto
            where  cl_det_producto = dp_det_producto
               and cl_cliente      = @w_cliente_ec
               and dp_cuenta       = @w_cta_banco

            if @w_conjunta = 1
              goto ENCONTRO

            delete from cl_conjunta
            where  ac_ente = @w_cliente_ec
            if @@error <> 0
            begin
              print
          'ERROR  eliminando cl_conjunta titularidad M  Codeudor  CLiente: '
          + cast ( @w_cliente_ec as varchar)
              goto SIG_CTA
            end

          end
        end
      end

      ENCONTRO:

      if @w_saldo_cta > @w_saldo
        select
          @w_valor_aplicar = @w_saldo
      else
        select
          @w_valor_aplicar = @w_saldo_cta

      exec @w_return = cob_ahorros..sp_calcula_gmf
        @s_date            = @w_fecha,
        @s_ofi             = @w_ah_moneda,
        @i_mon             = @w_ah_moneda,
        @i_cta             = @w_cta_banco,
        @i_cuenta          = @w_cuenta,
        @i_val             = @w_valor_aplicar,
        @i_val_tran        = @w_valor_aplicar,
        @i_numdeciimp      = @w_numdeci,
        @i_producto        = @w_producto,
        @i_operacion       = 'Q',
        @o_total_gmf       = @w_val_nx1000 out,
        @o_acumu_deb       = @w_acumu_deb out,
        @o_actualiza       = @w_actualiza out,
        @o_base_gmf        = @w_base_gmf out,
        @o_concepto        = @w_concep_exc out,
        @o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
        @o_valor_reintegro = @w_gmf_reintegro out -- JCO 

      if @w_return <> 0
      begin
        print 'ERROR  ejecutando cob_ahorros..sp_calcula_gmf para  : '
              + cast (@w_cta_banco as varchar)
        goto SIG_CTA
      end

      if @w_saldo_cta < @w_saldo
        select
          @w_valor_aplicar = @w_valor_aplicar - @w_val_nx1000

      update cob_cartera..ca_universo_cartera
      set    uc_valor_aplicado = isnull(uc_valor_aplicado, 0) + @w_valor_aplicar
             ,
             uc_saldo_mora = uc_saldo_mora - @w_valor_aplicar,
             uc_estado = 'P'
      where  uc_operacion = @w_banco

      if @@error <> 0
      begin
        print 'ERROR  actualizando cob_cartera..ca_universo_cartera  : '
              + cast (@w_cta_banco as varchar)
        goto SIG_CTA
      end

      update cob_ahorros..ah_saldoscompensa_actpas
      set    sc_saldo = isnull(sc_saldo,
                               0) - (floor(@w_valor_aplicar) + floor(
                                     @w_val_nx1000
                                     ))
      where  sc_cuenta = @w_cuenta

      if @@error <> 0
      begin
        print 'ERROR actualizando ah_saldoscompensa_actpas  saldo de cuenta  : '
              + cast (@w_cuenta as varchar)
        goto SIG_CTA
      end

      select
        @w_tipo_doc = en_tipo_ced,
        @w_identificacion = en_ced_ruc,
        @w_nombre_cliente = isnull(en_nomlar,
                                   en_nombre + ' ' + p_p_apellido + ' ' +
                            p_s_apellido
                            )
      from   cobis..cl_ente
      where  en_ente = @w_cliente

      select
        @w_ofi_desc = of_nombre
      from   cobis..cl_oficina
      where  of_oficina = @w_ah_oficina

      select
        @w_secuencial = @w_secuencial + 1

      update #univ_operacion
      set    uo_saldo_mora = (uo_saldo_mora - floor(@w_valor_aplicar))
      where  uo_banco = @w_banco

      if @w_debug = 'S'
        print 'Cliente: ' + cast(@w_cliente as varchar) + ' Titularidad '
              + cast(@w_titularidad as varchar) + ' Cuenta: ' + cast(
              @w_cta_banco
              as
                                                             varchar)
              + ' Saldo: ' + cast(@w_saldo_cta as varchar) + ' Valor Aplicado: '
              + cast(@w_valor_aplicar as varchar) + ' GMF: ' + cast(
              @w_val_nx1000
              as
                                                             varchar)
              + ' OperaciÂ¾n: ' + cast(@w_banco as varchar) + ' Cartera: '
              + cast(@w_num_banco as varchar) + ' Saldo Cartera: '
              + cast((@w_saldo - floor(@w_valor_aplicar)) as varchar)

      insert into cob_ahorros..ah_compensacion_actpas
                  (co_operacion,co_saldo,co_rol,co_num_producto,co_oficina,
                   co_valor_aplicado,co_tipo_doc,co_identificacion,co_nombre,
                   co_secuencial,
                   co_tipo_prod,co_tipo_obligacion,co_desc_oficina,co_estado_nd,
                   co_estado_pago,
                   co_cuenta,co_cliente,co_estado_registro)
        select
          @w_banco,(@w_saldo - floor(@w_valor_aplicar)),@w_rol,@w_cta_banco,
          @w_ah_oficina,
          floor(@w_valor_aplicar),@w_tipo_doc,@w_identificacion,
          @w_nombre_cliente,
          @w_secuencial,
          @w_prod_banc,@w_tipo_op,@w_ofi_desc,'N','N',
          @w_num_banco,@w_cliente,'I'

      if @@error <> 0
      begin
        print
  'ERROR Insertando  registro  en cob_ahorros..ah_compensacion_actpas  para : '
  + cast (@w_cta_banco as varchar)
    goto SIG_CTA
  end

  SIG_CTA:
  delete from saldo_compensa
  where  sc_cliente     = @w_cliente
     and sc_cuenta      = @w_cuenta
     and sc_saldo       = @w_saldo_cta
     and sc_titularidad = @w_titularidad

  if @@error <> 0
  begin
    print 'ERROR Eliminando registro de saldo_compensa Cuenta: '
          + cast (@w_cuenta as varchar)
    goto SIG_CTA
  end

  end

    SIG_OPERACION:

    delete from #univ_operacion
    where  uo_cliente = @w_cliente
       and uo_rol     = @w_rol
       and uo_banco   = @w_banco
    if @@error <> 0
    begin
      print 'ERROR  Borrando #univ_operacion en SIGUIENTE: ' + cast (@w_banco as
            varchar)
      goto ERRORFIN
    end

  end

  return 0

  ERRORFIN:
begin
  print @w_msg
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg
  return 1
end

go

