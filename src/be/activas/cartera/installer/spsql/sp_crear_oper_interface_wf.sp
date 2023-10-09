/************************************************************************/
/*   Archivo:              sp_crear_oper_interface_wf.sp                */
/*   Stored procedure:     sp_crear_oper_interface_wf                   */
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
/*	Interface para crear diferentes tipos de operacion				    */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      JAN-13-2021    PRO              Emision Inicial                 */
/*      22-FEB-2021    SRO              Req. 147999 F2                  */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_crear_oper_interface_wf')
    drop proc sp_crear_oper_interface_wf
go

create proc sp_crear_oper_interface_wf(
   @s_srv              varchar(30)    = null,
   @s_lsrv             varchar(30)    = null,
   @s_ssn              int            = null,
   @s_rol              int            = null,
   @s_org              char(1)        = null,
   @s_user             login          = null,
   @s_term             varchar(30)    = null,
   @s_date             datetime       = null,
   @s_sesn             int            = null,
   @s_ofi              smallint       = null,
   ---------------------------------------
   @t_trn              int            = null,
   @t_debug            char(1)        = null,
   @t_file             varchar(30)    = null,
   ---------------------------------------
   @i_tipo             varchar(1)     = 'O',
   @i_anterior         cuenta         = null,
   @i_migrada          cuenta         = null,
   @i_tramite          int            = null,
   @i_cliente          int            = 0,
   @i_nombre           descripcion    = null,
   @i_codeudor         int            = 0,
   @i_sector           catalogo       = null,
   @i_toperacion       catalogo       = null,
   @i_oficina          smallint       = null,
   @i_moneda           tinyint        = null,
   @i_comentario       varchar(255)   = null,
   @i_oficial          smallint       = null,
   @i_fecha_ini        datetime       = null,
   @i_monto            money          = null,
   @i_monto_aprobado   money          = null,
   @i_destino          catalogo       = null,
   @i_lin_credito      cuenta         = null,
   @i_ciudad           int            = null,
   @i_forma_pago       catalogo       = null,
   @i_cuenta           cuenta         = null,
   @i_formato_fecha    int            = 101,
   @i_no_banco         varchar(1)     = 'S',
   @i_clase_cartera    catalogo       = null,
   @i_origen_fondos    catalogo       = null,
   @i_fondos_propios   varchar(1)     = 'S',
   @i_ref_exterior     cuenta         = null,
   @i_sujeta_nego      varchar(1)     = 'N' ,
   @i_convierte_tasa   varchar(1)     = null,
   @i_tasa_equivalente varchar(1)     = null,
   @i_fec_embarque     datetime       = null,
   @i_reestructuracion varchar(1)     = null,
   @i_numero_reest     int            = null,
   @i_num_renovacion   int            = 0,
   @i_tipo_cambio      varchar(1)     = null,
   @i_grupal           char(1)        = null,
   @i_en_linea         varchar(1)     = 'S',
   @i_externo          varchar(1)     = 'S',
   @i_desde_web        varchar(1)     = 'S',
   @i_banca            catalogo       = null,
   @i_salida           varchar(1)     = 'N',
   @i_promocion        char(1)        = 'N', --LPO Santander
   @i_acepta_ren       char(1)        = null, --LPO Santander
   @i_no_acepta        char(1000)     = null, --LPO Santander
   @i_emprendimiento   char(1)        = null, --LPO Santander
   @i_participa_ciclo  char(1)        = null, --LPO Santander
   --@i_tg_monto_aprobado money     = null, --LPO Santander
   @i_garantia         float          = null, --LPO Santander
   @i_ahorro           money          = null, --LPO Santander
   @i_monto_max        money          = null, --LPO Santander
   @i_bc_ln            char(10)       = null, --LPO Santander
   @i_plazo            int            = null, --Santander -- tr_plazo
   @i_tplazo           catalogo       = null, --Santander -- tr_tipo_plazo
   @i_tdividendo       catalogo       = null,
   @i_periodo_cap      int            = null,
   @i_periodo_int      int            = null,
   @i_alianza          int            = null, --Santander -- tr_alianza
   @i_ciudad_destino   int            = null, --Santander
   @i_experiencia_cli  char(1)        = null, --Santander
   @i_monto_max_tr     money          = null, --Santander
   @i_automatica       char(1)        = 'N',   --Santander
   @i_naturaleza       varchar(10)    = NULL,
   @i_desplazamiento   int            = null,
   @i_id_inst_proc     int            = null,
   ---------------------------------------
   @o_banco            cuenta         = null out,
   @o_operacion        int            = null out,
   @o_tramite          int            = null out,
   @o_oficina          int            = null out,
   @o_msg              varchar(100)   = null out,
   @o_ciclo            int            = null out,
   @o_fecha_creacion   varchar(10)    = null out,
   @o_tasa_grp         varchar(255)   = null out
)as

declare
   @w_sp_name                  varchar(64),
   @w_return                   int,
   @w_error                    int,
   @w_fecha_proceso            datetime,
   @w_operacion                int,
   @w_banco                    cuenta
   

