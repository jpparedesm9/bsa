/********************************************************************/
/*  Archivo:          tablaAmort_on_bording.sp                      */
/*  Stored procedure: tablaAmort_on_bording                         */
/*  Base de datos:    con_conta_super                               */
/*  Producto:         Regulatorios                                  */
/********************************************************************/
/*                         IMPORTANTE                               */
/* Esta aplicacion es parte de los paquetes bancarios propiedad     */
/* de COBISCorp.                                                    */
/* Su uso no autorizado queda expresamente prohibido asi como       */
/* cualquier alteracion o agregado  hecho por alguno de sus         */
/* usuarios sin el debido consentimiento por escrito de COBISCorp.  */
/* Este programa esta protegido por la ley de derechos de autor     */
/* y por las convenciones  internacionales   de  propiedad inte-    */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para */
/* obtener ordenes  de secuestro o retencion y para  perseguir      */
/* penalmente a los autores de cualquier infraccion.                */
/********************************************************************/
/*                           PROPOSITO                              */
/* TablaAmortizacion                                                */
/********************************************************************/
/*                MODIFICACIONES                                    */
/*  FECHA         AUTOR           RAZON                             */
/* 04/03/2022     ACH         Emisión Inicial                       */
/********************************************************************/

use cob_conta_super
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'tablaAmort_on_bording')
   drop proc tablaAmort_on_bording
go

create proc tablaAmort_on_bording 
(
    @i_operacion                varchar(10)    = null,
    @i_banco                    varchar(15)    = null,
    @i_fecha                    datetime       = null,
    @i_formato                  int            = 103,
    @i_secuencial               INT            = 0,
    @o_secuencial               INT            = 0 output,
    @o_mensaje                  varchar(30)    = null output
)                               
as                              
declare                         
    @w_return                                 int         ,
    @w_sp_name                                varchar(30) ,
    @w_registro                               int         ,
    @w_fecha_proc                             datetime    ,
    @w_cod_grupo                              int         ,
    @w_nom_grupo                              varchar(100),
    @w_num_ciclos                             int         ,
    @w_cod_cliente                            int         ,
    @w_nom_cliente                            varchar(100),
    @w_cod_oficina                            int         ,
    @w_nom_oficna                             varchar(100),
    @w_rfc                                    varchar(30) ,
    @w_fecha_concesion                        datetime    ,
    @w_fecha_inicio                           datetime    ,
    @w_fecha_fin_ope                          datetime    ,
    @w_fecha_fin                              datetime    ,
    @w_reporte                                varchar(10) ,
    @w_existe_solicitud                       char (1)    ,
    @w_ini_mes                                datetime    ,
    @w_fin_mes                                datetime    ,
    @w_fin_mes_hab                            datetime    ,
    @w_fin_mes_ant                            datetime    ,
    @w_fin_mes_ant_hab                        datetime    ,
    @w_fin_aux                                datetime    ,
    @w_mes_aux                                int         ,
    @w_anio_aux                               int         ,
    @w_estado                                 varchar(64) ,
    @w_codigo_postal                          varchar(64) ,
    @w_delegacion                             varchar(100),
    @w_parroquia                              varchar(100),
    @w_calle                                  varchar(70) ,
    @w_numero                                 int         ,
    @w_codigo_topera                          varchar(10) ,  
    @w_estado_op                              varchar(20) ,
    @w_desc_toperacion                        varchar(100),
    @w_monto                                  money       ,
    @w_saldo                                  money       ,
    @w_interes_total                          money       ,
    @w_interes_proy                           money       ,
    @w_total_credito                          money       ,
    @w_capital                                money       ,
    @w_interes                                money       ,
    @w_interes_par                            money       ,
    @w_iva_interes                            money       ,
    @w_total_parcial                          money       ,
    @w_base_calculo                           money       ,
    @w_saldo_final_cap                        money       ,
    @w_estado_cartera                         int         ,
    @w_desc_estado                            varchar(64) ,
    @w_plazo                                  int         ,
    @w_desc_tplazo                            varchar(64) ,
    @w_cod_tplazo                             varchar(10) ,
    @w_fecha_pago                             datetime    ,
    @w_operacion                              int         ,
    @w_dia_pago                               varchar(30) ,
    @w_tasa                                   float       ,
    @w_tasa_mensual                           float       ,
    @w_deposito_gar                           money       ,
    @w_fecha_dep_gar                          datetime    ,
    @w_cat                                    float       ,
    @w_com_mora                               money       ,
    @w_num_div                                int         ,   
    @w_fecha_cancela                          datetime    ,
    @w_fecha_aux                              datetime    ,
    @w_num_movimiento                         int         ,
    @w_imp_comision                           money       ,
    @w_iva_tot_interes                        money       ,
    @w_fecha_comision                         datetime    ,
    @w_in_folio_fiscal                        varchar (60)    ,        
    @w_in_certificado                         varchar (30)    , 
    @w_in_sello_digital                       varchar (1500)  ,    
    @w_in_sello_sat                           varchar (1500)  ,    
    @w_in_num_se_certificado                  varchar (30)    ,    
    @w_in_fecha_certificacion                 datetime        ,
    @w_in_cadena_cer_dig_sat                  varchar (1500)  ,
    @w_fecha_proceso                          DATETIME        ,
    @w_primer_dia_mes                         DATETIME        ,
    @w_fecha_generacion_estado_cuenta         DATETIME ,
    @w_primer_dia_mes_anterior                DATETIME        ,
    @w_suma_importe                           MONEY           ,
    @w_iva_importe                            MONEY           ,
    @w_porcentaje_iva                         NUMERIC(10,6)   ,
    @w_rfc_generico                           varchar(30) ,
    @w_est_vigente                            tinyint,
    @w_est_novigente                          tinyint,
    @w_est_vencido                            tinyint,
    @w_est_cancelado                          tinyint,
    @w_est_suspenso                           tinyint,
    @w_est_castigado                          tinyint,
    @w_est_diferido                           tinyint,
    @w_error                                  int,    
    @w_saldo_capital                          money,
    @w_sec                                    int,
    @w_cap_pago                               money,
    @w_fpago_objetado                         cuenta ,
    @w_fpago_quebranto                        cuenta,
    @w_dr_cap_vig_ex                          money,
    @w_dr_cap_ven_ex                          money,
    @w_dr_int_vig_ex                          money,
    @w_dr_int_ven_ex                          money,
    @w_dr_int_sus_ex                          money,
    @w_dr_int_pag                             money,
    @w_dr_iva_int_ex                          money,
    @w_dr_com_ex                              money,
    @w_dr_saldo_iva_com                       money,
    @w_dr_saldo_prestamo                      money,
    @w_total_cap_ex                           money,
    @w_total_int_ex                           money,
    @w_total_iva_int_ex                       money,
    @w_total_com_ex                           money,
    @w_total_iva_com                          money,
    @w_total_exigible_lcr                     money,
    @w_com_mora_lcr                           money,
    @w_sec_lcr                                int ,
    @w_saldo_lcr                              money,
    @w_cap_pago_lcr                           money,
    @w_tipo_pago_lcr                          varchar(10),
    @w_saldo_ins_lcr                          money,
    @w_total_pagos                            money,
    @w_rsm_capital                            money,
    @w_rsm_int_ord                            money,
    @w_rsm_iva_int                            money,
    @w_rsm_gas_cob                            money,
    @w_rsm_iva_gas_cob                        money,
    @w_rsm_num_dis                            int,
    @w_rsm_imp_dis                            money,
    @w_rsm_impt_comc                          money,
    @w_rsm_ful_cob                            datetime,
    @w_rsm_impt_comd                          money,
    @w_rsm_ful_disp                           datetime,
    @w_toperacion                             varchar(10),
    @w_borrar_estcta_cab_tmp                  char(1) = 'S',
    @w_borrar_info_cre_tmp                    char(1) = 'S',
    @w_borrar_amortizacion_tmp                char(1) = 'S',
    @w_borrar_dato_operacion_abono_temp       char(1) = 'S',
    @w_borrar_movimientos_tmp                 char(1) = 'S',
    @w_borrar_estcta_cab_tmp_lcr              char(1) = 'S',
    @w_borrar_info_cre_tmp_lcr                char(1) = 'S',
    @w_borrar_resumen_pagos_tmp_lcr           char(1) = 'S',
    @w_borrar_dato_operacion_abono_temp_lcr   char(1) = 'S',
    @w_fecha_ini_ope                          datetime,--Caso#154890'
    @w_op_anterior                            varchar(20),
    @w_in_rfc_emisor                          varchar(30),
    @w_monto_factura_xml                      varchar(30),
    @w_interes_estado_cuenta 				  float,
	@w_tir                   				  float,
	@w_tea                   				  float

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_cons_estado_cuenta'

-- Parametro rfc Generico                         
select @w_rfc_generico = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'RFCGEN' 


select 
@w_fpago_objetado  = 'OBJETADO',
@w_fpago_quebranto = 'QUEBRANTO'

--se elimina los datos iniciales para que no se duplique la infromacion en el reporte   


