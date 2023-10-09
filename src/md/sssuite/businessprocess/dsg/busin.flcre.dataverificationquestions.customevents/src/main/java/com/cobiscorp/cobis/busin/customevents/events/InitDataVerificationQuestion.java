package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DataVerificationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.QuestionsPartOne;
import com.cobiscorp.cobis.busin.model.QuestionsPartThree;
import com.cobiscorp.cobis.busin.model.QuestionsPartTwo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataVerificationQuestion extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataVerificationQuestion.class);

	public InitDataVerificationQuestion(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Integrantes");

		try {

			DataEntity eQuestionPartThree = entities.getEntity(QuestionsPartThree.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);

			DataVerificationManagement dataVerificationManagement = new DataVerificationManagement(getServiceIntegration());
			DataVerificationRequest dataVerificationRequestP1 = new DataVerificationRequest();
			int idApplication = context.get(Context.REQUESTID); // id del tramite
			String nameActivity = context.get(Context.APPLICATIONSUBJECT);
			LOGGER.logDebug("------>> Consulta a la sincronización");
			SynchronizationManagement synchronizationManagement = new SynchronizationManagement(getServiceIntegration());
			SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
			SynchronizationResponse synchronizationResponse = new SynchronizationResponse();

			synchronizationRequest.setApplicationNumber(idApplication);
			synchronizationRequest.setNameActivity(nameActivity);

			synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, arg1, new BehaviorOption(false, false));

			if (synchronizationResponse != null) {
				if (synchronizationResponse.getSynchronization() == null) {
					context.set(Context.ENABLE, "N");
				}

			}
			LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 1");

			// Envio de Datos Parte 1
			dataVerificationRequestP1.setMode(1);
			dataVerificationRequestP1.setApplicationCode(context.get(Context.REQUESTID));
			dataVerificationRequestP1.setCustomerId(context.get(Context.CUSTOMERID));

			DataVerificationResponse[] dataVerificationResponseP1 = dataVerificationManagement.searchDataVerification(dataVerificationRequestP1, arg1, new BehaviorOption(false, false));
			if (dataVerificationResponseP1 != null) {
				DataEntityList questionsPartOneEntity = new DataEntityList();

				for (DataVerificationResponse qp1 : dataVerificationResponseP1) {
					DataEntity eQuestionPartOne = new DataEntity();
					eQuestionPartOne.set(QuestionsPartOne.NUMBER, qp1.getCode());
					eQuestionPartOne.set(QuestionsPartOne.DESCRIPTION, qp1.getQuestion().trim());
					eQuestionPartOne.set(QuestionsPartOne.ANSWER, qp1.getAnswer().trim());
					questionsPartOneEntity.add(eQuestionPartOne);
				}
				LOGGER.logDebug(":>:>eQuestionPartOne -> eQuestionPartOne:>:>" + questionsPartOneEntity.getDataList());
				entities.setEntityList(QuestionsPartOne.ENTITY_NAME, questionsPartOneEntity);
			}

			LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 2");
			DataVerificationRequest dataVerificationRequestP2 = new DataVerificationRequest();
			dataVerificationRequestP2.setMode(2);
			dataVerificationRequestP2.setApplicationCode(context.get(Context.REQUESTID));
			dataVerificationRequestP2.setCustomerId(context.get(Context.CUSTOMERID));

			DataVerificationResponse[] dataVerificationResponseP2 = dataVerificationManagement.searchDataVerification(dataVerificationRequestP2, arg1, new BehaviorOption(false, false));
			if (dataVerificationResponseP2 != null) {
				DataEntityList questionsPartTwoEntity = new DataEntityList();

				for (DataVerificationResponse qp1 : dataVerificationResponseP2) {
					DataEntity eQuestionPartTwo = new DataEntity();
					eQuestionPartTwo.set(QuestionsPartTwo.NUMBER, qp1.getCode());
					eQuestionPartTwo.set(QuestionsPartTwo.DESCRIPTION, qp1.getQuestion().trim());
					eQuestionPartTwo.set(QuestionsPartTwo.ANSWER, qp1.getAnswer().trim());
					questionsPartTwoEntity.add(eQuestionPartTwo);
				}
				LOGGER.logDebug(":>:>eQuestionPartTwo -> eQuestionPartTwo:>:>" + questionsPartTwoEntity.getDataList());
				entities.setEntityList(QuestionsPartTwo.ENTITY_NAME, questionsPartTwoEntity);
			}

			LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3");
			DataVerificationRequest dataVerificationRequestP3 = new DataVerificationRequest();
			dataVerificationRequestP3.setMode(3);
			dataVerificationRequestP3.setApplicationCode(context.get(Context.REQUESTID));
			dataVerificationRequestP3.setCustomerId(context.get(Context.CUSTOMERID));

			DataVerificationResponse[] dataVerificationResponse = dataVerificationManagement.searchDataVerification(dataVerificationRequestP3, arg1, new BehaviorOption(false, false));
			if (dataVerificationResponse != null) {
				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo");

				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo - P1: " + dataVerificationResponse[0].getQuestion());
				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo - P2: " + dataVerificationResponse[1].getQuestion());
				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo - P3: " + dataVerificationResponse[2].getQuestion());
				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo - P4: " + dataVerificationResponse[3].getQuestion());

				// DataEntity eQuestionPartThree = new DataEntity();

				eQuestionPartThree.set(QuestionsPartThree.CODEQUESTION1, dataVerificationResponse[0].getCode());
				eQuestionPartThree.set(QuestionsPartThree.HAVEEMAIL, dataVerificationResponse[0].getQuestion());
				eQuestionPartThree.set(QuestionsPartThree.HAVEEMAILANSWER, dataVerificationResponse[0].getAnswer());
				eQuestionPartThree.set(QuestionsPartThree.RESULT, dataVerificationResponse[0].getResult());

				eQuestionPartThree.set(QuestionsPartThree.CODEQUESTION2, dataVerificationResponse[1].getCode());
				eQuestionPartThree.set(QuestionsPartThree.FREQUENCYUSEEM, dataVerificationResponse[1].getQuestion());
				eQuestionPartThree.set(QuestionsPartThree.FREQUENCYUSEEMANSWER, dataVerificationResponse[1].getAnswer());

				eQuestionPartThree.set(QuestionsPartThree.CODEQUESTION3, dataVerificationResponse[2].getCode());
				eQuestionPartThree.set(QuestionsPartThree.SOCIALNETWORKS, dataVerificationResponse[2].getQuestion());
				eQuestionPartThree.set(QuestionsPartThree.SOCIALNETWORKSANSWER, dataVerificationResponse[2].getAnswer());

				eQuestionPartThree.set(QuestionsPartThree.CODEQUESTION4, dataVerificationResponse[3].getCode());
				eQuestionPartThree.set(QuestionsPartThree.CELLTYPE, dataVerificationResponse[3].getQuestion());
				eQuestionPartThree.set(QuestionsPartThree.CELLTYPEANSWER, dataVerificationResponse[3].getAnswer());

				eQuestionPartThree.set(QuestionsPartThree.CODEQUESTION5, dataVerificationResponse[4].getCode());
				eQuestionPartThree.set(QuestionsPartThree.PAYMENTMETHODPHONE, dataVerificationResponse[4].getQuestion());
				eQuestionPartThree.set(QuestionsPartThree.PAYMENTMETHODPHONEANSWER, dataVerificationResponse[4].getAnswer().trim());

				LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Envio Parte 3 - Nuevo - P1**: " + eQuestionPartThree.get(QuestionsPartThree.HAVEEMAIL));

			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.INITDATA_QUESTIONS, e, arg1, LOGGER);
		}
	}
}
