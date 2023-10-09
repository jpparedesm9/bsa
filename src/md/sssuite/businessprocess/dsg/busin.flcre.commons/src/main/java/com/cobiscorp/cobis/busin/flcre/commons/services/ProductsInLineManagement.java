package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.creditfacility.dto.CreditLineProductsRequest;
import cobiscorp.ecobis.creditfacility.dto.CreditLineProductsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

/**
 * @author srojas
 *
 */
public class ProductsInLineManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ProductsInLineManagement.class);

	public ProductsInLineManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CreditLineProductsResponse[] getAvailableProductsInLine(String operacion, ICommonEventArgs arg1, BehaviorOption options) {

		CreditLineProductsRequest creditLineProductsRequest = new CreditLineProductsRequest();
		creditLineProductsRequest.setOperacion(operacion);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inCreditLineProductsRequest", creditLineProductsRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.DistributionLineServices.SearchAvailableProducts", serviceRequestTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (CreditLineProductsResponse[]) serviceResponseTO.getValue("returnCreditLineProductsResponse");
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
}