package com.cobiscorp.cobis.busin.customevents.form;

import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Created by ntrujillo on 05/07/2017.
 */
public class QueryBureau extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryBureau.class);

	public QueryBureau(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand in QueryBureau");
		}

		try {

			DataEntity context = dynamicRequest.getEntity(Context.ENTITY_NAME);

			if (context != null) {

				ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();

				ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();

				validationProspectRequest.setCustomerId(context.get(Context.CUSTOMERID));
				validationProspectRequest.setChannel(context.get(Context.CHANNEL));
				validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);

				com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER,
						"OrchestrationClientValidationServiceSERVImpl.validateBuro",
						new Object[] { validationProspectServiceRequest });

				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse
							.getData();

					BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse
							.getBuroResponse();

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("buroExecutionResponse" + buroExecutionResponse);
					}

					//
					if (buroExecutionResponse != null && !buroExecutionResponse.getProblemConsultingBuro()) {
						LOGGER.logDebug("Se omite creditBureau porque se elimina riskScore");
						// naturalPerson.set(NaturalPerson.CREDITBUREAU,
						// String.valueOf(buroExecutionResponse.getRiskScore()));

						// naturalPerson.set(NaturalPerson.RISKLEVEL,
						// buroExecutionResponse.getRuleExecutionResult());
						LOGGER.logDebug("buroExecutionResponse.getListBlackCustomer()-->"
								+ buroExecutionResponse.getListBlackCustomer());

						if (buroExecutionResponse.getListBlackCustomer() == 1) {
							// naturalPerson.set(NaturalPerson.HASLISTBLACK, false);
						} else {
							if (buroExecutionResponse.getListBlackCustomer() == 3) {
								// naturalPerson.set(NaturalPerson.HASLISTBLACK, true);
							}
						}
					} else {
						iExecuteCommandEventArgs.setSuccess(false);

						LOGGER.logDebug("Error de Conexión con Buró");
						iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error de Conexión con Buró");
					}
					/**
					 * REMOVIDO consulta de cuenta Santander CustomerCoreInfo
					 * santanderExecutionResponse =
					 * orchestrationClientValidationResponse.getCustomerCoreInfo(); if
					 * (LOGGER.isDebugEnabled()) { LOGGER.logDebug("santanderExecutionResponse" +
					 * santanderExecutionResponse); } if (santanderExecutionResponse != null) { if
					 * (santanderExecutionResponse.getCustomerStdCode() == null ||
					 * santanderExecutionResponse.getCustomerAccountId() == null) {
					 * LOGGER.logDebug("No tiene cuenta en Santander");
					 * iExecuteCommandEventArgs.getMessageManager().showErrorMsg("No tiene cuenta en
					 * Santander"); } // SE COMENTA POR DEPENDENCIA DE MATRIZ DE RIESGO // try {
					 * QuerRule querySantander = new QuerRule(getServiceIntegration());
					 * querySantander.executeQuerySantanderForClient(context.get(Context.CUSTOMERID));
					 * } catch (Exception e) { iExecuteCommandEventArgs.setSuccess(false);
					 * LOGGER.logError("BusinessException: ", e);
					 * iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error al ejecutar
					 * la Matriz de Riesgo"); } } else { iExecuteCommandEventArgs.setSuccess(false);
					 * LOGGER.logDebug("Error al consultar datos de Santander");
					 * iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error al consultar
					 * datos de Santander"); }
					 */
				} else {
					iExecuteCommandEventArgs.getMessageManager()
							.showErrorMsg(serviceResponse.getMessages().get(0).getMessage());
				}
			} else {
				iExecuteCommandEventArgs.setSuccess(false);
				iExecuteCommandEventArgs.getMessageManager().showErrorMsg("CLIENTE NO EXISTE");
			}
		} catch (BusinessException be) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("BusinessException: ", be);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(be.getMessage());
		} catch (Exception e) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("Exception: ", e);
			System.out.println(e);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(e.getMessage());
		}
	}

}
