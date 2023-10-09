/*
 * Archivo: VW_PDUCTGOUIE37_ViewEvent.java
 * Fecha: 04/03/2015 03:58:14 PM
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

package com.cobiscorp.cobis.finpm.mprod.productgrouptask.customevent;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.finpm.mprod.productgrouptask.events.ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238;
import com.cobiscorp.cobis.finpm.mprod.productgrouptask.events.ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_PDUCTGOUIE37_ViewEvent - productGroupView
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_PDUCTGOUIE37"), @Property(name = "view.version", value = "1.0.0") })
public class VW_PDUCTGOUIE37_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_PDUCTGOUIE37_ViewEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logInfo(">>>>>> Eventos personalizables");
		// boton save
		addExecuteCommandEvent("VA_PDUCTGOUIE3705_IDLU238", new ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238(serviceIntegration));
		// boton associate
		addExecuteCommandEvent("VA_PDUCTGOUIE3707_0000006", new ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006(serviceIntegration));
	}

}