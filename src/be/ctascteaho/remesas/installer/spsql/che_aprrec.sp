/*******************************************************************************/
/*  Archivo:             che_aprrec.sp                                         */
/*  Store Procedure:     sp_cheq_aprob_rechaz                                  */
/*  Base de Datos:       cob_remesas                                           */
/*  Producto:            Aprobación/Rechazos de cheques                        */
/*  Diseñado por:        Jorge Zapata A.                                       */
/*  Fecha de Escritura:  18/JUN/2015                                           */
/*******************************************************************************/
/*                    IMPORTANTE                                               */
/*  Este programa es parte de los paquetes bancarios propiedad de "MACOSA",    */
/*  representantes exclusivos para el Ecuador de la "NCR CORPORATION".         */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/*  alteracion o agregado hecho por alguno de sus usuarios sin el debido       */
/*  consentimiento por escrito de la Presidencia Ejecutiva de MACOSA o su      */
/*  representante.                                                             */
/*******************************************************************************/
/*                     PROPOSITO                                               */
/* Crear un programa que permita revisar los cheques existentes para verificar */
/* los estados y según ellos, Aporbar o Rechazar.                              */
/*******************************************************************************/
/*                         MODIFICACIONES                                      */
/*    FECHA                    AUTOR                      RAZON                */
/* 18/JUN/2015             Jorge Zapata A.            Emisión inicial          */
/* 23/OCT/2015          Christian Padilla        Impuestos por efectivizacion  */
/* 02/AGO/2016          Tyrone Cruz              Incidencia #60783             */
/* 10/AGO/2016             Jorge Baque H.        USO EN COBIS CLOUD            */
/*******************************************************************************/

use cob_remesas
go


if exists (select * from sysobjects where name = 'sp_cheq_aprob_rechaz')
   drop proc sp_cheq_aprob_rechaz
go

create proc sp_cheq_aprob_rechaz (
    @s_ssn                      int,
    @s_ssn_branch          	    int 		        = null,
    @s_srv                      varchar(30),
    @s_lsrv                     varchar(30),
    @s_user                     login,
    @s_sesn                     int                 = null,
    @s_term                     varchar(32)         = null,
    @s_date                     datetime            = null,
    @s_ofi                      smallint            = null,
    @s_rol                      smallint            = null,
    @s_org                      char(1)             = null,
    @t_corr                     char(1)             = 'N',
    @t_ssn_corr                 int                 = null,
    @t_debug                    char(1)             = 'N',
    @t_file                     varchar(14)         = null,
    @t_from                     varchar(32)         = null,
    @t_trn                      int            = null,
    @t_show_version             bit                 = 0,
    @i_operacion                char(1),
    @i_modo                     int                 = null,
    @i_cuenta_operacion         varchar(25)         = null,
    @i_producto                 smallint            = null,
    @i_fecha                    date                = null,
    @i_oficina                  int                 = null,
    @i_filial                   tinyint             = null,
    @i_estado                   char(1)             = null,
    @i_regional                 varchar(10)         = null,
    @i_regional1                varchar(10)         = null,
    @i_regional2                varchar(10)         = null,
    @i_regional3                varchar(10)         = null,
    @i_regional4                varchar(10)         = null,
    @i_regional5                varchar(10)         = null,
    @i_regional6                varchar(10)         = null,
    @i_regional7                varchar(10)         = null,
    @i_regional8                varchar(10)         = null,
    @i_regional9                varchar(10)         = null,
    @i_regional10               varchar(10)         = null,
    @i_regional11               varchar(10)         = null,
    @i_regional12               varchar(10)         = null,
    @i_regional13               varchar(10)         = null,
    @i_regional14               varchar(10)         = null,
    @i_regional15               varchar(10)         = null,
    @i_secuencial               int                 = null,
    @i_ssn                      int                 = null,
    @i_secuencial_chq           smallint            = null,
    @i_formato_fecha            int                 = 101,
    @i_turno                    smallint            = null,
    @i_tipo                     varchar(1)          = null,
    @i_online                   char(1)             = 'S', --S-Obtiene secuencial de CTS, N-Obtiene secuenciales negativos
    @i_cta_banco                cuenta              = null,
    @i_causa                    varchar(3)          = null,
    @i_num_cheque               int                 = null,
    @i_valor_cheque             money               = null,
    @i_ofiorigen                smallint            = null,
    @i_fecha_cheque             date                = null,
    @i_dc_tipo                  varchar(10)         = null,
    @i_dc_co_banco              smallint            = null,
	@i_dif           			char(1)				= 'N',  --CMI
	@i_canal        			smallint    		= 4,	--CMI
    @o_request                  tinyint             = 0 out
)as

--Declaracion de variables de uso interno--
declare @w_return               int, 
        @w_sp_name              varchar(32),
        @w_alicuota             float,
        @w_moneda               tinyint,
        @w_cta_banco            cuenta,
        @w_valor_dep            money,
        @w_contable             money,
        @w_disponible           money,
        @w_12h                  money,
        @w_12h_dif              money,
        @w_24h                  money,
        @w_48h                  money,
        @w_tipo_promedio        varchar(3),
        @w_fecha_ult_upd        datetime,
        @w_cuenta               int,
        @w_ciudad               int,
        @w_oficina              smallint,
        @w_prom_disponible      money,
        @w_promedio1            money,
        @w_estado               char(1),
        @w_filial               tinyint,
        @w_mensaje              varchar(128),
        @w_prod_banc            smallint,
        @w_categoria            char(1),
        @w_decimales            char(1),
        @w_numdeci              tinyint,
        @w_error                int,
        @w_tipocta_super        char(1),
        @w_valdp_tot            money,
        @w_actualiza            char(1),
        @w_24h_efe              money,
        @w_valdp_ret            money,
        @w_total_chq            money,
        @w_retorno_ej           int,
        @w_rollback             char(1),
        @w_dep_ini              tinyint,
        @w_tipoefe              char(2),
        @w_regional             varchar(10),
        @w_fecha                varchar(10),
        @w_cta                  int,
        @w_signo                char(1),
        @w_lp_sec               int,
        @w_control              smallint,
        @w_prom_disp            money,
        @w_lineas               smallint,
        @w_tipo_prom            char(1),
        @w_remesas              money,
        @w_fldeci               char(1),
        @w_tipo_bloqueo         varchar(3),
        @w_tipo_ente            char(1),
        @w_rol_ente             char(1),
        @w_resto_24h            money,
        @w_personaliza          char(1),
        @w_comision             money,
        @w_tipo_def             char(1),
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_codigo               int,
        @w_mensaje_C            mensaje,
        @w_tipo_dir             char(1),
        @w_mail                 varchar(64),
        @w_ente                 int,
        @w_fecha_cheque         varchar(10),
        @w_moneda_chq           tinyint,
        @w_cta_cheque           varchar(50),
        @w_cod_bco              smallint,
        @w_nemo                 char(14),
        @w_numreg               int,
        @w_oficina_chq          smallint,
        @w_ssn                  int,
        @w_dc_tipo              varchar(10),
        @w_indicador            tinyint,
        @w_dc_secuencial        smallint,
        @w_dc_ssn               int,
        @w_cod_bco_char         varchar(10),
        @w_servidor             varchar(50),
        @w_tipocta              char(1),
        @w_cliente              int,
        @w_nombre               char(60),
        @w_genera_fac           char(1),
        @w_postea               char(1),
        @w_ssn_branch           int,
        @w_val_chq_dep          money,
        @w_procesadas           int,
        @w_valor_hoy_chqs       money,
        @w_oficina_chqs         smallint,
        @w_moneda_chqs          tinyint,
        @w_nemo2                char(4),
        @w_ncontrol             int,
        @w_lpend                int,
        @w_linpend              char(1),
        @w_alt_monet            int,
        @w_cod_alt              int,
        @w_cta_ing_caja         varchar(24),
        @w_cta_ing_caja_OK      tinyint,
		@w_dias_ret         	int,
		@w_fecha_efe          	smalldatetime,
		@w_fecha_depo			smalldatetime,
		@w_oficina_depo			smallint,
		@w_fecha_comp			smalldatetime,
		@w_proban_aporteord     int,
		@w_proban_aporteadic    int,
		@w_flag					tinyint,
		@w_debmes               money,
        @w_debhoy               money,
		@w_clase_clte           char(1)

--Captura nombre de Stored Procedure.---------------
select @w_sp_name   =  'sp_cheq_aprob_rechaz'

---- VERSIONAMIENTO DEL PROGRAMA -------------------
if @t_show_version = 1
begin
    print 'Stored Procedure=%1! Version=%2!' + @w_sp_name +  '4.0.0.2'
    return 0
end

--Validar Tipo de Transaccion.----------------------
if @t_trn != 150017
begin
    exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357021
        --no corresponde codigo de transaccion
    return 1
end

if @i_regional is null 
    select @w_regional = '99999'
else 
    select @w_regional = @i_regional

select @w_fecha = convert(varchar(10), @i_fecha, @i_formato_fecha)
select @w_fecha_comp = convert (datetime, @i_fecha, @i_formato_fecha)


if @i_operacion = 'Q' --consulta de registros
begin

    if @i_tipo = 'E' --solo para reporte para proceso de efectivizacion solo Chqs Locales
    begin
        select  '600001' = of_regional,
                '600002' = dc_oficina,
                '600003' = dc_producto,
                '600004' = count(dc_oficina),
                '600005' = sum(dc_valor),
                '600006' = (select mo_nemonico from cobis..cl_moneda where mo_moneda = dchq.dc_moneda)
        from  cob_remesas..re_detalle_cheque dchq, cobis..cl_oficina
        where dc_oficina  = of_oficina
        and   dc_estado   = 'I'
        and   dc_tipo     = '1'
        and  (of_regional = @i_regional or @i_regional is null)
        and  (dc_producto = @i_producto or @i_producto is null)
        and ((convert(varchar(10), dc_fecha_efe, @i_formato_fecha) = @w_fecha) or @i_fecha is null)
        group by of_regional, dc_oficina, dc_producto, dc_moneda
        order by of_regional, dc_oficina, dc_producto, dc_moneda

        -- if @@rowcount =  0
        -- begin
            -- exec cobis..sp_cerror
                -- @t_debug = @t_debug,
                -- @t_file  = @t_file,
                -- @t_from  = @w_sp_name,
                -- @i_num   = 357022
                -- --error, no existen registros
            -- return 1
        -- end
    end
    else
    begin
        if @i_tipo = 'R' --consulta la regional de la oficina de usuario
        begin
            select isnull(of_regional,'1')
            from   cobis..cl_oficina
            where  of_oficina = @i_oficina

            if @@rowcount =  0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 157958
                    --La oficina de conexión no tiene Regional
                return 1
            end
        end
        else --consulta para proceso de devolucion de cheques
        begin
            if exists (select 1 from cob_remesas..sysobjects where name='#cheques')
                drop table #cheques
            create table #cheques(
                secuencial      int identity not null,
                regional        varchar(10)      null,
                oficina         smallint         null,
                producto        tinyint          null,
                numCheque       int              null,
                ctaOperacion    varchar(24)      null,
                --ctaCheque       varchar(50)      null,
                estado          char(1)          null,
                valor           money            null,
                fecha           date             null,
                hora            datetime         null,
                tipoChq         varchar(15)      null,
                bancoChq        varchar(50)      null,
                monedaChq       tinyint          null,
                detMonedaChq    varchar(50)      null,
                fechaEfect      date             null,
                ssnChq          int              null,
                secuencialChq   smallint         null
            )
            
            insert into #cheques
            select
                of_regional,
                dc_oficina,
                dc_producto,
                dc_num_cheque,
                dc_cta_banco,
                --dc_cta_cheque,
                dc_estado,
                dc_valor,
                dc_fecha,
                dc_hora,
                case dc_tipo when '1' then 'Cheque Local' else 'Cheque Propio' end,
                dc_no_banco,
                dc_moneda,
                mo_descripcion,
                dc_fecha_efe,
                dc_ssn,
                dc_secuencial
            from  cob_remesas..re_detalle_cheque, cobis..cl_oficina, cobis..cl_moneda
            where dc_oficina    = of_oficina
            and   dc_moneda     = mo_moneda
            and  (of_regional   = @i_regional         or @i_regional         is null)
            and  (dc_producto   = @i_producto         or @i_producto         is null)
            and  (dc_cta_banco  = @i_cuenta_operacion or @i_cuenta_operacion is null)
            and  (dc_estado     = @i_estado           or @i_estado           is null)
            and  (dc_num_cheque = @i_num_cheque       or @i_num_cheque       is null)
            and  (dc_tipo       = @i_dc_tipo          or @i_dc_tipo          is null)
            and  (dc_co_banco   = @i_dc_co_banco      or @i_dc_co_banco      is null)
            and   dc_tipo      <> '2'
            and ((convert(varchar(10), dc_fecha, @i_formato_fecha) = @w_fecha) or @i_fecha is null)
            order by of_regional, dc_oficina, dc_co_banco, dc_cta_banco, dc_num_cheque

            -- if @@rowcount =  0
            -- begin
                -- exec cobis..sp_cerror
                    -- @t_debug = @t_debug,
                    -- @t_file  = @t_file,
                    -- @t_from  = @w_sp_name,
                    -- @i_num   = 357022
                    -- --error, no existen registros
                -- return 1
            -- end        

            --Consultar los registros existentes.
            set rowcount 20
            if @i_modo = 0
            begin
                select
                    '600007' = secuencial,
                    '600001' = regional,
                    '600008' = oficina,
                    '600003' = producto,
                    '600009' = numCheque,
                    '600010' = ctaOperacion,
                    '600011' = estado,
                    '600012' = valor,
                    '600013' = convert(char(10), fecha, @i_formato_fecha),
                    '600014' = convert(nvarchar,hora, 108),--substring(hora,13,7),
                    '600015' = tipoChq,
                    '600016' = bancoChq,
                    '600017' = monedaChq,
                    '600018' = detMonedaChq,
                    '600020' = convert(char(10), fechaEfect, @i_formato_fecha),
                    '600019' = ssnChq,
                    '600021' = secuencialChq
                from #cheques
                order by secuencial
            end
            else
            if @i_modo = 1
            begin
                select
                    '600007' = secuencial,
                    '600001' = regional,
                    '600008' = oficina,
                    '600003' = producto,
                    '600009' = numCheque,
                    '600010' = ctaOperacion,
                    '600011' = estado,
                    '600012' = valor,
                    '600013' = convert(char(10), fecha, @i_formato_fecha),
                    '600014' = convert(nvarchar,hora, 108),--substring(hora,13,7),
                    '600015' = tipoChq,
                    '600016' = bancoChq,
                    '600017' = monedaChq,
                    '600018' = detMonedaChq,
                    '600020' = convert(char(10), fechaEfect, @i_formato_fecha),
                    '600019' = ssnChq,
                    '600021' = secuencialChq
                from #cheques
                where convert(int,secuencial) > @i_secuencial
                order by secuencial
           end
        end
    end