if @i_operacion = 'A'
BEGIN
      
   select @w_toperacion=op_toperacion 
          from cob_cartera..ca_operacion
          where op_banco=@i_banco
	 
   PRINT '@i_secuencial'+ convert(VARCHAR(50),@i_secuencial)
   if(@w_toperacion='GRUPAL')
   begin
	  if exists (select 1 from sb_estcta_cab_tmp where ec_secuencial = @i_secuencial and ec_operacion = @i_banco) 
	      select @w_borrar_estcta_cab_tmp = 'N'
	  
	  if exists (select 1 from sb_info_cre_tmp where ic_secuencial = @i_secuencial and ic_banco = @i_banco)	
          select @w_borrar_info_cre_tmp = 'N'
		  
	  if exists (select 1 from sb_amortizacion_tmp where am_secuencial = @i_secuencial and am_banco = @i_banco)
	      select @w_borrar_amortizacion_tmp = 'N'
		 
	  if exists (select 1 from sb_dato_operacion_abono_temp where doa_secuencial = @i_secuencial and doa_banco = @i_banco)
	      select @w_borrar_dato_operacion_abono_temp = 'N'
		 
	  if exists (select 1 from sb_movimientos_tmp where mov_secuencial = @i_secuencial and mov_banco = @i_banco)
	      select @w_borrar_movimientos_tmp = 'N'

	  if (@w_borrar_estcta_cab_tmp = 'S' and @w_borrar_info_cre_tmp = 'S'and @w_borrar_amortizacion_tmp = 'S' and
	      @w_borrar_dato_operacion_abono_temp = 'S' and @w_borrar_movimientos_tmp = 'S')
      begin
        truncate table sb_estcta_cab_tmp 
        truncate table sb_info_cre_tmp
        truncate table sb_amortizacion_tmp
        truncate table sb_dato_operacion_abono_temp
        truncate table sb_movimientos_tmp---ParaCaso #148652 + caso #146792, al reejecutar se suma el valor anterior al actual. 
      end
	  else
	      return 0
   end
   if(@w_toperacion='REVOLVENTE')
   begin
       if exists (select 1 from sb_estcta_cab_tmp_lcr where ec_secuencial = @i_secuencial and ec_operacion = @i_banco)
	       select @w_borrar_estcta_cab_tmp_lcr = 'N'
		   
	   if exists (select 1 from sb_info_cre_tmp_lcr where ic_secuencial = @i_secuencial and ic_banco = @i_banco)
	       select @w_borrar_info_cre_tmp_lcr = 'N'
		   
	   if exists (select 1 from sb_resumen_pagos_tmp_lcr where rt_secuencial = @i_secuencial and rt_banco = @i_banco)
	       select @w_borrar_resumen_pagos_tmp_lcr = 'N'
		   
	   if exists (select 1 from sb_dato_operacion_abono_temp_lcr where doa_secuencial = @i_secuencial and doa_banco = @i_banco)
	       select @w_borrar_dato_operacion_abono_temp_lcr = 'N'
	   
	   if (@w_borrar_estcta_cab_tmp_lcr = 'S' and @w_borrar_info_cre_tmp_lcr = 'S' and 
	       @w_borrar_resumen_pagos_tmp_lcr = 'S' and @w_borrar_dato_operacion_abono_temp_lcr = 'S')
	   begin
          truncate table sb_estcta_cab_tmp_lcr
          truncate table sb_info_cre_tmp_lcr
          truncate table sb_resumen_pagos_tmp_lcr
          truncate table sb_dato_operacion_abono_temp_lcr
	   end
   end

    /* ESTADOS DE CARTERA */
    exec @w_error = cob_cartera..sp_estados_cca
    @o_est_vigente    = @w_est_vigente   out,
    @o_est_novigente  = @w_est_novigente out,
    @o_est_vencido    = @w_est_vencido   out,
    @o_est_cancelado  = @w_est_cancelado out,
    @o_est_castigado  = @w_est_castigado out,
    @o_est_suspenso   = @w_est_suspenso  out,
    @o_est_diferido   = @w_est_diferido  OUT
    if @w_error <> 0 
       RETURN @w_error
end

if @i_operacion = 'S' 
begin
   exec @w_return    = cobis..sp_cseqnos
        @t_from      = @w_sp_name,
        @i_tabla     = 'sb_ns_estado_cuenta',
        @o_siguiente = @o_secuencial out
    
   if @w_return <> 0
   begin
      RETURN @w_return --NO EXISTE TABLA EN TABLA DE SECUENCIALES
   end
    
   update cobis..cl_seqnos
   set    siguiente = @o_secuencial + 100
   where  tabla = 'sb_ns_estado_cuenta'
    
   select @o_mensaje    = null
   select @i_secuencial = @o_secuencial
   select @i_operacion  = 'A'            
end

if @i_operacion = 'C' OR @i_operacion = 'A' --Cabecera  / TODO
BEGIN
   IF @i_secuencial = 0 
   begin
      exec @w_return = cobis..sp_cseqnos
           @t_from      = @w_sp_name,
           @i_tabla     = 'sb_ns_estado_cuenta',
           @o_siguiente = @o_secuencial out
        
      if @w_return <> 0
      begin
         RETURN @w_return --NO EXISTE TABLA EN TABLA DE SECUENCIALES
      END
        
      SELECT @i_secuencial = @o_secuencial
   END
   ELSE
      SELECT @o_secuencial = @i_secuencial
    
   select @w_cod_oficina     = do_oficina,
          @w_cod_cliente     = do_codigo_cliente,
          @w_fecha_concesion = do_fecha_concesion,
          @w_codigo_topera   = do_tipo_operacion,
	  @w_estado_op		 = es_descripcion
   from   cob_conta_super..sb_dato_operacion op, cob_cartera..ca_estado 
   where  do_estado_cartera=es_codigo
   and    do_fecha = @i_fecha
   and    do_banco = @i_banco    
     
   IF @@ROWCOUNT = 0 
   BEGIN
      select @o_mensaje = (SELECT '['+ convert(VARCHAR,numero) +'] '+ mensaje FROM cobis..cl_errores WHERE numero = 710201)
      RETURN 710201
   end
     
   select @w_desc_toperacion = c.valor
   from cobis..cl_tabla t,cobis..cl_catalogo c
   where t.tabla  = 'ca_grupal'
   and   t.codigo = c.tabla
   and   c.codigo = @w_codigo_topera
     
   select @w_cod_grupo = gr_grupo,
          @w_nom_grupo = gr_nombre
   from   cob_credito..cr_tramite_grupal,
          cobis..cl_grupo
   where  tg_prestamo  = @i_banco
   and    tg_grupo     = gr_grupo
    
   select @w_num_ciclos = max(ci_ciclo)
   from  cob_cartera..ca_ciclo
   where ci_grupo       = @w_cod_grupo     
    
   select @w_nom_oficna = of_nombre
   from cobis..cl_oficina
   where of_oficina = @w_cod_oficina
   
   --Por caso #148652
   --select @w_nom_cliente = UPPER(ltrim(rtrim(isnull(dc_nombre,'')) + ' ' + UPPER(isnull(dc_p_apellido,'')) + ' ' + UPPER(isnull(dc_s_apellido,''))))
   --from cob_conta_super..sb_dato_cliente
   --where dc_cliente =  @w_cod_cliente
   select @w_nom_cliente = UPPER(ltrim(rtrim(isnull(p_p_apellido,'')))) + ' ' + UPPER(ltrim(rtrim(isnull(p_s_apellido,'')))) + ' ' +
                           UPPER(ltrim(rtrim(isnull(en_nombre,'')))) + ' ' + UPPER(ltrim(rtrim(isnull(p_s_nombre,'')))),
                  @w_rfc = en_nit						   
   from cobis..cl_ente where en_ente =  @w_cod_cliente    

   --encuentro el rfc segun el secuencial
   /*select @w_rfc = in_cliente_rfc 
   from   cob_conta_super..sb_ns_estado_cuenta 
   where nec_codigo = @i_secuencial
      
   if(rtrim(@w_rfc) = rtrim(@w_rfc_generico))
   begin
      set @w_rfc=@w_rfc_generico
   end 
   else
   begin
      select @w_rfc = en_nit
      from  cobis..cl_ente
      where en_ente = @w_cod_cliente
   end*/
	  
   if datepart(dd, @i_fecha) > 1 -- procesar con mes anterior
   begin                  
      select @w_mes_aux  = datepart(mm,@i_fecha),
             @w_anio_aux = datepart(yy,@i_fecha)    
                        
      select @w_fin_aux = convert(datetime,convert(varchar,@w_mes_aux)+'/01/'+convert(varchar,@w_anio_aux))
   end 

   select @w_reporte = 'NINGUN' 
   EXEC @w_return = cob_conta..sp_calcula_ultima_fecha_habil
        @i_reporte          = @w_reporte,  -- buro mensual
        @i_fecha            = @w_fin_aux,
        @o_existe_solicitud = @w_existe_solicitud  out,
        @o_ini_mes          = @w_ini_mes out,
        @o_fin_mes          = @w_fin_mes out,
        @o_fin_mes_hab      = @w_fin_mes_hab out,
        @o_fin_mes_ant      = @w_fin_mes_ant out,
        @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT      

   --Direccion
   select @w_calle     = di_calle    , 
          @w_numero    = di_nro      ,     
          -- 01 - COLONIA O POBLACION                        
          @w_parroquia = (select pq_descripcion from cobis..cl_parroquia where pq_parroquia = di_parroquia),
          -- 02 - DELEGACION O MUNICIPIO
          @w_delegacion   = (select ci_descripcion from cobis..cl_ciudad where ci_ciudad = di_ciudad),
               
          -- 05 - CODIGO POSTAL
          @w_codigo_postal =  (select case
                                      when eq_descripcion != 'MX' and di_codpostal is null 
                                      then '00000'
                                      else di_codpostal
                                      end
                               from sb_equivalencias
                               where eq_catalogo='CL_PAIS_A6'
                               and eq_valor_cat = di_pais),                 
          -- 04 - ESTADO
          @w_estado = (select upper(rtrim(ltrim(eq_descripcion)))
                       from sb_equivalencias
                       where eq_catalogo='ESTADOS_A7'
                       and eq_valor_cat = di_provincia )                       
   from   cobis..cl_direccion d1
   where  d1.di_ente      = @w_cod_cliente
   and    d1.di_principal = 'S'
   and    d1.di_tipo      = 'RE'
   and    d1.di_direccion = (select max(di_direccion)
                             from  cobis..cl_direccion d2
                             where d2.di_ente      = @w_cod_cliente
                             and   d2.di_principal = 'S' 
                             AND   d2.di_tipo      = 'RE')
    --Datos de xml Interfactura
   SELECT TOP 1 @w_in_folio_fiscal        = in_folio_fiscal,
                @w_in_certificado         = in_certificado,
                @w_in_sello_digital       = in_sello_digital,
                @w_in_sello_sat           = in_sello_sat,
                @w_in_num_se_certificado  = in_num_se_certificado,
                @w_in_fecha_certificacion = in_fecha_certificacion,
                @w_in_cadena_cer_dig_sat  = in_cadena_cer_dig_sat,
                @w_in_rfc_emisor          = isnull(in_rfc_emisor,''),
                @w_monto_factura_xml      = in_monto_fac
   FROM  cob_conta_super..sb_ns_estado_cuenta 
   WHERE nec_fecha = @i_fecha 
   AND   nec_banco  = @i_banco                            
   and   nec_codigo = @i_secuencial                           
                                

   --Por caso #148652
   if (@w_fecha_concesion between @w_ini_mes and @w_fin_mes)
       select @w_fecha_inicio = @w_fecha_concesion
   else
        select @w_fecha_inicio = @w_ini_mes
		
   if(@w_toperacion='GRUPAL')
   begin
   INSERT INTO sb_estcta_cab_tmp 
   SELECT 'secuencial'     = @i_secuencial,
          'Cod_Sucursal'   = @w_cod_oficina          ,
          'Sucursal'       = UPPER(isnull(@w_nom_oficna,'')),
          --Producto        
          'Producto'       = isnull(@w_desc_toperacion,''),
          'Nombre_Cliente' = @w_nom_cliente          ,
          --Grupo
          'Cod_Grupo'      = @w_cod_grupo            ,
          'Nom_Grupo'      = isnull(@w_nom_grupo,'') ,
          'RFC'            = isnull(@w_rfc,'')       ,
          'Operacion'      = @i_banco                ,
          --Domicilio
          'Calle'          = UPPER(isnull(@w_calle,''))     ,
          'Numero'         = UPPER(isnull(@w_numero,''))    ,
          'Parroquia'      = UPPER(isnull(@w_parroquia,'')) ,
          'Delegacion'     = UPPER(isnull(@w_delegacion,'')),
          'Codigo_Postal'  = UPPER(isnull(@w_codigo_postal,'')),
          'Estado'         = UPPER(isnull(@w_estado,''))    ,
          --Periodo
          'Fecha_Inicio'   = convert(varchar(10),@w_fecha_inicio,@i_formato),---@w_fecha_inicio
          'Fecha_Reporte'  = convert(varchar(10),@w_fin_mes,@i_formato),--convert(varchar(10),@i_fecha,@i_formato),
          --Fecha Corte
          'Dia_Habil'      = convert(varchar(10),@w_fin_mes, @i_formato),--convert(varchar(10),@w_fin_mes_hab, @i_formato),--caso#166476
          --Firma
          'Importes'       = 'Importes en Moneda Nacional',
          'Folio_Fiscal'   = @w_in_folio_fiscal ,
          'Certificado'    = @w_in_certificado  ,
          'Sello_Digital'  = @w_in_sello_digital,
          'Sello_SAT'      = @w_in_sello_sat    ,
          'No_De_Serie_Certificado' = @w_in_num_se_certificado,
          'Fecha_Certificacion'     = convert(varchar(10),@w_in_fecha_certificacion,103) + ' ' + convert(VARCHAR (5), CONVERT(datetime, @w_in_fecha_certificacion, 108),108),
          'Cadena_Original_Complemeto_SAT' = @w_in_cadena_cer_dig_sat,
          'Estado_OP'      = @w_estado_op,
          'Rfc_emisor'     = @w_in_rfc_emisor,
          'monto_Factura'  = @w_monto_factura_xml
          
   end

