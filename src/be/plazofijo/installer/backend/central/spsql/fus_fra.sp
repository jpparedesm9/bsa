/************************************************************************/
/*      Archivo:                fusfra.sp                               */
/*      Stored procedure:       sp_fus_fra                              */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Walter Rocha                            */
/*      Fecha de documentacion: 09/Ago/98                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este procedimiento debe grabar a las tablas definitivas las     */
/*      transacciones de Apertura de la nueva operacion (fusion)        */
/*      Cancelacion de las operaciones (fusion) y lo contrario para     */
/*      Fraccionamiento                                                 */
/*                                                                      */
/*      Apertura de la nueva operacion                                  */
/*      Cancelacion de las operaciones                                  */
/*      Contabilizacion de la transaccion de fusion                     */
/*      Borrado de tablas temporales                                    */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*   FECHA         AUTOR                 RAZON                          */
/*   24/Ago/1999   Walter Rocha          Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where type ='P' and name = 'sp_fus_fra')
drop proc sp_fus_fra
go

create proc sp_fus_fra (
    @s_ssn                  int         = NULL,
    @s_sesn                 int         = NULL,
    @s_user                 login       = NULL,
    @s_term                 varchar(30) = NULL,
    @s_date                 datetime    = NULL,
    @s_srv                  varchar(30) = NULL,
    @s_lsrv                 varchar(30) = NULL,
    @s_ofi                  smallint    = NULL,
    @s_rol                  smallint    = NULL,
    @t_debug                char(1)     = 'N',
    @t_file                 varchar(10) = NULL,
    @t_from                 varchar(32) = NULL,
    @t_trn                  smallint    = NULL,
    @i_operacion            char(1),
    @i_cuenta               cuenta      = ' ',
    @i_operacion_new        int         = 0,
    @i_renovaut             char(1)     = NULL,
    @i_puntos               float       = 0, --12-Abr-2000 Tasa Variable
    @i_cancelaut            char(1)     = NULL,
    @i_renova_todo          char(1)     = NULL,
    @i_monto_base           money       = 0,
    @i_fecha_valor          datetime    = NULL,
    @i_tasa                 float       = 0,
    @i_empresa              tinyint     = 1,--ojo nuevo
    @i_plazo                int         = 0,
    @i_preimpreso           int         = 0,
    @i_fraccion             char(1)     = NULL,
    @i_batch                char(1)     = 'N',
    @i_producto_fusfra      varchar(3)  = NULL,
    @i_ente                 int         = NULL,
    @i_operacion_fusfra     int         = NULL,
    @i_flag                 char(1)     = 'N'      --LIM 08/NOV/2005
)
with encryption
as
declare
    /* Variables Necesarias */
    @w_sp_name               varchar(32),
    @w_return                int,
    @w_numdeci               int,
    @w_usadeci               char(1),
    @w_perfil                varchar(10),
    @w_mnemonico             varchar(5),
    @w_descripcion           varchar(64),
    @w_num_banco_fracciones  varchar(64),
    @w_num_banco_ant         varchar(30),
    @w_pos_coma              int,
    --------------------------------------------
    -- Variables para la insercion de pf_fusfra
    --------------------------------------------
    @w_ctOperacion           int,
    @w_ctSecuencial          int,
    @w_funcionario_aper      varchar(30),
    @w_estado                char(1),
    @w_monto                 money,
    @w_monto_pg_int          money,
    @w_int_ganado            money,
    @w_oficina               int,
    @w_operacion_new         int,
    @w_secuencial            int,
    @w_mt_operacion          int,
    @w_mt_subsecuencia       int,
    @w_mt_producto           catalogo,
    @w_mt_moneda             int,
    @w_mt_cuenta             cuenta,
    @w_mt_oficina            int,
    @w_oficina_dest          int,    --+-+
    @w_mt_valor              money,
    @w_mt_valor_ext          money,
    @w_mt_tipo               char(1),
    @w_mt_impuesto           money,
    @w_mt_beneficiario       int,
    @w_mt_tipo_cliente       char(1),
    @w_mt_cotizacion         money,
    @w_mt_tipo_cotiza        char(1),
    @w_moneda                int,
    @w_num_banco             cuenta,
    @w_producto              int,
    @w_toperacion            catalogo,
    @w_tplazo                catalogo,
    @w_codval                varchar(20),
    @w_comprobante           int,
    @w_contador              int,
    @w_cotizacion            int,--ojo
    @w_cotizacion_compra_b   int,
    @w_cotizacion_venta_b    int,
    @w_cotizacion_conta      int,--ojo
    @w_valor                 money,
    @w_valor_mn              money,
    @w_valor_me              money,
    @w_area                  int,
    @w_tot_valor_mn          money,
    @w_tot_valor_me          money,
    @w_tot_valor             money,
    @w_ente                  int,/* Variables para Contabilizacion Terceros N.N */
    @w_ced_ruc               varchar(14),  /* N.N:*/
    @w_tipo_ente             char(1),       /* N.N.*/
    @w_fpago                 catalogo,
    @w_debcred               char(1),
    @w_tot_int_ganado        money,
    @w_tot_int_retenido      money,
    @w_tot_int_acumulado     money,
    @w_sec                   int,
    @w_fecha_valor           datetime,
    @w_mon_sgte              int,
    @w_sec_mov               int,
    @w_preimpreso            int,
    @w_nomlar                varchar(96),
    @w_temp_nomlar           varchar(96),
    -------------------------------------------
    -- VARIABLES PARA INSERCION EN PF_DET_PAGO
    -------------------------------------------
    @w_dp_tipo               catalogo,
    @w_dp_forma_pago         catalogo,
    @w_dp_cuenta             cuenta,
    @w_dp_monto              money,
    @w_dp_porcentaje         float,
    @w_dp_moneda_pago        smallint,
    @w_ah_cta_banco          cuenta,
    @w_cc_cta_banco          cuenta,
    @w_fpago_ctaaho          catalogo,
    @w_fpago_ctacte          catalogo,
    @w_dp_descripcion        varchar,
    @w_dp_oficina            int,
    @w_dp_tipo_cliente       char,
    @w_dp_benef_chq          varchar,
    @w_dp_secuencial         int,
    @w_dp_tipo_cuenta_ach    char,
    @w_dp_banco_ach          descripcion,
    -------------------------------------------------------
    -- VARIABLES PARA AJUSTE DE DECIMALES EN LOS ASIENTOS
    -------------------------------------------------------
    @w_diferencia            float,   --OOJJOO!!
    @w_int_original          money,
    @w_int_nuevos            money,
    @w_contador_ajuste       int,
    @w_operacion_fusfra      int,
    @w_ope                   int,
    @w_moneda_base           tinyint,
    @w_monto_fusionar        money,
    @w_tran_fus              int,
    @w_tran_fra              int,
    @w_rowcount     int,    --LIM 08/NOV/2005
    @w_observacion     descripcion,  --+-+
    @w_fp_por_defecto  varchar(10),  --+-+
    @w_total_int_pagados  money,     --+-+
    @w_fecha_pago_fe   datetime,  --+-+
    @w_fecha_ult_pg_int_i    datetime,  --+-+
    @w_fecha_ini_per   datetime,  --+-+
    @w_int_ganado_new  money,     --+-+
    @w_ajuste_int      money,     --+-+
    @w_tipo         char(1),   --+-+
    @w_int_gan_orig       money,     --+-+
    @w_int_gan_conta   money,     --+-+
    @w_oficina_ajuste  int,    --+-+
    @w_codval2      smallint         --LIM 03/ENE/2005
    
    -------------------------------------------------------------------------------
    -- Variables para la transmision y llamadas a otros Sps o cuando se llama
    -- este Sp desde un proceso Batch
    --------------------------------------------------------------------

    select @w_sp_name       = 'sp_fus_fra',
           @w_return        = 0,
           @w_int_gan_conta = 0,  --+-+
           @s_user          = isnull(@s_user, 'sa'),
           @s_term          = isnull(@s_term,'CONSOLA'),
           @s_srv           = isnull(@s_srv, 'SYSTEM'),
           @s_lsrv          = isnull(@s_lsrv, 'SYSTEM'),
           @s_ofi           = isnull(@s_ofi,1),
           @s_rol           = isnull(@s_rol,1),
           @t_debug         = isnull(@t_debug,'N'),
           @t_file          = isnull(@t_file,'SQR'),
           @s_ssn           = isnull(@s_ssn,  10),
           @s_sesn          = isnull(@s_sesn, 10),
           @t_trn           = isnull(@t_trn,14952),
           @w_tran_fus      = 14986,
           @w_tran_fra      = 14987

    select  @w_cotizacion      = 0,
            @w_contador_ajuste = 0,
            @w_num_banco_fracciones = '',
            @w_num_banco_ant = ' '

    select @w_moneda_base = em_moneda_base
    from   cob_conta..cb_empresa
    where  em_empresa = @i_empresa

    if @@rowcount = 0
    begin
        exec cobis..sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 601018
        return  1
    end

    select @w_fp_por_defecto = isnull(pa_char,'VXP')
    from   cobis..cl_parametro
    where  pa_producto = 'PFI'
    and    pa_nemonico = 'NVXP'

