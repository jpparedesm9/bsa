package com.cobiscorp.cobis.busin.customevents.change;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
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

public class ChangeTermOn extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeTermOn.class);

	
	public ChangeTermOn(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		String namePaymentFrequencyAfp = "";
		String paymentFrequencyAfp = "";
		Integer plazoApf = 0;
		Integer factorApf = 0;


		try {
			LOGGER.logDebug("---->Entra al ChangeTermOn");

			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			
			LOGGER.logError("---->Declaracion de TransactionManagement");
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			LOGGER.logDebug("---->Instancia de la entidad hacia los objetos");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

			LOGGER.logDebug("---->Variables APF");
		

			LOGGER.logDebug("---->Variables de Presentacion");
			String paymentFrequency = paymentPlan.get(PaymentPlan.TERMTYPE)==null?"":paymentPlan.get(PaymentPlan.TERMTYPE);
			Integer plazo = paymentPlan.get(PaymentPlan.TERM) == null ? 0 : paymentPlan.get(PaymentPlan.TERM);
			Integer factor = 0;

			LOGGER.logDebug("---->Valida variables de entrada");
			if (paymentFrequency.equals("") && plazo == 0) {
				args.getMessageManager().showErrorMsg("El plazo debe ser diferente de cero y la frecuencia es obligatoria");
				return;
			}

			LOGGER.logDebug("---->Recuerapcion de parametro de plazo en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE), Mnemonic.PLAZO)) {
				plazoApf = Integer.parseInt(generalParametersValuesHistory.getValue());

			}

			LOGGER.logDebug("---->Recuerapcion de parametro de tipo cuota en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args,
					paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE), Mnemonic.TIPO_CUOTA)) {
				paymentFrequencyAfp = generalParametersValuesHistory.getValue();
			}

			LOGGER.logDebug("---->Recupera del factor de acuerdo a la factor de pago del apf");
			List<CatalogDto> catalogDtoList = queryStoredProcedureManagement.getPaymentFrequency(args, new BehaviorOption(true));
			for (CatalogDto catalogDto : catalogDtoList) {
				if (paymentFrequencyAfp.equals(catalogDto.getCode().trim())) {
					namePaymentFrequencyAfp = catalogDto.getName();
					factorApf = Integer.valueOf(catalogDto.getDescription1().trim());
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

			//if (days > 0 && days <= daysApf) {
			//	paymentPlan.set(PaymentPlan.TERM, plazo);
			//} else {
			//	args.getMessageManager().showErrorMsg(
			//			"El plazo debe estar en el rango configurado el en producto ( Frecuencia: " + namePaymentFrequencyAfp + " Plazo: " + plazoApf
			//					+ " )");
			//}			
			
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_TERM, e, args, LOGGER);
		}

	}
}
