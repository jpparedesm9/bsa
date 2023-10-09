/************************************************************************/
/*   Archivo:                sp_tramite_busin.sp                        */
/*   Stored procedure:       sp_tramite_busin                           */
/*   Base de datos:          cob_pac                                    */
/*   Producto:               Credito                                    */
/*   Disenado por:           Adriana Chiluisa                           */
/*   Fecha de escritura:     08/Jun./2017                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Consulta de los datos de una operacion                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA               AUTOR               CAMBIO                     */
/*   JUN-08-2017        Adriana Chiluisa   Version tomada del ambiente  */
/*                                         de pruebas Santander         */
/************************************************************************/

use cob_pac
go

if exists (select 1 from sysobjects where name = 'sp_tramite_busin')
   drop proc sp_tramite_busin
go

create proc sp_tramite_busin (

@s_ssn		 	int = null,
@s_user		 	login = null,
@s_sesn		 	int = null,
@s_term		 	varchar(30) = null,
@s_date		 	datetime = null,
@s_srv		 	varchar(30) = null,
@s_lsrv		 	varchar(30) = null,
@s_rol		 	smallint = NULL,
@s_ofi		 	smallint = NULL,
@s_org_err		char(1) = NULL,
@s_error		int = NULL,
@s_sev		 	tinyint = NULL,
@s_msg		 	descripcion = NULL,
@s_org		 	char(1) = NULL,
@t_rty                	char(1)  = null,
@t_trn                	int = null,
@t_debug              	char(1)  = 'N',
@t_file               	varchar(14) = null,
@t_from               	varchar(30) = null,
@i_operacion		char(1) = null,
@i_tramite            	int  = null,
@i_tipo		 	char(1) = null,
@i_truta		tinyint = 88,
@i_oficina_tr	 	smallint = null,
@i_usuario_tr	 	login = null,
@i_fecha_crea 	 	datetime = null, 
@i_oficial		smallint = null,
@i_sector		catalogo = null,
@i_ciudad		smallint = null,
@i_estado		char(1) = null,
@i_nivel_ap		tinyint = null,
@i_fecha_apr		datetime = null,
@i_usuario_apr	 	login = null,
@i_numero_op_banco    	cuenta  = null,
/* campos para tramites de garantias */
@i_proposito		catalogo = null, 
@i_razon		catalogo = null,
@i_txt_razon		varchar(255) = null,
@i_efecto	  	catalogo = null,
/* campos para lineas de credito */
@i_cliente            	int = null,
@i_grupo              	int = null,
@i_fecha_inicio       	datetime = null,
@i_num_dias           	smallint = 0,
@i_per_revision       	catalogo = null,
@i_condicion_especial 	varchar(255) = null,
@i_rotativa		char(1) = null,
/* operaciones originales y renovaciones */
@i_linea_credito	cuenta = null,	  
@i_toperacion	 	catalogo = null,
@i_producto           	catalogo = null,
@i_monto              	money = 0,
@i_moneda             	tinyint = 0,
@i_periodo            	catalogo = null,
@i_num_periodos       	smallint = 0,
@i_destino            	catalogo = null,
@i_ciudad_destino     	smallint = null,
@i_parroquia            catalogo = null,   -- ITO:12/12/2011
@i_cuenta_corriente   	cuenta = null,
@i_garantia_limpia    	char = null,
-- solo para prestamos de cartera
@i_monto_desembolso	money = null,
@i_reajustable		char(1) = null, -- OGU Valores por defecto
@i_per_reajuste		tinyint = null,
@i_reajuste_especial	char(1) = null,
@i_fecha_reajuste	datetime = null,
@i_cuota_completa	char(1) = null, -- OGU Valores por defecto
@i_tipo_cobro		char(1) = null, -- OGU Valores por defecto
@i_tipo_reduccion	char(1) = null, -- OGU Valores por defecto
@i_aceptar_anticipos	char(1) = null, -- OGU Valores por defecto
@i_precancelacion	char(1) = null, -- OGU Valores por defecto
@i_tipo_aplicacion	char(1) = null, -- OGU Valores por defecto
@i_renovable		char(1) = null,
@i_fpago		catalogo = null,
@i_cuenta		cuenta = null,
-- generales
@i_renovacion		smallint = null,
@i_cliente_cca		int = null,
@i_es_acta		char(1)= null,
@i_op_renovada		cuenta = null,
@i_deudor		int = null,
   -- Etapa Rechazo CPN
	
@i_tipo_cartera    catalogo    = null,   
@i_destino_descripcion descripcion   =null,   
@i_patrimonio         money=null,         --JMA, 02-Marzo-2015
@i_ventas               money=null,         --JMA, 02-Marzo-2015
@i_num_personal_ocupado    int=null,      --JMA, 02-Marzo-2015
@i_tipo_credito catalogo =  null,
@i_indice_tamano_actividad float=null,    --JMA, 02-Marzo-2015
@i_objeto catalogo = null,                --JMA, 02-Marzo-2015
@i_actividad catalogo = null,             --JMA, 02-Marzo-2015
@i_descripcion_oficial descripcion= null, --JMA, 02-Marzo-2015 
@i_ventas_anuales         money         = null,    --NMA, 10-Abril-2015
@i_activos_productivos money         = null,     --NMA, 10-Abril-2015   
@i_level_indebtedness    char(1)  =null,   --DCA
@i_asigna_fecha_cic      char(1)  =null,
@i_convenio                 char(1)      = null,
@i_codigo_cliente_empresa  varchar(10)          = null,
@i_reprogramingObserv  varchar(255)          = null,
@i_motivo_uno  varchar(255)          = null, 
@i_motivo_dos  varchar(255)          = null, 
@i_motivo_rechazo    catalogo  =null,
@i_tamanio_empresa      varchar(5)   = null,
@i_producto_fie         catalogo     = null,
@i_num_viviendas        tinyint      = null,
@i_calificacion         catalogo     = null,
@i_es_garantia_destino  char(1)      = null,
-- reestructuraciones
@i_op_reestructurar	cuenta = null,
@i_cuenta_certificado	cuenta = null,
@i_alicuota		catalogo = null,
@i_alicuota_aho         catalogo = null,
@i_doble_alicuota	char(1) = null,
@i_actividad_destino    catalogo=null,       --SPO Actividad economica de destino
@i_compania             int=null,            --SPO Codigo compania-grupo
@i_tipo_cca             catalogo = null,     --SPO Clase de cartera del credito
@i_vinculado            char(1)  = 'N',    
@i_causal_vinculacion   catalogo = null,
@i_verificador          catalogo = null,
@i_seg_cre		catalogo=null, --SRA SEGMENTO CREDITO 17/09/2007
@i_activa_TirTea        char(1)  = 'S',
@i_ssn                 int = null,  --AC SSN PARA ALMACENAR LOS DEUDORES
@i_toperacion_ori	   catalogo = null, --Policia Nacional: Se incrementa por tema de interceptor   
@i_tplazo              catalogo     = null,   --Parámetro para crear la operación con el plazo ingresado desde la Originación
@i_plazo               smallint     = null,	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
@i_pplazo              smallint = null,
@i_frec_pago           catalogo = null,
@i_dest_hipot          varchar(10)= '0',
@i_dest_consumo        varchar(10)= '0',
@o_tramite             int	 = null out  -- MNU 2010.11.29 - Retorno numero tramite
)
as

