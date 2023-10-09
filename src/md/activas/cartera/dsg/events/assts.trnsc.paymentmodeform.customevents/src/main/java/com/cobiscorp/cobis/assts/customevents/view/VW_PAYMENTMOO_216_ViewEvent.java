/*
 * Archivo: VW_PAYMENTMOO_216_ViewEvent.java
 * Fecha: Dec 28, 2016 5:41:17 PM
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

package com.cobiscorp.cobis.assts.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.events.ChangeValueValidation;
import com.cobiscorp.cobis.assts.customevents.events.EventChangedLoadQuotation;
import com.cobiscorp.cobis.assts.customevents.events.InitDataCurrency;
import com.cobiscorp.cobis.assts.customevents.events.InitDataPaymentMode;
import com.cobiscorp.cobis.assts.customevents.events.LoadPaymentFormCategory;
import com.cobiscorp.cobis.assts.customevents.events.QueryCobisAccountValidation;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_PAYMENTMOO_216_ViewEvent - View of PaymentModeForm
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_PAYMENTMOO_216"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_PAYMENTMOO_216_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory
			.getLogger(VW_PAYMENTMOO_216_ViewEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public void configure() {
		logger.logInfo(">>>>>> Eventos personalizables");
		// Combo Oculto Moneda
		this.addLoadCatalog("VA_6057SWXKCQQHOIS_464216", new InitDataCurrency(
				serviceIntegration)); // OK
		this.addChangedEvent("VA_6057SWXKCQQHOIS_464216",
				(com.cobiscorp.designer.api.customization.IChangedEvent) null);

		// Combo Forma de Pago
		this.addLoadCatalog("Spacer2675", new InitDataPaymentMode(
				serviceIntegration)); // OK
		this.addChangedEvent("Spacer2675",
				 new LoadPaymentFormCategory(this.serviceIntegration));

		// TextBox Referencia(accountNumber)
		this.addChangedEvent("VA_2481BBVZTGCBDCR_830216",
				new QueryCobisAccountValidation(this.serviceIntegration));
		// TextBox Valor
		this.addChangedEvent("VA_8983QPJHQZZOSML_321216",
				new ChangeValueValidation(this.serviceIntegration));
		// Combo Moneda
		this.addLoadCatalog("VA_4212YIFTVBCOPPD_140216", new InitDataCurrency(
				serviceIntegration));
		this.addChangedEvent("VA_4212YIFTVBCOPPD_140216",
				new EventChangedLoadQuotation(this.serviceIntegration)); // OK
	}

}