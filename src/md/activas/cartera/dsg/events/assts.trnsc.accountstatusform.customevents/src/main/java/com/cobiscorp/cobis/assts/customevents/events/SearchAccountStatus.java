package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.AccountStatusResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.AccountStatus;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchAccountStatus extends BaseEvent implements com.cobiscorp.designer.api.customization.IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchAccountStatus.class);

	public SearchAccountStatus(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia executeCommand SearchPrecancellation");
		}

		try {
			args.setSuccess(true);
			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response = null;
			DataEntity clientID = entities.getEntity(Loan.ENTITY_NAME);
			//DataEntity accountStatus = entities.getEntity(AccountStatus.ENTITY_NAME);

			LoanRequest loanRequest = new LoanRequest();
			if(clientID.get(Loan.CLIENTID) != null){
				loanRequest.setClient(clientID.get(Loan.CLIENTID));
			}
			if(clientID.get(Loan.FEEENDDATE) != null){
				loanRequest.setExpirationFeeDate(GeneralFunction.convertDateToCalendar(clientID.get(Loan.FEEENDDATE)));
			}
			request.addValue("inLoanRequest", loanRequest);
			response = this.execute(getServiceIntegration(), LOGGER, Parameter.SEARCHACCOUTSTATUS, request);
			DataEntityList accountStatusList = new DataEntityList();
			
			LOGGER.logDebug("Resultado isResult() ---" + response.isResult());
			
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {

					AccountStatusResponse[] precancellationResponse = (AccountStatusResponse[]) resultado.getValue(Parameter.ACCOUNT_RESPONSE);
					
					LOGGER.logDebug("addresses ---" + precancellationResponse);
					for (AccountStatusResponse resp : precancellationResponse) {
						DataEntity businessEntity = new DataEntity();
						
						Date dateTmp = null;
						SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
						
						
						businessEntity.set(AccountStatus.CLIENTID, resp.getClientId());
						LOGGER.logDebug("businessList PoupForm Code>>" + resp.getClientId());
						businessEntity.set(AccountStatus.CLIENTNAME, resp.getClientName());
						businessEntity.set(AccountStatus.BANKNUMBER, resp.getBankNumber());
						businessEntity.set(AccountStatus.GROUPNAME, resp.getGroupName());
						businessEntity.set(AccountStatus.EMAIL, resp.getEmail());
						businessEntity.set(AccountStatus.TOPRINT, false);
						
						LOGGER.logDebug("Inicia executeCommand - resp.getEmail():"+resp.getEmail());
						
						if (resp.getDate() != null) {
							dateTmp = formatDate.parse(resp.getDate());
						}
						
						businessEntity.set(AccountStatus.DATE, dateTmp);
						
						accountStatusList.add(businessEntity);
					}
					LOGGER.logDebug("businessList PoupForm Size>>" + accountStatusList.size());
					entities.setEntityList(AccountStatus.ENTITY_NAME, accountStatusList);
					
				}
			} else {
				args.setSuccess(false);
				args.getMessageManager().showErrorMsg("ASSTS.LBL_ASSTS_NOSEENCNN_41118");
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Assets.SEARCH_PRECANCELATION, e, args, LOGGER);
		}

	}

}
