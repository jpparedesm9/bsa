package com.cobiscorp.mobile.services.impl;

import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Address;
import com.cobiscorp.mobile.model.AddressResponse;
import com.cobiscorp.mobile.model.Customer;
import com.cobiscorp.mobile.service.interfaces.ICustomerService;
import com.cobiscorp.mobile.services.impl.utils.Constants;
import com.cobiscorp.mobile.services.impl.utils.Utils;

import cobiscorp.ecobis.businesstoconsumer.dto.CustomerRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ ICustomerService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class CustomerServiceImpl extends ServiceBase implements ICustomerService {
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger LOGGER = LogFactory.getLogger(CustomerServiceImpl.class);
	private static final String className = "[CustomerServiceImpl]";

	@Override
	public void updateProspect(Customer customer, String cobisSessionId) throws MobileServiceException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Starting updateProspect method in class " + className);

		try {
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inCustomerRequest", Utils.getCustomerRequest(customer));

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, Constants.SERV_UPDATE_PROSPECT,
					cobisSessionId, serviceRequest);

			if (serviceResponseTO == null) {
				manageResponseError(serviceResponseTO, LOGGER);
			} else if (serviceResponseTO != null && !serviceResponseTO.isSuccess()) {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Logging error of updateProspect method in class " + className, e);
			throw new MobileServiceException(e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("Finishing updateProspecT method in class " + className);
		}

	}

	@Override
	public AddressResponse createAddress(Address address, String cobisSessionId) throws MobileServiceException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Starting createAddress method in class " + className);
		
		AddressResponse addressResponse = new AddressResponse();
		try {
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inAddressRequest", Utils.getAddressRequest(address));

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, Constants.SERV_CREATE_ADDRESS,
					cobisSessionId, serviceRequest);

			if (serviceResponseTO == null) {
				manageResponseError(serviceResponseTO, LOGGER);
			} else {
				if (serviceResponseTO.isSuccess()) {
					Map<String, Object> customerResponse = (Map<String, Object>) serviceResponseTO
							.getValue("com.cobiscorp.cobis.cts.service.response.output");
					addressResponse.setAddressId(
							Integer.parseInt(Utils.getOutputs(customerResponse, "@o_direccion").toString()));
					addressResponse.setCustomerId(address.getCustomerId());
					return addressResponse;

				} else {
					manageResponseError(serviceResponseTO, LOGGER);
				}
			}

			return addressResponse;
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Logging error of createAddress method in class " + className, e);
			throw new MobileServiceException(e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("Finishing createAddress method in class " + className);
		}

	}

	@Override
	public String getCurpByCustomerId(Integer customerId, String cobisSessionId) throws MobileServiceException {

		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Starting getCurpByCustomerId method in class " + className);

		try {
			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setId(customerId);

			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inCustomerRequest", customerRequest);

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, Constants.SERV_SEARCH_CUSTOMER,
					cobisSessionId, serviceRequest);

			if (serviceResponseTO == null) {
				manageResponseError(serviceResponseTO, LOGGER);
			} else {
				if (serviceResponseTO.isSuccess()) {
					Map<String, Object> customerResponse = (Map<String, Object>) serviceResponseTO
							.getValue("com.cobiscorp.cobis.cts.service.response.output");
					return Utils.getOutputs(customerResponse, "@o_curp").toString();

				} else {
					manageResponseError(serviceResponseTO, LOGGER);
				}
			}

		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Logging error of getCurpByCustomerId method in class " + className, e);
			throw new MobileServiceException(e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("Finishing getCurpByCustomerId method in class " + className);
		}

		return null;

	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
