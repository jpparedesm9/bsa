package com.cobiscorp.cobis.busin.view.customevents.change;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class ChangeVA_ORIAHEADER8602_TERM237 extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeVA_ORIAHEADER8602_TERM237.class);

	public ChangeVA_ORIAHEADER8602_TERM237(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {

		try {

			LOGGER.logDebug("---->Entra al ChangePaymentFrequency");

			LOGGER.logError("---->Declaracion de TransactionManagement");
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			LOGGER.logDebug("---->Instancia de la entidad hacia los objetos");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

			LOGGER.logDebug("---->Variables APF");
			String namePaymentFrequencyAfp = "";
			String paymentFrequencyAfp = "";
			Integer plazoApf = 0;
			Integer factorApf = 0;

			LOGGER.logDebug("---->Variables de Presentacion");
			String paymentFrequency = originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) == null ? "" : originalHeader.get(OriginalHeader.PAYMENTFREQUENCY);
			Integer plazo = args.getNewValue() == null ? 0 : Integer.valueOf(String.valueOf(args.getNewValue()));
			Integer factor = 0;

			LOGGER.logDebug("---->Recuerapcion de parametro de plazo en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					originalHeader.get(OriginalHeader.PRODUCTTYPE), Mnemonic.PLAZO)) {
				plazoApf = Integer.parseInt(generalParametersValuesHistory.getValue());

			}

			LOGGER.logDebug("---->Recuerapcion de parametro de tipo cuota en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					originalHeader.get(OriginalHeader.PRODUCTTYPE), Mnemonic.TIPO_CUOTA)) {
				paymentFrequencyAfp = generalParametersValuesHistory.getValue();
			}

			LOGGER.logDebug("---->Recupera del factor de acuerdo a la factor de pago del apf");
			List<CatalogDto> catalogDtoList = queryStoredProcedureManagement.getPaymentFrequency(args, new BehaviorOption(true));
			LOGGER.logDebug("paymentFrequencyAfp: " + paymentFrequencyAfp);
			for (CatalogDto catalogDto : catalogDtoList) {
				LOGGER.logDebug("catalogDto.getCode(): " + catalogDto.getCode().trim());
				if (catalogDto.getCode().trim().equals(paymentFrequencyAfp.trim())) {
					namePaymentFrequencyAfp = catalogDto.getName();
					factorApf = Integer.valueOf(catalogDto.getDescription1().trim());
					LOGGER.logDebug("factorApf:" + factorApf);
					break;
				}
			}

			LOGGER.logDebug("---->Recupera del factor de acuerdo a la factor de pago");
			for (CatalogDto catalogDto : catalogDtoList) {
				if (paymentFrequency.equals(catalogDto.getCode().trim())) {
					factor = Integer.valueOf(catalogDto.getDescription1().trim());
					break;
				}
			}

			Integer daysApf = plazoApf * factorApf;
			Integer days = plazo * factor;

			LOGGER.logDebug("factorChange: " + factor);
			LOGGER.logDebug("daysChange: " + days);
			LOGGER.logDebug("daysApfChange: " + daysApf);
			LOGGER.logDebug("plazoApfChange: " + plazoApf);
			LOGGER.logDebug("factorApfChange: " + factorApf);

			// if (days > 0 && days <= daysApf) {
			// originalHeader.set(OriginalHeader.TERM, plazo);
			// } else {
			// args.getMessageManager().showErrorMsg(
			// "El plazo debe estar en el rango configurado el en producto ( Frecuencia: " +
			// namePaymentFrequencyAfp + " Plazo: " + plazoApf
			// + " )");
			// }

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_TERM, e, args, LOGGER);
		}

	}
}
