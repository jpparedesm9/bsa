
/************************************************************************/
/*      Archivo:                ah_impuestos.sp                         */
/*      Stored procedure:       sp_impuestos                            */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros y Corrientes            */
/*      Disenado por:           Christian Padilla                       */
/*      Fecha de escritura:     20-May-2015                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la funcionalidad general                  */
/*      manejo de impuestos para ctas ahos y ctes                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*           FECHA               AUTOR                   RAZON          */ 
/*      20/May/2015      Christian Padilla        Emision inicial       */
/*      09/Sep/2015      Christian Padilla    Cobro impuesto ITF        */
/*      28/Oct/2015      Christian Padilla    RC/IVA Proceso de Interes */
/*      25/Ene/2016      Tyrone Cruz          IU-BE  Proceso de Interes */
/*      30/Mar/2016      Pedro Montenegro     Permitir ITF en Comisiones*/
/*      01/Ago/2016      Tyrone Cruz          Agregar categ a trx ser   */
/*	    03/Ago/2016	     Tyrone Cruz          Incidencia #60979         */
/*      25/Ago/2016      Jorge Baque H        Uso CobisCloud            */ 
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_impuestos')
    drop proc sp_impuestos
go

create proc sp_impuestos
(
    @t_show_version     bit         = 0, -- Mostrar la version del programa
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_corr             char(1)     = 'N',
    @t_ssn_corr         int         = null,	
    @s_ssn              int         = null,
    @s_ssn_branch       int         = null,
    @s_date             datetime    = null,
    @s_user             varchar(30) = 'sa',
    @s_term             varchar(32) = 'consola',
    @s_rol              smallint    = null,
    @s_org              char(1)     = null, 
    @s_srv              varchar(30) = null,
    @s_ofi              smallint    = null,	
    @i_operacion        char(1),
    @i_oficina          int         = null,
    @i_fecha            datetime    = null,
    @i_empresa          tinyint     = null,
    @i_producto         tinyint     = null,
    @i_producto_org     tinyint     = null,
    @i_moneda           tinyint     = null,
    @i_trn              int         = null,   -- Num Transaccion 
    @i_num_operacion    char(30)    = null,   --Num cta
    @i_tipocta          char(1)     = null,   --Tipo cliente P/C
    @i_ente             int         = 0,      --Codigo Cliente
    @i_nombre           char(60)    = null,   --Nombre cliente
    @i_val_tran         money       = null,   --Valor del cual se realiza el cobro de impuesto
    @i_saldo_cuenta     money       = null,
    @i_masivo           char(1)     = 'L',   -- Masivo (M), Linea (L)
    @i_srv              varchar(64) = null,
	@i_evitar_exencion  char(1)     = 'N',
	@i_lev_embargo      char(1)     = 'N',
    @i_postea           char(1)     = null,   --Verifica si registra lineas pendientes
    @i_tipocta_super    char(1)     = null,
    @i_sec              tinyint     = 1,
    @i_turno            smallint    = null,
    @i_cuenta           int         = null,
    @i_contable         money       = null,
    @i_filial           tinyint,
    @i_prod_banc        smallint    = null,
    @i_categoria        char(1)     = null,
    @i_causa            char(3)     = null,
    @i_batch            char(1)     = 'N',
    @i_transaccion      int         = null,
    @i_servicio         char(10)    = null,
    @i_tipo_trn         char(1)     = 'S',
    @i_alt              int         = 0, --alterno del impuesto usa para transaccion/servicio con un mismo impuesto
    @i_estado_cta       char(1)     = 'A',
    @i_usar_sal_min     char(1)     = 'S',
    @i_capitalizacion   char(1)     = 'N',         -- TRC CTA-S60764-IMPUESTO-IUBE
    @o_saldo_cuenta     money       = null out,
    @o_contable         money       = null out,
    @o_tot_impuestos    money       = null out,
    @o_genera_fac       char(1)     = 'N'  out,
    @o_imp_itf          money       = 0 out,
    @o_alt_monet        int         = null out,
    @o_alt_serv         int         = null out
)
as
declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_nit                  char(1),
        @w_ci_nit               varchar(20),
        @w_retencion            char(1),
        @w_ssn                  int,
        @w_impuesto             varchar(10),
        @w_monlocal             money,
        @w_monextranjera        money,
        @w_moneda_cta           tinyint,
        @w_val_impuesto         money,
        @w_val_impuesto_me      money,
        @w_moneda               tinyint,
        @w_control              int,
        @w_linea                smallint,
        @w_lp_sec               int,
        @w_contador             int,
        @w_causa                char(3),
        @w_sub_tipo             char(1),
        @w_pjuridica            char(10),
        @w_impositivo           char(1),
        @w_tipo_afectacion      char(1),
        @w_val_comision         money,
        @w_disponible           money,
        @w_12h                  money,
        @w_24h                  money,
        @w_48h                  money,
        @w_remesas              money,
        @w_contable             money,
        --@w_imp_it               char(6),
        @w_nac_extr             char(1),
        @w_ced_ruc              char(25),
        @w_genero_factura       char(1),
        @w_comision             money,
        @w_imp_itf              char(3),
        @w_saldo_para_girar     money,
        @w_saldo_contable       money,
        @w_codigobob            smallint,
        @w_signo                char(1),
        @w_estado               char(1),
        @w_correccion           char(1),
        @w_sec_correccion       int,
        @w_nemonico             char(4),
        @w_concepto             varchar(50),
        @w_tfactor              smallint,
        @w_secuencial           int,
        @w_disponible_imp       money,
        @w_secuencial_conta     int,
        @w_trn                  int,
        @w_impuesto_it          char(6),
        @w_causa_origen         char(3),
        @w_abr_producto         char(3),
        @w_incremento           int,
        @w_longitud             int,
        @w_serv                 varchar(10),
        @w_indicador            tinyint,
        -- TRC CTA-S60764-IMPUESTO-IUBE
        @w_tipdoc_empext        varchar(30),
        @w_tipdoc_ente          char(4),
        @w_itf_cex              char(1)
        -- TRC CTA-S60764-IMPUESTO-IUBE

-- Inicializacion de variables
select @w_sp_name = 'sp_impuestos'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
   begin
      print 'Stored procedure sp_impuestos, Version 4.0.0.7'
      return 0
   end

if (@i_producto_org is null)
   select @i_producto_org = @i_producto

