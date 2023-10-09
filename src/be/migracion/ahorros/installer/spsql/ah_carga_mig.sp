/***********************************************************************/
/*      Archivo:                        ah_carga_mig.sp                */
/*      Stored procedure:               sp_ah_carga_mig                */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Ahorros                        */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza la carga desde las tablas _EXT hacias las tablas _MIG       */
/* para la migracion.                                                  */
/***********************************************************************/

use cob_externos
go

if exists(select * from sysobjects where name = 'sp_ah_carga_mig')
   drop proc sp_ah_carga_mig
go

create proc sp_ah_carga_mig
as
declare
    @w_sp_name         varchar(30),
    @w_tabla           varchar(30),
    @w_conteo          int,
    @w_contador        int,
    @w_comited         int,
    @w_cuenta          int,
    @w_cta_banco       cuenta,
    @w_estado          varchar(1),
    @w_secuencial      int,
    @w_fecha           datetime,
    @w_ciudad          int,
    @w_producto        tinyint,
    @w_causa           varchar(3),
    @w_banco           smallint, 
    @w_cta_chq         varchar(50), 
    @w_cheque          int,
    @w_rows_to_comit   int,
    @w_coderror        int,
    @w_cta_banco_mig   cuenta

set nocount on
select @w_sp_name        = 'sp_ah_carga_mig',
       @w_rows_to_comit  = 1000,
       @w_coderror       = 283


--------------------------------
-- BORRADO DE LAS TABLAS MIG
--------------------------------
truncate table ah_cuenta_mig
truncate table re_cuenta_contractual_mig
truncate table ah_ctabloqueada_mig
truncate table ah_his_bloqueo_mig
truncate table ah_ciudad_deposito_mig
truncate table ah_his_inmovilizadas_mig 
truncate table ah_val_suspenso_mig
truncate table ah_tran_monet_mig
truncate table ah_his_movimiento_mig
truncate table re_accion_nd_mig
truncate table ah_linea_pendiente_mig
truncate table re_detalle_cheque_mig