--Cargo datos para lcr por conflictos al entrar borrando por grupal
   if(@w_toperacion='REVOLVENTE')
   begin
  INSERT INTO cob_conta_super..sb_estcta_cab_tmp_lcr 
   SELECT 'secuencial'     = @i_secuencial,
          'Cod_Sucursal'   = @w_cod_oficina          ,
          'Sucursal'       = UPPER(isnull(@w_nom_oficna,'')),
          --Producto       
          'Producto'       = isnull(@w_desc_toperacion,''),
          'Nombre_Cliente' = @w_nom_cliente          ,
          --Grupo
          'Cod_Grupo'      = @w_cod_grupo            ,
          'Nom_Grupo'      = isnull(@w_nom_grupo,'') ,
          'RFC'            = isnull(@w_rfc,'')       ,
          'Operacion'      = @i_banco                ,
          --Domicilio
          'Calle'          = UPPER(isnull(@w_calle,''))     ,
          'Numero'         = UPPER(isnull(@w_numero,''))    ,
          'Parroquia'      = UPPER(isnull(@w_parroquia,'')) ,
          'Delegacion'     = UPPER(isnull(@w_delegacion,'')),
          'Codigo_Postal'  = UPPER(isnull(@w_codigo_postal,'')),
          'Estado'         = UPPER(isnull(@w_estado,''))    ,
          --Periodo
          'Fecha_Inicio'   = convert(varchar(10),@w_fecha_concesion,@i_formato),
          'Fecha_Reporte'  = convert(varchar(10),@w_fin_mes,@i_formato),--convert(varchar(10),@i_fecha,@i_formato),
          --Fecha Corte
          'Dia_Habil'      = convert(varchar(10),@w_fin_mes,@i_formato),--convert(varchar(10),@w_fin_mes_hab,@i_formato),--caso#166476
          --Firma
          'Importes'       = 'Importes en Moneda Nacional',
          'Folio_Fiscal'   = @w_in_folio_fiscal ,
          'Certificado'    = @w_in_certificado  ,
          'Sello_Digital'  = @w_in_sello_digital,
          'Sello_SAT'      = @w_in_sello_sat    ,
          'No_De_Serie_Certificado' = @w_in_num_se_certificado,
          'Fecha_Certificacion'     = convert(varchar(10),@w_in_fecha_certificacion,103) + ' ' + convert(VARCHAR (5), CONVERT(datetime, @w_in_fecha_certificacion, 108),108),
          'Cadena_Original_Complemeto_SAT' = @w_in_cadena_cer_dig_sat,
		  'Estado_OP'      = @w_estado_op,
		  'Rfc_emisor'     = @w_in_rfc_emisor,
          'monto_Factura'  = @w_monto_factura_xml
   end 

END

