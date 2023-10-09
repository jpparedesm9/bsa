/*
 * Archivo: T_MEMBERHUJKTOU_740_FormEvent.java
 * Fecha: Mar 27, 2017 1:14:50 PM
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

package com.cobiscorp.cobis.loans.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_MEMBERHUJKTOU_740_FormEvent - MemberForm
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "LOANS"), @Property(name = "task.submodule", value = "GROUP"),
		@Property(name = "task.id", value = "T_MEMBERHUJKTOU_740"), @Property(name = "task.version", value = "1.0.0") })
public class T_MEMBERHUJKTOU_740_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_MEMBERHUJKTOU_740_FormEvent.class);

	// @Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	// private ICTSServiceIntegration serviceIntegration;

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	/*
	 * public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) { this.serviceIntegration = serviceIntegration; }
	 */

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	/*
	 * public void unsetServiceIntegration( ICTSServiceIntegration serviceIntegration) { this.serviceIntegration = null; }
	 */

	@Override
	public void configure() {
	}

}