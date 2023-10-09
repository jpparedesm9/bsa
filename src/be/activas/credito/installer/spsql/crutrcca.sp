

use cob_credito
go

/************************************************************************/
/*  Archivo:              crutrcca.sp                                   */
/*  Stored procedure:     sp_up_tramite_cca                             */
/*  Base de Datos:        cob_credito                                   */
/*  Producto:             Credito                                       */
/*  Disenado por:         Raul Altamirano                               */
/*  Fecha de escritura:   Ene-16-2017                                   */
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
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      ENE-17-2017    Raul Altamirano  Emision Inicial - Version MX    */
/*      SEP-28-2017    Ma. Jose Taco   Validar el cuando no se actualiza*/
/*                                     el grupo                         */
/************************************************************************/

if exists (select 1 from sysobjects where name = 'sp_up_tramite_cca')
    drop proc sp_up_tramite_cca
go

create proc sp_up_tramite_cca(
   @s_ssn                     int         = null,
   @s_user                    login       = null,
   @s_sesn                    int         = null,
   @s_term                    varchar(30) = null,
   @s_date                    datetime    = null,
   @s_ofi                     smallint    = null,
   @s_srv		 	          varchar(30) = null,
   @s_lsrv		 	          varchar(30) = null,
   @t_trn                     int         = null,
   @t_debug                   char(1)     = 'N',
   @t_file                    varchar(14) = null,
   @t_from                    varchar(30) = null,
   @i_operacion               char(1)     = 'U',
   @i_tramite                 int         = null,
   @i_promocion               char(1)       = null, --LPO Santander
   @i_acepta_ren              char(1)       = null, --LPO Santander
   @i_no_acepta               char(1000)    = null, --LPO Santander
   @i_emprendimiento          char(1)       = null, --LPO Santander
   @i_garantia                float         = null, --LPO Santander
   @i_ciudad_destino          int           = null, --Santander
   @i_experiencia_cli         char(1)       = null, --Santander
   @i_monto_max_tr            money         = null, --Santander

   ---NUEVO REGISTRO
   @i_producto                catalogo = 'CCA',
   @i_tipo                    char(1)  = null,
   @i_fecha_crea              datetime = null,
   @i_estado                  char(1)  = null,
   @i_numero_op_banco         cuenta   = null,
   @i_razon                   catalogo = null,
   @i_txt_razon               varchar(255) = null,
   @i_fecha_inicio            datetime = null,
   @i_num_dias                smallint = 0,
   @i_monto                   money    = 0,
   @i_monto_solicitado        money    = null,
   @i_plazo                   smallint = null,
   @i_grupal                  char(1)  = null,
   @i_tplazo                  catalogo = null,
   --REGISTRO ANTERIOR
   @i_w_tipo                  char(1)  = null,
   @i_w_fecha_crea            datetime = null,
   @i_w_estado                char(1)  = null,
   @i_w_numero_op_banco       cuenta   = null,
   @i_w_razon                 catalogo = null,
   @i_w_txt_razon             varchar(255) = null,
   @i_w_fecha_inicio          datetime = null,
   @i_w_num_dias              smallint = 0,
   @i_w_monto                 money = 0,
   @i_w_plazo                 smallint,
   @i_w_tplazo                catalogo,  -- Santander
   @i_w_monto_solicitado      money    = null,
   @i_w_promocion             char(1)  = null,  --PARA REGISTRAR CAMBIOS
   @i_w_acepta_ren            char(1)  = null,  --PARA REGISTRAR CAMBIOS
   @i_w_no_acepta             char(1000)= null, --PARA REGISTRAR CAMBIOS
   @i_w_emprendimiento        char(1)   = null, --PARA REGISTRAR CAMBIOS
   @i_w_garantia              float     = null,  --PARA REGISTRAR CAMBIOS     
   @i_alianza                 int       = null,
   @i_w_alianza               int       = null,
   @i_w_ciudad_destino        int       = null, --Santander
   @i_w_experiencia_cli       char(1)   = null, --Santander
   @i_w_monto_max_tr          money     = null, --Santander
   @o_tasa_grp                varchar(255) =null output
)
as
declare
   @w_today                  datetime,     ---FECHA DEL DIA
   @w_return                 int,          ---VALOR QUE RETORNA
   @w_sp_name                varchar(32),  ---NOMBRE STORED PROC
   @w_error                  int,
   @w_commit                 char(1),
   @w_tramite                int,
   @w_numero_operacion       int,
   @w_numero_op_banco        cuenta,
   @w_cambio                 char(1),
   @w_banco                  cuenta,
   @w_operacion              int,
   @w_num_banco              varchar(24),
   @w_op_operacion           INT,
   @w_tramite_ant            INT,
   @w_grupo                  INT,
   @w_cambio_promo           char(1)
   
