package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ItemResponse;
import cobiscorp.ecobis.loan.dto.LoanRequest;

import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.model.ConsultationDisbursementForms;
import com.cobiscorp.cobis.busin.model.DisbursementForms;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataBursementForm extends BaseEvent implements IInitDataEvent {
	private final static String INLOANREQUEST = "inLoanRequest";
	private final static String RETURNITEMRESPONSE = "returnItemResponse";
	private final static String SERVICESEARCHLOANITEMSTMP = "Loan.LoansQueries.SearchLoanItemsTmp";
	private final static Integer TYPE = 1;
	private static ILogger LOGGER = LogFactory.getLogger(InitDataBursementForm.class);

	public InitDataBursementForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		try{
			DataEntity parameterDisbursementForms = entities.getEntity(DisbursementForms.ENTITY_NAME);
			DataEntityList consDisbursementFormsEntity = new DataEntityList();

			LoanRequest loanRequest = new LoanRequest();
			loanRequest.setCurrencyOP(Integer.parseInt(parameterDisbursementForms.get(DisbursementForms.CURRENCY)));
			loanRequest.setType(TYPE);

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put(INLOANREQUEST, loanRequest);
			ServiceResponse serviceResponse = null;
			serviceResponse = execute(getServiceIntegration(), LOGGER, SERVICESEARCHLOANITEMSTMP, serviceRequestTO);
			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceDisbursementResponseTO = new ServiceResponseTO();
				serviceDisbursementResponseTO = (ServiceResponseTO) serviceResponse.getData();
				ItemResponse[] returnItemResponse = (ItemResponse[]) serviceDisbursementResponseTO.getValue(RETURNITEMRESPONSE);

				for (ItemResponse itemResponse : returnItemResponse) {
					DataEntity eItem = new DataEntity();
					if (itemResponse.getProduct() != null) {
						eItem.set(ConsultationDisbursementForms.PRODUCT, itemResponse.getProduct());
						parameterDisbursementForms.set(DisbursementForms.OBSERVATIONS, itemResponse.getProduct());
					} else {
						eItem.set(ConsultationDisbursementForms.PRODUCT, "");
					}

					eItem.set(ConsultationDisbursementForms.DESCRIPTION, Convert.StringToString(itemResponse.getDescription(), ""));

					if (itemResponse.getRetention() != null) {
						eItem.set(ConsultationDisbursementForms.RETENTION, itemResponse.getRetention());
					} else {
						eItem.set(ConsultationDisbursementForms.RETENTION, 0);
					}

					if (itemResponse.getCobisProduct() != null) {
						eItem.set(ConsultationDisbursementForms.COBISPRODUCT, itemResponse.getCobisProduct());
					} else {
						eItem.set(ConsultationDisbursementForms.COBISPRODUCT, 0);
					}

					eItem.set(ConsultationDisbursementForms.AUTOMATICPAYMENT, Convert.StringToString(itemResponse.getAutomaticPayment(), ""));

					consDisbursementFormsEntity.add(eItem);
				}
				entities.setEntityList(ConsultationDisbursementForms.ENTITY_NAME, consDisbursementFormsEntity);
			} else {
				List<Message> errorMessage = new ArrayList<Message>();
				errorMessage = serviceResponse.getMessages();
				for (Message message : errorMessage) {
					arg1.getMessageManager().showErrorMsg(message.getMessage() + "/n");
				}
				return;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENT_INITDATA, e, arg1, LOGGER);
		}
	}

}
