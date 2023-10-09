/************************************************************************/
/*  Archivo:            reverso_contabilizacion.sp                      */
/*  Stored procedure:   sp_reverso_contabilizacion                      */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes y de Ahorros                 */
/*  Disenado por:       Mauricio Bayas/Julio Navarrete/Xavier Bucheli   */
/*  Fecha de escritura: 12-Ene-1993                                     */
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
/*              PROPOSITO                                               */
/************************************************************************/
/*  Este programa se encarga de la generacion de los comprobantes       */
/*  contables y sus respectivos asientos, como fruto del                */
/*  reverso de la contabilizacion automatica                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA            AUTOR             RAZON                            */
/*  26/May/2000      Juan F. Cadena    Emision Inicial                  */
/*  02/Mayo/2016     Juan Tagle        Migración a CEN                  */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reverso_contabilizacion')
        drop proc sp_reverso_contabilizacion
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reverso_contabilizacion (
    @t_show_version bit = 0,
    @i_filial       tinyint,
    @i_fecha        datetime,
    @o_procesadas   int out
)
as
declare @w_return           int,
    @w_sp_name              varchar(30),
    @w_moneda               tinyint,
    @w_moneda_ant           smallint,
    @w_ofi_orig             smallint,
    @w_ofi_orig_ant         smallint,
    @w_ofi_orig_conta       int,
    @w_ofi_dest             smallint,
    @w_ofi_dest_ant         smallint,
    @w_ofi_dest_conta       int,
    @w_perfil               varchar(10),
    @w_perfil_ant           varchar(10),
    @w_descripcion          varchar(64),
    @w_desc_comprobante     varchar(64),
    @w_descerror            varchar(60),
    @w_valor                money,
    @w_valor_me             money,
    @w_valor_cre_me         money,
    @w_valor_deb_me         money,
    @w_cuenta_c             varchar(20),
    @w_cuenta_cre           varchar(20),
    @w_cuenta_d             varchar(20),
    @w_cuenta_deb           varchar(20),
    @w_auxiliar             varchar(20),
    @w_trama                varchar(20),
    @w_valor_trama          varchar(20),
    @w_origen_dest_c        char(1),
    @w_origen_dest_d        char(1),
    @w_constante_c          varchar(3),
    @w_constante_d          varchar(3),
    @w_area_d               int,
    @w_area_c               int,
    @w_cotizacion_c         money,
    @w_cotizacion_d         money,
    @w_area_origen          int,
    @w_area_destino         int,
    @w_error                tinyint,
    @w_error_comprobante    tinyint,
    @w_comprobante          int,
    @w_fin                  tinyint,
    @w_posicion             tinyint,
    @w_resultado            varchar(15),
    @w_ofi_deb              int,
    @w_ofi_cre              int,
    @w_ofi_orig_cobis       varchar(3),
    @w_contador             smallint,
    @w_gen_comprobante      tinyint,
    @w_valor_comprobante    money,
    @w_valor_me_comprobante money,
    @w_detalles             int,
    @w_fecha                datetime,
    @w_fecha_ant            datetime

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_reverso_contabilizacion'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

-- Inicializacion de variables
select @o_procesadas        = 0,
       @w_perfil_ant        = '',
       @w_ofi_orig_ant      = -1,
       @w_ofi_dest_ant      = -1,
       @w_moneda_ant        = -1,
       @w_error             = 0,
       @w_error_comprobante = 0,
       @w_contador          = 1,
       @w_gen_comprobante   = 0,
       @w_fecha_ant         = '01/01/1900'

-- Creacion de la tabla temporal con los totales
CREATE TABLE tempdb..totalcontar_ah (
    fecha          datetime,
    ofi_orig       smallint,
    ofi_dest       smallint,
    moneda         tinyint,
    perfil         varchar(10),
    descripcion    varchar(64),
    cuenta_deb     varchar(20),
    cuenta_cre     varchar(20),
    od_deb         char(1),
    od_cre         char(1),
    constante_deb  varchar(3),
    constante_cre  varchar(3),
    area_deb       int,
    area_cre       int,
    valor          money,
    valor_me       money
)