declare fracciones_tmp cursor local static for
select   mt_operacion,
   mt_sub_secuencia,
   mt_producto,
   mt_cuenta,
   isnull(mt_valor,0),
   isnull(mt_valor_ext,0),
   mt_tipo,
   mt_impuesto,
   mt_beneficiario,
   mt_moneda,
   mt_tipo_cliente,
   mt_cotizacion,
   mt_tipo_cotiza
from pf_mov_monet_tmp
where mt_usuario       = @s_user
   and mt_sesion        = @s_sesn
   and mt_sub_secuencia > 0
order by mt_operacion, mt_sub_secuencia


    if (@i_operacion <> 'I')
    begin
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 141004
        return 1
    end

    if   (@t_trn <> 14952)
    begin
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 141018
        return 1
    end

    select @w_producto       = 14,
           @w_contador       = 0,
           @w_codval         = '1',
           @w_estado         = 'A',
           @w_tot_valor_mn   = 0,
           @w_tot_valor_me   = 0

begin tran  --*****************************************************************************************++

        --------------------------------------------------------------------
        -- PARA IDENTIFICAR CUANDO ES UNA FUSION O UN FRACCIONAMIENTO
        --------------------------------------------------------------------
        --@w_operacion_fusfra tiene el numero de la operacion que se fraccionara
        --o el numero de la operacion resultante de una fusion

        if @i_fraccion = 'S'
        begin
   if exists(select *
                      from   pf_operacion
                      where  op_operacion = @i_operacion_fusfra
         and (isnull(op_retenido,'N') = 'S'
         or isnull(op_custodia,'N') = 'S'
         or isnull(op_pignorado,'N') = 'S')
       )
            begin
                exec cobis..sp_cerror
                     @t_debug     = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_num       = 149082 -- El estado en custodia no permite esta transaccion.
                return 1
            end

   if exists(select *
                      from   pf_cuotas
                      where  cu_operacion = @i_operacion_fusfra
         and (isnull(cu_retenido,'N') = 'S'
         or isnull(cu_custodia,'N') = 'S')
       )
            begin
                exec cobis..sp_cerror
                     @t_debug     = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_num       = 149082 -- El estado en custodia no permite esta transaccion.
                return 1
            end

            select  @w_mnemonico ='FRA'
            select  @w_operacion_fusfra = @i_operacion_fusfra
        end
        else
        begin
            select @w_mnemonico = 'FUS'
            select @w_operacion_fusfra = @i_operacion_new
        end

        --------------------------------------
        -- Encuentra parametro de decimales
        --------------------------------------
        select @w_usadeci = mo_decimales
        from cobis..cl_moneda
        where mo_moneda = @w_moneda

        if @w_usadeci = 'S'
        begin
            select @w_numdeci = isnull (pa_tinyint,0)
            from   cobis..cl_parametro
            where  pa_nemonico = 'DCI'
            and    pa_producto = 'PFI'

            if @@rowcount = 0
            begin
                exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 141140
                return 1
            end
        end
        else
            select @w_numdeci = 0


        --------------------------------------------------------------------
        -- ENCONTRAR LA DIFERENCIA EN LOS INTERESES POR NUMERO DE DECIMALES
        -- EN LA OPERACION A CANCELAR
        --------------------------------------------------------------------
        select @w_int_original = sum(mt_valor)
        from   pf_mov_monet_tmp
        where  mt_usuario     = @s_user
        and    mt_sesion      = @s_sesn
        and    mt_producto    in ('IFRA','IFUS')
        and    mt_operacion   = @w_operacion_fusfra

        if @@error <> 0
        begin
   exec cobis..sp_cerror @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143001
            return  1
        end

        --------------------------------------------------------------------
        -- EN LAS OPERACIONES NUEVAS
        --------------------------------------------------------------------
        select @w_int_nuevos = sum(mt_valor)
        from   pf_mov_monet_tmp
        where  mt_usuario   = @s_user
        and    mt_sesion    = @s_sesn
        and    mt_producto  in ('IFRA','IFUS')
        and    mt_operacion not in (@w_operacion_fusfra)

        if @@error <> 0
        begin
   exec cobis..sp_cerror @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143001
            return  1
        end

        if @w_mnemonico = 'FRA'
            select @w_diferencia = (@w_int_nuevos - @w_int_original)
        else
            select @w_diferencia = (@w_int_original - @w_int_nuevos)

        select  @w_diferencia = round(@w_diferencia,@w_numdeci)

        -----------------------------------------
        -- SE OBTIENE EL OP_MON_SGTE
        -----------------------------------------
        select @w_mon_sgte = max(mt_sub_secuencia)
        from   pf_mov_monet_tmp
        where  mt_usuario = @s_user
        and    mt_sesion  = @s_sesn
        if @@error <> 0
        begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 149999,
                 @i_msg   = 'ERROR en la obtencion del monto siguiente'
            return  1
        end

        if @w_mon_sgte is NULL
            select @w_mon_sgte = 1

        ----------------------------------------
        --  Lectura de pf_mov_monet_tmp
        ----------------------------------------
        open fracciones_tmp

