package com.cobiscorp.ecobis.external.services.bl.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.internetbanking.webapp.admin.dto.Customer;
import cobiscorp.ecobis.internetbanking.webapp.admin.dto.CustomerLinked;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class ContractInformationHisImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(ContractInformationHisImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		logger.logDebug("Starts execute in ContractInformationHisImpl");
		List<SummaryOtherDTO> others = new ArrayList<SummaryOtherDTO>();
		try {
			List<CustomerLinked> contractsInformation = getContractInformationByCustomer((Integer) values[0]);

			for (CustomerLinked customerLinked : contractsInformation) {
				SummaryOtherDTO summaryOther = new SummaryOtherDTO();
				summaryOther.setDateAPRRegistry(customerLinked.getLinkedDate() == null ? new Date() : customerLinked.getLinkedDate().getTime());
				summaryOther.setOperationType(customerLinked.getLinked());
				summaryOther.setOperationTypeDescription(customerLinked.getLinkedMessage());
				summaryOther.setOffice(customerLinked.getLinkedOffice());
				others.add(summaryOther);
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);
			throw new BusinessException(7300035, "Ocurrió un error al realizar la consulta del histórico de vinculación del Cliente");
		} finally {
			logger.logDebug("Finish execute in ContractInformationHisImpl");
		}
		return others;
	}

	private List<CustomerLinked> getContractInformationByCustomer(Integer customer) {
		try {
			logger.logInfo("Ejecuta Consulta de vinculacion del Cliente");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
			ServiceResponse serviceResponse = null;
			Customer customerDTO = new Customer();
			CustomerLinked customerLinked = new CustomerLinked();
			List<CustomerLinked> lstCustomerLinked = new ArrayList<CustomerLinked>();
			customerDTO.setEntityId(customer.intValue());
			serviceRequestTO.getData().put("inCustomer", customerDTO);
			serviceResponse = execute(this.serviceIntegration, logger, "InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation", serviceRequestTO);

			serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			Map<String, String> processesResponse = (Map<String, String>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			for (Object iterador : serviceResponseTO.getData().keySet()) {
				logger.logInfo("objetos : " + iterador);
			}

			if (processesResponse.get("@o_vinculado") != null) {
				Object value = serviceResponseTO.getData().values().iterator().next();
				logger.logInfo("objeto encontrado : " + value);
				String linked = processesResponse.get("@o_vinculado").toString();
				if (linked.equals("V")) {
					customerLinked.setLinked(linked);
					if (processesResponse.get("@o_sucursal") != null) {
						String linkedOffice = processesResponse.get("@o_sucursal").toString();
						customerLinked.setLinkedOffice(linkedOffice);
					}
					if (processesResponse.get("@o_fecha_vinculacion") != null) {
						SimpleDateFormat formatter = new SimpleDateFormat("MMM dd yyyy HH:mma", Locale.ENGLISH);
						Calendar linkedDate = Calendar.getInstance();
						linkedDate.setTime(formatter.parse(processesResponse.get("@o_fecha_vinculacion")));
						customerLinked.setLinkedDate(linkedDate);
					}
					if (processesResponse.get("@o_mensaje_asociado") != null) {
						String linkedMessage = processesResponse.get("@o_mensaje_asociado").toString();
						customerLinked.setLinkedMessage(linkedMessage);
					}
					lstCustomerLinked.add(customerLinked);
				}

			}
			return lstCustomerLinked;
		} catch (Exception e) {
			logger.logDebug(e);
			logger.logError("Ocurrió un error al realizar la consulta del histórico de vinculación del Cliente");
			return new ArrayList<CustomerLinked>();
		} finally {
			logger.logDebug("Finaliza Consulta de vinculacion del Cliente");
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
