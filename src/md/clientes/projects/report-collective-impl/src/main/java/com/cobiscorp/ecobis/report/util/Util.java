package com.cobiscorp.ecobis.report.util;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.clientviewer.report.dto.AdvisorReportDto;

import cobiscorp.ecobis.collective.dto.AdvisorExternalResponse;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class Util {
	/**
	 * formatea la fecha al de Panam�
	 * 
	 * @param Date
	 * @return String
	 */

	private static final ILogger logger = LogFactory.getLogger(Util.class);

	public static String obtenerFecha(Date date) {
		DateFormat df;
		df = DateFormat.getDateInstance(DateFormat.LONG, Locale.ENGLISH);
		String f = df.format(date);
		return f;
	}

	/**
	 * 
	 * @param request
	 * @return
	 */

	public static List<AdvisorReportDto> loadHistoryDataClient(HttpServletRequest request) {
		ServiceResponse serviceResponse = (ServiceResponse) request.getSession().getAttribute(Constants.LISTA_ASESOR_EXTERNO_DATA);

		logger.logDebug("request.getSession().getAttributeNames())0" + request.getSession().getAttribute(Constants.LISTA_ASESOR_EXTERNO_DATA));
		Map<Object, Object> mapSession = (HashMap<Object, Object>) request.getSession().getAttribute("cobis-session");
		AdvisorExternalResponse[] advisorExternalResponse = (AdvisorExternalResponse[]) mapSession.get(Constants.LISTA_ASESOR_EXTERNO_DATA);
		List<AdvisorReportDto> advisorReports = new ArrayList<AdvisorReportDto>();
		for (AdvisorExternalResponse advisorExternal : advisorExternalResponse) {
			if (advisorExternal != null) {
				advisorReports.add(mapSGDTOtoDTO(advisorExternal));
			}
		}

		logger.logDebug("request.getSession().getAttributeNames())0" + request.getSession().getAttribute("user"));
		logger.logDebug("request.getSession().getAttributeNames())a" + request.getSession().getAttribute(".freemarker.Session"));
		logger.logDebug("request.getSession().getAttributeNames())b" + request.getSession().getAttribute("cobis-authenticated"));
		logger.logDebug("request.getSession().getAttributeNames())c" + request.getSession().getAttribute("cobis-session"));
		logger.logDebug("request.getSession().getAttributeNames())d" + request.getSession().getAttribute("cobis-session-id"));

		return advisorReports;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	public static JRBeanCollectionDataSource getDataSourceCollection( List<AdvisorReportDto> advisorExternalResponses, String typeReport, String dateFormatPattern) {
		JRBeanCollectionDataSource beanColDataSource = null;
		if (typeReport != null && typeReport.equalsIgnoreCase(Constants.LISTA_ASESOR_EXTERNO_DATA_HIST)) {
			// List<AdvisorExternalResponse> advisorExternalResponselist =
			// Arrays.asList(advisorExternalResponses);
			logger.logDebug("beanColDataSource 1");
			beanColDataSource = new JRBeanCollectionDataSource(advisorExternalResponses);
		}
		for (int i=0;i<advisorExternalResponses.size();i++)
		{
			logger.logDebug("antes del data suource"+advisorExternalResponses.get(i).getCustomerName());
			logger.logDebug("antes del data suource1"+advisorExternalResponses.get(i).getCustomerCell());
			logger.logDebug("antes del data suource3"+advisorExternalResponses.get(i).getEmail());
		}
		
		logger.logDebug("beanColDataSource 2");
		beanColDataSource = new JRBeanCollectionDataSource(advisorExternalResponses);
		return beanColDataSource;

	}

	public static String getDirectory() {
		return COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE) + Constants.DIR_JASPER;

	}

	public static AdvisorReportDto mapSGDTOtoDTO(AdvisorExternalResponse advisorExternalResponse) {

		AdvisorReportDto advisorReportDto = null;

		advisorReportDto = new AdvisorReportDto();
		advisorReportDto.setAsesorExterno(advisorExternalResponse.getAsesorExterno()!=null ? advisorExternalResponse.getAsesorExterno() :"");
		advisorReportDto.setCollective(advisorExternalResponse.getCollective());
		advisorReportDto.setCustomerAddress(advisorExternalResponse.getCustumerAddress());
		advisorReportDto.setCustomerCell(advisorExternalResponse.getCustomerCell());
		advisorReportDto.setCustomerName(advisorExternalResponse.getCustomerName());
		advisorReportDto.setEmail(advisorExternalResponse.getEmail());
		advisorReportDto.setCustomerId(advisorExternalResponse.getCustomerId());

		return advisorReportDto;

	}
	
	@SuppressWarnings("unchecked")
	public void error(ServiceResponseTO serviceResponseTO) {

		if (!serviceResponseTO.isSuccess()) {
			List<MessageTO> errorMessages = serviceResponseTO.getMessages();
			for (MessageTO message : errorMessages) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Mensaje  -  Codigo: " + message.getCode() + ", Detalle:" + message.getMessage());
				}
			}
		}
	}

}
