/*
 * Archivo: T_ASSCRLLURZAUF_274_FormEvent.java
 * Fecha: 28/06/2019 8:35:10
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

package com.cobiscorp.cobis.asscr.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_ASSCRLLURZAUF_274_FormEvent - ResetMessageImage
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "ASSCR"), @Property(name = "task.submodule", value = "CREIR"), @Property(name = "task.id", value = "T_ASSCRLLURZAUF_274"), @Property(name = "task.version", value = "1.0.0") })
public class T_ASSCRLLURZAUF_274_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_ASSCRLLURZAUF_274_FormEvent.class);

	// @Reference(bind = "setServiceIntegration", unbind =
	// "unsetServiceIntegration", cardinality =
	// ReferenceCardinality.MANDATORY_UNARY)
	// private ICTSServiceIntegration serviceIntegration;

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration Instance of ICTSServiceIntegration
	 */
	/*
	 * public void setServiceIntegration(ICTSServiceIntegration serviceIntegration)
	 * { this.serviceIntegration = serviceIntegration; }
	 */

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration Instance of ICTSServiceIntegration
	 */
	/*
	 * public void unsetServiceIntegration( ICTSServiceIntegration
	 * serviceIntegration) { this.serviceIntegration = null; }
	 */

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
	}

}