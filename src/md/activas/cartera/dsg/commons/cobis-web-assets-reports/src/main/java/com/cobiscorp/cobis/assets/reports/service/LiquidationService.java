package com.cobiscorp.cobis.assets.reports.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import cobiscorp.ecobis.assets.cloud.dto.ReportDebtorInformation;
import cobiscorp.ecobis.assets.cloud.dto.ReportEntry;
import cobiscorp.ecobis.assets.cloud.dto.ReportLiquidationRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReportOperation;
import cobiscorp.ecobis.assets.cloud.dto.ReportOutlayDetail;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 *
 */
public class LiquidationService extends BaseService {
	private static final ILogger logger = LogFactory.getLogger(LiquidationService.class);
	public static final Integer FORMAT_DATE = 101;

	public ReportOperation queryLiquidationInfo(ReportLiquidationRequest reportLiquidationRequest,
			ICTSServiceIntegration serviceIntegration) {

		ReportOperation reportOperation = queryLiquidation(reportLiquidationRequest, serviceIntegration);

		if (reportOperation != null) {
			if ("S".equals(reportOperation.getRestructuring())) {
				reportOperation.setRestructuring("Si");
			} else if ("N".equals(reportOperation.getRestructuring())) {
				reportOperation.setRestructuring("No");
			}
			if (reportOperation.getDiscountMargin() == null) {
				reportOperation.setDiscountMargin(BigDecimal.ZERO);
			}
			if (reportOperation.getLastPaymentAmount() == null) {
				reportOperation.setLastPaymentAmount(BigDecimal.ZERO);
			}

			if (reportOperation.getValuationValue() == null) {
				reportOperation.setValuationValue(BigDecimal.ZERO);
			}

			if (reportOperation.getWarrantyNumber() == null) {
				reportOperation.setWarrantyNumber(0);
			}

			reportOperation.setBirthDate(util.convertDate(reportOperation.getBirthDate()));
			reportOperation.setApprovedDate(util.convertDate(reportOperation.getApprovedDate()));
			reportOperation.setGrant(util.convertDate(reportOperation.getGrant()));
			reportOperation.setLastDate(util.convertDate(reportOperation.getLastDate()));
			reportOperation.setLineType(util.convertDate(reportOperation.getLineType()));
			reportOperation.setScoreDate(util.convertDate(reportOperation.getScoreDate()));

			// info cliente
			ReportDebtorInformation reportDebtorInformation = queryDebtorInfo(reportLiquidationRequest,
					serviceIntegration);

			if (reportDebtorInformation != null) {
				reportOperation.setPhone(reportDebtorInformation.getPhone());
				reportOperation.setAddress(reportDebtorInformation.getAddress());
			}

		}
		return reportOperation;
	}

	/***
	 * Obtiene la informacion del reporte Liquidación/Desembolso Parcial
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public ReportOperation queryLiquidation(ReportLiquidationRequest reportLiquidationRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryLiquidationInfo \nbank " + reportLiquidationRequest.getBank());
		}
		if (reportLiquidationRequest.getBank() != null) {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_LIQUIDATION_REPORT);
			// Setea el objeto(Request) utilizado para la consulta del sp
			reportLiquidationRequest.setOperation("C");
			reportLiquidationRequest.setDateFormat(FORMAT_DATE);

			// Setea el ServiceRequestTO con el Objecto Request
			serviceReportRequestTO.getData().put(ConstantValue.IN_REPORT_LIQUIDATION_REPORT, reportLiquidationRequest);
			// Obtiene la respuesta del servicio
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE LIQUIDATION");
					logger.logDebug(" *****RESPONSE OPERATION"
							+ (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_OPERATION)));
					logger.logDebug(" *****RESPONSE DETAIL"
							+ (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_OUTLAY_DETAIL)));
					logger.logDebug(
							" *****RESPONSE ENTRY" + (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_ENTRY)));
				}
				// Si es exitosa la ejecucion se obtinene el objeto Response
				ReportOperation reportOperationResponse = (ReportOperation) (serviceResponseTo
						.getValue(ConstantValue.RETURN_REPORT_OPERATION));

				ReportOutlayDetail[] reportOutlayDetail = (ReportOutlayDetail[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_REPORT_OUTLAY_DETAIL));
				ReportEntry[] reportEntry = (ReportEntry[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_REPORT_ENTRY));
				if (reportOperationResponse != null && reportOutlayDetail != null) {
					reportOperationResponse
							.setOutlayDetails(new ArrayList<ReportOutlayDetail>(Arrays.asList(reportOutlayDetail)));
				}
				if (reportOperationResponse != null && reportEntry != null) {
					reportOperationResponse.setEntries(new ArrayList<ReportEntry>(Arrays.asList(reportEntry)));
				}

				return reportOperationResponse;
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE LIQUIDATION");
				util.error(serviceResponseTo);
				return null;
			}

		} else {
			return null;
		}
	}

	/***
	 * Obtiene la informacion del cliente para reporte Liquidación/Desembolso
	 * Parcial
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public ReportDebtorInformation queryDebtorInfo(ReportLiquidationRequest reportLiquidationRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryDebtorInfo \nbank " + reportLiquidationRequest.getBank());
		}
		if (reportLiquidationRequest.getBank() != null) {

			ServiceRequestTO serviceReportRequestTO = this.getHeaderRequest(ConstantValue.SERVICE_DEBTOR_REPORT);
			// Setea el objeto(Request) utilizado para la consulta del sp
			reportLiquidationRequest.setOperation("C");
			reportLiquidationRequest.setDateFormat(FORMAT_DATE);

			// Setea el ServiceRequestTO con el Objecto Request
			serviceReportRequestTO.getData().put(ConstantValue.IN_REPORT_LIQUIDATION_REPORT, reportLiquidationRequest);
			// Obtiene la respuesta del servicio
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE INFO CLIENTE");
					logger.logDebug(
							" *****RESPONSE" + (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_DEBTOR_INFO)));
				}
				// Si es exitosa la ejecucion se obtinene el objeto Response

				return (ReportDebtorInformation) (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_DEBTOR_INFO));
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE LIQUIDATION");
				util.error(serviceResponseTo);
				return null;
			}

		} else {
			return null;
		}
	}


}