fetch fracciones_tmp into
      @w_mt_operacion,          @w_mt_subsecuencia,         @w_mt_producto,
              @w_mt_cuenta,             @w_mt_valor,                @w_mt_valor_ext,
              @w_mt_tipo,               @w_mt_impuesto,             @w_mt_beneficiario,
              @w_mt_moneda,             @w_mt_tipo_cliente,         @w_mt_cotizacion,
              @w_mt_tipo_cotiza


        while @@FETCH_STATUS = 0
        begin

            ---------------------------------------
            -- BUSCA COTIZACION PARA OTRAS MONEDAS
            ---------------------------------------
            if @w_mt_moneda <> @w_moneda_base
            begin
                set rowcount 1
                select @w_cotizacion_compra_b = co_compra_billete,
                       @w_cotizacion_venta_b  = co_venta_billete,
                       @w_cotizacion_conta    = co_conta
                from   pf_cotizacion
                where  co_moneda   = @w_mt_moneda
                and    co_fecha    = @s_date
                order  by co_fecha desc

                if @@rowcount <> 1 or @@error <> 0
                begin
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 149999,
                         @i_msg   = 'ERROR en la obtencion de cotiz otras monedas'
                    return  1
                end

                select @w_cotizacion = @w_cotizacion_conta
                select @w_valor_me =  @w_mt_valor_ext
                select @w_valor_mn =  round(@w_mt_valor, @w_numdeci) * @w_cotizacion

                set rowcount 0
            end
            else
            begin
                select @w_valor_mn = @w_mt_valor
                select @w_valor_me = 0
            end

            if @w_diferencia <> 0
            begin
                if (@w_mt_operacion = @w_operacion_fusfra) and (@w_mt_producto = 'IFRA') and (@w_mnemonico = 'FRA')
                    select @w_valor_mn = @w_valor_mn + @w_diferencia

                if ((@w_contador_ajuste = 0 ) and (@w_mt_operacion <> @w_operacion_fusfra) and (@w_mt_producto = 'IFUS') and (@w_mnemonico = 'FUS'))
                begin
                    select @w_valor_mn = @w_valor_mn + @w_diferencia
                    select @w_contador_ajuste=@w_contador_ajuste + 1
                end
            end

            select @w_valor_mn = round(@w_valor_mn, @w_numdeci)

            ---------------------------------------
            -- TRAER DATOS DE LA TABLA TEMPORAL
            ---------------------------------------
            set rowcount 0

            select @w_num_banco         = ot_num_banco,
                   @w_toperacion        = ot_toperacion,
                   @w_tplazo            = ot_tipo_plazo,
                   @w_moneda            = ot_moneda,
                   @w_fpago             = ot_fpago,
      @w_int_ganado        = ot_int_ganado,     --+-+
      @w_oficina_dest        = ot_oficina,      --+-+
                   @w_tot_int_ganado    = ot_tot_int_ganados,
      @w_total_int_pagados = ot_tot_int_pagados,   --+-+
                   @w_tot_int_retenido  = ot_tot_int_retenido,
      @w_tot_int_acumulado = ot_int_ganado,  --+-+ot_tot_int_ganados - ot_tot_int_pagados,   --+-+ot_tot_int_acumulado,
                   @w_fecha_valor       = ot_fecha_valor,
                   @w_preimpreso        = ot_preimpreso
            from   pf_operacion_tmp
            where  ot_operacion    = @w_mt_operacion
            and    ot_usuario      = @s_user
            and    ot_sesion       = @s_sesn

            if @@rowcount = 1
            begin
                ----------------------------------------------------------
                -- Seleccion del Codigo del Cliente de PF_BENEFICIARIO_TMP
                ----------------------------------------------------------
                --+-+print 'AAA @w_tot_int_ganado:%1!,@w_total_int_pagados:%2!,@w_tot_int_acumulado:%3!',@w_tot_int_ganado,@w_total_int_pagados,@w_tot_int_acumulado

                select @w_ente =  bt_ente
                from   pf_beneficiario_tmp
                where  bt_usuario = @s_user
                and bt_sesion = @s_sesn
                and bt_operacion = @w_mt_operacion
                and bt_rol = 'T'
                and bt_tipo = 'T'

                if @@rowcount = 0
                begin
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 141005
                    return  1
                end
            end
            else
            begin
                if @@rowcount = 0
                begin
                    select @w_num_banco           = op_num_banco,
                           @w_producto            = op_producto,
                           @w_toperacion          = op_toperacion,
                           @w_tplazo              = op_tipo_plazo,
                           @w_moneda              = op_moneda,
                           @w_ente                = op_ente,
                           @w_fpago               = op_fpago,
                           @w_monto               = op_monto,
                           @w_monto_pg_int        = op_monto_pg_int,
                           @w_funcionario_aper    = op_oficial,
                           @w_int_ganado          = op_int_ganado,
                           @w_oficina             = op_oficina,
                           @w_tot_int_ganado      = op_total_int_ganados,
                           @w_tot_int_retenido    = op_total_int_retenido,
                           @w_total_int_pagados   = op_total_int_pagados,  --+-+
                           @w_tot_int_acumulado   = op_total_int_ganados - op_total_int_pagados,   --+-+op_total_int_acumulado,
                           @w_fecha_valor         = op_fecha_valor,
                           @w_preimpreso          = op_preimpreso
                    from pf_operacion
                    where op_operacion = @w_mt_operacion

                    if @@rowcount = 0 or @@error <> 0
                    begin
                        exec cobis..sp_cerror
                             @t_debug = @t_debug,
                             @t_file  = @t_file,
                             @t_from  = @w_sp_name,
                             @i_num   = 149050
                        return  1
                    end
                end --if @@rowcount = 0
                --+-+-print 'BBB @w_tot_int_ganado:%1!,@w_total_int_pagados:%2!,@w_tot_int_acumulado:%3!',@w_tot_int_ganado,@w_total_int_pagados,@w_tot_int_acumulado
            end -- fin del begin del else

            ------------------------------------------------------------
            -- LECTURA CLIENTE  (Contabilizaci0n de Terceros) N.N.
            ------------------------------------------------------------
            select @w_ced_ruc   = en_ced_ruc,
                   @w_tipo_ente = en_subtipo,
                   @w_nomlar    = en_nomlar
            from   cobis..cl_ente
            where  en_ente = @w_ente

            ------------------------------------
            -- Verificar Decimales y Cuantos
            ------------------------------------
            select @w_usadeci = mo_decimales
            from   cobis..cl_moneda
            where  mo_moneda = @w_moneda

            if @w_usadeci = 'S'
            begin
                select @w_numdeci = isnull (pa_tinyint,0)
                from   cobis..cl_parametro
                where  pa_nemonico = 'DCI'
                and    pa_producto = 'PFI'
            end
            else
                select @w_numdeci = 0

            select @w_return = 0
            select @w_contador = @w_contador + 1

            ------------------------------------------------------------------
            -- Insercion en la tabla PF_FUSFRA  para llevar una relacion
            -- historica. Aqui se insertan los titulos que se fusionaron
            -- Se toman de PF_CANCELACION_TMP
            -- Obtener Secuencial para la inserccion en pf_fusfra
            ------------------------------------------------------------------

            --+-+print 'QQQQQ @w_ctSecuencial:%1!',@w_ctSecuencial
            select @w_ctSecuencial = max(fu_secuencial)
            from   pf_fusfra
            where  fu_operacion = @w_ctOperacion

            --+-+print 'AAAAA @w_ctSecuencial:%1!',@w_ctSecuencial

            if @w_ctSecuencial is not NULL
            begin
                select @w_ctSecuencial = @w_ctSecuencial + 1
                --+-+print 'BBBBB @w_ctSecuencial:%1!',@w_ctSecuencial
            end
            else
            begin
                select @w_ctSecuencial =  1
                --+-+print 'CCCCC @w_ctSecuencial:%1!',@w_ctSecuencial
            end


            if @w_mt_tipo = 'C'
                select @w_ctOperacion  = @w_mt_operacion

            if @w_mt_producto in ('CFUS','IFUS')
                select @w_operacion_new = @i_operacion_new
            else
                select @w_operacion_new = @w_mt_operacion


            if (@w_mt_tipo = 'B' and @w_mt_producto = 'CFRA') or (@w_mt_tipo = 'C' and @w_mt_producto = 'CFUS')
            begin
                -----------------------------------------------------------
                -- PARA DIFERENCIAR CUANDO FUE UNA OPERACION POR BATCH O
                -- POR FRONT END
                -----------------------------------------------------------
                if @i_batch = 'S'
                    select @w_descripcion = 'DECEVAL'
                else
                    if @w_mt_producto in ('CFRA','IFRA')
                        select @w_descripcion = 'FRACCIONAMIENTO'
                    else
                    begin
                        select  @w_descripcion = 'FUSION',
                                @w_preimpreso  = @i_preimpreso

                        select  @w_ced_ruc   = en_ced_ruc,
                                @w_tipo_ente = en_subtipo,
                                @w_nomlar    = en_nomlar
                        from    cobis..cl_ente
                        where   en_ente = @i_ente

                        if @@error <> 0
                        begin
                            exec cobis..sp_cerror
                                 @t_debug = @t_debug,
                                 @t_file  = @t_file,
                                 @t_from  = @w_sp_name,
                                 @i_num   = 149999,
                                 @i_msg   = 'ERROR EN BUSQUEDA DE ENTE'
                            rollback tran
                            select @w_return = 1
                            goto borra
                        end
                    end

                ------------------------------------------
                -- INSERCION Definitiva en PF_FUSFRA
                ------------------------------------------
                if @w_mt_moneda = @w_moneda_base
                    select @w_monto_fusionar = @w_mt_valor
                else
                    select @w_monto_fusionar = @w_mt_valor_ext

                --+-+print '@w_ctOperacion:%1!,@w_ctSecuencial:%2!,@i_tasa:%3!',@w_ctOperacion,@w_ctSecuencial,@i_tasa

                if @w_mnemonico = 'FRA'    --+-+
                    select @w_total_int_pagados = 0

                set rowcount 1
                insert into pf_fusfra (fu_operacion,            fu_secuencial,                fu_tasa,
                                       fu_plazo,                fu_fecha_valor,               fu_oficial_apertura,
                                       fu_oficial_fusion,       fu_estado,                    fu_estado_ant,
                                       fu_renova_todo,          fu_monto,                     fu_monto_pg_int,
                                       fu_monto_fusionar,       fu_fecha_crea,                fu_fecha_mod,
                                       fu_descripcion,          fu_operacion_new,             fu_impuesto,
                                       fu_tot_int_ganado,       fu_tot_int_pagados,           fu_tot_int_retenido,
                                       fu_tot_int_acumulado,    fu_mnemonico,                 fu_moneda_pg,
                                       fu_oficina_apertura,     fu_oficina_fusion,            fu_preimpreso,
                                       fu_toperacion,           fu_nomlar)
                                values(@w_ctOperacion,          @w_ctSecuencial,              @i_tasa,
                                       @i_plazo,                @w_fecha_valor,               @w_funcionario_aper,
                                       @s_user,                 @w_estado,                    @w_estado,
                                       'N',                     @w_monto,                     @w_monto_pg_int,
                                       @w_monto_fusionar,       @s_date,                      NULL,
                                       @w_descripcion,          @w_operacion_new,             0,
                                       --+-+ @w_tot_int_ganado,
                                       @w_int_ganado,       @w_total_int_pagados,         @w_tot_int_retenido,
                                       @w_tot_int_acumulado,    @w_mnemonico,                 NULL,
                                       @w_oficina,              @s_ofi,                       @w_preimpreso,
                                       @w_toperacion,           @w_nomlar)

                if @@error <> 0 --or @@rowcount <> 1
                begin
                    --+-+print 'Error :%1!, rowcount:%2!',@@error,@@rowcount
         exec cobis..sp_cerror @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143016
                    rollback tran
                    select @w_return = 1
                    goto borra
                end

                set rowcount 0

                --Busca fecha de ultimo pago de interes ya sea periodico o anticipado
                select @w_fecha_pago_fe = isnull(op_fecha_ult_pago_int_ant,'01/01/1900'),
                       @w_fecha_ult_pg_int_i = op_fecha_ult_pg_int
                from   pf_operacion
                where  op_operacion = @w_ctOperacion

                if @w_fecha_pago_fe > @w_fecha_ult_pg_int_i
                    select @w_fecha_ini_per = @w_fecha_pago_fe
                else
                    select @w_fecha_ini_per = @w_fecha_ult_pg_int_i

            end

            if (@w_mt_tipo = 'C' and (@w_mt_producto in ('CFRA','CFUS')))
            begin
                if @w_mt_producto = 'CFRA'
                    select @w_observacion = 'FRACCIONAMIENTO'
                else
                    select @w_observacion = 'CONSOLIDACION'

                -- Validar si la operacion tiene instruccion de cancelacion o renovacion
                if exists(select * from pf_cancelacion where ca_operacion = @w_mt_operacion and ca_estado = 'I' and ca_tipo = 'N')
                   or exists(select * from pf_renovacion where re_operacion = @w_mt_operacion and re_estado = 'I')
                begin
                    rollback tran
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 141191
                    select @w_return = 141191
                    goto borra
                end

                ------------------------------------------
                --  EJECUCION DE SP_CAN_FUS_FRA
                ------------------------------------------
                select @w_return = 0
                exec @w_return        = sp_can_fus_fra
                     @s_ssn           = @s_ssn,
                     @s_sesn          = @s_sesn,
                     @s_user          = @s_user,
                     @s_term          = @s_term,
                     @s_date          = @s_date,
                     @s_srv           = @s_srv,
                     @s_lsrv          = @s_lsrv,
                     @s_ofi           = @s_ofi,
                     @s_rol           = @s_rol,
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @t_from,
                     @t_trn           = 14954,
                     @i_operacion     = 'I',
                     @i_observacion   = @w_observacion,
                     @i_operacion_can = @w_mt_operacion

                if @w_return = 1
                begin
                    rollback tran
                    select @w_return = 1
                    goto borra
                end
            end
            else
            begin
                if (@w_mt_tipo = 'B' and (@w_mt_producto in ('CFRA','CFUS')))
                begin

                    if @w_mt_producto = 'CFRA'
                        select @w_observacion = 'FRACCIONAMIENTO'
                    else
                        select @w_observacion = 'CONSOLIDACION'

                    select @w_return = 0

                    exec @w_return = sp_ins_fus_fra
                         @s_ssn           = @s_ssn,
                         @s_sesn          = @s_sesn,
                         @s_user          = @s_user,
                         @s_term          = @s_term,
                         @s_date          = @s_date,
                         @s_srv           = @s_srv,
                         @s_lsrv          = @s_lsrv,
                         @s_ofi           = @s_ofi,
                         @s_rol           = @s_rol,
                         @t_debug         = @t_debug,
                         @t_file          = @t_file,
                         @t_from          = @t_from,
                         @t_trn           = 14953,
                         @i_num_banco     = @w_num_banco,
                         @i_operacion     = 'I',
                         @i_renovaut      = @i_renovaut,
                         @i_puntos        = @i_puntos,
                         @i_cancelaut     = @i_cancelaut,
                         @i_renova_todo   = @i_renova_todo,
                         @i_monto_base    = @i_monto_base,
                         @i_fraccion      = @i_fraccion,
                         @i_batch         = @i_batch,
                         @i_observacion   = @w_observacion,
                         @i_sub_secuencia = @w_mt_subsecuencia,
                         @i_fecha_inicio  = @w_fecha_ini_per, --+-+ fecha valor = fecha de ult pago int
                          --+-+ ya sea periodico o anticipado.
                         @i_mon_sgte      = @w_mon_sgte,
                         @o_int_ganado    = @w_int_ganado_new out   --+-+

                    if @w_return <> 0
                    begin
                        rollback tran
                        select @w_return = 1
                        goto borra
                    end

                    -- Actualiza registro de fraccion correspondiente  --+-+
                    if @w_mnemonico = 'FRA'
                    begin
                        update pf_fusfra
                        set    fu_tot_int_ganado = isnull(@w_int_ganado_new,0)
                        where  fu_operacion      = @w_ctOperacion
                        and    fu_operacion_new  = @w_operacion_new
                        and    fu_estado         = 'A'
                    end

                    -- Totaliza int_ganado para las nuevas operaciones --+-+
                    select @w_int_gan_conta = @w_int_gan_conta + isnull(@w_int_ganado_new,0)
                end
            end

            --------------------------------------------------------
            -- INSERCCION EN PF_MOV_MONET DEL REGISTRO PROCESADO
            -- Obtener Secuencial para la inserccion en pf_fusfra
            -- DP00065, JSA, 04/09/2001 ingreso del tipo de cliente
            --------------------------------------------------------

            select @w_sec_mov = max(mm_secuencia)
            from   pf_mov_monet
            where  mm_operacion = @w_mt_operacion
            --+-+ and mm_tran      = 14952
            --+-+ and mm_secuencia = 0

            if @@error <> 0
            begin
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 149999,
         @i_msg ='error en obtencion de secuencial'
                return  1
            end

            if @w_sec_mov is not NULL
                select @w_sec_mov =  @w_sec_mov + 1
            else
                select @w_sec_mov =  1

            --+-+print '@w_mt_operacion:%1!,secuencia:%2!,@w_mt_subsecuencia:%3!',@w_mt_operacion,@w_sec_mov,@w_mt_subsecuencia

            insert into pf_mov_monet (mm_operacion,              mm_secuencia,               mm_secuencial,
                                      mm_sub_secuencia,          mm_producto,                mm_cuenta,
                                      mm_tran,                   mm_valor,                   mm_tipo,
                                      mm_beneficiario,           mm_impuesto,                mm_moneda,
                                      mm_valor_ext,              mm_fecha_crea,              mm_fecha_mod,
                                      mm_estado,                 mm_fecha_aplicacion,        mm_user,
                                      mm_tipo_cliente,           mm_cotizacion,              mm_tipo_cotiza,
                                      mm_usuario,                mm_oficina,                 mm_fecha_real,
                                      mm_fecha_valor)
                              values (@w_mt_operacion,           @w_sec_mov,                 @s_ssn,
                                      @w_mt_subsecuencia,        @w_mt_producto,             @w_mt_cuenta,
                                      14952,                     @w_mt_valor,                @w_mt_tipo,
                                      @w_mt_beneficiario,        @w_mt_impuesto,             @w_mt_moneda,
                                      @w_mt_valor_ext,           @s_date,                    @s_date,
                                      'A',                       @s_date,                    @s_user,
                                      @w_mt_tipo_cliente,        @w_mt_cotizacion,           @w_mt_tipo_cotiza,
                                      @s_user,                   @s_ofi,                     getdate(),
                                      @s_date)
            if @@error <> 0
            begin
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 143021
                rollback tran
                select @w_return = 1
                goto borra
            end

            -------------------------------------------------
            -- INSERCION De La Transaccion de Servicio
            -------------------------------------------------
            insert into ts_mov_monet (secuencial,               tipo_transaccion,                 clase,
                                      fecha,                    usuario,                          terminal,
                                      srv,                      lsrv,                             operacion,
                                      transaccion,              secuencia,                        sub_secuencia,
                                      producto,                 cuenta,                           valor,
                                      tipo,                     beneficiario,                     impuesto,
                                      moneda,                   valor_ext,                        fecha_crea,
                                      fecha_mod,                estado)
                              values (@s_ssn,                   14952,                            'N',
                                      @s_date,                  @s_user,                           @s_term,
                                      @s_srv,                   @s_lsrv,                           @w_mt_operacion,
                                      14952,                    @s_ssn,                            @w_mt_subsecuencia,
                                      @w_mt_producto,           @w_mt_cuenta,                      @w_mt_valor,
                                      @w_mt_tipo,               @w_mt_beneficiario,                @w_mt_impuesto,
                                      @w_mt_moneda,             @w_mt_valor_ext,                   @s_date,
                                      @s_date,                  NULL)
            if @@error <> 0
            begin
      exec cobis..sp_cerror @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 143005
                select @w_return = 1
                goto borra
            end

   fetch fracciones_tmp into  @w_mt_operacion,         @w_mt_subsecuencia,        @w_mt_producto,
                  @w_mt_cuenta,            @w_mt_valor,               @w_mt_valor_ext,
                  @w_mt_tipo,              @w_mt_impuesto,            @w_mt_beneficiario,
                  @w_mt_moneda,            @w_mt_tipo_cliente,        @w_mt_cotizacion,
                  @w_mt_tipo_cotiza
        end   /* Fin del i_loop1 */

        if @@FETCH_STATUS = -2
        begin
            close fracciones_tmp
            deallocate  fracciones_tmp
            raiserror ('200001 - Fallo lectura del cursor fracciones_tmp', 16, 1)
            return 0
        end

        close fracciones_tmp
        deallocate  fracciones_tmp

        ---------------------------------------------------------------------
        -- Proceso incrementado para enviar un secuencial distinto por cada
        -- registro en  pf_det_pago.
        ---------------------------------------------------------------------

        if @i_producto_fusfra = 'FUS'
        begin
            select @w_sec = isnull(max(dp_secuencia),0)+1
            from   pf_det_pago
            where dp_operacion = @w_operacion_new
        end

        if @w_mt_producto in ('CFRA','IFRA')
        begin
            select @w_num_banco = op_num_banco
            from   pf_operacion
            where  op_operacion = @w_ctOperacion

            select @w_descripcion = 'FRACCIONAMIENTO (' + convert(varchar,@w_num_banco) + ') '
            --'CONTABILIZACION DE FRACCIONAMIENTO (' + convert(varchar, @w_ctOperacion) + ') '
        end
        else
        begin
            select @w_num_banco = op_num_banco
            from   pf_operacion
            where  op_operacion = @i_operacion_new

            select @w_descripcion = 'CONSOLIDACION (' + convert(varchar,@w_num_banco) + ') '
            --'CONTABILIZACION DE FUSION (' + convert(varchar,@i_operacion_new) + ') '
        end

        --Ejecuta perfil de ajuste de provision por control de cambios que solicita hacer fecha valor de la nueva fecha de
        --calculo de interes para los depositos


        if @w_mnemonico = 'FRA'
        begin
            select @w_int_gan_orig = op_int_ganado - op_int_pagados
            from   pf_operacion
            where  op_operacion = @w_operacion_fusfra
        end
        else
        begin
            select @w_int_gan_orig = sum(op_int_ganado - op_int_pagados)
            from   pf_operacion, pf_fusfra
            where  op_operacion     = fu_operacion
            and    fu_operacion_new = @w_operacion_fusfra
            and    fu_estado        = 'A'
        end

        select @w_oficina_ajuste = op_oficina     --Oficina de la operacion padre o hija --+-+
        from   pf_operacion
        where  op_operacion = @w_operacion_fusfra
        --+-+print '@w_operacion_fusfra:%1!,@w_int_gan_conta:%2!,@w_int_gan_orig:%3!',@w_operacion_fusfra,@w_int_gan_conta,@w_int_gan_orig

        select @w_ajuste_int = @w_int_gan_conta - @w_int_gan_orig

        --+-+print '@w_ajuste_int:%1!',@w_ajuste_int

        if @w_ajuste_int < 0
            select @w_tipo = 'R'
        else
            select @w_tipo = 'N'

        select @w_ajuste_int = abs(@w_ajuste_int)


        if @w_mnemonico = 'FRA'
            select @w_descripcion = 'FRACCIONAMIENTO (' + convert(varchar,@w_num_banco) + ') '
        else
            select @w_descripcion = 'CONSOLIDACION (' + convert(varchar,@w_num_banco) + ') '

        --print 'w_oficina:%1!,w_oficina_dest:%2!',@w_oficina,@w_oficina_dest

        --Ejecuta Perfil contable de Fusion/Fraccionamiento
        --print 'VA A CONTABILIZAR...:%1!,OPER:%2!',@w_mnemonico,@w_operacion_fusfra
        --Nueva contabilizacion
        exec @w_return = cob_pfijo..sp_aplica_conta
             @s_date            = @s_date,
             @s_user            = @s_user,
             @s_term            = @s_term,
             @i_fecha           = @s_date,
             @i_tran            = 14952,
             @i_operacionpf     = @w_operacion_fusfra, --@w_ctOperacion,
             @i_afectacion      = 'N',
             @i_secuencia       = 0,
             @i_fusfra          = @w_mnemonico,
             @o_comprobante     = @w_comprobante out

        if @w_return <> 0
        begin
            rollback  tran
            select @w_return = 91 --12-May-2000 fus/fra
            goto borra --12-May-2000 fus/fra
        end
        else
        begin
   insert into pf_relacion_comp (
   rc_num_banco,     rc_comp,        rc_cod_tran,     rc_tran,
                                          rc_estado,        rc_secuencia,   rc_numero,       rc_fecha_tran)
   values (
   @w_num_banco,     @w_comprobante, 14952,           @w_mnemonico,
                                          'N',              NULL,           0,               @s_date)
        end

        select @w_ope = fu_operacion
        from   pf_fusfra
        where  fu_estado = 'A'

    commit tran --********************************************************************************************
    borra:
        delete pf_det_pago_tmp
        where dt_usuario = @s_user and dt_sesion = @s_sesn

        delete pf_operacion_tmp
        where ot_usuario = @s_user and ot_sesion = @s_sesn

        delete pf_mov_monet_tmp
        where mt_usuario = @s_user and mt_sesion = @s_sesn

        delete pf_beneficiario_tmp
        where bt_usuario = @s_user and bt_sesion = @s_sesn

        delete pf_cancelacion_tmp
        where cn_usuario = @s_user and cn_sesion = @s_sesn

    return @w_return
go