end 


if @i_operacion = 'D' --devolucion de cheque
begin

    if (@i_causa is null) or (ltrim(@i_causa) = '') or (rtrim(@i_causa) = '')
    begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = 'CAUSA DE DEVOLUCION NO VALIDA',
            @i_num   = 258037
        return 1
    end
	
	select @w_proban_aporteord = pa_int
	  from cobis..cl_parametro
	 where pa_producto = 'AHO'
       and pa_nemonico = 'PCAASO'	

	if @@rowcount = 0
	begin
	    exec cobis..sp_cerror
        @i_num = 101254,
        @i_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DEL PRODUCTO BANCARIO DE APORTE SOCIAL ORDINARIO'
        return 101254
	end	   
	   
	   select @w_proban_aporteadic = pa_int
	  from cobis..cl_parametro
	 where pa_producto = 'AHO'
       and pa_nemonico = 'PCAASA'
	   
	   	if @@rowcount = 0
	begin
	    exec cobis..sp_cerror
        @i_num = 101254,
        @i_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DEL PRODUCTO BANCARIO DE APORTE SOCIAL ADICIONAL'
        return 101254
	end
	
    if (@i_producto = 3) --ctacteD
    begin
	
        --parametro de ingreso de caja  'CTEIC'
        select @w_cta_ing_caja  = pa_char
        from   cobis..cl_parametro
        where  pa_nemonico = 'CTEIC'
        and    pa_tipo     = 'C' 
        and    pa_producto = 'REM'
        if @@rowcount <> 1
        begin
           /* Error en codigo de transaccion */
           exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201196, --PARAMETRO NO ENCONTRADO
               @i_msg       = 'PARAMETRO NO ENCONTRADO CTEIC'
           return 1
        end
        
        --verifica si es una cuenta de ingreso de caja  'CTEIC'
        if @i_cta_banco = @w_cta_ing_caja
            select @w_cta_ing_caja_OK = 0
        else
            select @w_cta_ing_caja_OK = 1


        select  @w_total_chq     = @i_valor_cheque,
                @w_resto_24h     = 0,
                @w_mensaje       = null, 
                @w_mensaje_C     = null

        if @w_cta_ing_caja_OK = 1
        begin
            select  @w_cta           = cc_ctacte
            from    cob_cuentas..cc_ctacte
            where   cc_cta_banco     = @i_cta_banco
            
            select  @w_tipo_prom     = cc_tipo_promedio,
                    @w_12h           = cc_12h,
                    @w_disponible    = cc_disponible,
                    @w_promedio1     = cc_promedio1,
                    @w_prom_disp     = cc_prom_disponible,
                    @w_categoria     = cc_categoria,
                    @w_tipo_ente     = cc_tipocta,
                    @w_rol_ente      = cc_rol_ente,
                    @w_tipo_def      = cc_tipo_def,
                    @w_prod_banc     = cc_prod_banc,
                    @w_producto      = cc_producto,
                    @w_tipo          = cc_tipo,
                    @w_codigo        = cc_default,
                    @w_personaliza   = cc_personalizada,
                    @w_24h           = cc_24h,
                    @w_48h           = cc_48h,
                    @w_remesas       = cc_remesas,
                    @w_moneda        = cc_moneda,
                    @w_cta_banco     = cc_cta_banco,
                    @w_filial        = cc_filial,
                    @w_oficina       = cc_oficina,
                    @w_tipocta_super = cc_tipocta_super,
                    @w_mail          = cc_descripcion_dv,
                    @w_ente          = cc_cliente,
                    @w_moneda_chq    = dc_moneda,
                    @w_cta_cheque    = dc_cta_cheque,
                    @w_cod_bco       = dc_co_banco,
                    @w_ssn           = dc_ssn,
                    @w_dc_tipo       = dc_tipo
            from  cob_cuentas..cc_ctacte, cob_remesas..re_detalle_cheque
            where cc_cta_banco       = dc_cta_banco
            and   cc_ctacte          = @w_cta
            and   dc_producto        = @i_producto
            and   dc_num_cheque      = @i_num_cheque
            and   dc_valor           = @i_valor_cheque
            and   dc_estado          = 'I'
            and   cc_estado          = 'A' 
            
            if @@rowcount =  0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_msg   = 'CUENTA NO EXISTE O NO ESTA VIGENTE',
                    @i_num   = 258037
                return 1
            end
            
            select @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h + @w_remesas
            
            --Encuentra los decimales a utilizar
            select @w_fldeci = mo_decimales
            from   cobis..cl_moneda
            where  mo_moneda = @w_moneda
            
            if @w_fldeci = 'S'
            begin
                select @w_numdeci = pa_tinyint
                from cobis..cl_parametro
                where pa_producto = 'CTE'
                and pa_nemonico   = 'DCI'
            
                if @@rowcount =  0
                begin
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_msg   = 'PARAMETRO DE DECIMALES NO ENCONTRADO',
                        @i_num   = 708130
                    return 1
                end
            end
            else
                select @w_numdeci = 0
            
            --Determinacion de bloqueo de cuenta
            select @w_tipo_bloqueo = cb_tipo_bloqueo
            from   cob_cuentas..cc_ctabloqueada
            where  cb_cuenta       = @w_cta
            and    cb_estado       = 'V'
            and   (cb_tipo_bloqueo = '2' or cb_tipo_bloqueo = '3')
            
            if @@rowcount != 0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 201008
                return 1
            end
            
             --Encuentra alicuota del promedio
            select @w_alicuota      = fp_alicuota
            from   cob_cuentas..cc_fecha_promedio
            where  fp_tipo_promedio = @w_tipo_prom
            and convert(varchar(10), fp_fecha_inicio, @i_formato_fecha) = @w_fecha
            
            if @@rowcount = 0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 201060
                return 1
            end
            
            begin tran
                --Determinar el codigo de la ciudad de la compensacion
                select @w_ciudad  = of_ciudad
                from   cobis..cl_oficina
                where  of_oficina = @i_ofiorigen
            
                select @w_fecha_cheque = convert(varchar(10),
                       @i_fecha_cheque, @i_formato_fecha)
            
                if @w_dc_tipo = '1' --chq local
                begin 
                    --Comparo de w_24h el valor del cheque a devolver
                    if @i_valor_cheque <= @w_24h
                    begin
                        select  @w_24h      = @w_24h      - @i_valor_cheque, --Resto el valor del cheque del @w_24h
                                @w_contable = @w_contable - @i_valor_cheque
                    end
                    else
                    begin
                        rollback tran
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO cc_24h',
                            @i_num   = 201231
                        return 1
                    end
            
                    select @w_indicador = 2
            
                    --Actualizado Ciudad Deposito
                    /*update cob_cuentas..cc_ciudad_deposito
                    set    cd_valor     = cd_valor     - @i_valor_cheque,
                           cd_valor_efe = cd_valor_efe - @i_valor_cheque
                    where  cd_cuenta    = @w_cta
                    and    cd_ciudad    = @w_ciudad
                    and convert(varchar(10), cd_fecha_depo, @i_formato_fecha) = @w_fecha_cheque
                    and isnull(cd_efectivizado,'N') = 'N'
            
                    if @@rowcount = 0
                    begin
                        rollback tran
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 205049  --ERROR EN ACTUALIZACION DE DEPOSITO
                        return 1
                    end*/
            
                    --Transaccion para la nota de debito por cheque devuelto
                    update cob_cuentas..cc_ctacte
                    set    cc_24h           = @w_24h,
                           cc_fecha_ult_mov = @i_fecha,
                           cc_contador_trx  = cc_contador_trx + 1
                    where  cc_ctacte        = @w_cta
            
                    if @@rowcount != 1
                    begin
                        rollback tran
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 205001
                        return 1
                    end                
                end
            
                if @w_dc_tipo = '3' --chq propio
                begin 
                    --Comparo de w_12h el valor del cheque a devolver
                    if @i_valor_cheque <= @w_12h
                    begin
                        select  @w_12h      = @w_12h      - @i_valor_cheque, --Resto el valor del cheque del @w_12h
                                @w_contable = @w_contable - @i_valor_cheque
                    end
                    else
                    begin
                        rollback tran
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO cc_12h',
                            @i_num   = 201231
                        return 1
                    end
            
                    select @w_indicador = 1
            
                    --Transaccion para la nota de debito por cheque devuelto
                    update cob_cuentas..cc_ctacte
                    set    cc_12h           = @w_12h,
                           cc_fecha_ult_mov = @i_fecha,
                           cc_contador_trx  = cc_contador_trx + 1
                    where  cc_ctacte        = @w_cta
            
                    if @@rowcount != 1
                    begin
                        rollback tran
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 205001
                        return 1
                    end
                end
            
                --costos
                exec    @w_return      = cob_remesas..sp_genera_costos
                        @t_from        = @w_sp_name,
                        @i_valor       = 1,
                        @i_fecha       = @i_fecha,
                        @i_categoria   = @w_categoria,
                        @i_tipo_ente   = @w_tipo_ente,
                        @i_rol_ente    = @w_rol_ente,
                        @i_tipo_def    = @w_tipo_def,
                        @i_prod_banc   = @w_prod_banc,
                        @i_producto    = @w_producto,
                        @i_moneda      = @w_moneda,
                        @i_tipo        = @w_tipo,
                        @i_codigo      = @w_codigo,
                        @i_servicio    = 'CDEV',
                        @i_rubro       = '11',
                        @i_disponible  = @w_disponible,
                        @i_contable    = @w_contable,
                        @i_promedio    = @w_promedio1,
                        @i_prom_disp   = @w_prom_disp,
                        @i_personaliza = @w_personaliza,
                        @i_filial      = @w_filial,
                        @i_oficina     = @w_oficina,
                        @i_is_batch    = 'N',
                        @o_valor_total = @w_comision out
            
                    if @w_return != 0
                    begin
                        rollback tran
                        select @w_mensaje = mensaje from cobis..cl_errores where numero = @w_return
                        if @w_mensaje is null
                            select @w_mensaje = 'ERROR EN LA EJECUCION DE GENERACION DE COSTOS'
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_msg   = @w_mensaje,
                            @i_num   = 351548
                        return 1
                    end
            
                if @w_comision > 0
                begin 
                    --Comision
                    exec   @w_return     = cob_cuentas..sp_ccndc_automatica
                           @s_srv        = @s_srv,
                           @s_ssn        = @s_ssn,
                           @s_ssn_branch = @s_ssn,
                           @s_ofi        = @i_ofiorigen,
                           @s_rol        = @s_rol,
                           @s_user       = @s_user,
                           @s_term       = @s_term,
                           @t_trn        = 50,
                           @i_cta        = @w_cta_banco,
                           @i_val        = @w_comision,
                           @i_cau        = '16',
                           @i_mon        = @w_moneda,
                           @i_fecha      = @i_fecha,
                           @i_imp        = 'S',
                           @i_is_batch   = 'N',
                           @i_alt        = 2,
                           @i_nchq       = @i_num_cheque,
                           @i_prod_cobis = 3
            
                    if @w_return <> 0
                    begin
                        rollback tran
                        select @w_mensaje_C = mensaje  from cobis..cl_errores  where numero = @w_return
            
                        if @w_mensaje_C is null
                            select @w_mensaje_C = 'ERROR EN LA EJECUCION DE LA NOTA DE DEBITO - COMISION'
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_msg   = @w_mensaje_C,
                            @i_num   = 2902819
                        return 1
                    end
                end
            
                --Transaccion Monetaria para la nota de debito por cheque devuelto
               /* insert into cob_cuentas..cc_notcredeb
                           (secuencial, ssn_branch, tipo_tran, oficina,
                            usuario, terminal, correccion,
                            reentry, origen, nodo,
                            fecha, cta_banco, signo,
                            causa, val_cheque, valor,
                            moneda, sld_contable, nro_cheque,
                            sld_disponible, indicador, vcomision,
                            filial, oficina_cta,
                            prod_banc, categoria,
                            tipocta_super, turno, hora,
                            monto_imp, chq_locales)
                    values (@s_ssn, @s_ssn, 2502, @i_ofiorigen,
                            @s_user, @s_term, 'N',
                            'N', 'L', @s_srv,
                            @i_fecha, @w_cta_banco, 'D',
                            @i_causa, 0, 0,
                            @w_moneda, @w_contable, @i_num_cheque,
                            @w_disponible, @w_indicador, @w_comision,
                            @w_filial, @w_oficina,
                            @w_prod_banc, @w_categoria,
                            @w_tipocta_super, null, getdate(), 
                            0, @i_valor_cheque)
            
                if @@error != 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 203000
                    return 1
                end
            */
                --Actualizo estado a devuelto
                update cob_remesas..re_detalle_cheque
                set    dc_estado    = 'D'
                where  dc_cta_banco = @w_cta_banco
                and    dc_producto  = 3
                and    dc_ssn       = @w_ssn
                and    dc_tipo      = @w_dc_tipo
                and    dc_valor     = @i_valor_cheque
                and   (convert(varchar(10), dc_fecha, @i_formato_fecha)) = @w_fecha
                and    dc_estado    = 'I'
                if @@error <> 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 355013
                    return 1
                end
            
                --Insert en tabla re_cheque_rec
                exec @w_return    = cobis..sp_cseqnos
                     @t_debug     = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_tabla     = 're_cheque_rec',
                     @o_siguiente = @w_numreg out
                if @w_return != 0
                    return @w_return
            
                --Genera registro de cheque devuelto en tabla re_cheque_rec 
                insert into cob_remesas..re_cheque_rec
                            (cr_cheque_rec, cr_fecha_ing, cr_status, cr_cta_depositada,
                            cr_valor, cr_banco_p, cr_oficina_p,
                            cr_cta_girada, cr_num_cheque, cr_oficina, cr_procedencia,
                            cr_producto, cr_moneda, cr_cau_devolucion, cr_tipo_cheque,
                            cr_estado, cr_num_papeleta)
                values      (@w_numreg, @i_fecha, 'D', @w_cta,
                            @i_valor_cheque, @w_cod_bco, @i_ofiorigen,
                            @w_cta_cheque, @i_num_cheque, @s_ofi, 'V',
                            @i_producto, @w_moneda_chq, @i_causa, 'L',
                            'D', @s_ssn)
                if @@error != 0
                begin
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 203000
                    return 203000
                end
            
                -- -- Generamos mail informativo al cliente
                -- select @w_enviar_mail = 0
            
                -- select @w_mail = di_descripcion
                -- from cobis..cl_direccion 
                -- where di_ente = @w_ente
                -- and di_tipo = 'CE'
                -- and di_direccion = (select max(di_direccion)
                                    -- from cobis..cl_direccion 
                                    -- where di_tipo = 'CE'
                                    -- and di_ente = @w_ente
                                    -- )        
            
                -- if @@rowcount > 0
                    -- select @w_enviar_mail = 1
            
                -- if @w_enviar_mail = 1 
                -- begin
                    -- select @w_nombre_ente = en_nomlar
                    -- from cobis..cl_ente
                    -- where en_ente = @w_ente
            
                    -- select @w_institucion = em_descripcion 
                    -- from cob_conta..cb_empresa    
                    -- where em_empresa = @w_filial
            
                    -- select @w_nombanco = convert(varchar,@w_banco) + ' - ' + c.valor 
                    -- from cobis..cl_tabla t, cobis..cl_catalogo c
                    -- where t.tabla = 're_bancos_sinpe'
                    -- and t.codigo = c.tabla
                    -- and c.codigo = convert(varchar,@w_banco)
            
                    -- select  @w_devolucion = '('+@w_causa + ') ' + c.valor 
                    -- from cobis..cl_tabla t,cobis..cl_catalogo c
                    -- where t.tabla = 'cc_causa_dev'
                    -- and t.codigo = c.tabla
                    -- and c.codigo = @w_causa                    
            
                    -- --- Generacion de correo
                    -- select @w_aux_cheque = convert(char(10), @w_num_cheque)
            
                    -- select @w_ssn = @w_ssn + 1
                    -- exec @w_return = cob_bvirtual..sp_bv_ins_notificacion
                         -- @s_ssn          = @w_ssn,
                         -- @s_date         = @i_fecha,
                         -- @i_ente         = @w_ente,
                         -- @i_notificacion = 'N58',      --Codigo de la notificacion
                         -- @i_producto     = 18, --4,      --Codigo del producto
                         -- @i_num_prod     = @w_cta_banco,  --Numero de la operacion
                         -- @i_tipo_mensaje = 'F',        --Tipo de mensaje a enviar   
                         -- @i_c2           = @w_cta_banco,  
                         -- @i_f            = @i_fecha,
                         -- @i_aux1         = @w_nombre_ente,
                         -- @i_aux2         = @w_institucion,
                         -- @i_aux3         = @w_cta_girada, -- cuenta del banco x
                         -- @i_aux4         = @w_total_chq,  -- CC      
                         -- @i_aux5         = @w_aux_cheque,
                         -- @i_aux6         = @w_nombanco,
                         -- @i_aux7         = @w_devolucion,
                         -- @i_tercero      = @w_mail
            
                    -- if @w_return != 0
                    -- begin
                        -- print 'Procesando 21.....'                       
            
                        -- select @w_mensaje_N  = mensaje from cobis..cl_errores where numero = @w_return
            
                        -- if @w_mensaje_N is null 
                        -- begin
                            -- select @w_mensaje2 = 'ERROR EN NOTIFICACION: ' 
                            -- select @w_mensaje_N  = @w_mensaje2 + ' - PROD: ' + convert(char(2),@w_producto) + ' - CTA: ' + @w_cta_banco               
                        -- end   
            
                        -- if @i_batch_flag = 'S'
                        -- begin
                            -- exec @w_retorno_ej  = cobis..sp_ba_error_log
                                 -- @i_sarta         = @i_sarta,
                                 -- @i_batch         = @i_batch,
                                 -- @i_secuencial    = @i_secuencial,
                                 -- @i_corrida       = @i_corrida,
                                 -- @i_intento       = @i_intento,
                                 -- @i_num_operacion = @w_cta_banco,
                                 -- @i_error         = 258037,
                                 -- @i_detalle       = @w_mensaje_N
            
                            -- if @w_retorno_ej > 0
                            -- begin
                                -- print 'Error en grabacion de archivo de errores'
                                -- close ndchqdev
                                -- deallocate cursor ndchqdev      
                                -- select @o_procesadas = @w_procesadas
                                -- return 203035
                            -- end 
                        -- end
                        -- else
                        -- begin
                            -- print @w_mensaje_N
                        -- end
                    -- end
                -- end
            commit tran
        end
        else --cuenta de ingreso de caja  'CTEIC'
        begin
            begin tran
                --Obtengo datos de la tabla re_detalle_cheque
                select @w_total_chq  = dc_valor,
                       @w_oficina    = dc_oficina,
                       @w_moneda     = dc_moneda
                from cob_remesas..re_detalle_cheque
                where  dc_cta_banco  = @w_cta_ing_caja
                and    dc_producto   = 3
                and    dc_tipo       = '1'
                and    dc_ssn        = @i_ssn
                and    dc_secuencial = @i_secuencial_chq
                and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                and    dc_estado     = 'I'
                if @@error <> 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug     = @t_debug,
                        @t_file      = @t_file,
                        @t_from      = @w_sp_name,
                        @i_num       = 2902763, --NO SE PUEDE CONSULTAR ESTADO DEL CHEQUE
                        @i_msg       = 'NO SE PUEDE CONSULTAR ESTADO DEL CHEQUE'
                    return 1
                end

                --Actualizo estado a devuelto
                update cob_remesas..re_detalle_cheque
                set    dc_estado     = 'D'
                where  dc_cta_banco  = @w_cta_ing_caja
                and    dc_producto   = 3
                and    dc_tipo       = '1'
                and    dc_ssn        = @i_ssn
                and    dc_secuencial = @i_secuencial_chq
                and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                and    dc_estado     = 'I'
                if @@error <> 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 355013 --ERROR AL ACTUALIZAR CHQ. DE CAMARA
                    return 1
                end
                --------------------------------------------------------
                insert into cob_cuentas..cc_tran_servicio
                               (ts_secuencial,     ts_ssn_branch,    ts_tipo_transaccion,     ts_tsfecha,
                                ts_usuario,        ts_terminal,      ts_ctacte,               ts_filial,
                                ts_valor,          ts_oficina,       ts_oficina_cta,          ts_prod_banc,
                                ts_categoria,      ts_moneda,        ts_hora,                 ts_tipocta_super,
                                ts_turno,          ts_saldo,         ts_cta_banco,            ts_cod_alterno)
                        values (@s_ssn,            @s_ssn_branch,    723,                     @i_fecha,
                                @s_user,           @s_term,          null,                    @i_filial,
                                @w_total_chq,      @i_oficina,       @w_oficina,              0,
                                '0',               @w_moneda,        getdate(),               null,
                                3,                 null,             @w_cta_ing_caja,         0)
                if @@error <> 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 203005 -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                    return 1
                end
            commit tran
        end
    end --fin ctacteD

    if (@i_producto = 4) --ctaahoD
    begin
        select @w_total_chq = @i_valor_cheque,
               @w_signo     = 'D', 
               @w_resto_24h = 0,
               @w_mensaje   = null, 
               @w_mensaje_C = null

        select @w_cta       = ah_cuenta
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cta_banco
		
        select  @w_tipo_prom     = ah_tipo_promedio,
                @w_12h           = ah_12h,
                @w_disponible    = ah_disponible,
                @w_promedio1     = ah_promedio1,
                @w_prom_disp     = ah_prom_disponible,
                @w_categoria     = ah_categoria,
                @w_tipo_ente     = ah_tipocta,
                @w_rol_ente      = ah_rol_ente,
                @w_tipo_def      = ah_tipo_def,
                @w_prod_banc     = ah_prod_banc,
                @w_producto      = ah_producto,
                @w_tipo          = ah_tipo,
                @w_codigo        = ah_default,
                @w_personaliza   = ah_personalizada,
                @w_24h           = ah_24h,
                @w_remesas       = ah_remesas,
                @w_48h           = ah_48h,
                @w_moneda        = ah_moneda,
                @w_cta_banco     = ah_cta_banco,
                @w_lineas        = ah_linea,
                @w_tipocta_super = ah_tipocta_super,
                @w_filial        = ah_filial,
                @w_oficina       = ah_oficina,
                @w_mail          = ah_descripcion_dv,
                @w_ente          = ah_cliente,
                @w_moneda_chq    = dc_moneda,
                @w_cta_cheque    = dc_cta_cheque,
                @w_cod_bco       = dc_co_banco,
                @w_ssn           = dc_ssn,
                @w_dc_tipo       = dc_tipo,
				@w_debmes		 = ah_debitos,				--CMI
				@w_debhoy		 = ah_debitos_hoy,			--CMI
				@w_clase_clte    = ah_clase_clte,			--CMI
				@w_fecha_depo    = dc_fecha,				--CMI
				@w_oficina_depo  = dc_oficina,			    --CMI
				@w_dc_secuencial = dc_secuencial
        from  cob_ahorros..ah_cuenta, cob_remesas..re_detalle_cheque
        where ah_cta_banco       = dc_cta_banco
        and   ah_cuenta          = @w_cta
        and   dc_producto        = @i_producto
        and   dc_num_cheque      = @i_num_cheque
        and   dc_valor           = @i_valor_cheque
        and   dc_estado          = 'I'
        and   ah_estado          = 'A' 
		and   (dc_secuencial      = @i_secuencial or @i_secuencial is null)  --CMI para evitar el caso de 2 cheques con el mismo número y valor
		and   (dc_ssn             = @i_ssn  or @i_secuencial is null)        --CMI para evitar el caso de 2 cheques con el mismo número y valor

		
        if @@rowcount =  0
        begin
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_msg   = 'CUENTA NO EXISTE O NO ESTA VIGENTE',
                @i_num   = 258037
            return 1
        end
		