if @i_operacion = 'I'
begin
    select @w_retencion = 'N'

    exec @w_return = cobis..sp_persona_cons
       @t_trn         =  133,
       @i_operacion   =  'Y',
       @i_persona     = @i_ente,
       @o_nit         = @w_ci_nit out,
       @o_retencion   = @w_retencion out,
       @o_sub_tipo    = @w_sub_tipo out,
       @o_pjuridica   = @w_pjuridica out,
       @o_ced_ruc     = @w_ced_ruc out

    if @w_return <> 0
       begin
          return @w_return
       end
    
    --Varifica que la cuenta del cliente este exenta de cobro de impuestos
    --if @w_retencion = 'N'
      -- begin
	
    select @w_itf_cex = 'S' 
	if @i_lev_embargo = 'N'
	begin
		if exists (select 1 from cob_remesas..re_extensiones_itf
				   where ei_producto = @i_producto and ei_cta_banco = @i_num_operacion
				   and ei_estado = 'V')
		begin
		   select @w_itf_cex = 'N'
		end
	end
          
       --end    
    --if @i_evitar_exencion = 'S'
    --   select @w_retencion = 'N'

    if @w_ci_nit is null
       select @w_nit = 'N', @w_ci_nit = @w_ced_ruc
    else
       select @w_nit = 'S'

    select @w_codigobob = pa_smallint 
    from cobis..cl_parametro
    where pa_nemonico = 'CP'
    and pa_producto = 'CLI'

    if @@rowcount != 1
    begin
        if @i_batch = 'N'
        begin
        	exec cobis..sp_cerror
        		@t_debug = @t_debug,
        		@t_file  = @t_file,
        		@t_from  = @w_sp_name,
        		@i_num   = 201196
        end     
        return 201196
    end

    -- TRC CTA-S60764-IMPUESTO-IUBE
    select @w_tipdoc_empext = pa_char 
    from cobis..cl_parametro
    where pa_nemonico = 'TDEE'
    and pa_producto = 'REM'

    if @@rowcount != 1
    begin
		if @i_batch = 'N'
		begin
			exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 201196
		end       
       return 201196
    end  
    -- TRC CTA-S60764-IMPUESTO-IUBE

    --if exists (select 1 from cobis..cl_ente, cobis..cl_tipo_documento 
				--where en_tipo_ced =  td_codigo 
				--and en_ente = @i_ente 
				--and (td_nacionalidad = convert(char(3),@w_codigobob) or td_nacionalidad is null) )
 --   begin
	--	-- TRC CTA-S60764-IMPUESTO-IUBE
	--	if @i_capitalizacion = 'S'
	--	begin
	--		select @w_tipdoc_ente = en_tipo_ced
	--			from cobis..cl_ente 
	--			where en_ente = @i_ente
				
	--		if @w_tipdoc_ente = @w_tipdoc_empext
	--			select @w_nac_extr = 'E'
	--		else
	--			select @w_nac_extr = 'N'
	--	end
	--	else
	--		select @w_nac_extr = 'N'
 --      -- TRC CTA-S60764-IMPUESTO-IUBE
	--end
	--else
		select @w_nac_extr = 'E'

    if @t_ssn_corr > 0 
	begin
		select @t_corr = 'S', @w_tfactor = -1

        if @i_producto = 4
           begin
              select @w_secuencial = tm_secuencial
              from cob_ahorros..ah_tran_monet
              where tm_cta_banco = @i_num_operacion
              and (tm_ssn_branch = @t_ssn_corr or (tm_secuencial = @t_ssn_corr and tm_ssn_branch is null))
           end
        else if @i_producto = 3
           begin
              select @w_secuencial = tm_secuencial
              from cob_cuentas..cc_tran_monet
              where tm_cta_banco = @i_num_operacion
              and (tm_ssn_branch = @t_ssn_corr or (tm_secuencial = @t_ssn_corr and tm_ssn_branch is null))
           end
       
        if not exists(select 1 from cob_tributario..tr_calculo_impuesto where ci_ssn = @w_secuencial)
           return 0
    end
    else
       select @t_corr = 'N', @w_tfactor = 1
    
    exec @w_return = cob_interfase..sp_tr_calcula_impuesto
       @s_ssn              = @s_ssn,
       @s_date             = @i_fecha,
       @s_user             = @s_user,
       @t_trn              = 6531,
       @t_debug            = 'N',
       @t_file             = null,
       @t_show_version     = 0,
       @t_from             = null,
       @t_corr             = @t_corr,          --indica si hay reverso parámetro del kernel, cts
       @t_ssn_corr         = @w_secuencial,      --secuencial para reversar parámetro del kernel, cts
       @i_oficina          = @i_oficina,       --Oficina de la cuenta
       @i_fecha            = @i_fecha,         --Fecha Proceso
       @i_operacion        = 'I',              --Insercion tablas tributarias
       @i_empresa          = @i_empresa,       --Empresa
       @i_producto         = @i_producto_org,      --Producto
       @i_moneda           = @i_moneda,        --Moneda
       @i_transaccion      = @i_transaccion,   --@i_trn,           --Transacción a generar el impuesto
       @i_num_operacion    = @i_num_operacion, --Numero de cuenta
       @i_tipo_trn         = @i_tipo_trn,      --'S',              --Servicio
       @i_tipo_ente        = @i_tipocta,       --Tipo ente Persona natural / Juridica
       @i_nac_extr         = @w_nac_extr,      --Determina si es persona Nacional / Extranjera
       @i_nit              = @w_nit,           --Veirifica si tiene nit o no
       @i_exento           = @w_retencion,     --para identificar que no se cobra ningún impuesto.
       @i_ente             = @i_ente,          --Código del Cliente
       @i_nombre_razon     = @i_nombre,        --Nombre del cliente
       @i_ci_nit           = @w_ci_nit,        --Numero NIT del cliente
       @i_base_imp         = @i_val_tran,      --valor total de la transaccion
       @i_masivo           = @i_masivo,        -- Masivo (M), Linea (L)
       @i_valor_cond       = @i_saldo_cuenta,  --saldo de la cuenta         
       @i_batch            = @i_batch,
	   @i_lev_embargo      = @i_lev_embargo,
       @i_servicio         = @i_servicio,      --Servicio a generar el impuesto
       @i_opcion           = 'G',              --Opcion G --> genera la trx de impuesto		
       @i_alt              = @i_alt,
       @i_itf_cex          = @w_itf_cex,
       @o_genero_factura   = @o_genera_fac  out--Indica si genera o no factura

    if @w_return <> 0
       begin
          return @w_return
       end

    if @i_trn = 234
       select @w_contador = 11
    else --if @i_trn = 55
       select @w_contador = case when @i_alt = 0 then 2 else @i_alt end

    select  @w_incremento = 0
         --,@w_contador = @w_contador + 1

    select @o_tot_impuestos = 0

    if @t_corr = 'S' 
       select @w_secuencial_conta = @w_secuencial
    else
       select @w_secuencial_conta = @s_ssn

    declare calimp cursor
        for select  ci_impuesto,
                    'ci_mn' = isnull(abs(ci_debito_fiscal),0),
                    'ci_me' = isnull(abs(ci_debito_fiscal_me),0),
                    ci_moneda,
                    ci_impositivo,
                    ci_tipo_afectacion
            from cob_tributario..tr_calculo_impuesto
            where ci_ssn = @w_secuencial_conta 
            and ci_fecha = @i_fecha
            and ci_producto = @i_producto_org 
            and ci_num_operacion = @i_num_operacion
            and ((ci_trn = @i_transaccion and @i_transaccion is not null) or (ci_servicio = @i_servicio and @i_servicio is not null))
            and ci_cod_alterno = isnull(@i_alt, ci_cod_alterno)
            and ci_opcion = 'G'
        for read only

    open calimp
        fetch calimp into
           @w_impuesto,
           @w_monlocal,
           @w_monextranjera,
           @w_moneda_cta,
           @w_impositivo,
           @w_tipo_afectacion

    if @@FETCH_STATUS = 1
       begin
          close calimp
          deallocate calimp
          exec cobis..sp_cerror
             @i_num       = 201157
          return 201157
       end
    else
       if @@FETCH_STATUS = 2
          begin
             close calimp 
             deallocate calimp
             return 0
          end

    while @@FETCH_STATUS = 0
    begin
       select @w_moneda = pa_tinyint 
       from cobis..cl_parametro
       where pa_nemonico = 'MLO'
       and pa_producto = 'ADM'

       if @w_moneda = @w_moneda_cta
          select  @w_val_impuesto    = @w_monlocal,
                  @w_val_impuesto_me = 0
       else
          select  @w_val_impuesto    = @w_monextranjera,
                  @w_val_impuesto_me = @w_monlocal
        
        select  @i_contable = @i_contable - @w_val_impuesto,
                @i_saldo_cuenta = @i_saldo_cuenta - @w_val_impuesto
        
        --Se verifica si el valor del impuesto es mayor a 0
        if @w_val_impuesto > 0
        begin
            if @i_producto = 4
               begin
                  if @w_impositivo = 'S' and @w_tipo_afectacion = 'C' and @i_servicio is null and @i_producto_org in (3, 4)
                     begin
                        exec cobis..sp_cerror
                           @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 251101
                           -- IMPUESTO NO CORRESPONDE A TIPO DE AFECTACION CONTABLE
                        return 251101
                     end
                else if @w_impositivo = 'S' and @w_tipo_afectacion = 'T' and (@i_transaccion is not null or @i_servicio is not null)--and (@i_transaccion is not null or (@i_producto_org not in (3, 4) and @i_servicio is not null))
                begin
                    if @i_batch = 'S'
                    begin
                       select @w_causa     = re_causa_monet
                              --@w_indicador = re_codigo
                       from cob_remesas..re_impuestos
                       where re_producto = @i_producto
                       and re_impuesto = @w_impuesto
                       and re_estado = 'V'

                       if @@rowcount != 1
                          begin
                             return 252124
                          end

                       select  @w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
                               @w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
                               @w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto

                          -- Inserta transaccion monetaria de impuesto 
                        if @i_estado_cta = 'A'
                           select @w_trn = 264
                        else
                           if @i_estado_cta = 'J'
                              select @w_trn = 3130
                           else
                              if @i_estado_cta = 'I'
                                 select @w_trn = 3141
                              else
                                 if @i_estado_cta = 'K'
                                    select @w_trn = 3146

                        select  @w_contador = isnull(max(tm_cod_alterno), @w_contador) + 1
                        from cob_ahorros..ah_tran_monet
                        where tm_secuencial = @s_ssn
                        and tm_cta_banco = @i_num_operacion

                        insert into cob_ahorros..ah_notcredeb 
                        (secuencial,      ssn_branch,       alterno,      tipo_tran,      oficina,      usuario,      terminal,      correccion,
                        sec_correccion,   reentry,          origen,       nodo,           fecha,        cta_banco,    signo,         indicador,
                        remoto_ssn,       moneda,           causa,        interes,        valor,        saldocont,    saldodisp,     oficina_cta, 
                        filial,           prod_banc,        categoria,    monto_imp,      tipo_exonerado,hora,        tipocta_super, turno,
                        concepto,         estado) 
                        values 
                        (@s_ssn,           @s_ssn,           @w_contador,  @w_trn,         @s_ofi,       @s_user,      @s_term,       @w_correccion,
                        @w_sec_correccion,'N',              'L',          @i_srv,         @i_fecha,     @i_num_operacion, @w_signo,   1,--@w_indicador, 
                        null,             @i_moneda,        @w_causa,     null,           @w_val_impuesto,@i_contable,@i_saldo_cuenta,@i_oficina, 
                        @i_filial,        @i_prod_banc,     @i_categoria, 0,              null,         getdate(),    @i_tipocta_super,@i_turno, 
                        @w_concepto,      @w_estado)

                        if @@error  != 0
                           begin
                              return 2600058
                           end
                           
                        if @i_postea = 'S'
                        begin
                           select @w_signo = 'D', @w_nemonico = substring(@w_impuesto,1,4)
                           
                           select @w_linea = ah_linea
                           from cob_ahorros..ah_cuenta
                           where ah_cuenta = @i_cuenta

                           -- Obtener el secuencial para numero de control y linea pendiente
                           select @w_control = siguiente 
                           from cobis..cl_seqnos
                           where tabla = 'ah_control'

                           if @w_control > 9999
                              select @w_control = 0
                                                  
                           select @w_lp_sec = siguiente + @i_sec 
                           from cobis..cl_seqnos
                           where tabla = 'ah_lpendiente'  
                                                  
                           if @w_lp_sec > 2147483640
                              select @w_lp_sec = @i_sec

                           -- Insertar Linea Pendiente de capitalizacion 
                           select @w_control = @w_control + 1, @w_lp_sec = @w_lp_sec + 1

                           update cobis..cl_seqnos 
                           set siguiente = @w_lp_sec 
                           where tabla = 'ah_lpendiente'

                           if @@error != 0
                              begin
                                 return 905116
                              end

                           update cobis..cl_seqnos 
                           set siguiente = @w_control 
                           where tabla = 'ah_control'
                              
                           if @@error != 0
                              begin
                                 return 255005
                              end

                           if @w_control > 9999
                              select @w_control = 0
                                                  
                           if @w_lp_sec > 2147483640
                              select @w_lp_sec = @i_sec
                                                  
                           select @w_linea = @w_linea + 1
                              
                           insert into cob_ahorros..ah_linea_pendiente 
                           (lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha, lp_control, lp_signo, lp_enviada)
                           values 
                           (@i_cuenta, @w_lp_sec, @w_nemonico, @w_val_impuesto, @i_fecha, @w_control, @w_signo, 'N')                              

                           if @@error != 0
                              begin
                                 return 253002
                              end
                        end --fin @w_postea = 'S'
                    end --FIN @i_batch = 'S'
                       
                    if @i_batch = 'N'
                    begin
                        select @w_causa     = re_causa_monet
                               --@w_indicador = re_codigo
                        from cob_remesas..re_impuestos
                        where re_producto = @i_producto
                        and re_impuesto = @w_impuesto
                        and re_estado = 'V'
                        
                        if @@rowcount != 1
                           begin
                              if @i_batch = 'N'
                                 begin
                                    exec cobis..sp_cerror
                                       @t_debug        = @t_debug,
                                       @t_file         = @t_file,
                                       @t_from         = @w_sp_name,
                                       @i_num          = 252124
                                 end
                              return 252124
                           end

                        select @w_imp_itf = pa_char
                        from cobis..cl_parametro
                        where pa_nemonico = 'IMPITF'
                        and pa_producto = 'AHO'

                        if @@rowcount != 1
                           begin
                              if @i_batch = 'N'
                                 begin
                                    exec cobis..sp_cerror
                                       @t_debug        = @t_debug,
                                       @t_file         = @t_file,
                                       @t_from         = @w_sp_name,
                                       @i_num          = 161003
                                 end
                              return 161003
                           end

                        if @w_impuesto = @w_imp_itf
                           select @o_imp_itf = @w_val_impuesto

                        if @i_batch = 'N'
						begin
							if @i_postea = 'S'
							begin
								if @t_corr = 'N'
									select @w_signo = 'D', @w_nemonico = substring(@w_impuesto,1,4)
								else
									select @w_signo = 'C', @w_nemonico = 'CORR'
                        
								select @w_linea = ah_linea
                                from cob_ahorros..ah_cuenta
                                where ah_cuenta = @i_cuenta
                        
								-- Obtener el secuencial para numero de control y linea pendiente
								select @w_control = siguiente 
                                    from cobis..cl_seqnos
                                    where tabla = 'ah_control'
                                    
								if @w_control > 9999
									select @w_control = 0

								select @w_lp_sec = siguiente + @i_sec from cobis..cl_seqnos
                                    where tabla = 'ah_lpendiente'  
                                    
								if @w_lp_sec > 2147483640
									select @w_lp_sec = @i_sec
                                    
								-- Insertar Linea Pendiente de capitalizacion 
								select @w_control = @w_control + 1, @w_lp_sec = @w_lp_sec + 1
                                    
								update cobis..cl_seqnos set siguiente = @w_lp_sec 
                                    where tabla = 'ah_lpendiente'

								if @@error != 0
								begin
									exec cobis..sp_cerror
										@t_debug    = @t_debug,
										@t_file     = @t_file,
										@t_from     = @w_sp_name,
										@i_num      = 905116
									return 905116
								end
                                    
								update cobis..cl_seqnos 
								set siguiente = @w_control 
                                where tabla = 'ah_control'
                                    
                                if @@error != 0
                                begin
                                	exec cobis..sp_cerror
                                		@t_debug    = @t_debug,
                                		@t_file     = @t_file,
                                		@t_from     = @w_sp_name,
                                		@i_num      = 255005
                                	return 255005
                                end

                                if @w_control > 9999
                                   select @w_control = 0
                                
                                if @w_lp_sec > 2147483640
									select @w_lp_sec = @i_sec
                                
                                select @w_linea = @w_linea + 1
                               
								insert into cob_ahorros..ah_linea_pendiente 
										(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha, lp_control, lp_signo, lp_enviada)
									values 
										(@i_cuenta, @w_lp_sec, @w_nemonico, @w_val_impuesto, @i_fecha, @w_control, @w_signo, 'N')
                                
								if @@error != 0
								begin
									exec cobis..sp_cerror
										@t_debug    = @t_debug,
										@t_file     = @t_file,
										@t_from     = @w_sp_name,
										@i_num      = 253002
									return 253002
								end
							end --fin @w_postea = 'S' 
                        end -- if @i_batch = 'N'
                        
                        exec @w_return = cob_ahorros..sp_ahcalcula_saldo
                           @t_debug            = @t_debug,
                           @t_file             = @t_file,
                           @t_from             = @w_sp_name,
                           @i_cuenta           = @i_cuenta,
                           @i_fecha            = @i_fecha,
                           @i_ofi              = @i_oficina,
                           @i_batch            = @i_batch,
                           @i_saldo_minimo     = @i_usar_sal_min,
                           @i_corr             = @t_corr,
                           @o_saldo_para_girar = @w_saldo_para_girar out,
                           @o_saldo_contable   = @w_saldo_contable out,
                           @o_disponible       = @w_disponible_imp out

                        if @w_return != 0
                           return @w_return

                        if @t_corr = 'N'
                           begin
                              select @w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
                                     @w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
                                     @w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto

                              if (@w_val_impuesto) > @w_saldo_para_girar
                                 begin
                                    exec cobis..sp_cerror
                                       @t_debug    = @t_debug,
                                       @t_file     = @t_file,
                                       @t_from     = @w_sp_name,
                                       @i_num     = 201017
                                    return 201017
                                 end
                           end
                        else
                           begin
                              select  @w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
                                      @w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
                                      @w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
                           end
                        
                        update cob_ahorros..ah_cuenta 
                        set ah_disponible   = ah_disponible - (@w_val_impuesto) * @w_tfactor, 
                            ah_debitos      = ah_debitos + (@w_val_impuesto) * @w_tfactor, 
                            ah_debitos_hoy  = ah_debitos_hoy + (@w_val_impuesto) * @w_tfactor,
                            ah_contador_trx = ah_contador_trx + @w_tfactor,
                            ah_linea        = isnull(@w_linea, ah_linea)
                        where ah_cta_banco = @i_num_operacion

                        if @@error != 0
                           begin
                              exec cobis..sp_cerror
                                 @t_debug    = @t_debug,
                                 @t_file     = @t_file,
                                 @t_from     = @w_sp_name,
                                 @i_num      = 155009
                                 -- /* ERROR EN ACTUALIZACION DE TRANSACCION */
                              return 155009
                           end

                        select @w_contador = isnull(max(tm_cod_alterno), @w_contador) + 1
                        from cob_ahorros..ah_tran_monet
                        where tm_secuencial = @s_ssn
                        and tm_cta_banco = @i_num_operacion

                        select @w_saldo_contable = @w_saldo_contable - (@w_val_impuesto * @w_tfactor),
                               @w_disponible_imp = @w_disponible_imp - (@w_val_impuesto * @w_tfactor)

                        -- Inserta transaccion monetaria de impuesto 
                        if @i_estado_cta = 'A'
							select @w_trn = 264
                        else
							if @i_estado_cta = 'J'
								select @w_trn = 3130
							else
								if @i_estado_cta = 'I'
									select @w_trn = 3141
                                else
                                    if @i_estado_cta = 'K'
                                       select @w_trn = 3146

                        insert into cob_ahorros..ah_notcredeb 
                        (secuencial, ssn_branch, alterno, tipo_tran, oficina, usuario, terminal, correccion,
                        sec_correccion, reentry, origen, nodo, fecha, cta_banco, signo, indicador,
                        remoto_ssn, moneda, causa, interes, valor, saldocont, saldodisp, oficina_cta, 
                        filial, prod_banc, categoria, monto_imp, tipo_exonerado, hora, tipocta_super, turno,
                        concepto, estado) 
                        values 
                        (@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_contador + @w_incremento, @w_trn, @s_ofi, @s_user, @s_term, @w_correccion,
                        @w_sec_correccion, 'N', 'L', @i_srv, @i_fecha, @i_num_operacion, @w_signo, 1, --@w_indicador, 
                        null, @i_moneda, @w_causa, null, @w_val_impuesto, @w_saldo_contable, @w_disponible_imp, @i_oficina, 
                        @i_filial, @i_prod_banc, @i_categoria, 0, null,getdate(), @i_tipocta_super, @i_turno, --@w_val_impuesto_me
                        @w_concepto,@w_estado)

                        if @@error  != 0
						begin
							exec cobis..sp_cerror
                                @t_debug    = @t_debug,
                                @t_file     = @t_file,
                                @t_from     = @w_sp_name,
                                @i_num      = 2600058
                                -- /* ERROR AL INSERTAR TRANSACCION MONETARIA */
							return 2600058
						end 

                        if @t_corr = 'S'
						begin
                            update cob_ahorros..ah_tran_monet set tm_estado = 'R'
                            where tm_cta_banco = @i_num_operacion
                            and (tm_ssn_branch = @t_ssn_corr or (tm_secuencial = @t_ssn_corr and tm_ssn_branch is null))
                            and tm_cod_alterno = @w_contador + @w_incremento
                           
                            if @@error != 0
                               begin
                                  exec cobis..sp_cerror
                                     @t_debug    = @t_debug,
                                     @t_file     = @t_file,
                                     @t_from     = @w_sp_name,
                                     @i_num      = 2600058
                                     -- /* ERROR AL INSERTAR TRANSACCION MONETARIA */
                                  return 2600058
                               end
						end
                        
                        -- Se acumulan los impuestos
                        select @o_tot_impuestos = @o_tot_impuestos + @w_val_impuesto
                    end
                end
                else if @w_impositivo = 'S' and @w_tipo_afectacion = 'C' and (@i_transaccion is not null or @i_servicio is not null)--and @i_servicio is not null 
				begin
					if @t_corr = 'N'
						select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
                                @w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
                                @w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto
						else
						begin
							select @w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
                                   @w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
                                   @w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
						end

                    select @w_indicador = re_codigo from cob_remesas..re_impuestos
                    where re_producto = @i_producto
                    and re_impuesto = @w_impuesto
                    and re_estado = 'V'
                    
                    if @@rowcount != 1
                       begin
                          if @i_batch = 'N'
                             begin
                                 exec cobis..sp_cerror
                                    @t_debug        = @t_debug,
                                    @t_file         = @t_file,
                                    @t_from         = @w_sp_name,
                                    @i_num          = 252124
                             end
                          return 252124
                       end

                    select @w_causa_origen = ''
                    select @w_serv = rtrim(ltrim(@i_servicio))
                    
                    if (@w_serv is null)
						select @w_causa_origen = null
                    else
					begin
                        select @w_longitud = len(@w_serv)
                        select @w_longitud = @w_longitud - 2 
                        select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
                        select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
                        select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

                    if @i_estado_cta = 'A'
						select @w_trn = 3128
                    else
                       if @i_estado_cta = 'J' 
                          select @w_trn = 3133
                       else
                          if @i_estado_cta = 'I' 
                             select @w_trn = 3142

                    select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
                    from cob_ahorros..ah_tran_servicio 
                    where ts_secuencial = @s_ssn
                    and ts_tipo_transaccion = @w_trn
                    and ts_clase = 'N'

                    insert into cob_ahorros..ah_tran_servicio 
                    (ts_secuencial, ts_ssn_branch,ts_tipo_transaccion,ts_clase, ts_tsfecha, ts_usuario, ts_terminal, ts_origen,
                     ts_nodo, ts_hora, ts_oficina, ts_valor, ts_monto,ts_cta_banco,ts_cod_alterno,ts_observacion,ts_causa,
                     ts_correccion,ts_estado,ts_ssn_corr,ts_indicador,ts_moneda,ts_prod_banc,ts_oficina_cta, ts_causa_rev,ts_categoria)
                    values
                    (@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn, 'N', @s_date, @s_user, @s_term, @s_org, 
                     @s_srv, getdate(),@s_ofi,@w_val_impuesto, 0, @i_num_operacion,@w_contador,@w_impuesto, '0', 
                     @w_correccion,@w_estado, @w_sec_correccion,@w_indicador,@i_moneda,@i_prod_banc,@i_oficina, @w_causa_origen, @i_categoria)

                    if @@error != 0
                       begin
                          exec cobis..sp_cerror
                             @t_debug    = @t_debug,
                             @t_file     = @t_file,
                             @t_from     = @w_sp_name,
                             @i_num      = 103005
                             -- /* ERROR EN CREACION DE TRANSACCION DE SERVICIO*/
                          return 103005
                       end
