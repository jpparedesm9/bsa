/*
 * Archivo: VW_ORIAHEADER86_ViewEvent.java
 * Fecha: Jun 3, 2015 10:58:38 AM
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

import com.cobiscorp.cobis.busin.view.customevents.change.ChangeBankingProduct;
import com.cobiscorp.cobis.busin.view.customevents.change.ChangeOffice;
import com.cobiscorp.cobis.busin.view.customevents.change.ChangePaymentFrequency;
import com.cobiscorp.cobis.busin.view.customevents.change.ChangeSegment;
import com.cobiscorp.cobis.busin.view.customevents.change.ChangeVA_ORIAHEADER8602_TERM237;
import com.cobiscorp.cobis.busin.view.customevents.events.ChangeVA_ORIAHEADER8602_EVAL957;
import com.cobiscorp.cobis.busin.view.customevents.events.ChangeVA_ORIAHEADER8602_OQUE134;
import com.cobiscorp.cobis.busin.view.customevents.events.ChangeVA_ORIAHEADER8602_URQT595;
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogCompanySheet;
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogCreditLineValidByCustomer;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogActivityDestination;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogBankingProduct;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogCurrencyByProduct;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogFinantialDestination;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogInsurance;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogOtherDestination;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogPaymentFrequency;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogSector;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogTerm;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogTermMedicalAssistance;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_ORIAHEADER86_ViewEvent - HeaderView
 * 
 * @autor designer
 */
@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_ORIAHEADER86"), @Property(name = "view.version", value = "1.0.0") })
public class VW_ORIAHEADER86_ViewEvent extends ViewEventBuilder {
	private static final ILogger logger = LogFactory.getLogger(VW_ORIAHEADER86_ViewEvent.class);
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public void configure() {
		logger.logDebug("Entra a VW_ORIAHEADER86_ViewEvent");
		// addLoadCatalog("VA_OFICANSSEW2603_CITY183", new
		// LoadCatalogCity(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8602_URQT595", new ChangeVA_ORIAHEADER8602_URQT595(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8602_OQUE134", new ChangeVA_ORIAHEADER8602_OQUE134(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8602_EVAL957", new ChangeVA_ORIAHEADER8602_EVAL957(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8605_TIRC927", new ChangeBankingProduct(serviceIntegration));
		addChangedEvent("VA_PAYMENTFREQUECN_439R86", new ChangePaymentFrequency(serviceIntegration));
		addChangedEvent("VA_TERMLJXTQBYRQKU_619R86", new ChangeVA_ORIAHEADER8602_TERM237(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8605_SETO998", new ChangeSegment(serviceIntegration));
		addChangedEvent("VA_ORIAHEADER8605_ORTR915", new ChangeOffice(serviceIntegration));

		// addLoadCatalog("VA_ORIAHEADER8602_EVAL957", new
		// LoadCatalogCreditLineValidByCustomer(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8602_REET975", new LoadCatalogCompanySheet(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8602_URQT595", new LoadCatalogCurrencyByProduct(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_ERTO640", new LoadCatalogCreditLineValidByCustomer(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_OCRI261", new LoadCatalogFinantialDestination(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_ENEO318", new LoadCatalogActivityDestination(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_SETO998", new LoadCatalogSector(serviceIntegration));
		addLoadCatalog("VA_PAYMENTFREQUECN_439R86", new LoadCatalogPaymentFrequency(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_OEIO709", new LoadCatalogOtherDestination(serviceIntegration));
		addLoadCatalog("VA_ORIAHEADER8605_TIRC927", new LoadCatalogBankingProduct(serviceIntegration));
		addLoadCatalog("VA_TERMINDTMTELITU_695R86", new LoadCatalogTerm(serviceIntegration));
		addLoadCatalog("VA_INSURANCEPACKEG_674R86", new LoadCatalogInsurance(serviceIntegration));
		addLoadCatalog("VA_TERMMEDICALAISS_991R86", new LoadCatalogTermMedicalAssistance(serviceIntegration));
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}