declare
@w_today		datetime,     /* fecha del dia */ 
@w_return		int,          /* valor que retorna */
@w_sp_name		varchar(32),  /* nombre stored proc*/
@w_existe		tinyint,      /* existe el registro*/
@w_tramite		int,
@w_truta		tinyint ,
@w_tipo			char(1) ,
@w_oficina_tr		smallint,
@w_usuario_tr		login ,
@w_fecha_crea		datetime ,
@w_oficial		smallint ,
@w_sector		catalogo ,
@w_ciudad		smallint ,
@w_estado		char(1) ,
@w_nivel_ap		tinyint ,
@w_fecha_apr		datetime ,
@w_usuario_apr		login ,
@w_secuencia		smallint ,
@w_numero_op		int,
@w_numero_op_banco	cuenta,
@w_aprob_por		login,
@w_nivel_por		tinyint,
@w_comite		catalogo,
@w_acta			cuenta,
@w_proposito		catalogo ,   /* garantias */
@w_razon		catalogo ,
@w_txt_razon		varchar(255),
@w_efecto		catalogo,
@w_cliente		int ,       /* lineas de credito */		
@w_grupo		int ,
@w_fecha_inicio		datetime ,
@w_num_dias		smallint ,
@w_per_revision		catalogo ,
@w_condicion_especial	varchar(255),
@w_linea_credito	int ,	/* renovaciones y operaciones */
@w_toperacion		catalogo ,
@w_producto		catalogo ,
@w_monto		money ,
@w_moneda		tinyint,
@w_periodo		catalogo,
@w_num_periodos		smallint,
@w_destino		catalogo,
@w_ciudad_destino	smallint,
@w_cuenta_corriente	cuenta ,
@w_garantia_limpia	char(1) ,
@w_renovacion		smallint,
@w_fecha_concesion	datetime,
/* variables de trabajo */
@w_cont			int,
@w_numero_aux		int,
@w_linea		int,
@w_numero_linea		int,
@w_numero_operacion	int,
@w_prioridad		tinyint,
--@o_tramite		int,
@o_linea_credito	cuenta,
@o_numero_op		cuenta,

/* variables para ingreso en cr_ruta_tramite */
@w_estacion		smallint,
@w_etapa		tinyint,
@w_login		login,
@w_doble_alicuota	char(1),
@w_paso		 	tinyint,
@w_verificador	 	catalogo,
@w_seg_cre              catalogo,
@w_alicuota             catalogo, 
@w_alicuota_aho         catalogo,
@w_fecha_patrimonio 	datetime, --eorbea validación del patrimonio técnico de un cliente se encuentre actualizado.
@w_parametro_patri	char(1),   --eorbea parametro que permite realizar la validación del patrimonio
@w_miembros int

select @w_today  = @s_date,
       @w_sp_name = 'sp_tramite_busin',
       @i_activa_TirTea = isnull(@i_activa_TirTea, 'S') -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE}
       --@i_tramite = 3862210

    
select @w_parametro_patri = pa_char 
from cobis..cl_parametro
where pa_nemonico = 'DBPA'