if @i_operacion = 'I' OR @i_operacion = 'A' --Informacion Crédito / TODO
begin
   if datepart(dd, @i_fecha) > 1 -- procesar con mes anterior
   begin                  
      select @w_mes_aux  = datepart(mm,@i_fecha),
             @w_anio_aux = datepart(yy,@i_fecha)    
                         
      select @w_fin_aux = convert(datetime,convert(varchar,@w_mes_aux)+'/01/'+convert(varchar,@w_anio_aux))
   end 
     
   select @w_saldo           = do_saldo ,
          @w_monto           = do_monto ,
          @w_base_calculo    = do_monto ,
          @w_saldo_final_cap = do_monto ,
          @w_estado_cartera  = do_estado_cartera   ,
          @w_fecha_concesion = do_fecha_concesion  ,
          @w_fecha_fin_ope   = isnull(do_fecha_prox_vto,do_fecha_vencimiento),--do_fecha_vencimiento,se encuentra el dia de pago de la proxima couta--caso #148652
          @w_plazo           = do_num_cuotas       ,
          @w_tasa            = do_tasa             ,
          @w_tasa_mensual    = do_tasa / 12        ,
          @w_deposito_gar    = isnull(do_gar_liq_orig , 0),
          @w_fecha_dep_gar   = do_gar_liq_fpago,
          @w_cat             = isnull(do_valor_cat,0),
 @w_fecha_fin       = isnull(do_fecha_vencimiento,do_fecha_aprob_tramite), -- caso#152856
          @w_fecha_ini_ope   = isnull(do_fecha_aprob_tramite, do_fecha_concesion)--caso #154890              
   from   cob_conta_super..sb_dato_operacion op
   where  do_fecha = @i_fecha
   and    do_banco = @i_banco  

   IF @@ROWCOUNT = 0 
   BEGIN
      select @o_mensaje = (SELECT '['+ convert(VARCHAR,numero) +'] '+ mensaje FROM cobis..cl_errores WHERE numero = 710201)
      RETURN 710201
   end
   
   select @w_desc_estado = es_descripcion
   from   cob_cartera..ca_estado
   where  es_codigo = @w_estado_cartera
     
   select @w_cod_tplazo = op_tplazo   ,
          @w_operacion  = op_operacion      
   from   cob_cartera..ca_operacion
   where  op_banco = @i_banco
    
   select @w_desc_tplazo = td_descripcion
   from   cob_cartera..ca_tdividendo
   where  td_tdividendo = @w_cod_tplazo
    
   select @w_interes= sum(isnull(dc_int_cuota,0))+ sum(isnull(dc_iva_int_cuota,0))
   from   cob_conta_super..sb_dato_cuota_pry
   where  dc_banco    = @i_banco
   and    dc_fecha    = @i_fecha
   
   select @w_total_credito = @w_monto + @w_interes
   
   select @w_capital = sum(isnull(dr_valor,0))
   from   cob_conta_super..sb_dato_operacion_rubro
   where  dr_fecha    = @i_fecha
   and    dr_banco    = @i_banco
   and    dr_concepto = 'CAP'
   and    dr_estado   in (@w_est_novigente, @w_est_vigente, @w_est_vencido)
     /*
     select  @w_interes_par = sum(isnull(dc_int_cuota,0)) - sum(isnull(dc_int_pag,0))
     from cob_conta_super..sb_dato_cuota_pry
     where dc_banco    = @i_banco
     and   dc_fecha    = @i_fecha
     and   dc_estado in (0,1,2)
     
     select @w_iva_interes=sum(isnull(dc_iva_int_cuota,0)) - sum(isnull(dc_iva_int_pag,0))
     from cob_conta_super..sb_dato_cuota_pry
     where dc_banco    = @i_banco
     and   dc_fecha    = @i_fecha
     and   dc_estado in (0,1,2)
     */ 
   select  @w_interes_par   = sum(isnull(dc_int_cuota,0)) - sum(isnull(dc_int_pag,0)),
           @w_iva_interes   = sum(isnull(dc_iva_int_cuota,0)) - sum(isnull(dc_iva_int_pag,0)),
           @w_saldo_capital = sum(isnull(dc_cap_cuota - dc_cap_pag,0))             
   from    cob_conta_super..sb_dato_cuota_pry
   where   dc_banco    = @i_banco
   and     dc_fecha    = @i_fecha
   and     dc_estado in (@w_est_vigente, @w_est_vencido)
          
   select @w_total_parcial = @w_saldo_capital + @w_interes_par + @w_iva_interes
   
   select @w_fecha_pago = @w_fecha_ini_ope --caso #154890---
   
   select @w_dia_pago= upper(datename(weekday, @w_fecha_pago))
   
   select @w_dia_pago = case 
                        when @w_dia_pago = 'MONDAY'    THEN 'LUNES'
                        when @w_dia_pago = 'TUESDAY'   THEN 'MARTES'
                        when @w_dia_pago = 'WEDNESDAY' THEN 'MIERCOLES'
                        when @w_dia_pago = 'THURSDAY'  THEN 'JUEVES'
                        when @w_dia_pago = 'FRIDAY'    THEN 'VIERNES'
                        when @w_dia_pago = 'SATURDAY'  THEN 'SABADO'
                        ELSE 'DOMINGO' end 
      
      
   select @w_com_mora= sum(isnull(dc_imo_cuota,0))
   from sb_dato_cuota_pry
   where dc_banco    = @i_banco
   and   dc_fecha    = @i_fecha
   and   dc_fecha_vto >= @w_fin_aux and dc_fecha_vto <= @i_fecha
   and   dc_estado  = @w_est_vencido
   
   -- caso #148652
   /*select @w_fecha_fin = op_fecha_fin
   from   cob_cartera..ca_operacion
   where  op_banco = @i_banco*/
   
   if(@w_toperacion='GRUPAL')
   begin
   INSERT INTO sb_info_cre_tmp
   select 
       'secuencial'      = @i_secuencial,
       'Limite_Credito'  = @w_monto        ,
       'Saldo_Inicial'   = @w_monto        , 
       'Interes_Ordinario'= @w_interes      ,
       'Total_Credito'   = @w_total_credito,
       
       'Capital'         = @w_saldo_capital, --@w_capital      ,
       'Interes_Par'     = @w_interes_par  ,
       'Iva_Interes'     = @w_iva_interes  ,
       'Total_Parcial'   = @w_total_parcial,
       
       'Base_Calculo'    = @w_base_calculo ,
       'Saldo_Final_Cap' = @w_capital,--@w_saldo_final_cap se obtiene el valor del capital de la deuada a a la fecha
       'Estado'          = convert(varchar(1),@w_estado_cartera) + '-' + @w_desc_estado,
       
       'Fecha_Inicio'    = convert(varchar(10),@w_fecha_concesion,@i_formato),
       'Fecha_Fin'       = convert(varchar(10),@w_fecha_fin,@i_formato),--convert(varchar(10),@w_fecha_fin_ope,@i_formato),
      
       'Frecuencia_Pago' = @w_desc_tplazo,
       'Plazo'           = @w_plazo      ,
       'Dia_Pago'        = @w_dia_pago   ,
       
       'Tasa_Ordinaria'  = @w_tasa        ,
       'Tasa_Mensual'    = @w_tasa_mensual,
   
       'Dep_Garantias'    =  @w_deposito_gar,
       'Fec_Dep_Garantias'= convert(varchar(10),@w_fecha_dep_gar,@i_formato),
       'Cat'              = @w_cat,
       'Comisiones'       = @w_com_mora,
       'Banco'            = @i_banco  
   end        
       /*Ingreso datos para informacion de Credito de las LCR*/ 
   if(@w_toperacion='REVOLVENTE')
   begin
    select
    --CAPITALES
    @w_dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado =   1  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
    @w_dr_cap_ven_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (2,4)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
    --INTERESES
    @w_dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   1  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
    @w_dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   2  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
    @w_dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (9,4) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
    --IVAS
    @w_dr_iva_int_ex    = sum(case when dr_categoria  = 'A' and dr_cat_rub_aso  = 'I' and dr_exigible    = 1 then  isnull(dr_valor,0) else 0 end),
    --COMISIONES
    @w_dr_com_ex        = sum(case when dr_categoria  = 'O' and dr_exigible    = 1   then isnull(dr_valor,0) else 0 end),
    --IVA SOBRE COMISIONES 
    @w_dr_saldo_iva_com = sum(case when dr_categoria  = 'A' and  dr_cat_rub_aso  = 'O' then isnull(dr_valor,0) else 0 end),
    
    @w_dr_saldo_prestamo= sum(isnull(dr_valor,0))
    
    from  cob_conta_super..sb_dato_operacion_rubro
    where dr_fecha      = @i_fecha
    and   dr_aplicativo = 7
    and   dr_banco      = @i_banco
    group by dr_banco
    
    select @w_total_cap_ex     = isnull(@w_dr_cap_vig_ex,0)+isnull(@w_dr_cap_ven_ex,0)
    select @w_total_int_ex     = isnull(@w_dr_int_vig_ex,0 )+isnull(@w_dr_int_ven_ex,0)+isnull(@w_dr_int_sus_ex,0)
    select @w_total_iva_int_ex = isnull(@w_dr_iva_int_ex,0)
    select @w_total_com_ex     = isnull(@w_dr_com_ex,0)
    select @w_total_iva_com    = isnull(@w_dr_saldo_iva_com,0)
    
    select @w_total_exigible_lcr= @w_total_cap_ex+@w_total_int_ex+@w_total_iva_int_ex+@w_total_com_ex+@w_total_iva_com
    
    select @w_com_mora_lcr= sum(isnull(dc_imo_cuota,0))
    from sb_dato_cuota_pry
    where dc_banco    = @i_banco
    and   dc_fecha    = @i_fecha
    and   dc_fecha_vto between @w_fin_aux and @i_fecha
    -- and   dc_fecha_vto >= @w_fin_aux and dc_fecha_vto <= @i_fecha
    --and   dc_estado  = @w_est_vencido
    							
	-------CALCULO DE CAT LCR FASE 2 --------------------
	
   exec @w_error=cob_cartera..sp_lcr_cat_estado_cuenta 
   @i_banco                 = @i_banco  ,
   @o_interes_estado_cuenta = @w_interes_estado_cuenta out 
   
   if @w_error <> 0  begin
      select @o_mensaje = 'ERROR EN CALCULO CAT ESTADO CUENTA'
      return 710202
   end
	
   exec @w_error = cob_cartera..sp_tir
   @i_banco      = @i_banco ,
   @i_tasa       = @w_interes_estado_cuenta,
   @o_cat        = @w_cat out,
   @o_tir        = @w_tir out,
   @o_tea        = @w_tea out
   
    if @w_error <> 0  begin
      select @o_mensaje = 'ERROR EN CALCULO TIR ESTADO CUENTA'
      return 710203
    end

   update cob_conta_super..sb_dato_operacion set 
   do_valor_cat   = @w_cat
   where do_fecha = @i_fecha 
   and do_banco   = @i_banco
  
   if @@error <> 0  begin
      select @o_mensaje = 'ERROR EN ACTUALIZACION SB_DATO_OPERACION'
      return 710203
   end  
    ---------------------------------------------------	
    INSERT INTO cob_conta_super..sb_info_cre_tmp_lcr
    select  
            'secuencial'         = @i_secuencial,
            'Fecha_inicio'       = do_fecha_concesion,
            'Fecha_Fin'          = do_fecha_vencimiento,
            'Linea_de_Credito'   = do_monto_aprobado, 
            'Linea_Disponible'   = do_monto_aprobado-do_saldo_cap, --poner el valor de luchito del Saldo de Capital a la fecha de fin de mes.      
            'Capital'            = @w_total_cap_ex,
            'Int_Ord'            = @w_total_int_ex,
            'Iva_Int_Ord'        = @w_total_iva_int_ex,
            'Gastos_conbranza'   = @w_total_com_ex,
            'Iva_Gastos_cobranza'= @w_total_iva_com,
            'Total'              = @w_total_exigible_lcr, 
            'Frecuencia Pago'    = do_plazo,
            'Plazo'              = DATEDIFF(ww,do_fecha_concesion,do_fecha_vencimiento),
            'Dia_Pago'           = case when do_tplazo in ('W') 
                                    then 'MARTES'
									         --else (case upper(datename(weekday, do_fecha_prox_vto)) 
											 else (case upper(datename(weekday, isnull(do_fecha_prox_vto,do_fecha_aprob_tramite)))--caso #148652 
    								         when 'MONDAY'     then 'LUNES'  
    								         when 'TUESDAY'    then 'MARTES' 
    								         when 'WEDNESDAY'  then 'MIERCOLES' 
    								         when 'THURSDAY' then 'JUEVES' 
    								         when 'FRIDAY'     then 'VIERNES' 
    								         when 'SATURDAY'   then 'SABADO'     
    								         else 'DOMINGO'   end) end,
            'TasaAnual'		  = do_tasa,
            'TasaMensual'		  = do_tasa/12,
            'Saldo_Inso_Cap'  = do_saldo_cap,--falta poner lo de 
            'CAT'              = isnull(@w_cat,0),    --- CALCULAR EN EL CONSOLIDADOR LCR DE FIN DE MES 
            'Com_Acumuladas'   = @w_com_mora_lcr,
            'Banco'            = @i_banco
    from cob_conta_super..sb_dato_operacion
    where do_fecha = @i_fecha
    and do_banco   = @i_banco
    end     
                  
END

if @i_operacion = 'M' OR @i_operacion = 'A' --Movimientos  / TODO
begin

   if(@w_toperacion='GRUPAL')
   begin
   
      select * into #tmp_dato_operacion
      from cob_conta_super..sb_dato_operacion
      where  do_fecha      = @i_fecha
      and    do_banco      = @i_banco
      and    do_aplicativo = 7
	  
      select * into #tmp_dato_operacion_abono	 
      from cob_conta_super..sb_dato_operacion_abono
      where  doa_fecha      = @i_fecha
      and    doa_banco      = @i_banco
      and    doa_aplicativo = 7
      order by doa_fecha_pag,doa_sec_pag,doa_dividendo		  
	  
      insert into cob_conta_super..sb_dato_operacion_abono_temp
      select 
      doa_fecha_pag,
          doa_di_fecha_ven,
          doa_dividendo,
          doa_dias_atraso,
      doa_fpago,
      doa_total,
      doa_capital,
      doa_int,
      doa_otro,
      doa_saldo_cap,
      doa_banco,
      doa_fecha,
      @i_secuencial,
      doa_fpago,
	  null
      from   #tmp_dato_operacion_abono
      where  doa_fpago = 'Saldo Inicial'	

	  --SRO. 147999 PAGO ADEUDO en Operación Renovada 
      select @w_op_anterior =  do_op_anterior from #tmp_dato_operacion where do_op_anterior is not null 
	  
	  if @@rowcount <> 0  begin
	  
	     insert into cob_conta_super..sb_dato_operacion_abono_temp 
		 values (null, null, 1, 0,
         'REF PAGO ADEUDO PREVIO CTO ' + @w_op_anterior, null, null, null,
         null, null, @i_banco, null,
         @i_secuencial,'PAGO ADEUDO', @w_op_anterior)
 
               end
	  
	  select top 1 
	  doat_fecha_pag    = a.doa_fecha_pag,
      doat_di_fecha_ven = a.doa_di_fecha_ven,
      doat_dividendo    = a.doa_dividendo,
      doat_dias_atraso  = a.doa_dias_atraso,
      doat_fpago        = a.doa_fpago,
      doat_total        = a.doa_total,
      doat_capital      = a.doa_total,
      doat_int          = a.doa_int,
      doat_otro         = a.doa_otro,
      doat_banco        = a.doa_banco,
      doat_fecha        = a.doa_fecha
	  into #tmp_sb_dato_operacion_abono_ant
	  from cob_conta_super..sb_dato_operacion_abono a
	  where (@w_op_anterior is not null and a.doa_banco = @w_op_anterior)
	  and   a.doa_fecha       = @i_fecha
      and   a.doa_aplicativo  = 7
	  order by a.doa_secuencial desc

	  update cob_conta_super..sb_dato_operacion_abono_temp set 
	  doa_total             = doat_total,
	  doa_fecha_ope         = doat_fecha_pag,
	  doa_fecha_pac         = doat_di_fecha_ven,
	  doa_dias_atra         = doat_dias_atraso,
      doa_fecha             = doat_fecha,
	  doa_cap               = 0--doat_totalcaso#170283--null--caso#168771
	  from #tmp_sb_dato_operacion_abono_ant
	  where doa_op_anterior = doat_banco 
	  and   doa_op_anterior is not null	
	    
	  INSERT INTO cob_conta_super..sb_dato_operacion_abono_temp
      SELECT 
      doa_fecha_pag,
      doa_di_fecha_ven,
      doa_dividendo,
      doa_dias_atraso,
      'PAGO '+ doa_fpago,
          doa_total,
          doa_capital,
      doa_int        = case when doa_fpago in ('INT_ESPERA','IVA_ESPERA') then round(doa_int/2, 2)--Caso: 148652/146792, cuando se tiene pagos condonados el valor se duplicaba
                    else doa_int end,
          doa_otro,
          doa_saldo_cap,
          doa_banco,
          doa_fecha,
      @i_secuencial,
      doa_fpago,
	  null
      from   #tmp_dato_operacion_abono
      where  doa_fpago    not in ( 'Saldo Inicial', 'RENOVACION' )
	  and    doa_tipo_trn = 'PAG'
	  order by doa_fecha_pag, doa_sec_pag, doa_dividendo	  
		  
	  insert into cob_conta_super..sb_dato_operacion_abono_temp
	  select
      max(doa_fecha_pag),
      max(doa_di_fecha_ven),
      min(doa_dividendo),
      max(doa_dias_atraso),
      'PAGO RENOVACION FINANCIADA CTO ',
      max(doa_total),
      sum(doa_capital),
      sum(round(doa_int/2, 2)),
      sum(doa_otro),
      sum(doa_saldo_cap),
      max(doa_banco),
      max(doa_fecha),
      @i_secuencial,
      max(doa_fpago),
	  null
      from   #tmp_dato_operacion_abono, #tmp_dato_operacion
      where  doa_banco      = do_banco
	  and    doa_fecha      = do_fecha 
	  and    doa_aplicativo = do_aplicativo
      and    doa_fpago      = 'RENOVACION' 
	  and    doa_tipo_trn   = 'PAG'
  
      update cob_conta_super..sb_dato_operacion_abono_temp set 
	  doa_detalle_mov = doa_detalle_mov + ' ' + do_banco
      from cob_conta_super..sb_dato_operacion	  
	  where do_op_anterior = doa_banco
	  and   do_fecha       = @i_fecha
      and   do_aplicativo  = 7
      and   doa_fpago      = 'RENOVACION' 
    
   SELECT @w_sec = 0

   SELECT @w_saldo     = doa_saldo_cap
   FROM   cob_conta_super..sb_dato_operacion_abono_temp
       WHERE  doa_fecha = @i_fecha
       and    doa_banco = @i_banco
	   and    doa_secuencial = @i_secuencial
       and    doa_num_pago = 0

   WHILE 1 = 1
   BEGIN
      SELECT TOP 1  @w_sec       = doa_sec,
                     @w_cap_pago  = doa_cap
      FROM cob_conta_super..sb_dato_operacion_abono_temp
      WHERE doa_sec > @w_sec
      AND doa_num_pago > 0
          and doa_fecha = @i_fecha
          and doa_banco = @i_banco
		  and doa_secuencial = @i_secuencial
      ORDER BY doa_sec
		 
      IF @@rowcount = 0 BREAK
       
      UPDATE cob_conta_super..sb_dato_operacion_abono_temp 
	  SET    doa_saldo_cap = @w_saldo - @w_cap_pago
      WHERE  doa_sec = @w_sec
   and    doa_fecha    = @i_fecha
   and    doa_banco    = @i_banco
   and    doa_secuencial = @i_secuencial
   
      SELECT @w_saldo      = @w_saldo - @w_cap_pago
   END
		 
   select @w_operacion = op_operacion
   from cob_cartera..ca_operacion
   where op_banco = @i_banco
        
   IF @@ROWCOUNT = 0 
   BEGIN
      select @o_mensaje = (SELECT '['+ convert(VARCHAR,numero) +'] '+ mensaje FROM cobis..cl_errores WHERE numero = 710201)
      RETURN 710201
   end
   
   --Insercion liquidacion        
   select @w_monto           = do_monto ,
          @w_fecha_concesion = do_fecha_concesion       
   from   cob_conta_super..sb_dato_operacion op
   where  do_fecha = @i_fecha
   and    do_banco = @i_banco  
   IF @@ROWCOUNT = 0 
   BEGIN
      PRINT 'NO EXISTE LA OPERACION 2'
      RETURN 710201
   end

   insert into sb_movimientos_tmp
     (mov_numero        ,       mov_fecha          ,       mov_fecha_pactada  ,
      mov_numero_pago   ,       mov_dias_atraso    ,       mov_detalle_mov    ,
      mov_total         ,       mov_capital        ,       mov_interes_ordina ,
      mov_comision_cob  ,       mov_saldo_capital  ,       mov_dividendo      ,
      mov_secuencial    ,       mov_banco)                           
   values(                                                                   
      0                ,       @w_fecha_concesion,       @w_fecha_concesion,
      0                ,       0                 ,       'Saldo Inicial'   ,
      @w_monto         ,       @w_monto          ,       0                 ,
      0                ,       @w_monto          ,       0                 ,
      @i_secuencial    ,       @i_banco)
                
   insert into sb_movimientos_tmp
   (
     mov_dividendo       ,
     mov_fecha           ,
     mov_fecha_pactada   ,
     mov_numero_pago     ,        
     mov_detalle_mov     ,
     mov_total           ,
     mov_capital         ,
     mov_interes_ordina  ,
     mov_interes_mora    ,       
     mov_iva_int_pag     ,
     mov_iva_imo_pag     ,
     mov_iva_pre_pag     ,
     mov_comision_cob    ,
     mov_otros           ,
     mov_secuencial      ,
	 mov_banco
   )     
   select dc_num_cuota,
          dc_fecha_can,
          dc_fecha_vto,
          1           ,
          'Pago Referenciado Santander',
          'Total'     = isnull(dc_cap_pag,0)     + isnull(dc_int_pag,0)     + isnull(dc_imo_pag,0)     + isnull(dc_pre_pag,0) +
                        isnull(dc_iva_int_pag,0) + isnull(dc_iva_imo_pag,0) + isnull(dc_iva_pre_pag,0) + isnull(dc_otros_pag,0),
          'Capital'   = isnull(dc_cap_pag,0),
          'Interes'   = isnull(dc_int_pag,0),
          'Mora'      = isnull(dc_imo_pag,0),
          'Iva_Int'   = isnull(dc_iva_int_pag,0),
          'Iva_Mora'  = isnull(dc_iva_imo_pag,0),
          'Iva_Precan'= isnull(dc_iva_pre_pag,0),
          'Comision'  = isnull(dc_pre_pag,0),
          'Otros Pag' = isnull(dc_otros_pag,0)          ,
          @i_secuencial,
          @i_banco
   from  cob_conta_super..sb_dato_cuota_pry
   where dc_fecha     = @i_fecha
   and   dc_banco     = @i_banco
   and   dc_fecha_can is not null  
   and   dc_fecha_can <> '01/01/1900'
   and   dc_estado    = @w_est_cancelado
   order by dc_num_cuota, dc_fecha_can
     
     
   insert into sb_movimientos_tmp
   (
     mov_dividendo       ,
     mov_fecha           ,
     mov_fecha_pactada   ,
     mov_numero_pago     ,        
     mov_detalle_mov     ,
     mov_total           ,
     mov_capital         ,
     mov_interes_ordina  ,
     mov_interes_mora    ,       
     mov_iva_int_pag     ,
     mov_iva_imo_pag     ,
     mov_iva_pre_pag     ,
     mov_comision_cob    ,
     mov_otros           ,
     mov_secuencial      ,
	 mov_banco
   )     
   select dc_num_cuota,
          dc_fecha_can,
          dc_fecha_vto,
          1           ,
          'Pago Referenciado Santander',
          'Total'     = isnull(dc_cap_pag,0)     + isnull(dc_int_pag,0)     + isnull(dc_imo_pag,0)     + isnull(dc_pre_pag,0) +
                        isnull(dc_iva_int_pag,0) + isnull(dc_iva_imo_pag,0) + isnull(dc_iva_pre_pag,0) + isnull(dc_otros_pag,0),
          'Capital'   = isnull(dc_cap_pag,0),
          'Interes'   = isnull(dc_int_pag,0),
          'Mora'      = isnull(dc_imo_pag,0),
          'Iva_Int'   = isnull(dc_iva_int_pag,0),
          'Iva_Mora'  = isnull(dc_iva_imo_pag,0),
          'Iva_Precan'= isnull(dc_iva_pre_pag,0),
          'Comision'  = isnull(dc_pre_pag,0),
          'Otros Pag' = isnull(dc_otros_pag,0)          ,
          @i_secuencial,
		  @i_banco
   from  cob_conta_super..sb_dato_cuota_pry
   where dc_fecha     = @i_fecha
   and   dc_banco     = @i_banco
   and   dc_estado    <> @w_est_cancelado
   and   (isnull(dc_cap_pag,0)   <> 0 or isnull(dc_int_pag,0) <>0 or isnull(dc_imo_pag,0)<>0)
   order by dc_num_cuota, dc_fecha_can
     
   select  'movimiento' = mov_secuencial, 'dividendo'=dtr_dividendo, 'fecha_pago' = max(ab_fecha_pag), 'banco' = tr_banco -- x caso#148652
   into #tmp_pago
   from  cob_conta_super..sb_movimientos_tmp, 
         cob_cartera..ca_transaccion, 
         cob_cartera..ca_det_trn,
         cob_cartera..ca_abono
   where mov_secuencial = @i_secuencial
   and   mov_banco      = @i_banco  -- x caso#148652
   and   tr_banco       = mov_banco -- x caso#148652
   and   tr_operacion   = @w_operacion
   and   tr_operacion   = dtr_operacion
   and   tr_secuencial  = dtr_secuencial
   and   ab_secuencial_pag = tr_secuencial
   and   ab_operacion   = tr_operacion
   and   tr_tran        = 'PAG'
   and   tr_estado      <> 'RV'
   and   (mov_fecha    is null or mov_fecha = '01/01/1900')
   and   mov_dividendo  = dtr_dividendo
   group by mov_secuencial, dtr_dividendo, tr_banco
     
   update cob_conta_super..sb_movimientos_tmp
   set    mov_fecha = fecha_pago
   from   #tmp_pago
   where  mov_secuencial = movimiento
   and    mov_banco      = banco -- x caso#148652
   and    mov_dividendo  = dividendo

     /*
     select @w_fecha_comision = max(dc_fecha_vto)
     from  cob_conta_super..sb_dato_cuota_pry
     where dc_fecha     = @i_fecha
     and   dc_banco     = @i_banco
     and   dc_fecha_can <> null 
     and   dc_fecha_can <> '01/01/1900'
     and   dc_estado    = @w_est_vencido
     */
 
     /*select @w_fecha_comision = max(dc_fecha_vto),
            @w_imp_comision =sum( isnull(dc_imo_pag,0))+sum(isnull(dc_iva_imo_pag,0)) --isnull(sum(dc_otros_pag),0)
     from  cob_conta_super..sb_dato_cuota_pry
     where dc_fecha     = @i_fecha
     and   dc_banco     = @i_banco
     and   dc_fecha_can <> null 
     and   dc_fecha_can <> '01/01/1900'
     and    dc_estado    = @w_est_vencido
    */ 
      
   update  sb_movimientos_tmp
   set     mov_dias_atraso =  datediff(dd,mov_fecha_pactada,mov_fecha)
   WHERE mov_secuencial = @i_secuencial
   and mov_banco = @i_banco
   
   update sb_movimientos_tmp
   set   mov_dias_atraso =0
   where mov_dias_atraso <0
   and   mov_secuencial = @i_secuencial
   and mov_banco = @i_banco
   
   update sb_movimientos_tmp
   set mov_dias_atraso   = 0
   where mov_dias_atraso < 0  
   and mov_secuencial = @i_secuencial
   and mov_banco = @i_banco
   
   select @w_num_movimiento = 0,
          @w_fecha_cancela  = @w_fecha_concesion,
          @w_num_div = 0
     
   while 1 = 1
   begin 
      select top 1 @w_num_div       = mov_dividendo,  
                   @w_fecha_cancela = mov_fecha    ,
                   @w_capital       = mov_capital
      from sb_movimientos_tmp
      where mov_secuencial = @i_secuencial
      and mov_banco = @i_banco
      and mov_fecha  > @w_fecha_cancela
      or  (mov_fecha = @w_fecha_cancela and  mov_dividendo > @w_num_div)
      order by mov_dividendo, mov_fecha
            
      if @@rowcount=0
         break 
      
      if @w_fecha_aux <> @w_fecha_cancela
      begin
         select @w_fecha_aux = @w_fecha_cancela,
                @w_num_movimiento = @w_num_movimiento + 1
      end   
            
      select @w_monto = @w_monto - @w_capital
            
      update sb_movimientos_tmp
      set   mov_numero        =  @w_num_movimiento, 
            mov_saldo_capital =  @w_monto
      where mov_fecha      = @w_fecha_cancela
      and   mov_dividendo  = @w_num_div            
      and   mov_secuencial = @i_secuencial
      and   mov_banco      = @i_banco
   end    
   end 

   --Revolvente Movimientos
   if(@w_toperacion='REVOLVENTE')
   begin
       insert into cob_conta_super..sb_dato_operacion_abono_temp_lcr
       select 'Fecha_Ope' =case when doa_dividendo =0
                           then 
                           CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(@i_fecha)-1),@i_fecha),103)
                           else      
                             convert(varchar(10),doa_fecha_pag,103)
                           end,
              'Fecha_Pac' = case when doa_tipo_trn = ('PAG')
                            then 
                             convert(varchar(10),doa_di_fecha_ven,103)
                            else       
                             null
                            end,
              'Mov'        = case when doa_tipo_trn = ('PAG')
                             then 
                               +'PAGO '+doa_fpago
                             else     
                               doa_fpago       
                            
                             end,
              'Capital'    = doa_capital,
              'Interes_Ord'= case when doa_tipo_trn = ('DES')
                             then 0
                             else     
                              doa_int       
                             end,
              'Iva_Int'  = case when doa_tipo_trn in ('DES')
                           then 0
                           else     
                             doa_iva_int       
                           end,
              'Com_Dis'  = case when doa_tipo_trn in ('INI','PAG')
                           then 0
                           else     
                             doa_disp       
                           end,
              'Com_Iva_Dis'= case when doa_tipo_trn in ('INI','PAG')
                             then 0
                             else     
                               doa_iva_disp       
                             end,
              'Com_Cob'   = case when doa_tipo_trn in ('DES')
                            then 0
                            else     
                               doa_imo       
                            end,
              'Com_Iva_Cob'=  case when doa_tipo_trn in ('DES')
                             then 0
                             else     
                               doa_iva_imo       
                             end,
              'Total'       = doa_total,
              'Saldo_Cap'  = doa_saldo_cap,
              'Operacion'   = doa_banco,       
              'Fecha'       = doa_fecha,
              'NumPago'     = doa_dividendo,
              'TipoPago'    = doa_tipo_trn,
              'Secuencial'  = @i_secuencial
        from sb_dato_operacion_abono
        where doa_fecha      = @i_fecha
        and   doa_banco      = @i_banco
        and   doa_aplicativo = 7
        and   doa_objetado   ='N'
        order by doa_fecha_pag,doa_sec_pag,doa_dividendo

       SELECT @w_sec_lcr = 0
       
       SELECT @w_saldo_lcr = doa_cap
       FROM   cob_conta_super..sb_dato_operacion_abono_temp_lcr
       WHERE   doa_fecha    = @i_fecha
       and     doa_secuencial = @i_secuencial	   
       and     doa_banco    = @i_banco
       and     doa_num_pago = 0
       
       
       UPDATE cob_conta_super..sb_dato_operacion_abono_temp_lcr 
	    SET    doa_saldo_cap = @w_saldo_lcr
       WHERE  doa_fecha    = @i_fecha
       and     doa_secuencial = @i_secuencial	   
       and    doa_banco    = @i_banco	   
       and    doa_num_pago = 0 
       
       
       WHILE 1 = 1
       BEGIN
          SELECT TOP 1   @w_sec_lcr       = doa_sec,
                         @w_cap_pago_lcr  = doa_cap,
                         @w_tipo_pago_lcr = doa_tipo_trn
          FROM cob_conta_super..sb_dato_operacion_abono_temp_lcr
          WHERE doa_sec > @w_sec_lcr
          AND doa_num_pago > 0
          and doa_fecha    = @i_fecha 
          and doa_secuencial = @i_secuencial		  
          and doa_banco    = @i_banco
          ORDER BY doa_sec
          IF @@rowcount = 0 BREAK
          

          if(@w_tipo_pago_lcr='PAG')
          begin
            set @w_saldo_ins_lcr= @w_saldo_lcr - @w_cap_pago_lcr
          end
          
          if(@w_tipo_pago_lcr='DES')
          begin
             set @w_saldo_ins_lcr= @w_saldo_lcr + @w_cap_pago_lcr
          end
           
          UPDATE cob_conta_super..sb_dato_operacion_abono_temp_lcr 
	       SET    doa_saldo_cap = @w_saldo_ins_lcr
          WHERE  doa_sec      = @w_sec_lcr
          and    doa_fecha    = @i_fecha
          and    doa_secuencial = @i_secuencial		  
          and    doa_banco    = @i_banco
          
          set @w_saldo_lcr=@w_saldo_ins_lcr
          
       end 
   end   
