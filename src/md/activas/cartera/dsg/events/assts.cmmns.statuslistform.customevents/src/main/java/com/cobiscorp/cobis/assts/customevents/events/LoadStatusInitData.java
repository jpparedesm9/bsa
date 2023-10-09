package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanStatusChange;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class LoadStatusInitData extends BaseEvent implements IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoadStatusInitData.class);

	public LoadStatusInitData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity loan = arg0.getEntity(Loan.ENTITY_NAME);
		DataEntityList statusList = new DataEntityList();

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setApplicationType('M');
		loanRequest.setQuotaType(loan.get(Loan.OPERATIONTYPEID));
		loanRequest.setTermType(loan.get(Loan.STATUS));

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
				DataEntity item = new DataEntity();

				item.set(LoanStatusChange.NEWSTATUS, r.getDescription());
				item.set(LoanStatusChange.CURRENTSTATUS, r.getDescription());
				statusList.add(item);
			}
			arg0.setEntityList(LoanStatusChange.ENTITY_NAME, statusList);
		}
		arg1.setSuccess(true);

	}

}
