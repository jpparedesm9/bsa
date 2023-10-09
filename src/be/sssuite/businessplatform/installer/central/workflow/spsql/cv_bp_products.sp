use cob_workflow
go
if exists (select * from sysobjects where name = 'sp_bp_products')
begin
  drop proc sp_bp_products
end
go

create proc sp_bp_products
/*******************************************************************/
/*   ARCHIVO:         bp_products.sp                               */
/*   NOMBRE LOGICO:   sp_bp_products                               */
/*   PRODUCTO:        REE                                          */
/*******************************************************************/
/*                       IMPORTANTE                                */
/*   Esta aplicacion es parte de los  paquetes bancarios           */
/*   propiedad de MACOSA S.A.                                      */
/*   Su uso no autorizado queda  expresamente  prohibido           */
/*   asi como cualquier alteracion o agregado hecho  por           */
/*   alguno de sus usuarios sin el debido consentimiento           */
/*   por escrito de MACOSA.                                        */
/*   Este programa esta protegido por la ley de derechos           */
/*   de autor y por las convenciones  internacionales de           */
/*   propiedad intelectual.  Su uso  no  autorizado dara           */
/*   derecho a MACOSA para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los           */
/*   autores de cualquier infraccion.                              */

/*******************************************************************/
/*                        PROPOSITO                                */
/*  Realiza la consulta de todos los productos cobis de un cliente */
/*                                                                 */
/*******************************************************************/
/*                       MODIFICACIONES                            */
/*   FECHA        AUTOR              RAZON                         */
/*   05/Ene/2011  Ma. Villavicencio  Emision Inicial               */
/*******************************************************************/
(
	@i_operacion	char(1),	
	@i_cliente	    int,
	@i_grupo        int         = null,
	@s_user		    login		= null,
 	@s_ssn      	int 		= null,
	@s_sesn    	    int		    = null,
  	@s_date 	    datetime	= null,
	@i_vista_360	char(1)		= null,
	@i_act_can      char(1)     = 'N',
	@i_formato_fecha int = 111
)

as
begin
   declare
	@w_return 	int,	
	@w_sp_name	varchar(32),	
	@w_spid     smallint,  --OGU 23/05/2014
	@w_realization_value     float  --MCA 05/01/2016
	
	select @w_spid = @@spid	--OGU 23/05/2014
	select @w_sp_name = 'sp_bp_products'  

-- set string_rtruncation off
select @w_realization_value = pa_float from cobis..cl_parametro 
where pa_nemonico = 'PVARE'

if (@i_operacion = 'I')
begin

--Retorno el identificador con el cual se han creado los registros  	   
    select 'SPID' = @w_spid, 'SESN' = @s_sesn  


/*LLENADO DE TABLAS TEMPORALES PARA LAS CONSULTAS*/

