/*
 * Archivo: VW_REAJUSTEDT_141_ViewEvent.java
 * Fecha: Oct 25, 2016 10:20:50 AM
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

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.events.CatalogManager;
import com.cobiscorp.cobis.assts.customevents.events.ReadjustmentDetalilsLoanCommandEvents;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_REAJUSTEDT_141_ViewEvent - View of ReadjustmentDetalilsLoanForm
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_REAJUSTEDT_141"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_REAJUSTEDT_141_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory
			.getLogger(VW_REAJUSTEDT_141_ViewEvent.class);

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
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void configure() {
		if (logger.isDebugEnabled()) {
			logger.logInfo("addExecuteCommandEvent VA_VABUTTONRGCIAEL_707141");
		}
		// this.addExecuteCommandEvent("VA_GRIDROWCOMMMDDA_590141",
		// new ReadjustmentDetalilsLoanCommandEvents(serviceIntegration,
		// Parameter.TYPEEXECUTION.UPDATE)); // ACTUALIZAR
		// this.addExecuteCommandEvent("VA_GRIDROWCOMMMADA_872141",
		// new ReadjustmentDetalilsLoanCommandEvents(serviceIntegration,
		// Parameter.TYPEEXECUTION.DELETE)); // ELIMINAR

		this.addExecuteCommandEvent("VA_VABUTTONRGCIAEL_707141",
				new ReadjustmentDetalilsLoanCommandEvents(serviceIntegration,
						Parameter.TYPEEXECUTION.SEARCH));

		this.addLoadCatalog("VA_TEXTINPUTBOXFYD_123141", new CatalogManager(
				serviceIntegration));

	}

}