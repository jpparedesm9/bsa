package com.cobiscorp.cobis.asscr.customevents.form.events;

import java.util.List;

import com.cobiscorp.cobis.asscr.model.Amount;
import com.cobiscorp.cobis.asscr.model.CallCenterQuestion;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.services.CallCenterQuestionsManager;

import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchCallCenterQuestions extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(SearchCallCenterQuestions.class);

	public SearchCallCenterQuestions(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		logger.logDebug("executeDataEvent SearchCallCenterQuestion");
		DataEntityList listCallCenterQuestions = new DataEntityList();
		CallCenterQuestionRequest callCenter = new CallCenterQuestionRequest();
		int codigoCliente = 0;
		logger.logDebug("codigoClienteAntes: " + arg0.getData().get("clientCode"));
		if (arg0.getData().get("clientCode") != null) {
			codigoCliente = (Integer) arg0.getData().get("clientCode");
			logger.logDebug("codigoCliente: " + codigoCliente);
		}
		callCenter.setIdCliente(codigoCliente);
		logger.logDebug("data: " + arg0.getData().toString());
		try {
			if (codigoCliente != 0) {
				logger.logDebug("--------------->>> Inicia busqueda de Preguntas por Cliente");
				CallCenterQuestionsManager callCenterQuestionsManager = new CallCenterQuestionsManager(getServiceIntegration());
				CallCenterQuestionResponse[] questionList = callCenterQuestionsManager.searchCallCenterQuestion(callCenter, arg1);
				if (questionList != null) {
					logger.logDebug("Entra a mapear lista de documentos");

					for (CallCenterQuestionResponse questions : questionList) {
						DataEntity questionEntity = new DataEntity();
						questionEntity.set(CallCenterQuestion.IDQUESTION, questions.getIdQuestion());
						questionEntity.set(CallCenterQuestion.QUESTION, questions.getQuestion());
						questionEntity.set(CallCenterQuestion.TYPEANSWER, questions.getTypeRes());
						questionEntity.set(CallCenterQuestion.NOTENGO, questions.getNoTengo());
						listCallCenterQuestions.add(questionEntity);
					}
					logger.logDebug("questionList  Size>>" + listCallCenterQuestions.size());
				}
			}
		} catch (Exception e) {
			logger.logDebug("Error" + e);
		}
		return listCallCenterQuestions.getDataList();

	}

}