select @w_today  = @s_date,
       @w_sp_name = 'sp_up_tramite_cca'
	   

---CHEQUEO DE NUMERO DE OPERACION
if @i_numero_op_banco is not null
begin
   if @i_producto = 'CCA'
   begin
      select
      @w_numero_operacion = op_operacion
      from  cob_cartera..ca_operacion
      where op_banco = @i_numero_op_banco

      if @@rowcount = 0
      begin
        select @w_error = 2101021
        goto  ERROR_PROCESO
      end
   end
end

if not exists (select 1 from cob_credito..cr_deudores
               where de_tramite = @i_tramite)
    begin
       select @w_banco = op_banco
         from cob_cartera..ca_operacion
        where op_tramite = @i_tramite
       
       insert into cr_deudores (
       de_tramite,    de_cliente,    de_rol,     de_ced_ruc)
       select
       @i_tramite,    cl_cliente,    @i_grupal,     cl_ced_ruc
       from cobis..cl_det_producto, cobis..cl_cliente
       where dp_cuenta = @w_banco
       and   dp_producto = 7
       and   cl_det_producto = dp_det_producto

       --Bandera que indica el tramite es grupal
       if @i_grupal = 'S'
          update cr_deudores
             set de_rol = 'G'
          where de_tramite = @i_tramite
    end

select @w_cambio = 'N' 

---CONTROL DE MODIFICACIONES UNA QUE EL TRAMITE HAYA SIDO APROBADO
/*if @i_w_estado = 'A'
begin
   ---INICIALIZACION DE VARIABLES
   select @w_cambio = 'N'
   
   if @i_operacion = 'R'
   begin
      if @i_razon is not null
         if @i_razon <> @i_w_razon select @w_cambio = 'S'
	  
      if @i_txt_razon is not null
         if @i_txt_razon <> @i_w_txt_razon select @w_cambio = 'S'
   end
   */
   ---ORIGINALES Y RENOVACIONES
   if @i_fecha_crea is not null
      if @i_fecha_crea <> @i_w_fecha_crea select @w_cambio = 'S'
   if @i_fecha_inicio is not null	  
      if @i_fecha_inicio <> @i_w_fecha_inicio select @w_cambio = 'S'
   if @i_num_dias is not null
      if @i_num_dias <> @i_w_num_dias select @w_cambio = 'S'
   
   if @i_plazo is not null
      if @i_plazo <> @i_w_plazo select @w_cambio = 'S'
   if @i_tplazo is not null
      if @i_tplazo <> @i_w_tplazo select @w_cambio = 'S'	  
   if @i_monto is not null
      if @i_monto <> @i_w_monto select @w_cambio = 'S'
   if @i_monto_solicitado is not null	  
      if @i_monto_solicitado  <> @i_w_monto_solicitado select @w_cambio = 'S'
	 	  
   if @i_promocion is not null or @i_acepta_ren is not null or @i_no_acepta is not null or @i_emprendimiento is not null or @i_garantia is not null
   if @i_promocion  <> @i_w_promocion or @i_acepta_ren  <> @i_w_acepta_ren or @i_no_acepta  <> @i_w_no_acepta or @i_emprendimiento  <> @i_w_emprendimiento or @i_garantia  <> @i_w_garantia
      select @w_cambio = 'S'

    if @i_promocion is not null and @i_promocion  <> @i_w_promocion  AND  @i_grupal='S'
      select @w_cambio_promo = 'S'
      
   if (isnull(@i_w_alianza,0) <> @i_alianza) select @w_cambio = 'S'

   if @i_w_ciudad_destino <> @i_ciudad_destino select @w_cambio = 'S'
   if @i_w_experiencia_cli <> @i_experiencia_cli select @w_cambio = 'S'
   if @i_w_monto_max_tr <> @i_monto_max_tr select @w_cambio = 'S'

--end

print 'VALOR VARIABLE CAMBIO:'+@w_cambio
print '@i_promocion:'+convert(VARCHAR(50),@i_promocion)
print '@i_w_promocion:'+convert(VARCHAR(50),@i_w_promocion)
print '@i_grupal:'+convert(VARCHAR(50),@i_grupal)
  
