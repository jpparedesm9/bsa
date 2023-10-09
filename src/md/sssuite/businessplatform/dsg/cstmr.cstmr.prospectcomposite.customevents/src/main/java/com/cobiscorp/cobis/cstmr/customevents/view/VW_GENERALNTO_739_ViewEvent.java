/*
 * Archivo: VW_GENERALNTO_739_ViewEvent.java
 * Fecha: Jan 25, 2017 10:28:02 AM
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

package com.cobiscorp.cobis.cstmr.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.events.Change_VA_TEXTINPUTBOXDXR_200739;
import com.cobiscorp.cobis.cstmr.customevents.events.Change_VA_TEXTINPUTBOXNJK_823739;
import com.cobiscorp.cobis.cstmr.customevents.events.Change_VA_TEXTINPUTBOXXGF_770739;
import com.cobiscorp.cobis.cstmr.customevents.events.ExecuteCommand_VA_VABUTTONUBNHVJA_668739;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCountryofBirth;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadLegalCatalogDocumenType;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadNaturalCatalogDocumenType;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_GENERALNTO_739_ViewEvent - View of GeneralForm
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_GENERALNTO_739"), @Property(name = "view.version", value = "1.0.0") })
public class VW_GENERALNTO_739_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_GENERALNTO_739_ViewEvent.class);

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
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logInfo(">>>>>> Eventos personalizables23");
		addChangedEvent("VA_TEXTINPUTBOXNJK_823739", new Change_VA_TEXTINPUTBOXNJK_823739(serviceIntegration));
		addChangedEvent("VA_TEXTINPUTBOXDXR_200739", new Change_VA_TEXTINPUTBOXDXR_200739(serviceIntegration));
		addChangedEvent("VA_TEXTINPUTBOXXGF_770739", new Change_VA_TEXTINPUTBOXXGF_770739(serviceIntegration));
		addLoadCatalog("VA_DOCUMENTTYPEFZR_461739", new LoadNaturalCatalogDocumenType(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXDYK_693739", new LoadNaturalCatalogDocumenType(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXNLL_783739", new LoadLegalCatalogDocumenType(serviceIntegration));
		addLoadCatalog("VA_COUNTYOFBIRTHHH_490739", new LoadCountryofBirth(serviceIntegration));
		addLoadCatalog("VA_COUNTRYOFBIRHTH_170739", new LoadCountryofBirth(serviceIntegration));

		logger.logInfo(">>>>>> Eventos personalizables........");
		this.addExecuteCommandEvent("VA_VABUTTONUBNHVJA_668739", new ExecuteCommand_VA_VABUTTONUBNHVJA_668739(serviceIntegration));
	}

}