/*
 * Archivo: VW_OFICANSSEW26_ViewEvent.java
 * Fecha: Mar 17, 2015 6:53:17 PM
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

package com.cobiscorp.cobis.busin.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.view.customevents.events.ChangeTypeOperation;
import com.cobiscorp.cobis.busin.view.customevents.events.ChangeVA_OFICANSSEW2603_POCT250;
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogCity;
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogCreditLineValidByCustomer;
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogOfficial;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogParroquia;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogProvince;
//import com.cobiscorp.cobis.busin.flcre.officialactivityallocation.customevent.VW_OFICANSSEW26_ViewEvent;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_OFICANSSEW26_ViewEvent - OfficerAnalysisView 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_OFICANSSEW26"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_OFICANSSEW26_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	
	private static final ILogger logger1 = LogFactory.getLogger(VW_OFICANSSEW26_ViewEvent.class);
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;		
	
	
	private static final ILogger logger = LogFactory.getLogger(VW_OFICANSSEW26_ViewEvent.class);
			
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logInfo(">>>>>> Eventos personalizables");
		
		//refinancingdataentry
		addLoadCatalog("VA_OFICANSSEW2603_CITY183", new LoadCatalogCity(serviceIntegration)); //ok falta borrar las clases
		
		//oficialactivityallocation
		//addChangedEvent("VA_OFICANSSEW2603_POCT250",new ChangeVA_OFICANSSEW2603_POCT250Copy2(serviceIntegration));
		//addExecuteCommandEvent("CM_CAAIL82SAE52", new ExecuteComandOficial(this.serviceIntegration));
		addLoadCatalog("VA_OFICIALOBG2103_OFIL240", new LoadCatalogOfficial(this.serviceIntegration));		
		
		//legalanalysisactivity
		addChangedEvent("VA_OFICANSSEW2603_POCT250",new ChangeVA_OFICANSSEW2603_POCT250(serviceIntegration)); //ok falta borrar las clases
		
		//printingactivity revisar y/o borrar		
		
		//applicationanalysis
		addChangedEvent("VA_OFICANSSEW2603_POCT250",new ChangeTypeOperation(serviceIntegration));
		/*addLoadCatalog("VA_OFICANSSEW2603_CITY183",new LoadCatalogCity(serviceIntegration) );		
		addLoadCatalog("VA_OFICANSSEW2603_RQIA102",new LoadCatalogParroquia(serviceIntegration));
		addLoadCatalog("VA_OFICANSSEW2603_PONE992",new LoadCatalogProvince(serviceIntegration));*/
				
		
	}
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {		
		this.serviceIntegration = null;
	}
				
}