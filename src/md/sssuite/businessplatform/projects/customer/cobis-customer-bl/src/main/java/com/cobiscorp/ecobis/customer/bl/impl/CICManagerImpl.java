package com.cobiscorp.ecobis.customer.bl.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.CICManager;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;
import com.cobiscorp.ecobis.customer.util.Utils;

public class CICManagerImpl implements CICManager {

	private ISPOrchestrator spOrchestrator;

	private static ILogger logger = LogFactory.getLogger(CICManagerImpl.class);

	public void validateOpen(String name) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("validateOpen: " + name);
		}

	}

	@Override
	public CustomerDataResponse getCIC(CustomerQuickCreateRequest request) {
		// TODO Auto-generated method stub
		CustomerDataResponse customerDataResponse = new CustomerDataResponse();
		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		wProcedureRequest = Utils.setHeaderParams(wProcedureRequest);

		if (wProcedureRequest == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {
			wProcedureRequest.setSpName("cobis..sp_infcic_hsbc_ej");
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

			wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1903");
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "V");
			wProcedureRequest.addInputParam("@i_tipo_id", ICTSTypes.SQLVARCHAR, request.getIdentificationTypeCode());
			wProcedureRequest.addInputParam("@i_identificacion", ICTSTypes.SQLVARCHAR, request.getId());

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);
			if (wProcedureResponseAS != null) {
				wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();
				if (wProcedureResponseAS.getReturnCode() != 0) {
					throw new BusinessException(wProcedureResponseAS.getReturnCode(), "CUSTOMER DOESN'T HAS CIC AUTHORIZED");
				}
			}
			customerDataResponse.setCustomerIdentification(request.getId());
		}

		return customerDataResponse;

	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