--CMI Otener la fecha de efectivización que se calculó cuando se hizo el depósito del cheque
      select                                                                                                                                                                                                                                                  
        @w_dias_ret = pa_tinyint
        from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'DIRE'

	

    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif   = 'N',
      @i_efec_dia  = 'S',
      @i_fecha     = @w_fecha_depo,
      @i_oficina   = @w_oficina_depo,
      @i_dif       = @i_dif,/**** Ingreso en  horario normal  ***/
      @w_dias_ret  = @w_dias_ret,/*** Dias siguientes habil ***/
      @o_ciudad    = @w_ciudad out,
      @o_fecha_sig = @w_fecha_efe out
	  
	  select @w_flag = 2 
	  
	  if @w_fecha_comp = @w_fecha_depo    --w_fecha es la fecha de hoy
	  begin	
			select @w_flag = 2    --Disminuye de 24H
	  end
	  else
	  begin
			if @w_fecha_comp < @w_fecha_efe
			begin	
				select @w_flag = 2    --Disminuye de 24H
			end
			else
			begin
				if @w_fecha_comp = @w_fecha_efe
				begin
					select @w_flag = 3   --Disminuye de 12h
				end
				else
				begin
					if @w_fecha_comp > @w_fecha_efe
					begin
						select @w_flag = 1   --Disminuye del Efectivo
					 end 
				end
			end
	  end