-- Insercion de los totales a contabilizar
insert into tempdb..totalcontar_ah
select to_hora, to_ofic_orig, to_ofic_dest,
       to_moneda, to_perfil,
       isnull(pe_descripcion, '*****'),
       isnull(a.dp_cuenta,''), isnull(b.dp_cuenta,''),
       isnull(a.dp_origen_dest,''), isnull(b.dp_origen_dest,''),
       isnull(a.dp_constante,'N'), isnull(b.dp_constante,'N'),
       isnull(a.dp_area,0), isnull(b.dp_area,0),
       sum(to_valor), sum(to_valor_me)
  from cob_remesas_his..re_his_total,
       cob_conta..cb_perfil,
       cob_conta..cb_det_perfil a,
       cob_conta..cb_det_perfil b
 where to_hora      = @i_fecha
   and to_producto  = 4 -- CUENTAS DE AHORROS
   and to_estado    = 'V'
   and pe_empresa   = @i_filial
   and pe_producto  = 4 -- CUENTAS DE AHORROS
   and to_perfil    = pe_perfil
   and a.dp_empresa = @i_filial
   and a.dp_producto= 4 -- CUENTAS DE AHORROS
   and to_perfil    = a.dp_perfil
   and a.dp_debcred = '1'
   and b.dp_empresa = @i_filial
   and b.dp_producto= 4 -- CUENTAS DE AHORROS
   and to_perfil    = b.dp_perfil
   and b.dp_debcred = '2'
 group by to_hora, to_ofic_orig, to_ofic_dest,
          to_moneda, to_perfil,
          isnull(pe_descripcion, '*****'),
          a.dp_cuenta, b.dp_cuenta,
          a.dp_origen_dest, b.dp_origen_dest,
          isnull(a.dp_constante,'N'), isnull(b.dp_constante,'N'),
          a.dp_area, b.dp_area

declare totales cursor
for select
      fecha,
      moneda,
      ofi_orig,
      ofi_dest,
      perfil,
      descripcion,
      valor,
      valor_me,
      cuenta_deb,
      cuenta_cre,
      od_deb,
      od_cre,
      constante_deb,
      constante_cre,
      area_deb,
      area_cre
 from tempdb..totalcontar_ah
order by fecha, ofi_orig, ofi_dest, moneda, perfil
  for read only

open totales
fetch totales into
    @w_fecha,
    @w_moneda,
    @w_ofi_orig,
    @w_ofi_dest,
    @w_perfil,
    @w_descripcion,
    @w_valor,
    @w_valor_me,
    @w_cuenta_d,
    @w_cuenta_c,
    @w_origen_dest_d,
    @w_origen_dest_c,
    @w_constante_d,
    @w_constante_c,
    @w_area_d,
    @w_area_c

if @@fetch_status = -1
begin
     close totales
     deallocate totales
     drop table tempdb..totalcontar_ah
     exec cobis..sp_cerror
         @i_num       = 201157
     return 201157
end

