/**
 * Archivo: SpCuentaBuroUtil.java
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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;

import java.sql.Types;

import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import java.util.Collection;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;

import com.cobiscorp.cobis.cts.domains.ICTSTypes;


import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;

public class SpCuentaBuroUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpCuentaBuroUtil.class);
  
  private SpCuentaBuroUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeCuentaBuro
     * @desciption Inicializa el sp: cob_credito..sp_buro_cuenta
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeCuentaBuro(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_buro_cuenta";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("fechaCierreCuenta")) {
			wParameterValue = wParameter.get("fechaCierreCuenta");
            aProcedureRequest.addInputParam("@i_fecha_cierre_cuenta", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("creditoMaximo")) {
			wParameterValue = wParameter.get("creditoMaximo");
            aProcedureRequest.addInputParam("@i_credito_maximo", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosCalificadosMOP3")) {
			wParameterValue = wParameter.get("totalPagosCalificadosMOP3");
            aProcedureRequest.addInputParam("@i_total_pagos_calificados_m_o_p3", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaMasAntiguaHistoricoPagos")) {
			wParameterValue = wParameter.get("fechaMasAntiguaHistoricoPagos");
            aProcedureRequest.addInputParam("@i_fecha_mas_antigua_historico_pagos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroPagosVencidos")) {
			wParameterValue = wParameter.get("numeroPagosVencidos");
            aProcedureRequest.addInputParam("@i_numero_pagos_vencidos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("formaPagoActual")) {
			wParameterValue = wParameter.get("formaPagoActual");
            aProcedureRequest.addInputParam("@i_forma_pago_actual", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaInicioReestructura")) {
			wParameterValue = wParameter.get("fechaInicioReestructura");
            aProcedureRequest.addInputParam("@i_fecha_inicio_reestructura", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("identificadorSociedadCrediticia")) {
			wParameterValue = wParameter.get("identificadorSociedadCrediticia");
            aProcedureRequest.addInputParam("@i_identificador_sociedad_crediticia", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("registroImpugnado")) {
			wParameterValue = wParameter.get("registroImpugnado");
            aProcedureRequest.addInputParam("@i_registro_impugnado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaActualizacion")) {
			wParameterValue = wParameter.get("fechaActualizacion");
            aProcedureRequest.addInputParam("@i_fecha_actualizacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("limiteCredito")) {
			wParameterValue = wParameter.get("limiteCredito");
            aProcedureRequest.addInputParam("@i_limite_credito", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("garantia")) {
			wParameterValue = wParameter.get("garantia");
            aProcedureRequest.addInputParam("@i_garantia", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("claveObservacion")) {
			wParameterValue = wParameter.get("claveObservacion");
            aProcedureRequest.addInputParam("@i_clave_observacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroTelefonoOtorgante")) {
			wParameterValue = wParameter.get("numeroTelefonoOtorgante");
            aProcedureRequest.addInputParam("@i_numero_telefono_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("claveUnidadMonetaria")) {
			wParameterValue = wParameter.get("claveUnidadMonetaria");
            aProcedureRequest.addInputParam("@i_clave_unidad_monetaria", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("importeSaldoMorosidadHistMasGrave")) {
			wParameterValue = wParameter.get("importeSaldoMorosidadHistMasGrave");
            aProcedureRequest.addInputParam("@i_importe_saldo_morosidad_hist_mas_grave", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("ultimaFechaSaldoCero")) {
			wParameterValue = wParameter.get("ultimaFechaSaldoCero");
            aProcedureRequest.addInputParam("@i_ultima_fecha_saldo_cero", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("operacion")) {
			wParameterValue = wParameter.get("operacion");
            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("claveOtorgante")) {
			wParameterValue = wParameter.get("claveOtorgante");
            aProcedureRequest.addInputParam("@i_clave_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("mopHistoricoMorosidadMasGrave")) {
			wParameterValue = wParameter.get("mopHistoricoMorosidadMasGrave");
            aProcedureRequest.addInputParam("@i_mop_historico_morosidad_mas_grave", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaReporte")) {
			wParameterValue = wParameter.get("fechaReporte");
            aProcedureRequest.addInputParam("@i_fecha_reporte", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("indicadorTipoResponsabilidad")) {
			wParameterValue = wParameter.get("indicadorTipoResponsabilidad");
            aProcedureRequest.addInputParam("@i_indicador_tipo_responsabilidad", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("ente")) {
			wParameterValue = wParameter.get("ente");
            aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("modoReportar")) {
			wParameterValue = wParameter.get("modoReportar");
            aProcedureRequest.addInputParam("@i_modo_reportar", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaMasRecienteHistoricoPagos")) {
			wParameterValue = wParameter.get("fechaMasRecienteHistoricoPagos");
            aProcedureRequest.addInputParam("@i_fecha_mas_reciente_historico_pagos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("montoUltimoPago")) {
			wParameterValue = wParameter.get("montoUltimoPago");
            aProcedureRequest.addInputParam("@i_monto_ultimo_pago", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosCalificadosMOP4")) {
			wParameterValue = wParameter.get("totalPagosCalificadosMOP4");
            aProcedureRequest.addInputParam("@i_total_pagos_calificados_m_o_p4", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaAperturaCuenta")) {
			wParameterValue = wParameter.get("fechaAperturaCuenta");
            aProcedureRequest.addInputParam("@i_fecha_apertura_cuenta", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("saldoVencido")) {
			wParameterValue = wParameter.get("saldoVencido");
            aProcedureRequest.addInputParam("@i_saldo_vencido", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("montoPagar")) {
			wParameterValue = wParameter.get("montoPagar");
            aProcedureRequest.addInputParam("@i_monto_pagar", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("saldoActual")) {
			wParameterValue = wParameter.get("saldoActual");
            aProcedureRequest.addInputParam("@i_saldo_actual", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("tipoCuenta")) {
			wParameterValue = wParameter.get("tipoCuenta");
            aProcedureRequest.addInputParam("@i_tipo_cuenta", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosCalificadosMOP2")) {
			wParameterValue = wParameter.get("totalPagosCalificadosMOP2");
            aProcedureRequest.addInputParam("@i_total_pagos_calificados_m_o_p2", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("frecuenciaPagos")) {
			wParameterValue = wParameter.get("frecuenciaPagos");
            aProcedureRequest.addInputParam("@i_frecuencia_pagos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("nombreOtorgante")) {
			wParameterValue = wParameter.get("nombreOtorgante");
            aProcedureRequest.addInputParam("@i_nombre_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosReportados")) {
			wParameterValue = wParameter.get("totalPagosReportados");
            aProcedureRequest.addInputParam("@i_total_pagos_reportados", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroCuentaActual")) {
			wParameterValue = wParameter.get("numeroCuentaActual");
            aProcedureRequest.addInputParam("@i_numero_cuenta_actual", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("tipoContrato")) {
			wParameterValue = wParameter.get("tipoContrato");
            aProcedureRequest.addInputParam("@i_tipo_contrato", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaUltimaCompra")) {
			wParameterValue = wParameter.get("fechaUltimaCompra");
            aProcedureRequest.addInputParam("@i_fecha_ultima_compra", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("historicoPagos")) {
			wParameterValue = wParameter.get("historicoPagos");
            aProcedureRequest.addInputParam("@i_historico_pagos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("valorActivoValuacion")) {
			wParameterValue = wParameter.get("valorActivoValuacion");
            aProcedureRequest.addInputParam("@i_valor_activo_valuacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("totalPagosCalificadosMOP5")) {
			wParameterValue = wParameter.get("totalPagosCalificadosMOP5");
            aProcedureRequest.addInputParam("@i_total_pagos_calificados_m_o_p5", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaHistoricaMorosidadMasGrave")) {
			wParameterValue = wParameter.get("fechaHistoricaMorosidadMasGrave");
            aProcedureRequest.addInputParam("@i_fecha_historica_morosidad_mas_grave", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("numeroPagos")) {
			wParameterValue = wParameter.get("numeroPagos");
            aProcedureRequest.addInputParam("@i_numero_pagos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("fechaUltimoPago")) {
			wParameterValue = wParameter.get("fechaUltimoPago");
            aProcedureRequest.addInputParam("@i_fecha_ultimo_pago", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
	}

    /**
     * @name       executeCuentaBuro
     * @desciption ejecuta el sp: cob_credito..sp_buro_cuenta
     * @user       
     * @param      
     * @return
     */
	public static void executeCuentaBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeCuentaBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeCuentaBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeCuentaBuro(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultCuentaBuro", wLResult);
		aParameter.getInfo().put("aParamCuentaBuro", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