--CMI Fin Búsqueda de fecha de depósito del cheque

		
        select @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h + @w_remesas

        --Encuentra los decimales a utilizar
        select @w_fldeci = mo_decimales
        from cobis..cl_moneda
        where mo_moneda = 0

        if @w_fldeci = 'S'
        begin
            select @w_numdeci = pa_tinyint
            from cobis..cl_parametro
            where pa_producto = 'AHO'
            and pa_nemonico = 'DCI'

            if @@rowcount =  0
            begin
				
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_msg   = 'PARAMETRO DE DECIMALES NO ENCONTRADO',
                    @i_num   = 708130
                return 1
            end
        end
        else
            select @w_numdeci = 0

		if @w_prod_banc not in (@w_proban_aporteord, @w_proban_aporteadic)	 --CMI las ctas de aporte social se bloquean contra retiro desde la apertura
																			 --por lo que no se valida el bloqueo porque se debe permitir devolver cheque
		begin
			--Determinacion de bloqueo de cuenta
			select @w_tipo_bloqueo = cb_tipo_bloqueo
			from   cob_ahorros..ah_ctabloqueada
			where  cb_cuenta       = @w_cta
			and    cb_estado       = 'V'
			and   (cb_tipo_bloqueo = '2' or cb_tipo_bloqueo = '3')

			if @@rowcount != 0
			begin

				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_num   = 201008
				return 1
			end
		end

        --Encuentra alicuota del promedio
        select @w_alicuota      = fp_alicuota
        from   cob_ahorros..ah_fecha_promedio
        where  fp_tipo_promedio = 'M'
        and convert(varchar(10), fp_fecha_inicio, @i_formato_fecha) = @w_fecha

        if @@rowcount = 0
        begin
		
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 201060
            return 1
        end

        begin tran
            --Determinar el codigo de la ciudad de la compensacion
            select @w_ciudad  = of_ciudad
            from   cobis..cl_oficina
            where  of_oficina = @i_ofiorigen

            select @w_fecha_cheque = convert(varchar(10),
                   @i_fecha_cheque, @i_formato_fecha),
                   @w_lineas = @w_lineas + 1

            if @w_dc_tipo = '1' --chq local
            begin
				if @w_flag = 2    --CMI rebaja de 24H
				begin
                --Comparo de w_24h el valor del cheque a devolver
					if @i_valor_cheque <= @w_24h
					begin
						select  @w_24h      = @w_24h      - @i_valor_cheque, --Resto el valor del cheque del @w_24h
								@w_indicador = 2
					end
					else
					begin
						rollback tran
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @w_sp_name,
						@i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO ah_24',
						@i_num   = 201231
						return 1
					end
				
					--Actualizado Ciudad Deposito
					update cob_ahorros..ah_ciudad_deposito
					set    cd_valor     = cd_valor     - @i_valor_cheque,
						cd_valor_efe = cd_valor_efe - @i_valor_cheque
					where  cd_cuenta    = @w_cta
					and    cd_ciudad    = @w_ciudad
					and convert(varchar(10), cd_fecha_depo, @i_formato_fecha) = @w_fecha_cheque
					and isnull(cd_efectivizado,'N') = 'N'

					if @@rowcount = 0
					begin
						rollback tran
						exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 205049  --ERROR EN ACTUALIZACION DE DEPOSITO
						return 1
					end
				end  --CMI w_flag = 2

				--CMI aumenta parte para considerar otros indicadores
				if @w_flag = 1   ---debe rebajar del disponible
				begin
					if @i_valor_cheque <= @w_disponible
					begin
						select @w_disponible = @w_disponible - @i_valor_cheque, --Resto el valor del cheque del @w_disponible
							   @w_indicador = 1
					end
					else
					begin
						rollback tran
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @w_sp_name,
						@i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO ah_disponible',
						@i_num   = 251051
						return 1
					end
				end
				if @w_flag = 3    --debe rebajar de 12h
				begin
					if @i_valor_cheque <= @w_12h
					begin
						select  @w_12h      = @w_12h - @i_valor_cheque, --Resto el valor del cheque del @w_12h
                           	    @w_indicador = 2
					end
					else
					begin
						rollback tran
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @w_sp_name,
						@i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO ah_12',
						@i_num   = 201231
						return 1
					end
				end
				
				if @w_flag = 1
				begin
					select @w_promedio1 = @w_promedio1 - @w_alicuota
					select @w_prom_disp = @w_prom_disp - @w_alicuota
				end
   
				select @w_debmes = @w_debmes + @i_valor_cheque ,
					   @w_debhoy = @w_debhoy + @i_valor_cheque ,
					   @w_contable = @w_contable - @i_valor_cheque
						   
				--Actualiza datos del maestro de cuenta
                update cob_ahorros..ah_cuenta
                set   ah_24h            = @w_24h,
                      ah_fecha_ult_mov  = @i_fecha,
                      ah_contador_trx   = ah_contador_trx + 1,
                      ah_linea          = @w_lineas,
					  ah_debitos        = @w_debmes,
                      ah_debitos_hoy    = @w_debhoy,
			          ah_disponible     = @w_disponible,
                      ah_promedio1      = @w_promedio1, 
                      ah_prom_disponible= @w_prom_disp,
                      ah_12h            = @w_12h
                where ah_cuenta         = @w_cta

                if @@rowcount != 1
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 255001
                    return 1
                end
				--CMI FIN aumenta parte para considerar otros indicadores

            end   --FIN @w_dc_tipo = '1' --chq local

            if @w_dc_tipo = '3' --chq propio
            begin
                --Comparo de w_12h el valor del cheque a devolver
                if @i_valor_cheque <= @w_12h
                begin
                    select  @w_12h      = @w_12h      - @i_valor_cheque, --Resto el valor del cheque del @w_12h
                            @w_contable = @w_contable - @i_valor_cheque
                end
                else
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_msg   = 'VALOR DEL CHEQUE EXCEDE EL CAMPO ah_12h',
                        @i_num   = 201231
                    return 1
                end

                select @w_indicador = 1

                --Transaccion para la nota de debito por cheque devuelto
                update cob_ahorros..ah_cuenta
                set   ah_12h           = @w_12h,
                      ah_fecha_ult_mov = @i_fecha,
                      ah_contador_trx  = ah_contador_trx + 1,
                      ah_linea         = @w_lineas
                where ah_cuenta        = @w_cta

                if @@rowcount != 1
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 255001
                    return 1
                end
            end

            --Grabacion de Linea Pendiente por monto de cheque Devuelto
            --Genera numero de Control para linea de libreta
            exec @w_return    = cobis..sp_cseqnos
                 @t_debug     = null,
                 @t_file      = null,
                 @t_from      = @w_sp_name,
                 @i_tabla     = 'ah_control',
                 @o_siguiente = @w_control out

            if @w_return <> 0 
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355004
                return 1
            end   

            if @w_control > 9999
            begin
                select @w_control = 0

                update cobis..cl_seqnos
                set siguiente = 0
                where tabla   = 'ah_control'

                if @@rowcount = 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 255005
                    return 1
                end
            end

            --Genera numero de linea Pendiente 
            exec @w_return    = cobis..sp_cseqnos
                 @t_debug     = null,
                 @t_file      = null,
                 @t_from      = @w_sp_name,
                 @i_tabla     = 'ah_lpendiente',
                 @o_siguiente = @w_lp_sec out

            if @w_return <> 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355004
                return 1
            end

            if @w_lp_sec  > 2147483640
            begin
                select @w_lp_sec  = 1

                update cobis..cl_seqnos
                set siguiente = @w_lp_sec
                where tabla   = 'ah_lpendiente'

                if @@rowcount != 0
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 105001
                    return 1
                end
            end

            --Determina el nemonico de la Transaccion
            select @w_nemo     = tn_nemonico
            from   cobis..cl_ttransaccion
            where  tn_trn_code = 2502

            --Inserta en Lineas Pendientes
            if @i_valor_cheque > 0
            begin
                insert into cob_ahorros..ah_linea_pendiente
                           (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                            lp_fecha, lp_control, lp_signo, lp_enviada)
                values     (@w_cta, @w_lp_sec, @w_nemo, @i_valor_cheque,
                            @i_fecha, @w_control, @w_signo, 'N')

                if @@rowcount != 1
                begin
                    rollback tran
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 253002
                    return 1
                end
            end
			
			
            --Costos
            exec @w_return      = cob_remesas..sp_genera_costos
                 @t_debug       = 'S',
                 @t_file        = null,
                 @t_from        = @w_sp_name,
                 @i_valor       = 1,
                 @i_fecha       = @i_fecha,
                 @i_categoria   = @w_categoria,
                 @i_tipo_ente   = @w_tipo_ente,
                 @i_rol_ente    = @w_rol_ente,
                 @i_tipo_def    = @w_tipo_def,
                 @i_prod_banc   = @w_prod_banc,
                 @i_producto    = @w_producto,
                 @i_moneda      = @w_moneda,
                 @i_tipo        = @w_tipo,
                 @i_codigo      = @w_codigo,
                 @i_servicio    = 'CDEV',
                 @i_rubro       = '11',
                 @i_disponible  = @w_disponible,
                 @i_contable    = @w_contable,
                 @i_promedio    = @w_promedio1,
                 @i_prom_disp   = @w_prom_disp,
                 @i_personaliza = @w_personaliza,
                 @i_filial      = @w_filial,
                 @i_oficina     = @w_oficina,
                 @i_batch       = 'N',
                 @o_valor_total = @w_comision out

            if @w_return != 0
            begin
                rollback tran
                select @w_mensaje = mensaje from cobis..cl_errores where numero = @w_return
                if @w_mensaje is null
                    select @w_mensaje = 'ERROR EN LA EJECUCION DE GENERACION DE COSTOS'
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_msg   = @w_mensaje,
                    @i_num   = 351548
                return 1
            end
			
            if @w_comision > 0
            begin 
                --Comision
                exec   @w_return     = cob_ahorros..sp_ahndc_automatica 
                       @s_srv        = @s_srv,
                       @s_ssn        = @s_ssn,
                       @s_ssn_branch = @s_ssn,
                       @s_ofi        = @i_ofiorigen,
                       @s_rol        = @s_rol,
                       @s_user       = @s_user,
                       @s_term       = @s_term,
                       @t_trn        = 264,
                       @i_cta        = @w_cta_banco,
                       @i_val        = @w_comision,
                       @i_cau        = '4',
                       @i_mon        = @w_moneda,
                       @i_fecha      = @i_fecha,
                       @i_imp        = 'S',
                       @i_is_batch   = 'N',
                       @i_alt        = 2,
                       @i_cheque     = @i_num_cheque--,
                       --@i_prod_cobis = null

                if @w_return <> 0
                begin
                    rollback tran
                    select @w_mensaje_C = mensaje  from cobis..cl_errores  where numero = @w_return

                    if @w_mensaje_C is null
                        select @w_mensaje_C = 'ERROR EN LA EJECUCION DE LA NOTA DE DEBITO - COMISION'
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_msg   = @w_mensaje_C,
                        @i_num   = 2902819
                    return 1
                end
            end
						
	      --Transaccion Monetaria para la nota de debito por cheque devuelto
    
			insert into cob_ahorros..ah_notcredeb
             (secuencial,     ssn_branch,   tipo_tran,  oficina,   alterno,
              usuario,        terminal,     correccion,            
              sec_correccion, reentry,      origen,                
              nodo,           fecha,        cta_banco,  signo,     causa,     val_cheque,
              valor,          remoto_ssn,   moneda,     saldocont, indicador,
              saldodisp,      departamento, filial,     
              banco,          oficina_cta,  prod_banc,  categoria,
              tipocta_super,  turno,        hora,
              canal,          cliente,      clase_clte)  
      values (@s_ssn,           @s_ssn,     240,          @i_ofiorigen, 1,
              @s_user,          @s_term,    'N',
              null,             'N',        'L',
              @s_srv,           @i_fecha,  @w_cta_banco, @w_signo, @i_causa, @i_valor_cheque,
              @i_valor_cheque,         null,       @w_moneda,    @w_contable, @w_indicador,
              @w_disponible,    null,    @w_filial,
              null,             @w_oficina, @w_prod_banc, @w_categoria,
              @w_tipocta_super, null,   getdate(),
              @i_canal,         @w_ente, @w_clase_clte)


            if @@error != 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 203000
                return 1
            end

            --Actualizo estado a devuelto
            update cob_remesas..re_detalle_cheque
            set    dc_estado    = 'D'
            where  dc_cta_banco = @w_cta_banco
            and    dc_producto  = 4
            and    dc_ssn       = @w_ssn
            and    dc_tipo      = @w_dc_tipo
            and    dc_valor     = @i_valor_cheque
            and   (convert(varchar(10), dc_fecha, @i_formato_fecha)) = @w_fecha_depo
			and    dc_secuencial = @w_dc_secuencial
            and    dc_estado    = 'I'
            if @@error <> 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355013
                return 1
            end

            --Insert en tabla re_cheque_rec
            exec @w_return    = cobis..sp_cseqnos
                 @t_debug     = @t_debug,
                 @t_file      = @t_file,
                 @t_from      = @w_sp_name,
                 @i_tabla     = 're_cheque_rec',
                 @o_siguiente = @w_numreg out
            if @w_return != 0
                return @w_return

            --Genera registro de cheque devuelto en tabla re_cheque_rec 
            insert into cob_remesas..re_cheque_rec
                       (cr_cheque_rec, cr_fecha_ing, cr_status, cr_cta_depositada,
                        cr_valor, cr_banco_p, cr_oficina_p,
                        cr_cta_girada, cr_num_cheque, cr_oficina, cr_procedencia,
                        cr_producto, cr_moneda, cr_cau_devolucion, cr_tipo_cheque,
                        cr_estado, cr_num_papeleta)
            values     (@w_numreg, @i_fecha, 'D', @w_cta,
                        @i_valor_cheque, @w_cod_bco, @i_ofiorigen,
                        @w_cta_cheque, @i_num_cheque, @s_ofi, 'V',
                        @i_producto, @w_moneda_chq, @i_causa, 'L',
                        'D', @s_ssn)
            if @@error != 0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 203000
                return 203000
            end

            -- -- Generamos mail informativo al cliente
            -- select @w_enviar_mail = 0

            -- select @w_mail = di_descripcion
            -- from cobis..cl_direccion 
            -- where di_ente = @w_ente
            -- and di_tipo = 'CE'
            -- and di_direccion = (select max(di_direccion)
                                -- from cobis..cl_direccion 
                                -- where di_tipo = 'CE'
                                -- and di_ente = @w_ente
                                -- )        

            -- if @@rowcount > 0
                -- select @w_enviar_mail = 1

            -- if @w_enviar_mail = 1 
            -- begin
                -- select @w_nombre_ente = en_nomlar
                -- from cobis..cl_ente
                -- where en_ente = @w_ente

                -- select @w_institucion = em_descripcion 
                -- from cob_conta..cb_empresa    
                -- where em_empresa = @w_filial

                -- select @w_nombanco = convert(varchar,@w_banco) + ' - ' + c.valor 
                -- from cobis..cl_tabla t, cobis..cl_catalogo c
                -- where t.tabla = 're_bancos_sinpe'
                -- and t.codigo = c.tabla
                -- and c.codigo = convert(varchar,@w_banco)

                -- select  @w_devolucion = '('+@w_causa + ') ' + c.valor 
                -- from cobis..cl_tabla t,cobis..cl_catalogo c
                -- where t.tabla = 'cc_causa_dev'
                -- and t.codigo = c.tabla
                -- and c.codigo = @w_causa                    

                -- --- Generacion de correo
                -- select @w_aux_cheque = convert(char(10), @w_num_cheque)

                -- select @w_ssn = @w_ssn + 1
                -- exec @w_return = cob_bvirtual..sp_bv_ins_notificacion
                     -- @s_ssn          = @w_ssn,
                     -- @s_date         = @i_fecha,
                     -- @i_ente         = @w_ente,
                     -- @i_notificacion = 'N58',      --Codigo de la notificacion
                     -- @i_producto     = 18, --4,      --Codigo del producto
                     -- @i_num_prod     = @w_cta_banco,  --Numero de la operacion
                     -- @i_tipo_mensaje = 'F',        --Tipo de mensaje a enviar   
                     -- @i_c2           = @w_cta_banco,  
                     -- @i_f            = @i_fecha,
                     -- @i_aux1         = @w_nombre_ente,
                     -- @i_aux2         = @w_institucion,
                     -- @i_aux3         = @w_cta_girada, -- cuenta del banco x
                     -- @i_aux4         = @w_total_chq,  -- CC      
                     -- @i_aux5         = @w_aux_cheque,
                     -- @i_aux6         = @w_nombanco,
                     -- @i_aux7         = @w_devolucion,
                     -- @i_tercero      = @w_mail

                -- if @w_return != 0
                -- begin
                    -- print 'Procesando 21.....'                       

                    -- select @w_mensaje_N  = mensaje from cobis..cl_errores where numero = @w_return

                    -- if @w_mensaje_N is null 
                    -- begin
                        -- select @w_mensaje2 = 'ERROR EN NOTIFICACION: ' 
                        -- select @w_mensaje_N  = @w_mensaje2 + ' - PROD: ' + convert(char(2),@w_producto) + ' - CTA: ' + @w_cta_banco               
                    -- end   

                    -- if @i_batch_flag = 'S'
                    -- begin
                        -- exec @w_retorno_ej  = cobis..sp_ba_error_log
                             -- @i_sarta         = @i_sarta,
                             -- @i_batch         = @i_batch,
                             -- @i_secuencial    = @i_secuencial,
                             -- @i_corrida       = @i_corrida,
                             -- @i_intento       = @i_intento,
                             -- @i_num_operacion = @w_cta_banco,
                             -- @i_error         = 258037,
                             -- @i_detalle       = @w_mensaje_N

                        -- if @w_retorno_ej > 0
                        -- begin
                            -- print 'Error en grabacion de archivo de errores'
                            -- close ndchqdev
                            -- deallocate cursor ndchqdev      
                            -- select @o_procesadas = @w_procesadas
                            -- return 203035
                        -- end 
                    -- end
                    -- else
                    -- begin
                        -- print @w_mensaje_N
                    -- end
                -- end
            -- end
        commit tran
    end --fin ctaahoD

    if (@i_producto = 14) --dpfD
    begin
        begin tran

            select @w_fecha_cheque = convert(varchar(10), @i_fecha_cheque, @i_formato_fecha)

            select  @w_ssn           = dc_ssn,
                    @w_dc_secuencial = dc_secuencial,
                    @w_cod_bco       = dc_co_banco,
                    @w_cta_cheque    = dc_cta_cheque,
                    @w_dc_tipo       = dc_tipo,
                    @w_moneda_chq    = dc_moneda
            from  cob_remesas..re_detalle_cheque
            where dc_valor           = @i_valor_cheque
            and   dc_cta_banco       = @i_cta_banco
            and   dc_num_cheque      = @i_num_cheque
            and   dc_oficina         = @i_ofiorigen
            and   dc_producto        = @i_producto
            and   dc_estado          = 'I'
            and   convert(varchar(10), dc_fecha, @i_formato_fecha) = @w_fecha_cheque

            if @@rowcount =  0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 357022
                    --error, no existen registros
                return 1
            end

            select @w_cod_bco_char = convert( varchar,@w_cod_bco)
            
            exec    @w_return = cob_pfijo..sp_fpago_prob
                    @s_ssn        = @s_ssn,           --- secuencial del central
                    @s_user       = @s_user,          --- login del usuario
                    @s_date       = @i_fecha,         --- fecha de proceso
                    @s_term       = @s_term,          --- terminal
                    @t_trn        = 14139,            --- enviar siempre 14139
                    @i_num_banco  = @i_cta_banco,     --- numero de cuenta del deposito a plazo
                    @i_operacion  = 'I',              --- enviar siempre I (ingreso)
                    @i_ssn        = @w_ssn,           --- ssn de la tabla de detalle de cheques   --dc_ssn
                    @i_secuencial = @w_dc_secuencial, --- secuencial del cheque                   --dc_secuencial
                    @i_banco      = @w_cod_bco_char,  --- codigo del banco (puede ser null, para el caso de cheques del exterior CHQE)
                    @i_cuenta     = @w_cta_cheque,    --- numero de cuenta del cheque
                    @i_cheque     = @i_num_cheque,    --- numero de cheque
                    @i_valor      = @i_valor_cheque,  --- valor del cheque
                    @i_fpago      = @w_dc_tipo,       --- dc_tipo 1:cheque propio 2: otras plazas, remesas, exterior 3: cheque local
                    @i_moneda     = @w_moneda_chq,    --- codigo de moneda
                    @i_caja       = 'S'               --- enviar siempre S
            
            if @w_return != 0 
            begin
                rollback tran
                
            end
            --Actualizo estado a devuelto
            update cob_remesas..re_detalle_cheque
            set    dc_estado    = 'D'
            where dc_valor      = @i_valor_cheque
            and   dc_cta_banco  = @i_cta_banco
            and   dc_num_cheque = @i_num_cheque
            and   dc_oficina    = @i_ofiorigen
            and   dc_producto   = @i_producto
            and   dc_estado     = 'I'
            and   convert(varchar(10), dc_fecha, @i_formato_fecha) = @w_fecha_cheque
            if @@error <> 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355013
                return 1
            end

        commit tran
    end --fin dpfD
    if (@i_producto = 10) --RECAUDOS Y REMESAS
    begin
        begin tran

            select @w_fecha_cheque = convert(varchar(10), @i_fecha_cheque, @i_formato_fecha)

            select  @w_ssn           = dc_ssn,
                    @w_dc_secuencial = dc_secuencial,
                    @w_cod_bco       = dc_co_banco,
                    @w_cta_cheque    = dc_cta_cheque,
                    @w_dc_tipo       = dc_tipo,
                    @w_moneda_chq    = dc_moneda
            from  cob_remesas..re_detalle_cheque
            where dc_valor           = @i_valor_cheque
            and   dc_cta_banco       = @i_cta_banco
            and   dc_num_cheque      = @i_num_cheque
            and   dc_oficina         = @i_ofiorigen
            and   dc_producto        = @i_producto
            and   dc_estado          = 'I'
            and   convert(varchar(10), dc_fecha, @i_formato_fecha) = @w_fecha_cheque

            if @@rowcount =  0
            begin
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 357022
                    --error, no existen registros
                return 1
            end

            select @w_cod_bco_char = convert( varchar,@w_cod_bco)
            
            --Actualizo estado a devuelto
            update cob_remesas..re_detalle_cheque
            set    dc_estado    = 'D'
            where dc_valor      = @i_valor_cheque
            and   dc_cta_banco  = @i_cta_banco
            and   dc_num_cheque = @i_num_cheque
            and   dc_oficina    = @i_ofiorigen
            and   dc_producto   = @i_producto
            and   dc_estado     = 'I'
            and   convert(varchar(10), dc_fecha, @i_formato_fecha) = @w_fecha_cheque
            if @@error <> 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355013
                return 1
            end

        commit tran
    end --fin RECAUDOS Y REMESAS    