select @w_fecha_patrimonio = '          ' --  JTA isnull(en_fecha_patrimonio, '          ')
from cobis..cl_ente
where en_ente = @i_cliente_cca

	if @w_fecha_patrimonio < @w_today
	begin
		if @w_parametro_patri = 'S'
		begin
		 exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file, 
		   @t_from  = @w_sp_name,
		   @i_num   = 2107014
	   	return 1 
	   	end

	   	if @w_parametro_patri = 'N' and @i_activa_TirTea = 'S'
		begin
		print 'El patrimonio técnico del cliente se encuentra desactualizado...'
		--return 0 EAndrade 25/Mar/2011
		end	
	end

if (@t_trn <> 21020 and @i_operacion = 'I') or
(@t_trn <> 21120 and @i_operacion = 'U') or
(@t_trn <> 21220 and @i_operacion = 'D') or
(@t_trn not in (21520,73932) and @i_operacion = 'Q')
begin

   /* tipo de transaccion no corresponde */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2101006
   return 1 
end

if @i_operacion <> 'Q' 
begin
 /* Chequeo de Existencias */
 /**************************/
 SELECT
    @w_tramite = tr_tramite,            
	 @w_truta = tr_truta,
	 @w_tipo = tr_tipo, 
	 @w_oficina_tr = tr_oficina,
	 @w_usuario_tr = tr_usuario,
	 @w_fecha_crea = tr_fecha_crea,
	 @w_oficial = tr_oficial,
	 @w_sector = tr_sector,
	 @w_ciudad = tr_ciudad,
	 @w_estado = tr_estado, 
	 @w_nivel_ap = tr_nivel_ap ,
	 @w_fecha_apr = tr_fecha_apr,
	 @w_usuario_apr	= tr_usuario_apr ,
	 @w_numero_op = tr_numero_op,
     @w_numero_op_banco = tr_numero_op_banco,
	 @w_aprob_por = tr_aprob_por,
	 @w_nivel_por = tr_nivel_por,
	 @w_comite    = tr_comite,
	 @w_acta      = tr_acta,
	 /* garantias*/
	 @w_proposito = tr_proposito, 
	 @w_razon = tr_razon,
	 @w_txt_razon = rtrim(tr_txt_razon),
	 @w_efecto = tr_efecto,
	 /*lineas*/
	 @w_cliente = tr_cliente, 
	 @w_grupo = tr_grupo,
	 @w_fecha_inicio = tr_fecha_inicio,
	 @w_num_dias = tr_num_dias,
	 @w_per_revision = tr_per_revision,
	 @w_condicion_especial = tr_condicion_especial,
	 /*renov. y operaciones*/
	 @w_linea_credito = tr_linea_credito,  
	 @w_toperacion = tr_toperacion,
	 @w_producto = tr_producto,
	 @w_monto = tr_monto,
	 @w_moneda = tr_moneda,
	 @w_periodo = tr_periodo,
	 @w_num_periodos = tr_num_periodos,
	 @w_destino = tr_destino,
	 @w_ciudad_destino = tr_ciudad_destino,
	 @w_cuenta_corriente = tr_cuenta_corriente,
	 @w_garantia_limpia = NULL, -- JTA tr_garantia_limpia,
     @w_doble_alicuota = NULL, -- JTA tr_doble_alicuota, --DMO 5/11/1999
	 @w_renovacion = tr_renovacion,
     @w_verificador = NULL, -- JTA  tr_verificador,
     @w_seg_cre = NULL, -- JTA  tr_seg_cre,
     @w_alicuota  = NULL, -- JTA  tr_alicuota, 
     @w_alicuota_aho = NULL -- JTA  tr_alicuota_aho

 FROM cob_credito..cr_tramite
 WHERE tr_tramite = @i_tramite 

 if @@rowcount > 0
  select @w_existe = 1
 else
  select @w_existe = 0

select @w_secuencia = rt_secuencia,
       @w_paso =  rt_paso
from   cob_credito..cr_ruta_tramite
where  rt_tramite = @i_tramite
and    rt_salida is NULL
if @@rowcount = 0
	   select @w_secuencia = max(rt_secuencia)
	   from   cob_credito..cr_ruta_tramite
	   where  rt_tramite = @i_tramite

/* Chequeo de Linea de Credito */
If @i_linea_credito is not null
begin
	select	@w_numero_linea = li_numero
	from   	cob_credito..cr_linea
	where	li_num_banco = @i_linea_credito
	If @@rowcount = 0
	begin
	/** registro no existe **/
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file  = @t_file, 
	    @t_from  = @w_sp_name,
	    @i_num   = 2101010
	    return 1 	
	end
end

/* Chequeo de Numero de operacion */
If @i_numero_op_banco is not null
begin
	If @i_producto = 'CCA'
	begin
		select	@w_numero_operacion = op_operacion
		from   	cob_cartera..ca_operacion
		where	op_banco = @i_numero_op_banco
		If @@rowcount = 0
		begin
		/** registro no existe **/
		    exec cobis..sp_cerror
		    @t_debug = @t_debug,
		    @t_file  = @t_file, 
		    @t_from  = @w_sp_name,
		    @i_num   = 2101011
		    return 1 	
		end
	end
	/*If @i_producto = 'CEX' -- NO SE ENCUENTRA LA BASE COB_COMEXT
	begin
		select	@w_numero_operacion = op_operacion
		from   	cob_comext..ce_operacion
		where	op_operacion_banco = @i_numero_op_banco
		If @@rowcount = 0
		begin
		-- registro no existe
		    exec cobis..sp_cerror
		    @t_debug = @t_debug,
		    @t_file  = @t_file, 
		    @t_from  = @w_sp_name,
		    @i_num   = 2101011
		    return 1 	
		end
	end
	*/
 end