exec @w_return       = cob_credito..sp_riesgos_asb
	@t_trn           = 21084,
	@s_user   	     = @s_user,
	@s_ssn    	     = @s_ssn,
	@s_sesn   	     = @s_sesn,
	@s_date       	 = @s_date,
	@i_operacion 	 = 'I',
	@i_cliente    	 = @i_cliente,
	@i_grupo         = @i_grupo,
	--@i_tipo_cliente  = 'C',
	@i_consulta      = 'T',
	@i_carga         = 'T',
	@i_limite        = 'S',
	@i_aprobado      = 'N',
	@i_tramite       = 0,
	@i_tipo_deuda    = 'T',
	@i_formato_fecha = @i_formato_fecha,
	@i_bandera       = 'N',
	@i_vista_360     = 'S',
	@i_act_can       = @i_act_can
	
    if @w_return != 0
	begin
	  print 'LLENADO DE TABLAS TEMPORALES'
	  return @w_return
	end

	--print 'ssn %1! ', 	@s_ssn  
	--print 'sesn %1! ', 	@s_sesn  
	
	/*GARANTIAS OGU 23/05/2014 */
 
	insert into cob_credito..cr_gar_tmp
	  (spid,     CLIENTE,     TIPO_GAR,     DESC_GAR,     CODIGO,     MONEDA,     VALOR_INI,
	   VALOR_ACT,     VALOR_ACT_ML,     PORCENTAJE,     MRC,     ESTADO,     PLAZO_FIJO,
	   TIPO_CTA,     FIADOR,     ID_FIADOR,     CUSTODIA,     nombre_cliente , fechaCancelacion,	fechaActivacion, VALOR_REALIZACION )
	  select  @w_spid, 
			  sc_cliente,  a.sg_tipo_gar,  
			  a.sg_desc_gar,   a.sg_codigo,
			  (select mo_nemonico
			  from cobis..cl_moneda
			  where mo_moneda = a.sg_moneda),
			  a.sg_valor_ini,   a.sg_valor_act,   a.sg_valor_act_ml,
			  a.sg_porc_mrc,    a.sg_valor_mrc,
			  a.sg_estado,      a.sg_pfijo,       
			  (case a.sg_tramite_gar when null then ' ' 
							  when 14 then (select td_descripcion from cob_pfijo..pf_operacion, cob_pfijo..pf_tipo_deposito where op_toperacion = td_mnemonico and op_num_banco = a.sg_pfijo )
							  when 4  then (select pb_descripcion from cob_ahorros..ah_cuenta, cob_remesas..pe_pro_bancario where ah_prod_banc = pb_pro_bancario and ah_cta_banco = a.sg_pfijo) 
							  when 3  then (select pb_descripcion from cob_cuentas..cc_ctacte, cob_remesas..pe_pro_bancario where cc_prod_banc = pb_pro_bancario and cc_cta_banco = a.sg_pfijo) 
							  else ' '
			  end ),
			  isnull( a.sg_fiador, ' '),isnull( a.sg_id_fiador, ' '), sg_custodia,sc_nombre_cliente,
			  a.sg_fechaCancelacion,
			  a.sg_fechaActivacion,
			  /*Si no se encuentra el valor parametrizado se colocará por defecto el 85%*/
			  (a.sg_valor_act * isnull(@w_realization_value,85))/100
	  from cob_credito..cr_situacion_cliente,
		   cob_credito..cr_situacion_gar a
	  where sc_cliente   = a.sg_cliente
	  and   sc_usuario   = @s_user
	  and   sc_secuencia = @s_sesn
	  and   sc_tramite   = 0
	  and   sc_usuario   = a.sg_usuario
	  and   sc_secuencia = a.sg_secuencia
	  and   sc_tramite   = a.sg_tramite
	  order by sc_cliente, a.sg_tipo_gar
	
	/*POLIZAS OGU 23/05/2014 */
	
	  insert into cob_credito..cr_poliza_tmp
	  (spid,        CLIENTE,     POLIZA,     TRAMITE,     COMENTARIO,
	   ASEGURADORA, ESTADO,      TIPO_POLIZA,FECHA_VEN,   ANUALIDAD,     
	   VAL_ENDOSO,  VAL_ENDOSO_ML,GARANTIA,  AVALUO,      SEC_POL,         
	   nombre_cliente, fecha_cancelacion, fecha_activacion) 
	  select distinct 
			 @w_spid, 
			 sp_cliente,    sp_poliza,
			 sp_tramite_d,   
			 sp_comentario, sp_aseguradora,
			 sp_estado,    sp_desc_pol,  sp_fecha_ven,
			 sp_anualidad,  sp_endoso,      sp_endoso_ml, sp_codigo,
			 case sp_avaluo
			   when 'S' then
				  'SI'
			   when 'N' then
				  'NO'
			 end,
			 sp_sec_poliza,
			 sc_nombre_cliente,
			 sp_fechaCancelacion,
			 sp_fechaActivacion
	   from  cob_credito..cr_situacion_poliza, 
			 cob_credito..cr_situacion_cliente
	  where  sp_tramite   = 0
		and  sp_usuario   = @s_user
		and  sp_secuencia = @s_sesn
		and  sc_usuario   = @s_user
		and  sc_secuencia = @s_sesn
		and  sc_tramite   = 0
	  order  by sp_sec_poliza, sp_tramite_d

	/*PAGARES OGU 23/05/2014 */
   
	insert into cob_credito..cr_gar_p_tmp 
	(spid,     CLIENTE,     TIPO_GAR,     DESC_GAR,     CODIGO,     MONEDA,     VALOR_INI,
	VALOR_ACT,     VALOR_ACT_ML,     PORCENTAJE,     MRC,     ESTADO,     PLAZO_FIJO,
	TIPO_CTA,     FIADOR,     ID_FIADOR,     nombre_cliente ,  fechaCancelacion , fechaActivacion  )
	select  @w_spid, 
		  sc_cliente,         a.sg_p_tipo_gar,
		  a.sg_p_desc_gar,    a.sg_p_codigo,
		  (select mo_nemonico
		   from cobis..cl_moneda
		   where mo_moneda = a.sg_p_moneda),
		  a.sg_p_valor_ini,
		  a.sg_p_valor_act,   a.sg_p_valor_act_ml,
		  a.sg_p_porc_mrc,    a.sg_p_valor_mrc,
		  a.sg_p_estado,   
		  a.sg_p_fijo,        
		  (case a.sg_p_tramite_gar when null then ' ' 
				  when 14 then (select td_descripcion from cob_pfijo..pf_operacion, cob_pfijo..pf_tipo_deposito where op_toperacion = td_mnemonico and op_num_banco = a.sg_p_fijo )
				  when 4  then (select pb_descripcion from cob_ahorros..ah_cuenta, cob_remesas..pe_pro_bancario where ah_prod_banc = pb_pro_bancario and ah_cta_banco = a.sg_p_fijo) 
				  when 3  then (select pb_descripcion from cob_cuentas..cc_ctacte, cob_remesas..pe_pro_bancario where cc_prod_banc = pb_pro_bancario and cc_cta_banco = a.sg_p_fijo) 
				  else ' '
		   end ),
		  a.sg_p_fiador,		
		  a.sg_p_id_fiador, sc_nombre_cliente,
		  a.sg_fechaCancelacion,
		  a.sg_fechaActivacion
	from cob_credito..cr_situacion_cliente,
		 cob_credito..cr_situacion_gar_p a
	where  sc_cliente     = a.sg_p_cliente   
	and    sc_usuario     = @s_user
	and    sc_secuencia   = @s_sesn
	and    sc_tramite     = 0
	and    sc_usuario     = a.sg_p_usuario
	and    sc_secuencia   = a.sg_p_secuencia
	and    sc_tramite     = a.sg_p_tramite
	order by sc_cliente, a.sg_p_tipo_gar
	
	
	/*CARTERA Y CARTERA INDIRECTA OGU 23/05/2014*/
  
	 insert into cob_credito..cr_deud1_tmp
		 (spid,cliente,              producto,
		  tipo_operacion,            desc_tipo_op,
		  tramite,                   operacion,
		  linea,
		  estado_conta,              estado,
		  tasa,
		  fecha_apt,
		  fecha_vto,
		  desc_moneda,
		  monto_orig,
		  saldo_vencido,
		  saldo_cuota,  	
		  subtotal,		
		  saldo_capital,	
		  saldo_total,
		  saldo_ml,
		  refinanciamiento,
		  prox_fecha_pag_int,
		  ult_fecha_pg,
		  clasificacion,
		  tipocar, valorcontrato, rol, nombre_cliente, tipo_deuda,
		  restructuracion,
		  fecha_cancelacion,
		  refinanciado,
		  calificacion,
		  tipo_plazo,
		  plazo,
		  motivo_credito, dias_atraso)		
	 select   @w_spid, sd_cliente,       a.sd_producto,
			  a.sd_tipo_op,              a.sd_desc_tipo_op, 
			  a.sd_tramite_d,            a.sd_numero_operacion,
			  a.sd_tarjeta_visa,		
			  a.sd_estado,		     a.sd_beneficiario,	
			  str( a.sd_tasa, 12, 4),
			  convert(char(10),a.sd_fecha_apr,@i_formato_fecha),
			  convert(char(10),a.sd_fecha_vct,@i_formato_fecha),
			  (select mo_nemonico
			   from cobis..cl_moneda
			   where mo_moneda = a.sd_moneda),
			  isnull(a.sd_monto_orig,0),
			  isnull(a.sd_saldo_vencido,0),
			  isnull(a.sd_saldo_promedio,0), --Saldo
			  isnull(a.sd_saldo_vencido, 0) + isnull( a.sd_saldo_promedio, 0),
			  isnull(a.sd_total_cargos,0),
			  isnull(a.sd_contrato_act,0), --saldo total --a.sd_saldo_x_vencer,
			  isnull(a.sd_monto_ml,0),
			  a.sd_subtipo, 		
			  convert(char(10),a.sd_prox_pag_int,@i_formato_fecha),
			  convert(char(10),a.sd_ult_fecha_pg,@i_formato_fecha),
			  a.sd_calificacion,
			  a.sd_tipoop_car, a.sd_monto_riesgo,a.sd_rol, sc_nombre_cliente, a.sd_tipo_deuda,
			  sd_restructuracion,
			  sd_fecha_cancelacion,
			  sd_refinanciamiento,
			  sd_calificacion,
			  sd_tipo_plazo,
			  sd_plazo,
			  sd_motivo_credito,
			  isnull(sd_dias_atraso,0)
	 from cob_credito..cr_situacion_cliente,
		  cob_credito..cr_situacion_deudas a
	 where sc_cliente     = a.sd_cliente 
	 and   a.sd_producto  = 'CCA'
	 and   sc_usuario     = @s_user
	 and   sc_secuencia   = @s_sesn
	 and   sc_tramite     = 0
	 and   sc_usuario     = a.sd_usuario
	 and   sc_secuencia   = a.sd_secuencia
	 and   sc_tramite   = a.sd_tramite
	 and   a.sd_tipo_deuda in ('D', 'I')
	 order by sc_cliente, a.sd_categoria, a.sd_producto

		/*		    
				 insert into cob_credito..cr_deud1_tmp   
					 (spid,cliente,              producto,   
					  tipo_operacion,            desc_tipo_op,   
					  tramite,                   operacion,   
					  linea,   
					  estado_conta,              estado,   
					  desc_moneda,   
					  clasificacion,   
					  tipocar, valorcontrato, rol, nombre_cliente, tipo_deuda, cod_estado)		   
				 select   @w_spid, sc_cliente,       a.tr_producto,   
						  a.tr_toperacion,              '',    
						  a.tr_tramite,            a.tr_numero_op_banco,   
						  '',		   
						  a.tr_estado,		     a.tr_estado,	   
						  (select mo_nemonico   
						   from cobis..cl_moneda   
						   where mo_moneda = a.tr_moneda),   
						  '',   
						  a.tr_toperacion, 0,sc_rol, sc_nombre_cliente, '', '0'  
				 from cob_credito..cr_situacion_cliente,   
					  cob_credito..cr_tramite a,   
					  cob_workflow..wf_inst_proceso   
				 where a.tr_producto  = 'CCA'   
				 and   a.tr_estado = 'N'   
				 and   io_estado = 'EJE'   
				 and   io_campo_3 = tr_tramite   
				 and   io_campo_1 = sc_cliente   
				 and   sc_usuario     = @s_user   
				 and   sc_secuencia   = @s_sesn   
				 and   sc_tramite     = 0  
				 and   a.tr_tramite not in (select sd_tramite from cob_credito..cr_situacion_deudas where sd_usuario = @s_user and sd_secuencia   = @s_sesn)   
				 order by tr_cliente, a.tr_producto   
				
			   
	 --IOR actualizar el codigo de estado de las operaciones
	 UPDATE cob_credito..cr_deud1_tmp 
	 SET cod_estado = convert(varchar(10),es_codigo)
	 FROM cob_cartera..ca_estado
	 WHERE estado_conta = es_descripcion
	 AND producto = 'CCA'
	 AND spid     = @w_spid 

	 UPDATE cob_credito..cr_deud1_tmp
	 SET cod_estado = CAT.codigo
	 FROM cob_credito..cr_deud1_tmp DEU, cobis..cl_tabla TAB, cobis..cl_catalogo CAT
	 WHERE DEU.estado_conta = CAT.valor
	 AND TAB.tabla = 'ce_etapa'
	 AND TAB.codigo = CAT.tabla 
	 AND producto = 'CEX'
	 AND spid     = @w_spid 	
	 
	    
	   

	 -- Inicio - Se obtiene datos de para el código alterno e instancia de proceso de las solicitudes en curso
	UPDATE cob_credito..cr_deud1_tmp
	SET id_inst_act    = p.io_id_inst_proc,
	    codigo_alterno = p.io_codigo_alterno 
	FROM cob_credito..cr_deud1_tmp DEU,cob_workflow..wf_inst_proceso p
	WHERE DEU.tramite =  p.io_campo_3*/


