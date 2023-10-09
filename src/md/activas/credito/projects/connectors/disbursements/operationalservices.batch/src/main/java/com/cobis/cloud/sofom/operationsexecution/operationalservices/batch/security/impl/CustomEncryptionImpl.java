package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.security.impl;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import com.cobis.cloud.sofom.batch.common.Cryptography;
import com.cobis.cloud.sofom.batch.common.dto.CryptographyResponse;
import com.cobis.cloud.sofom.batch.common.dto.EnvironmentInfo;
import com.cobiscorp.cobis.batch.engine.tasklet.ICustomCryptography;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobisv.commons.context.Context;

public class CustomEncryptionImpl implements ICustomCryptography {
    private ILogger logger = LogFactory.getLogger(CustomEncryptionImpl.class);
    private ICobisParameter cobisParameter;

    private String encryptionFolderPath;
    private String encryptionSoftwarePath;

    public void setCobisParameter(ICobisParameter cobisParameter) {
        this.cobisParameter = cobisParameter;
    }

    public void unsetCobisParameter(
            ICobisParameter cobisParameter) {
        this.cobisParameter = null;
    }

    @Override
    public ServiceResponseTO encrypt(Context context, ServiceRequestTO serviceRequestTO) {
        if (logger.isInfoEnabled()) {
            logger.logInfo("Proceso de cifrado para Desembolsos");
            logger.logInfo("Transaction type: " + serviceRequestTO.getValue(Constants.PROPERTY_TRANSACTION_TYPE));
            logger.logInfo("Application: " + serviceRequestTO.getValue(Constants.PROPERTY_APPLICATION));
            logger.logInfo("File name: " + serviceRequestTO.getValue(Constants.PROPERTY_FILE_NAME));
        }

        ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
        serviceResponseTO.setSuccess(false);

        if (!loadEnvironmentInformation()) {
            String errorMessage = "Error en lectura de parámetros de ambiente";
            logger.logError(errorMessage);
            serviceResponseTO.addMessage(new MessageTO(errorMessage));
        } else {
            String originalFileName = serviceRequestTO.getValue(Constants.PROPERTY_FILE_NAME).toString();
            EnvironmentInfo environmentInfo = new EnvironmentInfo(encryptionFolderPath, encryptionSoftwarePath);

            CryptographyResponse cryptographyResponse = Cryptography.encrypt(originalFileName, environmentInfo);

            serviceResponseTO.setSuccess(cryptographyResponse.getSuccess());
            serviceResponseTO.addMessage(new MessageTO(cryptographyResponse.getErrorMessage()));
        }

        return serviceResponseTO;
    }

    @Override
    public ServiceResponseTO decrypt(Context context, ServiceRequestTO serviceRequestTO) {
        if (logger.isInfoEnabled()) {
            logger.logInfo("Proceso de descifrado para Desembolsos");
            logger.logInfo("Transaction type: " + serviceRequestTO.getValue(Constants.PROPERTY_TRANSACTION_TYPE));
            logger.logInfo("Application: " + serviceRequestTO.getValue(Constants.PROPERTY_APPLICATION));
            logger.logInfo("File name: " + serviceRequestTO.getValue(Constants.PROPERTY_FILE_NAME));
        }

        ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
        serviceResponseTO.setSuccess(false);

        if (!loadEnvironmentInformation()) {
            String errorMessage = "Error en lectura de parámetros de ambiente";
            logger.logError(errorMessage);
            serviceResponseTO.addMessage(new MessageTO(errorMessage));
        } else {
            String originalFileName = serviceRequestTO.getValue(Constants.PROPERTY_FILE_NAME).toString();
            EnvironmentInfo environmentInfo = new EnvironmentInfo(encryptionFolderPath, encryptionSoftwarePath);

            CryptographyResponse cryptographyResponse = Cryptography.decode(originalFileName, environmentInfo);

            serviceResponseTO.setSuccess(cryptographyResponse.getSuccess());
            serviceResponseTO.addMessage(new MessageTO(cryptographyResponse.getErrorMessage()));
        }

        return serviceResponseTO;
    }

    private boolean loadEnvironmentInformation() {
        encryptionFolderPath = "cryptography";
/*
        encryptionFolderPath = cobisParameter.getParameter(null, "CRE", "CRYPFL", String.class).trim();
        if (encryptionFolderPath != null) {
            if ("".contentEquals(encryptionFolderPath)) {
                encryptionFolderPath = null;
                if (logger.isErrorEnabled()) {
                    logger.logError("Debe estar configurado el nombre de la carpeta de IEN donde se depositarán los archivos del proceso de criptografía");
                }
            } else {
                if (logger.isDebugEnabled()) {
                    logger.logDebug("encryptionFolderPath: " + encryptionFolderPath);
                }
            }
        }
*/

        encryptionSoftwarePath = "c:\\apicifrado\\";
/*
        encryptionSoftwarePath = cobisParameter.getParameter(null, "CRE", "CRYPSW", String.class).trim();
        if (encryptionSoftwarePath != null) {
            if ("".contentEquals(encryptionSoftwarePath)) {
                encryptionSoftwarePath = null;
                if (logger.isErrorEnabled()) {
                    logger.logError("Debe estar configurada la ruta del software de criptografía");
                }
            } else {
                if (logger.isDebugEnabled()) {
                    logger.logDebug("encryptionSoftwarePath: " + encryptionSoftwarePath);
                }
            }
        }
*/

        return encryptionFolderPath != null && encryptionSoftwarePath != null;
    }
}
