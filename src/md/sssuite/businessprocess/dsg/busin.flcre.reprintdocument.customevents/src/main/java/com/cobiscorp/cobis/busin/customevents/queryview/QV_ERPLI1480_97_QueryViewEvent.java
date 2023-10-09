/*
 * Archivo: QV_ERPLI1480_97_QueryViewEvent.java
 * Fecha: 30/06/2017 14:28:19
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

package com.cobiscorp.cobis.busin.customevents.queryview;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.events.QV_ERPLI1480_97_RowSelecting;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * QV_ERPLI1480_97_QueryViewEvent - RePrintDocument 
 *
 * @autor designer
 */
@Component
@Service({ QueryViewEventBuilder.class })
@Properties({ @Property(name = "queryView.id", value = "QV_ERPLI1480_97") })

public class QV_ERPLI1480_97_QueryViewEvent extends QueryViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(QV_ERPLI1480_97_QueryViewEvent.class);
	
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
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		LOGGER.logInfo(">>>>>> Eventos personalizables Grid");
		addGridRowSelecting("QV_ERPLI1480_97", new QV_ERPLI1480_97_RowSelecting(serviceIntegration));
	}		
}