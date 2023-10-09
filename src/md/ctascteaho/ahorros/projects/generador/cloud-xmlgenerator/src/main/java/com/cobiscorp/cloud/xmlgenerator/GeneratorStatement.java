package com.cobiscorp.cloud.xmlgenerator;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.xml.bind.JAXBElement;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;
import com.cobiscorp.cloud.xmlgenerator.commons.Commons;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.EstadoCuenta;
import com.cobiscorp.cloud.xmlgenerator.dto.jaxb.ObjectFactory;
import com.cobiscorp.cloud.xmlgenerator.service.ServiceStatement;

public class GeneratorStatement {

	private static final Logger logger = Logger
			.getLogger(GeneratorStatement.class);

	private static GeneratorStatement generatorStatement;
	private static Date processDate;
	private static Date dateNextLabor;
	private static String pathRoot;
	private static String pathTmp;

	private GeneratorStatement() {

	}

	public static GeneratorStatement getInstance() {
		if (generatorStatement == null) {
			generatorStatement = new GeneratorStatement();
		}
		return generatorStatement;
	}

	public static void main(String[] args) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia Main : " + args);
		}

		try {
			// Verifica las fechas
			if (!validateParams(args)) {
				return;
			}
			
			// Obtiene path para guardar xml
			if (!validatePath(Commons.getPaths())) {
				return;
			}
			// crea un archivo por estado de cuenta
			executeGenerator();
			// unifica los archivos en uno solo
			Commons.concatXml(pathRoot, "estadoCuenta", "EstadosCuentas");

		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e);
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza Main");
		}
	}

	public static boolean validateParams(String[] args) {
		// Verifica las fechas
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia validateParams : " + args);
		}
		if (args != null && args.length > 1) {
			processDate = Commons.stringToDate(args[0]);
			dateNextLabor = Commons.stringToDate(args[1]);
			return true;
		} else {
			logger.error("Por favor debe ingresar la fecha de proceso y la fecha del día siguiente laborable en formato yyyy-MM-dd");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza validateParams");
		}
		return false;

	}

	public static boolean validatePath(String[] paths) {
		// Verifica el path
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia validatePath : " + paths);
		}

		if (paths != null && paths.length > 1) {
			pathRoot = paths[0];
			pathTmp = paths[1];			
			return true;
		} else {
			logger.error("Por favor configurar xml.path");
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza validatePath");
		}
		return false;
	}

	public static void executeGenerator() throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia executeGenerator");
		}
		JaxbUtil jaxbUtil = new JaxbUtil();
		ObjectFactory factory = new ObjectFactory();
		ServiceStatement serviceSta = new ServiceStatement();
		List<EstadoCuenta> statements;

		int count = 0;
		int initialRange = 0;
		Integer finalRange = ConfigManager.getInstance().getRangeBach();
		do {
			if (logger.isDebugEnabled()) {
				logger.debug("*****************Inicia Consulta desde *************"
						+ initialRange);
			}
			statements = serviceSta.getStatements(factory, initialRange,
					finalRange, processDate, dateNextLabor);

			for (EstadoCuenta statement : statements) {
				File file = new File(pathTmp, "/file" + count + ".xml");
				JAXBElement<EstadoCuenta> root = factory
						.createEstadoCuenta(statement);
				jaxbUtil.marshall(statement, root, file);
				count++;
			}
			if (statements != null && !statements.isEmpty()) {
				initialRange = statements.get(statements.size() - 1)
						.getCuenta().getCodigo();
			}
			if (logger.isDebugEnabled()) {
				logger.debug("*****************Finaliza consulta, ultimo registro*************"
						+ initialRange);
			}

		} while (statements != null && !statements.isEmpty());
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza executeGenerator");
		}
	}

}
