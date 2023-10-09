package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.HpCatalogRequest;
import cobiscorp.ecobis.assets.cloud.dto.HpCatalogResponse;
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

public class ProducCobisLoadCatalogEvents extends BaseEvent implements
		ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(CategoryProductsLoadCatalogEvent.class);

	public ProducCobisLoadCatalogEvents(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {

		ServiceRequestTO request = new ServiceRequestTO();
		List<ItemDTO> producCobisList = new ArrayList<ItemDTO>();

		HpCatalogRequest hpCatalogRequest = new HpCatalogRequest();
		hpCatalogRequest.setType('A');

		request.addValue("inHpCatalogRequest", hpCatalogRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, "Loan.GeneralInfo.CatalogHpA", request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			HpCatalogResponse[] clResponse = (HpCatalogResponse[]) resultado
					.getValue("returnHpCatalogResponse");
			for (HpCatalogResponse r : clResponse) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Cargando item: " + r.getValue());
				}
				ItemDTO item = new ItemDTO();

				item.setCode(r.getCode());
				item.setValue(r.getValue());
				producCobisList.add(item);

			}
		}

		arg1.setSuccess(true);
		return producCobisList;
	}

}