while @@fetch_status = 0
begin
  if @w_fecha_ant <> @w_fecha
  begin
    select @w_fecha_ant = @w_fecha,
       @w_gen_comprobante = 1,
       @w_error_comprobante = 0
  end

  if @w_moneda_ant <> @w_moneda
  begin
    select @w_moneda_ant = @w_moneda,
       @w_gen_comprobante = 1,
       @w_error_comprobante = 0
  end

  if @w_ofi_orig_ant <> @w_ofi_orig
  begin
    select @w_ofi_orig_ant = @w_ofi_orig,
       @w_gen_comprobante = 1
    select @w_ofi_orig_conta = re_ofconta
      from cob_conta..cb_relofi
     where re_filial    = @i_filial
       and re_empresa   = @i_filial
       and re_ofadmin   = @w_ofi_orig
    if @@rowcount <> 1
    begin
      insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
    values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
        @w_valor, @w_valor_me, 'RELACION SUCURSAL ADMIN - CONTA')
      if @@error <> 0
    goto ERRCURSOR

      select @w_error_comprobante = 1
      goto LEER
    end
    select @w_error_comprobante = 0
  end

  if @w_ofi_dest_ant <> @w_ofi_dest
  begin
    select @w_ofi_dest_ant = @w_ofi_dest,
       @w_gen_comprobante = 1
    select @w_ofi_dest_conta = re_ofconta
      from cob_conta..cb_relofi
     where re_filial    = @i_filial
       and re_empresa   = @i_filial
       and re_ofadmin   = @w_ofi_dest
    if @@rowcount <> 1
    begin
      insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
    values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
        @w_valor, @w_valor_me, 'RELACION SUCURSAL ADMIN - CONTA')
      if @@error <> 0
    goto ERRCURSOR

      select @w_error_comprobante = 1
      goto LEER
    end
    select @w_error_comprobante = 0
  end

  if @w_error_comprobante = 1
    goto LEER

  if @w_descripcion = '*****'
  begin
    insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
      values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
              @w_valor, @w_valor_me, 'NO EXISTE EL PERFIL')
    if @@error <> 0
    goto ERRCURSOR

    select @w_error_comprobante = 1
    goto LEER
  end

  -- Detalle del perfil a ser usado
  if @w_perfil <> @w_perfil_ant
  begin
    select @w_perfil_ant = @w_perfil
    if @w_cuenta_d is null
    select @w_error = 1
    if @w_cuenta_c is null
    select @w_error = 2

    if @w_error = 0
    begin
      if @w_origen_dest_d = 'O'
        select @w_area_origen   = @w_area_d,
         @w_area_destino    = @w_area_c
      else
        select @w_area_origen   = @w_area_c,
         @w_area_destino    = @w_area_d

      -- Analisis de moneda extranjera
      select @w_cotizacion_d = null,
       @w_cotizacion_c = null,
       @w_valor_deb_me = @w_valor_me,
           @w_valor_cre_me = @w_valor_me
      if @w_moneda <> 0
      begin
        if @w_constante_d = 'B'
          select @w_valor_deb_me = 0
        else
        begin
          select @w_cotizacion_d =
      isnull((select X.ct_compra where @w_constante_d = 'C'),
           isnull((select X.ct_venta where @w_constante_d = 'V'),
           X.ct_valor))
        from cob_conta..cb_cotizacion X
       where /*ct_empresa   = @i_filial
         and */ ct_moneda   = @w_moneda
         and ct_fecha   = @w_fecha
        end
        if @w_constante_c = 'B'
          select @w_valor_cre_me = 0
        else
        begin
          select @w_cotizacion_c =
      isnull((select X.ct_compra where @w_constante_c = 'C'),
           isnull((select X.ct_venta where @w_constante_c = 'V'),
           X.ct_valor))
        from cob_conta..cb_cotizacion X
       where /*ct_empresa   = @i_filial
         and*/ ct_moneda    = @w_moneda
         and ct_fecha   = @w_fecha
        end
      end
    end

    select @w_error = 0
  end
  else
  begin
    if @w_error <> 0
    begin
      if @w_error = 1
    select @w_descerror = 'CUENTA DEBITO MAL DEFINIDA'
      else
    select @w_descerror = 'CUENTA CREDITO MAL DEFINIDA'

      insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
        values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
            @w_valor, @w_valor_me, @w_descerror)
      if @@error <> 0
    goto ERRCURSOR

      select @w_error_comprobante = 1
      goto LEER
    end
  end

  -- Analisis de las cuentas dinamicas
  select @w_fin     = 0,
     @w_auxiliar    = @w_cuenta_d
  select @w_cuenta_deb  = null
  while @w_fin = 0
  begin
    select @w_posicion = charindex('.', @w_auxiliar)
    if @w_posicion = 0
    begin
      select @w_fin = 1,
         @w_trama   = @w_auxiliar
    end
    else
    begin
      select @w_trama   = substring(@w_auxiliar, 1, @w_posicion - 1)
      select @w_auxiliar= stuff(@w_auxiliar, 1, @w_posicion, null)
    end
    -- Armar la cuenta
    select @w_valor_trama = '',
       @w_resultado   = ''
    if (@w_trama = 'CMOF') or (@w_trama = 'OPOF')
    begin
      if @w_origen_dest_d = 'O'
        select @w_valor_trama = convert(varchar(20), @w_ofi_orig)
      else
        select @w_valor_trama = convert(varchar(20), @w_ofi_dest)
    end
    if (@w_trama = 'EFEC') or (@w_trama = 'TMON') or (@w_trama = 'NMO') or
       (@w_trama = 'EFTR')
      select @w_valor_trama = convert(varchar(20), @w_moneda)
    if @w_valor_trama <> ''
    begin
      select @w_resultado   = re_substring
        from cob_conta..cb_relparam
       where re_empresa     = @i_filial
         and re_parametro   = @w_trama
         and re_clave       = @w_valor_trama
      if @@rowcount <> 1
      begin
        insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
          values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
              @w_valor, @w_valor_me, 'ERROR EN PARAMETRO ' + @w_trama)
    if @@error <> 0
      goto ERRCURSOR

        select @w_error_comprobante = 1
        goto LEER
      end
    end
    else
      select @w_resultado = @w_trama
    select @w_cuenta_deb = @w_cuenta_deb + @w_resultado
  end

  select @w_fin     = 0,
     @w_auxiliar    = @w_cuenta_c
  select @w_cuenta_cre  = null
  while @w_fin = 0
  begin
    select @w_posicion = charindex('.', @w_auxiliar)
    if @w_posicion = 0
    begin
      select @w_fin = 1,
         @w_trama   = @w_auxiliar
    end
    else
    begin
      select @w_trama   = substring(@w_auxiliar, 1, @w_posicion - 1)
      select @w_auxiliar= stuff(@w_auxiliar, 1, @w_posicion, null)
    end
    -- Armar la cuenta
    select @w_valor_trama = '',
       @w_resultado   = ''
    if (@w_trama = 'CMOF') or (@w_trama = 'OPOF')
    begin
      if @w_origen_dest_d = 'O'
        select @w_valor_trama = convert(varchar(20), @w_ofi_orig)
      else
        select @w_valor_trama = convert(varchar(20), @w_ofi_dest)
    end
    if (@w_trama = 'EFEC') or (@w_trama = 'TMON') or (@w_trama = 'NMO') or
       (@w_trama = 'EFTR')
      select @w_valor_trama = convert(varchar(20), @w_moneda)
    if @w_valor_trama <> ''
    begin
      select @w_resultado   = re_substring
        from cob_conta..cb_relparam
       where re_empresa     = @i_filial
         and re_parametro   = @w_trama
         and re_clave       = @w_valor_trama
      if @@rowcount <> 1
      begin
        insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
          values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
              @w_valor, @w_valor_me, 'ERROR EN PARAMETRO ' + @w_trama)
    if @@error <> 0
      goto ERRCURSOR

        select @w_error_comprobante = 1
        goto LEER
      end
    end
    else
      select @w_resultado = @w_trama
    select @w_cuenta_cre = @w_cuenta_cre + @w_resultado
  end

  -- Analisis de oficinas contables
  select @w_ofi_deb = pc_oficina_conta
    from cob_remesas..re_perfil_centralizado
   where pc_empresa = @i_filial
     and pc_producto    = 4 -- Cuentas de ahorros
     and pc_perfil  = @w_perfil
     and pc_debcred = '1' -- cuenta debito
  if @@rowcount <> 1
  begin
    if @w_origen_dest_d = 'O'
      select @w_ofi_deb = @w_ofi_orig_conta
    else
      select @w_ofi_deb = @w_ofi_dest_conta
  end
  select @w_ofi_cre = pc_oficina_conta
    from cob_remesas..re_perfil_centralizado
   where pc_empresa = @i_filial
     and pc_producto    = 4 -- Cuentas de ahorros
     and pc_perfil  = @w_perfil
     and pc_debcred = '2' -- cuenta credito
  if @@rowcount <> 1
  begin
    if @w_origen_dest_c = 'O'
      select @w_ofi_cre = @w_ofi_orig_conta
    else
      select @w_ofi_cre = @w_ofi_dest_conta
  end

  select @w_ofi_orig_cobis = right(convert(varchar(4),(@w_ofi_orig + 1000)),3)

  if @w_gen_comprobante = 1
  begin
    select @w_desc_comprobante = 'REVERSO: ORIGEN ' +
                convert(varchar(4), @w_ofi_orig) +
                ' - DESTINO ' +
                    convert(varchar(4), @w_ofi_dest) +
                ' - MONEDA ' +
                convert(varchar(4), @w_moneda)
    select @w_valor_comprobante = sum(valor),
       @w_valor_me_comprobante = sum(valor_me),
       @w_detalles = count(1) * 2
      from tempdb..totalcontar_ah
     where ofi_orig = @w_ofi_orig
       and ofi_dest = @w_ofi_dest
       and moneda   = @w_moneda

    -- Generacion del comprobante contable
    exec @w_return = cob_conta..sp_scomprobante
    @t_trn      = 6951,
    @i_operacion    = 'I',
    @i_empresa  = @i_filial,
    @i_producto = 4, -- CUENTAS DE AHORROS
    @i_fecha_tran   = @w_fecha,
    @i_oficina_orig = @w_ofi_orig_conta,
    @i_area_orig    = @w_area_origen,
    @i_digitador    = 'sa-repaut',
    @i_descripcion  = @w_desc_comprobante,
    @i_perfil   = '',
    @i_automatico   = 3123,
    @i_detalles = @w_detalles,
    @i_tot_debito   = @w_valor_comprobante,
    @i_tot_credito  = @w_valor_comprobante,
    @i_tot_debito_me= @w_valor_me_comprobante,
    @i_tot_credito_me= @w_valor_me_comprobante,
    @i_reversado    = 'N',
    @i_estado   = 'I',
    @o_comprobante  = @w_comprobante out

    if @w_return <> 0
    begin
      print 'Procesando 1.....'

      insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
        values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
          @w_valor, @w_valor_me, 'ERROR EN GENERACION DE COMPROBANTE')
      if @@error <> 0
    goto ERRCURSOR

      select @w_error_comprobante = 1
      goto LEER
    end
    select @w_gen_comprobante = 0,
       @w_contador = 1
  end

  -- Generacion del asiento de debito
  exec @w_return    = cob_conta..sp_sasiento
    @t_trn          = 6952,
    @i_empresa      = @i_filial,
    @i_producto     = 4, -- CUENTAS DE AHORROS
    @i_comprobante  = @w_comprobante,
    @i_fecha_tran   = @w_fecha,
    @i_asiento      = @w_contador,
    @i_cuenta       = @w_cuenta_deb,
    @i_oficina_dest = @w_ofi_deb,
    @i_area_dest    = @w_area_d,
    @i_credito      = @w_valor,
    @i_credito_me   = @w_valor_deb_me,
    @i_debcred      = '2', -- EN LUGAR DE DEBITO REALIZO CREDITO
    @i_concepto     = @w_descripcion,
    @i_tipo_doc     = @w_constante_d,
    @i_tipo_tran    = 'I',
    @i_moneda       = @w_moneda,
    @i_autorizado   = 'S',
    @i_param1       = @w_ofi_orig_cobis,
    @i_operacion    = 'I',
    @i_cotizacion   = @w_cotizacion_d

  if @w_return <> 0
  begin
    print 'Procesando 2.....'

    insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
      values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
          @w_valor, @w_valor_me, 'ERROR EN GENERACION DE ASIENTO DE DEBITO')
    if @@error <> 0
    goto ERRCURSOR

    select @w_error_comprobante = 1
    goto LEER
  end

  select @w_contador = @w_contador + 1

  -- Generacion del asiento de credito
  exec @w_return = cob_conta..sp_sasiento
    @t_trn          = 6952,
    @i_empresa      = @i_filial,
    @i_producto     = 4, -- CUENTAS DE AHORROS
    @i_comprobante  = @w_comprobante,
    @i_fecha_tran   = @w_fecha,
    @i_asiento      = @w_contador,
    @i_cuenta       = @w_cuenta_cre,
    @i_oficina_dest = @w_ofi_cre,
    @i_area_dest    = @w_area_c,
    @i_debito       = @w_valor,
    @i_debito_me    = @w_valor_cre_me,
    @i_debcred      = '1', -- EN LUGAR DE CREDITO REALIZO DEBITO
    @i_concepto     = @w_descripcion,
    @i_tipo_doc     = @w_constante_c,
    @i_tipo_tran    = 'I',
    @i_moneda       = @w_moneda,
    @i_autorizado   = 'S',
    @i_param1       = @w_ofi_orig_cobis,
    @i_operacion    = 'I',
    @i_cotizacion   = @w_cotizacion_c

  if @w_return <> 0
  begin
    print 'Procesando 3.....'

    insert into cob_ahorros..ah_error_conta
           (ec_fecha, ec_moneda, ec_ofi_orig, ec_ofi_dest, ec_perfil,
        ec_valor, ec_valor_me, ec_descripcion)
      values (@w_fecha, @w_moneda, @w_ofi_orig, @w_ofi_dest, @w_perfil,
         @w_valor, @w_valor_me, 'ERROR EN GENERACION DE ASIENTO DE CREDITO')
    if @@error <> 0
    goto ERRCURSOR

    select @w_error_comprobante = 1
    goto LEER
  end

  select @o_procesadas = @o_procesadas + 1,
     @w_contador = @w_contador + 1

LEER:
  fetch totales into
    @w_fecha,
    @w_moneda,
    @w_ofi_orig,
    @w_ofi_dest,
    @w_perfil,
    @w_descripcion,
    @w_valor,
    @w_valor_me,
    @w_cuenta_d,
    @w_cuenta_c,
    @w_origen_dest_d,
    @w_origen_dest_c,
    @w_constante_d,
    @w_constante_c,
    @w_area_d,
    @w_area_c

  if @@fetch_status = -1
  begin
    close totales
    deallocate totales
    drop table tempdb..totalcontar_ah
    exec cobis..sp_cerror
      @i_num       = 201157
    return 201157
  end
end

close totales
deallocate totales

drop table tempdb..totalcontar_ah

commit tran

return 0

ERRCURSOR:
exec cobis..sp_cerror
    @i_num = 203061

close totales
deallocate totales

drop table tempdb..totalcontar_ah

return 203061


go

