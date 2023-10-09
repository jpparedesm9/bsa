package com.cobiscorp.ecobis.frm.business.manager;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.frm.business.dto.AnswerData;
import com.cobiscorp.ecobis.frm.business.dto.ColumnAnswer;
import com.cobiscorp.ecobis.frm.business.dto.Form;
import com.cobiscorp.ecobis.frm.business.dto.FormAnswers;
import com.cobiscorp.ecobis.frm.business.dto.Question;
import com.cobiscorp.ecobis.frm.business.dto.RowAnswer;
import com.cobiscorp.ecobis.frm.business.dto.SaveAnswerResponse;
import com.cobiscorp.ecobis.frm.business.dto.Section;
import com.cobiscorp.ecobis.frm.business.exception.FormBusinessException;
import com.cobiscorp.ecobis.frm.business.util.Constants;
import com.cobiscorp.ecobis.frm.business.util.MappingData;
import com.cobiscorp.ecobis.frm.business.util.RestServiceBase;
import com.cobiscorp.ecobis.frm.business.util.ServiceResponseUtil;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatabusiness.dto.Answer;
import cobiscorp.ecobis.customerdatabusiness.dto.AnswerTable;
import cobiscorp.ecobis.customerdatabusiness.dto.FormData;
import cobiscorp.ecobis.customerdatabusiness.dto.FormQuestion;
import cobiscorp.ecobis.customerdatabusiness.dto.FormRequest;
import cobiscorp.ecobis.customerdatabusiness.dto.FormSection;
import cobiscorp.ecobis.customerdatabusiness.dto.QuestionCatalog;
import cobiscorp.ecobis.customerdatabusiness.dto.TableQuestion;

public class FormManager extends RestServiceBase {
	private static final String ANSWER_REQUEST = "inAnswer";
	private static final String FINISH_SAVE = "F";
	private static final String INIT_SAVE = "I";
	private final ILogger logger = LogFactory.getLogger(FormManager.class);

	public FormManager(ICTSServiceIntegration integration) {
		super(integration);
	}

