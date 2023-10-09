/*
 * Archivo: VW_AMOUNTPOKC_190_ViewEvent.java
 * Fecha: Mar 22, 2017 5:22:34 PM
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

package com.cobiscorp.cobis.loans.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.events.CreateAmount;
import com.cobiscorp.cobis.loans.customevents.events.LoadBusinessData;
import com.cobiscorp.cobis.loans.customevents.events.SynchronizationMovilGroup;
import com.cobiscorp.cobis.loans.customevents.events.VA_TEXTINPUTBOXSRP_129190_Change;
import com.cobiscorp.cobis.loans.customevents.events.VA_VABUTTONAICSAKZ_975190_Execute;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * <p>
 * VW_AMOUNTPOKC_190_ViewEvent - View of AmountForm
 *
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_AMOUNTPOKC_190"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_AMOUNTPOKC_190_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_AMOUNTPOKC_190_ViewEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 *
	 * @param serviceIntegration Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 *
	 * @param serviceIntegration Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public void configure() {
		logger.logInfo(">>>>>> Eventos personalizables");
		this.addChangedEvent("VA_TEXTINPUTBOXSRP_129190", new VA_TEXTINPUTBOXSRP_129190_Change(serviceIntegration));
		this.addExecuteCommandEvent("VA_VABUTTONNPVXIJW_123190", new CreateAmount(serviceIntegration));
		this.addExecuteCommandEvent("VA_VABUTTONAICSAKZ_975190",new VA_VABUTTONAICSAKZ_975190_Execute(serviceIntegration));
		this.addExecuteCommandEvent("VA_VABUTTONGPPUIHN_830190", new SynchronizationMovilGroup(serviceIntegration));
	
		this.addLoadCatalog("VA_TEXTINPUTBOXYVS_120190", new LoadBusinessData(serviceIntegration));
	}

}