-- ----------------------------------------------------------------------
-- AH_CUENTA_MIG
-- ----------------------------------------------------------------------

    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo   = count(1) from ah_cuenta_ext
    if @w_conteo > 0  
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = ah_cuenta, @w_cta_banco_mig = ah_cta_banco from ah_cuenta_ext e
            where  not exists (select 1 from ah_cuenta_mig m where m.ah_cuenta = e.ah_cuenta)
            
            insert into ah_cuenta_mig(
                   ah_cuenta           ,ah_cta_banco           ,ah_estado             ,ah_control            ,ah_filial           ,ah_oficina        ,
                   ah_producto         ,ah_tipo ,ah_moneda     ,ah_fecha_aper         ,ah_oficial            ,ah_cliente          ,ah_ced_ruc        ,
                   ah_nombre           ,ah_categoria           ,ah_tipo_promedio      ,ah_capitalizacion     ,ah_ciclo            ,ah_suspensos      ,
                   ah_bloqueos         ,ah_condiciones         ,ah_monto_bloq         ,ah_num_blqmonto       ,ah_cred_24          ,ah_cred_rem       ,
                   ah_tipo_def         ,ah_default             ,ah_rol_ente           ,ah_disponible         ,ah_12h              ,ah_12h_dif        ,
                   ah_24h              ,ah_48h                 ,ah_remesas,ah_rem_hoy ,ah_interes            ,ah_interes_ganado   ,ah_saldo_libreta  ,
                   ah_saldo_interes    ,ah_saldo_anterior      ,ah_saldo_ult_corte    ,ah_saldo_ayer         ,ah_creditos         ,ah_debitos        ,
                   ah_creditos_hoy     ,ah_debitos_hoy         ,ah_fecha_ult_mov      ,ah_fecha_ult_mov_int  ,ah_fecha_ult_upd    ,ah_fecha_prx_corte,
                   ah_fecha_ult_corte  ,ah_fecha_ult_capi      ,ah_fecha_prx_capita   ,ah_linea,ah_ult_linea ,ah_cliente_ec       ,ah_direccion_ec   ,
                   ah_descripcion_ec   ,ah_tipo_dir,ah_agen_ec ,ah_parroquia          ,ah_zona               ,ah_prom_disponible  ,ah_promedio1      ,
                   ah_promedio2        ,ah_promedio3           ,ah_promedio4          ,ah_promedio5          ,ah_promedio6        ,ah_personalizada  ,
                   ah_contador_trx     ,ah_cta_funcionario     ,ah_tipocta            ,ah_prod_banc          ,ah_origen           ,ah_numlib         ,
                   ah_dep_ini          ,ah_contador_firma      ,ah_telefono           ,ah_int_hoy            ,ah_tasa_hoy         ,ah_min_dispmes    ,
                   ah_fecha_ult_ret    ,ah_cliente1            ,ah_nombre1            ,ah_cedruc1            ,ah_sector           ,ah_monto_imp      ,
                   ah_monto_consumos   ,ah_ctitularidad        ,ah_promotor           ,ah_int_mes            ,ah_tipocta_super    ,ah_direccion_dv   ,
                   ah_descripcion_dv   ,ah_tipodir_dv          ,ah_parroquia_dv       ,ah_zona_dv            ,ah_agen_dv          ,ah_cliente_dv     ,
                   ah_traslado         ,ah_aplica_tasacorp     ,ah_monto_emb          ,ah_monto_ult_capi     ,ah_saldo_mantval    ,ah_cuota          ,
                   ah_creditos2        ,ah_creditos3           ,ah_creditos4          ,ah_creditos5          ,ah_creditos6        ,ah_debitos2       ,
                   ah_debitos3         ,ah_debitos4            ,ah_debitos5           ,ah_debitos6           ,ah_tasa_ayer        ,ah_estado_cuenta  ,
                   ah_permite_sldcero  ,ah_rem_ayer            ,ah_numsol             ,ah_patente            ,ah_fideicomiso      ,ah_nxmil          ,
                   ah_clase_clte       ,ah_deb_mes_ant         ,ah_cred_mes_ant       ,ah_num_deb_mes        ,ah_num_cred_mes     ,ah_num_con_mes    ,
                   ah_num_deb_mes_ant  ,ah_num_cred_mes_ant    ,ah_num_con_mes_ant    ,ah_fecha_ult_proceso  ,ah_cta_banco_rel    ,ah_saldo_max      ,
                   ah_dias_plazo       ,ah_estado_mig          )     
            select ah_cuenta           ,ah_cta_banco           ,ah_estado             ,ah_control            ,ah_filial           ,ah_oficina        ,
                   ah_producto         ,ah_tipo,ah_moneda      ,ah_fecha_aper         ,ah_oficial            ,ah_cliente          ,ah_ced_ruc        ,
                   ah_nombre           ,ah_categoria           ,ah_tipo_promedio      ,ah_capitalizacion     ,ah_ciclo            ,ah_suspensos      ,
                   ah_bloqueos         ,ah_condiciones         ,ah_monto_bloq         ,ah_num_blqmonto       ,ah_cred_24          ,ah_cred_rem       ,
                   ah_tipo_def         ,ah_default             ,ah_rol_ente           ,ah_disponible         ,ah_12h              ,ah_12h_dif        ,
                   ah_24h              ,ah_48h                 ,ah_remesas,ah_rem_hoy ,ah_interes            ,ah_interes_ganado   ,ah_saldo_libreta  ,
                   ah_saldo_interes    ,ah_saldo_anterior      ,ah_saldo_ult_corte    ,ah_saldo_ayer         ,ah_creditos         ,ah_debitos        ,
                   ah_creditos_hoy     ,ah_debitos_hoy         ,ah_fecha_ult_mov      ,ah_fecha_ult_mov_int  ,ah_fecha_ult_upd    ,ah_fecha_prx_corte,
                   ah_fecha_ult_corte  ,ah_fecha_ult_capi      ,ah_fecha_prx_capita   ,ah_linea,ah_ult_linea ,ah_cliente_ec       ,ah_direccion_ec   ,
                   ah_descripcion_ec   ,ah_tipo_dir,ah_agen_ec ,ah_parroquia          ,ah_zona               ,ah_prom_disponible  ,ah_promedio1      ,
                   ah_promedio2        ,ah_promedio3           ,ah_promedio4          ,ah_promedio5          ,ah_promedio6        ,ah_personalizada  ,
                   ah_contador_trx     ,ah_cta_funcionario     ,ah_tipocta            ,ah_prod_banc          ,ah_origen           ,ah_numlib         ,
                   ah_dep_ini          ,ah_contador_firma      ,ah_telefono           ,ah_int_hoy            ,ah_tasa_hoy         ,ah_min_dispmes    ,
                   ah_fecha_ult_ret    ,ah_cliente1            ,ah_nombre1            ,ah_cedruc1            ,ah_sector           ,ah_monto_imp      ,
                   ah_monto_consumos   ,ah_ctitularidad        ,ah_promotor           ,ah_int_mes            ,ah_tipocta_super    ,ah_direccion_dv   ,
                   ah_descripcion_dv   ,ah_tipodir_dv          ,ah_parroquia_dv       ,ah_zona_dv            ,ah_agen_dv          ,ah_cliente_dv     ,
                   ah_traslado         ,ah_aplica_tasacorp     ,ah_monto_emb          ,ah_monto_ult_capi     ,ah_saldo_mantval    ,ah_cuota          ,
                   ah_creditos2        ,ah_creditos3           ,ah_creditos4          ,ah_creditos5          ,ah_creditos6        ,ah_debitos2       ,
                   ah_debitos3         ,ah_debitos4            ,ah_debitos5           ,ah_debitos6           ,ah_tasa_ayer        ,ah_estado_cuenta  ,
                   ah_permite_sldcero  ,ah_rem_ayer            ,ah_numsol             ,ah_patente            ,ah_fideicomiso      ,ah_nxmil          ,
                   ah_clase_clte       ,ah_deb_mes_ant         ,ah_cred_mes_ant       ,ah_num_deb_mes        ,ah_num_cred_mes     ,ah_num_con_mes    ,
                   ah_num_deb_mes_ant  ,ah_num_cred_mes_ant    ,ah_num_con_mes_ant    ,ah_fecha_ult_proceso  ,ah_cta_banco_rel    ,ah_saldo_max      ,
                   ah_dias_plazo       ,null
            from   ah_cuenta_ext
            where  ah_cuenta = @w_cuenta
            if @@error <> 0
            begin
                select @w_tabla = 'ah_cuenta_mig'
                insert into ah_log_mig
                    select convert(varchar, @w_cuenta),
                    @w_tabla,
                    @w_sp_name,
                    NULL,
                    NULL,
                    @w_coderror,
                    @w_cuenta,
                    @w_cta_banco_mig
            end       
            delete from ah_cuenta_ext where ah_cuenta = @w_cuenta
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end