end


if @i_operacion = 'V' --Verifica si el proceso ya fue ejecutado en una fecha dada FIE
begin
    if @i_regional is null
    begin
        if (@i_regional1 is not null)
        begin 
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional1
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional2 is not null)
        begin 
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional2
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional3 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional3
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional4 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional4
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional5 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional5
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional6 is not null)
        begin 
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional6
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional7 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional7
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional8 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional8
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional9 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional9
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional10 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional10
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional11 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional11
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional12 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional12
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional13 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional13
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional14 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional14
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
        if (@i_regional15 is not null)
        begin
            if exists (select 1 from cob_remesas..re_efectiviza_regional
            where er_producto = @i_producto
            and   er_regional = @i_regional15
            and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
            begin
                select @o_request = 1
                select @o_request
                return 0
            end
        end
    end
    begin
        if exists  (select 1 from cob_remesas..re_efectiviza_regional
                    where er_producto = @i_producto
                    and   er_regional = @w_regional
                    and   convert(varchar(10), er_fecha, @i_formato_fecha) = @w_fecha)
        begin
            select @o_request = 1
            select @o_request
            return 0
        end
    end
end


if @i_operacion = 'E' --Efectivización de cheque
begin
    if not exists (select 1 from cobis..cl_filial
        where fi_filial = @i_filial)
    begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101002
            --error, no existe filial
        return 101002
    end
    /*  Determinacion si se graba S. DISP o CONT en LP  */
    select @w_linpend = pa_char
      from cobis..cl_parametro
     where pa_nemonico = 'DISLP'
       and pa_producto = 'REM'
    if @@rowcount <> 1
    begin
       /* Error en codigo de transaccion */
       exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196,
           @i_msg       = 'ERROR EN LECTURA DE PARAMETRO PARA LINEA PENDIENTE'
       return 1
    end

    if (@i_producto = 3) --ctacteE
    begin
        --parametro de ingreso de caja  'CTEIC'
        select @w_cta_ing_caja  = pa_char
        from   cobis..cl_parametro
        where  pa_nemonico = 'CTEIC'
        and    pa_tipo     = 'C' 
        and    pa_producto = 'REM'
        if @@rowcount <> 1
        begin
           /* Error en codigo de transaccion */
           exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201196, --PARAMETRO NO ENCONTRADO
               @i_msg       = 'PARAMETRO NO ENCONTRADO CTEIC'
           return 1
        end

        --Tabla temporal para almacenar los cheques por efectivizar
        if exists (select 1 from cob_remesas..sysobjects where name='#ccdetallechqs')
            drop table #ccdetallechqs
        create table #ccdetallechqs(
                     cdd_cta_banco     varchar(24),
                     cdd_valor_hoy     money,
                     cdd_oficina_chq   smallint,
                     cdd_moneda        tinyint,
                     cdd_ssn           int,
                     cdd_secuencial    smallint)
        if @@error <> 0
        begin
            select @w_error = 703105
            goto ERRORFINCTE
        end

        create clustered index idx1 on #ccdetallechqs(cdd_cta_banco)

        --Se insertan valores a efectivizar hoy
        insert into #ccdetallechqs
        select dc_cta_banco, dc_valor, dc_oficina, dc_moneda, dc_ssn, dc_secuencial
        from   cob_remesas..re_detalle_cheque, cobis..cl_oficina
        where dc_oficina  = of_oficina
        and convert(varchar(10), dc_fecha_efe, @i_formato_fecha) = @w_fecha
        and   dc_estado   = 'I'
        and   dc_tipo     = '1'
        and  (of_regional = @i_regional or @i_regional is null)
        and   dc_producto = @i_producto

        select @w_procesadas = 0, @w_rollback   = 'N', @w_alt_monet = 0, @w_cod_alt = 0

        --Cursor principal
        declare cur_24h cursor for
        select  cdd_cta_banco,
                cdd_valor_hoy,
                cdd_oficina_chq,
                cdd_moneda,
                cdd_ssn,
                cdd_secuencial
        from #ccdetallechqs
        group by cdd_cta_banco

        open cur_24h
        fetch cur_24h into @w_cta_banco,
                           @w_valor_hoy_chqs,
                           @w_oficina_chqs,
                           @w_moneda_chqs,
                           @w_dc_ssn,
                           @w_dc_secuencial

        while (@@FETCH_STATUS = 0)
        begin
            begin tran
                select @w_rollback  = 'S'
                --Inicializo variables de trabajo
                select @w_24h_efe   = 0,
                       @w_actualiza = '',
                       @w_total_chq = 0,
                       @w_error     = 0

                --verifica si es una cuenta de ingreso de caja  'CTEIC'
                if @w_cta_banco = @w_cta_ing_caja
                    select @w_cta_ing_caja_OK = 0
                else
                    select @w_cta_ing_caja_OK = 1

                if @w_cta_ing_caja_OK = 1
                begin
                    --Obtengo datos de trabajo de la cuenta corriente
                    select @w_disponible         = cc_disponible,
                           @w_12h                = isnull(cc_12h, 0),
                           @w_12h_dif            = isnull(cc_12h_dif, 0),
                           @w_24h                = isnull(cc_24h, 0),
                           @w_48h                = isnull(cc_48h, 0),
                           @w_tipo_promedio      = cc_tipo_promedio,
                           @w_fecha_ult_upd      = cc_fecha_ult_upd,
                           @w_cuenta             = cc_ctacte,
                           @w_oficina            = cc_oficina,
                           @w_prom_disponible    = cc_prom_disponible,
                           @w_promedio1          = cc_promedio1,
                           @w_estado             = cc_estado,
                           @w_moneda             = cc_moneda,
                           @w_categoria          = cc_categoria,
                           @w_prod_banc          = cc_prod_banc,
                           @w_filial             = cc_filial,
                           @w_tipocta_super      = cc_tipocta_super,
                           @w_dep_ini            = cc_dep_ini,
                           @w_tipocta            = cc_tipocta,
                           @w_cliente            = cc_cliente,
                           @w_nombre             = cc_nombre,
                           @w_remesas            = cc_remesas
                    from cob_cuentas..cc_ctacte
                    where cc_cta_banco = @w_cta_banco
                    if @@rowcount = 0
                    begin
                        select @w_error = 141047  --No existe cuenta corriente
                        goto SIGUIENTECTE
                    end
                    
                    /* Obtener Decimales de la Moneda */
                    select @w_decimales = mo_decimales
                    from cobis..cl_moneda
                    where mo_moneda = @w_moneda
                    if @w_decimales = 'S'
                        select @w_numdeci = isnull(pa_tinyint,0)
                        from cobis..cl_parametro
                        where pa_producto = 'CTE'
                        and pa_nemonico = 'DCI'
                    else
                        select @w_numdeci = 0
                    
                    /* Obtener Alicuota para el Promedio */
                    select @w_alicuota     = fp_alicuota
                    from cob_cuentas..cc_fecha_promedio
                    where fp_tipo_promedio = @w_tipo_promedio
                    and convert(varchar(10), fp_fecha_inicio, @i_formato_fecha) = @w_fecha
                    if @@rowcount = 0
                    begin
                        select @w_error = 251013
                        goto ERRORFINCTE
                    end
                    
                    --Obtener ciudad del chq
                    select @w_ciudad = of_ciudad
                    from cobis..cl_oficina
                    where of_oficina = @w_oficina_chqs
                    if @@rowcount = 0
                    begin
                        select @w_error = 8300006 --NO EXISTE CIUDAD DE LA OFICINA
                        goto ERRORFINCTE
                    end
                    
                    --Retenciones 24H
                    if @w_24h > 0
                    begin
                        if exists (select 1 from cob_remesas..re_cta_efectivizacion_esp 
                                   where  ce_producto = 3 and ce_cuenta = @w_cta_banco)
                        begin
                            select @w_prom_disponible = @w_prom_disponible + round(@w_24h * @w_alicuota,@w_numdeci),
                                   @w_promedio1       = @w_promedio1       + round(@w_24h * @w_alicuota,@w_numdeci),
                                   @w_disponible      = @w_disponible      + @w_24h,
                                   @w_24h             = $0
                        end
                        else
                        begin
                                select @w_disponible      = @w_disponible      + @w_valor_hoy_chqs
                                select @w_prom_disponible = @w_prom_disponible + round(@w_valor_hoy_chqs * @w_alicuota, @w_numdeci),
                                       @w_promedio1       = @w_promedio1       + round(@w_valor_hoy_chqs * @w_alicuota, @w_numdeci)
                                select @w_24h             = @w_24h             - @w_valor_hoy_chqs 
                                select @w_24h_efe         = @w_24h_efe         - @w_valor_hoy_chqs
                                select @w_total_chq       = @w_valor_hoy_chqs
                        end
                    end
                           
                    update cob_cuentas..cc_ctacte
                    set cc_12h             = @w_12h,
                        cc_12h_dif         = @w_12h_dif,
                        cc_24h             = @w_24h,
                        cc_prom_disponible = @w_prom_disponible,
                        cc_promedio1       = @w_promedio1,
                        cc_disponible      = @w_disponible
                    where cc_ctacte        = @w_cuenta
                    if @@error <> 0
                    begin
                        select @w_error = 205001   --ERROR AL ACTUALIZAR CUENTA CORRIENTE
                        goto SIGUIENTECTE
                    end
                    
                   /* if exists (select 1 from cob_cuentas..cc_ciudad_deposito
                                       where cd_cuenta       = @w_cuenta
                                       and   cd_ciudad       = @w_ciudad
                                       and   convert(varchar(10), cd_fecha_efe, @i_formato_fecha) = @w_fecha
                                       and  (cd_efectivizado = 'N' or cd_efectivizado is null))
                        begin
                            --Actualizo el estado a C    CONFIRMADO
                            update cob_remesas..re_detalle_cheque
                            set    dc_estado     = 'C'
                            where  dc_cta_banco  = @w_cta_banco
                            and    dc_producto   = 3
                            and    dc_tipo       = '1'
                            and    dc_ssn        = @w_dc_ssn
                            and    dc_secuencial = @w_dc_secuencial
                            and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                            and    dc_estado     = 'I'
                            if @@error <> 0
                            begin
                                select @w_error = 355016   --ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA
                                goto SIGUIENTECTE
                            end
                    
                            --Actualizado Ciudad Deposito
                            update cob_cuentas..cc_ciudad_deposito
                            set    cd_valor_efe    = cd_valor_efe - @w_valor_hoy_chqs
                            where  cd_cuenta       = @w_cuenta
                            and    cd_ciudad       = @w_ciudad
                            and    convert(varchar(10), cd_fecha_efe, @i_formato_fecha) = @w_fecha
                            and   (cd_efectivizado = 'N' or cd_efectivizado is null)
                            if @@error <> 0
                            begin
                                select @w_error = 2600055  --ERROR AL ACTUALIZAR REGISTRO DE CHEQUE
                                goto SIGUIENTECTE
                            end
                        end*/
                    
                        if @w_total_chq > 0 --TS solo si efectiviza valores GCH 17/Abr/2013
                        begin
                            if @w_dep_ini = 1
                            begin
                                update cob_cuentas..cc_ctacte
                                set    cc_dep_ini = 0
                                where  cc_ctacte  = @w_cuenta
                            end
                    
                            insert into cob_cuentas..cc_tran_servicio
                                   (ts_secuencial,     ts_ssn_branch,    ts_tipo_transaccion,     ts_tsfecha,
                                    ts_usuario,        ts_terminal,      ts_ctacte,               ts_filial,
                                    ts_valor,          ts_oficina,       ts_oficina_cta,          ts_prod_banc,
                                    ts_categoria,      ts_moneda,        ts_hora,                 ts_tipocta_super,
                                    ts_turno,          ts_saldo,         ts_cta_banco,            ts_cod_alterno)
                            values (@s_ssn,            @s_ssn_branch,    2965,                    @i_fecha,
                                    @s_user,           @s_term,          @w_cuenta,               @i_filial,
                                    @w_total_chq,      @i_oficina,       @w_oficina,              @w_prod_banc,
                                    @w_categoria,      @w_moneda,        getdate(),               @w_tipocta_super,
                                    @i_turno,          @w_disponible,    @w_cta_banco,            @w_cod_alt)
                            if @@error <> 0
                            begin
                                select @w_error = 203005  --ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                                goto SIGUIENTECTE
                            end
                    
                            select @w_contable = cc_disponible + cc_12h + cc_24h + cc_48h + cc_remesas
                            from   cob_cuentas..cc_ctacte
                            where  cc_ctacte   = @w_cuenta
                            
                            --TRN MONETARIA DE EFECTIVIZACION
                            insert into cob_cuentas..cc_tran_monet
                                    (tm_secuencial,       tm_ssn_branch, tm_tipo_tran,   tm_oficina,
                                     tm_terminal,         tm_fecha,      tm_cta_banco,   tm_moneda, 
                                     tm_saldo_disponible, tm_filial,     tm_oficina_cta, tm_cod_alterno,
                                     tm_prod_banc,        tm_usuario,    tm_categoria,   tm_tipocta_super,
                                     tm_hora,             tm_signo,      tm_saldo_contable
                                     )
                             values (@s_ssn,        @s_ssn_branch, 717,      @s_ofi, 
                                     @s_term,       @s_date,   @w_cta_banco, @w_moneda,
                                     @w_disponible, @i_filial, @w_oficina,   @w_cod_alt,
                                     @w_prod_banc,  @s_user,   @w_categoria, @w_tipocta_super,
                                     getdate(),     'C',        @w_contable
                                     )
                            if @@error <> 0
                            begin
                                select @w_error = 203000  --ERROR EN INSERCION DE TRANSACCION MONETARIA
                                goto SIGUIENTECTE
                            end
                         end
                         
                    --Manejo Impuestos en efectivizacion chq locales
                    select @w_cod_alt = @w_cod_alt + 1
                    
                    exec @w_return = cob_ahorros..sp_impuestos
					   @s_ssn            	= @s_ssn,
					   @s_ssn_branch     	= @s_ssn_branch,
					   @s_date           	= @s_date,
					   @s_user           	= @s_user,
					   @s_rol            	= @s_rol,
					   @s_term           	= @s_term,
					   @s_org            	= @s_org, 
					   @s_srv            	= @s_srv,	
					   @s_ofi            	= @s_ofi, 
					   @t_corr           	= @t_corr,
					   @t_ssn_corr       	= @t_ssn_corr,
					   @i_operacion      	= 'I',
					   @i_oficina        	= @w_oficina,
					   @i_fecha          	= @i_fecha,
					   @i_empresa        	= 1,
					   @i_producto       	= @i_producto,
					   @i_producto_org   	= 10,
					   @i_moneda         	= @w_moneda,		
					   @i_num_operacion  	= @w_cta_banco,      --@w_cta_banco,		--Num cta
					   @i_tipocta        	= @w_tipocta,		 --Tipo cliente P/C
					   @i_ente           	= @w_cliente,		 --Codigo Cliente
					   @i_nombre         	= @w_nombre,		 --Nombre cliente
					   @i_val_tran       	= @w_valor_hoy_chqs, --Valor del cual se realiza el cobro de impuesto
					   @i_saldo_cuenta   	= @w_disponible,
					   @i_contable       	= @w_contable,
					   @i_masivo         	= 'L',
					   @i_srv            	= @w_servidor,	                                 
					   @i_tipocta_super  	= @w_tipocta_super,
					   @i_sec            	= 1,
					   @i_turno          	= @s_rol,
					   @i_cuenta         	= @w_cuenta,    
					   @i_filial         	= @w_filial,
					   @i_prod_banc      	= @w_prod_banc,
					   @i_categoria      	= @w_categoria,
					   @i_transaccion    	= @t_trn,
					   @i_servicio       	= null, 
					   --@i_tipo_trn       	= 'S',
					   @i_alt            	= @w_cod_alt,
					   @o_genera_fac     	= @w_genera_fac out,
					   @o_alt_monet         = @w_alt_monet  out
                           
                    if @w_return <> 0
                    begin
                        select @w_error = @w_return
                        goto SIGUIENTECTE
                    end
                end
                else --cuenta de ingreso de caja  'CTEIC'
                begin
                    --Obtengo datos de la tabla re_detalle_cheque
                    select @w_total_chq  = dc_valor,
                           @w_oficina    = dc_oficina,
                           @w_moneda     = dc_moneda
                    from cob_remesas..re_detalle_cheque
                    where  dc_cta_banco  = @w_cta_ing_caja
                    and    dc_producto   = 3
                    and    dc_tipo       = '1'
                    and    dc_ssn        = @w_dc_ssn
                    and    dc_secuencial = @w_dc_secuencial
                    and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                    and    dc_estado     = 'I'
                    if @@error <> 0
                    begin
                        select @w_error = 2902706 --ERROR DATOS DEL CHEQUE A ACTUALIZAR NO CORRESPONDEN
                        goto SIGUIENTECTE
                    end

                    update cob_remesas..re_detalle_cheque
                    set    dc_estado     = 'C'
                    where  dc_cta_banco  = @w_cta_ing_caja
                    and    dc_producto   = 3
                    and    dc_tipo       = '1'
                    and    dc_ssn        = @w_dc_ssn
                    and    dc_secuencial = @w_dc_secuencial
                    and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                    and    dc_estado     = 'I'
                    if @@error <> 0
                    begin
                        select @w_error = 355016   --ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA
                        goto SIGUIENTECTE
                    end

                    insert into cob_cuentas..cc_tran_servicio
                               (ts_secuencial,     ts_ssn_branch,    ts_tipo_transaccion,     ts_tsfecha,
                                ts_usuario,        ts_terminal,      ts_ctacte,               ts_filial,
                                ts_valor,          ts_oficina,       ts_oficina_cta,          ts_prod_banc,
                                ts_categoria,      ts_moneda,        ts_hora,                 ts_tipocta_super,
                                ts_turno,          ts_saldo,         ts_cta_banco,            ts_cod_alterno)
                        values (@s_ssn,            @s_ssn_branch,    724,                     @i_fecha,
                                @s_user,           @s_term,          null,                    @i_filial,
                                @w_total_chq,      @i_oficina,       @w_oficina,              0,
                                '0',               @w_moneda,        getdate(),               null,
                                3,                 null,             @w_cta_ing_caja,         0)
                    if @@error <> 0
                    begin
                        select @w_error = 203005  --ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                        goto SIGUIENTECTE
                    end
                end
                select @w_cod_alt = isnull(@w_alt_monet,@w_cod_alt)

                select @w_procesadas = @w_procesadas + 1

            commit tran
            select @w_rollback = 'N'

            SIGUIENTECTE:
                if @w_error <> 0
                begin
                    if @w_rollback = 'S'
                        rollback tran

                    select @w_mensaje = mensaje
                    from   cobis..cl_errores
                    where  numero     = @w_error

                    if @w_mensaje is null
                        select @w_mensaje = 'NO HAY MENSAJE ASOCIADO'

                    return 203035
                end

            fetch cur_24h into @w_cta_banco,
                               @w_valor_hoy_chqs,
                               @w_oficina_chqs,
                               @w_moneda_chqs,
                               @w_dc_ssn,
                               @w_dc_secuencial

        end

        close cur_24h
        deallocate cur_24h

        if  @w_rollback = 'N' --inserto registro para validacion de re-proceso de efectivizacion
        begin
            insert into cob_remesas..re_efectiviza_regional
                       (er_producto, er_regional, er_fecha, er_usuario, er_hora)
            values     (@i_producto, @w_regional, @i_fecha, @s_user,    getdate())
        end

        --select @w_procesadas
        return 0

        ERRORFINCTE:
            if @w_error <> 0
            begin
                if @w_rollback = 'S'
                    rollback tran

                select @w_mensaje = mensaje
                from   cobis..cl_errores
                where  numero     = @w_error

                if @w_mensaje is null
                    select @w_mensaje = 'NO HAY MENSAJE ASOCIADO'

                return @w_error
            end
    end --fin ctacteE

    if (@i_producto = 4) --ctaahoE
    begin
        --Tabla temporal para almacenar los cheques por efectivizar
        if exists (select 1 from cob_remesas..sysobjects where name='#ahdetallechqs')
            drop table #ahdetallechqs
        create table #ahdetallechqs(
                     cdd_cta_banco     varchar(24),
                     cdd_valor_hoy     money,
                     cdd_oficina_chq   smallint,
                     cdd_moneda        tinyint)
        if @@error <> 0
        begin
            select @w_error = 703105
            goto ERRORFINAHO
        end

        create clustered index idx1 on #ahdetallechqs(cdd_cta_banco)

        --Se insertan valores a efectivizar hoy
        insert into #ahdetallechqs
        select dc_cta_banco, dc_valor, dc_oficina, dc_moneda
        from   cob_remesas..re_detalle_cheque, cobis..cl_oficina
        where dc_oficina  = of_oficina
        and convert(varchar(10), dc_fecha_efe, @i_formato_fecha) = @w_fecha
        and   dc_estado   = 'I'
        and   dc_tipo     = '1'
        and  (of_regional = @i_regional or @i_regional is null)
        and  (dc_producto = @i_producto or @i_producto is null)

        select @w_procesadas = 0, @w_rollback   = 'N', @w_alt_monet = 0, @w_cod_alt = 0

        --Cursor principal
        declare cur_24h cursor for
        select cdd_cta_banco,
               cdd_valor_hoy,
               cdd_oficina_chq,
               cdd_moneda
        from #ahdetallechqs
        group by cdd_cta_banco

        open cur_24h
        fetch cur_24h into @w_cta_banco,
                           @w_valor_hoy_chqs,
                           @w_oficina_chqs,
                           @w_moneda_chqs

