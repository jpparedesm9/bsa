package com.cobiscorp.cobis.customer.reports.base;

import javax.servlet.http.HttpServlet;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.customer.reports.servlet.BuroCreditoInternoExternoServlet;

/**
 * Clase base para reportes.
 * 
 * @author sgavilanes
 * 
 */
public class BaseReportServlet extends HttpServlet {

	/**
	 * Clase que permite obtener el identificador del tipo de archivo para PDF.
	 */
	protected static final String APPLICATION_PDF = "application/pdf";

	private static final String DIRECTORIO_REPORTES = "directorioReportes";
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoInternoExternoServlet.class);
	/**
	 * Id por serialización.
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Método que permite obtener el directorio de reportes en función de la configuración del aplicativo.
	 * 
	 * @param idReporte
	 *            Identificador del reporte.
	 * @return Directorio del reporte.
	 */
	protected String getReportsDirectory(String idReporte) {
		logger.logDebug("---->> INICIO BaseReportServlet - getReportsDirectory");
		String cobishome = COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE);
		return null;/*
					 * cobishome + ServiceConfiguration.obtenerPropiedades(DIRECTORIO_REPORTES) + ServiceConfiguration.obtenerPropiedades(idReporte);
					 */
	}

}
