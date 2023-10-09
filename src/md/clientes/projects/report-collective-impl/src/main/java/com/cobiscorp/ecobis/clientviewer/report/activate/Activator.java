package com.cobiscorp.ecobis.clientviewer.report.activate;

import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;
import com.cobiscorp.ecobis.report.servlet.AdvisorReportHistoryServlet;

/**
 * Activator de reportes.
 * 
 * @author mcabay
 * 
 */
public class Activator extends HttpServiceActivator {
	private static final ILogger logger = LogFactory.getLogger(Activator.class);
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerAdvisor;
	//private ICTSServiceIntegration serviceIntegration;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.cobis.plugin.activator.HttpServiceActivator#getContextRoot()
	 */
	@Override
	protected String getContextRoot() {
		return "/cobis/web";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.cobis.plugin.activator.HttpServiceActivator#loadHttpService()
	 */
	@Override
	public void loadHttpService() {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START loadHttpService ");
		}
		final AdvisorReportHistoryServlet advisorReportHistoryServlet = new AdvisorReportHistoryServlet();
	
		
		this.trackerAdvisor = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				advisorReportHistoryServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				advisorReportHistoryServlet.unsetServiceIntegration();;
				super.removedService(reference, service);
			}
		};
		
		this.trackerAdvisor.open();
		//this.registerServlet("/clientviewer/advisorReportHist", advisorReportHistoryServlet);
		this.registerServlet("/COLLECTIVE-CLIENT/advisorReportHist", advisorReportHistoryServlet);
		
	}

	/*@Override
	public void continueStop() throws Exception {
		if (this.tracker != null) {
			this.tracker.close();
		}
		super.continueStop();
	}

	@Override
	public void continueStart() throws Exception {
		System.out.println("Inicia continueStart");
		super.continueStart();
	}*/
	
	/*public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}*/
}