--------------
   

END

if @i_operacion = 'T' OR @i_operacion = 'A'--Tabla Amortizacion  / TODO
begin
   if(@w_toperacion='GRUPAL')
   begin
   insert into sb_amortizacion_tmp   (
   am_secuencial     ,
   am_numero         ,
   am_fecha          ,
   am_capital        ,
   am_interes_ordina ,
   am_iva_int        ,
   am_comision_cob   ,
   am_iva_comision   ,
   am_monto_pago     ,
   am_banco)      
   select  @i_secuencial,
           dc_num_cuota,
           dc_fecha_vto,
           'Capital'     = isnull(dc_cap_cuota,0) -  isnull(dc_cap_pag,0),
           'Interes'     = isnull(dc_int_cuota,0) -  isnull(dc_int_pag,0),
           'Iva_Int'     = isnull(dc_iva_int_cuota,0)-isnull(dc_iva_int_pag,0),
           'Comision'    = isnull(dc_imo_cuota,0) - isnull(dc_imo_pag,0),
           'Iva_Comision'= isnull(dc_iva_imo_cuota,0)-isnull(dc_iva_imo_pag,0),
           'Monto_Pago'  = (isnull(dc_cap_cuota,0) -  isnull(dc_cap_pag,0)) + 
                           (isnull(dc_int_cuota,0) -  isnull(dc_int_pag,0)) + 
                           (isnull(dc_iva_int_cuota,0)-isnull(dc_iva_int_pag,0)) + 
                           (isnull(dc_imo_cuota,0) - isnull(dc_imo_pag,0))+
                           (isnull(dc_iva_imo_cuota,0) - isnull(dc_iva_imo_pag,0)),
   @i_banco						   
   from  cob_conta_super..sb_dato_cuota_pry
   where dc_fecha     = @i_fecha
   and   dc_banco     = @i_banco
   and   dc_estado    <> @w_est_cancelado 
   order by dc_num_cuota

   IF @@ROWCOUNT = 0 
   BEGIN
      select @o_mensaje = (SELECT '['+ convert(VARCHAR,numero) +'] '+ mensaje FROM cobis..cl_errores WHERE numero = 710201)
      RETURN 710201
   end
     
   select @w_saldo = sum(dc_cap_cuota)
   from  cob_conta_super..sb_dato_cuota_pry
   where dc_fecha     = @i_fecha
   and   dc_banco     = @i_banco
   and   dc_estado    <> @w_est_cancelado 
   group by  dc_banco
     
   select @w_num_div = 0
     
   while 1 = 1
   begin
      select top 1 @w_num_div = am_numero,
                   @w_capital = am_capital
      from   sb_amortizacion_tmp
      where  am_numero > @w_num_div
      and    am_secuencial = @i_secuencial
      and    am_banco = @i_banco
      order by am_numero
           
      if @@rowcount=0
         break 
               
      update sb_amortizacion_tmp
      set   am_saldo_capital =  @w_saldo 
      where am_numero = @w_num_div
      and am_secuencial = @i_secuencial
      and am_banco = @i_banco
           
      select @w_saldo = @w_saldo - @w_capital           
   end
