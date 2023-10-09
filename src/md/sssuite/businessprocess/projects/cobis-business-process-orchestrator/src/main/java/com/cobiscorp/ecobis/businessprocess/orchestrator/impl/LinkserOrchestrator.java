package com.cobiscorp.ecobis.businessprocess.orchestrator.impl;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import com.cobiscorp.cobis.cis.sp.java.orchestration.CISResponseManagmentHelper;
import com.cobiscorp.cobis.cis.sp.java.orchestration.ICISSPBaseOrchestration;
import com.cobiscorp.cobis.cis.sp.java.orchestration.SPJavaOrchestrationBase;
import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.csp.domains.ICSP;
import com.cobiscorp.cobis.csp.services.IProvider;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureRequestParam;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.IProcedureResponseParam;
import com.cobiscorp.utils.Util;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

@Component(name = "LinkserOrchestrator", immediate = false)
@Service({
		com.cobiscorp.cobis.cis.sp.java.orchestration.ICISSPBaseOrchestration.class,
		com.cobiscorp.cobis.csp.services.inproc.IOrchestrator.class })
@Properties({
		@Property(name = "service.description", value = "LinkserOrchestrator"),
		@Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"),
		@Property(name = "service.identifier", value = "LinkserOrchestrator") })
public class LinkserOrchestrator extends SPJavaOrchestrationBase {

	private final ILogger logger = this.getLogger();
	@SuppressWarnings("deprecation")
	private final CISResponseManagmentHelper cisResponseHelper = new CISResponseManagmentHelper();

	@Override
	public void loadConfiguration(IConfigurationReader configurationReader) {
	}

	@Override
	public IProcedureResponse executeJavaOrchestration(
			IProcedureRequest anOriginalRequest,
			java.util.Map<String, Object> aBagSPJavaOrchestration) {
		boolean wGetDataForLinkser;
		boolean wGetReport;

		aBagSPJavaOrchestration.put("anOriginalRequest", anOriginalRequest);
		anOriginalRequest.addOutputParam("@o_estado", ICTSTypes.SYBVARCHAR,
				"ERROR");
		anOriginalRequest.addOutputParam("@o_retorno", ICTSTypes.SYBINT4,
				"8000");

		wGetDataForLinkser = getDataForLinkser(aBagSPJavaOrchestration);
		if (wGetDataForLinkser) {
			if (logger.isDebugEnabled())
				logger.logDebug("-->> CREDITCARD-ORCHESTRATOR => GET_REPORT - Ending flow, <getDataForLinkser> failed.");
			return this.processResponse(anOriginalRequest,
					aBagSPJavaOrchestration);
		}
		wGetReport = getReport(aBagSPJavaOrchestration);
		if (wGetReport) {
			if (logger.isDebugEnabled())
				logger.logDebug("-->> CREDITCARD-ORCHESTRATOR => GET_REPORT - Ending flow, <getReport> failed.");
			return this.processResponse(anOriginalRequest,
					aBagSPJavaOrchestration);
		}
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	private Boolean getDataForLinkser(
			java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest originalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration
				.get("anOriginalRequest")));
		IProcedureRequest requestTmp = (initProcedureRequest(originalRequest));
		requestTmp.setSpName("cob_credito..sp_autoriza_ltc");
		requestTmp.addInputParam("@t_trn", ICTSTypes.SYBINT4, "21187");
		// requestTmp.addInputParam("@i_operacion", ICTSTypes.SYBCHAR, "L");
		Util.copyParam("@i_operacion", originalRequest, requestTmp);
		Util.copyParam("@i_tramite", originalRequest, requestTmp);

