package com.cobiscorp.cobis.busin.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.change.ChangePaymentFrecuencyAmortization;
import com.cobiscorp.cobis.busin.customevents.change.ChangeRebateRequest;
import com.cobiscorp.cobis.busin.customevents.change.ChangeTermOn;
import com.cobiscorp.cobis.busin.customevents.change.ChangeVA_PROVTRIUST5751_AETE696;
import com.cobiscorp.cobis.busin.customevents.change.ChangeVA_VWPAYMENLA2606_AMUN652;
import com.cobiscorp.cobis.busin.customevents.change.ChangeVA_VWPAYMENLA2606_AOUN554;
import com.cobiscorp.cobis.busin.customevents.change.ChangeVA_VWPAYMENLA2606_RENC933;
import com.cobiscorp.cobis.busin.customevents.executeCommand.CargarGrupales;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteCommandVA_PROVTRIUST5706_TPPY859;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteCommandVA_VWPAYMENLA2613_0000566;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogAccounts;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogCurrencyByProduct;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogPaymentFrequency;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogPaymentWays;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogRebateRequest;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogSourceFunding;
import com.cobiscorp.cobis.busin.customevents.loadCatalog.LoadCatalogVA_VWPAYMENLA2606_ODCP782;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

@Component
@Service({ ViewEventBuilder.class })
@Properties(value = { @Property(name = "view.id", value = "VW_VWPAYMENLA26"),
		@Property(name = "view.version", value = "1.0.0") })
public class VW_VWPAYMENLA26_ViewEvent extends ViewEventBuilder {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static final ILogger logger = LogFactory
			.getLogger(VW_VWPAYMENLA26_ViewEvent.class);

	@Override
	public void configure() {
		if (logger.isDebugEnabled())
			logger.logDebug("Eventos personalizable - VW_VWPAYMENLA26_ViewEvent");

		addLoadCatalog("VA_VWPAYMENLA2606_ODCP782",
				new LoadCatalogVA_VWPAYMENLA2606_ODCP782(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2606_RENC933",
				new ChangeVA_VWPAYMENLA2606_RENC933(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2606_AMUN652",
				new ChangeVA_VWPAYMENLA2606_AMUN652(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2606_AOUN554",
				new ChangeVA_VWPAYMENLA2606_AOUN554(serviceIntegration));
		addExecuteCommandEvent("VA_VWPAYMENLA2613_0000566",
				new ExecuteCommandVA_VWPAYMENLA2613_0000566(serviceIntegration));

		// para pestaña de preguntas rebaja de tasa
		addChangedEvent("VA_PROVTRIUST5751_AETE696",
				new ChangeVA_PROVTRIUST5751_AETE696(serviceIntegration));
		addExecuteCommandEvent("VA_PROVTRIUST5706_TPPY859",
				new ExecuteCommandVA_PROVTRIUST5706_TPPY859(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2622_REAT420", new ChangeRebateRequest(
				serviceIntegration));
		addLoadCatalog("VA_VWPAYMENLA2622_EBEQ282",
				new LoadCatalogRebateRequest(serviceIntegration));

		// para el catlogo Fuente de Financiamieto
		addLoadCatalog("VA_VWPAYMENLA2621_OUED445",
				new LoadCatalogSourceFunding(serviceIntegration));
		addExecuteCommandEvent("VA_VWPAYMENLA2621_NCRI285",
				new ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285(
						serviceIntegration));

		// catalogo de moneda
		addLoadCatalog("VA_VWPAYMENLA2606_RENC933",
				new LoadCatalogCurrencyByProduct(serviceIntegration));

		// Catalogo Plazo
		addLoadCatalog("VA_VWPAYMENLA2607_ATQC570",
				new LoadCatalogPaymentFrequency(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2607_ATQC570",
				new ChangePaymentFrecuencyAmortization(serviceIntegration));
		addChangedEvent("VA_VWPAYMENLA2607_TERM808", new ChangeTermOn(
				serviceIntegration));
		// Catalogo Frecuencia de Pago
		addLoadCatalog("VA_VWPAYMENLA2605_TATY621",
				new LoadCatalogPaymentFrequency(serviceIntegration));

		// Catalogo Formas de Pago
		addLoadCatalog("VA_VWPAYMENLA2618_MEOE230", new LoadCatalogPaymentWays(
				serviceIntegration));

		// Catalogo Cuentas
		addLoadCatalog("VA_VWPAYMENLA2618_BTCO941", new LoadCatalogAccounts(
				serviceIntegration));

		//Boton para carga de informacion de grupales
		addExecuteCommandEvent("VA_VABUTTONPSZFMGQ_712A26", new CargarGrupales(serviceIntegration));
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}