-- ----------------------------------------------------------------------
-- RE_CUENTA_CONTRACTUAL_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo   = count(1) from re_cuenta_contractual_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin 
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cta_banco = e.cc_cta_banco, @w_estado = cc_estado from re_cuenta_contractual_ext e
             where not exists (select 1 from re_cuenta_contractual_mig m where m.cc_cta_banco = e.cc_cta_banco and m.cc_estado = e.cc_estado)
            
            insert into re_cuenta_contractual_mig(
                   cc_modulo          ,cc_profinal     ,cc_cta_banco    ,cc_plazo        ,
                   cc_cuota           ,cc_periodicidad ,cc_monto_final  ,cc_intereses    ,
                   cc_ptos_premio     ,cc_estado       ,cc_categoria    ,cc_fecha_crea   ,
                   cc_periodos_incump ,cc_prodbanc     ,cc_estado_mig)
            select cc_modulo          ,cc_profinal     ,cc_cta_banco    ,cc_plazo        ,
                   cc_cuota           ,cc_periodicidad ,cc_monto_final  ,cc_intereses    ,
                   cc_ptos_premio     ,cc_estado       ,cc_categoria    ,cc_fecha_crea   ,
                   cc_periodos_incump ,cc_prodbanc     ,null
            from   re_cuenta_contractual_ext
            where  cc_cta_banco = @w_cta_banco 
            and    cc_estado    = @w_estado
            if @@error <> 0
            begin
                select @w_tabla = 're_cuenta_contractual_mig'
                insert into ah_log_mig
                    select @w_cta_banco,
                           @w_tabla,
                           @w_sp_name,
                           'cc_estado',
                           @w_estado,
                           @w_coderror,
                           null,
                           @w_cta_banco
            end       
            delete from re_cuenta_contractual_ext where cc_cta_banco = @w_cta_banco and cc_estado = @w_estado
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_CTABLOQUEADA_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo = count(1) from ah_ctabloqueada_ext
    if @w_conteo > 0  
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = e.cb_cuenta, @w_secuencial = e.cb_secuencial from ah_ctabloqueada_ext e
             where not exists (select 1 from ah_ctabloqueada_mig m where m.cb_cuenta = e.cb_cuenta and m.cb_secuencial = e.cb_secuencial)
            
            insert into ah_ctabloqueada_mig(
                   cb_cuenta       ,cb_secuencial   ,cb_tipo_bloqueo ,cb_fecha    ,cb_hora         ,
                   cb_autorizante  ,cb_solicitante  ,cb_oficina      ,cb_estado   ,cb_causa        ,
                   cb_sec_asoc     ,cb_observacion  ,cb_estado_mig   )
            select cb_cuenta       ,cb_secuencial   ,cb_tipo_bloqueo ,cb_fecha    ,cb_hora         ,
                   cb_autorizante  ,cb_solicitante  ,cb_oficina      ,cb_estado   ,cb_causa        ,
                   cb_sec_asoc     ,cb_observacion  ,null
            from   ah_ctabloqueada_ext
            where  cb_cuenta     = @w_cuenta
            and    cb_secuencial = @w_secuencial
            if @@error <> 0
            begin
                select @w_tabla = 'ah_ctabloqueada_mig'
                insert into ah_log_mig
                    select convert(varchar, @w_cuenta),
                           @w_tabla,
                           @w_sp_name,
                           'cb_secuencial',
                           convert(varchar,@w_secuencial),
                           @w_coderror,
                           @w_cuenta,
                           null
            end       
            delete from ah_ctabloqueada_ext where cb_cuenta = @w_cuenta and cb_secuencial = @w_secuencial
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_HIS_BLOQUEO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_his_bloqueo_ext
    if @w_conteo > 0
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = e.hb_cuenta, @w_secuencial = e.hb_secuencial from ah_his_bloqueo_ext e
            where  not exists (select 1 from ah_his_bloqueo_mig m where m.hb_cuenta = e.hb_cuenta and m.hb_secuencial = e.hb_secuencial)
            
            insert into ah_his_bloqueo_mig(
                   hb_cuenta       ,hb_secuencial   ,hb_valor        ,hb_monto_bloq   ,hb_fecha        ,hb_fecha_ven    ,
                   hb_hora         ,hb_autorizante  ,hb_solicitante  ,hb_oficina      ,hb_causa        ,hb_saldo        ,
                   hb_accion       ,hb_levantado    ,hb_sec_asoc     ,hb_observacion  ,hb_ngarantia    ,hb_nlinea_sob   ,
                   hb_numcte       ,hb_estado_mig   )
            select hb_cuenta       ,hb_secuencial   ,hb_valor        ,hb_monto_bloq   ,hb_fecha        ,hb_fecha_ven    ,
                   hb_hora         ,hb_autorizante  ,hb_solicitante  ,hb_oficina      ,hb_causa        ,hb_saldo        ,
                   hb_accion       ,hb_levantado    ,hb_sec_asoc     ,hb_observacion  ,hb_ngarantia    ,hb_nlinea_sob   ,
                   hb_numcte       ,null
            from   ah_his_bloqueo_ext
            where  hb_cuenta     = @w_cuenta
            and    hb_secuencial = @w_secuencial
            if @@error <> 0
            begin
                select @w_tabla = 'ah_his_bloqueo_mig'
                insert into ah_log_mig
                    select convert(varchar, @w_cuenta),
                           @w_tabla,
                           @w_sp_name,
                           'hb_secuencial',
                           convert(varchar,@w_secuencial),
                           @w_coderror,
                           @w_cuenta,
                           null
            end       
            delete from ah_his_bloqueo_ext where hb_cuenta = @w_cuenta and hb_secuencial = @w_secuencial
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end

