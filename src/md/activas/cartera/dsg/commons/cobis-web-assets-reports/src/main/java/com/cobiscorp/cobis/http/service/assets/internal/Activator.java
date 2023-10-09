/*
 * Archivo: Activator.java
 * Fecha: Feb 17, 2014
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */
package com.cobiscorp.cobis.http.service.assets.internal;

import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

import com.cobiscorp.cobis.assets.reports.base.CollateralPaymentServlet;
import com.cobiscorp.cobis.assets.reports.base.CorresponsalPaymentServlet;
import com.cobiscorp.cobis.assets.reports.base.CreditAgreementServlet;
import com.cobiscorp.cobis.assets.reports.base.GenericPaymentSlipServlet;
import com.cobiscorp.cobis.assets.reports.base.LiquidationServlet;
import com.cobiscorp.cobis.assets.reports.base.PaymentCardServlet;
import com.cobiscorp.cobis.assets.reports.base.PaymentTableServlet;
import com.cobiscorp.cobis.assets.reports.base.PreCancellationServlet;
import com.cobiscorp.cobis.assets.reports.base.PromissoryNoteServlet;
import com.cobiscorp.cobis.assets.reports.base.ReceiptPaymentServlet;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.plugin.activator.HttpServiceActivator;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class Activator extends HttpServiceActivator {

	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerLiquidation;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerReceipt;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerPromissory;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerPaymentTable;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerCredit;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerCollateral;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerPreCancellation;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerPaymentCard;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerCorresponsalPayment;
	private ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration> trackerGenericPaymentSlip;

	private static final ILogger logger = LogFactory.getLogger(Activator.class);

	@Override
	protected String getContextRoot() {
		return "/cobis/web";
	}

	@Override
	public void loadHttpService() {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START loadHttpService ");
		}

		final LiquidationServlet liquidationServlet = new LiquidationServlet();
		final ReceiptPaymentServlet receiptPaymentServlet = new ReceiptPaymentServlet();
		final PromissoryNoteServlet promissoryNoteServlet = new PromissoryNoteServlet();
		final PaymentTableServlet paymentTableServlet = new PaymentTableServlet();
		final CreditAgreementServlet creditAgreementServlet = new CreditAgreementServlet();
		final CollateralPaymentServlet collateralPaymentServlet = new CollateralPaymentServlet();
		final PreCancellationServlet preCancellationServlet = new PreCancellationServlet();
		final PaymentCardServlet paymentCardServlet = new PaymentCardServlet();
		final CorresponsalPaymentServlet corresponsalPaymentServlet = new CorresponsalPaymentServlet();
		final GenericPaymentSlipServlet genericPaymentSlipServlet = new GenericPaymentSlipServlet();

		this.trackerLiquidation = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				liquidationServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				liquidationServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerReceipt = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				receiptPaymentServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				receiptPaymentServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerPromissory = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				promissoryNoteServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				promissoryNoteServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerPaymentTable = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				paymentTableServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				paymentTableServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerCredit = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				creditAgreementServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				creditAgreementServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerCollateral = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				collateralPaymentServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				collateralPaymentServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};
		this.trackerPreCancellation = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				preCancellationServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				preCancellationServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerPaymentCard = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				paymentCardServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				paymentCardServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};
		this.trackerCorresponsalPayment = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(),
				null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				corresponsalPaymentServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				preCancellationServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};
		this.trackerGenericPaymentSlip = new ServiceTracker<ICTSServiceIntegration, ICTSServiceIntegration>(this.getBundleContext(), ICTSServiceIntegration.class.getName(), null) {
			@Override
			public ICTSServiceIntegration addingService(ServiceReference<ICTSServiceIntegration> reference) {
				ICTSServiceIntegration service = super.addingService(reference);
				genericPaymentSlipServlet.setServiceIntegration(service);
				return service;
			}

			@Override
			public void removedService(ServiceReference<ICTSServiceIntegration> reference, ICTSServiceIntegration service) {
				genericPaymentSlipServlet.unsetServiceIntegration();
				super.removedService(reference, service);
			}
		};

		this.trackerLiquidation.open();
		this.trackerReceipt.open();
		this.trackerPromissory.open();
		this.trackerPaymentTable.open();
		this.trackerCredit.open();
		this.trackerCollateral.open();
		this.trackerPreCancellation.open();
		this.trackerPaymentCard.open();
		this.trackerCorresponsalPayment.open();
		this.trackerGenericPaymentSlip.open();

		this.registerServlet("/reports/Liquidation", liquidationServlet);
		this.registerServlet("/reports/ReceiptPayment", receiptPaymentServlet);
		this.registerServlet("/reports/PromissoryNote", promissoryNoteServlet);
		this.registerServlet("/reports/CreditAgreement", creditAgreementServlet);
		this.registerServlet("/reports/PaymentTable", paymentTableServlet);
		this.registerServlet("/reports/GarantiaLiquida", collateralPaymentServlet);
		this.registerServlet("/reports/PreCancellation", preCancellationServlet);
		this.registerServlet("/reports/paymentCard", paymentCardServlet);
		this.registerServlet("/reports/CorresponsalPayment", corresponsalPaymentServlet);
		this.registerServlet("/reports/GenericPaymentSlip", genericPaymentSlipServlet);

	}

}
