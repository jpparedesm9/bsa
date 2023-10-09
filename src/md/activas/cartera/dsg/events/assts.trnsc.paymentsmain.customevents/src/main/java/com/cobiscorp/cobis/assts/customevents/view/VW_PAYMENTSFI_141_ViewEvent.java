/*
 * Archivo: VW_PAYMENTSFI_141_ViewEvent.java
 * Fecha: Dec 5, 2016 2:18:56 PM
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





import com.cobiscorp.cobis.assts.customevents.events.CatalogBankPaymentMain;
import com.cobiscorp.cobis.assts.customevents.events.CatalogCurrencyPaymentMain;
import com.cobiscorp.cobis.assts.customevents.events.GetPaymentMethod;
import com.cobiscorp.cobis.assts.customevents.events.InitPaymentManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_PAYMENTSFI_141_ViewEvent - View of PaymentsForm
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_PAYMENTSFI_141"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_PAYMENTSFI_141_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory
			.getLogger(VW_PAYMENTSFI_141_ViewEvent.class);

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
        this.addLoadCatalog ("VA_TEXTINPUTBOXCFY_310141", new InitPaymentManager(serviceIntegration));
        this.addChangedEvent ("VA_TEXTINPUTBOXCFY_310141", new GetPaymentMethod(serviceIntegration));
        this.addLoadCatalog ("VA_CURRENCYSPEYFQA_285141", new CatalogCurrencyPaymentMain(serviceIntegration));
        this.addLoadCatalog ("VA_TEXTINPUTBOXSJQ_831141", new CatalogBankPaymentMain(serviceIntegration));
	}

}