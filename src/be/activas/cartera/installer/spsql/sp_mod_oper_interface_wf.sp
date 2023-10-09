/************************************************************************/
/*   Archivo:              sp_mod_oper_interface_wf.sp                */
/*   Stored procedure:     sp_mod_oper_interface_wf                   */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         PEDRO ROMERO                                 */
/*   Fecha de escritura:   13/01/2021                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*	Interface para actualizar diferentes tipos de operacion				*/
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      JAN-13-2021    PRO              Emision Inicial                 */
/************************************************************************/

use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_mod_oper_interface_wf')
    drop proc sp_mod_oper_interface_wf
go

create proc sp_mod_oper_interface_wf(
   @s_srv                   varchar(30),
   @s_lsrv                  varchar(30),
   @s_ssn                   int,
   @s_user                  login,
   @s_term                  varchar(30),
   @s_date                  datetime,
   @s_sesn                  int,
   @s_ofi                   smallint,
   @t_debug     char(1)     = 'N',
   @t_file      varchar(10) = null,    
   ---------------------------------------
   @t_trn                   int          = null,
   ---------------------------------------
   @i_operacion             varchar(1)   = null,   --*
   @i_calcular_tabla        varchar(1)   = 'N',
   @i_tabla_nueva           varchar(1)   = 'S',
   @i_operacionca           int          = null,
   @i_banco                 cuenta       = null,
   @i_tipo                  varchar(1)   = 'O',
   @i_anterior              cuenta       = null,
   @i_migrada               cuenta       = null,
   @i_tramite               int          = null,
   @i_cliente               int 	     = 0,
   @i_nombre                descripcion  = null,
   --@i_codeudor            int 	     = 0,
   @i_sector                catalogo     = null,
   @i_toperacion            catalogo     = null,
   @i_oficina               smallint     = null,
   @i_moneda                tinyint      = null,
   @i_comentario            varchar(255) = null,
   @i_oficial               smallint     = null,
   @i_fecha_ini             datetime     = null,
   @i_fecha_fin             datetime     = null,    --*
   @i_fecha_ult_proceso     datetime     = null,    --*
   @i_fecha_liq             datetime     = null,    --*
   @i_fecha_reajuste        datetime     = null,    --*
   @i_monto                 money        = null,
   @i_monto_aprobado        money        = null,
   @i_destino               catalogo     = null,
   @i_lin_credito           cuenta       = null,
   @i_ciudad                int          = null,
   @i_estado                tinyint      = null,
   @i_periodo_reajuste      smallint     = 0,
   @i_reajuste_especial     varchar(1)   = 'N',     --*
   @i_forma_pago            catalogo     = null,
   @i_cuenta                cuenta       = null,
   @i_dias_anio             smallint     = null,    --*
   @i_tipo_amortizacion     varchar(10)  = null, --*
   @i_cuota_completa        varchar(1)   = null, --*
   @i_tipo_cobro            varchar(1)   = null, --*
   @i_tipo_reduccion        varchar(1)   = null, --*
   @i_aceptar_anticipos     varchar(1)   = null, --*
   @i_precancelacion        varchar(1)   = null, --*
   @i_tipo_aplicacion       varchar(1)   = null, --*
   @i_tplazo                catalogo     = null,    --*
   @i_plazo                 int          = null,    --*
   @i_tdividendo            catalogo     = null,    --*
   @i_periodo_cap           int          = null,    --*
   @i_periodo_int           int          = null,    --*
   @i_dist_gracia           varchar(1)   = null,    --*
   @i_gracia_cap            int          = null,    --*
   @i_gracia_int            int          = null,    --*
   @i_dia_fijo              int          = null,    --*
   @i_cuota                 money        = null,    --*
   @i_evitar_feriados       varchar(1)   = null,    --*
   @i_num_renovacion        int          = 0,       --* 
   @i_renovacion            varchar(1)   = null,    --*
   @i_mes_gracia            tinyint      = null,    --*
   @i_upd_clientes          varchar(1)   = 'U',     --*
   @i_dias_gracia           smallint     = null,    --*
   @i_reajustable           varchar(1)   = null,    --*
   @i_es_interno            varchar(1)   = 'N',     --*
   @i_formato_fecha         int          = 101,
   @i_no_banco 	            varchar(1)   = 'S',
   @i_grupal                char(1)	     = null,
   @i_banca                 catalogo     = null,
   @i_en_linea              varchar(1)   = 'S',
   @i_externo               varchar(1)   = 'S',
   @i_desde_web             varchar(1)   = 'S',
   @i_salida                varchar(1)   = 'N',
   @i_promocion             char(1)      = null, --LPO Santander
   @i_acepta_ren            char(1)      = null, --LPO Santander
   @i_no_acepta             char(1000)   = null, --LPO Santander
   @i_emprendimiento        char(1)      = null, --LPO Santander
   @i_garantia              float        = null, --LPO Santander
   @i_alianza               int          = null, --Santander -- tr_alianza  
   @i_ciudad_destino        int          = null, --Santander
   @i_experiencia_cli       char(1)      = null, --Santander
   @i_monto_max_tr          money        = null, --Santander
   @i_desplazamiento  	    int            = null,
   ---------------------------------------
   @o_banco                 cuenta      = null out,
   @o_operacion             int         = null out,
   @o_tramite               int         = null out,
   @o_plazo                 smallint    = null out,
   @o_tplazo                catalogo    = null out,
   @o_cuota                 money       = null out,
   @o_msg                   varchar(100)= null out,
   @o_tasa_grp              varchar(255)= null out
)as

