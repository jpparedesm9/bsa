package com.cobiscorp.cobis.loans.reports.commons;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class SigantureServices extends ServicesBase {
	private static final ILogger logger = LogFactory.getLogger(SigantureServices.class);

	public SigantureServices(String sessionId) {
		super(sessionId);
	}

	public SigantureServices(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public SigantureServices(String sessionId, ICTSServiceIntegration serviceIntegration) {
		super(sessionId, serviceIntegration);
	}

}