end

If @i_operacion = 'I' or @i_operacion = 'U'
begin
/** Obtener prioridad **/
	SELECT @w_prioridad = tt_prioridad
	from   cob_credito..cr_tipo_tramite
	where  tt_tipo = @i_tipo
	if @@rowcount = 0
	begin
	   select @w_prioridad = 1
	end

   -- VALIDA PROHIBICION DE RUTEO DE TRAMITES DEL FUNCIONARIO
   -- O DE SUS RELACIONADOS (Deudores y Codeudores)  --AOL 03MAY07
   SELECT @w_return  = 0
   
   /*
   exec cob_credito..sp_prohibicion_ruteo --SE COMENTA POR QUE NO EXISTE SP
        @s_user    = @s_user,
        @i_tramite = @i_tramite

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101085
      return 1 
   end
   */
   --VCHILIQUINGA 18/NOV/2010
   --VALIDA QUE EXISTA N+MERO DE CUENTA
--/*--SE DESCOMENTA POR PRUEBAS --Ref A
   if @i_fpago is not null
   begin
	   if not exists(select ah_cta_banco 
	   from cob_ahorros..ah_cuenta,cob_remesas..pe_pro_bancario 
	   where ah_cta_banco=@i_cuenta
	   and ah_prod_banc=pb_pro_bancario 
	   and ah_cliente=@i_cliente_cca
	   --and pb_aplica_deb_auto = 'S'	   SE COMENTA POR QUE NO EXISTE ESA COLUMNA
	   and ah_estado = 'A')
	   --if @@rowcount = 0
	   begin
		  exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 101127
		  return 1 
	   end
   end    
  -- */
end

/* Insercion del registro */
/**************************/
if @i_operacion = 'I'
begin
if @i_tipo is NULL
begin

	/* Eliminacion de tabla temporal de deudores */
	delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn
	
/* Campos NOT NULL con valores nulos */
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = 2101001
return 1 
end

/*Incluir Financiamiento JSB 99-01-26*/
if (@i_deudor is NULL  and @i_tipo = 'O')
or (@i_deudor is NULL  and @i_tipo = 'R')
or (@i_deudor is NULL  and @i_tipo = 'F')	 
begin

	/* Eliminacion de tabla temporal de deudores */
	delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn

/* Campos NOT NULL con valores nulos */
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = 2101001
return 1 
end

if @w_existe = 1
begin  
	
	/* Eliminacion de tabla temporal de deudores */
	delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn
	
  /* Registro ya existe */
  exec cobis..sp_cerror
  @t_debug = @t_debug,
  @t_file  = @t_file, 
  @t_from  = @w_sp_name,
  @i_num   = 2101002
  return 1 
end

/** llamada al stored procedure que inserta tramites **/
--SPO
if @i_toperacion is not null
 if not exists(select * from cob_credito..cr_corresp_sib where tabla='T12' and codigo=@i_toperacion_ori)
 begin
   print 'El Tipo de Operacion ['+ @i_toperacion_ori  +'] no tiene Equivalente en la tabla T12 de la SIB' 
   return 1
 end
PRINT 'MGU @i_toperacion: '+ @i_toperacion +';@o_tramite: ' + @o_tramite
  --MGU: Invocacion a la creacion del tramite sin evaluacion de etapas
  
  select @i_tplazo = @i_frec_pago,
	     @i_plazo  = @i_pplazo
  
  SELECT isNULL(@i_truta,88) --Ruta que identifica a los trámites enviados por WorkFlow
  exec @w_return = cob_pac..sp_in_tramite_busin 
	   @s_ssn,@s_user,@s_sesn,@s_term,@s_date,@s_srv,@s_lsrv,@s_rol,
	   @s_ofi,@s_org_err,@s_error,@s_sev,@s_msg,@s_org,
	   @t_rty,@t_trn,@t_debug,@t_file,@t_from,
	   @i_operacion,@i_tramite,@i_tipo,@i_truta,@i_oficina_tr,
	   @i_usuario_tr,@i_fecha_crea,@i_oficial,@i_sector,@i_ciudad,
	   @i_estado,@i_nivel_ap,@i_fecha_apr,@i_usuario_apr,@i_numero_op_banco,
	   /* campos para tramites de garantias */
	   @i_proposito,@i_razon,@i_txt_razon,@i_efecto,
	   /* campos para lineas de credito */
	   @i_cliente,@i_grupo,@i_fecha_inicio,@i_num_dias,@i_per_revision,
	   @i_condicion_especial,@i_rotativa,

	   /* operaciones originales y renovaciones */
	   @i_linea_credito,@i_toperacion,@i_producto,@i_monto,@i_moneda,
	   @i_periodo,@i_num_periodos,@i_destino,@i_ciudad_destino,@i_parroquia,  -- ITO:13/12/2011 parroquia
	   @i_cuenta_corriente,@i_garantia_limpia,

	   -- solo para prestamos de cartera
	   @i_monto_desembolso,@i_reajustable,@i_per_reajuste,
	   @i_reajuste_especial, @i_fecha_reajuste,@i_cuota_completa,
	   @i_tipo_cobro,@i_tipo_reduccion,@i_aceptar_anticipos,
	   @i_precancelacion,@i_tipo_aplicacion,@i_renovable,
	   @i_fpago,@i_cuenta,

           -- generales
	   @i_renovacion,@i_cliente_cca,@i_op_renovada,@i_deudor,
	   -- reestructuracion

	   @i_op_reestructurar,
	   @i_cuenta_certificado,
	   @i_alicuota, @i_alicuota_aho, @i_doble_alicuota, --DMO Personalizacion Coop
       @i_actividad_destino,  -- SPO Campo Actividad de destino de la operacion 
       @i_compania,           -- SPO Nombre de la compania 
       @i_tipo_cca,           -- SPO Clase de cartera 
       @i_vinculado,    
       @i_causal_vinculacion,
       @i_verificador,
	   @i_seg_cre,
	   @i_activa_TirTea = @i_activa_TirTea,           -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
	   @i_ssn = @i_ssn, --AC SSN PARA ALMACENAR LOS DEUDORES
	   @i_toperacion_ori = @i_toperacion_ori, --Policia Nacional: Se incrementa por tema de interceptor  
	   @i_plazo          = @i_plazo,	--Parámetro para crear la operación con el plazo ingresado desde la Originación
	   @i_tplazo         = @i_tplazo,	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
	   @o_retorno = @o_tramite out -- MNU 2010.11.29 - Retorno numero tramite	

