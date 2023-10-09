package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.Map;
import java.util.Random;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.CodeVerifUtil;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.CodeVerification;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;

import cobiscorp.ecobis.businesstobusiness.dto.SendCodeRequest;
import cobiscorp.ecobis.businesstobusiness.dto.ValidateCodeRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ContactRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;


public class CodeVerifManager extends BaseEvent{

	private static final String MAIL = "CE";
	private static final String PHONE = "C";
	private static final String O_ENTE = "@o_ente";
	private static final ILogger LOGGER = LogFactory.getLogger(CodeVerifManager.class);
	
	public CodeVerifManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	/*@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}*/
	
	@Reference(bind = "setSpOrchestrator", unbind = "unsetSpOrchestrator", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISPOrchestrator spOrchestrator;

	public void unsetSpOrchestrator() {
		this.spOrchestrator = null;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}
	
	public void sendCode(DataEntity codeVerifEnt, ICommonEventArgs args) {
		String phoneMail = codeVerifEnt.get(CodeVerification.PHONENUMBER);
		String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
		args.setSuccess(true);
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.sendCode -> INI");
			LOGGER.logDebug("CodeVerifManager.sendCode -> codeVerifEnt=" + codeVerifEnt.getData());
		}
		try {
			
			codeVerifEnt.set(CodeVerification.PTOKENLEN, getTokenLenghtValue(args));
			
			if ("SMS".equals(validationType)) {
				if (!CodeVerifUtil.validatePhone(phoneMail)) {
					args.setSuccess(false);
					args.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_ELNMEROOU_91292", null, 6000); 
				}
			} else if ("MAIL".equals(validationType)) {
				if (!CodeVerifUtil.validateMail(phoneMail)) {
					args.setSuccess(false);
					args.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_CORREOERT_56061", null, 6000); 
				}
			}
			
			if(args.isSuccess()) {
				String msg = execSendCodeService(codeVerifEnt);
				
				if (!"".equals(msg)) {
					args.setSuccess(false);
					args.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_ERRORALVD_85715", null, 6000);
				}else{
					args.setSuccess(true);
					args.getMessageManager().showSuccessMsg("CSTMR.MSG_CSTMR_SEHAENVAL_21686", null, 6000);
				}
			}
			
		} catch (Exception e) {
			if(LOGGER.isErrorEnabled()) {
				LOGGER.logError("CodeVerifManager.sendCode -> ERROR:",e);
			}
		}
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.sendCode -> FIN");
		}
	}

	private String getTokenLenghtValue(ICommonEventArgs args) {
		ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
		ParameterResponse parameterDto;
		String paramTokenLength = "6";
		try {
			LOGGER.logInfo("consulta de parametro: TAMT");
			parameterDto = parameterManagement.getParameter(4, "TAMT", "BVI", args);
			LOGGER.logInfo("valor de parametro TAMT: " + parameterDto.getParameterValue());
			paramTokenLength = parameterDto.getParameterValue();
		} catch (Exception e) {
			//ExceptionUtils.showError("Error al consultar parámetro VASMS", e, args, LOGGER);
		}
		
		return paramTokenLength;
	}

	private String execSendCodeService(DataEntity codeVerifEnt) {
		
		ServiceRequestTO servReqTo = new ServiceRequestTO();
		SendCodeRequest sendCodeRequest = new SendCodeRequest();
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		//Route responseValue = null;
		Integer cstmrCode = codeVerifEnt.get(CodeVerification.CSTMRCODE);
		String phoneMail = codeVerifEnt.get(CodeVerification.PHONENUMBER);
		String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
		
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.execSendCodeService -> INI");
		}

		sendCodeRequest.setCanal("4");
		sendCodeRequest.setNumMail(phoneMail);
		sendCodeRequest.setTipo(validationType);
		sendCodeRequest.setCodEnte(cstmrCode);
		sendCodeRequest.setOtp(String.valueOf(getTokenLengthValue(codeVerifEnt.get(CodeVerification.PTOKENLEN))));
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("sendOtp -> " + sendCodeRequest.getCanal() + ", " + sendCodeRequest.getNumMail() + ", " + sendCodeRequest.getTipo() + ", " + sendCodeRequest.getCodEnte() + ", ");
		}
		servReqTo.addValue("inSendCodeRequest", sendCodeRequest);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, "BusinessToBusiness.SecurityManagement.SendOtp", servReqTo);
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CodeVerifManager.execSendCodeService -> serviceResponse=" + serviceResponse);
			}
			LOGGER.logDebug("-->>AccounStateManagement getCreateStateAccount result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				
				@SuppressWarnings("unchecked")
				Map<String, Object> outputParamsResp = (Map<String, Object>) serviceResponseTo.getValue("com.cobiscorp.cobis.cts.service.response.output");
				
				Object oEnte = outputParamsResp.get(O_ENTE);
				if (oEnte != null && !"".equals(oEnte.toString().trim()) && !"0".equals(oEnte.toString().trim())) {
					return outputParamsResp.get(O_ENTE).toString().trim();
				}
			}	
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.execSendCodeService -> FIN");
		}
		return "";
	}
	
	private int getTokenLengthValue(String tokenLength) {
		//AdminTokenUserImpl admTokenUsrImpl = new AdminTokenUserImpl();
		//admTokenUsrImpl.setSpOrchestrator(this.spOrchestrator);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.getTokenLengthValue - INI");
		}
		//String tokenLength = admTokenUsrImpl.getTokenLength();

		// Logica para generar el token
		String aux1 = "9", aux2 = "0";
		Random randomGenerator = new Random();

		for (int idx = 1; idx < Integer.parseInt(tokenLength); ++idx) {
			aux1 = aux1 + "0";
			aux2 = aux2 + "9";
		}

		int randomInt = randomGenerator.nextInt(Integer.parseInt(aux1)) + Integer.parseInt(aux2);
		return randomInt;
	}


	public void validateCode(DataEntity codeVerifEnt, ICommonEventArgs args) {
		String phoneMail = codeVerifEnt.get(CodeVerification.PHONENUMBER);
		String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
		
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.validateCode -> INI");
			LOGGER.logDebug("CodeVerifManager.validateCode -> codeVerifEnt=" + codeVerifEnt.getData());
		}
		try {
			args.setSuccess(true);
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CodeVerifManager.validateCode -> args.isSuccess=" + args.isSuccess());
			}
			if (Parameter.SMS_TYPE.equals(validationType)) {
				if (!CodeVerifUtil.validatePhone(phoneMail)) {
					args.setSuccess(false);
					args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_ELNMEROOU_91292", null, 6000); 
					//return errorResponse("EL número de teléfono ingresado enviado, no es un número válido");
				}
			} else if (Parameter.MAIL_TYPE.equals(validationType)) {
				if (!CodeVerifUtil.validateMail(phoneMail)) {
					args.setSuccess(false);
					args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_ELNMEROOU_91292", null, 6000); 
				}
				
			}
			
			if(args.isSuccess()) {
				boolean statusVal = execValidateCodeService(codeVerifEnt);
				args.setSuccess(statusVal);
			}
			
		} catch (Exception e) {
			if(LOGGER.isErrorEnabled()) {
				LOGGER.logError("CodeVerifManager.validateCode -> ERROR:",e);
			}
		}
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.validateCode -> FIN");
		}
		
	}

	private boolean execValidateCodeService(DataEntity codeVerifEnt) {
		ServiceRequestTO servReqTo = new ServiceRequestTO();
		ValidateCodeRequest valCodeRequest = new ValidateCodeRequest();
		
		Integer cstmrCode = codeVerifEnt.get(CodeVerification.CSTMRCODE);
		String phoneMail = codeVerifEnt.get(CodeVerification.PHONENUMBER);
		String valType = codeVerifEnt.get(CodeVerification.VALTYPE);
		String code = codeVerifEnt.get(CodeVerification.CODE);
		Integer addressId = codeVerifEnt.get(CodeVerification.ADDRESSID);
		Integer failureCounter = codeVerifEnt.get(CodeVerification.FAILURECOUNTER);
		failureCounter = failureCounter == null ? 0 : failureCounter;
		
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.execValidateCodeService -> INI");
		}
		valCodeRequest.setCanal("4");
		valCodeRequest.setNumMail(phoneMail);
		valCodeRequest.setTipo(valType);
		valCodeRequest.setCodigo(code);

		servReqTo.addValue("inValidateCodeRequest", valCodeRequest);		
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, "BusinessToBusiness.SecurityManagement.ValidationOtp", servReqTo);
		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CodeVerifManager.execValidateCodeService -> serviceResponseTo=" + serviceResponseTo.getData());
			}
			if (serviceResponseTo.isSuccess()) {
				if (serviceResponseTo.isSuccess()) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("CodeVerifManager.execValidateCodeService -> serviceResponseTo.isSuccess=" + serviceResponseTo.isSuccess());
					}
					ContactRequest reqVerif = new ContactRequest(); 
					reqVerif.setValue(phoneMail);
					reqVerif.setType("SMS".equals(valType) ? PHONE: MAIL);
					reqVerif.setClientId(cstmrCode);
					reqVerif.setAddressId(addressId);
					reqVerif.setChannel(4); //Tomar de la entida Context: "web"
					reqVerif.setOperation("I");
					
					ServiceRequestTO servReqTo2 = new ServiceRequestTO();
					servReqTo2.addValue("inContactRequest", reqVerif);
					
					ServiceResponse serviceResponse2 = execute(getServiceIntegration(), LOGGER, "CustomerDataManagementService.CustomerManagement.VerifyContact", servReqTo2);
					if (serviceResponse2 != null && serviceResponse2.isResult()) {
						if (LOGGER.isDebugEnabled()) {
							LOGGER.logDebug("CodeVerifManager.execValidateCodeService -> serviceResponse=" + serviceResponse2);
						}
						LOGGER.logDebug("-->>CodeVerifManager.execValidateCodeService result" + serviceResponse2.isResult());
						ServiceResponseTO serviceResponseTo2 = (ServiceResponseTO) serviceResponse2.getData();
						if (serviceResponseTo2.isSuccess()) {
							if (LOGGER.isDebugEnabled()) {
								LOGGER.logDebug("CodeVerifManager.execValidateCodeService -> TRUE");
							}
							return true;
						}	
					}

				}
			}
		}
		
		failureCounter++;
		codeVerifEnt.set(CodeVerification.FAILURECOUNTER, failureCounter);
	
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerifManager.execSendCodeService -> FALSE");
		}
		return false;
	}
	
	
	

}
