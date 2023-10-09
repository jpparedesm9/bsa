/*
 * Archivo: QV_PESAU2317_81_QueryViewEvent.java
 * Fecha: Dec 21, 2016 8:37:49 PM
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

import com.cobiscorp.cobis.busin.custonevents.events.QV_PESAU2317_81_RowDeleting;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * QV_PESAU2317_81_QueryViewEvent - EntryWarranty 
 *
 * @autor designer
 */
@Component
@Service({ QueryViewEventBuilder.class })
@Properties({ @Property(name = "queryView.id", value = "QV_PESAU2317_81") })

public class QV_PESAU2317_81_QueryViewEvent extends QueryViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(QV_PESAU2317_81_QueryViewEvent.class);
	
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
		addGridRowDeleting("QV_PESAU2317_81", new QV_PESAU2317_81_RowDeleting(serviceIntegration));
        
        
	}		
}