if @w_return != 0
begin
	/* Eliminacion de tabla temporal de deudores */
	delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn
	return @w_return
end	

/* Eliminacion de tabla temporal de deudores */
delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn
	
PRINT 'MGU Ejecuto sp_in tramite: ' + @o_tramite
/*--SE COMENTA POR QUE NO EXISTE SP
----VALIDA MONTO MAXIMO DE ENDEUDAMIENTO EN EL SISTEMA FINANCIERO    
   exec @w_return  = cob_credito..sp_valida_saldos_deuda	
	    @s_user         = @s_user,
     	@s_term         = @s_term,
        @s_date         = @s_date,
       	@i_tramite      = @o_tramite,
       	@i_seg_cred     = @i_seg_cre,
       	@i_tipo_car     = @i_tipo_cca,
       	@i_cliente      = @i_cliente_cca,
       	@i_valor_credito_evaluado = @i_monto,
       	@i_graba        = 'S'

    if @w_return != 0
    begin
       exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 710191
       return 710191
    end
*/
PRINT 'Fin del registro: ' + @o_tramite

----REQ#2765 VALIDA LA GARANTIAS 
/*--SE COMENTA POR QUE NO EXISTE SP
exec @w_return  = sp_valida_garantia
	@s_user        	= @s_user,
	@s_term        	= @s_term,
	@s_date        	= @s_date,
	@i_operacion 	= @i_operacion,
	@i_tramite      = @i_tramite,	--tramite
	@i_seg_cred     = @i_seg_cre,	--segmento de credito 3
	@i_tipo_car     = @i_tipo_cca, --tipo de cartera 4
	@i_cliente      = @i_cliente_cca,
	@i_tipo_oper    = @i_tipo
if @w_return != 0
begin
   return @w_return  
end
--*/
end
/* Actualizacion del registro */
/******************************/
if @i_operacion = 'U'
begin
--  eliminacion de formas de pago en el caso de existir cambio de tipo de operacion
--  en un producto de comercio exterior  						
	select 	@w_toperacion=tr_toperacion,
		@w_producto=tr_producto
	from 	cob_credito..cr_tramite	
	where   tr_tramite = @i_tramite

	/*if @w_producto = 'CEX' and @i_toperacion <> @w_toperacion 
	begin
		delete 	cob_comext..ce_credito_forma_pago
		where 	cf_tramite = @i_tramite
	end*/

if  @i_tramite is NULL or @i_tipo is NULL 
begin
  /* Campos NOT NULL con valores nulos */
  exec cobis..sp_cerror
  @t_debug = @t_debug,
  @t_file  = @t_file, 
  @t_from  = @w_sp_name,
  @i_num   = 2101001
  return 1 
end

 --VALIDA MONTO MAXIMO DE ENDEUDAMIENTO EN EL SISTEMA FINANCIERO  
 
 --/*--SE DESCOMENTA POR PRUEBAS
 exec @w_return  = cob_pac..sp_valida_saldos_deuda_busin
       	@s_user         = @s_user,
       	@s_sesn         = @s_sesn,
     	@s_term         = @s_term,
        @s_date         = @s_date,
       	@i_tramite      = @i_tramite,
       	@i_seg_cred     = @i_seg_cre,
       	@i_tipo_car     = @i_tipo_cca,
       	@i_cliente      = @i_cliente_cca,
       	@i_valor_credito_evaluado = @i_monto,
       	@i_valor_ant    = @w_monto,
     	@i_graba        = 'S'
 if @w_return != 0
 begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 710191
 return 710191
 end
--*/
--REQ#2765 VALIDA LA GARANTIAS