end     
end    
--Pagos Resultados Revolvente
if @i_operacion = 'R' OR @i_operacion = 'A' --Cabecera  / TODO
BEGIN

   if(@w_toperacion='REVOLVENTE')
   begin

   IF @i_secuencial = 0 
   begin
      exec @w_return = cobis..sp_cseqnos
           @t_from      = @w_sp_name,
           @i_tabla     = 'sb_ns_estado_cuenta',
           @o_siguiente = @o_secuencial out
        
      if @w_return <> 0
      begin
         RETURN @w_return --NO EXISTE TABLA EN TABLA DE SECUENCIALES
      END
        
      SELECT @i_secuencial = @o_secuencial
   END
   ELSE
      SELECT @o_secuencial = @i_secuencial 
    
      
   /*select @w_total_pagos     = isnull(sum(doa_cap),0)+isnull(sum(doa_inte_ord),0)+isnull(sum(doa_iva_int),0)
                               +isnull(sum(doa_comision_cob),0)+isnull(sum(doa_iva_comision_cob),0),
          @w_rsm_gas_cob     = isnull(sum(doa_comision_cob),0),
          @w_rsm_iva_gas_cob = isnull(sum(doa_iva_comision_cob),0),
          @w_rsm_impt_comd   = isnull(sum(doa_comision_dis),0)           
   FROM cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   WHERE  doa_banco    = @i_banco
   AND    doa_fecha    = @i_fecha
   and    doa_tipo_trn = 'PAG'*/
      if datepart(dd, @i_fecha) > 1 -- procesar con mes anterior
   begin                  
      select @w_mes_aux  = datepart(mm,@i_fecha),
             @w_anio_aux = datepart(yy,@i_fecha)    
                         
      select @w_fin_aux = convert(datetime,convert(varchar,@w_mes_aux)+'/01/'+convert(varchar,@w_anio_aux))
   end 
   
   --select top 1 * from cob_conta_super..sb_dato_cuota_pry
    select @w_rsm_gas_cob     = sum(isnull(dc_imo_cuota,0)),
           @w_rsm_iva_gas_cob = sum(isnull(dc_iva_imo_cuota,0))
    
    from sb_dato_cuota_pry
        where dc_fecha    = @i_fecha
        and   dc_banco    = @i_banco
    and   dc_fecha_vto between @w_fin_aux and @i_fecha
   
   select 
          @w_total_pagos     = isnull(sum(doa_cap),0)+isnull(sum(doa_inte_ord),0)+isnull(sum(doa_iva_int),0)
                               +isnull(sum(doa_comision_cob),0)+isnull(sum(doa_iva_comision_cob),0),                     
          @w_rsm_capital     =isnull(sum(doa_cap),0),
          @w_rsm_int_ord     =isnull(sum(doa_inte_ord),0),
          @w_rsm_iva_int     = isnull(sum(doa_iva_int),0)
           
   FROM cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   WHERE  doa_fecha    = @i_fecha
   and    doa_secuencial = @i_secuencial	   
   AND    doa_banco    = @i_banco
   and    doa_tipo_trn = 'PAG'
   
       --select * from cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   
   select @w_rsm_num_dis = count(1),
          @w_rsm_imp_dis = isnull(sum(doa_cap),0),
              @w_rsm_ful_disp= max(CONVERT (datetime,doa_fecha_ope,103)), 
          @w_rsm_impt_comd = sum(doa_comision_dis)+sum(doa_iva_comision_dis)            
   FROM cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   WHERE  doa_fecha    = @i_fecha
   and    doa_secuencial = @i_secuencial	   
   AND    doa_banco    = @i_banco
   and    doa_tipo_trn = 'DES'
   
      
   select @w_rsm_ful_cob= max(CONVERT (datetime,doa_fecha_ope,103))   
   FROM   cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   WHERE  doa_fecha    = @i_fecha
   and    doa_secuencial = @i_secuencial	   
   AND    doa_banco    = @i_banco
   and    doa_comision_cob>0

   insert into cob_conta_super..sb_resumen_pagos_tmp_lcr
   SELECT 'Secuencial'               = @i_secuencial,
          'Total_Pagos'              = @w_total_pagos,           
          'Capital'                  = @w_rsm_capital,     
          'Int_Ord'                  = @w_rsm_int_ord,       
          'Iva_Int_Ord'              = @w_rsm_iva_int ,  
          'Gastos_CObranza'          = @w_rsm_gas_cob    ,
          'Iva_Gastos_Cobranza'      = @w_rsm_iva_gas_cob ,
          'Num_Disposiciones'        = @w_rsm_num_dis, 
          'ImporteDisposiciones'     = @w_rsm_imp_dis,
          'ImporteToComCobranza'     = @w_rsm_gas_cob,
          'Fecha_Ult_Cobro_Cobranza' = isnull(convert(varchar(10),@w_rsm_ful_cob,103),''),
          'ImporteToComDispos'       = @w_rsm_impt_comd,
          'Fecha_Ult_Cobro_Disps'    = isnull(convert(varchar(10),@w_rsm_ful_disp,103),''),
          'Banco'   		         = @i_banco
