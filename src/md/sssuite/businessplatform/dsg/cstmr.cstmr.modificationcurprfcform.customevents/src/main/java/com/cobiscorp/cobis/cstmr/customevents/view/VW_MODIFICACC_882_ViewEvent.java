/*
 * Archivo: VW_MODIFICACC_882_ViewEvent.java
 * Fecha: Jan 17, 2018 2:11:59 PM
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

package com.cobiscorp.cobis.cstmr.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.events.ExecuteCommandLoadDataCustomer;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCountryofBirth;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadDocumentTypeCatalog;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_MODIFICACC_882_ViewEvent - View of ModificationCURPRFCForm
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_MODIFICACC_882"), @Property(name = "view.version", value = "1.0.0") })
public class VW_MODIFICACC_882_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_MODIFICACC_882_ViewEvent.class);

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

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public void configure() {
		logger.logInfo(">>>>>> Eventos personalizables - VW_MODIFICACC_882_ViewEvent");
		this.addLoadCatalog("VA_COUNTYOFBIRTHHH_156882", new LoadCountryofBirth(serviceIntegration));
		this.addLoadCatalog("VA_DOCUMENTTYPEMOR_836882", new LoadDocumentTypeCatalog(serviceIntegration));
		this.addExecuteCommandEvent("VA_VABUTTONBISUTWO_919882", new ExecuteCommandLoadDataCustomer(serviceIntegration));
	}

}