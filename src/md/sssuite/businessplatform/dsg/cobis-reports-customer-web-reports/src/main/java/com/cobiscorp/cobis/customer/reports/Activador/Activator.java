package com.cobiscorp.cobis.customer.reports.Activador;

import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.servlet.BuroCreditoHistoricoServlet;
import com.cobiscorp.cobis.customer.reports.servlet.BuroCreditoInternoExternoServlet;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;

public class Activator extends HttpServiceActivator {
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> tracker;
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoInternoExternoServlet.class);

	@Override
	protected String getContextRoot() {
		return "/cobis/web";
	}

	@Override
	public void loadHttpService() {

		logger.logDebug("---->> INICIO Activator - HttpServiceActivator");

		final BuroCreditoInternoExternoServlet buroCreditoInternoExternoServlet = new BuroCreditoInternoExternoServlet();
		final BuroCreditoHistoricoServlet buroCreditoHistoricoServlet = new BuroCreditoHistoricoServlet();

		this.tracker = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				buroCreditoInternoExternoServlet.setServiceIntegration(service);
				buroCreditoHistoricoServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				super.removedService(reference, service);
			}
		};
		this.tracker.open();
		this.registerServlet("/reports/BuroCreditoInternoExterno", buroCreditoInternoExternoServlet);
		this.registerServlet("/reports/BuroCreditoHistorico", buroCreditoHistoricoServlet);
	}	

	@Override
	public void continueStop() throws Exception {
		if (this.tracker != null) {
			this.tracker.close();
		}
		super.continueStop();
	}

}
