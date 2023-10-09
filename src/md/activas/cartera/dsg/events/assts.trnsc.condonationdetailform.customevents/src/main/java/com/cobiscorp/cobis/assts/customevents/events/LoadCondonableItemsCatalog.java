package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.ServerParameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class LoadCondonableItemsCatalog extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(LoadCondonableItemsCatalog.class);

	public LoadCondonableItemsCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		
		ServiceResponse response = null;
		ServiceRequestTO request = new ServiceRequestTO();
		
		DataEntity loan = arg0.getEntity(ServerParameter.ENTITY_NAME);
		List<ItemDTO> itemList = new ArrayList<ItemDTO>();
			
		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setOperation('R');
		loanRequest.setBank(loan.get(ServerParameter.LOANBANKID));
		
		request.addValue("inLoanRequest", loanRequest);
		response = this.execute(getServiceIntegration(), logger,
				"Loan.ProductListCredit.CondonableItemList", request);
		
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			ItemResponse[] clResponse = (ItemResponse[]) resultado
					.getValue("returnItemResponse");
			for (ItemResponse r : clResponse) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Cargando item: " + r.getDescription());
				}
				ItemDTO item = new ItemDTO();

				item.setCode(r.getProduct());
				item.setValue(r.getDescription());
				itemList.add(item);
			}
		}
		arg1.setSuccess(true);
		return itemList;
	}

}
