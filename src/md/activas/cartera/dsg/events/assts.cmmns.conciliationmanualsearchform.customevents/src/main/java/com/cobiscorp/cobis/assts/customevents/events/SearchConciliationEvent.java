package com.cobiscorp.cobis.assts.customevents.events;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ConciliationManualSearch;
import com.cobiscorp.cobis.assts.model.ConciliationManualSearchFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.ConciliationManualRequest;
import cobiscorp.ecobis.assets.cloud.dto.ConciliationManualResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchConciliationEvent extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(SearchConciliationEvent.class);
	
	private static final String CONSTANTE_C = "C";
	private static final String CONSTANTE_P = "P";
	private static final String CONSTANTE_G = "G";
	private static final String CONSTANTE_S = "S";

	public SearchConciliationEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso SearchConciliationEvent - executeDataEvent");
		}

		try {
			ServiceRequestTO request = new ServiceRequestTO();

			DataEntity conciliationSearchFilter = entities.getEntity(ConciliationManualSearchFilter.ENTITY_NAME);

			DataEntityList list = new DataEntityList();

			ConciliationManualRequest conciliationManualRequest = new ConciliationManualRequest();

			/** Method that prepares the data of the request */
			prepareDataRequest(conciliationSearchFilter, conciliationManualRequest);

			request.addValue("inConciliationManualRequest", conciliationManualRequest);
			ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.ConciliationManagement.SearchConciliationByFilters", request);

			if (response != null) {
				if (response.isResult()) {
					ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

					ConciliationManualResponse[] cmResponse = (ConciliationManualResponse[]) resultado.getValue("returnConciliationManualResponse");

					for (ConciliationManualResponse result : cmResponse) {

						DataEntity item = new DataEntity();

						item.set(ConciliationManualSearch.ISSELECTED, false);
						item.set(ConciliationManualSearch.CODECO, result.getCodeCo());
						item.set(ConciliationManualSearch.CORRESPONDENT, result.getCorrespondent());
						item.set(ConciliationManualSearch.PAYMENTREFERENCE, result.getPaymentReference());
						item.set(ConciliationManualSearch.CORRESPTRANSACTIONCODE, result.getIdTrnCorrespondent());
						item.set(ConciliationManualSearch.TYPE, result.getTransactionType());
						item.set(ConciliationManualSearch.CUSTOMCODE, result.getCustomerCode());
						item.set(ConciliationManualSearch.CLIENTNAME, result.getCustomName());
						item.set(ConciliationManualSearch.ISREVERSE, result.getIsReverse());
						item.set(ConciliationManualSearch.RECORDSDATE, calendarToStringWithFormat(result.getRecordsDate()));
						item.set(ConciliationManualSearch.VALUEDATE, GeneralFunction.convertCalendarToDate(result.getValueDate()));
						item.set(ConciliationManualSearch.USERPAYMENT, result.getUserPayment());
						item.set(ConciliationManualSearch.PAYMENTSTATE, result.getPaymentState());
						item.set(ConciliationManualSearch.CONCILIATE, result.getConciliate());
						item.set(ConciliationManualSearch.NOTCONCILIATIONREASON, result.getConciliationReason());
						item.set(ConciliationManualSearch.CONCILIATIONUSER, result.getConciliationUser());
						item.set(ConciliationManualSearch.CONCILIATIONDATE, GeneralFunction.convertCalendarToDate(result.getConciliationDate()));
						item.set(ConciliationManualSearch.OPERATION, result.getOperation());
						item.set(ConciliationManualSearch.OBSERVATION, result.getObservation());
						item.set(ConciliationManualSearch.SEQUENTIALCODE, result.getSequentialCode());
						item.set(ConciliationManualSearch.CODERELATION, result.getRelationCode());

						list.add(item);
					}

					entities.setEntityList(ConciliationManualSearch.ENTITY_NAME, list);

					args.setSuccess(true);
				} else {
					args.setSuccess(false);
					if (response.getMessages() != null) {
						args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
					}
					entities.getEntityList(ConciliationManualSearch.ENTITY_NAME).clear();
				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("INCORRECTO");
				}
			}
			args.setSuccess(true);
		} catch (Exception error) {
			logger.logError("ERROR: AL REALIZAR LA BUSQUEDA ", error);
		}

	}

	private String calendarToStringWithFormat(Calendar recordsDate) {
		if(recordsDate!=null) {
			Date date = recordsDate.getTime();  
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm");  
			return dateFormat.format(date);
		}
		return null;
	}

	private void prepareDataRequest(DataEntity conciliationSearchFilter, ConciliationManualRequest conciliationManualRequest) {
		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMCODE) != null) {
			if (CONSTANTE_P.equals(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMTYPE)) || CONSTANTE_C.equals(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMTYPE))) { 
				conciliationManualRequest.setCustomerCode(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMCODE));
			}
			if (CONSTANTE_S.equals(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMTYPE)) || CONSTANTE_G.equals(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMTYPE))) {
				conciliationManualRequest.setGroupCode(conciliationSearchFilter.get(ConciliationManualSearchFilter.CUSTOMCODE));
			}
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.CORRESPTRANSACTIONCODE) != null) {
			conciliationManualRequest.setIdTrnCorrespondent(conciliationSearchFilter.get(ConciliationManualSearchFilter.CORRESPTRANSACTIONCODE));
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.DATEFROM) != null) {
			Calendar df = Calendar.getInstance();
			df.setTime(conciliationSearchFilter.get(ConciliationManualSearchFilter.DATEFROM));
			conciliationManualRequest.setDateFrom(df);
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.DATEUNTIL) != null) {
			Calendar du = Calendar.getInstance();
			du.setTime(conciliationSearchFilter.get(ConciliationManualSearchFilter.DATEUNTIL));
			conciliationManualRequest.setDateUntil(du);
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.CORRESPONDENT) != null) {
			conciliationManualRequest.setCorrespondent(conciliationSearchFilter.get(ConciliationManualSearchFilter.CORRESPONDENT));
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.TYPE) != null) {
			conciliationManualRequest.setTransactionType(conciliationSearchFilter.get(ConciliationManualSearchFilter.TYPE));
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.NOTCONCILIATIONREASON) != null) {
			conciliationManualRequest.setConciliationReason(conciliationSearchFilter.get(ConciliationManualSearchFilter.NOTCONCILIATIONREASON).toString());
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.CONCILIATE) != null) {
			conciliationManualRequest.setConciliate(conciliationSearchFilter.get(ConciliationManualSearchFilter.CONCILIATE).toString());
		}

		if (conciliationSearchFilter.get(ConciliationManualSearchFilter.PAYMENTSTATE) != null) {
			conciliationManualRequest.setPaymentState(conciliationSearchFilter.get(ConciliationManualSearchFilter.PAYMENTSTATE).toString());
		}
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}
}
