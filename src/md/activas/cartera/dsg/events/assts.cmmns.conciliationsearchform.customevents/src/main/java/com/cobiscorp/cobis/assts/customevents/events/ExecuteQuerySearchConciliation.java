package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.UploadConciliationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import cobiscorp.ecobis.assets.cloud.dto.UploadConciliationResponse;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ConciliationSearch;
import com.cobiscorp.cobis.assts.model.ConciliationSearchFilter;

public class ExecuteQuerySearchConciliation extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(ExecuteQuerySearchConciliation.class);

	public ExecuteQuerySearchConciliation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start executeDataEvent in ExecuteQuerySearchConciliation");
		}
		DataEntityList resultList = new DataEntityList();

		try {

			ServiceRequestTO request = new ServiceRequestTO();
			UploadConciliationRequest uploadConciliationRequest = new UploadConciliationRequest();
			Map<String, Object> conciliationSearchFilter = (Map<String, Object>) entities.getData();

			uploadConciliationRequest.setAmount(conciliationSearchFilter.get("amount") == null ? null : Double.valueOf(String.valueOf(conciliationSearchFilter.get("amount"))));

			uploadConciliationRequest.setCustomerCode(conciliationSearchFilter.get("customerCode") == null
					|| "".equals(String.valueOf(conciliationSearchFilter.get("customerCode")).trim()) ? null : Integer.valueOf(String.valueOf(conciliationSearchFilter
					.get("customerCode"))));
			uploadConciliationRequest.setCustomerType(conciliationSearchFilter.get("customerType") == null ? null : String.valueOf(conciliationSearchFilter.get("customerType"))
					.charAt(0));
			uploadConciliationRequest.setSinceDate(GeneralFunction.convertDateToCalendar(GeneralFunction.convertStringToDate(
					String.valueOf(conciliationSearchFilter.get("dateFrom")), Parameter.TYPEDATEFORMAT.MMDDYYYY)));
			uploadConciliationRequest.setUntilDate(GeneralFunction.convertDateToCalendar(GeneralFunction.convertStringToDate(
					String.valueOf(conciliationSearchFilter.get("dateUntil")), Parameter.TYPEDATEFORMAT.MMDDYYYY)));
			logger.logDebug("conciliationSearchFilter.get(type)" + conciliationSearchFilter.get("type"));
			uploadConciliationRequest.setType(conciliationSearchFilter.get("type") == null ? null : String.valueOf(conciliationSearchFilter.get("type")));
			uploadConciliationRequest.setNotConciliationReason(conciliationSearchFilter.get("notConciliationReason") == null ? null : String.valueOf(conciliationSearchFilter
					.get("notConciliationReason")));

			String conciliateStatus = null;
	
			if (String.valueOf(conciliationSearchFilter.get("conciliationStatus")).charAt(0) == 'T') {
				uploadConciliationRequest.setConciliationStatus(conciliateStatus);
			} else {
				
				conciliateStatus = String.valueOf(conciliationSearchFilter.get("conciliationStatus")).trim();
				logger.logDebug("conciliateStatus: "+conciliateStatus);
				uploadConciliationRequest.setConciliationStatus(conciliateStatus);
			}
			
			request.addValue("inUploadConciliationRequest", uploadConciliationRequest);
			ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.ConciliationManagement.SearchPaymentByFilter", request);

			if (response != null) {
				if (response.isResult()) {
					ServiceResponseTO responseTO = (ServiceResponseTO) response.getData();
					UploadConciliationResponse[] uploadConciliationResponses = (UploadConciliationResponse[]) responseTO.getValue("returnUploadConciliationResponse");

					for (UploadConciliationResponse result : uploadConciliationResponses) {
						DataEntity dataEntity = new DataEntity();
						dataEntity.set(ConciliationSearch.TYPE, result.getType());
						dataEntity.set(ConciliationSearch.CUSTOMERNAME, result.getCustomerName());
						dataEntity.set(ConciliationSearch.PAYMENTRECEIPTDATE, result.getPaymentReceiptDate() != null ? result.getPaymentReceiptDate().getTime() : null);
						dataEntity.set(ConciliationSearch.PAYMENTRECEIPTAMOUNT, result.getPaymentReceiptAmount());
						dataEntity.set(ConciliationSearch.PAYMENTSTATE, result.getStatus() == null ? '\0' : result.getStatus().charAt(0));
//						dataEntity.set(ConciliationSearch.UPLOADCONCILIATIONFILEDATE, result.getUploadConciliationFileDate() != null ? result.getUploadConciliationFileDate()
//								.getTime() : null);
						dataEntity.set(ConciliationSearch.CONCILIATE, result.getConciliateStatus()==null?null:String.valueOf(result.getConciliateStatus()));
//						dataEntity.set(ConciliationSearch.AMOUNTREPORTEDINFILE, result.getAmountReportedInFile());
						dataEntity.set(ConciliationSearch.NOTCONCILIATIONREASON, result.getNotConciliationReason());
						dataEntity.set(ConciliationSearch.CONCILIATIONDATE, result.getConciliationDate() != null ? result.getConciliationDate().getTime() : null);
						dataEntity.set(ConciliationSearch.CONCILIATIONUSER, result.getConciliationUser());
						dataEntity.set(ConciliationSearch.OBSERVATION, result.getObservation());
						dataEntity.set(ConciliationSearch.REFERENCE, result.getReference());
						resultList.add(dataEntity);
					}
					args.setSuccess(true);
				} else {
					args.setSuccess(false);
					if (response.getMessages() != null) {
						args.getMessageManager().showErrorMsg(GeneralFunction.getSpsMessages(response.getMessages()));
					}
				}
			} else {
				args.setSuccess(false);

			}

		} catch (Exception ex) {
			args.setSuccess(false);
			logger.logError("Error in ExecuteQuerySearchConciliation: " + ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finish executeDataEvent in ExecuteQuerySearchConciliation");
			}
		}
		return resultList.getDataList();
	}

}
