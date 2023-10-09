/*
 * Archivo: Q_AMOUNTKL_6248_QueryEvent.java
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

package com.cobiscorp.cobis.loans.customevents.query;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.QueryEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Query
 * 
 * Q_AMOUNTKL_6248_QueryEvent - AmountQuery
 * 
 * @autor designer
 */
@Component
@Service({ QueryEventBuilder.class })
@Properties(value = { @Property(name = "query.id", value = "Q_AMOUNTKL_6248"), @Property(name = "query.version", value = "1.0.0") })
public class Q_AMOUNTKL_6248_QueryEvent extends QueryEventBuilder {

	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(Q_AMOUNTKL_6248_QueryEvent.class);

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