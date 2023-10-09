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
import com.cobiscorp.ecobis.customer.bl.CustomerManager;
import com.cobiscorp.ecobis.customer.dal.CustomerDAO;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;
import com.cobiscorp.ecobis.customer.util.Utils;

public class CustomerManagerImpl implements CustomerManager {
	private static ILogger logger = LogFactory.getLogger(CustomerManagerImpl.class);

	private CustomerDAO customerDAO;

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

	// private AddressManagerImpl addressManagerImpl;
	//
	// public void setAddressManagerImpl(AddressManagerImpl addressManagerImp) {
	// this.addressManagerImpl = addressManagerImp;
	// }
	@Override
	public void open(String name, double initialValue) {
		throw new BusinessException(1, "Not implemented");

	}

	@Override
	public void validateOpen(String name) {
		if (logger.isDebugEnabled())
			logger.logDebug("validateOpen: " + name);
	}

	private Boolean existCustomerData(CustomerDataResponse customerDataResponse) {
		Boolean customerExistence;

		if (customerDataResponse.getCustomerID() == null) {
			customerExistence = false;
		} else {
			customerExistence = true;
		}
		return customerExistence;
	}

	/*
	 * private Boolean existCompanyData(CompanyDataResponse companyDataResponse)
	 * { Boolean companyExistence;
	 * 
	 * if (companyDataResponse.getCompanyId() == 0) { companyExistence = false;
	 * } else { companyExistence = true; } return companyExistence; }
	 */

	@Override
	public CustomerDataResponse getCustomerDataById(Integer id) {

		CustomerDataResponse customerData = customerDAO.getCustomerDataByID(id);

		if (existCustomerData(customerData) == false) {
			throw new BusinessException(1, "CUSTOMER DOESN'T EXIST");
		}

		return customerData;
	}

	@Override
	public CustomerDataResponse searchCustomerDataById(Integer id) {

		CustomerDataResponse customerDataAll = customerDAO.getCustomerAllDataByID(id);

		if (existCustomerData(customerDataAll) == false) {
			throw new BusinessException(1, "CUSTOMER DOESN'T EXIST");
		}

		return customerDataAll;
	}

	public void setCustomerDAO(CustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}

	@Override
	public IdSearchResponse getIdSearchByID(String docId) {
		IdSearchResponse idSearchResponse = customerDAO.getIdSearchByID(docId);
		return idSearchResponse;
	}

	@Override
	public CustomerDataResponse searchCustomerNameById(Integer id) {

		CustomerDataResponse customerData = new CustomerDataResponse();

		logger.logDebug("Recupero datos del CobisSession");

		logger.logDebug("Declaro el IProcedureRequest");
		IProcedureRequest iProcedureRequest = new ProcedureRequestAS();

		iProcedureRequest = Utils.setHeaderParams(iProcedureRequest);

		if (iProcedureRequest == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {
			iProcedureRequest.setSpName("cobis..sp_persona_cons");
			logger.logDebug("Set de los campos del procedimiento");
			iProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "133");
			iProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "H");
			iProcedureRequest.addInputParam("@i_persona", ICTSTypes.SQLINT4, id.toString());

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(iProcedureRequest, null, null);
			wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

			Iterator it = wProcedureResponseAS.getResultSets().iterator();
			Iterator itMessage = wProcedureResponseAS.getMessages().iterator();

			while (it.hasNext()) {

				IResultSetBlock resulSetBlock = (IResultSetBlock) it.next();
				IResultSetData resultSetData = resulSetBlock.getData();
				IResultSetRow row = resultSetData.getRow(1);

				if (row == null) {

					iProcedureRequest = new ProcedureRequestAS();
					iProcedureRequest = Utils.setHeaderParams(iProcedureRequest);
					iProcedureRequest.setSpName("cobis..sp_compania_cons");
					iProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

					logger.logDebug("Set de los campos del procedimiento");

					iProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1218");
					iProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "Q");
					iProcedureRequest.addInputParam("@i_compania", ICTSTypes.SQLINT4, id.toString());

					wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(iProcedureRequest, null, null);
					wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

					it = wProcedureResponseAS.getResultSets().iterator();
					itMessage = wProcedureResponseAS.getMessages().iterator();

					while (it.hasNext()) {

						resulSetBlock = (IResultSetBlock) it.next();
						resultSetData = resulSetBlock.getData();
						row = resultSetData.getRow(1);
						customerData.setCustomerName(row.getRowData(1).getValue());
						customerData.setCustomerIdentification(row.getRowData(3).getValue());
					}

				} else {
					customerData.setCustomerName(row.getRowData(1).getValue());
					customerData.setCustomerIdentification(row.getRowData(3).getValue());
				}
			}
		}

		return customerData;
	}
}
