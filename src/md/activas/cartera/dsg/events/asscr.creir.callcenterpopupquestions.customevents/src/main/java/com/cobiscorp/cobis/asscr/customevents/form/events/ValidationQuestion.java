package com.cobiscorp.cobis.asscr.customevents.form.events;

import java.util.Map;

import com.cobiscorp.cobis.asscr.model.CallCenterQuestion;
import com.cobiscorp.cobis.asscr.model.LoginCallCenter;
import com.cobiscorp.cobis.asscr.model.QuestionValidation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.services.CallCenterQuestionsManager;

import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ValidationQuestion extends BaseEvent implements IExecuteCommand {
	
	private static ILogger logger = LogFactory.getLogger(ValidationQuestion.class);

	public ValidationQuestion(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {

		logger.logDebug("--------------->>> Inicia executeCommand ValidationQuestion (Validación de Preguntas)");
		
		DataEntityList questionList = arg0.getEntityList(CallCenterQuestion.ENTITY_NAME);
		DataEntity questionValidation = arg0.getEntity(QuestionValidation.ENTITY_NAME);
		DataEntity loginCallCenter = arg0.getEntity(LoginCallCenter.ENTITY_NAME);
		
		logger.logDebug("--------------->>> loginCallCenter"+ loginCallCenter);
		logger.logDebug("--------------->>> questionList"+ questionList);
		logger.logDebug("--------------->>> questionValidation"+ questionValidation);
		
		logger.logDebug("IdClienteLogin--"+loginCallCenter.get(LoginCallCenter.IDCLIENTE));
		logger.logDebug("P1--"+questionList.get(0).get(CallCenterQuestion.IDQUESTION));
		logger.logDebug("R1--"+questionList.get(0).get(CallCenterQuestion.ANSWER));
		logger.logDebug("P2--"+questionList.get(1).get(CallCenterQuestion.IDQUESTION));
		logger.logDebug("R2--"+questionList.get(1).get(CallCenterQuestion.ANSWER));
		logger.logDebug("P3--"+questionList.get(2).get(CallCenterQuestion.IDQUESTION));
		logger.logDebug("R3--"+questionList.get(2).get(CallCenterQuestion.ANSWER));
        
		int clienteCode=loginCallCenter.get(LoginCallCenter.IDCLIENTE);
		int    pregunta1 =questionList.get(0).get(CallCenterQuestion.IDQUESTION);
		String respuesta1=questionList.get(0).get(CallCenterQuestion.ANSWER);
		int    pregunta2 =questionList.get(1).get(CallCenterQuestion.IDQUESTION);
		String respuesta2=questionList.get(1).get(CallCenterQuestion.ANSWER);
		int    pregunta3 =questionList.get(2).get(CallCenterQuestion.IDQUESTION);
		String respuesta3=questionList.get(2).get(CallCenterQuestion.ANSWER);
		
		
		CallCenterQuestionRequest questionRequest=new CallCenterQuestionRequest();
		questionRequest.setIdCliente(clienteCode);
		questionRequest.setIdQuestion1(pregunta1);
		questionRequest.setAnswer1(respuesta1);
		questionRequest.setIdQuestion2(pregunta2);
		questionRequest.setAnswer2(respuesta2);
		questionRequest.setIdQuestion3(pregunta3);
		questionRequest.setAnswer3(respuesta3);
		
		Map<String, Object> otputs=null;
		
		CallCenterQuestionsManager callCenterQuestionsManager = new CallCenterQuestionsManager(getServiceIntegration());
		
		otputs = callCenterQuestionsManager.validationQuestionMsm(questionRequest, arg1);
		
		logger.logDebug("R validacion-->"+otputs.get("@o_resultado").toString());
		
		String resultadoValidacion=null;
		
		resultadoValidacion=otputs.get("@o_resultado").toString();
		
		logger.logDebug("R resultadoValidacion con otputs-->"+resultadoValidacion);
		
		logger.logDebug("Informacion de la entidada "+QuestionValidation.CORRETVALIDATION);
		
		questionValidation.set(QuestionValidation.CORRETVALIDATION, resultadoValidacion);
		
		logger.logDebug("R resultadoValidacion-->"+questionValidation.get(QuestionValidation.CORRETVALIDATION));	
		
		logger.logDebug("otputs-->"+otputs);	
		
		if(otputs.get("@o_msg").toString()!=null)
		{	
			String msmVali=null;
			msmVali=otputs.get("@o_msg").toString();
			logger.logDebug("msm validation-->"+msmVali);		
				logger.logDebug("msm validation ingresa-->"+msmVali);
			questionValidation.set(QuestionValidation.MSMVALIDATION, msmVali);
				
		}
		
		if(resultadoValidacion.equals("N"))
		{
			try {
			if (questionList != null) {
			logger.logDebug("--------------->>>Inicia nuevas preguntas cuando es N");
			CallCenterQuestionRequest questionRequestpreg=new CallCenterQuestionRequest();
			questionRequestpreg.setIdCliente(5);
			logger.logDebug("--------------->>> Inicia busqueda de Preguntas por Cliente cuando respuesta es N");
			CallCenterQuestionsManager pregcallCenterQuestionsManager1 = new CallCenterQuestionsManager(getServiceIntegration());
			CallCenterQuestionResponse[] preQuestionList1 = pregcallCenterQuestionsManager1.searchCallCenterQuestion(questionRequestpreg, arg1);
			
			logger.logDebug("preQuestionList1  Size>>" + preQuestionList1.length);
			for(int i=0;i<preQuestionList1.length;i++)
			{
				logger.logDebug("nueva pregunta id"+preQuestionList1[i].getIdQuestion());
				logger.logDebug("nueva pregunta id question"+preQuestionList1[i].getQuestion());
			}
			
			for(int i=0;i<preQuestionList1.length;i++)
			{
				questionList.get(i).set(CallCenterQuestion.IDQUESTION, preQuestionList1[i].getIdQuestion());
				questionList.get(i).set(CallCenterQuestion.QUESTION, preQuestionList1[i].getQuestion());
				questionList.get(i).set(CallCenterQuestion.ANSWER, null);
			}
				}
			}
		     catch (Exception e) {
			logger.logDebug("Error" +e);
			}
			
			
		}
	}

}
