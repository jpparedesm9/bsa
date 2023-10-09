package com.cobiscorp.cobis.busin.flcre.commons.bli;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.MessageLevel;

public class VW_ORIAHEADER86_BLI {

	private static final ILogger logger = LogFactory.getLogger(VW_ORIAHEADER86_BLI.class);
	public static void changeCurrencyRequested(DynamicRequest entities, IChangedEventArgs args, ICTSServiceIntegration serviceIntegration) {
		changed(entities, args, serviceIntegration);
	}

	public static void changeAmountRequested(DynamicRequest entities, IChangedEventArgs args, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		String EtapaTramite = (originalHeader.get(OriginalHeader.STAGEFLUX) != null) ? originalHeader.get(OriginalHeader.STAGEFLUX) : "";
		String TipoTramite = (originalHeader.get(OriginalHeader.TYPE) != null) ? originalHeader.get(OriginalHeader.TYPE) : "";
		if (EtapaTramite.equals(Mnemonic.STAGEENTRY) && TipoTramite.equals(Mnemonic.REFINANCINGREQUEST)
				|| (EtapaTramite.equals(Mnemonic.STAGEANALIYSIS) && TipoTramite.equals(Mnemonic.RESCHEDULEREQUEST))) {
			// DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			BigDecimal suma = sumRefinancing(entities, args, serviceIntegration);
			changed(entities, args, serviceIntegration);
			BigDecimal changedAmountReBigDecimal = originalHeader.get(OriginalHeader.AMOUNTREQUESTED);

			if(suma != null){
				if (changedAmountReBigDecimal.floatValue() <= suma.floatValue()) {
					MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_AMUNLLPTS_86896", MessageLevel.ERROR, true));
				}
			}
			
		} else {
			changed(entities, args, serviceIntegration);
		}
	}

