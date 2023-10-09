package com.cobiscorp.ecobis.cobiscloud.loginvalidationext.impl;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.ConfigurationActivator;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Activator extends ConfigurationActivator {
    private static final ILogger logger = LogFactory.getLogger(Activator.class);

    public static final String FILE_CONFIG = "CLOUD-MOBILE/plugins/prk.dat";

    private static byte[] privateKey;


    public static byte[] getPrivateKey() {
        return privateKey;
    }


    @Override
    protected void loadConfiguration() throws Exception {
        logger.logInfo("Leyendo las configuraciones de componente");
        Activator.loadConfig();
        logger.logInfo("Exito leyendo configuraciones");

    }
    public static void loadConfig() {
        privateKey = readPrivateKey();
    }

    private static byte[] readPrivateKey() {

        String cobisHome = System.getProperty("COBIS_HOME");
        File cobisHomeFile = new File(cobisHome);
        logger.logInfo("Leyendo las configuraciones del archivo: " + FILE_CONFIG);
        File privateKeyFile = new File(cobisHomeFile, FILE_CONFIG);
        if(!privateKeyFile.exists()) {
            throw new COBISInfrastructureRuntimeException(
                    "No existe el archivo de la clave privada en el path:" + privateKeyFile.getAbsolutePath());
        }
        try {
            byte[] privateKeyBytes = readBytes(privateKeyFile.getAbsolutePath());
            return privateKeyBytes;
        } catch (IOException e) {
            throw new COBISInfrastructureRuntimeException("Problemas al obtener la clave privada del archivo", e);
        }

    }
    public static byte[] readBytes(String fileName ) throws IOException {
        FileInputStream fis = new FileInputStream(fileName);
        byte [] content = new byte[fis.available()];
        fis.read(content);
        fis.close();
        return content;
    }
}
