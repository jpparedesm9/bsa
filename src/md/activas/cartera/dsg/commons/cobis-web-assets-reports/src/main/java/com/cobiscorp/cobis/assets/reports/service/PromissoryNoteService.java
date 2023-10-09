package com.cobiscorp.cobis.assets.reports.service;

import cobiscorp.ecobis.assets.cloud.dto.ReportPromissoryNote;
import cobiscorp.ecobis.assets.cloud.dto.ReportPromissoryNoteRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class PromissoryNoteService extends BaseService {
	private static final ILogger logger = LogFactory.getLogger(PromissoryNoteService.class);

	/***
	 * Obtiene la informacion del reporte Pagaré a la Orden
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public ReportPromissoryNote queryPromissoryNote(ReportPromissoryNoteRequest reportPromissoryNoteRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryPromissoryNote \nbank " + reportPromissoryNoteRequest.getBank());
		}
		if (reportPromissoryNoteRequest.getBank() != null) {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICEID_RECEIPT_PROMISSURENOTE);
			// Setea el objeto(Request) utilizado para la consulta del sp
			reportPromissoryNoteRequest.setBank(reportPromissoryNoteRequest.getBank());
			reportPromissoryNoteRequest.setWeb("S");


			// Setea el ServiceRequestTO con el Objecto Request
			serviceReportRequestTO.getData().put(ConstantValue.IN_RECEIPT_PROMISSURENOTE, reportPromissoryNoteRequest);
			// Obtiene la respuesta del servicio
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE PROMISSORYNOTE");
					logger.logDebug(" *****RESPONSE PROMISSURENOTE"
							+ (serviceResponseTo.getValue(ConstantValue.RETURN_PROMISSURENOTE)));
				}
				// Si es exitosa la ejecucion se obtinene el objeto Response

				ReportPromissoryNote reportPromissoryNoteResponse = (ReportPromissoryNote) (serviceResponseTo
						.getValue(ConstantValue.RETURN_PROMISSURENOTE));
				
				return reportPromissoryNoteResponse;
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE PROMISSORYNOTE");
				util.error(serviceResponseTo);
				return null;
			}

		} else {
			return null;
		}
	}
}
