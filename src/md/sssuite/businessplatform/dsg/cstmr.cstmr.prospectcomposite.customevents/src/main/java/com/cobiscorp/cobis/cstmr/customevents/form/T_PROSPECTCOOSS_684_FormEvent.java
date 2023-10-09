/*
 * Archivo: T_PROSPECTCOOSS_684_FormEvent.java
 * Fecha: Jan 25, 2017 10:28:02 AM
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

package com.cobiscorp.cobis.cstmr.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.events.InitDataProspect;
import com.cobiscorp.cobis.cstmr.customevents.events.QueryBureau;
import com.cobiscorp.cobis.cstmr.customevents.events.QueryRenapo;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_PROSPECTCOOSS_684_FormEvent - ProspectComposite
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "CSTMR"), @Property(name = "task.submodule", value = "CSTMR"),
		@Property(name = "task.id", value = "T_PROSPECTCOOSS_684"), @Property(name = "task.version", value = "1.0.0") })
public class T_PROSPECTCOOSS_684_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_PROSPECTCOOSS_684_FormEvent.class);

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
	// TODO Se deben agregar los eventos a administrar
	public void configure() {

		this.addExecuteCommandEvent("CM_TPROSPEC_STR", new QueryBureau(serviceIntegration));
		this.addInitDataEvent("VC_PROSPECTMI_213684", new InitDataProspect(serviceIntegration));
		this.addExecuteCommandEvent("CM_TPROSPEC_MR6", new QueryRenapo(serviceIntegration));
	}

}