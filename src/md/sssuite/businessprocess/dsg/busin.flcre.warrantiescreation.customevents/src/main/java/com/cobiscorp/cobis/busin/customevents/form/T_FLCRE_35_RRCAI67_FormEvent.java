/*
 * Archivo: T_FLCRE_35_RRCAI67_FormEvent.java
 * Fecha: Dec 14, 2016 4:24:06 PM
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

package com.cobiscorp.cobis.busin.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events.CloseModalFindingWarranty;
import com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events.ExecuteUpdateWarranty;
import com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events.InitDataWarranty;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_35_RRCAI67_FormEvent - warrantiesCreation
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"), @Property(name = "task.submodule", value = "FLCRE"), @Property(name = "task.id", value = "T_FLCRE_35_RRCAI67"),
		@Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_35_RRCAI67_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_FLCRE_35_RRCAI67_FormEvent.class);

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
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		addInitDataEvent("VC_RRCAI67_WACRI_884", new InitDataWarranty(serviceIntegration));
		addExecuteCommandEvent("CM_RRCAI67UAR18", new ExecuteUpdateWarranty(serviceIntegration));
		addOnCloseModalEvent("VC_RRCAI67_WACRI_884", new CloseModalFindingWarranty(serviceIntegration));

	}

}