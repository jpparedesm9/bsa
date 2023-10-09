/*
 * Archivo: T_FLCRE_24_CTORY86_FormEvent.java
 * Fecha: Jan 7, 2017 9:02:13 AM
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

import com.cobiscorp.cobis.busin.customevents.events.ExecuteCommandCreateItem;
import com.cobiscorp.cobis.busin.customevents.events.InitDataCategory;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_24_CTORY86_FormEvent - Category
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"), @Property(name = "task.submodule", value = "FLCRE"), @Property(name = "task.id", value = "T_FLCRE_24_CTORY86"),
		@Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_24_CTORY86_FormEvent extends FormEventBuilder {

	private static final ILogger logger = LogFactory.getLogger(T_FLCRE_24_CTORY86_FormEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		if (logger.isDebugEnabled())
			logger.logInfo("Carga de eventos en TAREA - T_FLCRE_24_CTORY86");
		addInitDataEvent("VC_CTORY86_CTEGO_587", new InitDataCategory(serviceIntegration));
		addExecuteCommandEvent("CM_CTORY86ARB39", new ExecuteCommandCreateItem(serviceIntegration));

	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}