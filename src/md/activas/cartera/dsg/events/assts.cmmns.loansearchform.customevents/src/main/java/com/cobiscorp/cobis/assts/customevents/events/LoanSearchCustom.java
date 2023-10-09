package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.LoanSearchFilterRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanSearchFilterResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanSearchFilter;
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

public class LoanSearchCustom extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(LoanSearchCustom.class);

	public LoanSearchCustom(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso LoanSearchCustom - executeDataEvent");
		}

		String isGroup = "N";
		
		ServiceRequestTO request = new ServiceRequestTO();
		Map<String, Object> loanSearchFilter = (Map<String, Object>) entities.getData();
		DataEntityList lista = new DataEntityList();
		
		//DataEntity loanSearchFilterEntity = entities.getEntity(LoanSearchFilter.ENTITY_NAME);
		//String groupSummary=loanSearchFilterEntity.get(LoanSearchFilter.GROUPSUMMARY);
		String groupSummary=(String)loanSearchFilter.get("groupSummary");
		logger.logDebug("SMO mapa>>"+loanSearchFilter);
		LoanSearchFilterRequest loanSearchFilterRequest = new LoanSearchFilterRequest();

		loanSearchFilterRequest.setGroupSummary((groupSummary==null)?"N":groupSummary);
		
		if (loanSearchFilter.get("identityCardNumber") != null && loanSearchFilter.get("identityCardNumber") != "") {
			if ("S".equals(loanSearchFilter.get("group"))) {
				loanSearchFilterRequest.setGroupClient(Integer.parseInt(loanSearchFilter.get("identityCardNumber").toString()));
			} else {
				loanSearchFilterRequest.setCodClient(Integer.parseInt(loanSearchFilter.get("identityCardNumber").toString()));
			}
		}

		if (loanSearchFilter.get(Parameter.NUMPROCEDURE) != null && !loanSearchFilter.get(Parameter.NUMPROCEDURE).toString().isEmpty()) {
			loanSearchFilterRequest.setNumTramite(Integer.parseInt(loanSearchFilter.get(Parameter.NUMPROCEDURE).toString()));
		}
		loanSearchFilterRequest.setCodCurrency(Integer.parseInt(loanSearchFilter.get("codCurrency").toString()));
		loanSearchFilterRequest.setOperation((String) loanSearchFilter.get("loanBankID"));

		if (loanSearchFilter.get(Parameter.OFFICEID) != null && !loanSearchFilter.get(Parameter.OFFICEID).toString().trim().isEmpty()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingreso carga dato oficina" + loanSearchFilter.get(Parameter.OFFICEID).toString());
			}
			loanSearchFilterRequest.setOffice(Integer.parseInt(loanSearchFilter.get("officeID").toString()));

		}
		loanSearchFilterRequest.setMigratedOper((String) loanSearchFilter.get("migratedOper"));
		loanSearchFilterRequest.setStatus((String) loanSearchFilter.get("status"));

		String dateDisbursement = GeneralFunction.convertDateToString((Date) loanSearchFilter.get("disbursementDate"), true);
		if ("".equals(dateDisbursement)) {
			loanSearchFilterRequest.setDisbursementDate(null);

		} else {
			loanSearchFilterRequest.setDisbursementDate(dateDisbursement);
		}

		if ("G".equals(loanSearchFilter.get("paymentType"))) {
			isGroup = "S";
		}

		
		loanSearchFilterRequest.setGroup(isGroup.charAt(0));
		loanSearchFilterRequest.setCategory(loanSearchFilter.get("category") == null ? 0 : Integer.parseInt(String.valueOf(loanSearchFilter.get("category"))));

		request.addValue("inLoanSearchFilterRequest", loanSearchFilterRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.LoanMaintenance.SearchLoanCustomer", request);

		GeneralFunction.handleResponse(args, response, "");

		if (response != null) {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				LoanSearchFilterResponse[] clResponse = (LoanSearchFilterResponse[]) resultado.getValue("returnLoanSearchFilterResponse");

				for (LoanSearchFilterResponse result : clResponse) {

					logger.logDebug("ClientId: " + result.getCodClient() + ", LoanId: " + result.getOperation() + ", DisbursmentDate:"
							+ GeneralFunction.convertStringToDate(result.getDisbursementDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY) + ", ExpirationDate: "
							+ GeneralFunction.convertStringToDate(result.getExpirationDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY) + ", Status:" + result.getDesStatus()
							+ ", ClientName: " + result.getNameClient() + ", OperationType: " + result.getTypeOperation() + ", Amount:" + result.getAmountPaid() + ", Office:"
							+ result.getOffice() + ", RedesCont:" + result.getRedesCont() + ", Adjustment: " + result.getAdjustment() + ", LoandId:" + result.getSequential()
							+ ", Tramite: " + result.getNumTramite() + ", PreviousOper:" + result.getPreviousOper() + ", QuotationCredit:" + result.getQuotaCredit()
							+ ", OperationTypeid:" + result.getClassOper());
					DataEntity item = new DataEntity();
					item.set(Loan.CODCURRENCY, result.getCodCurrency());
					item.set(Loan.DISBURSEMENTDATE, GeneralFunction.convertStringToDate(result.getDisbursementDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY));
					item.set(Loan.EXPIRATIONDATE, GeneralFunction.convertStringToDate(result.getExpirationDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY));
					item.set(Loan.STATUS, result.getDesStatus());
					item.set(Loan.CLIENTID, result.getCodClient());
					item.set(Loan.CLIENTNAME, result.getNameClient());
					item.set(Loan.DESOPERATIONTYPE, result.getTypeOperation());
					item.set(Loan.LOANBANKID, result.getOperation());
					item.set(Loan.AMOUNT, result.getAmountPaid());
					item.set(Loan.OFFICEID, result.getOffice());
					item.set(Loan.REDESCONT, result.getRedesCont());
					item.set(Loan.ADJUSTMENT, result.getAdjustment());
					item.set(Loan.LOANID, result.getSequential());
					item.set(Loan.NUMPROCEDURE, result.getNumTramite());
					item.set(Loan.PREVIOUSOPER, result.getPreviousOper());
					item.set(Loan.QUOTACREDIT, result.getQuotaCredit());
					item.set(Loan.OPERATIONTYPEID, result.getClassOper());
					lista.add(item);
				}
				args.setSuccess(true);
			} else {
				args.setSuccess(false);
				if (response.getMessages() != null) {
					args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
				}
			}
		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("INCORRECTO");
			}
		}

		logger.logDebug("size:" + lista.size());
		args.setSuccess(true);

		return lista.getDataList();
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
