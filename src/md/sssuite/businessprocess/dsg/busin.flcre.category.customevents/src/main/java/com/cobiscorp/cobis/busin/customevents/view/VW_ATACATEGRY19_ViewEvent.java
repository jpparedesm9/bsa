/*
 * Archivo: VW_ATACATEGRY19_ViewEvent.java
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

package com.cobiscorp.cobis.busin.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.change.ChangeItem;
import com.cobiscorp.cobis.busin.customevents.change.ChangeReadjustmentValueReference;
import com.cobiscorp.cobis.busin.customevents.change.ChangeValueReference;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogInsertItem;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogReadValueApply;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_ATACATEGRY19_ViewEvent - DataCategory
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_ATACATEGRY19"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_ATACATEGRY19_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory
			.getLogger(VW_ATACATEGRY19_ViewEvent.class);
	@Reference(bind = "setCacheManager", unbind = "unsetCacheManager", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICacheManager cacheManager;

	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	public void unsetCacheManager(ICacheManager cacheManager) {
		this.cacheManager = null;
	}

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {

		logger.logDebug(">>>>>> Eventos personalizables VW_ATACATEGRY19_ViewEvent");

		addLoadCatalog("VA_ATACATEGRY1902_COEP019", new LoadCatalogInsertItem(
				serviceIntegration, cacheManager));
		addChangedEvent("VA_ATACATEGRY1902_COEP019", new ChangeItem(
				serviceIntegration));
		addLoadCatalog("VA_ATACATEGRY1902_AUNL784",
				new LoadCatalogReadValueApply(serviceIntegration, cacheManager));
		addChangedEvent("VA_ATACATEGRY1902_AUNL784", new ChangeValueReference(
				serviceIntegration)); // Valor a Aplicar

		// REAJUSTE
		addLoadCatalog("VA_ATACATEGRY1904_COEP407", new LoadCatalogInsertItem(
				serviceIntegration, cacheManager));
		addLoadCatalog("VA_ATACATEGRY1904_AOOP178",
				new LoadCatalogReadValueApply(serviceIntegration, cacheManager));
		addChangedEvent("VA_ATACATEGRY1904_AOOP178",
				new ChangeReadjustmentValueReference(serviceIntegration)); // Valor
																			// a
																			// Aplicar

	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}