if  @i_ciudad is null or @i_ciudad = 0 begin
   select @i_ciudad = of_ciudad
   from cobis..cl_oficina
   where of_oficina = @i_oficina
end
 

   
if(@i_tipo = 'O')
begin
	exec @w_return = sp_crear_oper_sol_wf
	@s_srv              	=	@s_srv              ,
	@s_lsrv             	=	@s_lsrv             ,
	@s_ssn              	=	@s_ssn              ,
	@s_rol              	=	@s_rol              ,
	@s_org              	=	@s_org              ,
	@s_user             	=	@s_user             ,
	@s_term             	=	@s_term             ,
	@s_date             	=	@s_date             ,
	@s_sesn             	=	@s_sesn             ,
	@s_ofi              	=	@s_ofi              ,
	@t_trn              	=	@t_trn              ,
	@t_debug            	=	@t_debug            ,
	@t_file             	=	@t_file             ,
	@i_tipo             	=	@i_tipo             ,
	@i_anterior         	=	@i_anterior         ,
	@i_migrada          	=	@i_migrada          ,
	@i_tramite          	=	@i_tramite          ,
	@i_cliente          	=	@i_cliente          ,
	@i_nombre           	=	@i_nombre           ,
	@i_codeudor         	=	@i_codeudor         ,
	@i_sector           	=	@i_sector           ,
	@i_toperacion       	=	@i_toperacion       ,
	@i_oficina          	=	@i_oficina          ,
	@i_moneda           	=	@i_moneda           ,
	@i_comentario       	=	@i_comentario       ,
	@i_oficial          	=	@i_oficial          ,
	@i_fecha_ini        	=	@i_fecha_ini        ,
	@i_monto            	=	@i_monto            ,
	@i_monto_aprobado   	=	@i_monto_aprobado   ,
	@i_destino          	=	@i_destino          ,
	@i_lin_credito      	=	@i_lin_credito      ,
	@i_ciudad           	=	@i_ciudad           ,
	@i_forma_pago       	=	@i_forma_pago       ,
	@i_cuenta           	=	@i_cuenta           ,
	@i_formato_fecha    	=	@i_formato_fecha    ,
	@i_no_banco         	=	@i_no_banco         ,
	@i_clase_cartera    	=	@i_clase_cartera    ,
	@i_origen_fondos    	=	@i_origen_fondos    ,
	@i_fondos_propios   	=	@i_fondos_propios   ,
	@i_ref_exterior     	=	@i_ref_exterior     ,
	@i_sujeta_nego      	=	@i_sujeta_nego      ,
	@i_convierte_tasa   	=	@i_convierte_tasa   ,
	@i_tasa_equivalente 	=	@i_tasa_equivalente ,
	@i_fec_embarque     	=	@i_fec_embarque     ,
	@i_reestructuracion 	=	@i_reestructuracion ,
	@i_numero_reest     	=	@i_numero_reest     ,
	@i_num_renovacion   	=	@i_num_renovacion   ,
	@i_tipo_cambio      	=	@i_tipo_cambio      ,
	@i_grupal           	=	@i_grupal           ,
	@i_en_linea         	=	@i_en_linea         ,
	@i_externo          	=	@i_externo          ,
	@i_desde_web        	=	@i_desde_web        ,
	@i_banca            	=	@i_banca            ,
	@i_salida           	=	@i_salida           ,
	@i_promocion        	=	@i_promocion        ,
	@i_acepta_ren       	=	@i_acepta_ren       ,
	@i_no_acepta        	=	@i_no_acepta        ,
	@i_emprendimiento   	=	@i_emprendimiento   ,
	@i_participa_ciclo  	=	@i_participa_ciclo  ,
	@i_garantia         	=	@i_garantia         ,
	@i_ahorro           	=	@i_ahorro           ,
	@i_monto_max        	=	@i_monto_max        ,
	@i_bc_ln            	=	@i_bc_ln            ,
	@i_plazo            	=	@i_plazo            ,
	@i_tplazo           	=	@i_tplazo           ,
	@i_tdividendo       	=	@i_tdividendo       ,
	@i_periodo_cap      	=	@i_periodo_cap      ,
	@i_periodo_int      	=	@i_periodo_int      ,
	@i_alianza          	=	@i_alianza          ,
	@i_ciudad_destino   	=	@i_ciudad_destino   ,
	@i_experiencia_cli  	=	@i_experiencia_cli  ,
	@i_monto_max_tr     	=	@i_monto_max_tr     ,
	@i_automatica       	=	@i_automatica       ,
	@i_naturaleza       	=	@i_naturaleza       ,
	@i_desplazamiento		= 	@i_desplazamiento   ,
	@i_id_inst_proc         =   @i_id_inst_proc     , 
	@o_banco            	=	@o_banco            out,
	@o_operacion        	=	@o_operacion        out,
	@o_tramite          	=	@o_tramite          out,
	@o_oficina          	=	@o_oficina          out,
	@o_msg              	=	@o_msg              out,
	@o_ciclo            	=	@o_ciclo            out,
	@o_fecha_creacion   	=	@o_fecha_creacion   out,
	@o_tasa_grp             = 	@o_tasa_grp			out
   