	private static void changed(DynamicRequest entities, IChangedEventArgs args, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		String localMoney = null;
		CatalogManagement catalogMngnt = new CatalogManagement(serviceIntegration);
		ParameterResponse parameterDto = catalogMngnt.getParameter(4, "MLO", "ADM", args, new BehaviorOption(false, false));
		if (originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null) {
			if (parameterDto != null) {
				localMoney = parameterDto.getParameterValue();
			}
			QuoteRequest quoteRequest = new QuoteRequest();
			quoteRequest.setCurrencyOrigin(Integer.parseInt(localMoney));
			if (originalHeader.get(OriginalHeader.CURRENCYREQUESTED) != null) {
				quoteRequest.setCurrencyDestination(Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED)));
			} else {
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));
			}
			quoteRequest.setOffice(1);
			quoteRequest.setModule(Mnemonic.MODULE);
			Double cotization = null;
			TransactionManagement tranManager = new TransactionManagement(serviceIntegration);

			if (quoteRequest.getCurrencyOrigin().equals(quoteRequest.getCurrencyDestination()))
				cotization = tranManager.getQuote(quoteRequest, args, new BehaviorOption(true));
			else
				cotization = tranManager.getQuoteUSD(quoteRequest, args, new BehaviorOption(true));
			originalHeader.set(OriginalHeader.AMOUNTREQUESTEDML, originalHeader.get(OriginalHeader.AMOUNTREQUESTED).multiply(new BigDecimal(cotization)));
			// cambio para utilizar sp que devuelve el valor convertido
			/*
			 * if (quoteRequest.getCurrencyOrigin().equals(quoteRequest.getCurrencyDestination()))
			 * originalHeader.set(OriginalHeader.AMOUNTREQUESTEDML, originalHeader.get(OriginalHeader.AMOUNTREQUESTED)); else{ Double
			 * amountInCurrencyDestination = tranManager.getQuote(Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED)),
			 * Integer.parseInt(localMoney), originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue(), args, new BehaviorOption(true));
			 * originalHeader.set(OriginalHeader.AMOUNTREQUESTEDML, new BigDecimal(amountInCurrencyDestination )); }
			 */
		}
	}

	public static void changeCurrencyRequestedInReprogramming(DynamicRequest entities, IChangedEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		// 1.- INICIO DE VALORES
		String EtapaTramite = (originalHeader.get(OriginalHeader.STAGEFLUX) != null) ? originalHeader.get(OriginalHeader.STAGEFLUX) : "";
		String TipoTramite = (originalHeader.get(OriginalHeader.TYPE) != null) ? originalHeader.get(OriginalHeader.TYPE) : "";

		if (EtapaTramite.equals(Mnemonic.STAGEENTRY) && TipoTramite.equals(Mnemonic.REFINANCINGREQUEST)) {
			// 1.- BUSCA MONEDA DE DESTINO
			int currencyDestination = Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED));

			// 2.- CALCULA MONTO EN MONEDA DE 'DESTINO'
			if (currencyDestination >= 0) {
				DataEntityList operations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);
				OperationManagement operationManagement = new OperationManagement(serviceIntegration);
				BigDecimal amountRequested = operationManagement.calculateAmountInAnyCurrency(currencyDestination, operations, arg1);
				if (amountRequested == null) {
					amountRequested = new BigDecimal(0);
				}
				originalHeader.set(OriginalHeader.AMOUNTREQUESTED, amountRequested);
			}
		}
	}

	private static BigDecimal sumRefinancing(DynamicRequest entities, IChangedEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		int currencyDestination = 0, localMoney = 0;
		BigDecimal amountRequested = new BigDecimal(0);

		DataEntityList operations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);
		if (operations.size() > 0) {
			// 1.- BUSCA MONEDA LOCAL
			CatalogManagement catalogMngmnt = new CatalogManagement(serviceIntegration);
			ParameterResponse parameterDTO = catalogMngmnt.getParameter(4, "MLO", "ADM", arg1, new BehaviorOption(true));
			if (parameterDTO == null) {
				return null;
			}
			localMoney = Integer.parseInt(parameterDTO.getParameterValue());
			// 2.- BUSCA MONEDA DE DESTINO
			currencyDestination = Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED));
			// 3.- CALCULA MONTO-SOLICITADO EN MONEDA DESTINO
			for (DataEntity refOperation : operations) {
				amountRequested = refOperation.get(RefinancingOperations.LOCALCURRENCYBALANCE).add(amountRequested);
			}
			originalHeader.set(OriginalHeader.AMOUNTREQUESTEDML, amountRequested);
			if (localMoney != currencyDestination) {
				// SI MONEDA LOCAL Y DE DESTINO, SOLO SUMO LOS SALDOS EN MODEDA LOCAL
				// SI MONEDA DESTINO Y DE OPERACION ES DISTINTA BUSCO COTIZACION
				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(localMoney);
				quoteRequest.setCurrencyDestination(currencyDestination);
				quoteRequest.setOffice(1);
				quoteRequest.setModule(Mnemonic.MODULE);
				TransactionManagement tranManager = new TransactionManagement(serviceIntegration);
				Double amountInCurrencyDestination = tranManager.getQuote(localMoney, currencyDestination, amountRequested.doubleValue(), arg1, new BehaviorOption(true));
				amountRequested = new BigDecimal(amountInCurrencyDestination);

				// if (quoteRequest.getCurrencyOrigin().equals(quoteRequest.getCurrencyDestination()))
				// cotization = tranManager.getQuote(quoteRequest, arg1, new BehaviorOption(true));
				// else
				// cotization = tranManager.getQuoteUSD(quoteRequest, arg1, new BehaviorOption(true));
				//
				// amountRequested = amountRequested.divide(new BigDecimal(cotization));
			}

		} else {
			MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_ANRSRAPRA_09435", MessageLevel.ERROR, true));
			return null;
		}
		return amountRequested;
	}
	
	public static BigDecimal sumRefinancing2(DynamicRequest entities, IChangedEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		String numeroTramite = originalHeader.get(OriginalHeader.IDREQUESTED);
		TransactionManagement tranManager = new TransactionManagement(serviceIntegration);
		BigDecimal sum = new BigDecimal(0);
		Double amountInCurrencyDestination = 0.0;

		/* EJECUCION DEL SERVICIO DEVUELVE LOS MONTOS Y MONEDAS DE LAS OPERACIONES */
		RenewLoanRequest dtoBalanceRequest = new RenewLoanRequest();
		dtoBalanceRequest.setRequestId(numeroTramite);
		dtoBalanceRequest.setCustomerId(-1);
		// Se obtiene el valor de cada una de las operaciones
		RenewLoanResponse[] balanceResponse = tranManager.getBalancebyOperation(dtoBalanceRequest, arg1, new BehaviorOption(true));
		ApplicationResponse applicationResponseDTO = tranManager.getApplication(Integer.parseInt(numeroTramite), arg1, new BehaviorOption(true));
		if (balanceResponse != null) {
			// SOLO CUANDO ES UNA REPROGRAMACION
			if (IsRefinancing(applicationResponseDTO)) { // SOLO CUANDO ES UNA Refinanciamiento
				if (logger.isDebugEnabled())
					logger.logDebug("1..................REPROGRAMACION.........");
				for (RenewLoanResponse response : balanceResponse) {// Recorre la lista de resultados de la ejecucion del servicio
					if (Integer.parseInt(response.getOperationMoney()) == applicationResponseDTO.getCurrencyRequested()) {
						sum = sum.add(new BigDecimal(response.getBalance()));
					} else {
						amountInCurrencyDestination = tranManager.getQuote(Integer.parseInt(response.getOperationMoney()), applicationResponseDTO.getCurrencyRequested(), response.getBalance(), arg1,
								new BehaviorOption(true));
						sum = sum.add(new BigDecimal(amountInCurrencyDestination));
					}
				}// FIN FOR
			}
		}
		return sum;
	}

	private static boolean IsRefinancing(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.REFINANCINGREQUEST));
	}
	
	
	

}