-- ----------------------------------------------------------------------
-- AH_CIUDAD_DEPOSITO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_ciudad_deposito_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = e.cd_cuenta, @w_ciudad = e.cd_ciudad, @w_fecha = cd_fecha_depo from ah_ciudad_deposito_ext e
            where  not exists (select 1 from ah_ciudad_deposito_mig m where m.cd_cuenta = e.cd_cuenta and m.cd_ciudad = e.cd_ciudad and m.cd_fecha_depo = e.cd_fecha_depo)
            
            insert into ah_ciudad_deposito_mig(
                   cd_cuenta        ,cd_ciudad      ,cd_fecha_depo  ,cd_fecha_efe   ,cd_valor   ,cd_efectivizado, 
                   cd_valor_efe     ,cd_estado_mig)
            select cd_cuenta        ,cd_ciudad      ,cd_fecha_depo  ,cd_fecha_efe   ,cd_valor   ,cd_efectivizado, 
                   cd_valor_efe     ,null 
            from   ah_ciudad_deposito_ext
            where  cd_cuenta     = @w_cuenta 
            and    cd_ciudad     = @w_ciudad 
            and    cd_fecha_depo = @w_fecha
            if @@error <> 0
            begin
                select @w_tabla = 'ah_ciudad_deposito_mig'
                insert into ah_log_mig
                    select convert(varchar, @w_fecha, 101),
                           @w_tabla,
                           @w_sp_name,
                           'cd_ciudad',
                           convert(varchar,@w_ciudad),
                           @w_coderror,
                           @w_cuenta,
                           null
            end       
            delete from ah_ciudad_deposito_ext where cd_cuenta = @w_cuenta and cd_ciudad = @w_ciudad and cd_fecha_depo = @w_fecha
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end

