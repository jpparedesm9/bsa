package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.Iterator;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.PadronManager;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;
import com.cobiscorp.ecobis.customer.util.Utils;

public class PadronManagerImpl implements PadronManager {
	private static ILogger logger = LogFactory.getLogger(PadronManagerImpl.class);

	private ISPOrchestrator spOrchestrator;

	/**
	 * @return the spOrchestrator
	 */
	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	/**
	 * @param spOrchestrator
	 *            the spOrchestrator to set
	 */
	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	public void validateOpen(String name) {
		if (logger.isDebugEnabled())
			logger.logDebug("validateOpen: " + name);
	}

	@Override
	public CustomerDataResponse getPadronCustomer(CustomerQuickCreateRequest request) {

		logger.logDebug("Start getPadronCustomer");
		CustomerDataResponse customerDataResponse = null;
		try {
			IProcedureRequest preq = new ProcedureRequestAS();
			request.setPadron("SUG");

			preq = procedureRequest(request);
			if (preq != null) {
				ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(preq, null, null);
				wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

				if (wProcedureResponseAS != null && (wProcedureResponseAS.getReturnCode() != 0) && (request.getType().equals("P"))) {

					IProcedureRequest preq2 = new ProcedureRequestAS();
					request.setPadron("TSE");
					preq2 = procedureRequest(request);
					// Ejecuci�n del sp
					wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(preq2, null, null);
					wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

					if (wProcedureResponseAS != null && wProcedureResponseAS.getReturnCode() != 0) {
						throw new BusinessException(wProcedureResponseAS.getReturnCode(), "PADRON NOT FOUND");
					}

					Iterator it = wProcedureResponseAS.getResultSets().iterator();
					Iterator itMessage = wProcedureResponseAS.getMessages().iterator();

					while (it.hasNext()) {

						IResultSetBlock resulSetBlock = (IResultSetBlock) it.next();
						IResultSetData resultSetData = resulSetBlock.getData();

						if (resultSetData.getRowsNumber() > 0) {
							customerDataResponse = new CustomerDataResponse();
							IResultSetRow row = resultSetData.getRow(1);

							if (request.getPadron().equals("SUG")) {
								if (request.getType().equals("P")) {
									customerDataResponse.setCustomerTypeDocumentId(row.getRowData(1).getValue());
									customerDataResponse.setCustomerIdentification(row.getRowData(2).getValue());
									customerDataResponse.setCustomerLastName(row.getRowData(3).getValue());
									customerDataResponse.setCustomerAdditionalLastName(row.getRowData(4).getValue());
									customerDataResponse.setCustomerFirstName(row.getRowData(5).getValue());
									customerDataResponse.setCustomerBirthDate((row.getRowData(6).getValue()));
									customerDataResponse.setCustomerSexCode(Integer.parseInt(row.getRowData(7).getValue()));
									customerDataResponse.setCustomerSexType(row.getRowData(8).getValue());
									customerDataResponse.setCustomerCountry(Integer.parseInt(row.getRowData(9).getValue()));
									customerDataResponse.setCustomerNationalityD(row.getRowData(10).getValue());
									customerDataResponse.setCustomerSex(row.getRowData(11).getValue());
									customerDataResponse.setCustomerDateCharge(row.getRowData(12).getValue());
									customerDataResponse.setCustomerDescription(row.getRowData(13).getValue());

								}

								if (request.getType().equals("C")) {
									customerDataResponse.setCustomerTypeDocumentId(row.getRowData(1).getValue());
									customerDataResponse.setCustomerIdentification(row.getRowData(2).getValue());
									customerDataResponse.setCustomerBusinessName(row.getRowData(3).getValue());
									customerDataResponse.setCustomerConstitutionDate(row.getRowData(4).getValue());
									customerDataResponse.setCustomerCountry(Integer.parseInt(row.getRowData(5).getValue()));
									customerDataResponse.setCustomerDescription(row.getRowData(6).getValue());
									customerDataResponse.setCustomerDateCharge(row.getRowData(7).getValue());

								}
							}

							if (request.getPadron().equals("TSE")) {
								customerDataResponse.setCustomerIdentification(row.getRowData(1).getValue());
								customerDataResponse.setCustomerLastName(row.getRowData(2).getValue());
								customerDataResponse.setCustomerAdditionalLastName(row.getRowData(3).getValue());
								customerDataResponse.setCustomerFirstName(row.getRowData(4).getValue());
								customerDataResponse.setCustomerBirthDate(row.getRowData(5).getValue());
								customerDataResponse.setCustomerSexCode(Integer.parseInt(row.getRowData(6).getValue()));
								customerDataResponse.setCustomerCodelec(row.getRowData(7).getValue());
								customerDataResponse.setCustomerBoard(row.getRowData(8).getValue());
								customerDataResponse.setCustomerSex(row.getRowData(9).getValue());
								customerDataResponse.setCustomerSexType(row.getRowData(10).getValue());
								customerDataResponse.setCustomerDateCharge(row.getRowData(11).getValue());

							}

						}

					}
				}
			}
		} finally {
			logger.logDebug("Finish getPadronCustomer");
		}

		return customerDataResponse;
	}

	public IProcedureRequest procedureRequest(CustomerQuickCreateRequest request) {
		IProcedureRequest preq = new ProcedureRequestAS();
		logger.logDebug("Start procedureRequest");
		try {

			preq = Utils.setHeaderParams(preq);
			if (preq == null) {
				logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
			} else {
				preq.setSpName("cobis..sp_consulta_padron");
				preq.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

				preq.addInputParam("@i_padron", ICTSTypes.SQLVARCHAR, request.getPadron());
				preq.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "S");
				preq.addInputParam("@i_modo", ICTSTypes.SQLINT4, request.getModeCode().toString());
				preq.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1029");
				preq.addInputParam("@i_identificacion", ICTSTypes.SQLVARCHAR, request.getId());
				preq.addInputParam("@i_tipo", ICTSTypes.SQLVARCHAR, request.getType());
				preq.addInputParam("@i_tipo_identif", ICTSTypes.SQLVARCHAR, request.getIdentificationTypeCode());
			}
		} finally {
			logger.logDebug("Start procedureRequest");
		}
		return preq;
	}

}