end        

end        

--//////////////////////////////////////////////////////////////
-- DEVOLVER DATOS AL REPORTE
--//////////////////////////////////////////////////////////////
/* MAPEAR LOS DATOS CARGADOS EN LA OPCION C */
if @i_operacion = 'C1' --Cabecera
begin
   SELECT ec_cod_sucursal           ,
          ec_sucursal               ,
          ec_producto               ,
          ec_nombre_cliente         ,
          ec_cod_grupo              ,
          ec_nom_grupo              ,
          ec_rfc                    ,
          ec_operacion              ,
          ec_calle                  ,
          ec_numero                 ,
          ec_parroquia              ,
          ec_delegacion             ,
          ec_codigo_postal          ,
          ec_estado                 ,
          ec_fecha_inicio           ,
          ec_fecha_reporte          ,
          ec_dia_habil              ,
          ec_importes               ,
          ec_folio_fiscal           ,
          ec_certificado            ,
          ec_sello_digital          ,
          ec_sello_sat              ,
          ec_no_de_serie_certificado,
          ec_fecha_certificacion    ,--24
          ec_cadena_origial_sat     ,    
		    --ec_estado_op
		    ec_rfc_emisor              ,
	       ec_monto_factura     
   FROM   sb_estcta_cab_tmp       
   WHERE  ec_secuencial = @i_secuencial

   RETURN 0
end


if @i_operacion = 'I1' --Informacion Crédito
begin
   SELECT ic_limite_credito     ,
          ic_saldo_inicial      ,
          ic_interes_ordinario  ,
          ic_total_credito      ,
          ic_capital            ,
          ic_interes_par        ,
          ic_iva_interes        ,
          ic_total_parcial      ,
          ic_base_calculo       ,
          ic_saldo_final_cap    ,
          ic_estado             ,
          ic_fecha_inicio       ,
          ic_fecha_fin          ,
          ic_frecuencia_pago    ,
          ic_plazo              ,
          ic_dia_pago           ,
          ic_tasa_ordinaria     ,
          ic_tasa_mensual       ,
          ic_dep_garantias      ,
          ic_fec_dep_garantias  ,
          ic_cat                ,
          ic_comisiones         
   FROM sb_info_cre_tmp
   WHERE ic_secuencial = @i_secuencial

   RETURN 0         