-- ----------------------------------------------------------------------
-- AH_HIS_INMOVILIZADAS_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_his_inmovilizadas_ext
    if @w_conteo > 0
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cta_banco = e.hi_cuenta, @w_fecha = e.hi_fecha from ah_his_inmovilizadas_ext e
            where  not exists (select 1 from ah_his_inmovilizadas_mig m where m.hi_cuenta = e.hi_cuenta and m.hi_fecha = e.hi_fecha)

            insert into ah_his_inmovilizadas_mig(hi_cuenta, hi_saldo, hi_fecha, hi_estado_mig)
            select hi_cuenta, hi_saldo, hi_fecha, null
            from   ah_his_inmovilizadas_ext
            where  hi_cuenta = @w_cta_banco and hi_fecha = @w_fecha
            if @@error <> 0
            begin
                select @w_tabla = 'ah_his_inmovilizadas_mig'
                insert into ah_log_mig
                select  @w_cta_banco,
                        @w_tabla,
                        @w_sp_name,
                        'hi_fecha',
                        convert(varchar,@w_fecha,101),
                        @w_coderror,
                        null,
                        @w_cta_banco
            end       
            delete from ah_his_inmovilizadas_ext where hi_cuenta = @w_cta_banco and hi_fecha = @w_fecha
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_VAL_SUSPENSO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_val_suspenso_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = e.vs_cuenta, @w_secuencial = e.vs_secuencial from ah_val_suspenso_ext e
            where  not exists (select 1 from ah_val_suspenso_mig m where m.vs_cuenta = e.vs_cuenta and m.vs_secuencial = e.vs_secuencial)
            
            insert into ah_val_suspenso_mig(
                   vs_cuenta       ,vs_secuencial   ,vs_servicio     ,vs_valor        ,vs_oficina      ,vs_fecha        ,
                   vs_hora         ,vs_ssn          ,vs_estado       ,vs_procesada    ,vs_clave        ,vs_impuesto     ,
                   vs_estado_mig)
            select vs_cuenta       ,vs_secuencial   ,vs_servicio     ,vs_valor        ,vs_oficina      ,vs_fecha        ,
                   vs_hora         ,vs_ssn          ,vs_estado       ,vs_procesada    ,vs_clave        ,vs_impuesto     ,
                   null 
            from   ah_val_suspenso_ext
            where  vs_cuenta = @w_cuenta and vs_secuencial = @w_secuencial
            if @@error <> 0
            begin
                select @w_tabla = 'ah_val_suspenso_mig'
                insert into ah_log_mig
                select convert(varchar, @w_cuenta),
                        @w_tabla,
                        @w_sp_name,
                        '@w_secuencial',
                        convert(varchar,@w_secuencial),
                        @w_coderror,
                        @w_cuenta,
                        null
            end       
            delete from ah_val_suspenso_ext where vs_cuenta = @w_cuenta and vs_secuencial = @w_secuencial
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_TRAN_MONET_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_tran_monet_ext
    
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cta_banco = e.tm_cta_banco, @w_secuencial = e.tm_secuencial, @w_cuenta = tm_cod_alterno from ah_tran_monet_ext e
            where  not exists (select 1 from ah_tran_monet_mig m where m.tm_cta_banco = e.tm_cta_banco and m.tm_secuencial = e.tm_secuencial and m.tm_cod_alterno = e.tm_cod_alterno)
            
            insert into ah_tran_monet_mig(
                   tm_fecha           ,tm_secuencial       ,tm_ssn_branch       ,tm_cod_alterno          ,tm_tipo_tran       ,tm_filial          ,
                   tm_oficina         ,tm_usuario          ,tm_terminal         ,tm_correccion           ,tm_sec_correccion  ,tm_origen          ,
                   tm_nodo            ,tm_reentry          ,tm_signo            ,tm_fecha_ult_mov        ,tm_cta_banco       ,tm_valor           ,
                   tm_chq_propios     ,tm_chq_locales      ,tm_chq_ot_plazas    ,tm_remoto_ssn           ,tm_moneda          ,tm_efectivo        ,
                   tm_indicador       ,tm_causa            ,tm_departamento     ,tm_saldo_lib            ,tm_saldo_contable  ,tm_saldo_disponible,
                   tm_saldo_interes   ,tm_fecha_efec       ,tm_interes          ,tm_control              ,tm_ctadestino      ,tm_tipo_xfer       ,
                   tm_estado          ,tm_concepto         ,tm_oficina_cta      ,tm_hora                 ,tm_banco           ,tm_valor_comision  ,
                   tm_prod_banc       ,tm_categoria        ,tm_monto_imp        ,tm_tipo_exonerado_imp   ,tm_serial          ,tm_tipocta_super   ,
                   tm_turno           ,tm_cheque           ,tm_forma_pg         ,tm_canal                ,tm_stand_in        ,tm_oficial         ,
                   tm_clase_clte      ,tm_cliente          ,tm_base_gmf         ,tm_estado_mig)
            select tm_fecha           ,tm_secuencial       ,tm_ssn_branch       ,tm_cod_alterno          ,tm_tipo_tran       ,tm_filial          ,
                   tm_oficina         ,tm_usuario          ,tm_terminal         ,tm_correccion           ,tm_sec_correccion  ,tm_origen          ,
                   tm_nodo            ,tm_reentry          ,tm_signo            ,tm_fecha_ult_mov        ,tm_cta_banco       ,tm_valor           ,
                   tm_chq_propios     ,tm_chq_locales      ,tm_chq_ot_plazas    ,tm_remoto_ssn           ,tm_moneda          ,tm_efectivo        ,
                   tm_indicador       ,tm_causa            ,tm_departamento     ,tm_saldo_lib            ,tm_saldo_contable  ,tm_saldo_disponible,
                   tm_saldo_interes   ,tm_fecha_efec       ,tm_interes          ,tm_control              ,tm_ctadestino      ,tm_tipo_xfer       ,
                   tm_estado          ,tm_concepto         ,tm_oficina_cta      ,tm_hora                 ,tm_banco           ,tm_valor_comision  ,
                   tm_prod_banc       ,tm_categoria        ,tm_monto_imp        ,tm_tipo_exonerado_imp   ,tm_serial          ,tm_tipocta_super   ,
                   tm_turno           ,tm_cheque           ,tm_forma_pg         ,tm_canal                ,tm_stand_in        ,tm_oficial         ,
                   tm_clase_clte      ,tm_cliente          ,tm_base_gmf         ,null 
            from   ah_tran_monet_ext
            where  tm_cta_banco = @w_cta_banco and tm_secuencial = @w_secuencial 
            if @@error <> 0
            begin
                select @w_tabla = 'ah_tran_monet_mig'
                insert into ah_log_mig
                select  @w_cta_banco,
                        @w_tabla,
                        @w_sp_name,
                        'tm_secuencial',
                        convert(varchar,@w_secuencial),
                        @w_coderror,
                        null,
                        @w_cta_banco
            end       
            delete from ah_tran_monet_ext where tm_cta_banco = @w_cta_banco and tm_secuencial = @w_secuencial 
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_HIS_MOVIMIENTO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_his_movimiento_ext
    if @w_conteo > 0
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cta_banco = e.hm_cta_banco, @w_secuencial = e.hm_secuencial, @w_fecha = e.hm_fecha from ah_his_movimiento_ext e
            where  not exists (select 1 from ah_his_movimiento_mig m where m.hm_cta_banco = e.hm_cta_banco and m.hm_secuencial = e.hm_secuencial and m.hm_fecha = e.hm_fecha)
            
            insert into ah_his_movimiento_mig(
                   hm_fecha        , hm_secuencial , hm_ssn_branch   ,  hm_cod_alterno       , hm_tipo_tran     , hm_filial          ,
                   hm_oficina      , hm_usuario    , hm_terminal     ,  hm_correccion        , hm_sec_correccion, hm_origen          ,
                   hm_nodo         , hm_reentry    , hm_signo        ,  hm_fecha_ult_mov     , hm_cta_banco     , hm_valor           ,
                   hm_chq_propios  , hm_chq_locales, hm_chq_ot_plazas,  hm_remoto_ssn        , hm_moneda        , hm_efectivo        ,
                   hm_indicador    , hm_causa      , hm_departamento ,  hm_saldo_lib         , hm_saldo_contable, hm_saldo_disponible,
                   hm_saldo_interes, hm_fecha_efec , hm_interes      ,  hm_control           , hm_ctadestino    , hm_tipo_xfer       ,
                   hm_estado       , hm_concepto   , hm_oficina_cta  ,  hm_hora              , hm_banco         , hm_valor_comision  ,
                   hm_prod_banc    , hm_categoria  , hm_monto_imp    ,  hm_tipo_exonerado_imp, hm_serial        , hm_tipocta_super   ,
                   hm_turno        , hm_cheque     , hm_canal        ,  hm_stand_in          , hm_oficial       , hm_clase_clte      ,
                   hm_cliente      , hm_base_gmf   , hm_transaccion  ,  hm_estado_mig)
            select hm_fecha        , hm_secuencial , hm_ssn_branch   ,  hm_cod_alterno       , hm_tipo_tran     , hm_filial          ,
                   hm_oficina      , hm_usuario    , hm_terminal     ,  hm_correccion        , hm_sec_correccion, hm_origen          ,
                   hm_nodo         , hm_reentry    , hm_signo        ,  hm_fecha_ult_mov     , hm_cta_banco     , hm_valor           ,
                   hm_chq_propios  , hm_chq_locales, hm_chq_ot_plazas,  hm_remoto_ssn        , hm_moneda        , hm_efectivo        ,
                   hm_indicador    , hm_causa      , hm_departamento ,  hm_saldo_lib         , hm_saldo_contable, hm_saldo_disponible,
                   hm_saldo_interes, hm_fecha_efec , hm_interes      ,  hm_control           , hm_ctadestino    , hm_tipo_xfer       ,
                   hm_estado       , hm_concepto   , hm_oficina_cta  ,  hm_hora              , hm_banco         , hm_valor_comision  ,
                   hm_prod_banc    , hm_categoria  , hm_monto_imp    ,  hm_tipo_exonerado_imp, hm_serial        , hm_tipocta_super   ,
                   hm_turno        , hm_cheque     , hm_canal        ,  hm_stand_in          , hm_oficial       , hm_clase_clte      ,
                   hm_cliente      , hm_base_gmf   , hm_transaccion  ,  NULL 
            from   ah_his_movimiento_ext
            where  hm_cta_banco = @w_cta_banco and hm_secuencial = @w_secuencial and hm_fecha = @w_fecha 
            if @@error <> 0
            begin
                select @w_tabla = 'ah_his_movimiento_mig'
                insert into ah_log_mig
                select  @w_cta_banco,
                        @w_tabla,
                        @w_sp_name,
                        'hm_fecha',
                        convert(varchar,@w_fecha,101),
                        @w_coderror,
                        @w_secuencial,
                        @w_cta_banco
            end       
            delete from ah_his_movimiento_ext where hm_cta_banco = @w_cta_banco and hm_secuencial = @w_secuencial and hm_fecha = @w_fecha 
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- RE_ACCION_ND_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from re_accion_nd_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_producto = e.an_producto, @w_causa = e.an_causa from re_accion_nd_ext e
            where  not exists (select 1 from re_accion_nd_mig m where m.an_producto = e.an_producto and m.an_causa = e.an_causa)
            
            insert into re_accion_nd_mig(an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin, an_estado_mig)
            select an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin, null
            from   re_accion_nd_ext
            where  an_producto = @w_producto and an_causa = @w_causa
            if @@error <> 0
            begin
                select @w_tabla = 're_accion_nd_mig'
                insert into ah_log_mig
                select  @w_causa,
                        @w_tabla,
                        @w_sp_name,
                        'an_producto',
                        convert(varchar,@w_producto),
                        @w_coderror,
                        null,
                        null
            end       
            delete from re_accion_nd_ext where an_producto = @w_producto and an_causa = @w_causa
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
    