	public Form getFormData(Integer id, Integer processInstance, String stage) throws FormBusinessException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getFormData Impl");
		}

		ServiceRequestTO serviceRequestTo = new ServiceRequestTO();
		FormRequest formRequest = new FormRequest();
		formRequest.setStage(stage);
		formRequest.setProcessInstance(processInstance);
		serviceRequestTo.addValue("inFormRequest", formRequest);

		ServiceResponse serviceResponse = this.executeNormal(Constants.SERVICE_GET_FORM_DATA, serviceRequestTo);
		if (serviceResponse.isResult()) {
			ServiceResponseTO responseTo = (ServiceResponseTO) serviceResponse.getData();
			FormData[] formDataArray = (FormData[]) responseTo.getValue("returnFormData");
			FormSection[] formSections = (FormSection[]) responseTo.getValue("returnFormSection");
			FormQuestion[] formQuestions = (FormQuestion[]) responseTo.getValue("returnFormQuestion");
			TableQuestion[] tableQuestions = (TableQuestion[]) responseTo.getValue("returnTableQuestion");
			QuestionCatalog[] questionCatalogs = (QuestionCatalog[]) responseTo.getValue("returnQuestionCatalog");
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia mapeo de datos");
			}
			Form form = MappingData.toForm(formDataArray[0]);
			MappingData.mapSections(form, formSections);
			MappingData.mapQuestions(form, formQuestions, questionCatalogs, tableQuestions);
			getAnswers(form, id);

			return form;
		} else {
			throw new FormBusinessException(ServiceResponseUtil.getMessages(serviceResponse.getMessages()));
		}
	}

	private void getAnswers(Form form, Integer id) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getAnswers");
		}
		ServiceRequestTO serviceRequestToAnswers = new ServiceRequestTO();
		FormRequest formRequest = new FormRequest();
		formRequest.setCustomerId(id);
		formRequest.setFormId(form.getIdForm());
		serviceRequestToAnswers.addValue("inFormRequest", formRequest);

		ServiceResponse serviceResponseAnswers = this.executeNormal(Constants.SERVICE_GET_ANSWERS,
				serviceRequestToAnswers);
		if (serviceResponseAnswers.isResult()) {
			ServiceResponseTO serviceResponseToAnswers = (ServiceResponseTO) serviceResponseAnswers.getData();
			Answer[] answers = (Answer[]) serviceResponseToAnswers.getValue("returnAnswer");
			AnswerTable[] answersTable = (AnswerTable[]) serviceResponseToAnswers.getValue("returnAnswerTable");

			mapAnswers(form, answers);
			mapTableAnswers(form, answersTable);
		}
	}

	private void mapTableAnswers(Form form, AnswerTable[] answersTable) {
		if (answersTable != null && answersTable.length > 0) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Mapeo de Respuestas para tablas");
			}
			MappingData.mapTableAnswers(form, answersTable);
		}
	}

	private void mapAnswers(Form form, Answer[] answers) {
		if (answers != null && answers.length > 0) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Mapeo de Respuestas");
			}
			for (Section section : form.getSection()) {
				for (Question question : section.getQuestions()) {
					if (!Constants.TYPE_TABLE.equals(question.getType())) {
						MappingData.mapAnwsersToQuestion(answers, question);
					}
				}
			}
		}
	}

	public SaveAnswerResponse saveAnswer(FormAnswers formAnswers) throws FormBusinessException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia saveAnswer Impl");
		}
		SaveAnswerResponse response = new SaveAnswerResponse();
		int i = 0;
		for (AnswerData answerData : formAnswers.getAnswerData()) {
			Answer answer = new Answer();
			answer.setAnwserType(answerData.getAnswer().getAnswerType());
			answer.setAnswerDesc(answerData.getAnswer().getAnswerDesc());
			answer.setCustomerId(formAnswers.getCustomerId());
			answer.setFormId(formAnswers.getFormId());
			answer.setFormVersion(formAnswers.getFormVersion());
			answer.setQuestionId(answerData.getQuestion().getIdQuestion());
			if (i == 0) {
				answer.setFlag(INIT_SAVE);
			}

			ServiceRequestTO serviceRequestTo = new ServiceRequestTO();
			serviceRequestTo.addValue(ANSWER_REQUEST, answer);

			ServiceResponse serviceResponse = this.executeNormal(Constants.SERVICE_SAVE_ANSWER, serviceRequestTo);
			if (!serviceResponse.isResult()) {
				throw new FormBusinessException(ServiceResponseUtil.getMessages(serviceResponse.getMessages()));
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Se inica grabado de detalle de pregunta tabla");
				}
				if (Constants.TYPE_TABLE.equals(answerData.getQuestion().getType())) {
					saveTableAnswer(formAnswers, answerData);
				}
			}
			i++;
		}
		finishSave(formAnswers, response);
		return response;
	}

	private void finishSave(FormAnswers formAnswers, SaveAnswerResponse response) throws FormBusinessException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza grabado de respuestas");
		}
		Answer answer = new Answer();
		answer.setCustomerId(formAnswers.getCustomerId());
		answer.setFormId(formAnswers.getFormId());
		answer.setFormVersion(formAnswers.getFormVersion());
		answer.setProcessInstance(formAnswers.getProcessInstance());
		answer.setFlag(FINISH_SAVE);

		ServiceRequestTO serviceRequestTo = new ServiceRequestTO();
		serviceRequestTo.addValue(ANSWER_REQUEST, answer);
		ServiceResponse serviceResponse = this.executeNormal(Constants.SERVICE_SAVE_ANSWER, serviceRequestTo);
		if (!serviceResponse.isResult()) {
			throw new FormBusinessException(ServiceResponseUtil.getMessages(serviceResponse.getMessages()));
		}
		ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponse.getData();
		Map result = (Map) dataResponse.getValue("com.cobiscorp.cobis.cts.service.response.output");
		response.setMessage((String) result.get("@o_mensaje"));
		response.setResult(true);
	}

	private void saveTableAnswer(FormAnswers formAnswers, AnswerData answerData) throws FormBusinessException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia saveTableAnswer");
		}
		int rowId = 1;
		for (RowAnswer rowAnswer : answerData.getAnswer().getRowList()) {
			for (ColumnAnswer columnAnswer : rowAnswer.getColumns()) {
				Answer answerTable = new Answer();
				answerTable.setAnwserType(answerData.getAnswer().getAnswerType());
				answerTable.setAnswerDesc(columnAnswer.getAnswerDesc());
				answerTable.setCustomerId(formAnswers.getCustomerId());
				answerTable.setFormId(formAnswers.getFormId());
				answerTable.setFormVersion(formAnswers.getFormVersion());
				answerTable.setQuestionId(answerData.getQuestion().getIdQuestion());
				answerTable.setColumnId(columnAnswer.getColumn());
				answerTable.setIsHeader("S");
				answerTable.setRowId(rowId);

				ServiceRequestTO serviceRequestToTable = new ServiceRequestTO();
				serviceRequestToTable.addValue(ANSWER_REQUEST, answerTable);

				ServiceResponse serviceResponseTable = this.executeNormal(Constants.SERVICE_SAVE_ANSWER,
						serviceRequestToTable);
				if (!serviceResponseTable.isResult()) {
					throw new FormBusinessException(
							ServiceResponseUtil.getMessages(serviceResponseTable.getMessages()));
				}
			}
			rowId++;
		}
	}
}
