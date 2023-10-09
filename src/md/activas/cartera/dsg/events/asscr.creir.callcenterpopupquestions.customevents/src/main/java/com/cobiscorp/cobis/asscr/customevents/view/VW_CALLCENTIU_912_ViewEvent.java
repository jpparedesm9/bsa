/*
 * Archivo: VW_CALLCENTIU_912_ViewEvent.java
 * Fecha: 13/06/2019 16:46:38
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

package com.cobiscorp.cobis.asscr.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.asscr.customevents.form.events.SearchDataClient;
import com.cobiscorp.cobis.asscr.customevents.form.events.ValidationQuestion;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_CALLCENTIU_912_ViewEvent - View of CallCenterPopupQuestions
 *
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_CALLCENTIU_912"), @Property(name = "view.version", value = "1.0.0") })
public class VW_CALLCENTIU_912_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_CALLCENTIU_912_ViewEvent.class);

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

		logger.logInfo(">>>>>> Ingresa a Eventos de botones de Popup Call Center");

this.addExecuteCommandEvent("VA_VABUTTONMLAQDME_803912", new SearchDataClient(serviceIntegration));		
this.addExecuteCommandEvent("VA_VABUTTONPDDCALJ_814912", new ValidationQuestion(serviceIntegration));
		
	}

}