--/* SE DESCOMENTA POR PRUEBAS
exec @w_return  = cob_pac..sp_valida_garantia_busin
	@s_user        	= @s_user,
	@s_sesn         = @s_sesn,
	@s_term        	= @s_term,
	@s_date        	= @s_date,
	@i_operacion 	= @i_operacion,
	@i_tramite      = @i_tramite,	--tramite
	@i_seg_cred     = @i_seg_cre,	--segmento de credito 3
	@i_tipo_car     = @i_tipo_cca, --tipo de cartera 4
	@i_cliente      = @i_cliente_cca,
	@i_tipo_oper    = @i_tipo
if @w_return != 0
begin
   return @w_return
end

if @w_existe = 0
begin
-- Registro a actualizar no existe 
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = 2105002
return 1 
end
--*/
--Se incrementa para policia debido a que no se estaba guadando los deudores
if exists( select 1 from cob_pac..cr_deudores_tmp, cobis..cl_ente where dt_ssn = @i_ssn and en_ente = dt_cliente)
begin
   delete cob_credito..cr_deudores where de_tramite = @i_tramite

   insert cob_credito..cr_deudores
   select @i_tramite, dt_cliente, dt_rol, en_ced_ruc, null, null
   from cob_pac..cr_deudores_tmp, cobis..cl_ente
   where dt_ssn = @i_ssn
   and en_ente = dt_cliente
   
   if @@error <> 0
   begin
      return 2103001
   end

   delete cob_pac..cr_deudores_tmp where dt_ssn = @i_ssn
end

--Recuperacion de frecuencia y plazo
select @i_tplazo = @i_frec_pago,
	   @i_plazo  = @i_pplazo

/* llamada al stored procedure de actualizacion */
exec @w_return = cob_pac..sp_up_tramite_busin
/* parametros de tran-server */
	@s_ssn = @s_ssn,
	@s_user = @s_user,
	@s_sesn = @s_sesn,
	@s_term = @s_term,
	@s_date = @s_date,
	@s_srv = @s_srv,
	@s_lsrv = @s_lsrv,
	@s_rol = @s_rol,
	@s_ofi = @s_ofi,
	@s_org_err = @s_org_err,
	@s_error = @s_error,
	@s_sev = @s_sev,
	@s_msg = @s_msg,
	@s_org = @s_org,
	@t_rty = @t_rty,
	@t_trn = @t_trn,
	@t_debug = @t_debug,
	@t_file = @t_file,
	@t_from = @t_from,
/* parametros de input */
	@i_operacion = @i_operacion,
	@i_tramite = @i_tramite,
	@i_tipo = @i_tipo,
	@i_truta = @i_truta,
	@i_oficina_tr = @i_oficina_tr,
	@i_usuario_tr = @i_usuario_tr,
	@i_fecha_crea = @i_fecha_crea,
	@i_oficial = @i_oficial,
	@i_sector = @i_sector,
	@i_ciudad = @i_ciudad,
	@i_estado = @i_estado,
	@i_nivel_ap = @i_nivel_ap,
	@i_fecha_apr = @i_fecha_apr,
	@i_usuario_apr = @i_usuario_apr,
	@i_numero_op_banco = @i_numero_op_banco,
	@i_proposito = @i_proposito,
	@i_razon = @i_razon,
	@i_txt_razon = @i_txt_razon,
	@i_efecto = @i_efecto,
	@i_cliente = @i_cliente,
	@i_grupo = @i_grupo,
	@i_fecha_inicio = @i_fecha_inicio,
	@i_num_dias = @i_num_dias,
	@i_per_revision = @i_per_revision,
	@i_condicion_especial= @i_condicion_especial,
	@i_rotativa = @i_rotativa,
	@i_linea_credito = @i_linea_credito,
	@i_toperacion = @i_toperacion,
	@i_producto = @i_producto,
	@i_monto = @i_monto,
	@i_moneda = @i_moneda,
	@i_periodo = @i_periodo,
	@i_num_periodos = @i_num_periodos,
	@i_destino = @i_destino,
	@i_ciudad_destino = @i_ciudad_destino,
    @i_parroquia      = @i_parroquia,    --ITO: 12/12/2011
	@i_cuenta_corriente = @i_cuenta_corriente,
	@i_garantia_limpia = @i_garantia_limpia,
	@i_monto_desembolso = @i_monto_desembolso,
	@i_reajustable = @i_reajustable,
	@i_per_reajuste = @i_per_reajuste,
	@i_reajuste_especial = @i_reajuste_especial,
	@i_fecha_reajuste = @i_fecha_reajuste,
	@i_cuota_completa = @i_cuota_completa,
	@i_tipo_cobro = @i_tipo_cobro,
	@i_tipo_reduccion = @i_tipo_reduccion,
	@i_aceptar_anticipos = @i_aceptar_anticipos,
	@i_precancelacion = @i_precancelacion,
	@i_tipo_aplicacion = @i_tipo_aplicacion,
	@i_renovable = @i_renovable,
	@i_fpago = @i_fpago,
	@i_cuenta = @i_cuenta,
	@i_renovacion = @i_renovacion,
	@i_cliente_cca = @i_cliente_cca,
	@i_op_renovada = @i_op_renovada,
	@i_deudor = @i_deudor,
	@i_cuenta_certificado= @i_cuenta_certificado,
	@i_alicuota = @i_alicuota,
	@i_alicuota_aho = @i_alicuota_aho,
	@i_doble_alicuota = @i_doble_alicuota,
