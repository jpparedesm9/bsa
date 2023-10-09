package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DataVerificationManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.QuestionsPartOne;
import com.cobiscorp.cobis.busin.model.QuestionsPartThree;
import com.cobiscorp.cobis.busin.model.QuestionsPartTwo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class Compute extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(Compute.class);

	public Compute(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		LOGGER.logDebug("---->> Inicio - Compute ");

		try {
			DataEntityList questionsPartOne = entities.getEntityList(QuestionsPartOne.ENTITY_NAME);
			DataEntityList questionsPartTwo = entities.getEntityList(QuestionsPartTwo.ENTITY_NAME);
			DataEntity questionsPartThree = entities.getEntity(QuestionsPartThree.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());

			String type = context.get(Context.TYPE);
			LOGGER.logDebug("Imprimo el tipo de Producto: " + type);

			String answer = "";
			String part1 = "";
			for (DataEntity dataEntity : questionsPartOne) {
				part1 = part1 + dataEntity.get(QuestionsPartOne.ANSWER) + ";";
			}
			String part2 = "";
			for (DataEntity dataEntity : questionsPartTwo) {
				part2 = part2 + dataEntity.get(QuestionsPartOne.ANSWER) + ";";
			}

			String part3 = "";

			part3 = questionsPartThree.get(QuestionsPartThree.HAVEEMAILANSWER) + ";";
			part3 = part3 + questionsPartThree.get(QuestionsPartThree.FREQUENCYUSEEMANSWER) + ";";
			part3 = part3 + questionsPartThree.get(QuestionsPartThree.SOCIALNETWORKSANSWER) + ";";
			part3 = part3 + questionsPartThree.get(QuestionsPartThree.CELLTYPEANSWER) + ";";
			part3 = part3 + questionsPartThree.get(QuestionsPartThree.PAYMENTMETHODPHONEANSWER);

			answer = part1 + part2 + part3;

			LOGGER.logDebug("Imprimo la respuesta completa: " + answer);

			DataVerificationManagement dataVerificationManagement = new DataVerificationManagement(getServiceIntegration());

			DataVerificationRequest dataVerificationRequest = new DataVerificationRequest();
			dataVerificationRequest.setAnswer(answer);
			dataVerificationRequest.setCustomerId(context.get(Context.CUSTOMERID));
			dataVerificationRequest.setResult(questionsPartThree.get(QuestionsPartThree.RESULT));
			dataVerificationRequest.setApplicationCode(context.get(Context.REQUESTID));

			if (!dataVerificationManagement.updateDataVerification(dataVerificationRequest, arg1, new BehaviorOption(false, false))) {
				arg1.getMessageManager().showErrorMsg("Error al Calcular");
			} else {
				LOGGER.logDebug("----->>>Compute: Ingresa al Else");
				DataVerificationRequest dataVerificationRequestP3 = new DataVerificationRequest();

				dataVerificationRequestP3.setMode(3);

				dataVerificationRequestP3.setApplicationCode(context.get(Context.REQUESTID));
				dataVerificationRequestP3.setCustomerId(context.get(Context.CUSTOMERID));

				DataVerificationResponse[] dataVerificationResponse = dataVerificationManagement.searchDataVerification(dataVerificationRequestP3, arg1, new BehaviorOption(false, false));
				questionsPartThree.set(QuestionsPartThree.RESULT, dataVerificationResponse[0].getResult());

				LOGGER.logDebug("----->>>Compute: -- Valor del Resultado:" + dataVerificationResponse[0].getResult());
				Integer resultadoParam = catalogMngmnt.getValueQuestionnaireResponse(type, arg1);
				LOGGER.logDebug("---->Entra al Save_CM_TBUSINSF_3N8 Busqueda de Integrantes - resultadoParam " + resultadoParam);

				if (resultadoParam != null) {
					if (dataVerificationResponse[0].getResult() < resultadoParam && (type.equals("GRUPAL"))) {
						arg1.getMessageManager().showErrorMsg("Es resultado Grupal es menor a " + resultadoParam);
						arg1.setSuccess(false);
					} else if (dataVerificationResponse[0].getResult() < resultadoParam && (type.equals("INDIVIDUAL"))) {
						arg1.getMessageManager().showErrorMsg("Es resultado Individual es menor a " + resultadoParam);
						arg1.setSuccess(false);
					} else {
						arg1.setSuccess(true);
					}
				} else {
					arg1.getMessageManager().showErrorMsg("No existe parámetro para comparar el resultado");
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.COMPUTE, e, arg1, LOGGER);
		}

	}
}
