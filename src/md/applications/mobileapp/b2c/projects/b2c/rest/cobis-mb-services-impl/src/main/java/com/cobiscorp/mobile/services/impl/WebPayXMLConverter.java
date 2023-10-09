package com.cobiscorp.mobile.services.impl;

import java.io.StringWriter;
import java.math.BigDecimal;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.dto.BusinessType;
import com.cobiscorp.mobile.dto.DataType;
import com.cobiscorp.mobile.dto.DatosAdicionalesType;
import com.cobiscorp.mobile.dto.PType;
import com.cobiscorp.mobile.dto.UrlType;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.ElavonRequest;

/**
 * Created by portiz on 13/01/2020.
 */
public class WebPayXMLConverter extends ServiceBase {

	private static ILogger LOGGER = LogFactory.getLogger(WebPayXMLConverter.class);
	private static final String className = "[WebPayXMLConverter]";

	public static String buildXML(ElavonRequest elavonRequest, ICTSServiceIntegration serviceIntegration, String cobisSessionId) throws MobileServiceException, JAXBException {
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);
		ParameterSearchResponse simularXML = parameterService.searchParameter("WPPSIM", "CLI", cobisSessionId);
		PType p = new PType();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + "Parametro de simularXML: " + simularXML.getTinyintValue());
		}
		if (simularXML.getTinyintValue() == 2) {
			throw new MobileServiceException("Los pagos por WebPay Plus se encuentran desactivados.");
		}
		if (simularXML.getTinyintValue() == 1) {
			p = simulatorXML();
		} else {
			BusinessType business = new BusinessType();
			UrlType url = new UrlType();
			DatosAdicionalesType datosAdicionales = new DatosAdicionalesType();

			ParameterSearchResponse companyElavon = parameterService.searchParameter("WPPCOM", "CLI", cobisSessionId);
			ParameterSearchResponse branchElavon = parameterService.searchParameter("WPPBRN", "CLI", cobisSessionId);
			ParameterSearchResponse userElavon = parameterService.searchParameter("WPPUSR", "CLI", cobisSessionId);
			ParameterSearchResponse passwordElavon = parameterService.searchParameter("WPPPWD", "CLI", cobisSessionId);
			ParameterSearchResponse canalElavon = parameterService.searchParameter("WPPCAN", "CLI", cobisSessionId);
			ParameterSearchResponse sendNotification = parameterService.searchParameter("WPPEVN", "CLI", cobisSessionId);
			ParameterSearchResponse requestEmail = parameterService.searchParameter("WPPSOC", "CLI", cobisSessionId);
			ParameterSearchResponse automaticEnrolment = parameterService.searchParameter("WPPENA", "CLI", cobisSessionId);

			business.setIdCompany(companyElavon.getCharValue());
			business.setIdBranch(branchElavon.getCharValue());
			business.setUser(userElavon.getCharValue());
			business.setPwd(passwordElavon.getCharValue());

			DataType dataType = new DataType();
			dataType.setId(1);
			dataType.setDisplay(true);
			dataType.setLabel("PRESTAMO");
			dataType.setValue(elavonRequest.getLoanId());
			datosAdicionales.getData().add(dataType);

			url.setDatosAdicionales(datosAdicionales);

			url.setReference(elavonRequest.getReference());
			url.setAmount(new BigDecimal(elavonRequest.getAmount()));
			url.setMoneda(elavonRequest.getMoneda());
			url.setCanal(canalElavon.getCharValue());
			url.setOmitirNotifDefault(String.valueOf(sendNotification.getTinyintValue()));
			url.setStCorreo(String.valueOf(requestEmail.getTinyintValue()));
			url.setFhVigencia(elavonRequest.getFechaVigencia());
			url.setMailCliente(elavonRequest.getEmail());
			
			url.setDatosAdicionales(datosAdicionales);

			p.setBusiness(business);
			p.setUrl(url);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + " Transformar DTO a XML ");
		}
		JAXBElement<PType> elem = new JAXBElement<PType>(new QName("", "P"), PType.class, p);
		JAXBContext jaxbContext = JAXBContext.newInstance(PType.class);
		Marshaller marshaller = jaxbContext.createMarshaller();
		StringWriter sw = new StringWriter();
		marshaller.marshal(elem, sw);

		String xmlRequest = sw.toString();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + " xmlRequest: " + xmlRequest);
		}
		return xmlRequest;
	}

	public static PType simulatorXML() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + " Inicia Similacion de objeto");
		}
		/* SIMULACION */
		PType p = new PType();
		BusinessType businessType = new BusinessType();
		UrlType urlType = new UrlType();
		DatosAdicionalesType adicionalesType = new DatosAdicionalesType();
		DataType dataType = new DataType();

		businessType.setIdCompany("SNBX");
		businessType.setIdBranch("01SNBXBRNCH");
		businessType.setUser("SNBXUSR01");
		businessType.setPwd("SECRETO");

		urlType.setReference("FACTURA999");
		urlType.setAmount(new BigDecimal(2500.00));
		urlType.setMoneda("MXN");
		urlType.setCanal("W");
		urlType.setOmitirNotifDefault("1");
		urlType.setStCorreo("1");
		urlType.setFhVigencia(null);
		urlType.setMailCliente("nospam@gmail.com");
		urlType.setStCr("A");

		dataType.setId(1);
		dataType.setDisplay(false);
		dataType.setLabel("PRINCIPAL");
		dataType.setValue("ID_DE_TU_CLIENTE");
		adicionalesType.getData().add(dataType);

		urlType.setDatosAdicionales(adicionalesType);

		p.setBusiness(businessType);
		p.setUrl(urlType);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + "Termina simulación de Objeto: " + p.toString());
		}

		return p;
	}

}