-- ----------------------------------------------------------------------
-- AH_LINEA_PENDIENTE_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from ah_linea_pendiente_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cuenta = e.lp_cuenta, @w_secuencial = e.lp_linea from ah_linea_pendiente_ext e
            where  not exists (select 1 from ah_linea_pendiente_mig m where m.lp_cuenta = e.lp_cuenta and m.lp_linea = e.lp_linea)
            
            insert into ah_linea_pendiente_mig (
                   lp_cuenta ,  lp_linea,   lp_nemonico,    lp_valor     ,  lp_fecha,
                   lp_control,  lp_signo,   lp_enviada ,    lp_estado_mig)
            select lp_cuenta ,  lp_linea,   lp_nemonico,    lp_valor     ,  lp_fecha,
                   lp_control,  lp_signo,   lp_enviada ,    null 
            from   ah_linea_pendiente_ext
            where  lp_cuenta = @w_cuenta and lp_linea = @w_secuencial
            if @@error <> 0
            begin
                select @w_tabla = 'ah_linea_pendiente_mig'
                insert into ah_log_mig
                select  convert(varchar,@w_cuenta),
                        @w_tabla,
                        @w_sp_name,
                        'lp_linea',
                        convert(varchar,@w_secuencial),
                        @w_coderror,
                        @w_cuenta,
                        null
            end       
            delete from ah_linea_pendiente_ext where lp_cuenta = @w_cuenta and lp_linea = @w_secuencial
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end