declare
   @w_sp_name                  varchar(64),
   @w_return                   int,
   @w_error                    int,
   @w_fecha_proceso            datetime,
   @w_operacion                int,
   @w_banco                    cuenta,
   @w_ciudad				   int

if  @i_ciudad is null or @i_ciudad = 0 begin
   select @i_ciudad = of_ciudad
   from cobis..cl_oficina
   where of_oficina = @i_oficina
   
   SELECT @w_ciudad=tr_ciudad 
   FROM cob_credito..cr_tramite 
   WHERE tr_tramite=@i_tramite
   
   if(@w_ciudad is not null and @w_ciudad > 0)
		select @i_ciudad = @w_ciudad
end

if(@i_tipo = 'O')
begin
	exec @w_return = sp_modificar_oper_sol_wf
	   @s_srv   					=	   @s_srv   ,
	   @s_lsrv  					=	   @s_lsrv  ,
	   @s_ssn   					=	   @s_ssn   ,
	   @s_user  					=	   @s_user  ,
	   @s_term  					=	   @s_term  ,
	   @s_date  					=	   @s_date  ,
	   @s_sesn  					=	   @s_sesn  ,
	   @s_ofi   					=	   @s_ofi   ,
	   @t_debug 					=	   @t_debug ,
	   @t_file  					=	   @t_file  ,
	   @t_trn                   	=	   @t_trn                   ,
	   @i_operacion             	=	   @i_operacion             ,
	   @i_calcular_tabla        	=	   @i_calcular_tabla        ,
	   @i_tabla_nueva           	=	   @i_tabla_nueva           ,
	   @i_operacionca           	=	   @i_operacionca           ,
	   @i_banco                 	=	   @i_banco                 ,
	   @i_tipo                  	=	   @i_tipo                  ,
	   @i_anterior              	=	   @i_anterior              ,
	   @i_migrada               	=	   @i_migrada               ,
	   @i_tramite               	=	   @i_tramite               ,
	   @i_cliente               	=	   @i_cliente               ,
	   @i_nombre                	=	   @i_nombre                ,
	   @i_sector                	=	   @i_sector                ,
	   @i_toperacion            	=	   @i_toperacion            ,
	   @i_oficina               	=	   @i_oficina               ,
	   @i_moneda                	=	   @i_moneda                ,
	   @i_comentario            	=	   @i_comentario            ,
	   @i_oficial               	=	   @i_oficial               ,
	   @i_fecha_ini             	=	   @i_fecha_ini             ,
	   @i_fecha_fin             	=	   @i_fecha_fin             ,
	   @i_fecha_ult_proceso     	=	   @i_fecha_ult_proceso     ,
	   @i_fecha_liq             	=	   @i_fecha_liq             ,
	   @i_fecha_reajuste        	=	   @i_fecha_reajuste        ,
	   @i_monto                 	=	   @i_monto                 ,
	   @i_monto_aprobado        	=	   @i_monto_aprobado        ,
	   @i_destino               	=	   @i_destino               ,
	   @i_lin_credito           	=	   @i_lin_credito           ,
	   @i_ciudad                	=	   @i_ciudad                ,
	   @i_estado                	=	   @i_estado                ,
	   @i_periodo_reajuste      	=	   @i_periodo_reajuste      ,
	   @i_reajuste_especial     	=	   @i_reajuste_especial     ,
	   @i_forma_pago            	=	   @i_forma_pago            ,
	   @i_cuenta                	=	   @i_cuenta                ,
	   @i_dias_anio             	=	   @i_dias_anio             ,
	   @i_tipo_amortizacion     	=	   @i_tipo_amortizacion     ,
	   @i_cuota_completa        	=	   @i_cuota_completa        ,
	   @i_tipo_cobro            	=	   @i_tipo_cobro            ,
	   @i_tipo_reduccion        	=	   @i_tipo_reduccion        ,
	   @i_aceptar_anticipos     	=	   @i_aceptar_anticipos     ,
	   @i_precancelacion        	=	   @i_precancelacion        ,
	   @i_tipo_aplicacion       	=	   @i_tipo_aplicacion       ,
	   @i_tplazo                	=	   @i_tplazo                ,
	   @i_plazo                 	=	   @i_plazo                 ,
	   @i_tdividendo            	=	   @i_tdividendo            ,
	   @i_periodo_cap           	=	   @i_periodo_cap           ,
	   @i_periodo_int           	=	   @i_periodo_int           ,
	   @i_dist_gracia           	=	   @i_dist_gracia           ,
	   @i_gracia_cap            	=	   @i_gracia_cap            ,
	   @i_gracia_int            	=	   @i_gracia_int            ,
	   @i_dia_fijo              	=	   @i_dia_fijo              ,
	   @i_cuota                 	=	   @i_cuota                 ,
	   @i_evitar_feriados       	=	   @i_evitar_feriados       ,
	   @i_num_renovacion        	=	   @i_num_renovacion        ,
	   @i_renovacion            	=	   @i_renovacion            ,
	   @i_mes_gracia            	=	   @i_mes_gracia            ,
	   @i_upd_clientes          	=	   @i_upd_clientes          ,
	   @i_dias_gracia           	=	   @i_dias_gracia           ,
	   @i_reajustable           	=	   @i_reajustable           ,
	   @i_es_interno            	=	   @i_es_interno            ,
	   @i_formato_fecha         	=	   @i_formato_fecha         ,
	   @i_no_banco 					=	   @i_no_banco ,
	   @i_grupal                	=	   @i_grupal                ,
	   @i_banca                 	=	   @i_banca                 ,
	   @i_en_linea              	=	   @i_en_linea              ,
	   @i_externo               	=	   @i_externo               ,
	   @i_desde_web             	=	   @i_desde_web             ,
	   @i_salida                	=	   @i_salida                ,
	   @i_promocion             	=	   @i_promocion             ,
	   @i_acepta_ren            	=	   @i_acepta_ren            ,
	   @i_no_acepta             	=	   @i_no_acepta             ,
	   @i_emprendimiento        	=	   @i_emprendimiento        ,
	   @i_garantia              	=	   @i_garantia              ,
	   @i_alianza               	=	   @i_alianza               ,
	   @i_ciudad_destino        	=	   @i_ciudad_destino        ,
	   @i_experiencia_cli       	=	   @i_experiencia_cli       ,
	   @i_monto_max_tr          	=	   @i_monto_max_tr          ,
	   @i_desplazamiento			=  	   @i_desplazamiento   ,
	   @o_banco                 	=	   @o_banco                 out,
	   @o_operacion             	=	   @o_operacion             out,
	   @o_tramite               	=	   @o_tramite               out,
	   @o_plazo                 	=	   @o_plazo                 out,
	   @o_tplazo                	=	   @o_tplazo                out,
	   @o_cuota                 	=	   @o_cuota                 out,
	   @o_msg                   	=	   @o_msg                   out,
	   @o_tasa_grp              	=	   @o_tasa_grp              out

   
