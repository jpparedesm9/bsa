/****************************************************************************/
/*     Archivo:             peprocon.sp                                     */
/*     Stored procedure:    sp_producto_contractual                         */
/*     Base de datos:       cob_remesas                                     */
/*     Producto:            Sub-Modulo de Personalizacion                   */
/*     Disenado por:        Jaime Loyo Holguin                              */
/*     Fecha de escritura:  29 de Marzo de 2011                             */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa se encarga de insertar, actualizar, borrar y consultar */
/*     (Search, Query y Help) la definicion de un producto contractual.     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     29/Mar/2011      J. Loyo         Emision Inicial                     */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/

use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_producto_contractual')
  drop proc sp_producto_contractual
go

create proc sp_producto_contractual
(
  @s_ssn              int = null,
  @s_user             login = null,
  @s_sesn             int = null,
  @s_term             varchar(30) = null,
  @s_date             datetime = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_rol              smallint = null,
  @s_ofi              smallint = null,
  @s_org_err          char(1) = null,
  @s_error            int = null,
  @s_sev              tinyint = null,
  @s_msg              descripcion = null,
  @s_org              char(1) = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(14) = null,
  @t_from             varchar(32) = null,
  @t_trn              smallint = null,
  @t_show_version     bit = 0,
  @i_oper             char(3),
  @i_profinal         smallint = null,
  @i_categoria        char(1) = null,
  @i_plazo            tinyint = null,--- VALIDAR CAMPO
  @i_plazo_neg        char(1) = 'N',
  @i_cuota            money = null,--- VALIDAR CAMPO
  @i_cuota_neg        char(1) = 'N',
  @i_periodicidad     catalogo = null,--- VALIDAR CAMPO
  @i_periodicidad_neg char(1) = 'N',
  @i_monto_final      money = null,--- VALIDAR CAMPO
  @i_monto_final_neg  char(1) = 'N',
  @i_dias_max_mora    tinyint = 0,--- VALIDAR CAMPO
  @i_ptos_premio      float = null,--- VALIDAR CAMPO
  @i_fecha_crea       datetime = null,
  @i_fecha_upd        datetime = null,
  @i_contractual      char(1) = 'N',
  @i_sucursal         int = null,
  @i_plan_pago        char(1) = 'N',
  @i_estado           char(1) = 'V',
  @o_tipo_ente        char(1) = null out,
  @o_me_pro_bancario  tinyint = null out
----------------------------------
)
as
  declare
    @w_sp_name          varchar(32),
    @w_return           int,
    @w_plazo            tinyint,
    @w_plazo_neg        char(1),
    @w_cuota            money,
    @w_cuota_neg        char(1),
    @w_periodicidad     catalogo,
    @w_periodicidad_neg char(1),
    @w_monto_final      money,
    @w_monto_final_neg  char(1),
    @w_dias_max_mora    tinyint,
    @w_estado           catalogo,
    @w_ptos_premio      float,
    @w_plan_pago        char(1),
    @w_profinal         smallint,
    @w_contractual      char(1)

  /* Captura del nombre del stored procedure */
  select
    @w_sp_name = 'sp_producto_contractual'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Validar el codigo de transaccion */
  if @t_trn = 4125
  begin
    /* ** Insert ** */
    if @i_oper = 'I'
    begin
      if @i_profinal is null
          or @i_categoria is null
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351527,
          @i_msg   = 'No viene el producto final o la categoria'
        /* 'No existe producto final' */
        return 351527
      end

      /* Verificacion que exista el producto final  */
      if not exists (select
                       1
                     from   cob_remesas..pe_pro_final
                     where  pf_pro_final = @i_profinal)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351527
        /* 'No existe producto final' */
        return 351527
      end

      /*** Verificamos que no este creado el producto contractual ***/
      if exists (select
                   1
                 from   cob_remesas..pe_producto_contractual
                 where  pc_profinal  = @i_profinal
                    and pc_categoria = @i_categoria)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351569
        /* 'Ya existe registro Producto Contractual' */
        return 351569
      end

      begin tran

      /* Insercion de Definicion de producto Contractual */
      insert into pe_producto_contractual
                  (pc_profinal,pc_categoria,pc_plazo,pc_plazo_neg,pc_cuota,
                   pc_cuota_neg,pc_periodicidad,pc_monto_final,pc_dias_max_mora,
                   pc_estado,
                   pc_ptos_premio,pc_fecha_crea,pc_fecha_upd,pc_plan_pago)
      values      (@i_profinal,@i_categoria,@i_plazo,@i_plazo_neg,@i_cuota,
                   @i_cuota_neg,@i_periodicidad,@i_monto_final,@i_dias_max_mora,
                   @i_estado,
                   @i_ptos_premio,getdate(),getdate(),@i_plan_pago)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353516
        /* 'Error al insertar producto Contractual' */
        return 353517
      end

      /* transaccion servicio - categoria por producto */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_tipo_variacion,ts_minimo,ts_tipo,ts_rubro,
                   ts_maximo,
                   ts_rango,ts_cuenta,ts_fecha,ts_fecha_cambio)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_categoria,@i_plazo,
                   @i_plazo_neg,@i_cuota,@i_cuota_neg,@i_periodicidad,
                   @i_monto_final
                   ,
                   @i_dias_max_mora,convert(varchar, @i_ptos_premio)
                   ,getdate(),getdate
                   () )

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end
  end

  if @t_trn = 4126
  begin
    /* ** Delete ** */
    if @i_oper = 'D'
    begin
      select
        @w_profinal = pc_profinal,
        @w_plazo = pc_plazo,
        @w_plazo_neg = pc_plazo_neg,
        @w_cuota = pc_cuota,
        @w_cuota_neg = pc_cuota_neg,
        @w_periodicidad = pc_periodicidad,
        @w_ptos_premio = pc_ptos_premio
      from   cob_remesas..pe_producto_contractual
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351570
        /*'No existe registro Producto Contractual'*/
        return 351570
      end

      begin tran

      /* Eliminacion de una Producto final como producto contractual */
      update cob_remesas..pe_producto_contractual
      set    pc_estado = 'C'
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_fil   = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357512
        /*'Error al eliminar Producto Contractual'*/
        return 357512
      end

      /* transaccion servicio - producto Contractual */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_tipo_variacion,ts_minimo,ts_tipo,ts_rubro,
                   ts_maximo,
                   ts_rango,ts_cuenta,ts_fecha,ts_fecha_cambio)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_categoria,@w_plazo,
                   @w_plazo_neg,@w_cuota,@w_cuota_neg,@w_periodicidad,
                   @i_monto_final
                   ,
                   @i_dias_max_mora,convert(varchar, @i_ptos_premio)
                   ,getdate(),getdate
                   () )

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end
  end

  if @t_trn = 4124
  begin
    /* ** Update ** */
    if @i_oper = 'U'
    begin
      /* Capturar los datos anteriores del producto Contractual*/
      select
        @w_plazo = pc_plazo,-- En meses
        @w_plazo_neg = pc_plazo_neg,
        @w_cuota = pc_cuota,
        @w_cuota_neg = pc_cuota_neg,
        @w_periodicidad = pc_periodicidad,
        @w_monto_final = pc_monto_final,
        @w_estado = pc_estado,
        @w_ptos_premio = pc_ptos_premio,
        @w_plan_pago = pc_plan_pago
      from   cob_remesas..pe_producto_contractual
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351570
        /*'No existe registro Producto Contractual'*/
        return 351570
      end

      begin tran

      /* Actualizacion de los datos del producto contractual */
      update pe_producto_contractual
      set    pc_plazo = @i_plazo,-- En meses
             pc_plazo_neg = @i_plazo_neg,
             pc_cuota = @i_cuota,
             pc_cuota_neg = @i_cuota_neg,
             pc_periodicidad = @i_periodicidad,
             pc_monto_final = @i_monto_final,
             pc_estado = @i_estado,
             pc_ptos_premio = @i_ptos_premio,
             pc_plan_pago = @i_plan_pago,
             pc_fecha_upd = getdate()
      where  pc_profinal  = @i_profinal
         and pc_categoria = @i_categoria

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_fil   = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355520
        /*'Error en actualizar producto Contractual'*/
        return 355520
      end

      /* transaccion servicio - producto Contractual PREVIO */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_tipo_variacion,ts_minimo,ts_tipo,ts_rubro,
                   ts_maximo,
                   ts_rango,ts_cuenta,ts_fecha_cambio,ts_rol)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_categoria,@w_plazo,
                   @w_plazo_neg,@w_cuota,@w_cuota_neg,@w_periodicidad,
                   @w_monto_final
                   ,
                   @w_dias_max_mora,convert(varchar, @w_ptos_premio)
                   ,getdate(),'P' )

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      /* transaccion servicio - producto Contractual  ACTUAL */
      insert into pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_pro_final,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_tipo_variacion,ts_minimo,ts_tipo,ts_rubro,
                   ts_maximo,
                   ts_tipo_default,ts_rango,ts_cuenta,ts_fecha_cambio,ts_rol)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   'N',@i_oper,@i_profinal,@i_categoria,@i_plazo,
                   @i_plazo_neg,@i_cuota,@i_cuota_neg,@i_periodicidad,
                   @i_monto_final
                   ,
                   @i_monto_final_neg,@i_dias_max_mora,convert(
                   varchar, @i_ptos_premio
                   ),getdate(),'A' )

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 103005
      end

      commit tran
      return 0
    end
  end

  if @t_trn = 4123
  begin
    /* Search - Query  */
    if @i_oper in ('S', 'Q', 'H')
    begin
    /* HELP */
      /** Ayuda para Encontrar el tipo de cliente definido para un determiando producto final **/
      if @i_oper = 'H'
      begin
        select
          @o_tipo_ente = me_tipo_ente,
          @o_me_pro_bancario = me_pro_bancario
        from   cob_remesas..pe_pro_final,
               cob_remesas..pe_mercado
        where  pf_pro_final = @i_profinal
           and pf_sucursal  = @i_sucursal
           and pf_mercado   = me_mercado
        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351570
          /*'No existe mercado definido*/
          return 351511
        end

        select
          @o_tipo_ente,
          @o_me_pro_bancario

      end

      /* Search */
      if @i_oper = 'S'
      begin
        select
          '1644' = pc_profinal,                                            --PROD
          '1665' = pf_descripcion,                                         --PRODUCTO FINAL
          '1062 ' = pc_categoria,                                          --CAT
          '1063' = b1.valor,                                               --CATEGORIA
          '1636' = pc_plazo,                                               --PLAZO
          '1494' = pc_plazo_neg,                                           --NEG. PLAZO
          '1134' = pc_cuota,                                               --CUOTA
          '1493' = pc_cuota_neg,                                           --NEG. CUOTA
          '1625' = pc_periodicidad,                                        --PERIODICIDAD
          '1189' = b2.valor,                                               --DESCRIPCION
          --             'NEG. PERIOD'    = pc_periodicidad_neg,
          '1485' = pc_monto_final,                                         --MONTO FINAL
          --             'NEG MONTO FIN'  = pc_monto_final_neg,
          --'DIAS'           = isnull(pc_dias_max_mora, 0),
          '1333' = pc_estado,                                              --ESTADO
          '1188' = case pc_estado -- 14                                      DESCR. ESTADO
                              when 'V' then 'VIGENTE'
                              when 'C' then 'NO VIGENTE'
                            end,
          '1675' = pc_ptos_premio,                                         --PUNTOS ADIC
          '1121' = pc_fecha_crea,                                          --CREACION
          '1479' = pc_fecha_upd,-- 17                                        MODIFICACION
          '1736' = pf_sucursal,                                            --SUCURSAL
          '1406 ' = pc_plan_pago,                                          --IMPRIME
          '1645' = pb_pro_bancario,-- 20                                     PROD BANC
          '1656' = pb_descripcion                                          --PRODUCTO BANCARIO
        from   cob_remesas..pe_pro_final,
               cob_remesas..pe_producto_contractual,
               cob_remesas..pe_mercado,
               cob_remesas..pe_pro_bancario,
               cobis..cl_tabla a1,
               cobis..cl_catalogo b1,
               cobis..cl_tabla a2,
               cobis..cl_catalogo b2
        where  (pc_profinal     = @i_profinal
                 or @i_profinal     = null)
           and pc_profinal     = pf_pro_final
           and (pc_categoria    = @i_categoria
                 or @i_categoria is null)
           and a1.tabla        = 'pe_categoria'
           and a1.codigo       = b1.tabla
           and b1.codigo       = pc_categoria
           and a2.tabla        = 'ah_capitalizacion'
           and a2.codigo       = b2.tabla
           and b2.codigo       = pc_periodicidad
           and me_pro_bancario = pb_pro_bancario
           and me_mercado      = pf_mercado

        -- and pc_estado     = 'V'

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351570
          /* 'No existe registro Producto Contractual'*/
          return 351570
        end
        return 0
      end

      /* Query */
      if @i_oper = 'Q'
      begin
        select
          '1644' = pc_profinal,-- 1                                           --PROD
          '1665' = pf_descripcion,-- 2                              --PRODUCTO FINAL
          '1062 ' = pc_categoria,-- 3                                          --CAT
          '1063' = b1.valor,-- 4                                         --CATEGORIA
          '1636' = pc_plazo,-- 5                                             --PLAZO
          '1494' = pc_plazo_neg,-- 6                                    --NEG. PLAZO
          '1134' = pc_cuota,-- 7                                             --CUOTA
          '1493' = pc_cuota_neg,-- 8                                    --NEG. CUOTA
          '1625' = pc_periodicidad,-- 9                               --PERIODICIDAD
          '1189' = b2.valor,-- 10                                      --DESCRIPCION
          --            'NEG. PERIOD'    = pc_periodicidad_neg,         --    
          '1485' = pc_monto_final,-- 11                                --MONTO FINAL
          --            'NEG MONTO FIN'  = pc_monto_final_neg,          --    
          --'DIAS'           = isnull(pc_dias_max_mora, 0),   -- 12           
          '1333' = pc_estado,-- 13                                          --ESTADO
          '1188' = case pc_estado -- 14                                DESCR. ESTADO
                              when 'V' then 'VIGENTE'                         
                              when 'C' then 'NO VIGENTE'                      
                            end,                                              
          '1675' = pc_ptos_premio,-- 15                                --PUNTOS ADIC
          '1121' = pc_fecha_crea,-- 16                                    --CREACION
          '1479' = pc_fecha_upd,-- 17                                   MODIFICACION
          '1736' = pf_sucursal,                                           --SUCURSAL
          '1406' = pc_plan_pago,                                           --IMPRIME
          '1645' = pb_pro_bancario,-- 20                                   PROD BANC
          '1656' = pb_descripcion                                --PRODUCTO BANCARIO
        from   cob_remesas..pe_pro_final,
               cob_remesas..pe_producto_contractual,
               cob_remesas..pe_mercado,
               cob_remesas..pe_pro_bancario,
               cobis..cl_tabla a1,
               cobis..cl_catalogo b1,
               cobis..cl_tabla a2,
               cobis..cl_catalogo b2
        where  pc_profinal     = pf_pro_final
               -- and   pc_categoria = @i_categoria
               and a1.tabla        = 'pe_categoria'
               and a1.codigo       = b1.tabla
               and b1.codigo       = pc_categoria
               and a2.tabla        = 'ah_capitalizacion'
               and a2.codigo       = b2.tabla
               and b2.codigo       = pc_periodicidad
               and me_pro_bancario = pb_pro_bancario
               and me_mercado      = pf_mercado

        -- and pc_estado     = 'V'

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351570
          /* 'No existe registro Producto Contractual'*/
          return 351570
        end
        return 0
      end
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

GO 