/*
                    select @w_imp_it = pa_char
                    from cobis..cl_parametro
                    where pa_nemonico = 'IMPIT'
                    and pa_producto = 'AHO'
*/
                    select @w_val_comision = isnull(sum(ts_valor) ,0)
                    from cob_ahorros..ah_tran_servicio
                    where ts_secuencial = @s_ssn
                    and ts_tipo_transaccion = @w_trn
                    and ts_causa_rev = @w_causa_origen
                    and ts_indicador in (select re_codigo from cob_remesas..re_impuestos
                                          --where re_producto = @i_producto and re_estado = 'V' and re_impuesto <> @w_imp_it)
                                         where re_producto = @i_producto 
                                         and re_estado = 'V' 
                                         and re_impuesto not in (select ti_codigo
                                                                 from cob_tributario..tr_tipo_imp
                                                                 where ti_impositivo = 'N'
                                                                 and ti_tipo_afectacion = 'T'))

                    select @w_comision = isnull(tm_valor,0) 
                    from cob_ahorros..ah_tran_monet
                    where tm_secuencial = @s_ssn
                    and tm_causa = @w_causa_origen
                    
                    if @w_val_comision > @w_comision
                       begin
                          select @o_genera_fac = 'N'
                          exec cobis..sp_cerror
                             @t_debug    = @t_debug,
                             @t_file     = @t_file,
                             @t_from     = @w_sp_name,
                             @i_num      = 252123
                             -- /* EL VALOR DEL IMPUESTO ES MAYOR AL VALOR DE LA COMISION*/
                          return 252123
                       end

                    update cob_ahorros..ah_tran_monet set tm_monto_imp = tm_valor - @w_val_comision
					where tm_secuencial = @s_ssn
					and tm_causa = @w_causa_origen

					if @@error != 0
					begin
						exec cobis..sp_cerror
							@t_debug    = @t_debug,
							@t_file     = @t_file,
							@t_from     = @w_sp_name,
							@i_num      = 145000
                             -- /* ERROR EN ACTUALIZACION DE TRANSACCION MONETARIA*/
						return 145000
					end
                    
                    if exists (select 1 from cob_ahorros..ah_tran_monet
								where tm_secuencial = @s_ssn
								and tm_monto_imp < 0)
                    begin
						select @o_genera_fac = 'N'
						exec cobis..sp_cerror
							@t_debug    = @t_debug,
							@t_file     = @t_file,
							@t_from     = @w_sp_name,
							@i_num      = 252123
							-- /* EL VALOR DEL IMPUESTO ES MAYOR AL VALOR DE LA COMISION*/
						return 252123
                    end
                    
                    if @t_corr = 'S'
					begin
						update cob_ahorros..ah_tran_servicio set ts_estado = @w_estado
							where ts_ssn_branch = @w_sec_correccion
							and ts_tipo_transaccion = @w_trn
                          
						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 103005
								--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
							return 103005
						end
					end 
                end
                else if @w_impositivo = 'N' and @w_tipo_afectacion = 'T'
				begin                
					if @i_estado_cta = 'A'
						select @w_trn = 3128
					else
                        if @i_estado_cta = 'J' 
                           select @w_trn = 3133
                        else
							if @i_estado_cta = 'I' 
								select @w_trn = 3142

                    if @t_corr = 'N'
						select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto
                    else
					begin
						select 	@w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
								@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
								@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
					end
                    
                    select @w_indicador = re_codigo 
                    from cob_remesas..re_impuestos
                    where re_producto = @i_producto
                    and re_impuesto = @w_impuesto
                    and re_estado = 'V'
                    
                    if @@rowcount != 1
                       begin
                          if @i_batch = 'N'
                             begin
                                exec cobis..sp_cerror
                                   @t_debug        = @t_debug,
                                   @t_file         = @t_file,
                                   @t_from         = @w_sp_name,
                                   @i_num          = 252124
                             end
                          return 252124
                       end

                    select @w_causa_origen = ''
                    select @w_serv = rtrim(ltrim(@i_servicio))
                    
                    if (@w_serv is null)
						select @w_causa_origen = null
                    else
					begin
						select @w_longitud = len(@w_serv)
						select @w_longitud = @w_longitud - 2 
						select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
						select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
						select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

                    select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
                    from cob_ahorros..ah_tran_servicio 
                    where ts_secuencial = @s_ssn
                    and ts_tipo_transaccion = @w_trn
                    and ts_clase = 'N'

                    insert into cob_ahorros..ah_tran_servicio 
                    (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,ts_clase, ts_tsfecha, ts_usuario,
                    ts_terminal, ts_origen, ts_nodo, ts_hora, ts_oficina, ts_valor, ts_monto,ts_cta_banco,ts_cod_alterno,
                    ts_observacion,ts_causa,ts_correccion,ts_estado,ts_ssn_corr,
                    ts_indicador,ts_moneda,ts_prod_banc,ts_oficina_cta, ts_causa_rev, ts_categoria) 
                    values
                    (@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn, 'N', @s_date, @s_user, @s_term, @s_org, @s_srv, getdate(),@s_ofi,@w_val_impuesto, 0, 
                    @i_num_operacion,@w_contador,@w_impuesto,'0',@w_correccion,@w_estado, @w_sec_correccion,
                    @w_indicador,@i_moneda,@i_prod_banc,@i_oficina, @w_causa_origen,@i_categoria)

                    if @@error != 0
					begin
						exec cobis..sp_cerror
							@t_debug    = @t_debug,
							@t_file     = @t_file,
							@t_from     = @w_sp_name,
							@i_num      = 103005
							-- /* ERROR EN CREACION DE TRANSACCION DE SERVICIO*/
						return 103005
					end

					if @t_corr = 'S'
					begin
						update cob_ahorros..ah_tran_servicio set ts_estado = @w_estado
						where ts_ssn_branch = @w_sec_correccion
						and ts_tipo_transaccion = @w_trn

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 103005
									--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
							return 103005
						end
					end 
				end
				--else if @w_impositivo = 'S' and @w_tipo_afectacion = 'T' and (@i_transaccion is null and @i_producto_org in (3, 4))
				--begin
				--	exec cobis..sp_cerror
				--		@t_debug    = @t_debug,
				--		@t_file     = @t_file,
				--		@t_from     = @w_sp_name,
				--		--@i_msg      = "IMPUESTO NO CORRESPONDE A TIPO DE AFECTACION CONTABLE",
				--		@i_num      = 251101
				--		-- IMPUESTO NO CORRESPONDE A TIPO DE AFECTACION CONTABLE
				--	return 251101
				--end
				else
				begin
					if @t_corr = 'N'
						select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto
					else
					begin
						select  @w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
								@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
								@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
					end

                    select @w_indicador = re_codigo from cob_remesas..re_impuestos
                    where re_producto = @i_producto
                    and re_impuesto = @w_impuesto
                    and re_estado = 'V'
                    
                    if @@rowcount != 1
                    begin
                       	if @i_batch = 'N'
                    	begin
                    		exec cobis..sp_cerror
                    			@t_debug        = @t_debug,
                    			@t_file         = @t_file,
                    			@t_from         = @w_sp_name,
                    			@i_num          = 252124
                    	end
                    	return 252124
                    end

					select @w_causa_origen = ''
					select @w_serv = rtrim(ltrim(@i_servicio))
					
					if (@w_serv is null)
						select @w_causa_origen = null
					else
					begin
						select @w_longitud = len(@w_serv)
						select @w_longitud = @w_longitud - 2 
						select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
						select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
						select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

					if @i_estado_cta = 'A'
					select @w_trn = 3128
					else 
						if @i_estado_cta = 'J'
							select @w_trn = 3133
						else
							if @i_estado_cta = 'I' 
								select @w_trn = 3142

					select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
						from cob_ahorros..ah_tran_servicio 
						where ts_secuencial = @s_ssn
						and ts_tipo_transaccion = @w_trn
						and ts_clase = 'N'

					insert into cob_ahorros..ah_tran_servicio 
					(ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,ts_clase, ts_tsfecha, ts_usuario,
					ts_terminal, ts_origen, ts_nodo, ts_hora, ts_oficina, ts_valor, ts_monto,ts_cta_banco,ts_cod_alterno,
					ts_observacion,ts_causa,ts_correccion,ts_estado,ts_ssn_corr,
					ts_indicador,ts_moneda,ts_prod_banc,ts_oficina_cta, ts_causa_rev,ts_categoria) 
					values
                    (@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn, 'N', @s_date, @s_user, @s_term, @s_org, @s_srv, getdate(),@s_ofi,@w_val_impuesto, 0, 
                    @i_num_operacion,@w_contador,@w_impuesto,'0',@w_correccion,@w_estado, @w_sec_correccion,
                    @w_indicador,@i_moneda,@i_prod_banc,@i_oficina, @w_causa_origen,@i_categoria)

					if @@error != 0
					begin
						exec cobis..sp_cerror
							@t_debug    = @t_debug,
							@t_file     = @t_file,
							@t_from     = @w_sp_name,
							@i_num      = 103005
							-- ERROR EN CREACION DE TRANSACCION DE SERVICIO
						return 103005
					end

					if @t_corr = 'S'
					begin
						update cob_ahorros..ah_tran_servicio set ts_estado = @w_estado
							where ts_ssn_branch = @w_sec_correccion
							and ts_tipo_transaccion = @w_trn

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 103005
									--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
							return 103005
						end
					end 
				end
			end  --Fin producto = 4

			if @i_producto = 3
			begin
				if @w_impositivo = 'S' and @w_tipo_afectacion = 'C' and @i_servicio is null and @i_producto_org in (3, 4)
				begin
				    if @i_batch = 'N'
					begin
						exec cobis..sp_cerror
					      	@t_debug    = @t_debug,
					      	@t_file     = @t_file,
					      	@t_from     = @w_sp_name,						
					      	@i_num      = 251101
					      	-- IMPUESTO NO CORRESPONDE A TIPO DE AFECTACION CONTABLE
					end
					return 251101
				end	
				else if @w_impositivo = 'S' and @w_tipo_afectacion = 'T' and (@i_transaccion is not null or @i_servicio is not null)--and (@i_transaccion is not null or (@i_producto_org not in (3, 4) and @i_servicio is not null))
				begin
				    if @i_batch = 'S'
					begin
						select @w_causa     = re_causa_monet
                               --@w_indicador = re_codigo
						from cob_remesas..re_impuestos
						where re_producto = @i_producto
						and re_impuesto = @w_impuesto
						and re_estado = 'V'
						   
						if @@rowcount != 1
						begin
							return 252124
						end

						select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto--, @w_trn = 50

                        if @i_estado_cta = 'A'
                           select @w_trn = 50
                        if @i_estado_cta = 'I'
                           select @w_trn = 2022
                        if @i_estado_cta = 'K'
                           select @w_trn = 2156

                        select  @w_contador = isnull(max(tm_cod_alterno), @w_contador) + 1
                        from cob_cuentas..cc_tran_monet
                        where tm_secuencial = @s_ssn
                        and tm_cta_banco = @i_num_operacion

							-- Inserta transaccion monetaria de impuesto 
					   /*	insert into cob_cuentas..cc_notcredeb 
						(secuencial,     ssn_branch,     alterno,     tipo_tran,     oficina,     usuario,    terminal, 
                         correccion,     sec_correccion, reentry,     origen,        nodo,        fecha,      cta_banco, 
                         signo,          indicador,      remoto_ssn,  moneda,        causa,       valor,      sld_contable, 
                         sld_disponible, oficina_cta,    filial,      prod_banc,     categoria,   monto_imp,  tipo_exonerado, 
                         hora,           tipocta_super,  turno,       concepto,      estado) 
						values 
                        (@s_ssn,         @s_ssn,         @w_contador, @w_trn,        @s_ofi,      @s_user,    @s_term, 
                         @w_correccion,  @w_sec_correccion,'N',       'L',           @i_srv,      @i_fecha,   @i_num_operacion, 
                         @w_signo,       1,              null,        @i_moneda,     @w_causa,    @w_val_impuesto,@i_contable, 
                         @i_saldo_cuenta,@i_oficina,     @i_filial,   @i_prod_banc,  @i_categoria,0,           null, 
                         getdate(),      @i_tipocta_super,@i_turno,   @w_concepto,   @w_estado)

						if @@error != 0
						begin
							return 2600058
						end*/
					end --FIN if @i_batch = 'S'
					
					if @i_batch = 'N'
					begin
						select @w_causa     = re_causa_monet
                               --@w_indicador = re_codigo
						from cob_remesas..re_impuestos
							where re_producto = @i_producto
							and re_impuesto = @w_impuesto
							and re_estado = 'V'

						if @@rowcount != 1
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug        = @t_debug,
									@t_file         = @t_file,
									@t_from         = @w_sp_name,
									@i_num          = 252124
							end
							return 252124
						end

						select @w_imp_itf = pa_char 
							from cobis..cl_parametro
							where pa_nemonico = 'IMPITF'
							and pa_producto = 'AHO'

						if @@rowcount != 1
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug        = @t_debug,
									@t_file         = @t_file,
									@t_from         = @w_sp_name,
									@i_num          = 161003
							end
							return 161003
						end

						if @w_impuesto = @w_imp_itf
							select @o_imp_itf = @w_val_impuesto

						exec @w_return = cob_cuentas..sp_calcula_saldo
							@t_debug            = @t_debug,
							@t_file             = @t_file,
							@t_from             = @w_sp_name,
							@i_cuenta           = @i_cuenta,
							@i_fecha            = @i_fecha,
							@i_saldo_minimo		= @i_usar_sal_min,
							@o_saldo_para_girar = @w_saldo_para_girar out,
							@o_saldo_contable   = @w_saldo_contable out,
							@o_disponible       = @w_disponible_imp out 

						if @w_return != 0
							return @w_return

						if @t_corr = 'N'
						begin
							select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
									@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
									@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto--, @w_trn = 50

							if (@w_val_impuesto) > @w_saldo_para_girar
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num     = 201017
								return 201017
							end
						end
						else
						begin
							select  @w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
									@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
									@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto --, @w_trn = 50
						end

						update cob_cuentas..cc_ctacte 
						set cc_disponible = cc_disponible - (@w_val_impuesto) * @w_tfactor, 
								--cc_debitos2 = cc_debitos2 + (@w_val_impuesto) * @w_tfactor, 
								cc_debitos_hoy = cc_debitos_hoy + (@w_val_impuesto) * @w_tfactor,
								cc_debitos_mes = cc_debitos_mes + (@w_val_impuesto) * @w_tfactor
							where cc_cta_banco = @i_num_operacion

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 155009
									-- /* ERROR EN ACTUALIZACION DE TRANSACCION */
							end
							return 155009
						end

						select @w_saldo_contable = @w_saldo_contable - (@w_val_impuesto * @w_tfactor),
						       @w_disponible_imp = @w_disponible_imp - (@w_val_impuesto * @w_tfactor)

						if @i_estado_cta = 'A'
							select @w_trn = 50
						if @i_estado_cta = 'I'
							select @w_trn = 2022
						if @i_estado_cta = 'K'
							select @w_trn = 2156

						select 	@w_contador = isnull(max(tm_cod_alterno), @w_contador) + 1
							from cob_cuentas..cc_tran_monet
							where tm_secuencial = @s_ssn
							and tm_cta_banco = @i_num_operacion

						-- Inserta transaccion monetaria de impuesto 
					  /*	insert into cob_cuentas..cc_notcredeb 
						(secuencial, ssn_branch, alterno, tipo_tran, oficina, usuario, terminal, correccion,
						sec_correccion, reentry, origen, nodo, fecha, cta_banco, signo, indicador, 
						remoto_ssn, moneda, causa, valor, sld_contable, sld_disponible,oficina_cta, filial,
						prod_banc, categoria, monto_imp, tipo_exonerado, hora, tipocta_super, turno,concepto, estado) 
						values 
						(@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_contador + @w_incremento, @w_trn, @s_ofi, @s_user, @s_term, @w_correccion,
						@w_sec_correccion, 'N', 'L', @i_srv, @i_fecha, @i_num_operacion, @w_signo, 1,--@w_indicador,
						null, @i_moneda, @w_causa, @w_val_impuesto, @w_saldo_contable, @w_disponible_imp,@i_oficina, @i_filial,
						@i_prod_banc, @i_categoria, 0, null,getdate(), @i_tipocta_super, @i_turno,@w_concepto, @w_estado) 

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 2600058
									--  ERROR AL INSERTAR TRANSACCION MONETARIA
							end
							return 2600058
						end*/

						if (@t_corr = 'S')
						begin
							update cob_cuentas..cc_tran_monet set tm_estado = 'R'
								where tm_cta_banco = @i_num_operacion
								and (tm_ssn_branch = @t_ssn_corr or (tm_secuencial = @t_ssn_corr and tm_ssn_branch is null))
								and tm_cod_alterno = @w_contador + @w_incremento

							if @@error != 0
							begin
								if @i_batch = 'N'
								begin
									exec cobis..sp_cerror
										@t_debug    = @t_debug,
										@t_file     = @t_file,
										@t_from     = @w_sp_name,
										@i_num      = 2600058
									-- /* ERROR AL INSERTAR TRANSACCION MONETARIA */
								end
								return 2600058
							end
						end

						-- Se acumulan los impuestos
						select @o_tot_impuestos = @o_tot_impuestos + @w_val_impuesto 
					end
				end
				else if @w_impositivo = 'S' and @w_tipo_afectacion = 'C' and (@i_transaccion is not null or @i_servicio is not null)--and @i_servicio is not null 
				begin
					if @t_corr = 'N'
						select 	@w_signo = 'D', @w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto --, @w_trn = 50
					else
						select 	@w_signo = 'C', @w_estado = 'R', @w_correccion = 'S', 
								@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
								@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto--, @w_trn = 48
					
					if @i_estado_cta = 'A'
						select @w_trn = 2015
					else
						if @i_estado_cta = 'I'
							select @w_trn = 2023

                    select @w_indicador = re_codigo 
                    from cob_remesas..re_impuestos
                    where re_producto = @i_producto
                    and re_impuesto = @w_impuesto
                    and re_estado = 'V'
                    
                    if @@rowcount != 1
                    begin
                    	if @i_batch = 'N'
                    	begin
                    		exec cobis..sp_cerror
                    			@t_debug        = @t_debug,
                    			@t_file         = @t_file,
                    			@t_from         = @w_sp_name,
                    			@i_num          = 252124
                    	end
                    	return 252124
                    end

					select @w_causa_origen = ''
					select @w_serv = rtrim(ltrim(@i_servicio))

					if (@w_serv is null)
						select @w_causa_origen = null
					else
					begin
						select @w_longitud = len(@w_serv)
						select @w_longitud = @w_longitud - 2 
						select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
						select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
						select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

					select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
						from cob_cuentas..cc_tran_servicio 
						where ts_secuencial = @s_ssn
						and ts_tipo_transaccion = @w_trn --2015
						and ts_clase = 'N'

					insert into cob_cuentas..cc_tran_servicio
					(ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_clase, ts_tsfecha, ts_usuario, ts_terminal, ts_origen,
					ts_nodo, ts_hora, ts_oficina, ts_valor, ts_monto,ts_cta_banco,ts_cod_alterno,ts_descripcion_ec,
					ts_causa, ts_producto, ts_moneda,ts_autorizacion,ts_cliente,ts_tipocta,ts_fecha,ts_correccion,
					ts_estado,ts_ssn_corr,ts_indicador,ts_prod_banc,ts_oficina_cta, ts_stick_imp,ts_categoria) 
					values
					(@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn, 'N', @s_date, @s_user, @s_term, @s_org, 
					@s_srv, getdate(),@s_ofi,@w_val_impuesto, 0, @i_num_operacion, @w_contador, @w_concepto, 
					'0',@i_producto,@i_moneda,@s_user,@i_ente,@i_tipocta,@i_fecha,@w_correccion,
					@w_estado, @w_sec_correccion,@w_indicador,@i_prod_banc,@i_oficina, @w_causa_origen,@i_categoria)

					if @@error != 0
					begin
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
								@t_debug    = @t_debug,
								@t_file     = @t_file,
								@t_from     = @w_sp_name,
								@i_num      = 103005
								-- ERROR EN CREACION DE TRANSACCION DE SERVICIO
						end
						return 103005
					end

					select @w_val_comision = isnull(sum(ts_valor) ,0)
						from cob_cuentas..cc_tran_servicio
						where ts_secuencial = @s_ssn
						and ts_tipo_transaccion = @w_trn --2015
						and ts_stick_imp = @w_causa_origen
						and ts_indicador in (select re_codigo from cob_remesas..re_impuestos
											where re_producto = @i_producto 
											and re_estado = 'V' 
											and re_impuesto not in (select ti_codigo
																	from cob_tributario..tr_tipo_imp
																	where ti_impositivo = 'N'
																	and ti_tipo_afectacion = 'T'))
											--and re_impuesto <> @w_imp_it)	
											
					select @w_comision = isnull(tm_valor,0)
						from cob_cuentas..cc_tran_monet
						where tm_secuencial = @s_ssn
						and tm_causa = @w_causa_origen

					if @w_val_comision > @w_comision
					begin
						select @o_genera_fac = 'N'
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
								@t_debug    = @t_debug,
								@t_file     = @t_file,
								@t_from     = @w_sp_name,
								@i_num      = 252123
								--EL VALOR DEL IMPUESTO ES MAYOR AL VALOR DE LA COMISION
							end
						return 252123
					end

					--update cob_cuentas..cc_tran_monet 
					--		set tm_monto_imp = tm_valor - @w_val_comision
					--	where tm_secuencial = @s_ssn
					--	and tm_causa = @w_causa_origen

					if @@error != 0
					begin
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
					  	     	@t_debug    = @t_debug,
					  	     	@t_file     = @t_file,
					  	     	@t_from     = @w_sp_name,
					  	     	@i_num      = 145000
					  	     	--  ERROR EN ACTUALIZACION DE TRANSACCION MONETARIA
						end
						return 145000
					end

					--if exists (select 1 from cob_cuentas..cc_tran_monet
					--		where tm_secuencial = @s_ssn
					--		and tm_monto_imp < 0)
					begin
						select @o_genera_fac = 'N'
						if @i_batch = 'N'
						begin 
							exec cobis..sp_cerror
						     	@t_debug    = @t_debug,
						     	@t_file     = @t_file,
						     	@t_from     = @w_sp_name,
						     	@i_num      = 252123
						     	-- /* EL VALOR DEL IMPUESTO ES MAYOR AL VALOR DE LA COMISION*/
						end
						return 252123
					end

					if @t_corr = 'S'
					begin					    
						if @i_estado_cta = 'A'
							select @w_trn = 2015
						else
							if @i_estado_cta = 'I'
								select @w_trn = 2023
												
						update cob_cuentas..cc_tran_servicio 
								set ts_estado = @w_estado
							where ts_ssn_branch = @w_sec_correccion
							and ts_tipo_transaccion = @w_trn --2015

						if @@error != 0
						begin
						  	if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
						  	   		@t_debug    = @t_debug,
						  	   		@t_file     = @t_file,
						  	   		@t_from     = @w_sp_name,
						  	   		@i_num      = 103005
						  	   		--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
						  	return 103005
						end
					end	

					/*
					if @i_trn = 48
					begin
						select @w_impuesto_it = pa_char from cobis..cl_parametro
							where pa_nemonico = 'IMPIT' 
							and pa_producto = 'CTE'

						if @w_impuesto <> @w_impuesto_it --'IT'
						begin
							exec @w_return = cob_cuentas..sp_calcula_saldo
								@t_debug            = @t_debug,
								@t_file             = @t_file,
								@t_from             = @w_sp_name,
								@i_cuenta           = @i_cuenta,
								@i_fecha            = @i_fecha,
								@o_saldo_para_girar = @w_saldo_para_girar out,
								@o_saldo_contable   = @w_saldo_contable out,
								@o_disponible       = @w_disponible_imp out 

							if @w_return != 0
								return @w_return
								
							select @w_causa = isnull(pa_char,'1') from cobis..cl_parametro 
								where pa_nemonico = 'COBIMP'
								and pa_producto = 'CTE'

							if @t_corr = 'N'
								select @w_concepto = 'COBRO POR IMPUESTO '
							else
								select @w_concepto = 'CORRECCION COBRO POR IMPUESTO ', @w_trn = 50

							select 	@w_contador = isnull(max(tm_cod_alterno), @w_contador) + 1
								from cob_cuentas..cc_tran_monet
								where tm_secuencial = @s_ssn
								and tm_cta_banco = @i_num_operacion

							-- Inserta transaccion monetaria de impuesto 
							insert into cob_cuentas..cc_notcredeb 
								(secuencial, ssn_branch, alterno, tipo_tran, oficina, usuario, terminal, correccion,
								sec_correccion, reentry, origen, nodo, fecha, cta_banco, signo, indicador, 
								remoto_ssn, moneda, causa, valor, sld_contable, sld_disponible,oficina_cta, filial,
								prod_banc, categoria, monto_imp, tipo_exonerado,hora, tipocta_super, turno,concepto,estado) 
							values 
								(@s_ssn, @s_ssn_branch, @w_contador + @w_incremento, @w_trn, @s_ofi, @s_user, @s_term, @w_correccion,
								@w_sec_correccion, 'N', 'L', @i_srv, @i_fecha, @i_num_operacion, @w_signo, 1, 
								null, @i_moneda, @w_causa, @w_val_impuesto, @w_saldo_contable, @w_disponible_imp,@i_oficina, @i_filial,
								@i_prod_banc, @i_categoria, 0, null,getdate(), @i_tipocta_super, @i_turno,@w_concepto,@w_estado) --@w_val_impuesto_me

							if @@error != 0
							begin
								if @i_batch = 'N'
								begin
									exec cobis..sp_cerror
										@t_debug    = @t_debug,
										@t_file     = @t_file,
										@t_from     = @w_sp_name,
										@i_num      = 2600058
										--  ERROR AL INSERTAR TRANSACCION MONETARIA
								end
								return 2600058
							end

							--update cob_cuentas..cc_ctacte set cc_disponible = cc_disponible - (@w_val_impuesto) * @w_tfactor, 
							-- cc_debitos2 = cc_debitos2 + (@w_val_impuesto) * @w_tfactor, 
							-- cc_debitos_hoy = cc_debitos_hoy + (@w_val_impuesto) * @w_tfactor,
							-- cc_debitos_mes = cc_debitos_mes + (@w_val_impuesto) * @w_tfactor
							-- where cc_cta_banco = @i_num_operacion
							-- if @@error != 0
							--      begin
							--	     if @i_batch = 'N'
							--           begin
							--              exec cobis..sp_cerror
							--                   @t_debug    = @t_debug,
							--                   @t_file     = @t_file,
							--                   @t_from     = @w_sp_name,
							--                   @i_num      = 155009
							--              --ERROR EN ACTUALIZACION DE TRANSACCION
							--		   end
							--        return 155009
							--      end

							if @t_corr = 'S'
							begin
								update cob_cuentas..cc_tran_monet set tm_estado = 'R'
									where tm_cta_banco = @i_num_operacion
									and tm_ssn_branch = @t_ssn_corr
									and tm_estado is null

								if @@error != 0
								begin
									if @i_batch = 'N'
									begin
										exec cobis..sp_cerror
											@t_debug    = @t_debug,
											@t_file     = @t_file,
											@t_from     = @w_sp_name,
											@i_num      = 2600058
											--ERROR AL INSERTAR TRANSACCION MONETARIA
									end
									return 2600058
								end
							end
						end --fin @w_impuesto <> 'IT'
					end	--fin  if @i_trn = 48
					*/
				end
				else if @w_impositivo = 'N' and @w_tipo_afectacion = 'T'
				begin
					if @t_corr = 'N'
						select 	@w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto
					else
						select 	@w_estado = 'R', @w_correccion = 'S', 
								@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
								@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
					
					if @i_estado_cta = 'A'
						select @w_trn = 2015
					else
						if @i_estado_cta = 'I'
							select @w_trn = 2023

					select @w_indicador = re_codigo 
					from cob_remesas..re_impuestos
					where re_producto = @i_producto
					and re_impuesto = @w_impuesto
					and re_estado = 'V'
                    
					if @@rowcount != 1
					begin
					  	if @i_batch = 'N'
						begin
					  	  	exec cobis..sp_cerror
					  	  		@t_debug        = @t_debug,
					  	  		@t_file         = @t_file,
					  	  		@t_from         = @w_sp_name,
					  	  		@i_num          = 252124
						end
					  	return 252124
					end

					select @w_causa_origen = ''
					select @w_serv = rtrim(ltrim(@i_servicio))
					
					if (@w_serv is null)
						select @w_causa_origen = null
					else
					begin
						select @w_longitud = len(@w_serv)
						select @w_longitud = @w_longitud - 2 
						select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
						select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
						select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

					select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
						from cob_cuentas..cc_tran_servicio 
						where ts_secuencial = @s_ssn
						and ts_tipo_transaccion = @w_trn --2015
						and ts_clase = 'N'

					insert into cob_cuentas..cc_tran_servicio
					(ts_secuencial,   ts_ssn_branch,     ts_tipo_transaccion,    ts_clase,       ts_tsfecha,     ts_usuario,     ts_terminal, 
					ts_origen,       ts_nodo,           ts_hora,                ts_oficina,     ts_valor,       ts_monto,       ts_cta_banco,
					ts_cod_alterno,  ts_descripcion_ec, ts_causa,               ts_producto,    ts_moneda,      ts_autorizacion,ts_cliente,
					ts_tipocta,      ts_fecha,          ts_correccion,          ts_estado,      ts_ssn_corr,    ts_indicador,   ts_prod_banc,
					ts_oficina_cta,  ts_stick_imp,ts_categoria) 
					values
					(@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn,                'N',            @s_date,        @s_user,        @s_term, 
					@s_org,          @s_srv,            getdate(),              @s_ofi,         @w_val_impuesto, 0,             @i_num_operacion,
					@w_contador,     @w_concepto,       '0',                    @i_producto,    @i_moneda,      @s_user,        @i_ente,
					@i_tipocta,      @i_fecha,          @w_correccion,          @w_estado,      @w_sec_correccion,@w_indicador, @i_prod_banc,
					@i_oficina,      @w_causa_origen, @i_categoria)

					if @@error != 0
					begin
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
								@t_debug    = @t_debug,
								@t_file     = @t_file,
								@t_from     = @w_sp_name,
								@i_num      = 103005
								--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
						end
						return 103005
					end

					if @t_corr = 'S'
					begin
						update cob_cuentas..cc_tran_servicio set ts_estado = @w_estado
							where ts_ssn_branch = @w_sec_correccion
							and ts_tipo_transaccion = @w_trn --2015

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 103005
									--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
							return 103005
						end
					end 
				end			
				--else if @w_impositivo = 'S' and @w_tipo_afectacion = 'T' and (@i_transaccion is null and @i_producto_org in (3, 4))
				--begin
				--	if @i_batch = 'N'
				--	begin
				--		exec cobis..sp_cerror
				--	      	@t_debug    = @t_debug,
				--	      	@t_file     = @t_file,
				--	      	@t_from     = @w_sp_name,					      	
				--	      	@i_num      = 251101
				--	      	-- IMPUESTO NO CORRESPONDE A TIPO DE AFECTACION CONTABLE
				--	end
				--	return 251101
				--end
				else
				begin
					if @t_corr = 'N'
						select 	@w_estado = null, @w_correccion = 'N', 
								@w_sec_correccion = null, @w_nemonico = substring(@w_impuesto,1,4),
								@w_concepto = 'COBRO DE IMPUESTO ' + @w_impuesto
				   else
				   begin
						select 	@w_estado = 'R', @w_correccion = 'S', 
								@w_sec_correccion = @t_ssn_corr, @w_nemonico = 'CORR',
								@w_concepto = 'CORRECCION COBRO DE IMPUESTO ' + @w_impuesto
					end
					
					if @i_estado_cta = 'A'
						select @w_trn = 2015
					else
						if @i_estado_cta = 'I'
							select @w_trn = 2023

                    select @w_indicador = re_codigo from cob_remesas..re_impuestos
                    where re_producto = @i_producto
                    and re_impuesto = @w_impuesto
                    and re_estado = 'V'
                    
					if @@rowcount != 1
					begin
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
								@t_debug        = @t_debug,
								@t_file         = @t_file,
								@t_from         = @w_sp_name,
								@i_num          = 252124
						end
						return 252124
					end

					select @w_causa_origen = ''
					select @w_serv = rtrim(ltrim(@i_servicio))

					if (@w_serv is null)
						select @w_causa_origen = null
					else
					begin
						select @w_longitud = len(@w_serv)
						select @w_longitud = @w_longitud - 2 
						select @w_causa_origen = substring(@w_serv, @w_longitud, 3)
						select @w_causa_origen = convert(varchar, convert(int, @w_causa_origen))
						select @w_causa_origen = rtrim(ltrim(@w_causa_origen))
					end

					select @w_contador = isnull(max(ts_cod_alterno), @w_contador) + 1
						from cob_cuentas..cc_tran_servicio 
						where ts_secuencial = @s_ssn
						and ts_tipo_transaccion = @w_trn --2015
						and ts_clase = 'N'

					insert into cob_cuentas..cc_tran_servicio
							(ts_secuencial, ts_ssn_branch,ts_tipo_transaccion,ts_clase, ts_tsfecha, ts_usuario, ts_terminal, ts_origen,
							ts_nodo, ts_hora, ts_oficina, ts_valor, ts_monto,ts_cta_banco,ts_cod_alterno,ts_descripcion_ec,
							ts_causa, ts_producto, ts_moneda,ts_autorizacion,ts_cliente,ts_tipocta,ts_fecha,ts_correccion,
							ts_estado,ts_ssn_corr,ts_indicador,ts_prod_banc,ts_oficina_cta, ts_stick_imp,ts_categoria)
						values
							(@s_ssn, isnull(@s_ssn_branch, @s_ssn), @w_trn, 'N', @s_date, @s_user, @s_term, @s_org, 
							@s_srv, getdate(),@s_ofi,@w_val_impuesto, 0,@i_num_operacion,@w_contador,@w_concepto, 
							'0',@i_producto,@i_moneda,@s_user,@i_ente,@i_tipocta,@i_fecha,@w_correccion,
							@w_estado, @w_sec_correccion,@w_indicador,@i_prod_banc,@i_oficina, @w_causa_origen,@i_categoria)

					if @@error != 0
					begin
						if @i_batch = 'N'
						begin
							exec cobis..sp_cerror
								@t_debug    = @t_debug,
								@t_file     = @t_file,
								@t_from     = @w_sp_name,
								@i_num      = 103005
								-- ERROR EN CREACION DE TRANSACCION DE SERVICIO
						end
						return 103005
					end

					if @t_corr = 'S'
					begin
						update cob_cuentas..cc_tran_servicio set ts_estado = @w_estado
							where ts_ssn_branch = @w_sec_correccion
							and ts_tipo_transaccion = @w_trn --2015

						if @@error != 0
						begin
							if @i_batch = 'N'
							begin
								exec cobis..sp_cerror
									@t_debug    = @t_debug,
									@t_file     = @t_file,
									@t_from     = @w_sp_name,
									@i_num      = 103005
									--  ERROR EN CREACION DE TRANSACCION DE SERVICIO
							end
							return 103005
						end
					end 
				end
			end  --Fin producto = 3
		end

		select @w_contador = @w_contador + 1

		fetch calimp into
			@w_impuesto,
			@w_monlocal,
			@w_monextranjera,
			@w_moneda_cta,
			@w_impositivo,
			@w_tipo_afectacion
	end
	close calimp
	deallocate calimp

	if (@i_producto = 3)
	begin
	    if @i_estado_cta = 'A'
			select @w_trn = 2015
		else
			if @i_estado_cta = 'I'
				select @w_trn = 2023

        select  @o_alt_monet = isnull(max(tm_cod_alterno), 0) + 1
        from cob_cuentas..cc_tran_monet
        where tm_secuencial = @s_ssn
        and tm_cta_banco = @i_num_operacion

        select @o_alt_serv = isnull(max(ts_cod_alterno), 0) + 1
        from cob_cuentas..cc_tran_servicio 
        where ts_secuencial = @s_ssn
        and ts_tipo_transaccion = @w_trn --2015
        and ts_clase = 'N'
	end
	else if (@i_producto = 4)
	begin
		if @i_estado_cta = 'A'
			select @w_trn = 3128
		else 
		  if @i_estado_cta = 'J'
			 select @w_trn = 3133
		  else
			 if @i_estado_cta = 'I' 
				select @w_trn = 3142

		select 	@o_alt_monet = isnull(max(tm_cod_alterno), 0) + 1
		from cob_ahorros..ah_tran_monet
		where tm_secuencial = @s_ssn
		and tm_cta_banco = @i_num_operacion

		select @o_alt_serv = isnull(max(ts_cod_alterno), 0) + 1
		from cob_ahorros..ah_tran_servicio 
		where ts_secuencial = @s_ssn
		and ts_tipo_transaccion = @w_trn
		and ts_clase = 'N'
	end 

    select @o_saldo_cuenta = @i_saldo_cuenta
    select @o_contable = @i_contable
end  --@i_operacion = 'I'

return 0
go

