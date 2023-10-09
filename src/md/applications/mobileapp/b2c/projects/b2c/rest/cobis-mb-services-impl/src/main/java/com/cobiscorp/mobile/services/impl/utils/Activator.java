package com.cobiscorp.mobile.services.impl.utils;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.ConfigurationActivator;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Activator extends ConfigurationActivator {

	private static final ILogger logger = LogFactory.getLogger(Activator.class);

	public static final String FILE_CONFIG = "CLOUD-MOBILE/plugins/.mobkeyprod.key";

	private static String privateKey;

	public static String getPrivateKey() {
		return privateKey;
	}

	@Override
	protected void loadConfiguration() throws Exception {
        Activator.loadConfig();
	}
	public static void loadConfig() {
        logger.logInfo("Leyendo las configuraciones de componente");
        privateKey = readPrivateKey();
        logger.logInfo("Exito leyendo configuraciones");

    }

	private static String readPrivateKey() {

		String cobisHome = System.getProperty("COBIS_HOME");
		File cobisHomeFile = new File(cobisHome);
		logger.logInfo("Leyendo las configuraciones del archivo: " + FILE_CONFIG);
		File privateKeyFile = new File(cobisHomeFile, FILE_CONFIG);
		if(!privateKeyFile.exists()) {
			throw new COBISInfrastructureRuntimeException(
					"No existe el archivo de la clave privada en el path:" + privateKeyFile.getAbsolutePath());
		}
		try {
			byte[] privateKeyBytes = KeepSecurity.readBytes(privateKeyFile.getAbsolutePath());
			return ByteConverter.tranformToHex(privateKeyBytes);
		} catch (IOException e) {
			throw new COBISInfrastructureRuntimeException("Problemas al obtener la clave privada del archivo", e);
		}

	}
	
	
}