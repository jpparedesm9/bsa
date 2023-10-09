package com.cobiscorp.cobis.busin.flcre.commons.bli;

import java.math.BigDecimal;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;

public class Expromission_BLI {

	public static void changeCurrencyRequested(DynamicRequest entities, IChangedEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntityList refOperations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		BigDecimal amountRequested = new BigDecimal(0);
		int currencyDestination = 0, localMoney = 0;

		// 1.- BUSCA MONEDA LOCAL
		CatalogManagement catalogMngmnt = new CatalogManagement(serviceIntegration);
		ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
		if (parameterDTO == null) {
			return;
		}
		localMoney = Integer.parseInt(parameterDTO.getParameterValue());
		// 2.- BUSCA MONEDA DE DESTINO
		currencyDestination = Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED));
		// 3.- CALCULA MONTO-SOLICITADO EN MONEDA DESTINO
		TransactionManagement tranManager = new TransactionManagement(serviceIntegration);
		for (DataEntity refOperation : refOperations) {
			if (localMoney == currencyDestination) {
				// SI MONEDA LOCAL Y DE DESTINO, SOLO SUMO LOS SALDOS EN MODEDA LOCAL
				amountRequested = refOperation.get(RefinancingOperations.LOCALCURRENCYBALANCE).add(amountRequested);
			} else {
				if (currencyDestination == refOperation.get(RefinancingOperations.CURRENCYOPERATION)) {
					// SI MONEDA DESTINO Y DE OPERACION ES LA MISMA TOMO EL SALDO
					amountRequested = refOperation.get(RefinancingOperations.BALANCE).add(amountRequested);
				} else {
					// SI MONEDA DESTINO Y DE OPERACION ES DISTINTA BUSCO COTIZACION
					QuoteRequest quoteRequest = new QuoteRequest();
					quoteRequest.setCurrencyOrigin(refOperation.get(RefinancingOperations.CURRENCYOPERATION));
					quoteRequest.setCurrencyDestination(currencyDestination);
					quoteRequest.setOffice(1);
					quoteRequest.setModule(Mnemonic.MODULE);
					Double amountInCurrencyDestination = tranManager.getQuote(refOperation.get(RefinancingOperations.CURRENCYOPERATION), currencyDestination,
							refOperation.get(RefinancingOperations.BALANCE).doubleValue(), arg1, new BehaviorOption(true));
					amountRequested = amountRequested.add(new BigDecimal(amountInCurrencyDestination));
				}
			}
		}
		// 5.- MAPEA DATOS
		originalHeader.set(OriginalHeader.AMOUNTREQUESTED, amountRequested);
	}

}