end
else if(@i_tipo = 'R')
begin
	exec @w_return = sp_modificar_ren_sol_wf
	   @s_srv   					=	   @s_srv   ,
	   @s_lsrv  					=	   @s_lsrv  ,
	   @s_ssn   					=	   @s_ssn   ,
	   @s_user  					=	   @s_user  ,
	   @s_term  					=	   @s_term  ,
	   @s_date  					=	   @s_date  ,
	   @s_sesn  					=	   @s_sesn  ,
	   @s_ofi   					=	   @s_ofi   ,
	   @t_debug 					=	   @t_debug ,
	   @t_file  					=	   @t_file  ,
	   @t_trn                   	=	   @t_trn                   ,
	   @i_operacion             	=	   @i_operacion             ,
	   @i_calcular_tabla        	=	   @i_calcular_tabla        ,
	   @i_tabla_nueva           	=	   @i_tabla_nueva           ,
	   @i_operacionca           	=	   @i_operacionca           ,
	   @i_banco                 	=	   @i_banco                 ,
	   @i_tipo                  	=	   @i_tipo                  ,
	   @i_anterior              	=	   @i_anterior              ,
	   @i_migrada               	=	   @i_migrada               ,
	   @i_tramite               	=	   @i_tramite               ,
	   @i_cliente               	=	   @i_cliente               ,
	   @i_nombre                	=	   @i_nombre                ,
	   @i_sector                	=	   @i_sector                ,
	   @i_toperacion            	=	   @i_toperacion            ,
	   @i_oficina               	=	   @i_oficina               ,
	   @i_moneda                	=	   @i_moneda                ,
	   @i_comentario            	=	   @i_comentario            ,
	   @i_oficial               	=	   @i_oficial               ,
	   @i_fecha_ini             	=	   @i_fecha_ini             ,
	   @i_fecha_fin             	=	   @i_fecha_fin             ,
	   @i_fecha_ult_proceso     	=	   @i_fecha_ult_proceso     ,
	   @i_fecha_liq             	=	   @i_fecha_liq             ,
	   @i_fecha_reajuste        	=	   @i_fecha_reajuste        ,
	   @i_monto                 	=	   @i_monto                 ,
	   @i_monto_aprobado        	=	   @i_monto_aprobado        ,
	   @i_destino               	=	   @i_destino               ,
	   @i_lin_credito           	=	   @i_lin_credito           ,
	   @i_ciudad                	=	   @i_ciudad                ,
	   @i_estado                	=	   @i_estado                ,
	   @i_periodo_reajuste      	=	   @i_periodo_reajuste      ,
	   @i_reajuste_especial     	=	   @i_reajuste_especial     ,
	   @i_forma_pago            	=	   @i_forma_pago            ,
	   @i_cuenta                	=	   @i_cuenta                ,
	   @i_dias_anio             	=	   @i_dias_anio             ,
	   @i_tipo_amortizacion     	=	   @i_tipo_amortizacion     ,
	   @i_cuota_completa        	=	   @i_cuota_completa        ,
	   @i_tipo_cobro            	=	   @i_tipo_cobro            ,
	   @i_tipo_reduccion        	=	   @i_tipo_reduccion        ,
	   @i_aceptar_anticipos     	=	   @i_aceptar_anticipos     ,
	   @i_precancelacion        	=	   @i_precancelacion        ,
	   @i_tipo_aplicacion       	=	   @i_tipo_aplicacion       ,
	   @i_tplazo                	=	   @i_tplazo                ,
	   @i_plazo                 	=	   @i_plazo                 ,
	   @i_tdividendo            	=	   @i_tdividendo            ,
	   @i_periodo_cap           	=	   @i_periodo_cap           ,
	   @i_periodo_int           	=	   @i_periodo_int           ,
	   @i_dist_gracia           	=	   @i_dist_gracia           ,
	   @i_gracia_cap            	=	   @i_gracia_cap            ,
	   @i_gracia_int            	=	   @i_gracia_int            ,
	   @i_dia_fijo              	=	   @i_dia_fijo              ,
	   @i_cuota                 	=	   @i_cuota                 ,
	   @i_evitar_feriados       	=	   @i_evitar_feriados       ,
	   @i_num_renovacion        	=	   @i_num_renovacion        ,
	   @i_renovacion            	=	   @i_renovacion            ,
	   @i_mes_gracia            	=	   @i_mes_gracia            ,
	   @i_upd_clientes          	=	   @i_upd_clientes          ,
	   @i_dias_gracia           	=	   @i_dias_gracia           ,
	   @i_reajustable           	=	   @i_reajustable           ,
	   @i_es_interno            	=	   @i_es_interno            ,
	   @i_formato_fecha         	=	   @i_formato_fecha         ,
	   @i_no_banco 					=	   @i_no_banco ,
	   @i_grupal                	=	   @i_grupal                ,
	   @i_banca                 	=	   @i_banca                 ,
	   @i_en_linea              	=	   @i_en_linea              ,
	   @i_externo               	=	   @i_externo               ,
	   @i_desde_web             	=	   @i_desde_web             ,
	   @i_salida                	=	   @i_salida                ,
	   @i_promocion             	=	   @i_promocion             ,
	   @i_acepta_ren            	=	   @i_acepta_ren            ,
	   @i_no_acepta             	=	   @i_no_acepta             ,
	   @i_emprendimiento        	=	   @i_emprendimiento        ,
	   @i_garantia              	=	   @i_garantia              ,
	   @i_alianza               	=	   @i_alianza               ,
	   @i_ciudad_destino        	=	   @i_ciudad_destino        ,
	   @i_experiencia_cli       	=	   @i_experiencia_cli       ,
	   @i_monto_max_tr          	=	   @i_monto_max_tr          ,
	   @i_desplazamiento		    = 	   @i_desplazamiento   ,
	   @o_banco                 	=	   @o_banco                 out,
	   @o_operacion             	=	   @o_operacion             out,
	   @o_tramite               	=	   @o_tramite               out,
	   @o_plazo                 	=	   @o_plazo                 out,
	   @o_tplazo                	=	   @o_tplazo                out,
	   @o_cuota                 	=	   @o_cuota                 out,
	   @o_msg                   	=	   @o_msg                   out,
	   @o_tasa_grp              	=	   @o_tasa_grp              out
end

if(@w_return != 0)
	return @w_return
   
return 0
go

