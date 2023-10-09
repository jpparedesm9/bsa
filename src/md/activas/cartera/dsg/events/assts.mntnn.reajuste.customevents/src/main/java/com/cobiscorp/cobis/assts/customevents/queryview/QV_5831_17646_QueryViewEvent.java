/*
 * Archivo: QV_5831_17646_QueryViewEvent.java
 * Fecha: Oct 26, 2016 5:23:45 PM
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

package com.cobiscorp.cobis.assts.customevents.queryview;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.events.ReadjustmentLoanGridRowEvents;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * QV_5831_17646_QueryViewEvent - REAJUSTE
 * 
 * @autor designer
 */
@Component
@Service({ QueryViewEventBuilder.class })
@Properties({ @Property(name = "queryView.id", value = "QV_5831_17646") })
public class QV_5831_17646_QueryViewEvent extends QueryViewEventBuilder {

	private static final ILogger logger = LogFactory
			.getLogger(QV_5831_17646_QueryViewEvent.class);

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
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void configure() {

		if (logger.isDebugEnabled()) {
			logger.logInfo("GRID Reajuste Eventos personalizables (QV_5831_17646)");
		}

		this.addGridRowUpdating("QV_5831_17646",
				new ReadjustmentLoanGridRowEvents(serviceIntegration,
						Parameter.TYPEEXECUTION.UPDATE));
		this.addGridRowDeleting("QV_5831_17646",
				new ReadjustmentLoanGridRowEvents(serviceIntegration,
						Parameter.TYPEEXECUTION.DELETE));

		//
		// this.addExecuteCommandEvent("VA_GRIDROWCOMMMDDA_590141",
		// new ReadjustmentDetalilsLoanCommandEvents(serviceIntegration,
		// Parameter.TYPEEXECUTION.UPDATE)); // ACTUALIZAR
		// this.addExecuteCommandEvent("VA_GRIDROWCOMMMADA_872141",
		// new ReadjustmentDetalilsLoanCommandEvents(serviceIntegration,
		// Parameter.TYPEEXECUTION.DELETE)); // ELIMINAR
	}
}