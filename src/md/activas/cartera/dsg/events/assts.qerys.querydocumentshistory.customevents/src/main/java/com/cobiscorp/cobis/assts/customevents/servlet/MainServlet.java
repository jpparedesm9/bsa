package com.cobiscorp.cobis.assts.customevents.servlet;

import java.util.ArrayList;
import java.util.List;

//import javax.servlet.http.HttpServlet;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.bsl.Version;
import com.cobiscorp.cobis.assets.commons.impl.AlfrescoServicesImpl;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;

public abstract class MainServlet {

	private static ILogger logger = LogFactory.getLogger(MainServlet.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	// FIELDS
	private String APPLICATION_TYPE = "HTML";// PDF, HTML , EXCEL, RTF
	protected final int DATE_FORMAT = 103;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Main Set serviceIntegration:" + serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	// PROPERTIES
	protected String getApplicationType() {
		return APPLICATION_TYPE;
	}

	protected void setApplicationType(String applicationType) {
		this.APPLICATION_TYPE = applicationType;
	}

	public static List<Version> getVersionsHistorical(String session, String folder, String customerId, String fileName, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicio uploadFile" + session + " " + customerId);
		}
		List<Version> retorno = new ArrayList<Version>();
		
		GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();
		getCredentialsImpl.setServiceIntegration(serviceIntegration);

		CredentialsDTO credentials = null;
		try {
			credentials = getCredentialsImpl.getCredentials(session);
		} catch (Exception e) {
			new Exception("No se encuentra autorizado para realizar esta acción");
		}

		String password = credentials.getPassword();

		if (customerId != null && !customerId.equalsIgnoreCase("0")) {
			
			AlfrescoServicesImpl alfrescoImpl = new AlfrescoServicesImpl();
			retorno = alfrescoImpl.getVersions(StorageConfiguration.getConfiguration(1, "library"), fileName, 
					StorageConfiguration.getConfiguration(1, "login"), password);
		}
		
		if (logger.isDebugEnabled())
			logger.logDebug("Finaliza uploadFile");
		return retorno;
	}
}
