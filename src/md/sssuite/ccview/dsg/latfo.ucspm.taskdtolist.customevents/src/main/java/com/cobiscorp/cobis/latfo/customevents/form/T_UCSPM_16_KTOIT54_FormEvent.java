/*
 * Archivo: T_UCSPM_16_KTOIT54_FormEvent.java
 * Fecha: 16/09/2015 09:35:53 AM
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

package com.cobiscorp.cobis.latfo.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.customevents.events.InitdataDtoList;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_UCSPM_16_KTOIT54_FormEvent - TaskDTOList
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "LATFO"), @Property(name = "task.submodule", value = "UCSPM"),
		@Property(name = "task.id", value = "T_UCSPM_16_KTOIT54"), @Property(name = "task.version", value = "1.0.0") })
public class T_UCSPM_16_KTOIT54_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static final ILogger logger = LogFactory.getLogger(T_UCSPM_16_KTOIT54_FormEvent.class);

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logDebug("Se registran los servicios");
		addInitDataEvent("VC_KTOIT54_DOLST_848", new InitdataDtoList(serviceIntegration));
		// addExecuteCommandEvent("CM_MAMIE85CET66", new ExecuteCommandAccept(serviceIntegration));
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}