RETURN 0
	UPDATE cob_credito..cr_deud1_tmp
	set etapa_act = (select ia_nombre_act 
							from cob_workflow..wf_inst_actividad a
							where a.ia_id_inst_act = DEU.id_inst_act --
							-- HAVING a.ia_id_inst_act = a.ia_id_inst_act )
							)
	FROM cob_credito..cr_deud1_tmp DEU
	-- Fin
	 
	return 0
	end
else
	begin

/*1 CUENTAS CORRIENTES*/

	exec 	@w_return 	= cob_credito..sp_riesgos_asb
		@t_trn    	= 73004,
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c       = 'I',
		@i_modo         = 1,
		@i_formato_fecha= @i_formato_fecha,
		@i_vista_360     = @i_vista_360

	 if @w_return != 0
	 begin
		print 'C CORRIENTES'
	  return @w_return
	 end

/*2 CUENTAS DE AHORRO*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn             = 73004,
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c          = 'I',
		@i_modo            = 9,
		@i_formato_fecha   = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

		
	if @w_return != 0
	 begin
	 print 'C AHORRO'
	  return @w_return
	end
  

/*3 PLAZOS FIJO*/
	exec 	@w_return  = cob_credito..sp_riesgos_asb
		@t_trn             = 73004,
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c          = 'I',
		@i_modo            = 2,
		@i_formato_fecha   = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

	 

	if @w_return != 0
	  begin
	 print 'PLAZO FIJO'
	  return @w_return
	end

