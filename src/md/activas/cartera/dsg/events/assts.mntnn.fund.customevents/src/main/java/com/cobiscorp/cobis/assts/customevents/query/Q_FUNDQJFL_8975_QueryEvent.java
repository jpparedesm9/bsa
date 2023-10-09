/*
 * Archivo: Q_FUNDQJFL_8975_QueryEvent.java
 * Fecha: Jun 16, 2017 10:52:04 AM
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

package com.cobiscorp.cobis.assts.customevents.query;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.events.ExecuteQueryFundResources;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.QueryEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * Q_FUNDQJFL_8975_QueryEvent - FundQuery
 * 
 * @autor designer
 */
@Component
@Service({ QueryEventBuilder.class })
@Properties(value = { @Property(name = "query.id", value = "Q_FUNDQJFL_8975"),
		@Property(name = "query.version", value = "1.0.0") })
public class Q_FUNDQJFL_8975_QueryEvent extends QueryEventBuilder {

	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory
			.getLogger(Q_FUNDQJFL_8975_QueryEvent.class);

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
	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public void configure() {
		this.addQueryEvent(
				"Q_FUNDQJFL_8975",
				(com.cobiscorp.designer.api.customization.IExecuteQuery) new ExecuteQueryFundResources(
						this.serviceIntegration));
	}
}