		IProcedureResponse response = executeCoreBanking(requestTmp);
		aBagSPJavaOrchestration.put("wgetDataForLinkserResp", response);
		if (!response.hasError()) {
			aBagSPJavaOrchestration.put("p_numero_operacion", response.getResultSetRowColumnData(1, 1, 1).getValue());
			IProcedureRequestParam wPRParam = originalRequest
					.readParam("@i_operacion");
			if (wPRParam != null && wPRParam.getValue().equals("L")) { 
				aBagSPJavaOrchestration.put("p_oficina", response
						.getResultSetRowColumnData(1, 1, 2).getValue());
				aBagSPJavaOrchestration.put("p_moneda", response
						.getResultSetRowColumnData(1, 1, 3).getValue());
				aBagSPJavaOrchestration.put("p_monto", response
						.getResultSetRowColumnData(1, 1, 4).getValue());
				aBagSPJavaOrchestration.put("p_titular_id", response
						.getResultSetRowColumnData(1, 1, 5).getValue());
				aBagSPJavaOrchestration.put("p_titular_ente", response
						.getResultSetRowColumnData(1, 1, 6).getValue());
				aBagSPJavaOrchestration.put("p_titular_nombre", response
						.getResultSetRowColumnData(1, 1, 7).getValue());
				aBagSPJavaOrchestration.put("p_titular_dir", response
						.getResultSetRowColumnData(1, 1, 8).getValue());
				aBagSPJavaOrchestration.put("p_oficial", response
						.getResultSetRowColumnData(1, 1, 9).getValue());
				aBagSPJavaOrchestration.put("p_sector_cli", response
						.getResultSetRowColumnData(1, 1, 10).getValue());
				aBagSPJavaOrchestration.put("p_fecha_aprob", response
						.getResultSetRowColumnData(1, 1, 11).getValue());
			} else { 
				aBagSPJavaOrchestration.put("p_monto", response
						.getResultSetRowColumnData(1, 1, 2).getValue());
				aBagSPJavaOrchestration.put("p_titular_id", response
						.getResultSetRowColumnData(1, 1, 3).getValue());
				aBagSPJavaOrchestration.put("p_titular_ente", response
						.getResultSetRowColumnData(1, 1, 4).getValue());
				aBagSPJavaOrchestration.put("p_titular_nombre", response
						.getResultSetRowColumnData(1, 1, 5).getValue());
				aBagSPJavaOrchestration.put("p_titular_dir", response
						.getResultSetRowColumnData(1, 1, 6).getValue());
				aBagSPJavaOrchestration.put("p_oficial", response
						.getResultSetRowColumnData(1, 1, 7).getValue());
				aBagSPJavaOrchestration.put("p_sector_cli", response
						.getResultSetRowColumnData(1, 1, 8).getValue());
				aBagSPJavaOrchestration.put("p_fecha_aprob", response
						.getResultSetRowColumnData(1, 1, 9).getValue());
			}
			if (wPRParam!=null){
				aBagSPJavaOrchestration.put("p_operacion", wPRParam.getValue());
			}
		}
		return response.hasError();
	}

	private Boolean getReport(
			java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wGetReportRequest = ((IProcedureRequest) aBagSPJavaOrchestration
				.get("anOriginalRequest"));
		IProcedureRequest wGetReportTMP = initProcedureRequest(wGetReportRequest);
		wGetReportTMP.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "2");

		wGetReportTMP.addInputParam("@i_operacion", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_operacion").toString());
		wGetReportTMP.addInputParam("@i_numero_operacion",
				ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_numero_operacion").toString());
		if (aBagSPJavaOrchestration.get("p_operacion").toString().equals("L")) {
			wGetReportTMP.addInputParam("@i_oficina", ICTSTypes.SYBVARCHAR,
					aBagSPJavaOrchestration.get("p_oficina").toString());
			wGetReportTMP.addInputParam("@i_moneda", ICTSTypes.SYBVARCHAR,
					aBagSPJavaOrchestration.get("p_moneda").toString());
		}
		wGetReportTMP.addInputParam("@i_monto", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_monto").toString());
		wGetReportTMP.addInputParam("@i_titular_id", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_titular_id").toString());
		wGetReportTMP.addInputParam("@i_titular_ente", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_titular_ente").toString());
		wGetReportTMP.addInputParam("@i_titular_nombre", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_titular_nombre").toString());
		wGetReportTMP.addInputParam("@i_titular_dir", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_titular_dir").toString());
		wGetReportTMP.addInputParam("@i_oficial", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_oficial").toString());
		wGetReportTMP.addInputParam("@i_sector_cli", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_sector_cli").toString());
		wGetReportTMP.addInputParam("@i_fecha_aprob", ICTSTypes.SYBVARCHAR,
				aBagSPJavaOrchestration.get("p_fecha_aprob").toString());

		wGetReportTMP.addFieldInHeader(ICOBISTS.HEADER_TIMEOUT,
				ICOBISTS.HEADER_STRING_TYPE, ((String) MyConfigurationImpl
						.getProperties().get("INFOCRED.HEADER_TIMEOUT")));
		wGetReportTMP.addFieldInHeader(IProvider.HEADER_CATALOG_PROVIDER,
				ICOBISTS.HEADER_STRING_TYPE, ((String) MyConfigurationImpl
						.getProperties()
						.get("INFOCRED.HEADER_CATALOG_PROVIDER")));
		aBagSPJavaOrchestration.put(
				ICISSPBaseOrchestration.CONNECTOR_TYPE,
				((String) MyConfigurationImpl.getProperties().get(
						"CREDITCARD.CONNECTOR_TYPE")));

		IProcedureResponse wGetReportResp = executeProvider(wGetReportTMP,
				aBagSPJavaOrchestration);
		aBagSPJavaOrchestration.put("wGetReportResp", wGetReportResp);
		Integer returnCode = Integer.valueOf(wGetReportResp
				.readValueParam("@o_return"));
		aBagSPJavaOrchestration.put("returnCode", returnCode);
		String returnMessage = wGetReportResp.readValueParam("@o_message");
		aBagSPJavaOrchestration.put("returnMessage", returnMessage);

		if (logger.isDebugEnabled()) {
			logger.logDebug("returnProvider: " + returnCode);
			logger.logDebug("message: " + returnMessage);
		}

		@SuppressWarnings("unchecked")
		ArrayList<IProcedureResponseParam> procedureResponseParams = new ArrayList<IProcedureResponseParam>(
				wGetReportResp.getParams());
		// boolean hasReturnCode = false;
		// boolean hasReturnMessage = false;
		// String xmlString = null;
		// String returnMessage = "";
		// int returnCode = -1;
		// for (int i = 0; i < procedureResponseParams.size(); i++) {
		// if (procedureResponseParams.get(i).getName().equals("@o_return")) {
		// returnCode = Integer.parseInt(procedureResponseParams.get(i)
		// .getValue());
		// hasReturnCode = true;
		// break;
		// }
		// }
		// for (int i = 0; i < procedureResponseParams.size(); i++) {
		// if (procedureResponseParams.get(i).getName().equals("@o_message")) {
		// returnMessage = procedureResponseParams.get(i).getValue();
		// procedureResponseParams.remove(i);
		// hasReturnMessage = true;
		// break;
		// }
		// }
		if (returnCode == 0 || returnMessage.isEmpty()) {
			return true;
		}
		if (returnCode == 0) {
			// VALIDA QUE LA INFORMACION DEVUENTA SEA CORRECTA
			DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder docBuilder;
			Document doc;
			try {
				docBuilder = docBuilderFactory.newDocumentBuilder();
				doc = docBuilder.parse(new InputSource(new StringReader(
						returnMessage)));
			} catch (ParserConfigurationException e) {
				logger.logDebug(
						" --> CreditCard XML - MAL FORMADO - ParserConfigurationException = \n"
								+ returnMessage, e);
				wGetReportResp
						.addMessage(80000,
								"Error Infocred - XML MAL FORMADO - ParserConfigurationException");
				return true;
			} catch (SAXException e) {
				logger.logDebug(
						" --> CreditCard XML - MAL FORMADO - SAXException = \n"
								+ returnMessage, e);
				wGetReportResp.addMessage(80000,
						"Error Infocred - XML MAL FORMADO - SAXException");
				return true;
			} catch (IOException e) {
				logger.logDebug(
						" --> CreditCard XML - MAL FORMADO - IOException = \n"
								+ returnMessage, e);
				wGetReportResp.addMessage(80000,
						"Error Infocred - XML MAL FORMADO - IOException");
				return true;
			}
			doc.getDocumentElement().normalize();
			Element element = doc.getDocumentElement();
			// INICIA LA VALIDACION

			return wGetReportResp.hasError();
		} else if (returnCode == -1) { // ERROR EN LA CONEXION
			wGetReportResp.addMessage(80000, returnMessage);
			return true;
		} else if (returnCode == -2) { // ERROR AL INVOCAR EL SERVICIO
			wGetReportResp.addMessage(80000, returnMessage);
			return true;
		}

		return true;
	}

	@SuppressWarnings("deprecation")
	@Override
	public IProcedureResponse processResponse(
			IProcedureRequest originalRequest,
			java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(originalRequest));
		String[] wAllProcedureResponse = { "wGetReportResp",
				"wgetDataForLinkserResp" };
		cisResponseHelper
				.addOutputParamsResponse(wProcedureRespFinal, originalRequest,
						wAllProcedureResponse, aBagSPJavaOrchestration);
		cisResponseHelper.addResultsetsResponse(wProcedureRespFinal,
				wAllProcedureResponse, aBagSPJavaOrchestration);

		IProcedureResponse wProcedureRespDataForLinkser = (IProcedureResponse) aBagSPJavaOrchestration
				.get("wgetDataForLinkserResp");
		if (wProcedureRespDataForLinkser != null
				&& wProcedureRespDataForLinkser.getMessageListSize() != 0) {
			cisResponseHelper.addMessages(wProcedureRespFinal,
					wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT,
					ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT,
					ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		IProcedureResponse wProcedureRespGetReport = (IProcedureResponse) aBagSPJavaOrchestration
				.get("wGetReportResp");
		if (wProcedureRespGetReport != null
				&& wProcedureRespGetReport.getMessageListSize() != 0) {
			cisResponseHelper.addMessages(wProcedureRespFinal,
					wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT,
					ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT,
					ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		wProcedureRespFinal.addParam("@o_message", 1, 1,
				aBagSPJavaOrchestration.get("returnMessage").toString());
		wProcedureRespFinal.addParam("@o_return", 1, 1, aBagSPJavaOrchestration
				.get("returnCode").toString());

		logger.logDebug("wProcedureRespFinal --> "
				+ wProcedureRespFinal.getProcedureResponseAsString());

		return wProcedureRespFinal;
	}

}