END

if @i_operacion = 'M1' --Movimientos
begin

   SELECT 'secuecial'      = doa_sec,           
          'Fecha_Operacion'= convert(varchar(10),doa_fecha_ope,@i_formato),     
          'Fecha_Pactada'  = convert(varchar(10),doa_fecha_pac,@i_formato),    
          'Numero_Pago'    = doa_num_pago ,     
          'Dias_Atraso'    = doa_dias_atra ,    
          'Movimiento'     = doa_detalle_mov ,  
          'Total'          = doa_total  ,        
          'Capital'        = doa_cap    ,       
          'Interes_Ord'    = doa_inte_ord ,     
          'Comision'       = doa_gasto_cobranza,
          'Iva_Int'        = 0,
          'Iva_Con_Mora'   = 0,
          'Otros'          = 0,
          'Saldo_Capital'  = doa_saldo_cap  
   FROM sb_dato_operacion_abono_temp 
   WHERE  doa_banco = @i_banco
   AND doa_fecha    = @i_fecha
    
   RETURN 0
END

if @i_operacion = 'M2' --Movimientos
begin
     /*select @w_fecha_comision = max(dc_fecha_vto)
     from  cob_conta_super..sb_dato_cuota_pry
     where dc_fecha     = @i_fecha
     and   dc_banco     = @i_banco
     and   dc_estado    = @w_est_vencido
     */

   select @w_imp_comision =sum( isnull(dc_imo_pag,0))+sum(isnull(dc_iva_imo_pag,0)) --isnull(sum(dc_otros_pag),0)
   from   cob_conta_super..sb_dato_cuota_pry
   where  dc_fecha     = @i_fecha
   and    dc_banco     = @i_banco
   
   select @w_fecha_comision=max (doa_fecha_pag) 
   from   cob_conta_super..sb_dato_operacion_abono
   where  doa_fecha     = @i_fecha
   and    doa_banco     = @i_banco
   and    doa_otro      > 0
  
   
   select 'Sum_Capital'  = sum(mov_capital)       ,
          'Sum_interes'  = sum(mov_interes_ordina),
          'Sum_Iva'      = sum(mov_iva_int_pag),           
          'Sum_Pagos'    = sum(mov_total),            
          'Importe_Com'  = @w_imp_comision,
          'Tipo_Comision'= 'Gastos de cobranza',
          'Fecha_Cobro'  = convert(varchar(10),@w_fecha_comision,@i_formato)
   from   sb_movimientos_tmp
   WHERE  mov_secuencial = @i_secuencial
   and    mov_dividendo > 0

   RETURN 0
end

if @i_operacion = 'T1' --Tabla Amortizacion
begin
   select 'Numero'     = am_numero ,
           'Fecha'      = convert(varchar(10),am_fecha,@i_formato)  ,
           'Capital'    = am_capital,
           'Interes'    = am_interes_ordina,
           'Iva_Int'    = am_iva_int,
           'Comision'   = am_comision_cob,
           'Iva_Com'    = am_iva_comision,
           'Monto_Pago' = am_monto_pago,
           'Saldo'      = isnull(am_saldo_capital,0)
   from  sb_amortizacion_tmp
   WHERE am_secuencial = @i_secuencial
   order by am_numero
   RETURN 0
end 

--Tablas para llenar informacion de Credito Revolvente
/* MAPEAR LOS DATOS CARGADOS EN LA OPCION C */
if @i_operacion = 'C2' --Cabecera
begin
   SELECT ec_cod_sucursal           ,
          ec_sucursal               ,
          ec_producto               ,
          ec_nombre_cliente         ,
          ec_cod_grupo              ,
          ec_nom_grupo              ,
          ec_rfc                    ,
          ec_operacion              ,
          ec_calle                  ,
          ec_numero                 ,
          ec_parroquia              ,
          ec_delegacion             ,
          ec_codigo_postal          ,
          ec_estado                 ,
          ec_fecha_inicio           ,
          ec_fecha_reporte          ,
          ec_dia_habil              ,
          ec_importes               ,
          ec_folio_fiscal           ,
          ec_certificado            ,
          ec_sello_digital          ,
          ec_sello_sat              ,
          ec_no_de_serie_certificado,
          ec_fecha_certificacion    ,
          ec_estado_op              ,
          RTRIM(ec_cadena_origial_sat)     , 
          ec_rfc_emisor             ,
	      ec_monto_factura          
   FROM   cob_conta_super..sb_estcta_cab_tmp_lcr       
   WHERE  ec_secuencial = @i_secuencial
   and    ec_operacion      = @i_banco

   RETURN 0
end

if @i_operacion = 'I2' --Informacion Crédito Revolvente
begin
   select 
	      'fechaInicio'          = convert(varchar(10),ic_fecha_inicio,@i_formato),        
	      'fechaFin'             = convert(varchar(10), ic_fecha_fin,@i_formato ),          
	      'lineaCredito'         = ic_linea_credito       ,
	      'lineaDisponoble'      = ic_linea_disponible    ,
	      'capital '             = ic_capital             ,
	      'intOrd'               = ic_interes_ordinario   ,
	      'iva_int_ord'          = ic_iva_int_ortdinario  ,
	      'comisionGastos'       = ic_comision_gastos     ,
	      'ivaComisionGastos'    = ic_iva_comision_gastos ,
	      'total'                = ic_total               ,
	      'frecuenciaPago'       = ic_frecuencia_pago     ,
	      'plazo'                = ic_plazo               ,
	      'diaPago'              = ic_dia_pago            ,
	      'tasaOrdinaria'        = ic_tasa_ordinaria      ,
	      'tasaMensual'          = ic_tasa_mensual        ,
	      'baseCalcInt'          = ic_base_calc_int       ,
	      'Cat'                  = ic_cat                 ,
	      'Comisiones'           = ic_comisiones          
	from sb_info_cre_tmp_lcr
	WHERE ic_secuencial = @i_secuencial
	and   ic_banco      = @i_banco

   RETURN 0         
END

--Movimientos para Revolvente
if @i_operacion = 'M3' --Movimientos Revolvente
begin

   SELECT 'secuecial'                = doa_sec,           
          'Fecha_Operacion'          = isnull(doa_fecha_ope,''),     
          'Fecha_Pactada'            = isnull(doa_fecha_pac,''),       
          'Movimiento'               = doa_detalle_mov ,  
          'Capital'                  = doa_cap    ,
          'Interes_Ord'              = doa_inte_ord ,
          'Iva_Int'                  = doa_iva_int, 
          'Comision_Disposicion'     = doa_comision_dis,
          'Iva_Comision_Disposicion' = doa_iva_comision_dis,
          'Comision_Cobranza'        = doa_comision_cob,
          'Iva_Comision_Cobranza'    = doa_iva_comision_cob,
          'Total'                    = doa_total  ,
          'Saldo_Capital'            = doa_saldo_cap  
   FROM cob_conta_super..sb_dato_operacion_abono_temp_lcr 
   WHERE doa_secuencial = @i_secuencial
   and   doa_banco    = @i_banco
   and   doa_fecha    = @i_fecha
    
   RETURN 0
END

--Resumen Totales y COmisiones para Revolvente
if @i_operacion = 'R1' --Pagos
begin

   SELECT 'total_pagos'        = rt_total_pagos ,          
          'capital'            = rt_capital  ,             
          'int_ord'            = rt_int_Ord  ,             
          'iva_int_ord'        = rt_iva_Int_Ord ,          
          'gastos_cob'         = rt_gastos_cobranza ,      
          'iva_gatos_cob'      = rt_iva_gastos_cobranza ,  
          'num_dispo'          = rt_num_disposiciones ,    
          'imp_dispo'          = rt_importe_disposiciones ,
          'impo_total_com'     = rt_importe_total_com ,    
          'fecha_cob_ult_com'  = convert(varchar(10),rt_fecha_cobro_cobranza,@i_formato)  , 
          'imp_to_dispo'       = rt_importe_total_dispos , 
          'fecha_disp_ult_com' = convert(varchar(10),rt_fecha_cobro_dispos,@i_formato)       
   FROM cob_conta_super..sb_resumen_pagos_tmp_lcr 
   where rt_secuencial=@i_secuencial
   and   rt_banco     =@i_banco
    
   RETURN 0
END

--Cargos Objetados para Revolvente
if @i_operacion = 'N1' 
begin

    select  
           'fecha'      =  convert(varchar(10),doa_fecha_pag,@i_formato),
           'Movimiento' = 'Pago en Revisión', 
           'Importe'    = doa_total,
           'NumFolio'   = doa_sec_rpa
          
            
    from sb_dato_operacion_abono
    where doa_fecha=@i_fecha
    and doa_banco = @i_banco
    and doa_objetado in ('S')
    group by doa_fecha_pag,doa_sec_rpa,doa_total
    order by doa_fecha_pag,doa_sec_rpa,doa_total
    
    
   RETURN 0
END


if @i_operacion = 'O' begin 


   select 
   doa_fecha_pag = doa_fecha_pag, 
   doa_total     = doa_total,
   doa_sec_rpa   = doa_sec_rpa,
   doa_dividendo = max(doa_dividendo) 
   into #sb_dato_operacion_abono
   from sb_dato_operacion_abono
   where doa_fpago = @w_fpago_objetado
   and doa_fecha = @i_fecha
   and doa_banco = @i_banco
   and doa_aplicativo = 7
   group by doa_fecha_pag,doa_total,doa_sec_rpa

   select 
   'fecha'      = convert(varchar(10),doa_fecha_pag,103),
   'Movimiento' = 'Pago en Revisión', 
   'Importe'    = doa_total,
   'NumFolio'   = doa_sec_rpa
   from #sb_dato_operacion_abono
 
   RETURN 0


end 


return 0

go