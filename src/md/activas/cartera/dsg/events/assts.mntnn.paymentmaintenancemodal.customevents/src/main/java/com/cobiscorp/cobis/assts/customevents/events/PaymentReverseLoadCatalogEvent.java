package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ListProductCredictRequest;
import cobiscorp.ecobis.assets.cloud.dto.ListProductCredictResponse;
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

public class PaymentReverseLoadCatalogEvent extends BaseEvent implements
		ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(CategoryProductsLoadCatalogEvent.class);

	public PaymentReverseLoadCatalogEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		
		ServiceRequestTO request = new ServiceRequestTO();
		List<ItemDTO> paymentReverseList = new ArrayList<ItemDTO>();
				
		ListProductCredictRequest listProductCredictRequest = new ListProductCredictRequest();
		listProductCredictRequest.setType(6);
		listProductCredictRequest.setOperation('A');
		listProductCredictRequest.setCurrency(0);
		request.addValue("inListProductCredictRequest",
				listProductCredictRequest);

		ServiceResponse response = this
				.execute(getServiceIntegration(), logger,
						"Loan.LoanMaintenance.QueryListProductCredict", request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			ListProductCredictResponse[] clResponse = (ListProductCredictResponse[]) resultado
					.getValue("returnListProductCredictResponse");
			for (ListProductCredictResponse r : clResponse) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Cargando item: " + r.getProduct());
				}
				ItemDTO item = new ItemDTO();

				item.setCode(r.getProduct());
				item.setValue(r.getDescription());
				paymentReverseList.add(item);

			}
		}

		arg1.setSuccess(true);
		return paymentReverseList;
	}

}
