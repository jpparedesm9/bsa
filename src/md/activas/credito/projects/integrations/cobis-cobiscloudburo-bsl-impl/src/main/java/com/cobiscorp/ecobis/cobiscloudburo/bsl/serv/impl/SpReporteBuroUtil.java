/**
 * Archivo: SpReporteBuroUtil.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.impl;

import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;

public class SpReporteBuroUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpReporteBuroUtil.class);
  
  private SpReporteBuroUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeReporteBuro
     * @desciption Inicializa el sp: cob_credito..sp_buro_resumen_reporte
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeReporteBuro(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_buro_resumen_reporte";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("totalPagosRevolventes")) {
			wParameterValue = wParameter.get("totalPagosRevolventes");
            aProcedureRequest.addInputParam("@i_total_pagos_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP4")) {
			wParameterValue = wParameter.get("numeroMOP4");
            aProcedureRequest.addInputParam("@i_numero_m_o_p4", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("pctLimiteCreditoUtilizadoRevolventes")) {
			wParameterValue = wParameter.get("pctLimiteCreditoUtilizadoRevolventes");
            aProcedureRequest.addInputParam("@i_pct_limite_credito_utilizado_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP0")) {
			wParameterValue = wParameter.get("numeroMOP0");
            aProcedureRequest.addInputParam("@i_numero_m_o_p0", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP99")) {
			wParameterValue = wParameter.get("numeroMOP99");
            aProcedureRequest.addInputParam("@i_numero_m_o_p99", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasPagosFijosHipotecas")) {
			wParameterValue = wParameter.get("cuentasPagosFijosHipotecas");
            aProcedureRequest.addInputParam("@i_cuentas_pagos_fijos_hipotecas", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasNegativasActuales")) {
			wParameterValue = wParameter.get("cuentasNegativasActuales");
            aProcedureRequest.addInputParam("@i_cuentas_negativas_actuales", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalSolicitudesReporte")) {
			wParameterValue = wParameter.get("totalSolicitudesReporte");
            aProcedureRequest.addInputParam("@i_total_solicitudes_reporte", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP97")) {
			wParameterValue = wParameter.get("numeroMOP97");
            aProcedureRequest.addInputParam("@i_numero_m_o_p97", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP7")) {
			wParameterValue = wParameter.get("numeroMOP7");
            aProcedureRequest.addInputParam("@i_numero_m_o_p7", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("tipoMoneda")) {
			wParameterValue = wParameter.get("tipoMoneda");
            aProcedureRequest.addInputParam("@i_tipo_moneda", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalCreditosMaximosRevolventes")) {
			wParameterValue = wParameter.get("totalCreditosMaximosRevolventes");
            aProcedureRequest.addInputParam("@i_total_creditos_maximos_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroTotalCuentasDespachoCobranza")) {
			wParameterValue = wParameter.get("numeroTotalCuentasDespachoCobranza");
            aProcedureRequest.addInputParam("@i_numero_total_cuentas_despacho_cobranza", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroTotalSolicitudesDespachosCobranza")) {
			wParameterValue = wParameter.get("numeroTotalSolicitudesDespachosCobranza");
            aProcedureRequest.addInputParam("@i_numero_total_solicitudes_despachos_cobranza", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasDisputa")) {
			wParameterValue = wParameter.get("cuentasDisputa");
            aProcedureRequest.addInputParam("@i_cuentas_disputa", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroSolicitudesUltimos6Meses")) {
			wParameterValue = wParameter.get("numeroSolicitudesUltimos6Meses");
            aProcedureRequest.addInputParam("@i_numero_solicitudes_ultimos6_meses", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("nuevaDireccionReportadaUltimos60Dias")) {
			wParameterValue = wParameter.get("nuevaDireccionReportadaUltimos60Dias");
            aProcedureRequest.addInputParam("@i_nueva_direccion_reportada_ultimos60_dias", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP3")) {
			wParameterValue = wParameter.get("numeroMOP3");
            aProcedureRequest.addInputParam("@i_numero_m_o_p3", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaSolicitudMasRecienteDespachoCobranza")) {
			wParameterValue = wParameter.get("fechaSolicitudMasRecienteDespachoCobranza");
            aProcedureRequest.addInputParam("@i_fecha_solicitud_mas_reciente_despacho_cobranza", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOPUR")) {
			wParameterValue = wParameter.get("numeroMOPUR");
            aProcedureRequest.addInputParam("@i_numero_m_o_p_u_r", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalSaldosActualesRevolventes")) {
			wParameterValue = wParameter.get("totalSaldosActualesRevolventes");
            aProcedureRequest.addInputParam("@i_total_saldos_actuales_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaAperturaCuentaMasReciente")) {
			wParameterValue = wParameter.get("fechaAperturaCuentaMasReciente");
            aProcedureRequest.addInputParam("@i_fecha_apertura_cuenta_mas_reciente", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP5")) {
			wParameterValue = wParameter.get("numeroMOP5");
            aProcedureRequest.addInputParam("@i_numero_m_o_p5", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalSaldosActualesPagosFijos")) {
			wParameterValue = wParameter.get("totalSaldosActualesPagosFijos");
            aProcedureRequest.addInputParam("@i_total_saldos_actuales_pagos_fijos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("mensajesAlerta")) {
			wParameterValue = wParameter.get("mensajesAlerta");
            aProcedureRequest.addInputParam("@i_mensajes_alerta", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalLimitesCreditoRevolventes")) {
			wParameterValue = wParameter.get("totalLimitesCreditoRevolventes");
            aProcedureRequest.addInputParam("@i_total_limites_credito_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP2")) {
			wParameterValue = wParameter.get("numeroMOP2");
            aProcedureRequest.addInputParam("@i_numero_m_o_p2", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP1")) {
			wParameterValue = wParameter.get("numeroMOP1");
            aProcedureRequest.addInputParam("@i_numero_m_o_p1", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("operacion")) {
			wParameterValue = wParameter.get("operacion");
            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalSaldosVencidosRevolventes")) {
			wParameterValue = wParameter.get("totalSaldosVencidosRevolventes");
            aProcedureRequest.addInputParam("@i_total_saldos_vencidos_revolventes", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("ente")) {
			wParameterValue = wParameter.get("ente");
            aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasClavesHistoriaNegativa")) {
			wParameterValue = wParameter.get("cuentasClavesHistoriaNegativa");
            aProcedureRequest.addInputParam("@i_cuentas_claves_historia_negativa", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaAperturaCuentaMasRecienteDespachoCobranza")) {
			wParameterValue = wParameter.get("fechaAperturaCuentaMasRecienteDespachoCobranza");
            aProcedureRequest.addInputParam("@i_fecha_apertura_cuenta_mas_reciente_despacho_cobranza", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaIngresoBD")) {
			wParameterValue = wParameter.get("fechaIngresoBD");
            aProcedureRequest.addInputParam("@i_fecha_ingreso_b_d", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP6")) {
			wParameterValue = wParameter.get("numeroMOP6");
            aProcedureRequest.addInputParam("@i_numero_m_o_p6", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroCuentas")) {
			wParameterValue = wParameter.get("numeroCuentas");
            aProcedureRequest.addInputParam("@i_numero_cuentas", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaSolicitudReporteMasReciente")) {
			wParameterValue = wParameter.get("fechaSolicitudReporteMasReciente");
            aProcedureRequest.addInputParam("@i_fecha_solicitud_reporte_mas_reciente", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("existenciaDeclaracionesConsumidor")) {
			wParameterValue = wParameter.get("existenciaDeclaracionesConsumidor");
            aProcedureRequest.addInputParam("@i_existencia_declaraciones_consumidor", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalSaldosVencidosPagosFijos")) {
			wParameterValue = wParameter.get("totalSaldosVencidosPagosFijos");
            aProcedureRequest.addInputParam("@i_total_saldos_vencidos_pagos_fijos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosPagosFijos")) {
			wParameterValue = wParameter.get("totalPagosPagosFijos");
            aProcedureRequest.addInputParam("@i_total_pagos_pagos_fijos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasRevolventesAbiertas")) {
			wParameterValue = wParameter.get("cuentasRevolventesAbiertas");
            aProcedureRequest.addInputParam("@i_cuentas_revolventes_abiertas", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalCreditosMaximosPagosFijos")) {
			wParameterValue = wParameter.get("totalCreditosMaximosPagosFijos");
            aProcedureRequest.addInputParam("@i_total_creditos_maximos_pagos_fijos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroMOP96")) {
			wParameterValue = wParameter.get("numeroMOP96");
            aProcedureRequest.addInputParam("@i_numero_m_o_p96", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaAperturaCuentaMasAntigua")) {
			wParameterValue = wParameter.get("fechaAperturaCuentaMasAntigua");
            aProcedureRequest.addInputParam("@i_fecha_apertura_cuenta_mas_antigua", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("cuentasCerradas")) {
			wParameterValue = wParameter.get("cuentasCerradas");
            aProcedureRequest.addInputParam("@i_cuentas_cerradas", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
	}

    /**
     * @name       executeReporteBuro
     * @desciption ejecuta el sp: cob_credito..sp_buro_resumen_reporte
     * @user       
     * @param      
     * @return
     */
	public static void executeReporteBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeReporteBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeReporteBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeReporteBuro(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultReporteBuro", wLResult);
		aParameter.getInfo().put("aParamReporteBuro", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

