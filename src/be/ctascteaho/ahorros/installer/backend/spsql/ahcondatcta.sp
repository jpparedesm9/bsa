/********************************************************************/
/*  Archivo:            ahcondatcta.sp                              */
/*  Stored procedure:   sp_cons_datos_cuenta                        */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           CUENTAS DE AHORROS                          */
/*  Fecha de escritura: 15-Agosto-2016                              */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa realiza la consulta de los campos necesarios      */
/*  para la impresion de los contratos de apertura de cuentas       */
/*  dado un numero de cuenta                                        */
/********************************************************************/
/*                      MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                           */
/*  15/Ago/2016     Dfu             Emision Inicial                 */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cons_datos_cuenta')
  drop proc sp_cons_datos_cuenta
go

/****** Object:  StoredProcedure [dbo].[sp_cons_datos_cuenta]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_cons_datos_cuenta
(
    @s_ssn                 int = null,
    @s_date                datetime = null,
    @s_user                login = null,
    @s_term                descripcion = null,
    @s_corr                char(1) = null,
    @s_ssn_corr            int = null,
    @s_ofi                 smallint = null,
    @t_rty                 char(1) = null,
    @t_trn                 smallint = null,
    @t_debug               char(1) = 'N',
    @t_file                varchar(14) = null,
    @t_from                varchar(30) = null,
    @t_show_version        bit = 0,
    @i_operacion           char(1) = 'Q',
    @i_mon                 tinyint,
    @i_cta_banco           cuenta
)
as

    declare @w_return     int,
            @w_sp_name    varchar(32)
    
    select  @w_sp_name = 'sp_cons_datos_cuenta'

    -- Versionamiento del Programa --
    if @t_show_version = 1
    begin
        print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
        return 0
    end

    if (@t_trn <> 538 and @i_operacion = 'Q')
    begin
        /* 'Tipo de transaccion no corresponde' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
        return 1
    end
    
    if @i_operacion = 'Q'
    begin
        select ah_cuenta          ,  ah_cta_banco      ,   ah_estado         ,   ah_control,
               ah_filial          ,  ah_oficina        ,   ah_producto       ,   ah_tipo,
               ah_moneda          ,  
               convert(varchar(10),ah_fecha_aper,101) as ah_fecha_aper,   
               ah_oficial         ,  ah_cliente,
               ah_ced_ruc         ,  ah_nombre         ,   ah_categoria      ,   ah_tipo_promedio, 
               ah_capitalizacion  ,  ah_ciclo          ,   ah_suspensos      ,   ah_bloqueos, 
               ah_condiciones     ,  ah_monto_bloq     ,   ah_num_blqmonto   ,   ah_cred_24, 
               ah_cred_rem        ,  ah_tipo_def       ,   ah_default        ,   ah_rol_ente, 
               ah_disponible      ,  ah_12h            ,   ah_12h_dif        ,   ah_24h, 
               ah_48h             ,  ah_remesas        ,   ah_rem_hoy        ,   ah_interes, 
               ah_interes_ganado  ,  ah_saldo_libreta  ,   ah_saldo_interes  ,   ah_saldo_anterior, 
               ah_saldo_ult_corte ,  ah_saldo_ayer     ,   ah_creditos       ,   ah_debitos, 
               ah_creditos_hoy    ,  ah_debitos_hoy    ,   
               convert(varchar(10),ah_fecha_ult_mov,101)     as ah_fecha_ult_mov,  
               convert(varchar(10),ah_fecha_ult_mov_int,101) as ah_fecha_ult_mov_int,  
               convert(varchar(10),ah_fecha_ult_upd,101)     as ah_fecha_ult_upd,  
               convert(varchar(10),ah_fecha_prx_corte,101)   as ah_fecha_prx_corte,   
               convert(varchar(10),ah_fecha_ult_corte,101)   as ah_fecha_ult_corte,
               convert(varchar(10),ah_fecha_ult_capi,101)    as ah_fecha_ult_capi,     
               convert(varchar(10),ah_fecha_prx_capita,101)  as ah_fecha_prx_capita,
               ah_linea           ,   ah_ult_linea      ,   ah_cliente_ec, 
               ah_direccion_ec    ,  ah_descripcion_ec ,   ah_tipo_dir       ,   ah_agen_ec, 
               ah_parroquia       ,  ah_zona           ,   ah_prom_disponible,   ah_promedio1, 
               ah_promedio2       ,  ah_promedio3      ,   ah_promedio4      ,   ah_promedio5, 
               ah_promedio6       ,  ah_personalizada  ,   ah_contador_trx   ,   ah_cta_funcionario, 
               ah_tipocta         ,  ah_prod_banc      ,   ah_origen         ,   ah_numlib, 
               ah_dep_ini         ,  ah_contador_firma ,   ah_telefono       ,   ah_int_hoy, 
               ah_tasa_hoy        ,  ah_min_dispmes    ,   convert(varchar(10),ah_fecha_ult_ret,101) as ah_fecha_ult_ret, ah_cliente1, 
               ah_nombre1         ,  ah_cedruc1        ,   ah_sector         ,   ah_monto_imp, 
               ah_monto_consumos  ,  ah_ctitularidad   ,   ah_promotor       ,   ah_int_mes, 
               ah_tipocta_super   ,  ah_direccion_dv   ,   ah_descripcion_dv ,   ah_tipodir_dv, 
               ah_parroquia_dv    ,  ah_zona_dv        ,   ah_agen_dv        ,   ah_cliente_dv, 
               ah_traslado        ,  ah_aplica_tasacorp,   ah_monto_emb      ,   ah_monto_ult_capi, 
               ah_saldo_mantval   ,  ah_cuota          ,   ah_creditos2      ,   ah_creditos3, 
               ah_creditos4       ,  ah_creditos5      ,   ah_creditos6      ,   ah_debitos2, 
               ah_debitos3        ,  ah_debitos4       ,   ah_debitos5       ,   ah_debitos6, 
               ah_tasa_ayer       ,  ah_estado_cuenta  ,   ah_permite_sldcero,   ah_rem_ayer, 
               ah_numsol          ,  ah_patente        ,   ah_fideicomiso    ,   ah_nxmil, 
               ah_clase_clte      ,  ah_deb_mes_ant    ,   ah_cred_mes_ant   ,   ah_num_deb_mes, 
               ah_num_cred_mes    ,  ah_num_con_mes    ,   ah_num_deb_mes_ant,   ah_num_cred_mes_ant, 
               ah_num_con_mes_ant ,  convert(varchar(10),ah_fecha_ult_proceso,101) as ah_fecha_ult_proceso,
               of_ciudad          ,  ci_descripcion 
        from   cob_ahorros..ah_cuenta,
               cobis..cl_oficina,
               cobis..cl_ciudad
        where  ah_oficina   = of_oficina 
          and  ah_filial    = of_filial
          and  of_ciudad    = ci_ciudad 
          and  ah_cta_banco = @i_cta_banco
          and  ah_moneda    = @i_mon
    end
    
    return 0

go
