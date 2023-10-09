/*
 * Archivo: T_GROUPCOMPOIET_974_FormEvent.java
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

package com.cobiscorp.cobis.loans.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.events.CreateGroup;
import com.cobiscorp.cobis.loans.customevents.events.SyncMobile;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_GROUPCOMPOIET_974_FormEvent - GroupComposite
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "LOANS"), @Property(name = "task.submodule", value = "GROUP"),
		@Property(name = "task.id", value = "T_GROUPCOMPOIET_974"), @Property(name = "task.version", value = "1.0.0") })
public class T_GROUPCOMPOIET_974_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_GROUPCOMPOIET_974_FormEvent.class);

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
		logger.logDebug("-->  T_GROUPCOMPOIET_974_FormEvent configure");

		this.addInitDataEvent("VC_GROUPCOMOS_387974", new InitDataGroupComposite(serviceIntegration));
		this.addExecuteCommandEvent("CM_TGROUPCO_IRO", new CreateGroup(serviceIntegration));
		// this.addExecuteCommandEvent("VA_VABUTTONQGYEKJY_245213", new ReadCustomerExecuteCommandEvent(serviceIntegration));
		this.addExecuteCommandEvent("CM_TGROUPCO_O3P", new SyncMobile(serviceIntegration));
	}

}