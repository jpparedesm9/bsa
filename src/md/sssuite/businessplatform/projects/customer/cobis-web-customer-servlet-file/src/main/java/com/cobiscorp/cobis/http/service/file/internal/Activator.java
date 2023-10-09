package com.cobiscorp.cobis.http.service.file.internal;

import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.platform.customer.files.GetFileHistoricalServlet;
import com.cobiscorp.cobis.platform.customer.files.GetFileServlet;
import com.cobiscorp.cobis.platform.customer.files.UploadFileServlet;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;


public class Activator extends HttpServiceActivator {

	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerUp;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerGet;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerHistoryGet;
	
	
	@Override
	protected String getContextRoot() {
		return "/cobis/web";
	}

	@Override
	public void loadHttpService() {
		final UploadFileServlet uploadFileServlet = new UploadFileServlet();
		final GetFileServlet getFileServlet = new GetFileServlet();
		final GetFileHistoricalServlet getFileHistoricalServlet = new GetFileHistoricalServlet();
		
		this.registerServlet("/customer/UploadFileServlet", uploadFileServlet);
		this.registerServlet("/customer/GetFileServlet", getFileServlet);
		this.registerServlet("/customer/GetFileHistoricalServlet", getFileHistoricalServlet);

	    //UploadFileServlet
		this.trackerUp = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(),
				ICTSServiceIntegration.class.getName(), null) {

			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration serviceIntegration = super.addingService(reference);
				uploadFileServlet.setServiceIntegration(serviceIntegration);
				return serviceIntegration;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference,
					ICTSServiceIntegration service) {
				uploadFileServlet.unsetServiceIntegration(service);
				super.removedService(reference, service);
			}
			
		};
		this.trackerUp.open();
		
		
		//GetFileServlet
		this.trackerGet = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(),
				ICTSServiceIntegration.class.getName(), null) {

			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration serviceIntegration = super.addingService(reference);
				getFileServlet.setServiceIntegration(serviceIntegration);
				return serviceIntegration;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference,
					ICTSServiceIntegration service) {
				getFileServlet.unsetServiceIntegration(service);
				super.removedService(reference, service);
			}
			
		};
		this.trackerGet.open();
		
		//GetFileHistoricalServlet
		this.trackerHistoryGet = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(),
				ICTSServiceIntegration.class.getName(), null) {

			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration serviceIntegration = super.addingService(reference);
				getFileHistoricalServlet.setServiceIntegration(serviceIntegration);
				return serviceIntegration;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference,
					ICTSServiceIntegration service) {
				getFileHistoricalServlet.unsetServiceIntegration(service);
				super.removedService(reference, service);
			}
			
		};
		this.trackerHistoryGet.open();
		
	}

	

	@Override
	public void continueStop() throws Exception {
		super.continueStop();
		this.trackerUp.close();
		this.trackerGet.close();
		this.trackerHistoryGet.close();
	}
	
	

}
 