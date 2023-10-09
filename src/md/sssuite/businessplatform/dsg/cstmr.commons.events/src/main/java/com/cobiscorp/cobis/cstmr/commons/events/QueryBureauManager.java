package com.cobiscorp.cobis.cstmr.commons.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;
import com.cobiscorp.ecobis.customer.commons.prospect.services.ProspectManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.ProspectReportResponse;

public class QueryBureauManager extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(QueryBureauManager.class);

	public QueryBureauManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void queryBureau(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs,
			String type) throws Exception {
		String wDeb = ">>>QueryBureauManager -- queryBureau -- ";

		DataEntity person = dynamicRequest.getEntity(Person.ENTITY_NAME);
		DataEntity naturalPerson = dynamicRequest.getEntity(NaturalPerson.ENTITY_NAME);
		DataEntity context = dynamicRequest.getEntity(Context.ENTITY_NAME);
		Integer sequential = null;
		Integer daysValidityBureau = null;

		Boolean executeCallToSantander = true; // Para que no envie tambien error de Santander si falla Buro
		Boolean callUpdateServGenerReport = true; // Para enviar a actualizar los campos de reporte y conocer cual
													// reporte debe
													// ejecutarse
		context.set(Context.GENERATEREPORT, true);
		Integer channel = context.get(Context.CHANNEL);

		if ("CUSTOMER".equals(type)) {
			sequential = person.get(Person.PERSONSECUENTIAL);
		} else {
			sequential = naturalPerson.get(NaturalPerson.PERSONSECUENTIAL);
		}
		ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
		ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
		validationProspectRequest.setCustomerId(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
		validationProspectRequest.setChannel(channel);
		validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);

		// Listas negras y negative file
		boolean next = true;
		ServiceResponse serviceResponseBlackList = this.execute(LOGGER,
				"OrchestrationClientValidationServiceSERVImpl.blackListValidation",
				new Object[] { validationProspectServiceRequest });

		if (serviceResponseBlackList.isResult()) {
			OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponseBlackList
					.getData();
			BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(
						"QueryBureauManager-->queryBureau-->buroExecutionResponseBlackList" + buroExecutionResponse);
			}

			if (buroExecutionResponse == null) {
				iExecuteCommandEventArgs.setSuccess(false);
				LOGGER.logDebug("Error al Consultar Listas Negras o Negative File");
				iExecuteCommandEventArgs.getMessageManager()
						.showErrorMsg("Problema al Consultar Listas Negras o Negative File");
				next = false;
			}

			if (buroExecutionResponse != null && buroExecutionResponse.getListBlackCustomer() != null
					&& buroExecutionResponse.getListBlackCustomer() == 3) {
				naturalPerson.set(NaturalPerson.HASLISTBLACK, true);
				naturalPerson.set(NaturalPerson.INDIVIDUALRISK, buroExecutionResponse.getRuleIndividualRiskResult());// Letra
				naturalPerson.set(NaturalPerson.RISKLEVEL, buroExecutionResponse.getRuleExecutionResult());// Color

				next = false;
				context.set(Context.GENERATEREPORT, false);

				LOGGER.logDebug("QueryBureauManager-->El cliente " + naturalPerson.get(NaturalPerson.PERSONSECUENTIAL)
						+ " se encuentra en listas Negras o negative File, no continua");
			}
		} else {
			iExecuteCommandEventArgs.getMessageManager()
					.showErrorMsg("Problema al Consultar Listas Negras o Negative File");
			next = false;
		}

		LOGGER.logDebug(wDeb + "next: " + next);

		if (next) {
			com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER,
					"OrchestrationClientValidationServiceSERVImpl.validate",
					new Object[] { validationProspectServiceRequest });

			if (serviceResponse.isResult()) {
				OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse
						.getData();
				BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("buroExecutionResponse" + buroExecutionResponse);
				}

				if (buroExecutionResponse != null) {
					daysValidityBureau = buroExecutionResponse.getValidityDaysBureau();
					LOGGER.logDebug("Se omite creditBureau porque se elimina riskScore");
					// naturalPerson.set(NaturalPerson.CREDITBUREAU,
					// String.valueOf(buroExecutionResponse.getRiskScore()));

					naturalPerson.set(NaturalPerson.RISKLEVEL, buroExecutionResponse.getRuleExecutionResult());
					naturalPerson.set(NaturalPerson.INDIVIDUALRISK,
							buroExecutionResponse.getRuleIndividualRiskResult());
					LOGGER.logDebug("buroExecutionResponse.getListBlackCustomer()-->"
							+ buroExecutionResponse.getListBlackCustomer());
					if ("CUSTOMER".equals(type)) {
						if (buroExecutionResponse.getListBlackCustomer() != null) {
							if (buroExecutionResponse.getListBlackCustomer() == 1) {
								naturalPerson.set(NaturalPerson.HASLISTBLACK, false);
							} else {
								if (buroExecutionResponse.getListBlackCustomer() == 3) {
									naturalPerson.set(NaturalPerson.HASLISTBLACK, true);
								}
							}
						}
					}

					if (buroExecutionResponse.getProblemConsultingBuro() != null) {
						LOGGER.logDebug("QueryBureau-buroExecutionResponse.getProblemConsultingBuro():"
								+ buroExecutionResponse.getProblemConsultingBuro());
						if (buroExecutionResponse.getProblemConsultingBuro()) {
							context.set(Context.GENERATEREPORT, false);
							iExecuteCommandEventArgs.setSuccess(false);
							executeCallToSantander = false;
							callUpdateServGenerReport = false;
							LOGGER.logDebug("Error de Conexión con Buró-problema al consultar a buro");
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error de Conexión con Buró");
						}
					}

					if (buroExecutionResponse.getRuleExecutionResult() != null) {
						if (buroExecutionResponse.getRuleIndividualRiskResult().trim().equals("F")) {
							LOGGER.logDebug("Cliente no es candidato a credito-Resultado Diferente a F-"
									+ buroExecutionResponse.getRuleExecutionResult());
							iExecuteCommandEventArgs.getMessageManager()
									.showErrorMsg("CSTMR.LBL_CSTMR_ELNIVELUT_98836"); // El cliente no es candidato a
																						// credito
							executeCallToSantander = false;
						}
					}

				} else {
					executeCallToSantander = false;
					iExecuteCommandEventArgs.setSuccess(false);
					LOGGER.logDebug("Error de Conexión con Buró");
					iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error de Conexión con Buró");
				}

				LOGGER.logDebug("QueryBureau-hubo error de buro-GeneraReporte:" + context.get(Context.GENERATEREPORT));
				LOGGER.logDebug("QueryBureau-executeCallToSantander:" + executeCallToSantander);

				if (executeCallToSantander) {
					CustomerCoreInfo santanderExecutionResponse = orchestrationClientValidationResponse
							.getCustomerCoreInfo();
					LOGGER.logDebug("santanderExecutionResponse" + santanderExecutionResponse);
					if (santanderExecutionResponse != null) {
						naturalPerson.set(NaturalPerson.ACCOUNTINDIVIDUAL,
								santanderExecutionResponse.getCustomerAccountId());
						naturalPerson.set(NaturalPerson.SANTANDERCODE, santanderExecutionResponse.getCustomerStdCode());
						if ("CUSTOMER".equals(type)) {
							person.set(Person.SANTANDERCODE, santanderExecutionResponse.getCustomerStdCode());
						}
						if (santanderExecutionResponse.getCustomerStdCode() == null
								|| santanderExecutionResponse.getCustomerAccountId() == null) {
							LOGGER.logDebug("No tiene cuenta en Santander");
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg("No tiene cuenta en Santander");
						}
					} else {
						iExecuteCommandEventArgs.setSuccess(false);
						LOGGER.logDebug("Error al consultar datos de Santander");
						iExecuteCommandEventArgs.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_ELCLIENOA_33448");
					}
				} else {
					LOGGER.logDebug("QueryBureau-No llamo a Ejecución Santander");
				}
			} else {
				iExecuteCommandEventArgs.getMessageManager()
						.showErrorMsg(serviceResponse.getMessages().get(0).getMessage());
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia Reporte");
			}

			NaturalProspectRequest prospectRequest = new NaturalProspectRequest();
			prospectRequest.setProspectId(sequential);
			prospectRequest.setValidityDaysBureau(daysValidityBureau);

			LOGGER.logDebug("QueryBureau-callUpdateServGenerReport:" + callUpdateServGenerReport);
			if (callUpdateServGenerReport) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Inicia Reporte queryReportBureau");
				}

				ProspectManager prospectManager = new ProspectManager(getServiceIntegration());
				ProspectReportResponse reportResponse = prospectManager.queryReportBureau(prospectRequest,
						iExecuteCommandEventArgs);

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Fin Reporte queryReportBureau");
				}

				// Añadir reporte
				// BuroCreditoHistorico.jrxml
				// BuroCreditoInternoExterno.jrxml

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Llamada Reporte");
				}

				context.set(Context.NAMEREPORT, reportResponse.getNameReport());
				context.set(Context.PRINTREPORT, ("S".equals(reportResponse.getPrintReport()) ? true : false));

				dynamicRequest.setEntity(Business.ENTITY_NAME, context);

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Termina Reporte");
				}
			} else {
				iExecuteCommandEventArgs.getMessageManager()
						.showErrorMsg(serviceResponse.getMessages().get(0).getMessage());
			}
		}
	}
}
