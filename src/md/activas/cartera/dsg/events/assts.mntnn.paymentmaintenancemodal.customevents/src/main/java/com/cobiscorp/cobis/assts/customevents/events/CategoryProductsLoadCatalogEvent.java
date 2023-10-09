package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.PaidCategoryRequest;
import cobiscorp.ecobis.assets.cloud.dto.PaidCategoryResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CategoryProductsLoadCatalogEvent extends BaseEvent implements
ILoadCatalog{
	private static final ILogger logger = LogFactory
			.getLogger(CategoryProductsLoadCatalogEvent.class);

	public CategoryProductsLoadCatalogEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
	
		ServiceRequestTO request = new ServiceRequestTO();
		List<ItemDTO> paidCategoryList = new ArrayList<ItemDTO>();
				
		PaidCategoryRequest paidCategoryRequest = new PaidCategoryRequest();
		paidCategoryRequest.setMode(0);

		request.addValue("inPaidCategoryRequest", paidCategoryRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, "Loan.LoanMaintenance.PaidCategory", request);
		
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			PaidCategoryResponse[] clResponse = (PaidCategoryResponse[]) resultado
					.getValue("returnPaidCategoryResponse");
			for (PaidCategoryResponse r : clResponse) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Cargando item: " + r.getDescription());
				}
				ItemDTO item = new ItemDTO();

				item.setCode (r.getDescription());
				item.setValue(r.getDescription());
				
				paidCategoryList.add(item);

			}
		}
		
				
		arg1.setSuccess(true);
		return paidCategoryList;
	}

}
