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

@Component(name = "InfocredOrchestrator", immediate = false)
@Service({ com.cobiscorp.cobis.cis.sp.java.orchestration.ICISSPBaseOrchestration.class, com.cobiscorp.cobis.csp.services.inproc.IOrchestrator.class })
@Properties({ @Property(name = "service.description", value = "InfocredOrchestrator"), @Property(name = "service.vendor", value = "COBISCORP"), @Property(name = "service.version", value = "1.0.0"),
		@Property(name = "service.identifier", value = "InfocredOrchestrator") })
public class InfocredOrchestrator extends SPJavaOrchestrationBase {

	private final ILogger logger = this.getLogger();
	@SuppressWarnings("deprecation")
	private final CISResponseManagmentHelper cisResponseHelper = new CISResponseManagmentHelper();

	@Override
	public void loadConfiguration(IConfigurationReader configurationReader) {
	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, java.util.Map<String, Object> aBagSPJavaOrchestration) {
		boolean wGetUser;
		boolean wInsertReport;
		boolean wGetReport;

		aBagSPJavaOrchestration.put("anOriginalRequest", anOriginalRequest);
		anOriginalRequest.addOutputParam("@o_estado", ICTSTypes.SYBVARCHAR, "ERROR");
		anOriginalRequest.addOutputParam("@o_retorno", ICTSTypes.SYBINT4, "8000");

		wGetUser = getDataForInfocred(aBagSPJavaOrchestration);
		if (wGetUser) {
			if (logger.isDebugEnabled())
				logger.logDebug("-->> INFOCRED-ORCHESTRATOR => GET_REPORT - Ending flow, <getDataForInfocred> failed.");
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		wGetReport = getReport(aBagSPJavaOrchestration);
		if (wGetReport) {
			if (logger.isDebugEnabled())
				logger.logDebug("-->> INFOCRED-ORCHESTRATOR => GET_REPORT - Ending flow, <getReport> failed.");
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		wInsertReport = insertReport(aBagSPJavaOrchestration);
		if (wInsertReport) {
			if (logger.isDebugEnabled())
				logger.logDebug("-->> INFOCRED-ORCHESTRATOR => GET_REPORT - Ending flow, <insertReport> failed.");
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}

		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	private Boolean getDataForInfocred(java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest originalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get("anOriginalRequest")));
		IProcedureRequest requestTmp = (initProcedureRequest(originalRequest));
		requestTmp.setSpName("cob_credito..sp_infocred");
		requestTmp.addInputParam("@t_trn", ICTSTypes.SYBINT4, "21784");
		requestTmp.addInputParam("@i_operacion", ICTSTypes.SYBCHAR, "Q");
		Util.copyParam("@i_cliente", originalRequest, requestTmp);
		Util.copyParam("@i_valida_fecha", originalRequest, requestTmp);

		IProcedureResponse response = executeCoreBanking(requestTmp);
		aBagSPJavaOrchestration.put("wDataForInfocredResp", response);
		if (!response.hasError()) {
			aBagSPJavaOrchestration.put("p_nombre_completo_usuario", response.getResultSetRowColumnData(1, 1, 1).getValue());
			aBagSPJavaOrchestration.put("p_documento_usuario", response.getResultSetRowColumnData(1, 1, 2).getValue());
			aBagSPJavaOrchestration.put("p_documento_titular", response.getResultSetRowColumnData(2, 1, 2).getValue());

			IProcedureRequestParam wPRParam = originalRequest.readParam("@i_reconsulta");
			if (wPRParam != null && wPRParam.getValue().equals("N")) { // cuando "@i_reconsulta='N' se toma la data de la BBDD
				aBagSPJavaOrchestration.put("p_tipo_documento_titular", response.getResultSetRowColumnData(2, 1, 1).getValue());
			} else { // solo cuando "@i_reconsulta='S' se debe de mandar la data que viene de FrontEnd
				aBagSPJavaOrchestration.put("p_tipo_documento_titular", originalRequest.readParam("@i_tipo_documento_titular").getValue());
			}
		}
		return response.hasError();
	}

	private Boolean insertReport(java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest originalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get("anOriginalRequest")));
		IProcedureRequest requestTmp = (initProcedureRequest(originalRequest));
		requestTmp.setSpName("cob_credito..sp_infocred");
		requestTmp.addInputParam("@t_trn", ICTSTypes.SYBINT4, "21784");
		requestTmp.addInputParam("@i_operacion", ICTSTypes.SYBCHAR, "I");
		Util.copyParam("@i_cliente", originalRequest, requestTmp);
		Util.copyParam("@i_term", originalRequest, requestTmp);
		Util.copyParam("@i_tram_oper", originalRequest, requestTmp);
		Util.copyParam("@i_rol", originalRequest, requestTmp);
		Util.copyParam("@i_origen", originalRequest, requestTmp);
		requestTmp.addInputParam("@i_xml", ICTSTypes.SQLBINARY, aBagSPJavaOrchestration.get("xmlInfocred").toString());

