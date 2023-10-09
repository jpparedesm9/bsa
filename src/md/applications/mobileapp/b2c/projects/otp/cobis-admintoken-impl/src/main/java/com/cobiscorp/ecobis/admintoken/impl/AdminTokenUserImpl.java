package com.cobiscorp.ecobis.admintoken.impl;

import java.util.Random;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenRequest;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenResponse;
import com.cobiscorp.ecobis.admintoken.dto.Message;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.ecobis.admintoken.utils.MessageManager;

public class AdminTokenUserImpl implements IAdminTokenUser {


	private static ILogger logger = LogFactory.getLogger(AdminTokenUserImpl.class);

	CobisStoredProcedureUtils cobisStoredProcedureUtils;
	private ISPOrchestrator spOrchestrator;
	
	private ICobisCrypt cobisCrypt;
	
	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = null;
	}
	
	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}
	
	public CobisStoredProcedureUtils getCobisStoredProcedureUtils() {
		return cobisStoredProcedureUtils;
	}

	public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}


	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.admintoken.bl.AdminTokenUser#
	 * generateTokenUser(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public DataTokenResponse generateTokenUser(DataTokenRequest dataIn) {
		
		DataTokenResponse dataTokenResponse = new DataTokenResponse();
		try {

			if (logger.isDebugEnabled()) {
				logger.logDebug("Empieza generateTokenUser Method");
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

			Context wContext = ContextManager.getContext();
			if (logger.isTraceEnabled()) {
				logger.logTrace("context to use:" + wContext);
			}

			wProcedureRequest.setSpName("cob_bvirtual..sp_administra_token");
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "local");

			// Add parameters of business
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "I"); //puede ser Q valida, I inserta
			wProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, dataIn.getLogin());
			wProcedureRequest.addInputParam("@i_canal", ICTSTypes.SQLVARCHAR, dataIn.getChannel().toString());
			
			//Encriptación token segun tamaño definido en base
			String tokenLength = getTokenLength();
			String aux1 = "9", aux2 = "0";
			Random randomGenerator = new Random();

			for (int idx = 1; idx < Integer.parseInt(tokenLength); ++idx){
				aux1 = aux1 + "0";
				aux2 = aux2 + "9";
			}

			int randomInt = randomGenerator.nextInt(Integer.parseInt(aux1)) + Integer.parseInt(aux2);
		    String tokenEncrypted = this.cobisCrypt.enCrypt(dataIn.getLogin(), Integer.toString(randomInt));
		    dataTokenResponse.setTokenNumber(String.valueOf(randomInt));
			dataIn.setToken(Integer.toString(randomInt));
			wProcedureRequest.addInputParam("@i_token", ICTSTypes.SQLVARCHAR, tokenEncrypted);			

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			logger.logDebug("<<<<<<<<<< wProcedureResponseAS generateTokenUser >>>>>>>>>> " + wProcedureResponseAS);

			if (wProcedureResponseAS != null && !wProcedureResponseAS.hasError()) {				
				
				 if(notifyTokenUser(dataIn)){
					 dataTokenResponse.setSuccess(true); 
				 }
				 
			}else{
				dataTokenResponse.setSuccess(false);
				Message message = new Message();
				if (wProcedureResponseAS != null) {
					message.setCode(wProcedureResponseAS.getReturnCode()+"");
				}
				message.setDescription("Error al guardar Token");
				dataTokenResponse.setMessage(message);
			}

        return dataTokenResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("generateTokenUser.001"), ex);
			throw new BusinessException(1887674, "An error occurred executing generateTokenUser.");
		} finally {
			logger.logDebug(MessageManager.getString("generateTokenUser.001", "generateTokenUser"));			
		}
	}

	private boolean notifyTokenUser(DataTokenRequest dataIn) {

		boolean answerNotificaction  = false;		
		try{
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("Empieza notifyTokenUser Method");
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		Context wContext = ContextManager.getContext();
		if (logger.isTraceEnabled()) {
			logger.logTrace("context to use:" + wContext);
		}

		wProcedureRequest.setSpName("cob_bvirtual..sp_se_generar_notif");
		wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "local");

		// Add parameters of business	
		wProcedureRequest.addInputParam("@i_banco", ICTSTypes.SQLVARCHAR, dataIn.getBankName()); // No importa
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "1875901"); // COn este numero de trn funciona
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, dataIn.getOperation()); //puede ser Q consulta, N notifica
		wProcedureRequest.addInputParam("@i_canal", ICTSTypes.SQLINT4, (null != dataIn.getChannel()?dataIn.getChannel()+"":null)); // este caso 8
		wProcedureRequest.addInputParam("@i_correo_orig", ICTSTypes.SQLVARCHAR, dataIn.getOriginMail()); // Verificar si es obligatorio en sp
		wProcedureRequest.addInputParam("@i_correo_dest", ICTSTypes.SQLVARCHAR, dataIn.getDestinationMail()); // Verificar si es obligatorio en sp
		wProcedureRequest.addInputParam("@i_token", ICTSTypes.SQLVARCHAR, dataIn.getToken()); // Verificar si se usa en el sp
		wProcedureRequest.addInputParam("@i_cliente", ICTSTypes.SQLINT4, (null != dataIn.getClientId()?dataIn.getClientId()+"":null));
		wProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, dataIn.getLogin());
		wProcedureRequest.addInputParam("@i_bandera_sms", ICTSTypes.SQLVARCHAR, dataIn.getSmsFlag()); // S usa el numero del campo i_bandera_sms
		wProcedureRequest.addInputParam("@i_num_telf", ICTSTypes.SQLVARCHAR, dataIn.getClientPhoneNumber());
		wProcedureRequest.addInputParam("@i_tipo_env", ICTSTypes.SQLVARCHAR, dataIn.getSendingType());
		
		ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

		logger.logDebug("<<<<<<<<<< wProcedureResponseAS notifyTokenUser >>>>>>>>>> " + wProcedureResponseAS);

		if (wProcedureResponseAS != null && !wProcedureResponseAS.hasError()) {
			answerNotificaction = true;
		}
		return answerNotificaction;
		
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("notifyTokenUser.002"), ex);
			
			throw new BusinessException(1887674, "An error occurred sending token");
		} finally {
			logger.logDebug(MessageManager.getString("notifyTokenUser.002", "notifyTokenUser"));
		}
	}

	private boolean notifySMSUser(DataTokenRequest dataIn) {

		boolean answerNotificaction  = false;
		
		try{
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("Empieza notifySMSUser Method");
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		Context wContext = ContextManager.getContext();
		if (logger.isTraceEnabled()) {
			logger.logTrace("context to use:" + wContext);
		}

		wProcedureRequest.setSpName("cob_bvirtual..sp_b2c_notificar_sms");
		wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "local");

		// Add parameters of business	
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "775074"); // COn este numero de trn funciona
		wProcedureRequest.addInputParam("@i_token", ICTSTypes.SQLVARCHAR, dataIn.getToken()); // Verificar si se usa en el sp
		wProcedureRequest.addInputParam("@i_cliente", ICTSTypes.SQLINT4, (null != dataIn.getClientId()?dataIn.getClientId()+"":null));
		wProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, dataIn.getLogin());
		wProcedureRequest.addInputParam("@i_num_telf", ICTSTypes.SQLVARCHAR, dataIn.getClientPhoneNumber());

		ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

		logger.logDebug("<<<<<<<<<< wProcedureResponseAS notifySMSUser >>>>>>>>>> " + wProcedureResponseAS);

		if (wProcedureResponseAS != null && !wProcedureResponseAS.hasError()) {
			answerNotificaction = true;
		}
		return answerNotificaction;
		
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("notifySMSUser.002"), ex);
			
			throw new BusinessException(1887674, "An error occurred sending token");
		} finally {
			logger.logDebug(MessageManager.getString("notifySMSUser.002", "notifySMSUser"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.admintoken.bl.AdminTokenUser#
	 * validateTokenUser(java.lang.Integer, java.lang.Integer)
	 */
	@Override
	public DataTokenResponse validateTokenUser(DataTokenRequest dataIn) {
		DataTokenResponse dataTokenResponse = new DataTokenResponse();
		
		try {
			
			if (logger.isDebugEnabled()) {
				logger.logDebug("Empieza validateTokenUser Method");
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

			Context wContext = ContextManager.getContext();
			if (logger.isTraceEnabled()) {
				logger.logTrace("context to use:" + wContext);
			}

			wProcedureRequest.setSpName("cob_bvirtual..sp_administra_token");
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "local");

			// Add parameters of business
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "Q"); //puede ser Q valida, I inserta
			wProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, dataIn.getLogin());
			wProcedureRequest.addInputParam("@i_canal", ICTSTypes.SQLVARCHAR, dataIn.getChannel().toString());
			
			String tokenEncrypted = this.cobisCrypt.enCrypt(dataIn.getLogin(), dataIn.getToken());
						
			wProcedureRequest.addInputParam("@i_token", ICTSTypes.SQLVARCHAR, tokenEncrypted);

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			logger.logDebug("<<<<<<<<<< wProcedureResponseAS validateTokenUser >>>>>>>>>> " + wProcedureResponseAS);

			if (wProcedureResponseAS != null && !wProcedureResponseAS.hasError()) {
				 dataTokenResponse.setSuccess(true); 
			}else{
				dataTokenResponse.setSuccess(false);
				Message message = new Message();
				if (wProcedureResponseAS != null) {
					message.setCode(wProcedureResponseAS.getReturnCode()+"");
				}
				message.setDescription("Error al validar Token");
				dataTokenResponse.setMessage(message);
			}

			 return dataTokenResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("validateTokenUser.001"), ex);
			throw new BusinessException(7300024, "An error occurred at validating token user");
		} finally {
			logger.logDebug(MessageManager.getString("validateTokenUser.001", "validateTokenUser"));
		}

	}
	
	public String getTokenLength() {

		String tokenLength = "";
		
		try{
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("Empieza getTokenLenght Method");
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		Context wContext = ContextManager.getContext();
		if (logger.isTraceEnabled()) {
			logger.logTrace("context to use:" + wContext);
		}

		wProcedureRequest.setSpName("cob_bvirtual..sp_param_ini_token");
		wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "local");

		// Add parameters of business	
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "V");
		wProcedureRequest.addInputParam("@i_producto", ICTSTypes.SQLVARCHAR, "BVI");
		wProcedureRequest.addInputParam("@i_nemonico", ICTSTypes.SQLVARCHAR, "TAMT");
		
		ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

		logger.logDebug("<<<<<<<<<< wProcedureResponseAS getTokenLenght >>>>>>>>>> " + wProcedureResponseAS);

		if (wProcedureResponseAS != null && !wProcedureResponseAS.hasError()) {
			//Mapeo de longitud del token
			IResultSetBlock iresultsetblock = wProcedureResponseAS.getResultSet(1);
			if (iresultsetblock != null) {
                IResultSetData iresultsetdata = iresultsetblock.getData();
                for (int i = 1; i <= iresultsetdata.getRowsNumber(); i++) {
                	if (iresultsetdata.getRow(i).getRowData(2).getValue() != null 
                			&& !iresultsetdata.getRow(i).getRowData(2).isNull()) {
                			tokenLength = iresultsetdata.getRow(i).getRowData(2).getValue(); //Longitud del token
                	}
                	
                }
			}
		}
		
		logger.logDebug("tokenLenght --> " + tokenLength);
		return tokenLength;
		
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("getTokenLenght.002"), ex);
			
			throw new BusinessException(1887674, "An error occurred get token length");
		} finally {
			logger.logDebug(MessageManager.getString("getTokenLenght.002", "getTokenLenght"));
		}
	}

	@Override
	public boolean isValidPasword(String clientId, String password, String login, int channel) {
		String pwd = this.cobisCrypt.enCrypt(password, password);

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		wProcedureRequest.setSpName("cob_bvirtual..sp_b2c_validar_pwd");

		wProcedureRequest.addInputParam("@s_servicio", ICTSTypes.SQLINT1, String.valueOf(channel));
		wProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, clientId);
		wProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, login);
		wProcedureRequest.addInputParam("@i_pwd", ICTSTypes.SQLVARCHAR, pwd);
				
		ProcedureResponseAS procedureResponse = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

		return procedureResponse != null && !procedureResponse.hasError();
	}

}
