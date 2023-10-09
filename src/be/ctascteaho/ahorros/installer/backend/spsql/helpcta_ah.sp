/************************************************************************/
/*      Archivo:                helpcta_ah.sp                           */
/*      Stored procedure:       sp_helpcta_ah                           */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     24-Nov-1993                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de consulta de cuentas de  */
/*      ahorro (help)                                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      23/Jul/2003                     Emision inicial BDF             */
/*      04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_helpcta_ah')
  drop proc sp_helpcta_ah
go

/****** Object:  StoredProcedure [dbo].[sp_helpcta_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_helpcta_ah
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_nombre       descripcion,
  @i_nombre1      descripcion = '',
  @i_cta          cuenta = null,
  @i_mon          tinyint,
  @i_modo         tinyint,
  @i_cliente      int = null,
  @i_producto     tinyint = null,
  @i_cuenta       cuenta = null
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_est         char(1),
    @w_cuenta      int,
    @w_nombre      descripcion,
    @w_num_libreta int,
    @w_ced_ruc     numero,
    @w_cliente     int,
    @w_tabla       int,
    @w_fecha_proc  datetime,
    @w_prods_nav   varchar(10),
    @w_prod        tinyint,
    @w_cuantos     tinyint

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_helpcta_ah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_nombre = @i_nombre,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  select
    @w_fecha_proc = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @i_nombre = @i_nombre + '%'

  if @i_modo = 0
  begin
    set rowcount 20
    select
      'CUENTA' = ah_cta_banco,
      'NOMBRE' = ah_nombre
    from   cob_ahorros..ah_cuenta
    where  ah_nombre like @i_nombre
       and ah_moneda = @i_mon
       and ah_estado = 'A'
    order  by ah_nombre,
              ah_cta_banco

    if @@rowcount = 0
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001,
        @i_sev   = 0,
        @i_msg   = 'No existe cuenta de ahorros'
      return 251001
    end
  end

  if @i_modo = 1
  begin
    set rowcount 20

    select
      'CUENTA' = ah_cta_banco,
      'NOMBRE' = ah_nombre
    from   cob_ahorros..ah_cuenta
    where  ah_nombre like @i_nombre
       and (ah_nombre    > @i_nombre1
             or (ah_nombre    = @i_nombre1
                 and ah_cta_banco > @i_cta))
       and ah_moneda    = @i_mon
       and ah_estado    = 'A'
    order  by ah_nombre,
              ah_cta_banco

    if @@rowcount = 0
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001,
        @i_sev   = 0,
        @i_msg   = 'No existe cuenta de ahorros'
      return 251001
    end
  end
  if @i_modo = 2
  begin
    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'cl_rol'
    if @i_producto = 3
    begin
      set rowcount 20
      select distinct
        'CUENTA' = dp_cuenta,
        'PRODUCTO' = 'CTE',
        'DISPONIBLE' = cc_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_interfase..cc_tsctacte
      where  b.cl_det_producto = dp_det_producto
         and b.cl_cliente      = @i_cliente
         and cc_cta_banco      = dp_cuenta
         and cc_moneda         = @i_mon
         and cc_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
         and cc_cta_banco      > isnull(@i_cuenta,
                                        '')
      order  by dp_cuenta,
                cc_disponible
      set rowcount 0
    end

    if @i_producto = 4
    begin
      set rowcount 20
      select distinct
        'CUENTA' = dp_cuenta,
        'PRODUCTO' = 'AHO',
        'DISPONIBLE' = ah_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_ahorros..ah_cuenta
      where  b.cl_det_producto = dp_det_producto
         and b.cl_cliente      = @i_cliente
         and ah_cta_banco      = dp_cuenta
         and ah_moneda         = @i_mon
         and ah_estado         = 'A'
         and ah_cta_banco      > isnull(@i_cuenta,
                                        '')
      order  by dp_cuenta
      set rowcount 0
    end
  end
  if @i_modo = 3
  begin
    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'cl_rol'
    if @i_producto = 3
    begin
      set rowcount 20
      select distinct
        'CLIENTE' = cl_cliente,
        'PRODUCTO' = 'CTE',
        'DISPONIBLE' = cc_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_interfase..cc_tsctacte
      where  b.cl_det_producto = dp_det_producto
             --and b.cl_cliente        = @i_cliente
             and cc_cta_banco      = dp_cuenta
             and cc_moneda         = @i_mon
             and cc_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
             and cc_cta_banco      = @i_cuenta
      --order by dp_cuenta
      set rowcount 0
    end

    if @i_producto = 4
    begin
      set rowcount 20
      select distinct
        'CLIENTE' = cl_cliente,
        'PRODUCTO' = 'AHO',
        'DISPONIBLE' = ah_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_ahorros..ah_cuenta
      where  b.cl_det_producto = dp_det_producto
             --and b.cl_cliente        = @i_cliente
             and ah_cta_banco      = dp_cuenta
             and ah_moneda         = @i_mon
             and ah_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
             and ah_cta_banco      = @i_cuenta
      --order by dp_cuenta
      set rowcount 0
    end
  end

  if @i_modo = 4 --WORKFLOW VINCULACION DEL CLIENTE BMG0022
  begin
    select
      @w_prods_nav = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PBNA'

    create table #prd_nav1
    (
      prod tinyint
    )

    while @w_prods_nav is not null
    begin
      select
        @w_prod = convert(tinyint, substring(@w_prods_nav,
                                             1,
                                             isnull(nullif(
                                             charindex(',',
                                                       @w_prods_nav)
                                                    ,
                                                           0),
                                                    11) - 1))
      insert into #prd_nav1
      values      (@w_prod)
      select
        @w_prods_nav = substring(@w_prods_nav,
                                 nullif(charindex(',', @w_prods_nav), 0) + 1,
                                 10)
    end

    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'cl_rol'

    --CUENTAS CORRIENTES
    select distinct
      'CUENTA' = '3-' + dp_cuenta,
      'ROL' = case b.cl_rol
                when 'T' then 'S'
                else 'N'
              end,
      'TOTAL' = cc_disponible - cc_monto_blq - cc_monto_emb - cc_monto_consumos
                          - cc_monto_conformado + cc_12h + cc_24h + cc_remesas,
      'RETENIDO' = cc_12h + cc_24h + cc_remesas,
      'DISPONIBLE' = cc_disponible - cc_monto_blq - cc_monto_emb
                     - cc_monto_consumos
                     - cc_monto_conformado,
      'PIGNORADO' = cc_monto_blq,
      'LIM SBGIRO' = (select
                        sum(sb_monto_aut)
                      from   cob_interfase..cc_tssobregiro
                      where  sb_cuenta    = a.cc_ctacte
                         and sb_tipo      = 'C'
                         and sb_fecha_aut <= @w_fecha_proc
                         and sb_fecha_ven >= @w_fecha_proc),
      'NO AUTORIZADO'= case
                         when cc_disponible - (select
                                                 sum(sb_monto_aut)
                                               from
                              cob_interfase..cc_tssobregiro
                                               where  sb_cuenta    = a.cc_ctacte
                                                  and sb_tipo      = 'C'
                                                  and
                              sb_fecha_aut <= @w_fecha_proc
                                                  and
                              sb_fecha_ven >= @w_fecha_proc)
                              >
                              0 then
                         cc_disponible - (select
                                            sum(sb_monto_aut)
                                          from   cob_interfase..cc_tssobregiro
                                          where  sb_cuenta    = a.cc_ctacte
                                             and sb_tipo      = 'C'
                                             and sb_fecha_aut <= @w_fecha_proc
                                             and sb_fecha_ven >= @w_fecha_proc)
                         else 0
                       end,
      'VCTO.SOBREG.' = (select
                          convert(char(10), max(sb_fecha_aut), 101)
                        from   cob_interfase..cc_tssobregiro
                        where  sb_cuenta    = a.cc_ctacte
                           and sb_tipo      = 'C'
                           and sb_fecha_aut <= @w_fecha_proc
                           and sb_fecha_ven >= @w_fecha_proc)
    from   cobis..cl_cliente b,
           cobis..cl_det_producto,
           cob_interfase..cc_tsctacte a
    where  b.cl_det_producto = dp_det_producto
       and b.cl_cliente      = @i_cliente
       and cc_cta_banco      = dp_cuenta
       and cc_moneda         = @i_mon
       and cc_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
       and cc_cta_banco      > isnull(@i_cuenta,
                                      '')
       and cc_tipocta_super  <> '5' --SIN FINES DE LUCRO

    union
    --CUENTAS DE AHORROS
    select distinct
      'CUENTA' = '4-' + dp_cuenta,
      'ROL' = case b.cl_rol
                when 'T' then 'S'
                else 'N'
              end,
      'TOTAL' = ah_disponible - ah_monto_bloq - ah_monto_emb - ah_monto_consumos
                +
                ah_12h +
                          ah_24h + ah_remesas,
      'RETENIDO' = ah_12h + ah_24h + ah_remesas,
      'DISPONIBLE' = ah_disponible - ah_monto_bloq - ah_monto_emb
                     - ah_monto_consumos,
      'PIGNORADO' = ah_monto_bloq,
      'LIM SBGIRO' = null,
      'NO AUTORIZADO'= null,
      'VCTO.SOBREG.' = null
    from   cobis..cl_cliente b,
           cobis..cl_det_producto,
           cob_ahorros..ah_cuenta
    where  b.cl_det_producto = dp_det_producto
       and b.cl_cliente      = @i_cliente
       and ah_cta_banco      = dp_cuenta
       and ah_moneda         = @i_mon
       and ah_estado         = 'A' --SOLO ACTIVAS
       and ah_cta_banco      > isnull(@i_cuenta,
                                      '')
       --      and ah_prod_banc not in (select prod from #prd_nav1) --EXCLUIR NAVIDAD
       and ah_tipocta_super  <> '5' --SIN FINES DE LUCRO

    if @@rowcount = 0
    begin
      /* No existe cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101162
      return 101162
    end

    set rowcount 0

  end

  if @i_modo = 5 --CONSULTA CUENTAS WORKFLOW(MAPA DE OFICIOS BMG0026)

  begin
    select
      @w_prods_nav = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PBNA'

    create table #prd_nav2
    (
      prod tinyint
    )

    while @w_prods_nav is not null
    begin
      select
        @w_prod = convert(tinyint, substring(@w_prods_nav,
                                             1,
                                             isnull(nullif(
                                             charindex(',',
                                                       @w_prods_nav)
                                                    ,
                                                           0),
                                                    11) - 1))
      insert into #prd_nav2
      values      (@w_prod)
      select
        @w_prods_nav = substring(@w_prods_nav,
                                 nullif(charindex(',', @w_prods_nav), 0) + 1,
                                 10)
    end
    set rowcount 100
    select
      '4-' + rtrim(ltrim(ah_cta_banco))
    from   cobis..cl_cliente b,
           cobis..cl_det_producto,
           cob_ahorros..ah_cuenta
    where  b.cl_det_producto = dp_det_producto
       and b.cl_cliente      = @i_cliente
       and ah_cta_banco      = dp_cuenta
       and ah_moneda         = @i_mon
       and ah_estado         = 'A' --ACTIVAS
       and cl_rol in ('T', 'C') --EL TITULAR O COTITULAR
       --      and ah_prod_banc not in (select prod from #prd_nav2) --EXCLUIR NAVIDAD
       and ah_cta_banco      > isnull(@i_cuenta,
                                      '')
       and ah_tipocta_super  <> '5' --SIN FINES DE LUCRO
    order  by dp_cuenta

    if @@rowcount = 0
      select
        @w_cuantos = 0
    else
      select
        @w_cuantos = 1

    select
      '3-' + rtrim(ltrim(cc_cta_banco))
    from   cobis..cl_cliente b,
           cobis..cl_det_producto,
           cob_interfase..cc_tsctacte
    where  b.cl_det_producto = dp_det_producto
       and b.cl_cliente      = @i_cliente
       and cc_cta_banco      = dp_cuenta
       and cc_moneda         = @i_mon
       and cc_estado         = 'A' --ACTIVAS
       and cl_rol in ('T', 'C') --EL TITULAR O COTITULAR
       and cc_tipocta_super  <> '5' --SIN FINES DE LUCRO
    order  by dp_cuenta

    if @@rowcount = 0
       and @w_cuantos = 0
    begin
      /* No existe cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101162
      return 101162
    end

    set rowcount 0

  end

  if @i_modo = 6 --WORKFLOW(CUENTAS DISPONIBLES PARA OFICIOS BMG0024)
  begin
    select
      @w_prods_nav = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PBNA'

    create table #prd_nav3
    (
      prod tinyint
    )

    while @w_prods_nav is not null
    begin
      select
        @w_prod = convert(tinyint, substring(@w_prods_nav,
                                             1,
                                             isnull(nullif(
                                             charindex(',',
                                                       @w_prods_nav)
                                                    ,
                                                           0),
                                                    11) - 1))
      insert into #prd_nav3
      values      (@w_prod)
      select
        @w_prods_nav = substring(@w_prods_nav,
                                 nullif(charindex(',', @w_prods_nav), 0) + 1,
                                 10)
    end
    set rowcount 75
    --CUENTAS
    create table #cuentas
    (
      cuenta  cuenta null,
      tipo    varchar(30) null,
      oficial varchar(20) null,
      dispo   money null,
      bloq    char(1) null
    )

    --CUENTAS CORRIENTES
    insert #cuentas
      select
        '3-' + rtrim(ltrim(cc_cta_banco)),'CUENTA CORRIENTE',rtrim(
        ltrim(fu_nombre))
        ,
               cc_disponible - cc_monto_blq - cc_monto_emb - cc_monto_consumos
               - cc_monto_conformado,case isnull((select
                       cb_tipo_bloqueo
                     from   cob_interfase..cc_tsctabloqueada
                     where  cb_cuenta = a.cc_ctacte
                        and cb_estado = 'V'),
                    '1')
          when '1' then '0'
          else '1'
        end
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_interfase..cc_tsctacte a,
             cobis..cc_oficial,
             cobis..cl_funcionario
      where  b.cl_det_producto
             = dp_det_producto
         and b.cl_cliente
             = @i_cliente
         and cc_cta_banco
             = dp_cuenta
         and cc_moneda
             = @i_mon
         and cc_estado
             = 'A' --ACTIVAS
         and cl_rol in ('T', 'C') --EL TITULAR O COTITULAR
         and oc_funcionario
             = fu_funcionario
         and cc_oficial
             = oc_oficial
         and cc_cta_banco
             > isnull(@i_cuenta,
                      '')
         and cc_tipocta_super
             <> '5' --SIN FINES DE LUCRO
         and (cc_disponible - cc_monto_blq - cc_monto_emb - cc_monto_consumos
                  - cc_monto_conformado) > 0

    --CUENTAS DE AHORRO
    insert #cuentas
      select
        '4-' + rtrim(ltrim(ah_cta_banco)),'CUENTA DE AHORROS',
        rtrim(ltrim(fu_nombre)
        ),
        ah_disponible - ah_monto_bloq - ah_monto_emb - ah_monto_consumos,
        case isnull((select
                       cb_tipo_bloqueo
                     from   cob_ahorros..ah_ctabloqueada
                     where  cb_cuenta = a.ah_cuenta
                        and cb_estado = 'V'),
                    '1')
          when '1' then '0'
          else '1'
        end
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_ahorros..ah_cuenta a,
             cobis..cc_oficial,
             cobis..cl_funcionario
      where  b.cl_det_producto
             =
             dp_det_producto
         and b.cl_cliente
             =
             @i_cliente
         and ah_cta_banco
             =
             dp_cuenta
         and ah_moneda
             =
             @i_mon
         and ah_estado
             =
             'A' --ACTIVAS
         and cl_rol in ('T', 'C') --EL TITULAR O COTITULAR
         and oc_funcionario
             =
             fu_funcionario
         and ah_oficial
             =
             oc_oficial
         and ah_cta_banco
             >
             isnull(@i_cuenta,
                    '')
         and ah_prod_banc not in (select
                                    prod
                                  from   #prd_nav3) --EXCLUIR NAVIDAD
         and ah_tipocta_super
             <>
             '5' --SIN FINES DE LUCRO
         and (ah_disponible - ah_monto_bloq - ah_monto_emb - ah_monto_consumos)
             >
             1000

    --DEPOSITOS A PLAZO
    insert #cuentas
      select
        '14-' + op_num_banco,'DEPOSITO A PLAZO',rtrim(ltrim(fu_nombre)),(isnull(
        op_monto,
                0) - isnull(op_monto_blq,
                            0) - isnull(op_monto_pgdo,
                                        0) - isnull(op_monto_blqlegal,
                                                    0)),case
          when (isnull(op_monto_blq, 0) + isnull(op_monto_pgdo, 0) + isnull(
                op_monto_blqlegal,
                0 ) = 0) then '0'
          else '1'
        end
      from   cob_pfijo..pf_beneficiario,
             cob_pfijo..pf_operacion,
             cobis..cl_funcionario
      where  be_operacion
             = op_operacion
         and op_toperacion not in ('409', '453', '509')
         and op_estado
             = 'ACT'
         and (isnull(op_monto,
                     0) - isnull(op_monto_blq,
                                 0) - isnull(op_monto_pgdo,
                                             0) - isnull(op_monto_blqlegal,
                                                         0)) > 0
         and op_ente
             = @i_cliente
         and op_ente
             = be_ente
         and op_oficial_principal
             = fu_login

    select
      @w_cuantos = count(1)
    from   #cuentas

    if @w_cuantos = 0
    begin
      /* No existe cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101162
      return 101162
    end

    if @w_cuantos < 20
      while @w_cuantos < 20
      begin
        insert into #cuentas
        values      (null,null,null,null,null)
        set @w_cuantos = @w_cuantos + 1
      end

    select
      cuenta
    from   #cuentas

    select
      tipo
    from   #cuentas

    select
      dispo
    from   #cuentas

    select
      oficial
    from   #cuentas

    select
      bloq
    from   #cuentas

  end --tipo 6

  if @i_modo = 7
  begin
    select
      @w_prods_nav = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PBNA'

    create table #prd_nav4
    (
      prod tinyint
    )

    while @w_prods_nav is not null
    begin
      select
        @w_prod = convert(tinyint, substring(@w_prods_nav,
                                             1,
                                             isnull(nullif(
                                             charindex(',',
                                                       @w_prods_nav)
                                                    ,
                                                           0),
                                                    11) - 1))
      insert into #prd_nav4
      values      (@w_prod)
      select
        @w_prods_nav = substring(@w_prods_nav,
                                 nullif(charindex(',', @w_prods_nav), 0) + 1,
                                 10)
    end

    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'cl_rol'
    if @i_producto = 3
    begin
      set rowcount 20
      select distinct
        'CLIENTE' = cl_cliente,
        'PRODUCTO' = 'CTE',
        'DISPONIBLE' = cc_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_interfase..cc_tsctacte
      where  b.cl_det_producto = dp_det_producto
         and b.cl_cliente      = @i_cliente
         and cc_cta_banco      = dp_cuenta
         and cc_moneda         = @i_mon
         and cc_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
         and cc_cta_banco      = @i_cuenta
      --order by dp_cuenta
      set rowcount 0
    end

    if @i_producto = 4
    begin
      set rowcount 20
      select distinct
        'CLIENTE' = cl_cliente,
        'PRODUCTO' = 'AHO',
        'DISPONIBLE' = ah_disponible,
        'ROL' = (select
                   a.valor
                 from   cobis..cl_catalogo a
                 where  a.tabla  = @w_tabla
                    and a.codigo = b.cl_rol)
      from   cobis..cl_cliente b,
             cobis..cl_det_producto,
             cob_ahorros..ah_cuenta
      where  b.cl_det_producto = dp_det_producto
         and b.cl_cliente      = @i_cliente
         and ah_cta_banco      = dp_cuenta
         and ah_moneda         = @i_mon
         and ah_prod_banc not in(select
                                   prod
                                 from   #prd_nav4)
         and ah_estado         = 'A' --SOLAMENTE LAS CUENTAS ACTIVAS
         and ah_cta_banco      = @i_cuenta
      order  by dp_cuenta
      set rowcount 0
    end
  end

  set rowcount 0

  return 0

go