		IProcedureResponse response = executeCoreBanking(requestTmp);
		aBagSPJavaOrchestration.put("wInsertReportResp", response);
		return response.hasError();
	}

	private Boolean getReport(java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wGetReportRequest = ((IProcedureRequest) aBagSPJavaOrchestration.get("anOriginalRequest"));
		IProcedureRequest wGetReportTMP = initProcedureRequest(wGetReportRequest);
		wGetReportTMP.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "2");
		Util.copyParam("@i_tipo_reporte", wGetReportRequest, wGetReportTMP);
		Util.copyParam("@i_nombre_completo_titular", wGetReportRequest, wGetReportTMP);
		wGetReportTMP.removeParam("@i_tipo_documento_titular");
		wGetReportTMP.addInputParam("@i_tipo_documento_titular", ICTSTypes.SYBVARCHAR, aBagSPJavaOrchestration.get("p_tipo_documento_titular").toString());
		wGetReportTMP.addInputParam("@i_documento_titular", ICTSTypes.SYBVARCHAR, aBagSPJavaOrchestration.get("p_documento_titular").toString());
		wGetReportTMP.addInputParam("@i_documento_usuario", ICTSTypes.SYBVARCHAR, aBagSPJavaOrchestration.get("p_documento_usuario").toString());
		wGetReportTMP.addInputParam("@i_nombre_completo_usuario", ICTSTypes.SYBVARCHAR, aBagSPJavaOrchestration.get("p_nombre_completo_usuario").toString());

		wGetReportTMP.addFieldInHeader(ICOBISTS.HEADER_TIMEOUT, ICOBISTS.HEADER_STRING_TYPE, ((String) MyConfigurationImpl.getProperties().get("INFOCRED.HEADER_TIMEOUT")));
		wGetReportTMP.addFieldInHeader(IProvider.HEADER_CATALOG_PROVIDER, ICOBISTS.HEADER_STRING_TYPE, ((String) MyConfigurationImpl.getProperties().get("INFOCRED.HEADER_CATALOG_PROVIDER")));
		aBagSPJavaOrchestration.put(ICISSPBaseOrchestration.CONNECTOR_TYPE, ((String) MyConfigurationImpl.getProperties().get("INFOCRED.CONNECTOR_TYPE")));

		IProcedureResponse wGetReportResp = executeProvider(wGetReportTMP, aBagSPJavaOrchestration);
		aBagSPJavaOrchestration.put("wGetReportResp", wGetReportResp);

		@SuppressWarnings("unchecked")
		ArrayList<IProcedureResponseParam> procedureResponseParams = new ArrayList<IProcedureResponseParam>(wGetReportResp.getParams());
		boolean hasReturnCode = false;
		boolean hasReturnMessage = false;
		// String xmlString = null;
		String returnMessage = "";
		int returnCode = -1;
		for (int i = 0; i < procedureResponseParams.size(); i++) {
			if (procedureResponseParams.get(i).getName().equals("@o_return")) {
				returnCode = Integer.parseInt(procedureResponseParams.get(i).getValue());
				hasReturnCode = true;
				break;
			}
		}
		for (int i = 0; i < procedureResponseParams.size(); i++) {
			if (procedureResponseParams.get(i).getName().equals("@o_message")) {
				returnMessage = procedureResponseParams.get(i).getValue();
				procedureResponseParams.remove(i);
				hasReturnMessage = true;
				break;
			}
		}
		if (!hasReturnCode || !hasReturnMessage) {
			return true;
		}
		if (returnCode == 0) {
			// VALIDA QUE LA INFORMACION DEVUENTA SEA CORRECTA
			DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder;
			Document doc;
			try {
				docBuilder = docBuilderFactory.newDocumentBuilder();
				doc = docBuilder.parse(new InputSource(new StringReader(returnMessage)));
			} catch (ParserConfigurationException e) {
				logger.logDebug(" --> Infocred XML - MAL FORMADO - ParserConfigurationException = \n" + returnMessage, e);
				wGetReportResp.addMessage(80000, "Error Infocred - XML MAL FORMADO - ParserConfigurationException");
				return true;
			} catch (SAXException e) {
				logger.logDebug(" --> Infocred XML - MAL FORMADO - SAXException = \n" + returnMessage, e);
				wGetReportResp.addMessage(80000, "Error Infocred - XML MAL FORMADO - SAXException");
				return true;
			} catch (IOException e) {
				logger.logDebug(" --> Infocred XML - MAL FORMADO - IOException = \n" + returnMessage, e);
				wGetReportResp.addMessage(80000, "Error Infocred - XML MAL FORMADO - IOException");
				return true;
			}
			doc.getDocumentElement().normalize();
			Element element = doc.getDocumentElement();
			// INICIA LA VALIDACION
			if (element.getNodeName().equals("titular") && element.getAttribute("estado").equals("Titular inexistente.")) {
				// es cuando el XM de respuesta tiene esta estructura
				// <?xml version="1.0" encoding="ISO-8859-1"?>
				// <titular estado="Titular inexistente.">
				logger.logDebug(" --> Infocred XML - ERROR VALIDACION - Titular inexistente, no se encontro el reporte INFOCRED del cliente con la información proporcionada");
				wGetReportResp.addMessage(2101112, "Titular inexistente, no se encontro el reporte INFOCRED del cliente con la información proporcionada");
				return true;
			} else if (element.getNodeName().equals("titulares")) {
				// es cuando el XM de respuesta tiene esta estructura
				// <?xml version="1.0" encoding="ISO-8859-1"?>
				// <titulares>
				// <titular ..... />
				// <titular ..... />
				// </titulares>
				logger.logDebug(" --> Infocred XML - ERROR VALIDACION - Existen varios titulares que coinciden con la misma identificación, debe seleccionar solo uno de ellos");
				// Mando el XML como parte del mensaje de repuesta para poder obtener los clientes candidatos en el FrontEnd
				wGetReportResp.addMessage(2101113, returnMessage);// "BUSIN.DLB_BUSIN_OODTENRSO_32928"
				return true;
			}
			// SI PASO TODAS LAS VALIDACIONES GUARDA EN LA BBDD
			byte[] xmlByte = ZipUnzip.serializeObject(returnMessage);
			String strAux = ByteConverter.tranformToHex(xmlByte);
			aBagSPJavaOrchestration.put("xmlInfocred", strAux);

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
	public IProcedureResponse processResponse(IProcedureRequest originalRequest, java.util.Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(originalRequest));
		String[] wAllProcedureResponse = { "wGetReportResp", "wInsertReportResp", "wDataForInfocredResp" };
		cisResponseHelper.addOutputParamsResponse(wProcedureRespFinal, originalRequest, wAllProcedureResponse, aBagSPJavaOrchestration);
		cisResponseHelper.addResultsetsResponse(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);

		IProcedureResponse wProcedureRespDataForInfocred = (IProcedureResponse) aBagSPJavaOrchestration.get("wDataForInfocredResp");
		if (wProcedureRespDataForInfocred != null && wProcedureRespDataForInfocred.getMessageListSize() != 0) {
			cisResponseHelper.addMessages(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		IProcedureResponse wProcedureRespGetReport = (IProcedureResponse) aBagSPJavaOrchestration.get("wGetReportResp");
		if (wProcedureRespGetReport != null && wProcedureRespGetReport.getMessageListSize() != 0) {
			cisResponseHelper.addMessages(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		IProcedureResponse wProcedureRespInsertEmployee = (IProcedureResponse) aBagSPJavaOrchestration.get("wInsertReportResp");
		if (wProcedureRespInsertEmployee != null && wProcedureRespInsertEmployee.getMessageListSize() != 0) {
			cisResponseHelper.addMessages(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		return wProcedureRespFinal;
	}
}