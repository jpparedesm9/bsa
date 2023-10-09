use cob_ahorros
go

/************************************************************************/
/*  Archivo:            trans_ah_of.sp                                  */
/*  Stored procedure:   sp_trans_ah_of                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       N/N                                             */
/*  Fecha de escritura: N/D                                             */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                               PROPOSITO                              */
/*  Transferencias de ahorros realizadas desde gestor de Oficiana/Caja  */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA           AUTOR           RAZON                              */
/*  02/Mayo/2016    Walther Toledo  Migración a CEN                     */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_trans_ah_of')
  drop proc sp_trans_ah_of
go

create proc sp_trans_ah_of
(
  @t_show_version bit = 0,
  @i_param1       datetime,-- Fecha Inicio
  @i_param2       datetime -- Fecha Fin

)
as
  declare
    @w_sp_name           varchar(30),
    @i_fecha_ini         datetime,-- Fecha Inicio
    @i_fecha_fin         datetime,-- Fecha Fin
    @w_fecha_gen_reporte datetime

  select
    @w_sp_name = 'sp_ahapmasiva_ej'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @i_fecha_ini = @i_param1,
    @i_fecha_fin = @i_param2

  select
    @w_fecha_gen_reporte = fp_fecha
  from   cobis..ba_fecha_proceso

  begin try
    select
      trn=eq_val_cfijo,
      causal=eq_val_num_ini
    into   #causales_internas
    from   cob_remesas..re_equivalencias -- codigo de la transaccion
    where  eq_tabla  = 'REPOFIR549'
           -- catalogo para reporte de tx desde oficina rq549
           and eq_modulo = 4 -- producto ahorros
           and eq_val_num_ini like 'CAUSAL%'

    -- TRANSACCIONES DE AHORROS REALIZADAS DESDE EL GESTOR DE LA OFICINA
    select
      FechaTrn = hs_tsfecha,
      Oficina = hs_oficina,
      Cliente = hs_cliente,
      Cuenta = hs_cta_banco,
      Trn = hs_tipo_transaccion,
      Causa = isnull(hs_causa,
                     0),
      Canal = 'GESTOR',
      Valor = convert(money, 0)
    into   #ah_trn_base
    from   cob_ahorros_his..ah_his_servicio with (nolock)
    where  hs_tsfecha between @i_fecha_ini and @i_fecha_fin
       and isnull(hs_rol_ente,
                  'S') <> 'N'
       -- rol_ente = N (tx no realizada en presencia del cliente)
       and hs_tipo_transaccion in
           (select distinct
              eq_val_cfijo
            from   cob_remesas..re_equivalencias -- codigo de la transaccion
            where  eq_tabla       = 'REPOFIR549'
                   -- catalogo para reporte de tx desde oficina rq549
                   and eq_modulo      = 4 -- producto ahorros
                   and eq_val_num_fin = 'GESTOR')

    -- TRANSACCIONES DE AHORROS REALIZADAS DESDE CAJA EN LA OFICINA,
    -- SE BUSCA EN LA TABLA ah_his_servicio PARA ENCONTRAR LAS TX DE CONSULTA DE SALDO AH TX 230
    insert into #ah_trn_base
      select
        FechaTrn = hs_tsfecha,Oficina = hs_oficina,Cliente = hs_cliente,Cuenta =
        hs_cta_banco,Trn = hs_tipo_transaccion,
        Causa = isnull(hs_causa,
                       0),Canal = 'CAJA',Valor = convert(money, 0)
      from   cob_ahorros_his..ah_his_servicio with (nolock)
      where  hs_tsfecha between @i_fecha_ini and @i_fecha_fin
         and isnull(hs_rol_ente,
                    'S') <> 'N'
         -- rol_ente = N (tx no realizada en presencia del cliente)
         and hs_tipo_transaccion in
             (select distinct
                eq_val_cfijo
              from   cob_remesas..re_equivalencias -- codigo de la transaccion
              where  eq_tabla       = 'REPOFIR549'
                     -- catalogo para reporte de tx desde oficina rq549
                     and eq_modulo      = 4 -- producto ahorros
                     and eq_val_num_fin = 'CAJA')
    update #ah_trn_base
    set    Cliente = ah_cliente
    from   #ah_trn_base,
           cob_ahorros..ah_cuenta
    where  Cuenta = ah_cta_banco

    -- TRANSACCIONES DE AHORROS REALIZADAS DESDE CAJA
    select
      eq_val_cfijo
    into   #temporal
    from   cob_remesas..re_equivalencias
    where  eq_tabla       = 'REPOFIR549'
       and eq_modulo      = 4
       and eq_val_num_fin = 'CAJA'

    insert into #ah_trn_base
      select
        FechaTrn = hm_fecha,Oficina = hm_oficina,Cliente = hm_cliente,Cuenta =
        hm_cta_banco,Trn = hm_tipo_tran,
        Causa = isnull(hm_causa,
                       0),Canal = 'CAJA',Valor = case hm_tipo_tran
                  when 252 then isnull(hm_valor, 0) + isnull(hm_chq_locales, 0)
                                +
                                isnull
                                (
                                hm_chq_propios, 0)
                  else isnull(hm_valor,
                              0)
                end
      from   cob_ahorros_his..ah_his_movimiento
      where  hm_fecha between @i_fecha_ini and @i_fecha_fin
         and hm_estado is null
         and hm_tipo_tran in
             (select
                eq_val_cfijo
              from   #temporal)
         and hm_canal = 4

    -- ELIMINA CAUSALES PARA TRANSACCIONES DE APERTURA
    update #ah_trn_base
    set    Causa = 0
    where  Trn in
           (select distinct
              eq_val_cfijo
            from   cob_remesas..re_equivalencias -- codigo de la transaccion
            where  eq_tabla       = 'REPOFIR549'
                   -- catalogo para reporte de tx desde oficina rq549
                   and eq_val_num_ini = 'APERTURA')

    -- ELIMINA CAUSALES INTERNAS NOTA CREDITO
    delete #ah_trn_base
    from   #causales_internas
    where  causal = 'CAUSALNC'
       and Trn    = trn
       and convert (int, isnull(Causa,
                                '999')) not in (select
                                                  convert(int, c.codigo)
                                                from   cobis..cl_tabla t,
                                                       cobis..cl_catalogo c
                                                where  t.codigo = c.tabla
                                                   and
           t.tabla  = 'ah_causa_nc_caja')
    -- ELIMINA CAUSALES INTERNAS NOTA DEBITO
    delete #ah_trn_base
    from   #causales_internas
    where  causal = 'CAUSALND'
       and Trn    = trn
       and convert (int, isnull(Causa,
                                '999')) not in (select
                                                  convert(int, c.codigo)
                                                from   cobis..cl_tabla t,
                                                       cobis..cl_catalogo c
                                                where  t.codigo = c.tabla
                                                   and
           t.tabla  = 'ah_causa_nd_caja')
    -- TRANSACCIONES DE OTROS PRODUCTOS
    select
      eq_val_cfijo,
      isnull(eq_val_interfaz,
             0) eq_val_interfaz,
      isnull(eq_val_num_fin,
             0) eq_val_num_fin
    into   #tmp_otros
    from   cob_remesas..re_equivalencias
    where  eq_tabla  = 'REPOFIR549'
       and eq_modulo = 3 -- OTROS PRODUCTOS

    insert into #ah_trn_base
      select
        FechaTrn = hs_tsfecha,Oficina = hs_oficina,Cliente = hs_cliente,Cuenta =
        hs_cta_banco,Trn = hs_tipo_transaccion,
        Causa = isnull(hs_causa,
                       0),Canal = 'CAJA',Valor = isnull(hs_contratado,
                       0)
      from   cob_cuentas_his..cc_his_servicio with (nolock)
      where  hs_tsfecha between @i_fecha_ini and @i_fecha_fin
             --and    hs_estado           is null
             and hs_tipo_transaccion in
                 (select
                    eq_val_cfijo
                  from   #tmp_otros)

    -- TRANSACCIONES DE CORRESPONSALES BANCARIOS
    insert into #ah_trn_base
      select
        FechaTrn = tsh_fecha,Oficina = tsh_oficina,Cliente = isnull(tsh_campo2,
                         tsh_campo4),Cuenta = tsh_campo3,Trn = tsh_tipo_tran,
        Causa = 0,Canal = 'CAJA',Valor = isnull(tsh_valor4,
                       tsh_monto)
      from   cobis..ws_tran_servicio_his with (nolock)
      where  tsh_fecha between @i_fecha_ini and @i_fecha_fin
         and tsh_estado is null
         and tsh_sec_corr is null
         and tsh_tipo_tran in
             (select
                eq_val_cfijo
              from   #tmp_otros)

    -- INSERTA EN LA TABLA DEFINITIVA
    insert into cobis..cl_transacciones_of
      select
        convert(varchar(10), @w_fecha_gen_reporte, 101),Oficina,null,null,null,
        null,null,(select
           c.valor
         from   cobis..cl_catalogo c
         where  c.tabla  = (select
                              t.codigo
                            from   cobis..cl_tabla t
                            where  t.tabla = 'cr_meses')
            and c.codigo = datepart(mm,
                                    t.FechaTrn)),right(
        '00' + convert(varchar(2), datepart(dd, FechaTrn)),
              2),-- DIA DEL REPORTE
        Canal,
        Trn,Causa,isnull(sum(Valor),
               0),count(Trn),count(distinct Cliente),
        FechaTrn
      from   #ah_trn_base t
      group  by FechaTrn,
                Oficina,
                Canal,
                Trn,
                Causa

    -- ACTUALIZA LA DESCRIPCION DE LA TRANSACCION CUANDO SE TIENE IDENTIFICADA LA CAUSAL EN EL CATALOGO
    update cobis..cl_transacciones_of
    set    to_tipo_transaccion = eq_descripcion
    from   cob_remesas..re_equivalencias
    where  to_tipo_transaccion         = eq_val_cfijo
       and cast(to_causal_trn as int) = isnull(eq_val_interfaz,
                                               0)
       and eq_tabla                    = 'REPOFIR549'
       -- catalogo para reporte de tx desde oficina rq549
       and eq_modulo in (3, 4) -- producto otros (3) ahorros (4)

    -- ACTUALIZA LA DESCRIPCION DE LA TRANSACCION CUANDO NO SE TIENE IDENTIFICADA LA CAUSAL EN EL CATALOGO,
    -- DEJANDO UNA DESCRIPCION GENERICA PARA ESTOS CASOS
    update cobis..cl_transacciones_of
    set    to_tipo_transaccion = eq_descripcion
    from   cob_remesas..re_equivalencias
    where  to_tipo_transaccion = eq_val_cfijo
       and eq_val_interfaz is null
       and eq_tabla            = 'REPOFIR549'
       -- catalogo para reporte de tx desde oficina rq549
       and eq_modulo in (3, 4) -- producto otros (3) ahorros (4)

    -- OBTIENE DATOS DE LA OFICINA
    update cobis..cl_transacciones_of
    set    to_nombre_oficina = of_nombre,
           to_cod_zona = of_zona,
           to_cod_regional = of_regional
    from   cobis..cl_oficina
    where  to_nombre_oficina is null
       and to_cod_oficina = of_oficina

    -- OBTIENE NOMBRE DE LA ZONA
    update cobis..cl_transacciones_of
    set    to_nombre_zona = of_nombre
    from   cobis..cl_oficina
    where  to_nombre_zona is null
       and to_cod_zona = of_oficina

    -- OBTIENE NOMBRE DE LA REGIONAL
    update cobis..cl_transacciones_of
    set    to_nombre_regional = of_nombre
    from   cobis..cl_oficina
    where  to_nombre_regional is null
       and to_cod_regional = of_oficina

  end try
  begin catch
    select
      error_number()  as ErrorNumber,
      error_message() as ErrorMessage
    return 1
  end catch

  return 0

go