-- ----------------------------------------------------------------------
-- RE_DETALLE_CHEQUE_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from re_detalle_cheque_ext
    if @w_conteo > 0 
    begin
        begin tran
        while not @w_contador = @w_conteo
        begin  
            if @w_comited = @w_rows_to_comit
            begin
                select @w_comited = 0
                commit tran
                select @@TRANCOUNT
                begin tran
            end
            
            -- ------------------------------------------------------------------
            -- - Cargo tabla MIG
            -- ------------------------------------------------------------------
            select @w_cta_banco = dc_cta_banco, @w_banco = dc_co_banco, @w_cta_chq = dc_cta_cheque, @w_cheque = dc_num_cheque  
            from   re_detalle_cheque_ext e
            where  not exists (select 1 from re_detalle_cheque_mig m 
                               where m.dc_cta_banco  = e.dc_cta_banco 
                               and   m.dc_co_banco   = e.dc_co_banco 
                               and   m.dc_cta_cheque = e.dc_cta_cheque 
                               and   m.dc_num_cheque = e.dc_num_cheque)

            insert into re_detalle_cheque_mig (
                   dc_filial       , dc_oficina   , dc_fecha       , dc_fecha_efe       , dc_id         ,  dc_trn       ,
                   dc_numctrl      , dc_secuencial, dc_ssn         , dc_ssn_branch      , dc_cta_banco  ,  dc_producto  ,
                   dc_tipo         , dc_tipo_chq  , dc_co_banco    , dc_no_banco        , dc_cta_cheque ,  dc_num_cheque,
                   dc_valor        , dc_moneda    , dc_fechaemision, dc_estado          , dc_user       ,  dc_hora      ,
                   dc_detalle      , dc_factor    , dc_cotizacion  , dc_valor_convertido, dc_mon_destino,  dc_estado_mig)
            select 
                   dc_filial       , dc_oficina   , dc_fecha       , dc_fecha_efe       , dc_id         ,  dc_trn       ,
                   dc_numctrl      , dc_secuencial, dc_ssn         , dc_ssn_branch      , dc_cta_banco  ,  dc_producto  ,
                   dc_tipo         , dc_tipo_chq  , dc_co_banco    , dc_no_banco        , dc_cta_cheque ,  dc_num_cheque,
                   dc_valor        , dc_moneda    , dc_fechaemision, dc_estado          , dc_user       ,  dc_hora      ,
                   dc_detalle      , dc_factor    , dc_cotizacion  , dc_valor_convertido, dc_mon_destino,  null 
            from   re_detalle_cheque_ext
            where (dc_cta_banco  = @w_cta_banco or @w_cta_banco is null)
            and    dc_co_banco   = @w_banco
            and    dc_cta_cheque = @w_cta_chq
            and   (dc_num_cheque = @w_cheque or @w_cheque is null)
            if @@error <> 0
            begin
                select @w_tabla = 're_detalle_cheque_mig'
                insert into ah_log_mig
                select  @w_cta_banco,
                        @w_tabla,
                        @w_sp_name,
                        'dc_cta_cheque',
                        @w_cta_chq,
                        @w_coderror,
                        @w_cheque,
                        @w_cta_banco
            end       
            delete from re_detalle_cheque_ext 
            where (dc_cta_banco  = @w_cta_banco or @w_cta_banco is null)
            and    dc_co_banco   = @w_banco
            and    dc_cta_cheque = @w_cta_chq
            and   (dc_num_cheque = @w_cheque or @w_cheque is null)
            
            select @w_contador = @w_contador + 1
            select @w_comited = @w_comited + 1 
        end
        commit tran
    end
   
return 0

go