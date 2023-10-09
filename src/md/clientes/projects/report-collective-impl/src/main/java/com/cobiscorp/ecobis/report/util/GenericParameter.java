package com.cobiscorp.ecobis.report.util;

import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class GenericParameter {

	private static final ILogger logger = LogFactory.getLogger(GenericParameter.class);

	public Map<String, Object> getReportsParameter(String title, String show, String clientName, String dateFormatPattern, JRBeanCollectionDataSource datasource) {
		// TODO Remove hardcoded sorry :(
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (logger.isDebugEnabled()) {
			logger.logDebug("El tipo de reporte es " + show);
		}
	
		parameters.put("DataSourceAsesores", datasource);
		
		for (Map.Entry<String, Object> entry : parameters.entrySet()) {
			logger.logDebug("clave=" + entry.getKey() + ", valor=" + entry.getValue());
		}
		return parameters;
	}
}
