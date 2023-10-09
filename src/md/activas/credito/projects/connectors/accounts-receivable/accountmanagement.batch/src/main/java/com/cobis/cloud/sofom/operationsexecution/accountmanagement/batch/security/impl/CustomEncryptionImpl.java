package com.cobis.cloud.sofom.operationsexecution.accountmanagement.batch.security.impl;

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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
            logger.logInfo("Proceso de cifrado para Pagos Referenciados");
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
            logger.logInfo("Proceso de descifrado para Pagos Referenciados");
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

            // Envío a carpeta de Conciliaciones
            String fileName = new File(originalFileName).getName();
            if (isConsolidatedFile(fileName)) {
                copyFileToReconcile(fileName);
            }
        }

        return serviceResponseTO;
    }

    private boolean isConsolidatedFile(String fileName) {
        String patternString = "H2H_43009668_\\d{8}_0[0123456]\\d{4}_\\.edocta";
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(fileName);
        return matcher.matches();
    }

    private void copyFileToReconcile(String fileName) {
        String decodeOutPath = "DecodeSalida";
        String encryptionIenPath = System.getenv("IEN_HOME") + "\\" + encryptionFolderPath + "\\";
        DateFormat dateFormat = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
        Date date = new Date();

        File originalFile = new File(fileName);
        String fileNameDecoded = encryptionIenPath + decodeOutPath + dateFormat.format(date) + originalFile.getName();

        String reconcilePath = System.getenv("IEN_HOME") + "\\conciliaciones\\";
        String dstFileName = reconcilePath + fileName + ".copy";

        if (logger.isTraceEnabled()) {
            logger.logTrace("Archivo decodificado: " + fileNameDecoded);
            logger.logTrace("Archivo para conciliación: " + dstFileName);
        }

        FileChannel srcChannel = null;
        FileChannel dstChannel = null;
        try {
            srcChannel = new FileInputStream(fileNameDecoded).getChannel();
            dstChannel = new FileOutputStream(dstFileName).getChannel();
            dstChannel.transferFrom(srcChannel, 0, srcChannel.size());
        } catch (IOException ioe) {
            logger.logError("No fue posible mover el archivo a la carpeta de Conciliaciones: " + ioe);
        } finally {
            if (srcChannel != null) {
                try {
                    srcChannel.close();
                } catch (IOException e) {
                    logger.logError(e);
                }
            }
            if (dstChannel != null) {
                try {
                    dstChannel.close();
                } catch (IOException e) {
                    logger.logError(e);
                }
            }
        }
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
