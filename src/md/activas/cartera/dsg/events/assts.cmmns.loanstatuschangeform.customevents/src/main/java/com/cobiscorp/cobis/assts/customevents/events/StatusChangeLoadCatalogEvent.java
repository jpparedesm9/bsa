package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class StatusChangeLoadCatalogEvent extends BaseEvent implements
		ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(StatusChangeLoadCatalogEvent.class);

	public StatusChangeLoadCatalogEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		ServiceRequestTO request = new ServiceRequestTO();
		List<ItemDTO> statusList = new ArrayList<ItemDTO>();

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setApplicationType('M');
		loanRequest.setQuotaType("CLIENT1A");
		loanRequest.setTermType("VIGENTE");

		request.addValue("inLoanRequest", loanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger,
				"Loan.Queries.GetStatesLoan", request);

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

				item.setCode(r.getDescription());
				item.setValue(r.getDescription());
				statusList.add(item);

			}
		}
		arg1.setSuccess(true);
		return statusList;

	}

}
