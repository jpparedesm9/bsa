/************************************************************************/
/*  Archivo:              clcrgpro.sp                                   */
/*  Stored procedure:     sp_con_gral_producto                          */
/*  Base de datos:        cobis                                         */
/*  Producto:             Clientes                                      */
/*  Disenado por:         Etna Johana Laguna                            */
/*  Fecha de escritura:   05-Abr-2001                                   */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*  Este stored procedure procesa:                                      */
/*  Consulta de los productos de AHO, CTE y PFI con sus respectivos     */
/*  saldos para realizar embargos a un Cliente                          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR            RAZON                              */
/*  04/Feb/2010    O. Usi¤a          Embragos Cuenta ahorros            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_con_gral_producto')
  drop proc sp_con_gral_producto
go
create proc sp_con_gral_producto
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
  @i_modo         tinyint = 0,
  @i_siguiente    cuenta = null,
  @i_linea        char (1) = null,
  @i_operacion    char (1),
  @i_tipo_mmi     varchar(6) = 'MMINAP',
  @i_secuencial   int = null
)
as
  declare
    @w_sp_name          varchar(32),
    @w_oficial          smallint,
    @w_nue_oficial      smallint,
    @w_desc_banca       descripcion,
    @w_banca            varchar(3),
    @w_gente            int,
    @w_vbanca           varchar(3),
    @w_imp_2x1000       float,
    @w_factor_3x1000    float,
    @w_parametro        money,
    @w_primera          char(16),
    @w_sec              int,
    @w_mdian            varchar(10),
    @w_mmi              varchar(10),
    @w_productos        smallint,
    @w_producto         varchar(3),
    @w_cuenta           cuenta,
    @w_fecha_proceso    datetime,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_saldo            money,
    @w_cta              int,
    @w_secuencial       int,
    @w_return           int,
    @w_error            int,
    @w_total_gmf        money,-- GMF Calculado
    @w_acumu_deb        money,-- Devuelve acumulado debitos
    @w_actualiza        char(1),-- Indicador para actualizar acumulado
    @w_base_gmf         money,-- Devuelve base calculo gmf
    @w_concepto         smallint,-- Devuelve concepto exencion
    @w_tasa             float,-- Devuelve la tasa aplicada
    @w_difer_gmf        money,-- Devuelve la diferencia para embargos
    @w_marca            char(1)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --U2 V9
  select
    @w_sp_name = 'sp_con_gral_producto'
  select
    @w_mdian = 'MMIDIA'

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1422
    begin
      select
        @w_parametro = pa_money
      from   cobis..cl_parametro
      where  pa_nemonico = @i_tipo_mmi
         and pa_producto = 'MIS'

      if @@rowcount <> 1
      begin
        if @i_linea = 'S'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001,
            @i_msg   = 'NO EXISTE PARAMETRO DE MONTO '
          return 101001
        end
        else
          return 101001
      end

      --busca la fecha mas antigua de las cuentas
      select
        Cta = ah_cta_banco,
        Fecha = ah_fecha_aper,
        Rol = cl_rol
      into   #tmp_ctas1
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
      from   #tmp_ctas1
      where  Fecha = (select
                        min(Fecha)
                      from   #tmp_ctas1)

      if @i_tipo_mmi = @w_mdian
      begin
        /*Muestra los productos para Ahorros */
        delete from productos_tmp
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = 'A','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
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
            'CUENTA     ' = ah_cta_banco,'SALDO      ' =
                                         ah_disponible - ah_monto_bloq
                                         - ah_monto_emb,
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
             and ah_cta_banco    <> @w_primera
             and cl_cliente      = @i_cliente
             and cl_rol in('T', 'C')

      end
      else
      begin
        /*Muestra los productos para Ahorros */
        delete from productos_tmp
        insert into productos_tmp
                    (marca,descripcion,producto,cuenta,saldo,
                     capital,interes,montoe,capitale,interese,
                     naturaleza,apertura,secuencial)
          select distinct
            'MARCA' = ' ','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
            'CUENTA     ' = ah_cta_banco,'SALDO      ' = (
                                         ah_disponible - ah_monto_bloq
                                         - ah_monto_emb) - @w_parametro
            ,
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
      end

    /*   Muestra los productos para Corrientes */
      /*   se agrego suma de los exigibles pendientes(14905) para la operacion */
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
          'NATURALEZA CTA ' = cc_tipocta,'FECHA APERTURA ' = cc_fecha_aper,
          'SECUENCIAL'
          = 0
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

    /*   Muestra los productos para Plazo Fijo */
      /*   se agrego suma de los exigibles pendientes(14905) para la operacion */

      insert into productos_tmp
                  (marca,descripcion,producto,cuenta,saldo,
                   capital,interes,montoe,capitale,interese,
                   naturaleza,apertura,secuencial)
        select
          'MARCA' = '','DESCRIPCION' = td_descripcion,'PRODUCTO   ' = 'PFI',
          'CUENTA     ' = op_num_banco,'SALDO      ' = 0,
          'CAPITAL    ' = op_monto - (isnull(op_monto_blq, 0) + isnull(
                                      op_monto_pgdo,
                                      0
                                      )
                                      + isnull(
                                                      op_monto_blqlegal
                                                                 , 0 )),
          'INTERES    ' = isnull(op_total_int_estimado,
                                 0) - isnull((select
                                                isnull(sum((isnull(
                                                       bl_valor_int_embgdo_banco
                                                            ,
                                                       0) - isnull(
                                                bl_valor_int_embgdo_aplicado
                                                ,
                                                0))),
                                                       0)
                                              from   cob_pfijo..pf_bloqueo_legal
                                              where  bl_operacion =
                                                     pf.op_operacion
                                                 and bl_estado    = 'I'),
                                             0) - isnull(op_total_int_pagados,
                                                         0),
          'MONTO A EMBARGAR ' = 0,
          'CAPITAL EMBARGADO' = 0,--op_monto_blqlegal,
          'INTERES EMBARGADO' = 0,--op_monto_int_blqlegal,
          'NATURALEZA CTA ' = '','FECHA APERTURA ' = op_fecha_crea,
          'SECUENCIAL' = 0
        from   cob_pfijo..pf_tipo_deposito,
               cob_pfijo..pf_operacion pf,
               cob_pfijo..pf_beneficiario
        where  op_operacion     = be_operacion
           and op_toperacion    = td_mnemonico
           and op_tasa_variable = td_tasa_variable
           and op_estado in ('ACT', 'VEN')
           and be_ente          = @i_cliente
           and be_estado_xren   = 'N'
           and be_estado        = 'I'
           and be_tipo          = 'T'
           and op_operacion not in (select
                                      rt_operacion
                                    from   cob_pfijo..pf_retencion
                                    where  rt_operacion = pf.op_operacion
                                       and rt_motivo    = 'BCHQL')
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
          'CAPITAL A EMBARGAR' = capitale,'INTERES A EMBARGAR' = interese,
          'NATURALEZA CTA ' = naturaleza,'FECHA APERTURA ' =
                                         convert(varchar(10),
                                         apertura, 101),
          'SECUENCIAL'
          = secuencial
        from   cobis..productos_tmp
      --      order by apertura asc

      select
        @w_sec = 1

      update cobis..productos_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      /* se ejecuta el calcula saldo para las cuentas de ahorro */
      select
        @w_productos = count(0)
      from   cobis..productos_tmp2

      if @w_productos > 0
      begin
        declare cursor_calcula_saldoAH cursor for
          select
            producto,
            cuenta,
            saldo,
            secuencial,
            marca
          from   cobis..productos_tmp2
          where  producto = 'AHO'
          --           and  marca   <> 'A'
          for read only

        open cursor_calcula_saldoAH

        fetch cursor_calcula_saldoAH into @w_producto,
                                          @w_cuenta,
                                          @w_saldo,
                                          @w_secuencial,
                                          @w_marca

        while (@@fetch_status != -1)
        begin
          -- Control del estado del cursor
          if @@fetch_status = -2
          begin
            close cursor_calcula_saldoAH
            deallocate cursor_calcula_saldoAH
            return 2
          end

          select
            @w_fecha_proceso = fc_fecha_cierre
          from   cobis..ba_fecha_cierre
          where  fc_producto = 2

          if @w_cuenta is not null
          begin
            select
              @w_cta = ah_cuenta
            from   cob_ahorros..ah_cuenta
            where  ah_cta_banco = @w_cuenta

            if @@error != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 105026
              return 1
            end

            exec @w_return = cob_ahorros..sp_ahcalcula_saldo
              @t_from             = @w_sp_name,
              @i_cuenta           = @w_cta,
              @i_fecha            = @w_fecha_proceso,
              @i_valida_saldo     = 'N',
              @i_monblq           = 'N',
              @o_saldo_para_girar = @w_saldo_para_girar out,
              @o_saldo_contable   = @w_saldo_contable out

            if @w_return != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101017--cambiar
              return 1
            end
            if isnull(@w_saldo_para_girar,
                      0) > 0
            begin
              if @i_tipo_mmi = @w_mdian
                 and @w_marca = 'A'
              begin
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_parametro
              end

              if @i_tipo_mmi <> @w_mdian
              begin
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_parametro
              end

              exec @w_return = cob_ahorros..sp_calcula_gmf
                @s_date       = @w_fecha_proceso,
                @s_ofi        = @s_ofi,
                @t_trn        = 264,
                @i_factor     = 1,
                @i_mon        = 0,
                @i_cta        = @w_cuenta,
                @i_cuenta     = @w_cta,
                @i_val        = @w_saldo_para_girar,
                @i_val_tran   = @w_saldo_para_girar,
                @i_numdeciimp = 2,
                @i_producto   = 4,
                @i_operacion  = 'Q',
                @i_total      = 'S',
                @o_total_gmf  = @w_total_gmf out,
                @o_acumu_deb  = @w_acumu_deb out,
                @o_actualiza  = @w_actualiza out,
                @o_base_gmf   = @w_base_gmf out,
                @o_concepto   = @w_concepto out,
                @o_difer_gmf  = @w_difer_gmf out

              if @w_return <> 0
                return @w_return
              else
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_total_gmf
            end
          end -- @w_cuenta  <> ''

          if @w_saldo_para_girar is not null
          begin
            update cobis..productos_tmp2
            set    saldo = case
                             when ((@w_saldo_para_girar) < 0) then 0
                             else @w_saldo_para_girar
                           end
            where  producto = 'AHO'
               and cuenta   = @w_cuenta

            if @@error != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 105026

              return 1
            end
            goto SIGUIENTE
          end -- @w_saldo_para_girar is not null

          ------
          SIGUIENTE:
          fetch cursor_calcula_saldoAH into @w_producto,
                                            @w_cuenta,
                                            @w_saldo,
                                            @w_secuencial,
                                            @w_marca

        end -- while
        close cursor_calcula_saldoAH
        deallocate cursor_calcula_saldoAH
      end --if @w_productos > 0

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

  /*  CODIGO PARA COBRO AUTOMATICO - BATCH */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1422
    begin
      select
        @w_parametro = pa_money
      from   cobis..cl_parametro
      where  pa_nemonico = @i_tipo_mmi
         and pa_producto = 'MIS'

      if @@rowcount <> 1
      begin
        if @i_linea = 'S'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001,
            @i_msg   = 'NO EXISTE PARAMETRO DE MONTO '
          return 101001
        end
        else
          return 101001
      end

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

      /*Muestra los productos para Corrientes */
      delete from productos_tmp
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
          'NATURALEZA CTA ' = cc_tipocta,'FECHA APERTURA ' = cc_fecha_aper,
          'SECUENCIAL'
          = 0
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

      /*   Muestra los productos para Ahorros */
      insert into productos_tmp
                  (marca,descripcion,producto,cuenta,saldo,
                   capital,interes,montoe,capitale,interese,
                   naturaleza,apertura,secuencial)
        select distinct
          'MARCA' = 'A','DESCRIPCION' = pb_descripcion,'PRODUCTO   ' = 'AHO',
          'CUENTA     ' = ah_cta_banco,'SALDO      ' = case
                            when (((ah_disponible - ah_monto_bloq - ah_monto_emb
                                   )
                                   - @w_parametro) < 0)
                          then 0
                            else (ah_disponible - ah_monto_bloq - ah_monto_emb)
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
          'CUENTA     ' = ah_cta_banco,'SALDO      ' =
                                       ah_disponible - ah_monto_bloq
                                       - ah_monto_emb,
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
           and ah_cta_banco    <> @w_primera
           and cl_cliente      = @i_cliente
           and cl_rol in('T', 'C')

    /*   Muestra los productos para Plazo Fijo */
      /*   se agrego suma de los exigibles pendientes(14905) para la operacion */

      insert into productos_tmp
                  (marca,descripcion,producto,cuenta,saldo,
                   capital,interes,montoe,capitale,interese,
                   naturaleza,apertura,secuencial)
        select
          'MARCA' = '','DESCRIPCION' = td_descripcion,'PRODUCTO   ' = 'PFI',
          'CUENTA     ' = op_num_banco,'SALDO      ' = 0,
          'CAPITAL    ' = op_monto - (isnull(op_monto_blq, 0) + isnull(
                                      op_monto_pgdo,
                                      0
                                      )
                                      + isnull(
                                                      op_monto_blqlegal
                                                                 , 0 )),
          'INTERES    ' = isnull(op_total_int_estimado,
                                 0) - isnull((select
                                                isnull(sum((isnull(
                                                       bl_valor_int_embgdo_banco
                                                            ,
                                                       0) - isnull(
                                                bl_valor_int_embgdo_aplicado
                                                ,
                                                0))),
                                                       0)
                                              from   cob_pfijo..pf_bloqueo_legal
                                              where  bl_operacion =
                                                     pf.op_operacion
                                                 and bl_estado    = 'I'),
                                             0) - isnull(op_total_int_pagados,
                                                         0),
          'MONTO A EMBARGAR ' = 0,
          'CAPITAL EMBARGADO' = 0,--op_monto_blqlegal,
          'INTERES EMBARGADO' = 0,--op_monto_int_blqlegal,
          'NATURALEZA CTA ' = '','FECHA APERTURA ' = op_fecha_crea,
          'SECUENCIAL' = 0
        from   cob_pfijo..pf_tipo_deposito,
               cob_pfijo..pf_operacion pf
        where  op_toperacion    = td_mnemonico
           and op_tasa_variable = td_tasa_variable
           and op_estado in ('ACT', 'VEN')
           and op_ente          = @i_cliente

      /* Inicio el Query que mapea el Front End */
      delete productos_tmp2
      insert into productos_tmp2
                  (marca,descripcion,producto,cuenta,saldo,
                   capital,interes,montoe,capitale,interese,
                   naturaleza,apertura,secuencial)
        select
          'MARCA              ' = marca,'DESCRIPCION        ' = descripcion,
          'PRODUCTO           ' = producto,'CUENTA             ' = cuenta,
          'SALDO              ' = saldo,
          'CAPITAL            ' = capital,'INTERES            ' = interes,
          'MONTO A EMBARGAR   ' = montoe,'CAPITAL A EMBARGAR ' = capitale,
          'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA     ' = naturaleza,'FECHA APERTURA     ' =
                                             convert(varchar(10), apertura, 101)
          ,
          'SECUENCIAL         ' = secuencial
        from   cobis..productos_tmp
      --      order by apertura asc

      select
        @w_sec = 1

      update cobis..productos_tmp2
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      /* se ejecuta el calcula saldo para las cuentas de ahorro */
      select
        @w_productos = count(0)
      from   cobis..productos_tmp2

      if @w_productos > 0
      begin
        declare cursor_calcula_saldoAH cursor for
          select
            producto,
            cuenta,
            saldo,
            secuencial,
            marca
          from   cobis..productos_tmp2
          where  producto = 'AHO'
          --           and  marca <> 'A'
          for read only

        open cursor_calcula_saldoAH

        fetch cursor_calcula_saldoAH into @w_producto,
                                          @w_cuenta,
                                          @w_saldo,
                                          @w_secuencial,
                                          @w_marca

        while (@@fetch_status != -1)
        begin
          -- Control del estado del cursor
          if @@fetch_status = -2
          begin
            close cursor_quita_mascara
            deallocate cursor_calcula_saldoAH
            return 2
          end

          select
            @w_fecha_proceso = fc_fecha_cierre
          from   cobis..ba_fecha_cierre
          where  fc_producto = 2

          if @w_cuenta <> ''
          begin
            select
              @w_cta = ah_cuenta
            from   cob_ahorros..ah_cuenta
            where  ah_cta_banco = @w_cuenta

            if @@error != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 105026
              return 1
            end
            exec @w_return = cob_ahorros..sp_ahcalcula_saldo
              @t_from             = @w_sp_name,
              @i_cuenta           = @w_cta,
              @i_fecha            = @w_fecha_proceso,
              @i_valida_saldo     = 'N',
              @i_monblq           = 'N',
              @o_saldo_para_girar = @w_saldo_para_girar out,
              @o_saldo_contable   = @w_saldo_contable out

            if @w_return != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101017--cambiar
              return 1
            end

            if isnull(@w_saldo_para_girar,
                      0) > 0
            begin
              if @i_tipo_mmi = @w_mdian
                 and @w_marca = 'A'
              begin
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_parametro
              end

              if @i_tipo_mmi <> @w_mdian
              begin
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_parametro
              end

              exec @w_return = cob_ahorros..sp_calcula_gmf
                @s_date       = @w_fecha_proceso,
                @s_ofi        = @s_ofi,
                @t_trn        = 264,
                @i_factor     = 1,
                @i_mon        = 0,
                @i_cta        = @w_cuenta,
                @i_cuenta     = @w_cta,
                @i_val        = @w_saldo_para_girar,
                @i_val_tran   = @w_saldo_para_girar,
                @i_numdeciimp = 2,
                @i_producto   = 4,
                @i_operacion  = 'Q',
                @i_total      = 'S',
                @o_total_gmf  = @w_total_gmf out,
                @o_acumu_deb  = @w_acumu_deb out,
                @o_actualiza  = @w_actualiza out,
                @o_base_gmf   = @w_base_gmf out,
                @o_concepto   = @w_concepto out,
                @o_difer_gmf  = @w_difer_gmf out

              if @w_return <> 0
                return @w_return
              else
                select
                  @w_saldo_para_girar = @w_saldo_para_girar - @w_total_gmf
            end
          end --@w_cuenta  <> ""

          if @w_saldo_para_girar is not null
          begin
            update cobis..productos_tmp2
            set    saldo = case
                             when ((@w_saldo_para_girar) < 0) then 0
                             else @w_saldo_para_girar
                           end
            where  producto = 'AHO'
               and cuenta   = @w_cuenta

            if @@error != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 105026
              return 1
            end
          end --@w_saldo_para_girar is not null

          goto SIGUIENTE2

          ------
          SIGUIENTE2:
          fetch cursor_calcula_saldoAH into @w_producto,
                                            @w_cuenta,
                                            @w_saldo,
                                            @w_secuencial,
                                            @w_marca
        end -- while
        close cursor_calcula_saldoAH
        deallocate cursor_calcula_saldoAH

      end --    if @w_productos > 0

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'MARCA              ' = marca,
          'DESCRIPCION        ' = descripcion,
          'PRODUCTO           ' = producto,
          'CUENTA             ' = cuenta,
          'SALDO              ' = saldo,
          'CAPITAL            ' = capital,
          'INTERES            ' = interes,
          'MONTO A EMBARGAR   ' = montoe,
          'CAPITAL A EMBARGAR ' = capitale,
          'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA     ' = naturaleza,
          'FECHA APERTURA     ' = convert(varchar(10), apertura, 101),
          'SECUENCIAL         ' = secuencial
        from   cobis..productos_tmp2
        order  by secuencial
      end
      else
      begin
        set rowcount 20
        select
          'MARCA              ' = marca,
          'DESCRIPCION        ' = descripcion,
          'PRODUCTO           ' = producto,
          'CUENTA             ' = cuenta,
          'SALDO              ' = saldo,
          'CAPITAL            ' = capital,
          'INTERES            ' = interes,
          'MONTO A EMBARGAR   ' = montoe,
          'CAPITAL A EMBARGAR ' = capitale,
          'INTERES A EMBARGAR ' = interese,
          'NATURALEZA CTA     ' = naturaleza,
          'FECHA APERTURA     ' = convert(varchar(10), apertura, 101),
          'secuencial         ' = secuencial
        from   cobis..productos_tmp2
        where  secuencial > @i_secuencial
        order  by secuencial
      end
      return 0
    end --fin trans.
  end --fin operacion
  return 0

go

