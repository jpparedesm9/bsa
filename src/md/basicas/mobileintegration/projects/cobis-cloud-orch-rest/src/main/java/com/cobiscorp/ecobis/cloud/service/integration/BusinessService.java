package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessResp;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessResult;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.Predicate;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import java.util.Arrays;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;

public class BusinessService extends RestServiceBase {

    private final ILogger logger = LogFactory.getLogger(BusinessService.class);

    public BusinessService(ICTSServiceIntegration integration) {
        super(integration);
    }

    public CustomerBusinessResp searchBusiness(int customerId, final int businessId) {
        CustomerBusinessResp[] business = executeSearchBusiness(customerId);
        if (business == null) {
            return null;
        }
        System.out.println("***** Business " + Arrays.toString(business));
        if(businessId == 0){
        	if(business.length == 0){
        		return null;
        	} else{
        		return business[0];
        	}
        } else {
        	return ArrayUtil.find(business, new Predicate<CustomerBusinessResp>() {
	            @Override
	            public boolean test(CustomerBusinessResp obj) {
	                return obj.getCode() == businessId;
	            }
	        });
        }
    }

    public BusinessResult createBusiness(CustomerBusinessRequest request) {
        ServiceRequestTO requestTo = new ServiceRequestTO();
        request.setChannel("B2B");
        requestTo.addValue("inCustomerBusinessRequest", request);
        ServiceResponse response = execute(
                "CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness",
                requestTo
        );
        return new BusinessResult(extractOutputValue(response, "@o_codigo", Integer.class), extractOutputValue(response, "@o_telefono_id", Integer.class));
    }

    public BusinessResult updateBusiness(CustomerBusinessRequest request) {
        ServiceRequestTO requestTo = new ServiceRequestTO();
        request.setChannel("B2B");
        requestTo.addValue("inCustomerBusinessRequest", request);
        ServiceResponse response = execute(
                "CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness",
                requestTo
        );
        return new BusinessResult(extractOutputValue(response, "@o_codigo", Integer.class), extractOutputValue(response, "@o_telefono_id", Integer.class));
    }

    private CustomerBusinessResp[] executeSearchBusiness(int customerId) {
        ServiceRequestTO requestTo = new ServiceRequestTO();
        CustomerBusinessRequest request = new CustomerBusinessRequest();
        request.setCustomerCode(customerId);
        requestTo.addValue("inCustomerBusinessRequest", request);
        ServiceResponse response = execute(
                "CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness",
                requestTo
        );
        return extractValue(response, "returnCustomerBusinessResp", CustomerBusinessResp[].class);
    }

}