/*4 SOBREGIROS*/
	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	=  @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'D',
		@i_modo          = 4,
		@i_formato_fecha = @i_formato_fecha,
		@i_tipo_deuda    = 'D',
		@i_vista_360     = @i_vista_360

	if @w_return != 0
	 begin
	 print 'SOBREGIROS'
	  return @w_return
	end


/*5 GARANTIAS*/

	exec @w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'G',
		@i_formato_fecha = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

		
	if @w_return != 0
	begin
	 print 'GARANTIAS'
	  return @w_return
	end


/*6 LINEAS DE CREDITO*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'L',
		@i_formato_fecha = @i_formato_fecha,
		@i_tipo_deuda    = 'D',
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'PRESTAMOS'
	   return @w_return
	end

/*7 CEX*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn     	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'D',
		@i_modo          = 2,
		@i_cabecera      = 'S',
		@i_formato_fecha = @i_formato_fecha,
		@i_tipo_deuda    = 'T',
	@i_vista_360     = @i_vista_360


	if @w_return != 0 
	begin
		print 'CEX'
	   return @w_return
	end


/*8 POLIZAS*/
	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'P',
		@i_formato_fecha = @i_formato_fecha,
		@i_vista_360     = @i_vista_360


	if @w_return != 0 
	begin
		print 'POLIZAS'
	   return @w_return
	end
  