while (@@FETCH_STATUS = 0)
        begin  
            begin tran
                select @w_rollback = 'S'
                --Inicializo variables de trabajo
                select @w_24h_efe   = 0,
                       @w_actualiza = '',
                       @w_total_chq = 0,
                       @w_error     = 0

                --Obtengo datos de trabajo de la cuenta de ahorros
                select @w_disponible      = ah_disponible,
                       @w_12h             = isnull(ah_12h,0),
                       @w_12h_dif         = isnull(ah_12h_dif,0),
                       @w_24h             = isnull(ah_24h,0),
                       @w_48h             = isnull(ah_48h,0),
                       @w_tipo_promedio   = ah_tipo_promedio,
                       @w_fecha_ult_upd   = ah_fecha_ult_upd,
                       @w_cuenta          = ah_cuenta,
                       @w_oficina         = ah_oficina,
                       @w_prom_disponible = ah_prom_disponible,
                       @w_promedio1       = ah_promedio1,
                       @w_estado          = ah_estado,
                       @w_moneda          = ah_moneda,
                       @w_categoria       = ah_categoria,
                       @w_prod_banc       = ah_prod_banc,
                       @w_filial          = ah_filial,
                       @w_tipocta_super   = ah_tipocta_super,
                       @w_dep_ini         = ah_dep_ini,
                       @w_tipocta         = ah_tipocta,
                       @w_cliente         = ah_cliente,
                       @w_nombre          = ah_nombre,
                       @w_remesas         = ah_remesas,
                       @w_tipo            = ah_tipo
                from cob_ahorros..ah_cuenta
                where ah_cta_banco        = @w_cta_banco
                if @@rowcount = 0
                begin
                    select @w_error = 141048  --No existe cuenta de ahorros
                    goto SIGUIENTEAHO
                end

                /* Obtener Decimales de la Moneda */
                select @w_decimales = mo_decimales
                from cobis..cl_moneda
                where mo_moneda     = @w_moneda
                if @w_decimales = 'S'
                    select @w_numdeci  = isnull(pa_tinyint,0)
                    from   cobis..cl_parametro
                    where  pa_producto = 'AHO'
                    and    pa_nemonico = 'DCI'
                else
                    select @w_numdeci  = 0

                /* Obtener Alicuota para el Promedio */
                select @w_alicuota     = fp_alicuota
                from cob_cuentas..cc_fecha_promedio
                where fp_tipo_promedio = @w_tipo_promedio
                and convert(varchar(10), fp_fecha_inicio, @i_formato_fecha) = @w_fecha
                if @@rowcount = 0
                begin
                    select @w_error = 251013
                    goto ERRORFINAHO
                end

                --Obtener ciudad del chq
                select @w_ciudad = of_ciudad
                from cobis..cl_oficina
                where of_oficina = @w_oficina_chqs
                if @@rowcount = 0
                begin
                    select @w_error = 8300006 --NO EXISTE CIUDAD DE LA OFICINA
                    goto ERRORFINAHO
                end

                if @w_24h > 0
                begin
                    if exists (select 1 from cob_remesas..re_cta_efectivizacion_esp 
                               where ce_producto  = 4 and ce_cuenta = @w_cta_banco)
                       begin
                           select @w_prom_disponible = @w_prom_disponible + round(@w_24h * @w_alicuota,@w_numdeci),
                                  @w_promedio1       = @w_promedio1       + round(@w_24h * @w_alicuota,@w_numdeci),
                                  @w_disponible      = @w_disponible      + @w_24h,
                                  @w_24h             = $0
                       end
                    else
                    begin
                               select @w_disponible      = @w_disponible + @w_valor_hoy_chqs
                               select @w_prom_disponible = @w_prom_disponible + round(@w_valor_hoy_chqs * @w_alicuota, @w_numdeci),
                                      @w_promedio1       = @w_promedio1 + round(@w_valor_hoy_chqs * @w_alicuota, @w_numdeci)
                               select @w_24h             = @w_24h     - @w_valor_hoy_chqs 
                               select @w_24h_efe         = @w_24h_efe - @w_valor_hoy_chqs
                               select @w_total_chq       = @w_valor_hoy_chqs
                    end
                end

                update cob_ahorros..ah_cuenta
                set ah_12h             = @w_12h,
                    ah_12h_dif         = @w_12h_dif,
                    ah_24h             = @w_24h,
                    ah_prom_disponible = @w_prom_disponible,
                    ah_promedio1       = @w_promedio1,
                    ah_disponible      = @w_disponible
                where ah_cuenta        = @w_cuenta
                if @@error <> 0
                begin
                    select @w_error = 255001   --ERROR AL ACTUALIZAR CUENTA DE AHORROS
                    goto SIGUIENTEAHO
                end

                if exists (select 1 from cob_ahorros..ah_ciudad_deposito
                               where cd_cuenta       = @w_cuenta
                               and   cd_ciudad       = @w_ciudad
                               and   convert(varchar(10), cd_fecha_efe, @i_formato_fecha) = @w_fecha
                               and  (cd_efectivizado = 'N' or cd_efectivizado is null))
                begin
                     --Actualizo el estado a C    CONFIRMADO
                    update cob_remesas..re_detalle_cheque
                    set    dc_estado    = 'C'
                    where  dc_cta_banco = @w_cta_banco
                    and    dc_producto  = 4
                    and    dc_tipo      = '1'
                    and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
                    and    dc_estado    = 'I'
                    if @@error <> 0
                       begin
                           select @w_error = 355016   --ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA
                           goto SIGUIENTEAHO
                       end

                    --Actualizado Ciudad Deposito
                    update cob_ahorros..ah_ciudad_deposito
                    set    cd_valor_efe    = cd_valor_efe - @w_valor_hoy_chqs
                    where  cd_cuenta       = @w_cuenta
                    and    cd_ciudad       = @w_ciudad
                    and    convert(varchar(10), cd_fecha_efe, @i_formato_fecha) = @w_fecha
                    and   (cd_efectivizado = 'N' or cd_efectivizado is null)
                    if @@error <> 0
                       begin
                           select @w_error = 2600055  --ERROR AL ACTUALIZAR REGISTRO DE CHEQUE
                           goto SIGUIENTEAHO
                       end
                end

                if @w_total_chq > 0 --TS solo si efectiviza valores GCH 17/Abr/2013
                begin
                    if @w_dep_ini = 1
                    begin
                        update cob_ahorros..ah_cuenta
                        set    ah_dep_ini = 0
                        where  ah_cuenta  = @w_cuenta
                    end

                    insert into cob_ahorros..ah_tran_servicio
                         (ts_secuencial,     ts_ssn_branch,    ts_tipo_transaccion,     ts_tsfecha,
                          ts_usuario,        ts_terminal,      ts_ctacte,               ts_filial,
                          ts_valor,          ts_oficina,       ts_oficina_cta,          ts_prod_banc,
                          ts_categoria,      ts_moneda,        ts_hora,                 ts_tipocta_super,
                          ts_turno,          ts_saldo,         ts_cta_banco,            ts_cod_alterno)
                    values
                         (@s_ssn,            @s_ssn,           380,                     @i_fecha,
                          @s_user,           @s_term,          @w_cuenta,               @i_filial,
                          @w_total_chq,      @w_oficina,       @w_oficina,              @w_prod_banc,
                          @w_categoria,      @w_moneda,        getdate(),               @w_tipocta_super,
                          @i_turno,          @w_disponible,    @w_cta_banco,            @w_cod_alt)
                    if @@error <> 0
                    begin
                        select @w_error = 203005   --ERROR EN INSERCION DE TRANSACCION DE SERVICIO
                        goto SIGUIENTEAHO
                    end

                    select @w_contable = ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas
                    from   cob_ahorros..ah_cuenta
                    where  ah_cuenta   = @w_cuenta

                    -- Transaccion Monetaria
                    insert into cob_ahorros..ah_tran_monet
                        (tm_secuencial,   tm_cod_alterno,      tm_tipo_tran,   tm_oficina,
                        tm_reentry,       tm_origen,           tm_nodo,        tm_fecha, 
                        tm_saldo_disponible, tm_oficina_cta,   tm_cta_banco, 
                        tm_prod_banc,     tm_categoria,        tm_ssn_branch,  tm_moneda,
                        tm_tipocta_super, tm_hora,             tm_usuario,     tm_terminal,
                        tm_signo,         tm_saldo_contable)
                    values 
                        (@s_ssn,          @w_cod_alt,     716,           @s_ofi, 
                        'N',              'L',            @s_srv,        @i_fecha, 
                        @w_disponible,    @w_oficina,     @w_cta_banco,
                        @w_prod_banc,     @w_categoria,   @s_ssn_branch, @w_moneda, 
                        @w_tipocta_super, getdate(),      @s_user,       @s_term,
                        'C',              @w_contable)
                    if @@error <> 0
                    begin
                        select @w_error = 253000   --ERROR EN INSERCION DE TRANSACCION MONETARIA
                        goto SIGUIENTEAHO
                    end
                    
                    -- Obtengo parametro que determina si postea lineas pendientes
                    select @w_postea = isnull(cp_posteo, 'N')
                    from cob_remesas..pe_mercado, cob_remesas..pe_pro_final, cob_remesas..pe_categoria_profinal
                    where pf_mercado    = me_mercado
                    and cp_profinal     = pf_pro_final
                    and me_tipo_ente    = @w_tipocta
                    and me_pro_bancario = @w_prod_banc
                    and pf_sucursal     = @w_oficina
                    and pf_tipo         = @w_tipo
                    and pf_moneda       = @w_moneda
                    and pf_filial       = @w_filial
                    and cp_categoria    = @w_categoria

                    if @w_postea is null
                        select @w_postea = 'N'  -- Por defecto no se postea lineas pendientes
                    
                    --Manejo Impuestos en efectivizacion chq locales
                    select @w_cod_alt = @w_cod_alt + 1
                
                    exec @w_return = cob_ahorros..sp_impuestos
							@s_ssn            	= @s_ssn,
							@s_ssn_branch     	= @s_ssn_branch,
							@s_date           	= @s_date,
							@s_user           	= @s_user,
							@s_rol            	= @s_rol,
							@s_term           	= @s_term,
							@s_org            	= @s_org, 
							@s_srv            	= @s_srv,	
							@s_ofi            	= @s_ofi, 
							@t_corr           	= @t_corr,
							@t_ssn_corr       	= @t_ssn_corr,
							@i_operacion      	= 'I',
							@i_oficina        	= @w_oficina,
							@i_fecha          	= @i_fecha,
							@i_empresa        	= 1,
							@i_producto       	= @i_producto,
							@i_producto_org   	= 10,
							@i_moneda         	= @w_moneda,		
							@i_num_operacion  	= @w_cta_banco,      --@w_cta_banco,		--Num cta
							@i_tipocta        	= @w_tipocta,		 --Tipo cliente P/C
							@i_ente           	= @w_cliente,		 --Codigo Cliente
							@i_nombre         	= @w_nombre,		 --Nombre cliente
							@i_val_tran       	= @w_valor_hoy_chqs, --Valor del cual se realiza el cobro de impuesto
							@i_saldo_cuenta   	= @w_disponible,
							@i_contable       	= @w_contable,
							@i_masivo         	= 'L',
							@i_srv            	= @w_servidor,
							@i_postea         	= @w_postea,    
							@i_tipocta_super  	= @w_tipocta_super,
							@i_sec            	= 1,
							@i_turno          	= @s_rol,
							@i_cuenta         	= @w_cuenta,    
							@i_filial         	= @w_filial,
							@i_prod_banc      	= @w_prod_banc,
							@i_categoria      	= @w_categoria,
							@i_transaccion    	= @t_trn,
							@i_servicio       	= null, 
							@i_tipo_trn       	= 'S',
							@i_alt            	= @w_cod_alt,
							@o_genera_fac     	= @w_genera_fac out,
							@o_alt_monet        = @w_alt_monet  out
                   if @w_return <> 0
                   begin
                        select @w_error = @w_return   
                        goto SIGUIENTEAHO
                   end
                    
                   select @w_cod_alt = isnull(@w_alt_monet,@w_cod_alt)
                                
                   --Generacion de LP de cheques efectivizados
                   if @w_linpend = 'S'
                   begin
                       /* Encontrar el seqnos para el numero de control y para la linea pendiente */
                       update cobis..cl_seqnos
                          set siguiente = siguiente + 3
                        where tabla = 'ah_control'
                       
                       select @w_ncontrol = siguiente - 2
                         from cobis..cl_seqnos
                        where tabla = 'ah_control'
                       
                       if @w_ncontrol >= 9998
                       begin
                          select @w_ncontrol = 0
                          update cobis..cl_seqnos
                             set siguiente = 2
                           where tabla = 'ah_control'
                       end
                       
                       update cobis..cl_seqnos
                          set siguiente = siguiente + 3
                        where tabla = 'ah_lpendiente'
                       
                       select @w_lpend = siguiente - 2
                         from cobis..cl_seqnos
                        where tabla = 'ah_lpendiente'
                       
                       if @w_lpend >= 2147483639
                       begin
                          select @w_lpend = 0
                          update cobis..cl_seqnos
                             set siguiente = 2
                           where tabla = 'ah_lpendiente'
                       end
                       
                       
                       insert into cob_ahorros..ah_linea_pendiente
                                 (lp_cuenta, lp_linea,     lp_nemonico, lp_valor,
                                  lp_fecha,  lp_control,   lp_signo,    lp_enviada)
                          values (@w_cuenta, @w_lpend,     'EFEC',    @w_total_chq,
                                  @i_fecha,  @w_ncontrol,  'C',         'N')
                       
                       if @@error != 0
                       begin                    
                           select @w_error = 253002   --ERROR EN INSERCION DE LINEA PENDIENTE 
                           goto SIGUIENTEAHO
                       end
                   end
                end

                select @w_procesadas = @w_procesadas + 1

            commit tran
            select @w_rollback = 'N'

            SIGUIENTEAHO:
                if @w_error <> 0
                begin
                    if @w_rollback = 'S'
                        rollback tran

                    select @w_mensaje = mensaje
                    from   cobis..cl_errores
                    where  numero     = @w_error

                    if @w_mensaje is null
                        select @w_mensaje = 'NO HAY MENSAJE ASOCIADO'

                    return 203035
                end

            fetch cur_24h into @w_cta_banco,
                               @w_valor_hoy_chqs,
                               @w_oficina_chqs,
                               @w_moneda_chqs

        end

        close cur_24h
        deallocate cur_24h

        if  @w_rollback = 'N' --inserto registro para validacion de re-proceso de efectivizacion
        begin
            insert into cob_remesas..re_efectiviza_regional
                       (er_producto, er_regional, er_fecha, er_usuario, er_hora)
            values     (@i_producto, @w_regional, @i_fecha, @s_user,    getdate())
        end

        --select @w_procesadas
        return 0

        ERRORFINAHO:
            if @w_error <> 0
            begin
                if @w_rollback = 'S'
                    rollback tran

                select @w_mensaje = mensaje
                from   cobis..cl_errores
                where  numero     = @w_error

                if @w_mensaje is null
                    select @w_mensaje = 'NO HAY MENSAJE ASOCIADO'

                return @w_error
            end
    end --fin ctaahoE

    if (@i_producto = 14) --dpfE
    begin 
        begin tran
            --Actualizo el estado a C    CONFIRMADO
            update cob_remesas..re_detalle_cheque
            set    dc_estado    = 'C'
            where  dc_producto  = 14
            and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
            and    dc_estado    = 'I'
            if @@rowcount = 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355016   --ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA
                return 1
            end
        commit tran
    end --fin dpfE

    if (@i_producto = 10) --RECAUDOS Y REMESAS
    begin 
        begin tran
            --Actualizo el estado a C    CONFIRMADO
            update cob_remesas..re_detalle_cheque
            set    dc_estado    = 'C'
            where  dc_producto  = 10
            and   (convert(varchar(10), dc_fecha_efe, @i_formato_fecha)) = @w_fecha
            and    dc_estado    = 'I'
            if @@rowcount = 0
            begin
                rollback tran
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 355016   --ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA
                return 1
            end
        commit tran
    end --fin RECAUDOS Y REMESAS    
end
                
                
return 0
go
