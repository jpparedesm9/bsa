package com.cobiscorp.cloud.notificationservice.impl;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class DescargaListasNegras extends NotificationGeneric implements Job {
    private static final Logger logger = Logger.getLogger(DescargaListasNegras.class);
    private static final String JOB_ACRONYM = "DSCLN";

    private static final String messageOk = "DESCARGA EXITOSA DEL ARCHIVO DE LISTAS NEGRAS !!";

    @Override
    public List<?> xmlToDTO(File inputData) {
        return null;
    }

    @Override
    public Map<String, Object> setParameterToJasper(Object inputDto) {
        return null;
    }

    @Override
    public List<?> setCollection(Object inputDto) {
        return null;
    }

    @Override
    public Map<String, Object> setParameterToSendMail(Object inputDto) {
        return null;
    }

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
            downloadBlackList();
        } catch (Exception ex) {
            logger.error(ex);
        }
    }

    private void downloadBlackList() {
        if (logger.isDebugEnabled()) {
            logger.debug("Inicia downloadBlackList");
        }

        boolean continueProcess = true;
        String internalError = null;

        String fileName;
        String downloadPath;
        String historyPath;
        String username;
        String password;
        String host;
        Integer port;
        Integer timeout;
        String currentDate;
        File historyFile = null;
        File blackListFile;


        /* JOB PROPERTIES */
        InputStream inputStreamPropertiesFile = null;

        try {

            try {
                inputStreamPropertiesFile = new FileInputStream("notification/" + JOB_ACRONYM + ".properties");
            } catch (FileNotFoundException e) {
                logger.error(e.toString());
                throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
            }

            Properties properties = new Properties();
            try {
                properties.load(inputStreamPropertiesFile);
            } catch (IOException e) {
                logger.error(e.toString());
                throw new COBISInfrastructureRuntimeException("No se pudo cargar archivo de configuraci\u00f3n de " + JOB_ACRONYM);
            }
            if (logger.isDebugEnabled()) {
                logger.debug("Se carg\u00f3 el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
            }

            fileName = properties.getProperty("fileName");
            downloadPath = properties.getProperty("downloadPath");
            historyPath = properties.getProperty("historyPath");
            username = properties.getProperty("username");
            password = properties.getProperty("password");
            host = properties.getProperty("host");
            port = Integer.parseInt(properties.getProperty("port"));
            timeout = Integer.parseInt(properties.getProperty("timeout"));

            if (logger.isTraceEnabled()) {
                logger.trace("fileName: " + fileName);
                logger.trace("downloadPath: " + downloadPath);
                logger.trace("historyPath: " + historyPath);
                logger.trace("username: " + username);
//                logger.trace("password: " + password);
                logger.trace("host: " + host);
                logger.trace("port: " + port);
                logger.trace("timeout: " + timeout);
            }

        } finally {
            if (inputStreamPropertiesFile != null) {
                try {
                    inputStreamPropertiesFile.close();
                } catch (IOException e) {
                    logger.error(e.toString());
                    internalError = "No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM;
                    continueProcess = false;
                }
            }
        }


        if (continueProcess) {

            /* VERIFY IF A FILE WAS PROCESSED OK PREVIOUSLY */
            DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            currentDate = dateFormat.format(new Date());

            historyFile = new File(historyPath + currentDate + "_" + fileName);
            if (historyFile.exists()) {
                if (logger.isDebugEnabled()) {
                    logger.debug("Ya se descarg\u00f3 previamente el archivo de Listas Negras");
                }
                return;
            }

        }


        if (continueProcess) {

            /* DOWNLOAD BLACK-LIST FILE BY SFTP */
            Session session = null;
            Channel channel = null;
            OutputStream outputStreamBlackListFile = null;
            ChannelSftp channelSftp = null;

            try {

                JSch jsch = new JSch();
                try {
                    session = jsch.getSession(username, host, port);
                } catch (JSchException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede iniciar sesi\u00f3n SFTP");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se inici\u00f3 sesi\u00f3n SFTP");
                }

                session.setPassword(password);
                session.setConfig("StrictHostKeyChecking", "no");

                try {
                    session.connect(timeout);
                } catch (JSchException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede conectar al servidor SFTP");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se realiz\u00f3 la conexi\u00f3n al servidor SFTP");
                }

                try {
                    channel = session.openChannel("sftp");
                } catch (JSchException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede abrir el canal SFTP para descargar Listas Negras");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se abri\u00f3 el canal SFTP");
                }

                try {
                    channel.connect(timeout);
                } catch (JSchException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede abrir el canal SFTP para descargar Listas Negras");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se abre el canal de la sesi\u00f3n");
                }

                channelSftp = (ChannelSftp) channel;

                try {
                    SftpATTRS sftpATTRS = channelSftp.lstat(fileName);
                    if (logger.isDebugEnabled()) {
                        logger.debug("sftpATTRS " + fileName + ": " + sftpATTRS.toString());
                    }
                } catch (SftpException e) {
                    logger.error(e.toString());
                    if (e.id == ChannelSftp.SSH_FX_NO_SUCH_FILE) {
                        throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO DE LISTAS NEGRAS PARA DESCARGAR");
                    } else {
                        throw new COBISInfrastructureRuntimeException("Error al buscar el archivo para descarga");
                    }
                }

                try {
                    outputStreamBlackListFile = new FileOutputStream(downloadPath + fileName);
                } catch (FileNotFoundException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede crear archivo de salida de Listas Negras");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se cre\u00f3 el archivo de salida de Listas Negras");
                }

                try {
                    channelSftp.get(fileName, outputStreamBlackListFile);
                } catch (SftpException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede descargar la informaci\u00f3n del archivo de Listas Negras");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se descarg\u00f3 la informaci\u00f3n del archivo de Listas Negras");
                }


                /* DELETE ORIGINAL BLACK-LIST FILE AT HOST */
                try {
                    channelSftp.rm(fileName);
                } catch (SftpException e) {
                    logger.error(e.toString());
                    e.printStackTrace();
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se elimin\u00f3 el archivo de Listas Negras del servidor anfitri\u00f3n");
                }

            } finally {
                if (outputStreamBlackListFile != null) {
                    try {
                        outputStreamBlackListFile.close();
                    } catch (IOException e) {
                        logger.error(e.toString());
                        internalError = "No se pudo cerrar el canal de escritura del archivo de Listas Negras descargado";
                        continueProcess = false;
                    }
                }
                if (channelSftp != null && channelSftp.isConnected()) channelSftp.disconnect();
                if (channel != null && channel.isConnected()) channel.disconnect();
                if (session != null && session.isConnected()) session.disconnect();
            }
        }


        if (continueProcess) {

            /* COPY DOWNLOADED BLACK-LIST FILE TO HISTORICAL REPOSITORY */
            FileChannel srcChannelBlackListFile = null;
            FileChannel dstChannelBlackListFileHistoric = null;

            try {

                blackListFile = new File(downloadPath + fileName);

                try {
                    srcChannelBlackListFile = new FileInputStream(blackListFile).getChannel();
                } catch (FileNotFoundException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo " + blackListFile.getAbsolutePath());
                }

                try {
                    dstChannelBlackListFileHistoric = new FileOutputStream(historyFile).getChannel();
                } catch (FileNotFoundException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede encontrar el destino " + historyPath);
                }

                try {
                    dstChannelBlackListFileHistoric.transferFrom(srcChannelBlackListFile, 0, srcChannelBlackListFile.size());
                } catch (IOException e) {
                    logger.error(e.toString());
                    throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo " + fileName + " a Hist\u00f3ricos");
                }
                if (logger.isDebugEnabled()) {
                    logger.debug("Se copi\u00f3 el archivo a los hist\u00f3ricos");
                }

            } finally {
                if (srcChannelBlackListFile != null) {
                    try {
                        srcChannelBlackListFile.close();
                    } catch (IOException e) {
                        logger.error(e.toString());
                        internalError = "No se pudo cerrar el canal de lectura del archivo descargado de Listas Negras";
                        continueProcess = false;
                    }
                }
                if (dstChannelBlackListFileHistoric != null) {
                    try {
                        dstChannelBlackListFileHistoric.close();
                    } catch (IOException e) {
                        logger.error(e.toString());
                        internalError = "No se pudo cerrar el canal de escritura del archivo de Listas Negras en Hist\u00f3ricos";
                        continueProcess = false;
                    }
                }
            }
        }


        if (continueProcess) {
            logger.info(messageOk);
        } else {
            throw new COBISInfrastructureRuntimeException(internalError);
        }

    }
}
