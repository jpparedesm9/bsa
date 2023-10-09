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

public class LoanSearchGroup extends BaseEvent implements IExecuteQuery {
	private static final ILogger LOGGER = LogFactory
			.getLogger(LoanSearchGroup.class);

	public LoanSearchGroup(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs args) {
		DataEntityList lista = new DataEntityList();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso LoanSearchGroup>>");
		}
		args.setSuccess(true);
		try {			
			ServiceRequestTO request = new ServiceRequestTO();
			Map<String, Object> loanSearchFilter = (Map<String, Object>) entities
					.getData();
			LOGGER.logDebug("Ingreso loanSearchFilter>>" + loanSearchFilter);
			

			LoanSearchFilterRequest loanSearchFilterRequest = new LoanSearchFilterRequest();
			LOGGER.logDebug("Ingreso Banco111>>"+ loanSearchFilter.get("loanBankID"));
			LOGGER.logDebug("Ingreso identityCardNumber>>"+ loanSearchFilter.get("identityCardNumber"));
			LOGGER.logDebug("Ingreso Parameter.NUMPROCEDURE>>"+ loanSearchFilter.get(Parameter.NUMPROCEDURE));
			LOGGER.logDebug("Ingreso Parameter.OFFICEID>>"+ loanSearchFilter.get(Parameter.OFFICEID));
			LOGGER.logDebug("Ingreso Parameter.OFFICERID>>"+ loanSearchFilter.get(Parameter.OFFICERID));
			LOGGER.logDebug("Ingreso loanSearchFilter.get(disbursementDate)>>"+ loanSearchFilter.get("disbursementDate"));
			
			
			// loanSearchFilterRequest.setOperation((String)
			// loanSearchFilter.get("loanBankID")); //prestamo

			if (loanSearchFilter.get("loanBankID") != null
					&& loanSearchFilter.get("loanBankID") != "") {
				LOGGER.logDebug("Ingreso loanBankID>>>");
				loanSearchFilterRequest.setOperation((String) loanSearchFilter
						.get("loanBankID"));
			}

			if (loanSearchFilter.get("identityCardNumber") != null
					&& loanSearchFilter.get("identityCardNumber") != "") {
				LOGGER.logDebug("Ingreso setCodClient>>>");
				loanSearchFilterRequest.setCodClient(Integer
						.parseInt(loanSearchFilter.get("identityCardNumber")
								.toString()));
			}

			if (loanSearchFilter.get(Parameter.NUMPROCEDURE) != null
					&& !loanSearchFilter.get(Parameter.NUMPROCEDURE).toString()
							.isEmpty()) {
				loanSearchFilterRequest.setNumTramite(Integer
						.parseInt(loanSearchFilter.get(Parameter.NUMPROCEDURE)
								.toString()));
			}

			if (loanSearchFilter.get(Parameter.OFFICEID) != null
					&& !loanSearchFilter.get(Parameter.OFFICEID).toString()
							.trim().isEmpty()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Ingreso carga dato oficina"
							+ loanSearchFilter.get(Parameter.OFFICEID)
									.toString());
				}
				loanSearchFilterRequest.setOffice(Integer
						.parseInt(loanSearchFilter.get("officeID").toString()));
			}

			if (loanSearchFilter.get(Parameter.OFFICERID) != null
					&& !loanSearchFilter.get(Parameter.OFFICERID).toString()
							.trim().isEmpty()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Ingreso carga dato oficial>>>"
							+ loanSearchFilter.get(Parameter.OFFICERID)
									.toString());
				}
				loanSearchFilterRequest
						.setOfficer(Integer.parseInt(loanSearchFilter.get(
								"officerID").toString()));
			}

			//String dateDisbursement = GeneralFunction.convertDateToString((Date) loanSearchFilter.get("disbursementDate"), true);
			if(loanSearchFilter.get("disbursementDate")!= null)
			{
			String dateDisbursement = GeneralFunction.convertDateToString((Date) loanSearchFilter.get("disbursementDate"), false);
			
			
			if ("".equals(dateDisbursement)) {
				loanSearchFilterRequest.setDisbursementDate(null);
				LOGGER.logDebug("FECHA INI NULL>>>");

			} else {
				loanSearchFilterRequest.setDisbursementDate(dateDisbursement);
				LOGGER.logDebug("FECHA INI>>>" +dateDisbursement);
			}
			}

			loanSearchFilterRequest
					.setGroup(loanSearchFilter.get("group") == null ? 'S'
							: String.valueOf(loanSearchFilter.get("group"))
									.charAt(0));

			LOGGER.logDebug("loanSearchFilterRequest......>>>"
					+ loanSearchFilterRequest);

			request.addValue("inLoanSearchFilterRequest",
					loanSearchFilterRequest);
			ServiceResponse response = this.execute(getServiceIntegration(),
					LOGGER, "Loan.LoanMaintenance.SearchLoanGroup", request);
			LOGGER.logDebug("response......>>>" + response);

			//GeneralFunction.handleResponse(args, response, "");

			if (response != null) {
				
				LOGGER.logDebug("entra response is not null......>>>" );
				if (response.isResult()) {
					LOGGER.logDebug("entra response is result......>>>" );
					ServiceResponseTO resultado = (ServiceResponseTO) response
							.getData();
					LoanSearchFilterResponse[] clResponse = (LoanSearchFilterResponse[]) resultado
							.getValue("returnLoanSearchFilterResponse");
					LOGGER.logDebug("clResponse......>>>" + clResponse);
					if(clResponse!=null)
					{
						LOGGER.logDebug("entra clResponse is not null......>>>" );

					for (LoanSearchFilterResponse result : clResponse) {

						LOGGER.logDebug("ClientId: "
								+ result.getCodClient()
								+ ", LoanId: "
								+ result.getOperation()
								+ ", DisbursmentDate:"
								+ GeneralFunction.convertStringToDate(
										result.getDisbursementDate(),
										Parameter.TYPEDATEFORMAT.MMDDYYYY)
								+ ", ClientName: " + result.getNameClient()
								+ ", OperationType: "
								+ result.getTypeOperation() + ", Amount:"
								+ result.getAmountPaid() + ", Office:"
								+ result.getOffice() + ", LoandId:"
								+ result.getSequential() + ", Tramite: "
								+ result.getNumTramite());
						DataEntity item = new DataEntity();
						item.set(Loan.STARTDATE, GeneralFunction
								.convertStringToDate(
										result.getDisbursementDate(),
										Parameter.TYPEDATEFORMAT.MMDDYYYY));
						item.set(Loan.CLIENTNAME, result.getNameClient());
						item.set(Loan.LOANBANKID, result.getOperation());
						item.set(Loan.AMOUNT, result.getAmountPaid());
						item.set(Loan.NUMPROCEDURE, result.getNumTramite());
						lista.add(item);
					    }
					//GeneralFunction.handleResponse(args, response,null);
					}
					else
					{
						LOGGER.logDebug("entra clResponse es  null......>>>" );
						
						//GeneralFunction.handleResponse(args, response,null);
						 args.setSuccess(false); 
						 if (response.getMessages() != null) {
							 LOGGER.logDebug("response.getMessages()111.."+ response.getMessages() );
							 args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages())); 
						 }
					}
				} else {
					LOGGER.logDebug("entra Response es not result ......>>>" );		
					//GeneralFunction.handleResponse(args, response,null);
					 args.setSuccess(false); 
					 if (response.getMessages() != null) {
						 LOGGER.logDebug("response.getMessages()222.."+ response.getMessages() );
						 args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages())); 
					 }
					 
				}
			} else {
				args.setSuccess(false);	
				LOGGER.logDebug("entra Response es null ......>>>" );
				//GeneralFunction.handleResponse(args, response, null);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("INCORRECTO");
				}
				
			}

			LOGGER.logDebug("size:" + lista.size());
			

			//return lista.getDataList();

		} catch (Exception e) {	
			args.setSuccess(false); 
			LOGGER.logDebug("Exception... ",e);
		}
		
		return lista.getDataList();

	}
	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}
}
