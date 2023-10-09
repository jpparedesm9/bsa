package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.customer.bl.IdCustomerManager;
import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;
import com.cobiscorp.ecobis.customer.util.Utils;

public class IdCustomerManagerImpl implements IdCustomerManager {

	private ISPOrchestrator spOrchestrator;

	private static ILogger logger = LogFactory.getLogger(IdCustomerManagerImpl.class);

	// doubt
	public void validateOpen(String name) {
		if (logger.isDebugEnabled())
			logger.logDebug("validateOpen: " + name);
	}

	public List<IdCustomerDataResponse> getIdCustomer(IdCustomerDataResponse request) {
		// String code = null;

		IdCustomerDataResponse idCustomerDataResponse = null;
		List<IdCustomerDataResponse> idCustomerDataResponses = new ArrayList<IdCustomerDataResponse>();
		
		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		wProcedureRequest = Utils.setHeaderParams(wProcedureRequest);

		if (wProcedureRequest == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {

			wProcedureRequest.setSpName("cobis..sp_tipo_iden");
			wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1445");
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "A");
			wProcedureRequest.addInputParam("@i_tpersona ", ICTSTypes.SQLVARCHAR, request.getTypePerson());
			wProcedureRequest.addInputParam("@i_aperrapida", ICTSTypes.SQLVARCHAR, request.getAperquick());

			if (logger.isDebugEnabled()) {
				logger.logDebug("<<<<<<<<<< Before execute ProcedureRequest >>>>>>>>>> " + wProcedureRequest.getProcedureRequestAsString());
			}

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			if (wProcedureResponseAS != null && wProcedureResponseAS.getResultSet(1) != null) {
				IResultSetBlock resulSetBlock = wProcedureResponseAS.getResultSet(1);// 1
				logger.logDebug("------RESULTSET 1---->" + resulSetBlock.toString());
				IResultSetData resultSetData = resulSetBlock.getData();
				logger.logDebug("------RESULTSETDATA---->" + resulSetBlock.getData());
				logger.logDebug("------NUMERO DE REGISTROS---->" + resultSetData.getRowsNumber());

				for (int i = 1; i <= resultSetData.getRowsNumber(); ++i) {
					idCustomerDataResponse = new IdCustomerDataResponse();
					IResultSetRow row = resultSetData.getRow(i);
					logger.logDebug("------ROW " + i + "---->" + row.toString());

					idCustomerDataResponse.setCode(row.getRowData(1).getValue());
					idCustomerDataResponse.setDescription(row.getRowData(2).getValue());
					idCustomerDataResponse.setMask(row.getRowData(3).getValue());
					idCustomerDataResponse.setTypePerson(row.getRowData(4).getValue());
					idCustomerDataResponse.setProvince(row.getRowData(5).getValue());
					idCustomerDataResponse.setAperquick(row.getRowData(6).getValue());
					idCustomerDataResponse.setBlocks(row.getRowData(7).getValue());
					idCustomerDataResponse.setNationality(row.getRowData(8).getValue());
					idCustomerDataResponse.setDigit(row.getRowData(9).getValue());

					idCustomerDataResponses.add(idCustomerDataResponse);

				}

			}

		}

		return idCustomerDataResponses;

	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
