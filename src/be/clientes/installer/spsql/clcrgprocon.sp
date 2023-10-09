/************************************************************************/
/*      Archivo:        clcrgprocon.sp                                  */
/*  Stored procedure:   sp_con_gral_producto_con                        */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Etna Johana Laguna                              */
/*  Fecha de escritura:     05-Abr-2001                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*      Este stored procedure procesa:                                  */
/*      Consulta de los productos AHO, CTE con sus respectivos saldos   */
/*      para realizar Congelamientos de Fondos y Producto a un Cliente  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*        FECHA           AUTOR             RAZON                       */
/*      18/Ene/2010     O. Usina        Embargos Cta. Ahorros           */
/*      02/Mayo/2016    Roxana Sánchez     Migración a CEN              */
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
           where  name = 'sp_con_gral_producto_con')
  drop proc sp_con_gral_producto_con
go
create proc sp_con_gral_producto_con
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
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cliente      int = null,
  @i_modo         tinyint = null,
  @i_operacion    char (1),
  @i_tipo_mmi     varchar(6) = null,
  @i_secuencial   int = null
)
as
  declare
    @w_sp_name     varchar(32),
    @w_oficial     smallint,
    @w_nue_oficial smallint,
    @w_desc_banca  descripcion,
    @w_banca       varchar(3),
    @w_gente       int,
    @w_vbanca      varchar(3),
    @vw_oficial    varchar(64),
    @ww_oficial    varchar(64),
    @w_parametro   money,
    @w_primera     char(16),
    @w_sec         int,
    @w_mdian       varchar(10),
    @w_mmi         varchar(10)

  --U2 V3
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_con_gral_producto_con'
  select
    @w_mdian = 'MMIDIA'

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1436
    begin
      select
        @w_parametro = pa_money
      from   cobis..cl_parametro
      where  pa_nemonico = @i_tipo_mmi
         and pa_producto = 'MIS'

      if @@rowcount = 0
        select
          @w_parametro = 0
      --busca la fecha mas antigua de las cuentas
      select
        Cta = ah_cta_banco,
        Fecha = ah_fecha_aper,
        Rol = cl_rol
      into   #tmp_ctas
      from   cob_ahorros..ah_cuenta,
             cobis..cl_cliente,
             cobis..cl_det_producto
      where  ah_estado       <> 'C'
         and ah_cta_banco    = dp_cuenta
         and cl_det_producto = dp_det_producto
         and cl_cliente      = @i_cliente
         and cl_rol in('T', 'C')

      select top 1
        @w_primera = Cta
      from   #tmp_ctas
      where  Fecha = (select
                        min(Fecha)
                      from   #tmp_ctas)

      if @i_tipo_mmi = @w_mdian
      begin
        /*   Muestra los productos para Ahorros */
        delete from productos_tmp
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
            'CUENTA     ' = ah_cta_banco,'SALDO      ' = case
                              when (((ah_disponible - ah_monto_bloq
                                      - ah_monto_emb
                                     )
                                     - @w_parametro) < 0)
                            then 0
                              else (ah_disponible - ah_monto_bloq - ah_monto_emb
                                   )
                                   - @w_parametro
                            end,
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA ' = ah_tipocta,'FECHA APERTURA ' =
                                           convert(varchar(10),
                                           ah_fecha_aper, 101),
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_ahorros..ah_cuenta,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
             and pf_producto     = 4
             and pf_moneda       = 0
             and pf_tipo         = 'R'
             and me_mercado      = pf_mercado
             and me_pro_bancario = pb_pro_bancario
             and pb_pro_bancario = ah_prod_banc
             and ah_estado       <> 'C'
             and ah_cta_banco    = dp_cuenta
             and cl_det_producto = dp_det_producto
             and ah_cta_banco    = @w_primera
             and cl_cliente      = @i_cliente
             and cl_rol in('T', 'C')

        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
            'CUENTA     ' = ah_cta_banco,'SALDO      ' = case
                              when ((ah_disponible - ah_monto_bloq
                                     - ah_monto_emb)
                                    <
                                    0
                                   )
                                                         then
                              0
                              else (ah_disponible - ah_monto_bloq - ah_monto_emb
                                   )
                            end,
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA ' = ah_tipocta,'FECHA APERTURA ' =
                                           convert(varchar(10),
                                           ah_fecha_aper, 101),
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_ahorros..ah_cuenta,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
             and pf_producto     = 4
             and pf_moneda       = 0
             and pf_tipo         = 'R'
             and me_mercado      = pf_mercado
             and me_pro_bancario = pb_pro_bancario
             and pb_pro_bancario = ah_prod_banc
             and ah_estado       <> 'C'
             and ah_cta_banco    = dp_cuenta
             and cl_det_producto = dp_det_producto
             and cl_cliente      = @i_cliente
             and cl_rol in('T', 'C')
             and ah_cta_banco    <> @w_primera

        /*   Muestra los productos para Corrientes */
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'CTE',
            'CUENTA     ' = cc_cta_banco,'SALDO      ' = ((
                                         cc_disponible - cc_monto_blq)
                                                          - @w_parametro),
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA' = cc_tipocta,'FECHA APERTURA' = convert(varchar(10)
                                                             ,
                                                             cc_fecha_aper, 101)
            ,
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_cuentas..cc_ctacte,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
             and pf_producto     = 3
             and pf_moneda       = 0
             and pf_tipo         = 'R'
             and me_mercado      = pf_mercado
             and me_pro_bancario = pb_pro_bancario
             and pb_pro_bancario = cc_prod_banc
             and cc_estado       <> 'C'
             and cc_cta_banco    = dp_cuenta
             and cl_det_producto = dp_det_producto
             and cl_cliente      = @i_cliente
             and cl_rol in('T', 'C')
             and cc_cta_banco    = @w_primera

        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'CTE',
            'CUENTA     ' = cc_cta_banco,'SALDO      ' = (
                                         cc_disponible - cc_monto_blq
                                                         ),
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA' = cc_tipocta,'FECHA APERTURA' = convert(varchar(10)
                                                             ,
                                                             cc_fecha_aper, 101)
            ,
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_cuentas..cc_ctacte,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
                 --       and   pf_sucursal  = 22200
                 and pf_producto     = 3
                 and pf_moneda       = 0
                 and pf_tipo         = 'R'
                 and me_mercado      = pf_mercado
                 and me_pro_bancario = pb_pro_bancario
                 and pb_pro_bancario = cc_prod_banc
                 and cc_estado       <> 'C'
                 and cc_cta_banco    = dp_cuenta
                 and cl_det_producto = dp_det_producto
                 and cl_cliente      = @i_cliente
                 and cl_rol in('T', 'C')
                 and cc_cta_banco    <> @w_primera
      end
      else
      begin
        /*   Muestra los productos para Ahorros */
        delete from productos_tmp
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
            'CUENTA     ' = ah_cta_banco,'SALDO      ' = case
                              when (((ah_disponible - ah_monto_bloq
                                      - ah_monto_emb
                                     )
                                     - @w_parametro) < 0)
                            then 0
                              else (ah_disponible - ah_monto_bloq - ah_monto_emb
                                   )
                                   - @w_parametro
                            end,
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA ' = ah_tipocta,'FECHA APERTURA ' =
                                           convert(varchar(10),
                                           ah_fecha_aper, 101),
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_ahorros..ah_cuenta,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
                 --  and   pf_sucursal  = 22200
                 and pf_producto     = 4
                 and pf_moneda       = 0
                 and pf_tipo         = 'R'
                 and me_mercado      = pf_mercado
                 and me_pro_bancario = pb_pro_bancario
                 and pb_pro_bancario = ah_prod_banc
                 and ah_estado       <> 'C'
                 and ah_cta_banco    = dp_cuenta
                 and cl_det_producto = dp_det_producto
                 and cl_cliente      = @i_cliente
                 and cl_rol in('T', 'C')

        /*   Muestra los productos para Corrientes */
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = '','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'CTE',
            'CUENTA     ' = cc_cta_banco,'SALDO      ' = ((
                                         cc_disponible - cc_monto_blq)
                                                          - @w_parametro),
            'CAPITAL    ' = 0,'INTERES    ' = 0,'MONTO A EMBARGAR ' = 0,
            'CAPITAL A EMBARGAR ' = 0,'INTERES A EMBARGAR ' = 0,
            'NATURALEZA CTA' = cc_tipocta,'FECHA APERTURA' = convert(varchar(10)
                                                             ,
                                                             cc_fecha_aper, 101)
            ,
            'SECUENCIAL' = 0
          from   cob_remesas..pe_pro_final,
                 cob_remesas..pe_mercado,
                 cob_remesas..pe_pro_bancario,
                 cob_cuentas..cc_ctacte,
                 cobis..cl_cliente,
                 cobis..cl_det_producto
          where  pf_filial       = 1
             and pf_producto     = 3
             and pf_moneda       = 0
             and pf_tipo         = 'R'
             and me_mercado      = pf_mercado
             and me_pro_bancario = pb_pro_bancario
             and pb_pro_bancario = cc_prod_banc
             and cc_estado       <> 'C'
             and cc_cta_banco    = dp_cuenta
             and cl_det_producto = dp_det_producto
             and cl_cliente      = @i_cliente
             and cl_rol in('T', 'C')
      end
      /* Inicio el Query que mapea el Front End */
      delete productos_tmp2
      insert into productos_tmp2
                  (marca,descripcion,producto,cuenta,saldo,
                   capital,interes,montoe,capitale,interese,
                   naturaleza,apertura,secuencial)
        select
          'MARCA' = marca,'DESCRIPCION' = descripcion,'PRODUCTO   ' = producto,
          'CUENTA     ' = cuenta,'SALDO      ' = saldo,
          'CAPITAL    ' = capital,'INTERES    ' = interes,
          'MONTO A EMBARGAR ' = montoe
          ,
          'CAPITAL A EMBARGAR ' = capitale,'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA ' = naturaleza,'FECHA APERTURA ' =
                                         convert(varchar(10),
                                         apertura, 101),
          'SECUENCIAL'
          = secuencial
        from   cobis..productos_tmp
        order  by apertura asc

      select
        @w_sec = 1

      update cobis..productos_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1
      if @i_modo = 0
      begin
        set rowcount 20
        select
          'MARCA' = marca,
          'DESCRIPCION' = descripcion,
          'PRODUCTO   ' = producto,
          'CUENTA     ' = cuenta,
          'SALDO      ' = saldo,
          'CAPITAL    ' = capital,
          'INTERES    ' = interes,
          'MONTO A EMBARGAR ' = montoe,
          'CAPITAL A EMBARGAR ' = capitale,
          'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA ' = naturaleza,
          'FECHA APERTURA ' = convert(varchar(10), apertura, 101),
          'SECUENCIAL' = secuencial
        from   cobis..productos_tmp2
        order  by secuencial
      end
      else
      begin
        set rowcount 20
        select
          'MARCA' = marca,
          'DESCRIPCION' = descripcion,
          'PRODUCTO   ' = producto,
          'CUENTA     ' = cuenta,
          'SALDO      ' = saldo,
          'CAPITAL    ' = capital,
          'INTERES    ' = interes,
          'MONTO A EMBARGAR ' = montoe,
          'CAPITAL A EMBARGAR ' = capitale,
          'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA ' = naturaleza,
          'FECHA APERTURA ' = convert(varchar(10), apertura, 101),
          'secuencial' = secuencial
        from   cobis..productos_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end
      return 0

    end
  end /* If operacion = Q*/

go

