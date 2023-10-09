package com.cobis.cloud.sofom.batch.common;

import com.cobis.cloud.sofom.batch.common.dto.CryptographyResponse;
import com.cobis.cloud.sofom.batch.common.dto.EnvironmentInfo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.FileChannel;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class Cryptography {
    private static ILogger logger = LogFactory.getLogger(Cryptography.class);
    private static final String className = "[Cryptography]";

    private static final String encryptInPath = "CifradoEntrada";
    private static final String encryptOutPath = "CifradoSalida";
    private static final String decodeInPath = "DecodeEntrada";
    private static final String decodeOutPath = "DecodeSalida";

    public synchronized static CryptographyResponse encrypt(String fileName, EnvironmentInfo environmentInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[encrypt]");
        }

        String errorMessage = null;
        boolean continueProcess = true;
        boolean pendingProcess = false;

        String encryptionFolderPath = environmentInfo.getEncryptionFolderPath();
        String encryptionSoftwarePath = environmentInfo.getEncryptionSoftwarePath();
        String encryptionIenPath = System.getenv("IEN_HOME") + "\\" + encryptionFolderPath + "\\";
        if (logger.isDebugEnabled()) {
            logger.logDebug("encryptionIenPath: " + encryptionIenPath);
        }

        CryptographyResponse cryptographyResponse = new CryptographyResponse();
        cryptographyResponse.setSuccess(false);

        File originalFile = new File(fileName);

        // Specification of file to encrypt
        DateFormat dateFormat = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
        Date date = new Date();
        String fileNameToEncrypt = encryptionIenPath + encryptInPath + dateFormat.format(date) + originalFile.getName();
        String fileNameEncrypted = encryptionIenPath + encryptOutPath + dateFormat.format(date) + originalFile.getName();
        File fileToEncrypt = new File(fileNameToEncrypt);
        File fileEncrypted = new File(fileNameEncrypted);
        if (logger.isDebugEnabled()) {
            logger.logDebug("fileNameToEncrypt: " + fileNameToEncrypt);
            logger.logDebug("fileNameEncrypted: " + fileNameEncrypted);
        }

        // Existence of folder to encrypt file
        File encryptInFolder = new File(fileToEncrypt.getParent());
        if (!encryptInFolder.exists()) {
            if (!encryptInFolder.mkdirs()) {
                errorMessage = "No se puede crear la carpeta de entrada para cifrar archivos";
                continueProcess = false;
            } else {
                if (logger.isDebugEnabled()) {
                    logger.logDebug("Creaci\u00f3n de la carpeta de entrada para cifrado: [" + encryptInFolder.getAbsolutePath() + "]");
                }
            }
        }

        if (continueProcess) {
            // Existence of folder for encrypted file
            File encryptOutFolder = new File(fileEncrypted.getParent());
            if (!encryptOutFolder.exists()) {
                if (!encryptOutFolder.mkdirs()) {
                    errorMessage = "No se puede crear la carpeta de salida para archivos cifrados";
                    continueProcess = false;
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.logDebug("Creaci\u00f3n de la carpeta de salida para cifrado: [" + encryptOutFolder.getAbsolutePath() + "]");
                    }
                }
            }
        }

        if (continueProcess) {
            // Existence of file to encrypt
            if (fileToEncrypt.exists()) {
                if (!fileToEncrypt.delete()) {
                    errorMessage = "No se pudo eliminar el archivo [" + fileNameToEncrypt + "] ya existente para iniciar el proceso de cifrado";
                    continueProcess = false;
                }
            }

            if (continueProcess) {
                // Existence of encrypted file
                if (fileEncrypted.exists()) {
                    // CHANGE TO CONTROL WHEN IEN CANNOT UPLOAD A FILE, AND LEAVE A CRYPTED FILE PENDING
                    if (logger.isInfoEnabled()) {
                        logger.logInfo("No procede con el proceso de cifrado, pues ya existe un archivo pendiente: [" + fileNameEncrypted + "]");
                    }
                    pendingProcess = true;
                    continueProcess = false;
                }
            }

            if (continueProcess) {
                // Move file to encrypt
                if (!originalFile.renameTo(fileToEncrypt)) {
                    errorMessage = "No se pudo mover el archivo [" + fileName + "] para cifrar";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            // Backup file to encrypt
            FileChannel srcChannel = null;
            FileChannel dstChannel = null;

            try {
                try {
                    srcChannel = new FileInputStream(fileNameToEncrypt).getChannel();
                } catch (FileNotFoundException e) {
                    errorMessage = "No existe el archivo a cifrar: [" + fileNameToEncrypt + "]";
                    continueProcess = false;
                }

                if (continueProcess) {
                    try {
                        dstChannel = new FileOutputStream(fileNameToEncrypt + ".bck").getChannel();
                    } catch (FileNotFoundException e) {
                        errorMessage = "No puede crear el archivo de respaldo: [" + fileNameToEncrypt + ".bck]";
                        continueProcess = false;
                    }
                }

                if (continueProcess) {
                    try {
                        dstChannel.transferFrom(srcChannel, 0, srcChannel.size());
                    } catch (IOException e) {
                        errorMessage = "No se pudo respaldar el archivo a cifrar [" + fileNameToEncrypt + "]";
                        continueProcess = false;
                    }
                }
            } finally {
                try {
                    if (srcChannel != null) srcChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo a cifrar: [" + fileNameToEncrypt + "]";
                    continueProcess = false;
                }
                try {
                    if (dstChannel != null) dstChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo de respaldo: [" + fileNameToEncrypt + ".bck]";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            if (logger.isDebugEnabled()) {
                logger.logDebug("Inicia el software de criptograf\u00eda");
            }

            // Execute software to encrypt
            Runtime runtime = Runtime.getRuntime();
            Process process = null;
            try {
                process = runtime.exec(new String[]{"cmd", "/c",
                                "CmpApiCifrado.bat",
                                fileNameToEncrypt,
                                fileNameEncrypted},
                        null,
                        new File(encryptionSoftwarePath));
            } catch (IOException e) {
                errorMessage = "Error en ejecuci\u00f3n de software de criptograf\u00eda";
                continueProcess = false;
            }

            if (continueProcess) {
                // Handle output of software to encrypt
                InputStream inputStream = process.getInputStream();
                int i;
                StringBuilder stringBuilder = new StringBuilder();
                try {
                    while ((i = inputStream.read()) != -1) {
                        stringBuilder.append((char) i);
                    }
                    if (logger.isDebugEnabled()) {
                        logger.logDebug("Salida del programa de criptograf\u00eda: " + stringBuilder);
                    }
                } catch (IOException e) {
                    errorMessage = "Error en lectura de salida del programa de criptograf\u00eda";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            // Copy file encrypted to IEN repository
            FileChannel srcChannel = null;
            FileChannel dstChannel = null;

            try {
                try {
                    srcChannel = new FileInputStream(fileNameEncrypted).getChannel();
                } catch (FileNotFoundException e) {
                    errorMessage = "No existe el archivo decodificado: [" + fileNameEncrypted + "]";
                    continueProcess = false;
                }

                if (continueProcess) {
                    try {
                        dstChannel = new FileOutputStream(originalFile).getChannel();
                    } catch (FileNotFoundException e) {
                        errorMessage = "No existe la ruta original de IEN: [" + originalFile.getParent() + "]";
                        continueProcess = false;
                    }
                }

                if (continueProcess) {
                    try {
                        dstChannel.transferFrom(srcChannel, 0, srcChannel.size());
                    } catch (IOException e) {
                        errorMessage = "No se pudo copiar el archivo cifrado [" + fileNameEncrypted + "] a la ruta original de IEN [" + fileName + "]";
                        continueProcess = false;
                    }
                }
            } finally {
                try {
                    if (srcChannel != null) srcChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo cifrado: [" + fileNameEncrypted + "]";
                    continueProcess = false;
                }
                try {
                    if (dstChannel != null) dstChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo de IEN: [" + fileName + "]";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess || pendingProcess) {
            logger.logInfo("CIFRADO EXITOSO !!");
            cryptographyResponse.setSuccess(true);
        }

        if (errorMessage != null) {
            logger.logError(errorMessage);
            cryptographyResponse.setErrorMessage(errorMessage);
        }

        return cryptographyResponse;
    }

    public synchronized static CryptographyResponse decode(String fileName, EnvironmentInfo environmentInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[decode]");
        }

        String errorMessage = null;
        boolean continueProcess = true;

        String encryptionFolderPath = environmentInfo.getEncryptionFolderPath();
        String encryptionSoftwarePath = environmentInfo.getEncryptionSoftwarePath();
        String encryptionIenPath = System.getenv("IEN_HOME") + "\\" + encryptionFolderPath + "\\";
        if (logger.isDebugEnabled()) {
            logger.logDebug("encryptionIenPath: " + encryptionIenPath);
        }

        CryptographyResponse cryptographyResponse = new CryptographyResponse();
        cryptographyResponse.setSuccess(false);

        File originalFile = new File(fileName);

        // Specification of file to decode
        DateFormat dateFormat = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
        Date date = new Date();
        String fileNameToDecode = encryptionIenPath + decodeInPath + dateFormat.format(date) + originalFile.getName();
        String fileNameDecoded = encryptionIenPath + decodeOutPath + dateFormat.format(date) + originalFile.getName();
        File fileToDecode = new File(fileNameToDecode);
        File fileDecoded = new File(fileNameDecoded);
        if (logger.isDebugEnabled()) {
            logger.logDebug("fileNameToDecode: " + fileNameToDecode);
            logger.logDebug("fileNameDecoded: " + fileNameDecoded);
        }

        // Existence of folder to decode file
        File decodeInFolder = new File(fileToDecode.getParent());
        if (!decodeInFolder.exists()) {
            if (!decodeInFolder.mkdirs()) {
                errorMessage = "No se puede crear la carpeta de entrada para decodificar archivos";
                continueProcess = false;
            } else {
                if (logger.isDebugEnabled()) {
                    logger.logDebug("Creaci\u00f3n de la carpeta de entrada para decodificaci\u00f3n: [" + decodeInFolder.getAbsolutePath() + "]");
                }
            }
        }

        if (continueProcess) {
            // Existence of folder for decoded file
            File decodeOutFolder = new File(fileDecoded.getParent());
            if (!decodeOutFolder.exists()) {
                if (!decodeOutFolder.mkdirs()) {
                    errorMessage = "No se puede crear la carpeta de salida para archivos decodificados";
                    continueProcess = false;
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.logDebug("Creaci\u00f3n de la carpeta de salida para decodificaci\u00f3n: [" + decodeOutFolder.getAbsolutePath() + "]");
                    }
                }
            }
        }

        if (continueProcess) {
            // Existence of file to decode
            if (fileToDecode.exists()) {
                if (!fileToDecode.delete()) {
                    errorMessage = "No se pudo eliminar el archivo [" + fileNameToDecode + "] ya existente para iniciar el proceso de decodificado";
                    continueProcess = false;
                }
            }

            if (continueProcess) {
                // Existence of decoded file
                if (fileDecoded.exists()) {
                    if (!fileDecoded.delete()) {
                        errorMessage = "No se pudo eliminar el archivo [" + fileNameDecoded + "] ya existente para iniciar el proceso de decodificado";
                        continueProcess = false;
                    }
                }
            }

            if (continueProcess) {
                // Move file to decode
                if (!originalFile.renameTo(fileToDecode)) {
                    errorMessage = "No se pudo mover el archivo [" + fileName + "] para decodificar";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            // Backup file to decode
            FileChannel srcChannel = null;
            FileChannel dstChannel = null;

            try {
                try {
                    srcChannel = new FileInputStream(fileNameToDecode).getChannel();
                } catch (FileNotFoundException e) {
                    errorMessage = "No existe el archivo a decodificar: [" + fileNameToDecode + "]";
                    continueProcess = false;
                }

                if (continueProcess) {
                    try {
                        dstChannel = new FileOutputStream(fileNameToDecode + ".bck").getChannel();
                    } catch (FileNotFoundException e) {
                        errorMessage = "No puede crear el archivo de respaldo: [" + fileNameToDecode + ".bck]";
                        continueProcess = false;
                    }
                }

                if (continueProcess) {
                    try {
                        dstChannel.transferFrom(srcChannel, 0, srcChannel.size());
                    } catch (IOException e) {
                        errorMessage = "No se pudo respaldar el archivo a decodificar [" + fileNameToDecode + "]";
                        continueProcess = false;
                    }
                }
            } finally {
                try {
                    if (srcChannel != null) srcChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo a decodificar: [" + fileNameToDecode + "]";
                    continueProcess = false;
                }
                try {
                    if (dstChannel != null) dstChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo de respaldo: [" + fileNameToDecode + ".bck]";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            if (logger.isDebugEnabled()) {
                logger.logDebug("Inicia software de criptograf\u00eda");
            }

            // Execute software to decode
            Runtime runtime = Runtime.getRuntime();
            Process process = null;
            try {
                process = runtime.exec(new String[]{"cmd", "/c",
                                "CmpApiCifradoDecode.bat",
                                fileNameToDecode,
                                fileNameDecoded},
                        null,
                        new File(encryptionSoftwarePath));
            } catch (IOException e) {
                errorMessage = "Error en ejecuci\u00f3n de software de criptograf\u00eda";
                continueProcess = false;
            }

            if (continueProcess) {
                // Handle output of software to decode
                InputStream inputStream = process.getInputStream();
                int i;
                StringBuilder stringBuilder = new StringBuilder();
                try {
                    while ((i = inputStream.read()) != -1) {
                        stringBuilder.append((char) i);
                    }
                    if (logger.isDebugEnabled()) {
                        logger.logDebug("Salida del programa de criptograf\u00eda: " + stringBuilder);
                    }
                } catch (IOException e) {
                    errorMessage = "Error en lectura de salida del programa de criptograf\u00eda";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            // Copy file decoded to IEN repository
            FileChannel srcChannel = null;
            FileChannel dstChannel = null;

            try {
                try {
                    srcChannel = new FileInputStream(fileNameDecoded).getChannel();
                } catch (FileNotFoundException e) {
                    errorMessage = "No existe el archivo decodificado: [" + fileNameDecoded + "]";
                    continueProcess = false;
                }

                if (continueProcess) {
                    try {
                        dstChannel = new FileOutputStream(originalFile).getChannel();
                    } catch (FileNotFoundException e) {
                        errorMessage = "No existe la ruta original de IEN: [" + originalFile.getParent() + "]";
                        continueProcess = false;
                    }
                }

                if (continueProcess) {
                    try {
                        dstChannel.transferFrom(srcChannel, 0, srcChannel.size());
                    } catch (IOException e) {
                        errorMessage = "No se pudo copiar el archivo decoficado [" + fileNameDecoded + "] a la ruta original de IEN [" + fileName + "]";
                        continueProcess = false;
                    }
                }
            } finally {
                try {
                    if (srcChannel != null) srcChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo decodificado: [" + fileNameDecoded + "]";
                    continueProcess = false;
                }
                try {
                    if (dstChannel != null) dstChannel.close();
                } catch (IOException e) {
                    errorMessage = "No se cerr\u00f3 correctamente el archivo de IEN: [" + fileName + "]";
                    continueProcess = false;
                }
            }
        }

        if (continueProcess) {
            logger.logInfo("DECODIFICACI\u00d3N EXITOSA !!");
            cryptographyResponse.setSuccess(true);
        }

        if (errorMessage != null) {
            logger.logError(errorMessage);
            cryptographyResponse.setErrorMessage(errorMessage);
        }

        return cryptographyResponse;
    }
}