-- etapa rechazo
	@i_tramite     =@i_tramite,
    @i_tipo_cartera  = @i_tipo_cartera,
    @i_destino_descripcion =@i_destino_descripcion,
    @i_patrimonio =@i_patrimonio,
    @i_ventas  = @i_ventas,
    @i_num_personal_ocupado =@i_num_personal_ocupado,
    @i_tipo_credito = @i_tipo_credito,
    @i_indice_tamano_actividad =@i_indice_tamano_actividad,
    @i_objeto  = @i_objeto ,
    @i_actividad  = @i_actividad ,
    @i_descripcion_oficial = @i_descripcion_oficial,
    @i_ventas_anuales = @i_ventas_anuales,
    @i_activos_productivos = @i_activos_productivos,
    @i_level_indebtedness=@i_level_indebtedness,
    @i_asigna_fecha_cic = @i_asigna_fecha_cic,
    @i_convenio                 = @i_convenio    ,
    @i_codigo_cliente_empresa=@i_codigo_cliente_empresa,
    @i_reprogramingObserv=@i_reprogramingObserv,
    @i_motivo_uno = @i_motivo_uno,        -- Etapa Rechazo
    @i_motivo_dos = @i_motivo_dos,        -- Etapa Rechazo
    @i_motivo_rechazo = @i_motivo_rechazo, -- Etapa Rechazo
    @i_tamanio_empresa = @i_tamanio_empresa,
    @i_producto_fie    = @i_producto_fie,
    @i_num_viviendas   = @i_num_viviendas,
    @i_calificacion    = @i_calificacion,
    @i_es_garantia_destino = @i_es_garantia_destino,
    --fin rechazo

-- reestructuracion
	@i_op_reestructurar = @i_op_reestructurar,
	@i_verificador = @i_verificador,

/* valores del registro actual */
	@i_w_tipo = @w_tipo,
	@i_w_truta = @w_truta,
	@i_w_oficina_tr = @w_oficina_tr,
	@i_w_usuario_tr = @w_usuario_tr,
	@i_w_fecha_crea = @w_fecha_crea,
	@i_w_oficial = @w_oficial,
	@i_w_sector = @w_sector,
	@i_w_ciudad = @w_ciudad,
	@i_w_estado = @w_estado,
	@i_w_nivel_ap = @w_nivel_ap,
	@i_w_fecha_apr = @w_fecha_apr,
	@i_w_usuario_apr = @w_usuario_apr,
	@i_w_numero_op_banco = @w_numero_op_banco,
	@i_w_numero_op = @w_numero_op,
	@i_w_proposito = @w_proposito,
	@i_w_razon = @w_razon,
	@i_w_txt_razon = @w_txt_razon,
	@i_w_efecto = @w_efecto,
	@i_w_cliente = @w_cliente,
	@i_w_grupo = @w_grupo,
	@i_w_fecha_inicio = @w_fecha_inicio,
	@i_w_num_dias = @w_num_dias,
	@i_w_per_revision = @w_per_revision,
	@i_w_condicion_especial= @w_condicion_especial,
	@i_w_linea_credito = @w_linea_credito,
	@i_w_toperacion = @w_toperacion,
	@i_w_producto          = @w_producto,
	@i_w_monto     = @w_monto,
	@i_w_moneda            = @w_moneda,
	@i_w_periodo           = @w_periodo,
	@i_w_num_periodos      = @w_num_periodos,	
	@i_w_destino           = @w_destino,
	@i_w_ciudad_destino    = @w_ciudad_destino,
    @i_w_parroquia         = @i_parroquia,    -- ITO:12/12/2011
	@i_w_cuenta_corriente  = @w_cuenta_corriente,
	@i_w_garantia_limpia   = @w_garantia_limpia,
	@i_w_renovacion        = @w_renovacion,
	@i_w_doble_alicuota    = @w_doble_alicuota,
	@i_w_verificador       = @w_verificador,
    @i_actividad_destino   = @i_actividad_destino,  --SPO  Campo actividad destino
    @i_compania            = @i_compania,           --SPO  Compania - grupo
    @i_tipo_cca            = @i_tipo_cca,           --SPO  Clase de cartera
    @i_vinculado           = @i_vinculado,
    @i_causal_vinculacion  = @i_causal_vinculacion,
    @i_seg_cre = @i_seg_cre,         --SRA SEGMENTO CREDITO 17/09/2007
    @i_w_seg_cre           = @w_seg_cre,         --PRON:19/SEP/07
    @i_w_alicuota          = @w_alicuota,        --PRON:25/OCT/07
    @i_w_alicuota_aho      = @w_alicuota_aho,     --PRON:25/OCT/07
	@i_ssn                 = @i_ssn, --AC SSN PARA ALMACENAR LOS DEUDORES
    @i_activa_TirTea       = @i_activa_TirTea,    -- SPRINT 6 320:Parametrizacion de mensajes de Credito, PBE
    @i_toperacion_ori      = @i_toperacion_ori,   --Tipo de Operación Interceptado
	@i_plazo               = @i_plazo,	--Parámetro para crear la operación con el plazo ingresado desde la Originación
	@i_tplazo              = @i_tplazo	--Parámetro para crear la operación con el tipo de plazo ingresado desde la Originación
		
	if @w_return != 0
    return @w_return
	
	if (@i_toperacion='CREGRP' or @i_toperacion='CREGRP1' or @i_toperacion='CREGRUP1')
	BEGIN  
			
		SELECT  @w_miembros = count(1)
		FROM  cobis..cl_cliente_grupo
		WHERE  cg_grupo = @i_cliente
		 	
		update cob_credito..cr_tramite_grupal
		set tg_monto = (@i_monto/@w_miembros)
		WHERE  tg_tramite = @i_tramite
	end
   

