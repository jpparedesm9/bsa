package com.cobiscorp.ecobis.customer.bl.impl;

import java.text.SimpleDateFormat;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponseParam;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.QuickCustomerManager;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;
import com.cobiscorp.ecobis.customer.util.Utils;

public class QuickCustomerManagerImpl implements QuickCustomerManager {
	private SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

	private static ILogger logger = LogFactory.getLogger(QuickCustomerManagerImpl.class);
	private ISPOrchestrator spOrchestrator;

	public void validateOpen(String name) {
		if (logger.isDebugEnabled())
			logger.logDebug("validateOpen: " + name);
	}

	public CustomerDataResponse getQuickCustomer(CustomerQuickCreateRequest request) {
		Integer customerID = null;

		CustomerDataResponse customerDataResponse = null;

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		wProcedureRequest = Utils.setHeaderParams(wProcedureRequest);

		if (wProcedureRequest == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {


			wProcedureRequest.setSpName("cobis..sp_persona_no_ruc");
			wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1288");// 1026
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "I");
			wProcedureRequest.addInputParam("@i_tipo_ced", ICTSTypes.SQLVARCHAR, request.getIdentificationTypeCode());
			wProcedureRequest.addInputParam("@i_cedula", ICTSTypes.SQLVARCHAR, request.getId());
			wProcedureRequest.addInputParam("@i_nombre", ICTSTypes.SQLVARCHAR, request.getFirstName());
			wProcedureRequest.addInputParam("@i_segnombre", ICTSTypes.SQLVARCHAR, request.getMiddleName());
			wProcedureRequest.addInputParam("@i_papellido", ICTSTypes.SQLVARCHAR, request.getLastName());
			wProcedureRequest.addInputParam("@i_sapellido", ICTSTypes.SQLVARCHAR, request.getAdditionalLastName());
			wProcedureRequest.addInputParam("@i_nacionalidad", ICTSTypes.SQLINT4, request.getNationalityCode().toString());
			wProcedureRequest.addInputParam("@i_profesion", ICTSTypes.SQLVARCHAR, request.getProfessionCode());
			Context wContext = ContextManager.getContext();
			CobisSession wSession = (CobisSession) wContext.getSession();
			wProcedureRequest.addInputParam("@i_filial", ICTSTypes.SQLINT4, wSession.getOffice());
			wProcedureRequest.addInputParam("@i_oficina", ICTSTypes.SQLINT4, wSession.getOffice());
			
			wProcedureRequest.addInputParam("@i_estado", ICTSTypes.SQLVARCHAR, request.getStatusCode());
			wProcedureRequest.addInputParam("@i_oficial", ICTSTypes.SQLINT4, request.getOfficial().toString());
			wProcedureRequest.addInputParam("@i_ejecutivo_con", ICTSTypes.SQLINT4, request.getOfficial().toString());
			wProcedureRequest.addInputParam("@i_sexo", ICTSTypes.SQLVARCHAR, request.getSexCode());
			wProcedureRequest.addInputParam("@i_fecha_nac", ICTSTypes.SQLDATETIME, request.getBirthDate() == null ? "" : sdf.format(request.getBirthDate()));
			wProcedureRequest.addInputParam("@i_fecha_expira", ICTSTypes.SQLDATETIME, request.getIdExpirationDate() == null ? "" : sdf.format(request.getIdExpirationDate()));
			wProcedureRequest.addInputParam("@i_est_civil", ICTSTypes.SQLVARCHAR, request.getMaritalStatusCode());
			wProcedureRequest.addInputParam("@i_c_apellido", ICTSTypes.SQLVARCHAR, request.getMarriedName());
			/* tipo de estado es P-PersonaNatural saco del catalogo cl_ptipo */
			wProcedureRequest.addInputParam("@i_tipo", ICTSTypes.SQLVARCHAR, request.getTypeCode());
			wProcedureRequest.addInputParam("@i_digito", ICTSTypes.SQLVARCHAR, request.getDigitCheck());
			wProcedureRequest.addInputParam("@o_ente", ICTSTypes.SQLINT4, "0");
			// wProcedureRequest.addInputParam("@o_tip_ente", ICTSTypes.SQLINT4,
			// "0");

			if (logger.isDebugEnabled()) {
				logger.logDebug("<<<<<<<<<< Before execute ProcedureRequest >>>>>>>>>> " + wProcedureRequest.getProcedureRequestAsString());
			}
			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			if (logger.isDebugEnabled()) {
				logger.logDebug("<<<<<<<<<< wProcedureResponseAS >>>>>>>>>> " + wProcedureResponseAS);
			}

			if (wProcedureResponseAS != null) {

				wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

				if (wProcedureResponseAS.getReturnCode() != 0) {
					throw new BusinessException(wProcedureResponseAS.getReturnCode(), "CUSTOMER EXIST");
				}

				for (Object rsb : wProcedureResponseAS.getParams()) {
					IProcedureResponseParam param = (IProcedureResponseParam) rsb;
					if (param.getName().equals("@o_ente"))
						customerID = Integer.parseInt(param.getValue());

				}

				customerDataResponse = new CustomerDataResponse();
				customerDataResponse.setCustomerID(customerID);
			}
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
