package com.cobiscorp.cloud.notificationservice.main;

import javax.xml.bind.JAXBException;

import net.sf.jasperreports.engine.JRException;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.scheduler.utils.GenerateReport;

public class NotificationService {
	private static final Logger logger = Logger.getLogger(NotificationService.class);

	/**
	 * @param args
	 * @throws JAXBException
	 * @throws JRException
	 */

	private NotificationService() {

	}

	public static void main(String[] args) throws JRException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia Main : " + args);
			logger.debug("Argumento : " + args[0]);
		}
		String parameter = null;
		try {
			parameter = args[0].toUpperCase();
		} catch (Exception ex) {
			logger.debug("Exception: ", ex);
		}

		GenerateReport.generateReport(parameter, null);

		/********************/
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza Main");
		}
	}

}