/*9 TARJETA DE DEBITO*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'I',
		@i_modo          = 4,
		@i_formato_fecha = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'TARJETA DE DEBITO'
	   return @w_return
	end


/* 10 OTROS CONTINGENTES*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'D',
		@i_modo          = 6,
		@i_formato_fecha = @i_formato_fecha,
		@i_tipo_deuda    = 'D',
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'OTROS CONTINGENTES'
	   return @w_return
	end


/*11 PAGARES*/
	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'GP',
		@i_formato_fecha = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'PAGARES'
	   return @w_return
	end

/*12 GLOBALNET*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn    	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'A',
		@i_formato_fecha = @i_formato_fecha,
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'GLOBALNET'
	   return @w_return
	 
	end



/*13 CARTERA*/
	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,	
		@s_user   	= @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion 	= @i_operacion,
		@i_cliente    	= @i_cliente,
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'D',
		@i_modo          = 1,
		@i_formato_fecha = @i_formato_fecha,
		@i_cabecera      = 'S',
		@i_tipo_deuda    = 'D',
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'CARTERA'
	   return @w_return
	end


	 
/*14 CARTERA INDIRECTAS*/

	exec 	@w_return = cob_credito..sp_riesgos_asb
		@t_trn           = 73004,
		@s_user          = @s_user,
		@s_ssn    	= @s_ssn,
		@s_sesn   	= @s_sesn,
		@s_date   	= @s_date,
		@i_operacion     = 'S',
		@i_cliente       = @i_cliente, 
		@i_grupo		 = @i_grupo,
		@i_modo_c        = 'D',
		@i_modo          = 1,
		@i_cabecera      = 'S',
		@i_formato_fecha = @i_formato_fecha,
		@i_tipo_deuda    = 'I',	
		@i_vista_360     = @i_vista_360

	if @w_return != 0 
	begin
		print 'CARTERA INDIRECTAS'
	   return @w_return
	end

end
return 0
end
go

