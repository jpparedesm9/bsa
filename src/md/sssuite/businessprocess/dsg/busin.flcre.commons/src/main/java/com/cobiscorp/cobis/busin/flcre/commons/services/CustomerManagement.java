package com.cobiscorp.cobis.busin.flcre.commons.services;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Outputs;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.businessprocess.customers.dto.Customer;
import cobiscorp.ecobis.businessprocess.customers.dto.CustomerResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

public class CustomerManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(CustomerManagement.class);

	public CustomerManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public char getEntailmentCustomer(Integer customerId) {
		if (logger.isDebugEnabled())
			logger.logDebug("--->>CustomerManagement--Ingreso");
		Customer customer = new Customer();

		if (customerId != null) {
			customer.setCustomerId(customerId);

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put(RequestName.INCUSTOMER, customer);

			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYENTAILMENTCUSTOMER, serviceRequestTO);

			if (serviceResponse != null && serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("--->>CustomerManagement--serviceResponse");

				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

				CustomerResponse customerResponse = (CustomerResponse) serviceResponseTO.getValue(ReturnName.RETURNCUSTOMER);

				if (customerResponse != null) {
					logger.logDebug("customerResponse.getCustomerEntailment()" + customerResponse.getCustomerEntailment());
					return customerResponse.getCustomerEntailment() == null ? 'N' : customerResponse.getCustomerEntailment().charValue();
				}
			}
		}
		return '\0';
	}

	// SRO. Obtener Ciclo Cliente - CAME
	public Integer getCustomerCycleNumber(Integer customerId, ICommonEventArgs args) throws Exception {
		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setCustomerId(customerId);
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.INCUSTOMERREQUEST, customerRequest, ServiceId.SERVICEGETCUSTOMERCYCLENUMBER, Outputs.OUTRESULTADO, args);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

	public void updateCustomer(CustomerTotalRequest customerTotalRequest) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		customerTotalRequest.setOperation('M');
		logger.logDebug("customerOperation-->" + customerTotalRequest.getOperation());
		logger.logDebug("customerNivel-->" + customerTotalRequest.getCollectiveLevel());
		logger.logDebug("customerIngresos-->" + customerTotalRequest.getOtherIncome().toString());
		serviceRequestTO.addValue("inCustomerTotalRequest", customerTotalRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATECUSTOMER, serviceRequestTO);

		if (serviceResponse == null && !serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("--->>CustomerManagement--serviceResponse");
		}
	}
}
