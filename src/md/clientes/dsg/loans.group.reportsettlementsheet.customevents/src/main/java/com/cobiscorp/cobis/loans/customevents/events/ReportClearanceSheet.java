package com.cobiscorp.cobis.loans.customevents.events;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.ClearanceSheet;
import com.cobiscorp.cobis.loans.model.GeneralInformation;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ReportClearanceSheet extends BaseEvent implements IInitDataEvent {
	private static ILogger LOGGER = LogFactory
			.getLogger(ReportClearanceSheet.class);

	public ReportClearanceSheet(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		// TODO Auto-generated method stub

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("-------> ReportClearanceSheet -- Ingreso **");
			LOGGER.logDebug("-------> ReportClearanceSheet -- arg1 **"
					+ arg1.getParameters());
		}

		int idCredit = (Integer) arg1.getParameters().getCustomParameters()
				.get("IDRequested");

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportClearanceSheet -- getClearanceSheetHeader - idCredit:"
					+ idCredit);

		getClearanceSheetHeader(entities, idCredit, arg1);
		getClearanceSheetDetail(entities, idCredit, arg1);
	}

	public void getClearanceSheetHeader(DynamicRequest entities, int idCredit,
			IDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportClearanceSheet -- getClearanceSheetHeader - idCredit:"
					+ idCredit);

		try {

			// Id de Servicio
			String serviceId = "LoanGroup.ReportMaintenance.SettlementSheetHeader";

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			cobiscorp.ecobis.loangroup.dto.ReportRequest requestInReportRequest = new cobiscorp.ecobis.loangroup.dto.ReportRequest();

			// requestInReportRequest.setTramite(informationGroup.get(com.cobiscorp.cobis.loans.model.InformationGroup.GROUPID).intValue());
			requestInReportRequest.setTramite(idCredit);

			// Invocación de servicio
			serviceRequest.addValue("inReportRequest", requestInReportRequest);

			SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");

			// Ejecución de servicio
			ServiceResponse response = this.execute(LOGGER, serviceId,
					serviceRequest);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-------> ReportClearanceSheet -- response.isResult():"
						+ response.isResult());

			// Mapeo de respuesta
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {

					cobiscorp.ecobis.loangroup.dto.ReportResponse reportResponse = (cobiscorp.ecobis.loangroup.dto.ReportResponse) resultado
							.getValue("returnReportResponse");

					DataEntity reportResponseEntity = entities.getEntity(GeneralInformation.ENTITY_NAME);

					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("-------> ReportClearanceSheet -- reportResponse" + reportResponse);

					if (reportResponse != null) {

						reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.CURRENTDATE, formateador.format(new Date()));

						if (reportResponse.getDatePayment() != null) {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.DATEPAYMENT, reportResponse.getDatePayment());
						} else {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.DATEPAYMENT, "");
						}

						if (reportResponse.getAmountBorrowed() != null) {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.AMOUNTAPPROVED,
									new BigDecimal(reportResponse.getAmountBorrowed()));
						} else {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.AMOUNTAPPROVED, new BigDecimal(0));
						}

						if (reportResponse.getGroup() != null) {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.GROUPNAME, reportResponse.getGroup());
						} else {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.GROUPNAME, "");
						}

						reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.CURRENTCYCLE, reportResponse.getCycle());

						if (reportResponse.getBranchOffice() != null) {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.BRANCHOFFICE,
											reportResponse.getBranchOffice());
						} else {
							reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.BRANCHOFFICE, "");
						}

						reportResponseEntity.set(com.cobiscorp.cobis.loans.model.GeneralInformation.CODE, reportResponse.getCode());
					}
				}
			} else {
				for (Message message : response.getMessages()) {
					arg1.getMessageManager().showInfoMsg(message.getMessage());
				}
			}
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				ExceptionUtils.showError(
						ExceptionMessage.Clients.REPORT_CLEARANCESHEET_HEAD, e,
						arg1, LOGGER);
		}
	}

	public void getClearanceSheetDetail(DynamicRequest entities, int idCredit,
			IDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportClearanceSheet -- getClearanceSheetDetail - idCredit:"
					+ idCredit);

		String serviceId = "LoanGroup.ReportMaintenance.SettlementSheetDetail";

		try {

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			cobiscorp.ecobis.loangroup.dto.ReportRequest requestInReportRequest = new cobiscorp.ecobis.loangroup.dto.ReportRequest();

			// requestInReportRequest.setTramite(clearanceSheet.get(com.cobiscorp.cobis.loans.model.ClearanceSheet.LOAN));
			requestInReportRequest.setTramite(idCredit);
			// Invocación de servicio
			serviceRequest.addValue("inReportRequest", requestInReportRequest);

			// Ejecución de servicio
			ServiceResponse response = this.execute(LOGGER, serviceId,
					serviceRequest);
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-------> ReportClearanceSheet -- getClearanceSheetDetail -- response.isResult(): "
						+ response.isResult());

			// Mapeo de respuesta
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {

					cobiscorp.ecobis.loangroup.dto.ReportResponse[] reportResponseList = (cobiscorp.ecobis.loangroup.dto.ReportResponse[]) resultado
							.getValue("returnReportResponse");

					LOGGER.logDebug("------->ReportClearanceSheet Detalle--reportResponseList: :"
							+ reportResponseList);
					if (reportResponseList != null) {
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("------->ReportClearanceSheet Detalle--reportResponseList.lenght: :"
									+ reportResponseList.length);

						DataEntityList reportResponseEntityList = new DataEntityList();

						int num = 0;

						for (cobiscorp.ecobis.loangroup.dto.ReportResponse reportResponseDTO : reportResponseList) {
							DataEntity reportResponseEntity = new DataEntity();

							reportResponseEntity.set(ClearanceSheet.NUMBERCLEARANCE, ++num);
							if (reportResponseDTO.getLoan() != null) {
								reportResponseEntity.set(ClearanceSheet.LOAN, reportResponseDTO.getLoan());
							} else {
								reportResponseEntity.set(ClearanceSheet.LOAN, "");
							}

							if (reportResponseDTO.getClient() != null) {
								reportResponseEntity.set(ClearanceSheet.NAMECUSTOMER, reportResponseDTO.getClient());
							} else {
								reportResponseEntity.set(ClearanceSheet.NAMECUSTOMER, "");
							}

							if (reportResponseDTO.getAmountApproved() != null) {
								reportResponseEntity.set(ClearanceSheet.AMOUNTAPPROVED, new BigDecimal(reportResponseDTO.getAmountApproved()));
							} else {
								reportResponseEntity.set(ClearanceSheet.AMOUNTAPPROVED, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getValuesDiscounting() != null) {
								reportResponseEntity.set(ClearanceSheet.VALUESDISCOUNTING, new BigDecimal(reportResponseDTO.getValuesDiscounting()));
							} else {
								reportResponseEntity.set(ClearanceSheet.VALUESDISCOUNTING, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getSaving() != null) {
								reportResponseEntity.set(ClearanceSheet.SAVING, new BigDecimal(reportResponseDTO.getSaving()));
							} else {
								
								reportResponseEntity.set(ClearanceSheet.SAVING, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getIncentive() != null) {
								reportResponseEntity.set(ClearanceSheet.INCENTIVE, new BigDecimal(reportResponseDTO.getIncentive()));
							} else {
								reportResponseEntity.set(ClearanceSheet.INCENTIVE, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getNetToDeliver() != null) {
								reportResponseEntity.set(ClearanceSheet.NETTODELIVER, reportResponseDTO.getNetToDeliver().toString());
							} else {
								reportResponseEntity.set(ClearanceSheet.NETTODELIVER, "");
							}

							if (reportResponseDTO.getCheck() != null) {
								reportResponseEntity.set(ClearanceSheet.CHECKCLEARANCE, reportResponseDTO.getCheck());
							} else {
								reportResponseEntity.set(ClearanceSheet.CHECKCLEARANCE, "");
							}

							reportResponseEntity.set(ClearanceSheet.SIGNATURE, "");

							reportResponseEntityList.add(reportResponseEntity);

						}
						entities.setEntityList(ClearanceSheet.ENTITY_NAME, reportResponseEntityList);
					}
				}
			} else {
				for (Message message : response.getMessages()) {
					arg1.getMessageManager().showInfoMsg(message.getMessage());
				}
			}
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				ExceptionUtils.showError(
						ExceptionMessage.Clients.REPORT_CLEARANCESHEET_DETAIL,
						e, arg1, LOGGER);
		}
	}
}