end


--Guarda informacion de otro destino del tramite
if @i_operacion = 'I'
begin

    select @i_tramite = isNULL(@i_tramite,@o_tramite)

    /* -- SE COMENTA POR QUE NO EXISTE SP
	exec @w_return = cob_cartera..sp_inf_tasas_bce
	@t_trn          	= 7450,
	@s_ssn          	= @s_ssn,
	@s_sesn         	= @s_sesn,
	@s_ofi          	= @s_ofi,
	@s_rol          	= @s_rol,
	@s_srv          	= @s_srv,
	@s_lsrv         	= @s_lsrv,
	@s_term         	= @s_term,
	@s_org          	= @s_org,
	@s_user         	= @s_user,
	@s_date         	= @s_date,
	@i_operacion     	= 'IT',
	@i_banco        	= '',
	@i_tramite      	= @i_tramite ,
	@i_saldo_acum      	= 0,
	@i_dest_finan   	= @i_destino,
	@i_act_eco_bce      = @i_actividad_destino,
	@i_dest_hipot       = @i_dest_hipot,
	@i_dest_consumo     = @i_dest_consumo

	if @w_return != 0
	begin
		return @w_return  
	end
	*/
end

--Actualiza informacion de otro destino del tramite
if @i_operacion = 'U'
begin

	if @i_destino is not null and @i_actividad_destino is not null
	begin
	      print 'Ingreso operacion U y no hace nada mas'
		   /* -- SE COMENTA POR QUE NO EXISTE SP
		   exec @w_return = cob_cartera..sp_inf_tasas_bce
			@t_trn          	= 7450,
			@s_ssn          	= @s_ssn,
			@s_sesn         	= @s_sesn,
			@s_ofi          	= @s_ofi,
			@s_rol          	= @s_rol,
			@s_srv          	= @s_srv,
			@s_lsrv         	= @s_lsrv,
			@s_term         	= @s_term,
			@s_org          	= @s_org,
			@s_user         	= @s_user,
			@s_date         	= @s_date,
			@i_operacion     	= 'UT',
			@i_banco        	= '',
			@i_tramite      	= @i_tramite ,
			@i_saldo_acum      	= 0,
			@i_dest_finan   	= @i_destino,
			@i_act_eco_bce      = @i_actividad_destino,
			@i_dest_hipot       = @i_dest_hipot,
			@i_dest_consumo     = @i_dest_consumo
		
			if @w_return != 0
			begin
				return @w_return  
			end
			*/--SE DESCOMENTA POR PRUEBAS
			
	end
	
end



/* Eliminacion de registros */
/****************************/
if @i_operacion = 'D'
begin
if @w_existe = 0
begin
/* Registro a eliminar no existe */
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_num   = 2107002
return 1 
end
/* --SE DESCOMENTA POR PRUEBAS
exec @w_return = cob_credito..sp_de_tramite
	-- parametros de tran-server 
	@s_ssn, @s_user, @s_sesn, @s_term, @s_date, @s_srv, @s_lsrv,
	@s_rol, @s_ofi, @s_org_err, @s_error, @s_sev, @s_msg,
	@s_org, @t_rty, @t_trn, @t_debug, @t_file, @t_from,
	-- parametros de input 
	@i_operacion,		@i_tramite,
	-- valores del registro actual 
   -- registro anterior 
	@w_tipo,		@w_truta,		@w_oficina_tr,
	@w_usuario_tr,		@w_fecha_crea,		@w_oficial,
	@w_sector,		@w_ciudad,		@w_estado,
	@w_nivel_ap,		@w_fecha_apr,		@w_usuario_apr,
	@w_numero_op,		@w_numero_op_banco,	@w_proposito, 
	@w_razon,   		@w_txt_razon,		@w_efecto,
	@w_cliente,		@w_grupo,		@w_fecha_inicio,
	@w_num_dias,		@w_per_revision,	@w_condicion_especial,
	@w_linea_credito,	@w_toperacion,		@w_producto,
	@w_monto,		@w_moneda,		@w_periodo,
	@w_num_periodos,	@w_destino,		@w_ciudad_destino,
	@w_cuenta_corriente,	@w_garantia_limpia,	@w_renovacion,
    @w_verificador
if @w_return != 0
	return @w_return
	*/
end

/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'Q'
begin

 exec cob_pac..sp_query_tramite_busin
  @t_debug           = @t_debug,
  @t_file            = @t_file,
  @t_from            = @t_from,
  @i_tramite         = @i_tramite,
  @i_numero_op_banco = @i_numero_op_banco,
  @i_linea_credito   = @i_linea_credito,
  @i_producto        = @i_producto,
  @i_es_acta         = @i_es_acta 
end 
return 0

GO
