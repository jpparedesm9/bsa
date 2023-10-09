package com.cobiscorp.cobis.loans.customevents.events;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.CreditSummary;
import com.cobiscorp.cobis.loans.model.InformationGroup;
import com.cobiscorp.cobis.loans.model.PaymentPlan;
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

public class ReportGroupAccountStatement extends BaseEvent implements
		IInitDataEvent {

	private static ILogger LOGGER = LogFactory
			.getLogger(ReportGroupAccountStatement.class);

	public ReportGroupAccountStatement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------->ReportGroupAccountStatement -- Ingreso*");
			LOGGER.logDebug("-------> ReportGroupAccountStatement -- arg1 ****"
					+ arg1.getParameters().getCustomParameters()
							.get("IDRequested"));
			LOGGER.logDebug("------->ReportGroupAccountStatement -- Ingreso - entities**"
					+ entities.getData());
		}
		int idCredit = (Integer) arg1.getParameters().getCustomParameters()
				.get("IDRequested");

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("------->ReportGroupAccountStatement -- Ingreso - idCredit**"
					+ idCredit);

		getInformationGroup(entities, idCredit, arg1);
		getCreditSummary(entities, idCredit, arg1);
		getPlaymentPlan(entities, idCredit, arg1);

	}

	public void getInformationGroup(DynamicRequest entities, int idCredit,
			IDataEventArgs arg1) {
		// Id de Servicio
		String serviceId = "LoanGroup.ReportMaintenance.GroupAccountHeader";

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportGroupAccountStatement -- getInformationGroup - idCredit: "
					+ idCredit);

		try {

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			cobiscorp.ecobis.loangroup.dto.ReportRequest requestInReportRequest = new cobiscorp.ecobis.loangroup.dto.ReportRequest();

			// requestInReportRequest.setTramite(informationGroup.get(com.cobiscorp.cobis.loans.model.InformationGroup.GROUPID).intValue());
			requestInReportRequest.setTramite(idCredit);

			serviceRequest.addValue("inReportRequest", requestInReportRequest);

			ServiceResponse response = this.execute(LOGGER, serviceId,
					serviceRequest);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-->ReportGroupAccountStatement -- getInformationGrou -- response.isResult():"
						+ response.isResult());

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("-->ReportGroupAccountStatement -- getInformationGrou -- response.isResult():"
							+ resultado);

				if (resultado.isSuccess()) {

					cobiscorp.ecobis.loangroup.dto.ReportResponse reportResponse = (cobiscorp.ecobis.loangroup.dto.ReportResponse) resultado
							.getValue("returnReportResponse");

					DataEntity reportResponseEntity = entities.getEntity(InformationGroup.ENTITY_NAME);

					if (reportResponse != null) {
						if (reportResponse.getAdviser() != null) {
							reportResponseEntity.set(InformationGroup.ADVISER, reportResponse.getAdviser());
						} else {
							reportResponseEntity.set(InformationGroup.ADVISER, "");
						}
						if (reportResponse.getAdviser() != null) {
							reportResponseEntity.set(InformationGroup.ADVISER, reportResponse.getAdviser());
						} else {
							reportResponseEntity.set(InformationGroup.ADVISER, "");
						}

						if (reportResponse.getAmountBorrowed() != null) {
							reportResponseEntity.set(InformationGroup.AMOUNTBORROWED, reportResponse.getAmountBorrowed());
						} else {
							reportResponseEntity.set(InformationGroup.AMOUNTBORROWED, 0.0);
						}

						if (reportResponse.getBranchOffice() != null) {
							reportResponseEntity.set(InformationGroup.BRANCHOFFICE, reportResponse.getBranchOffice());
						} else {
							reportResponseEntity.set(InformationGroup.BRANCHOFFICE, "");
						}

						reportResponseEntity.set(InformationGroup.CYCLE, reportResponse.getCycle());

						if (reportResponse.getGroup() != null) {
							reportResponseEntity.set(InformationGroup.GROUPNAME, reportResponse.getGroup());
						} else {
							reportResponseEntity.set(InformationGroup.GROUPNAME, "");
						}

						if (reportResponse.getDestination() != null) {
							reportResponseEntity.set(InformationGroup.DESTINATION, reportResponse.getDestination());
						} else {
							reportResponseEntity.set(InformationGroup.DESTINATION, "");
						}

						if (reportResponse.getGroupMeetings() != null) {
							reportResponseEntity.set(InformationGroup.GROUPMEETING, reportResponse.getGroupMeetings());
						} else {
							reportResponseEntity.set(InformationGroup.GROUPMEETING, "");
						}

						if (reportResponse.getTerm() != null) {
							reportResponseEntity.set(InformationGroup.TERM, reportResponse.getTerm());
						} else {
							reportResponseEntity.set(InformationGroup.TERM, "");
						}

						reportResponseEntity.set(InformationGroup.INTERESTRATE, reportResponse.getInterestRate());
						if (reportResponse.getDeliverDate() != null) {
							reportResponseEntity.set(InformationGroup.DELIVERDATE, reportResponse.getDeliverDate());
						} else {
							reportResponseEntity.set(InformationGroup.DELIVERDATE, "");
						}

					}

				}
			} else {
				for (Message message : response.getMessages()) {
					arg1.getMessageManager().showInfoMsg(message.getMessage());
				}
			}

		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				ExceptionUtils
						.showError(
								ExceptionMessage.Clients.REPORT_GROUP_ACCOUNT_STATEMENT,
								e, arg1, LOGGER);
		}
	}

	public void getCreditSummary(DynamicRequest entities, int idCredit,
			IDataEventArgs arg1) {
		// Id de Servicio

		String serviceId = "LoanGroup.ReportMaintenance.GroupAccountSummary";

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportGroupAccountStatement -- getCreditSummary - idCredit: "
					+ idCredit);

		try {

			cobiscorp.ecobis.loangroup.dto.ReportRequest requestInReportRequest = new cobiscorp.ecobis.loangroup.dto.ReportRequest();

			requestInReportRequest.setTramite(idCredit);

			// Invocación de servicio
			serviceRequest.addValue("inReportRequest", requestInReportRequest);

			// Ejecución de servicio
			ServiceResponse response = this.execute(LOGGER, serviceId,
					serviceRequest);

			// Mapeo de respuesta
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-------> ReportGroupAccountStatement -- getCreditSummary - response:"
						+ response);

			if (response.isResult()) {

				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("-------> ReportGroupAccountStatement -- getCreditSummary - resultado:"
							+ resultado);

				if (resultado.isSuccess()) {

					cobiscorp.ecobis.loangroup.dto.ReportResponse[] reportResponseList = (cobiscorp.ecobis.loangroup.dto.ReportResponse[]) resultado
							.getValue("returnReportResponse");

					if (reportResponseList != null) {
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("-------> ReportGroupAccountStatement -- getCreditSummary - reportResponseList.len:"
									+ reportResponseList.length);

						DataEntity reportResponseEntity = new DataEntity();
						DataEntityList reportResponseEntityList = new DataEntityList();

						for (cobiscorp.ecobis.loangroup.dto.ReportResponse reportResponseDTO : reportResponseList) {
							reportResponseEntity = new DataEntity();
							reportResponseEntity.set(CreditSummary.CURRENCYBALANCE, reportResponseDTO.getCurrencyBalance());
							reportResponseEntity.set(CreditSummary.BEGINNINGBALANCE, reportResponseDTO.getBeginningBalance());
							reportResponseEntity.set(CreditSummary.EXPIRED, reportResponseDTO.getExpired());
							reportResponseEntity.set(CreditSummary.CONCEPT, reportResponseDTO.getConcept());
							reportResponseEntity.set(CreditSummary.PAYMENT, reportResponseDTO.getPayment());
							reportResponseEntityList.add(reportResponseEntity);
						}
						entities.setEntityList(CreditSummary.ENTITY_NAME, reportResponseEntityList);
					}

				}
			} else {
				for (Message message : response.getMessages()) {
					arg1.getMessageManager().showInfoMsg(message.getMessage());
				}
			}
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				ExceptionUtils
						.showError(
								ExceptionMessage.Clients.REPORT_GROUP_ACCOUNT_CREDIT_SUMMARY,
								e, arg1, LOGGER);
		}

	}

	public void getPlaymentPlan(DynamicRequest entities, int idCredit,
			IDataEventArgs arg1) {
		// Id de Servicio
		String serviceId = "LoanGroup.ReportMaintenance.GroupAccount";

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-------> ReportGroupAccountStatement -- getPlaymentPlan - idCredit: "
					+ idCredit);

		try {

			cobiscorp.ecobis.loangroup.dto.ReportRequest requestInReportRequest = new cobiscorp.ecobis.loangroup.dto.ReportRequest();

			requestInReportRequest.setTramite(idCredit);

			// Invocación de servicio
			serviceRequest.addValue("inReportRequest", requestInReportRequest);

			// Ejecución de servicio
			ServiceResponse response = this.execute(LOGGER, serviceId,
					serviceRequest);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-------> ReportGroupAccountStatement -- getPlaymentPlan - response:"
						+ response);

			// Mapeo de respuesta
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("-------> ReportGroupAccountStatement -- getPlaymentPlan - resultado:"
							+ resultado);

				if (resultado.isSuccess()) {

					cobiscorp.ecobis.loangroup.dto.ReportResponse[] reportResponseList = (cobiscorp.ecobis.loangroup.dto.ReportResponse[]) resultado
							.getValue("returnReportResponse");

					if (reportResponseList != null) {
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("-------> ReportGroupAccountStatement -- getPlaymentPlan - reportResponseList.length:"
									+ reportResponseList.length);
						DataEntity reportResponseEntity = new DataEntity();
						DataEntityList reportResponseEntityList = new DataEntityList();

						for (cobiscorp.ecobis.loangroup.dto.ReportResponse reportResponseDTO : reportResponseList) {
							reportResponseEntity = new DataEntity();

							reportResponseEntity.set(PaymentPlan.NUMPAYMENT, reportResponseDTO.getCode());
							if (reportResponseDTO.getDatePayment() != null) {
								reportResponseEntity.set(PaymentPlan.DATEPAYMENT, reportResponseDTO.getDatePayment());
							} else {
								reportResponseEntity.set(PaymentPlan.DATEPAYMENT, "");
							}

							if (reportResponseDTO.getExtraSavings() != null) {
								reportResponseEntity.set(PaymentPlan.EXTRASAVINGS, new BigDecimal(reportResponseDTO.getExtraSavings()));
							} else {
								reportResponseEntity.set(PaymentPlan.EXTRASAVINGS, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getBalance() != null) {
								reportResponseEntity.set(PaymentPlan.BALANCE, new BigDecimal(reportResponseDTO.getBalance()));
							} else {
								reportResponseEntity.set(PaymentPlan.BALANCE, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getInterest() != null) {
								reportResponseEntity.set(PaymentPlan.INTEREST, new BigDecimal(reportResponseDTO.getInterest()));
							} else {
								reportResponseEntity.set(PaymentPlan.INTEREST, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getVoluntarySavings() != null) {
								reportResponseEntity.set(PaymentPlan.VOLUNTARYSAVINGS, new BigDecimal(reportResponseDTO.getVoluntarySavings()));
							} else {
								reportResponseEntity.set(PaymentPlan.VOLUNTARYSAVINGS, BigDecimal.valueOf(0.0));
							}

							if (reportResponseDTO.getCapital() != null) {
								reportResponseEntity.set(PaymentPlan.CAPITAL, new BigDecimal(reportResponseDTO.getCapital()));
							} else {
								reportResponseEntity.set(PaymentPlan.CAPITAL, new BigDecimal(reportResponseDTO.getCapital()));
							}

							if (reportResponseDTO.getOthers() != null) {
								reportResponseEntity.set(PaymentPlan.OTHERS, new BigDecimal(reportResponseDTO.getOthers()));
							} else {
								reportResponseEntity.set(PaymentPlan.OTHERS, BigDecimal.valueOf(0.0));
							}

							reportResponseEntityList.add(reportResponseEntity);
						}
						entities.setEntityList(PaymentPlan.ENTITY_NAME, reportResponseEntityList);
					}
				}
			} else {
				for (Message message : response.getMessages()) {
					arg1.getMessageManager().showInfoMsg(message.getMessage());
				}
			}
		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				ExceptionUtils
						.showError(
								ExceptionMessage.Clients.REPORT_GROUP_ACCOUNT_PLAYMENT_PLAN,
								e, arg1, LOGGER);
		}
	}

	public String convertDateToString(Date date, String format) {
		String dateStr = null;
		DateFormat df = new SimpleDateFormat(format);
		try {
			dateStr = df.format(date);
		} catch (Exception ex) {
			System.out.println(ex);
		}
		return dateStr;
	}
}
