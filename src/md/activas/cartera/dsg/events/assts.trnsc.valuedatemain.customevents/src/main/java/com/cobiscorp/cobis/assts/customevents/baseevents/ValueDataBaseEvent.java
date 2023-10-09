package com.cobiscorp.cobis.assts.customevents.baseevents;

import java.util.Calendar;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.ValueDateTranRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.TransactionLoan;
import com.cobiscorp.cobis.assts.model.ValueDateFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ValueDataBaseEvent extends BaseEvent {

	public static final String OPTION_VALUE_DATE = "1";
	public static final String OPTION_REVERSE = "2";
	public static final char OPERATION_VALUE_DATE = 'F';
	public static final char OPERATION_REVERSE = 'R';

	public ValueDataBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(TransactionBaseEvent.class);

	public void applyReverseValueDate(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia applyReverseValueDate");
		}

		try {
			boolean executeService = false;
			ServiceRequestTO request = new ServiceRequestTO();

			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity valueDateFilter = entities
					.getEntity(ValueDateFilter.ENTITY_NAME);
			DataEntityList loanTransactions = entities
					.getEntityList(TransactionLoan.ENTITY_NAME);
			DataEntity loanTransaction = new DataEntity();
			String option = valueDateFilter.get(ValueDateFilter.OPTION);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia applyReverseValueDate-option" + option);
			}
			
			ValueDateTranRequest valueDateRequest = new ValueDateTranRequest();
			valueDateRequest.setBank(loan.get(Loan.LOANBANKID));

			Integer indexRow = 0;
			if (OPTION_REVERSE.equals(option)) {
				indexRow = valueDateFilter.get(ValueDateFilter.INDEXTRN);
			}

			if (indexRow != null) {
				Calendar movDate = Calendar.getInstance();

				if (!(loanTransactions.isEmpty())
						&& !loanTransactions.isEmpty()) {
					loanTransaction = loanTransactions.get(indexRow);
					Date parseMovDate = GeneralFunction.convertStringToDate(
							loanTransaction.get(TransactionLoan.DATETRAN),
							Parameter.TYPEDATEFORMAT.DDMMYYYY);
					movDate.setTime(parseMovDate);
				}
				valueDateRequest.setMovDate(movDate);
			}

			if (OPTION_VALUE_DATE.equals(option)) {
				
				if (logger.isDebugEnabled()) {
					logger.logDebug("-->>ValueDataBaseEvent-applyReverseValueDate-option:" + option);
				}
				
				Calendar valDate = Calendar.getInstance();
				valDate.setTime(valueDateFilter.get(ValueDateFilter.VALUEDATE));
				executeService = validateValueDate(loan, valDate, args);

				valueDateRequest.setValDate(valDate);
				valueDateRequest.setOperation(OPERATION_VALUE_DATE);

			} else {
				executeService = true;//validateReverse(indexRow, loanTransactions,args);
				valueDateRequest.setOperation(OPERATION_REVERSE);
				valueDateRequest.setObservation(valueDateFilter
						.get(ValueDateFilter.OBSERVATION));
			}
			valueDateRequest.setSecuential(loanTransaction
					.get(TransactionLoan.SECUENTIAL));

			if (logger.isDebugEnabled()) {
				logger.logDebug("Operation --> "
						+ valueDateRequest.getOperation());
				logger.logDebug("Index Row --> " + indexRow);
			}

			if (executeService) {
				request.addValue("inValueDateTranRequest", valueDateRequest);
				ServiceResponse response = this.execute(getServiceIntegration(), logger,
						Parameter.PROCESS_VALUE_DATE_TRANSACTION, request);

				GeneralFunction.handleResponse(args, response, null);
								
				if (OPTION_REVERSE.equals(option)) {
					
					Date parseProcessDate = GeneralFunction.convertStringToDate(
							ServerParamUtil.getProcessDate(),
							Parameter.TYPEDATEFORMAT.MMDDYYYY);
					
					if (logger.isDebugEnabled()) {
						logger.logDebug("-->>ValueDataBaseEvent-applyReverseValueDate-parseProcessDate:" + parseProcessDate);
					}
					
					Calendar valDate = Calendar.getInstance();
					valDate.setTime(parseProcessDate);
					executeService = validateValueDate(loan, valDate, args);

					valueDateRequest.setValDate(valDate);
					valueDateRequest.setOperation(OPERATION_VALUE_DATE);
					
					request.addValue("inValueDateTranRequest", valueDateRequest);
					ServiceResponse responseF = this.execute(getServiceIntegration(), logger,
							Parameter.PROCESS_VALUE_DATE_TRANSACTION, request);
					GeneralFunction.handleResponse(args, responseF, null);
					
					if (logger.isDebugEnabled()) {
						logger.logDebug("-->>ValueDataBaseEvent-applyReverseValueDate-Fin modifiaccion");
					}
					
			}

			}

		} catch (Exception ex) {
			this.manageException(ex, logger);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza applyReverseValueDate");
		}
	}

	/*private boolean validateReverse(Integer indexRow,
			DataEntityList loanTransactions, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia validateReverse");
		}
		if (indexRow != null && indexRow != (loanTransactions.size() - 1)) {
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_SEDEBERZE_11964");
			args.setSuccess(false);
			return false;
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza validateReverse");
		}
		return true;
	}*/

	private boolean validateValueDate(DataEntity loan, Calendar valueDate, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia validateValueDate");
		}

		if (valueDate != null) {
			Date parseProcessDate = GeneralFunction.convertStringToDate(
					ServerParamUtil.getProcessDate(),
					Parameter.TYPEDATEFORMAT.MMDDYYYY);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Value Date --> " + valueDate.getTime());
				logger.logDebug("Parse process date--> " + parseProcessDate);
			}
			if (valueDate.getTime().compareTo(parseProcessDate) > 0) {
				args.getMessageManager().showErrorMsg(
						"ASSTS.MSG_ASSTS_NOSEPUELR_96521");
				args.setSuccess(false);
				return false;
			}
		}

		/*if (Parameter.CANCEL_STATUS.equals(loan.get(Loan.STATUS))) {
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_OPERACION_73139");
			args.setSuccess(false);
			return false;
		}*/
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza validateValueDate");
		}
		return true;
	}
	
	public void generateReverseValueDateOrder(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia generateReverseValueDateOrder");
		}

		try {
			ServiceRequestTO request = new ServiceRequestTO();

			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity valueDateFilter = entities.getEntity(ValueDateFilter.ENTITY_NAME);
			DataEntityList loanTransactions = entities.getEntityList(TransactionLoan.ENTITY_NAME);
			DataEntity loanTransaction = new DataEntity();

			ValueDateTranRequest valueDateRequest = new ValueDateTranRequest();
			valueDateRequest.setBank(loan.get(Loan.LOANBANKID));

			Integer indexRow = valueDateFilter.get(ValueDateFilter.INDEXTRN);
			if (indexRow != null) {
				Calendar movDate = Calendar.getInstance();

				if (!(loanTransactions.isEmpty()) && !loanTransactions.isEmpty()) {
					loanTransaction = loanTransactions.get(indexRow);
					Date parseMovDate = GeneralFunction.convertStringToDate(loanTransaction.get(TransactionLoan.DATETRAN), Parameter.TYPEDATEFORMAT.DDMMYYYY);
					movDate.setTime(parseMovDate);
				}
				valueDateRequest.setMovDate(movDate);
			}
			
			boolean executeService = true;
			valueDateRequest.setOperation(OPERATION_REVERSE);
			valueDateRequest.setObservation(valueDateFilter.get(ValueDateFilter.OBSERVATION));
			valueDateRequest.setSecuential(loanTransaction.get(TransactionLoan.SECUENTIAL));
			valueDateRequest.setIsGroup("S");

			if (logger.isDebugEnabled()) {
				logger.logDebug("Operation --> " + valueDateRequest.getOperation());
				logger.logDebug("Index Row --> " + indexRow);
			}

			if (executeService) {
				request.addValue("inValueDateTranRequest", valueDateRequest);
				ServiceResponse response = this.execute(getServiceIntegration(), logger, Parameter.PROCESS_VALUE_DATE_TRANSACTION, request);

				GeneralFunction.handleResponse(args, response, null);
			}

		} catch (Exception ex) {
			this.manageException(ex, logger);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza generateReverseValueDateOrder");
		}
		
	}
}
