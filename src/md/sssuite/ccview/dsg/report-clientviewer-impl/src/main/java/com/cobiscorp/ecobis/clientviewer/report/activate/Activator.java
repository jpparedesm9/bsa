package com.cobiscorp.ecobis.clientviewer.report.activate;

import org.osgi.util.tracker.ServiceTracker;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;
import com.cobiscorp.ecobis.report.servlet.ProductHistoryServlet;

/**
 * Activator de reportes.
 * 
 * @author mcabay
 * 
 */
public class Activator extends HttpServiceActivator {
	private static final ILogger logger = LogFactory.getLogger(Activator.class);
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> tracker;
	private ICTSServiceIntegration serviceIntegration;

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
		this.registerServlet("/clientviewer/debtsLoansHist", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/creditsHist", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/warrantiesHis",new ProductHistoryServlet());
		this.registerServlet("/clientviewer/contingenciesHist", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/indirectPortfolioHis", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/productsOtherComextHist",new ProductHistoryServlet());
		this.registerServlet("/clientviewer/currentAccountsHis", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/savingAccountsHis", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/fixedTermsHis",new ProductHistoryServlet());
		this.registerServlet("/clientviewer/promissoryNotesHis", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/customerLinkedHis", new ProductHistoryServlet());
		this.registerServlet("/clientviewer/debitCardDataHis",new ProductHistoryServlet());
		this.registerServlet("/clientviewer/debtsSourceHist",new ProductHistoryServlet());
		this.registerServlet("/clientviewer/requestRejected",new ProductHistoryServlet());
	}

	@Override
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
	}
	
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
