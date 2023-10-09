package com.cobiscorp.mobile.services.impl.security;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.cts.integration.services.dto.CTSSessionRequest;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;
import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.services.impl.security.dto.CTSServiceResponseTO;

public class COBISSecurityManager {
    private static ILogger logger = LogFactory
            .getLogger(COBISSecurityManager.class);
    // private static String sessionId = null;
    // Objeto para guardar las sesiones de varios usuarios.
    private static Map<SessionSecurityKey, String> sessionMap = new HashMap<SessionSecurityKey, String>();

    private static boolean lock = false;
    private static String externalUserId = null;
    private static String externalApplicationId = null;
    private static String password = null;

    public static synchronized <T extends CTSServiceResponseTO> String initializeSession(
            ICTSServiceIntegration ctsServiceIntegration,
            SessionSecurityKey secKey, T response) {
        try {
            if (logger.isTraceEnabled()) {
                logger.logTrace("START initializeSession");
            }

            String backendId = secKey.getBackendId();

            if (sessionMap.get(secKey) != null) {
                return "NULL";
            }
            lock = true;
           
            // if user is sent in header
            if (secKey.getLogin() != null && secKey.getApplicationId() != null) {
                if (logger.isDebugEnabled()) {
                    logger.logDebug("Initializing session using header params");
                }
                
                CTSSessionRequest sessionReq = new CTSSessionRequest();
                sessionReq.setExternalApplicationId(secKey.getApplicationId());
                sessionReq.setExternalUserId(secKey.getLogin());
                sessionReq.setPassword(secKey.getPassword());
                if (backendId != null) {
                    sessionReq.setBackEndId(backendId);
                }
                // sessionReq.setPassword(wProperties.getProperty("p"));
                if (logger.isDebugEnabled()) {
                    logger.logDebug("externalUserId: " + secKey.getLogin()
                            + ", externalApplicationId: "
                            + secKey.getApplicationId() + ", backendId: "
                            + backendId);
                }
                String wSessionId = ctsServiceIntegration
                        .initializeSession(sessionReq);
                sessionMap.put(secKey, wSessionId);
                if (logger.isTraceEnabled()) {
                    logger.logTrace("END initializeSession. sessionId = "
                            + wSessionId);
                }
                return wSessionId;
            }
            if (externalUserId == null || externalApplicationId == null) {
                // algn File
                if (logger.isDebugEnabled()) {
                    logger.logDebug("Initializing session using Algn file");
                    logger.logDebug("Folder: "+ System.getProperty("COBIS_HOME"));
                }
                String algnFile = null;

                if (algnFile == null || algnFile.equals("")) {
                    algnFile = "Buromovil.algncon";
                }
                
                algnFile = System.getProperty("COBIS_HOME") + "/CLIENT_ALGNS/"
                        + algnFile;

                File file = new File(algnFile);
                if (!file.exists()) {
                    response.setSuccess(false);
                    MessageTO errorMessage = new MessageTO();
                    errorMessage.setMessage("File doesn't exist : " + algnFile);
                    MessageTO[] messages = {errorMessage};
                    response.setMessages(messages);
                    if (logger.isErrorEnabled()) {
                        logger.logError("File doesn't exist : " + algnFile);
                    }
                    return "NULL";
                }
                ReadAlgn wAlgReader = new ReadAlgn(algnFile);
                Properties wProperties = wAlgReader.leerParametros();
                externalUserId = wProperties.getProperty("l");
                externalApplicationId = wProperties.getProperty("s");
                password = wProperties.getProperty("p");
                              
            }

            CTSSessionRequest sessionReq = new CTSSessionRequest();
            sessionReq.setExternalApplicationId(externalApplicationId);
            sessionReq.setExternalUserId(externalUserId);
            sessionReq.setPassword(password);
            if (backendId != null) {
                sessionReq.setBackEndId(backendId);
            }
            // sessionReq.setPassword(wProperties.getProperty("p"));
            if (logger.isDebugEnabled()) {
                logger.logDebug("externalUserId: " + externalUserId
                        + ", externalApplicationId: " + externalApplicationId
                        + ", backendId: " + backendId);
            }
            String wSessionId = ctsServiceIntegration
                    .initializeSession(sessionReq);
            secKey.setLogin(externalUserId);
            secKey.setApplicationId(externalApplicationId);
            sessionMap.put(secKey, wSessionId);
            if (logger.isTraceEnabled()) {
                logger.logTrace("END initializeSession. sessionId = "
                        + wSessionId);
            }
            return wSessionId;
        } catch (COBISException e) {
            if (logger.isErrorEnabled()) {
                logger.logError(e, e);
            }
            response.setSuccess(false);
            MessageTO errorMessage = new MessageTO();
            errorMessage.setMessage(e.getMessage());
            MessageTO[] messages = {errorMessage};
            response.setMessages(messages);
        } finally {
            lock = false;
        }
        return "NULL";
    }

    public static String getSessionId(SessionSecurityKey secKey) {
        try {
            while (lock)
                Thread.sleep(100);
        } catch (InterruptedException e) {
            if (logger.isErrorEnabled()) {
                logger.logError(e, e);
            }
        }
        return sessionMap.get(secKey);
    }

    public static synchronized void ClearSessionId(SessionSecurityKey secKey) {
        // Solo se debe este metodo antes de llamar a initializeSession
        lock = true;
        sessionMap.remove(secKey);
        externalUserId = null;
        externalApplicationId = null;
    }

    public static synchronized void setExternalUserId(String aExternalUserId) {
        externalUserId = aExternalUserId;
    }

    public static synchronized void setExternalApplicationId(
            String aExternalApplicationId) {
        externalApplicationId = aExternalApplicationId;
    }
}