end
else if(@i_tipo = 'R')
begin
	exec @w_return = sp_crear_ren_sol_wf
	@s_srv              	=	@s_srv              ,
	@s_lsrv             	=	@s_lsrv             ,
	@s_ssn              	=	@s_ssn              ,
	@s_rol              	=	@s_rol              ,
	@s_org              	=	@s_org              ,
	@s_user             	=	@s_user             ,
	@s_term             	=	@s_term             ,
	@s_date             	=	@s_date             ,
	@s_sesn             	=	@s_sesn             ,
	@s_ofi              	=	@s_ofi              ,
	@t_trn              	=	@t_trn              ,
	@t_debug            	=	@t_debug            ,
	@t_file             	=	@t_file             ,
	@i_tipo             	=	@i_tipo             ,
	@i_anterior         	=	@i_anterior         ,
	@i_migrada          	=	@i_migrada          ,
	@i_tramite          	=	@i_tramite          ,
	@i_cliente          	=	@i_cliente          ,
	@i_nombre           	=	@i_nombre           ,
	@i_codeudor         	=	@i_codeudor         ,
	@i_sector           	=	@i_sector           ,
	@i_toperacion       	=	@i_toperacion       ,
	@i_oficina          	=	@i_oficina          ,
	@i_moneda           	=	@i_moneda           ,
	@i_comentario       	=	@i_comentario       ,
	@i_oficial          	=	@i_oficial          ,
	@i_fecha_ini        	=	@i_fecha_ini        ,
	@i_monto            	=	@i_monto            ,
	@i_monto_aprobado   	=	@i_monto_aprobado   ,
	@i_destino          	=	@i_destino          ,
	@i_lin_credito      	=	@i_lin_credito      ,
	@i_ciudad           	=	@i_ciudad           ,
	@i_forma_pago       	=	@i_forma_pago       ,
	@i_cuenta           	=	@i_cuenta           ,
	@i_formato_fecha    	=	@i_formato_fecha    ,
	@i_no_banco         	=	@i_no_banco         ,
	@i_clase_cartera    	=	@i_clase_cartera    ,
	@i_origen_fondos    	=	@i_origen_fondos    ,
	@i_fondos_propios   	=	@i_fondos_propios   ,
	@i_ref_exterior     	=	@i_ref_exterior     ,
	@i_sujeta_nego      	=	@i_sujeta_nego      ,
	@i_convierte_tasa   	=	@i_convierte_tasa   ,
	@i_tasa_equivalente 	=	@i_tasa_equivalente ,
	@i_fec_embarque     	=	@i_fec_embarque     ,
	@i_reestructuracion 	=	@i_reestructuracion ,
	@i_numero_reest     	=	@i_numero_reest     ,
	@i_num_renovacion   	=	@i_num_renovacion   ,
	@i_tipo_cambio      	=	@i_tipo_cambio      ,
	@i_grupal           	=	@i_grupal           ,
	@i_en_linea         	=	@i_en_linea         ,
	@i_externo          	=	@i_externo          ,
	@i_desde_web        	=	@i_desde_web        ,
	@i_banca            	=	@i_banca            ,
	@i_salida           	=	@i_salida           ,
	@i_promocion        	=	@i_promocion        ,
	@i_acepta_ren       	=	@i_acepta_ren       ,
	@i_no_acepta        	=	@i_no_acepta        ,
	@i_emprendimiento   	=	@i_emprendimiento   ,
	@i_participa_ciclo  	=	@i_participa_ciclo  ,
	@i_garantia         	=	@i_garantia         ,
	@i_ahorro           	=	@i_ahorro           ,
	@i_monto_max        	=	@i_monto_max        ,
	@i_bc_ln            	=	@i_bc_ln            ,
	@i_plazo            	=	@i_plazo            ,
	@i_tplazo           	=	@i_tplazo           ,
	@i_tdividendo       	=	@i_tdividendo       ,
	@i_periodo_cap      	=	@i_periodo_cap      ,
	@i_periodo_int      	=	@i_periodo_int      ,
	@i_alianza          	=	@i_alianza          ,
	@i_ciudad_destino   	=	@i_ciudad_destino   ,
	@i_experiencia_cli  	=	@i_experiencia_cli  ,
	@i_monto_max_tr     	=	@i_monto_max_tr     ,
	@i_automatica       	=	@i_automatica       ,
	@i_naturaleza       	=	@i_naturaleza       ,
	@i_desplazamiento		= 	@i_desplazamiento   ,
	@o_banco            	=	@o_banco            out,
	@o_operacion        	=	@o_operacion        out,
	@o_tramite          	=	@o_tramite          out,
	@o_oficina          	=	@o_oficina          out,
	@o_msg              	=	@o_msg              out,
	@o_ciclo            	=	@o_ciclo            out,
	@o_fecha_creacion   	=	@o_fecha_creacion   out,
	@o_tasa_grp             = 	@o_tasa_grp			out
end

if(@w_return != 0)
	return @w_return
   
return 0
go