if @w_cambio = 'S'
begin
   if @@trancount = 0
   begin
      begin tran
      select @w_commit = 'S'
   end

   update cr_tramite with(rowlock) set
   tr_razon               = @i_razon,
   tr_txt_razon           = @i_txt_razon,
   tr_fecha_inicio        = @i_fecha_inicio,
   tr_num_dias            = @i_num_dias,
   tr_monto               = @i_monto,
   tr_monto_solicitado    = @i_monto_solicitado,
   tr_plazo               = @i_plazo,
   tr_grupal              = isnull(@i_grupal, tr_grupal),
   tr_promocion           = @i_promocion,
   tr_acepta_ren          = @i_acepta_ren,         
   tr_no_acepta           = @i_no_acepta,          
   tr_emprendimiento      = @i_emprendimiento,
   tr_porc_garantia       = isnull(@i_garantia,tr_porc_garantia), --MTA
   tr_tipo_plazo          = @i_tplazo,
   tr_alianza             = @i_alianza,
   tr_ciudad_destino      = @i_ciudad_destino,    
   tr_experiencia         = @i_experiencia_cli,  
   tr_monto_max           = @i_monto_max_tr
   from cr_tramite
   where  tr_tramite      = @i_tramite

   if @@error <> 0
   begin
      ---ERROR EN LA ACTUALIZACION DEL REGISTRO
      select @w_error = 2105001
      goto  ERROR_PROCESO
   end
   
   ---TRANSACCION DE SERVICIO ANTERIOR
   insert into ts_tramite (
   secuencial,                           tipo_transaccion,                       clase,
   fecha,                                usuario,                                terminal,
   oficina,                              tabla,                                  lsrv,
   srv,                                  tramite,                                tipo,
   oficina_tr,                           usuario_tr,                             fecha_crea,
   oficial,                              sector,                                 ciudad,
   estado,                               nivel_ap,                               fecha_apr,
   usuario_apr,                          truta,                                  numero_op,
   numero_op_banco,                      proposito,                              razon,
   txt_razon,                            efecto,                                 cliente,
   grupo,                                fecha_inicio,                           num_dias,
   per_revision,                         condicion_especial,                     linea_credito,
   toperacion,                           producto,                               monto,
   moneda,                               periodo,                                num_periodos,
   destino,                              ciudad_destino,                         cuenta_corriente,
   renovacion,                           rent_actual,                            rent_solicitud,
   rent_recomend,                        prod_actual,                            prod_solicitud,
   prod_recomend,                        clasecca,                               admisible,
   noadmis,                              relacionado,                            pondera,
   tipo_producto,                        origen_bienes,                          localizacion,
   plan_inversion,                       naturaleza,                             tipo_financia,
   forward,                              elegible,                               emp_emisora,
   num_acciones,                         responsable,                            negocio,
   reestructuracion,                     concepto_credito,                       aprob_gar,
   mercado_objetivo,                     tipo_productor,                         valor_proyecto,
   sindicado,                            margen_redescuento,                     asociativo,
   incentivo,                            fecha_eleg,                             fecha_redes,
   solicitud,                            montop,                                 montodesembolsop,
   mercado,                              carta_apr,                              fecha_aprov,
   fmax_redes,                           f_prorroga,                             sujcred,
   fabrica,                              callcenter,                             apr_fabrica,
   monto_solicitado,                     tipo_plazo ,                            tipo_cuota,
   plazo,                                cuota_aproximada,                       fuente_recurso,
   tipo_credito,                         alianza,                                exp_cliente, 
   monto_max_tr)

   select 
   @s_ssn,                               21120,                                  'P',
   @s_date,                              @s_user,                                 @s_term,
   @s_ofi,                               'cr_tramite',                            @s_lsrv,
   @s_srv,                               tr_tramite, 							  tr_tipo,
   tr_oficina,                           tr_usuario, 							  tr_fecha_crea,
   tr_oficial,                           tr_sector, 							  tr_ciudad,
   tr_estado,               			 tr_nivel_ap,							  tr_fecha_apr,
   tr_usuario_apr,   					 tr_truta, 								  tr_numero_op,
   tr_numero_op_banco, 					 tr_proposito,                            tr_razon,
   tr_txt_razon,                         tr_efecto,                               tr_cliente,
   tr_grupo,                             tr_fecha_inicio,                         tr_num_dias,
   tr_per_revision,                      tr_condicion_especial,                   tr_linea_credito,
   tr_toperacion,                        tr_producto,                             tr_monto,
   tr_moneda,                            tr_periodo,                              tr_num_periodos,
   tr_destino,                           tr_ciudad_destino,                       tr_cuenta_corriente,
   tr_renovacion, 						 tr_rent_actual,                          tr_rent_solicitud,
   tr_rent_recomend,                     tr_prod_actual,                          tr_prod_solicitud,
   tr_prod_recomend,                     tr_clase,                                tr_admisible,
   tr_noadmis,                           tr_relacionado,                          tr_pondera,
   tr_tipo_producto,                     tr_origen_bienes,                        tr_localizacion,
   tr_plan_inversion,                    tr_naturaleza,                           tr_tipo_financia,
   tr_forward,                           tr_elegible,                             tr_emp_emisora,
   tr_num_acciones,    					 tr_responsable,                          tr_negocio,
   tr_reestructuracion,                  tr_concepto_credito,                     tr_aprob_gar,
   tr_mercado_objetivo,                  tr_tipo_productor,                       tr_valor_proyecto,
   tr_sindicado,       					 tr_margen_redescuento,                   tr_asociativo,
   tr_incentivo,                         tr_fecha_eleg, 				          tr_fecha_redes,
   tr_solicitud,                         tr_montop,                               tr_monto_desembolsop,
   tr_mercado,                           tr_carta_apr,                            tr_fecha_aprov,
   tr_fmax_redes,                        tr_f_prorroga,                           tr_sujcred,
   tr_fabrica,                           tr_callcenter,                           tr_apr_fabrica,
   tr_monto_solicitado,                  tr_tipo_plazo,                           tr_tipo_cuota,
   tr_plazo,                             tr_cuota_aproximada,                     tr_fuente_recurso,
   tr_tipo_credito,                      tr_alianza,                              tr_experiencia,                       
   tr_monto_max
   from cr_tramite
   where tr_tramite = @i_tramite
   
   if @@error <> 0
   begin
      ---ERROR EN INSERCION DE TRANSACCION DE SERVICION
	  select @w_error = 2103003
      goto  ERROR_PROCESO
   end

   ---TRANSACCION DE SERVICIO REGISTRO ACTUAL
   insert into ts_tramite (
   secuencial,                           tipo_transaccion,                       clase,
   fecha,                                usuario,                                terminal,
   oficina,                              tabla,                                  lsrv,
   srv,                                  tramite,                                tipo,
   oficina_tr,                           usuario_tr,                             fecha_crea,
   oficial,                              sector,                                 ciudad,
   estado,                               nivel_ap,                               fecha_apr,
   usuario_apr,                          truta,                                  numero_op,
   numero_op_banco,                      proposito,                              razon,
   txt_razon,                            efecto,                                 cliente,
   grupo,                                fecha_inicio,                           num_dias,
   per_revision,                         condicion_especial,                     linea_credito,
   toperacion,                           producto,                               monto,
   moneda,                               periodo,                                num_periodos,
   destino,                              ciudad_destino,                         cuenta_corriente,
   renovacion,                           rent_actual,                            rent_solicitud,
   rent_recomend,                        prod_actual,                            prod_solicitud,
   prod_recomend,                        clasecca,                               admisible,
   noadmis,                              relacionado,                            pondera,
   tipo_producto,                        origen_bienes,                          localizacion,
   plan_inversion,                       naturaleza,                             tipo_financia,
   forward,                              elegible,                               emp_emisora,
   num_acciones,                         responsable,                            negocio,
   reestructuracion,                     concepto_credito,                       aprob_gar,
   mercado_objetivo,                     tipo_productor,                         valor_proyecto,
   sindicado,                            margen_redescuento,                     asociativo,
   incentivo,                            fecha_eleg,                             fecha_redes,
   solicitud,                            montop,                                 montodesembolsop,
   mercado,                              carta_apr,                              fecha_aprov,
   fmax_redes,                           f_prorroga,                             sujcred,
   fabrica,                              callcenter,                             apr_fabrica,
   monto_solicitado,                     tipo_plazo,                             tipo_cuota,
   plazo,                                cuota_aproximada,                       fuente_recurso,
   tipo_credito)
   select 
   @s_ssn,                               21120,                                  'N',
   @s_date,                              @s_user,                                 @s_term,
   @s_ofi,                               'cr_tramite',                            @s_lsrv,
   @s_srv,                               tr_tramite, 							  tr_tipo,
   tr_oficina,                           tr_usuario, 							  @i_fecha_crea,
   tr_oficial,                           tr_sector, 							  tr_ciudad,
   tr_estado,               			 tr_nivel_ap,							  tr_fecha_apr,
   tr_usuario_apr,   					 tr_truta, 								  tr_numero_op,
   tr_numero_op_banco, 					 tr_proposito,                            @i_razon,
   @i_txt_razon,                         tr_efecto,                               tr_cliente,
   tr_grupo,                             @i_fecha_inicio,                         @i_num_dias,
   tr_per_revision,                      tr_condicion_especial,                   tr_linea_credito,
   tr_toperacion,                        tr_producto,                             @i_monto,
   tr_moneda,                            tr_periodo,                              tr_num_periodos,
   tr_destino,                           tr_ciudad_destino,                       tr_cuenta_corriente,
   tr_renovacion, 						 tr_rent_actual,                          tr_rent_solicitud,
   tr_rent_recomend,                     tr_prod_actual,                          tr_prod_solicitud,
   tr_prod_recomend,                     tr_clase,                                tr_admisible,
   tr_noadmis,                           tr_relacionado,                          tr_pondera,
   tr_tipo_producto,                     tr_origen_bienes,                        tr_localizacion,
   tr_plan_inversion,                    tr_naturaleza,                           tr_tipo_financia,
   tr_forward,                           tr_elegible,                             tr_emp_emisora,
   tr_num_acciones,    					 tr_responsable,                          tr_negocio,
   tr_reestructuracion,                  tr_concepto_credito,                     tr_aprob_gar,
   tr_mercado_objetivo,                  tr_tipo_productor,                       tr_valor_proyecto,
   tr_sindicado,       					 tr_margen_redescuento,                   tr_asociativo,
   tr_incentivo,                         tr_fecha_eleg, 				          tr_fecha_redes,
   tr_solicitud,                         tr_montop,                               tr_monto_desembolsop,
   tr_mercado,                           tr_carta_apr,                            tr_fecha_aprov,
   tr_fmax_redes,                        tr_f_prorroga,                           tr_sujcred,
   tr_fabrica,                           tr_callcenter,                           tr_apr_fabrica,
   @i_monto_solicitado,                  tr_tipo_plazo,                           tr_tipo_cuota,
   @i_plazo,                             tr_cuota_aproximada,                     tr_fuente_recurso,
   tr_tipo_credito
   from cr_tramite
   where tr_tramite = @i_tramite

   if @@error <> 0
   begin
      ---ERROR EN INSERCION DE TRANSACCION DE SERVICIO
	  select @w_error = 2103003
      goto  ERROR_PROCESO
   end
   
   if @w_cambio_promo ='S'
   begin
      select @w_grupo = tg_grupo 
      from cob_credito..cr_tramite_grupal
      where tg_tramite = @i_tramite
   
   	  exec sp_monto_inicial
   	  @i_tramite      =   @i_tramite,
      @i_grupo        =   @w_grupo,
      @i_promocion    =   @i_promocion
    
   
	 exec @w_return = cob_credito..sp_grupal_reglas
     @s_ssn         = @s_ssn ,
     @s_ofi         = @s_ofi ,
     @s_sesn        = @s_sesn ,
     @t_trn         = 1111    ,
     @s_user        = @s_user ,
     @s_term        = @s_term ,
     @s_date        = @s_date ,
     @s_srv         = @s_srv ,
     @s_lsrv        = @s_lsrv ,
     @i_tramite     = @i_tramite,
     @i_valida_part = 'N',
     @i_id_rule     = 'TASA_GRP',  -- encontral la tasa grupal
	 @o_resultado   = @o_tasa_grp out
                
	 if @w_return <> 0 begin
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file  = @t_file,
	    @t_from  = @w_sp_name,
	    @i_num   = 21008,
	    @i_msg   = 'Error al determinar la tasa grupal'
     end
	 	 
   end
   if @w_commit = 'S' begin 
      commit tran
      select @w_commit = 'N'
   end   
end   
        
/*
if exists(select 1 from cob_cartera..ca_operacion
          where  op_tramite = @w_tramite) and 
   (@i_tipo = 'O') and (@i_producto = 'CCA')
begin
   select @w_banco = op_banco
   from cob_cartera..ca_operacion
   where  op_tramite = @w_tramite
   
   exec @w_return = cob_cartera..sp_borrar_tmp
        @i_banco  = @w_banco,
        @s_user   = @s_user
		
   if @w_return <> 0
   begin
      select @w_error = @w_return
      goto  ERROR_PROCESO
   end
end
*/

return 0


ERROR_PROCESO:
PRINT 'ERROR NUMERO ' + CONVERT(VARCHAR, @w_error)
if @w_commit = 'S'
   rollback tran
   
return @w_error   
   
go
