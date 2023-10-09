package com.cobiscorp.cobis.busin.customevents.change;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.bli.VW_ORIAHEADER86_BLI;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_VWPAYMENLA2606_AOUN554 extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeVA_VWPAYMENLA2606_AOUN554.class);

	public ChangeVA_VWPAYMENLA2606_AOUN554(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso IChangedEvent -> ChangeVA_VWPAYMENLA2606_AOUN554_MONTO_PROPUESTO_APPROVED_AMOUNT");
		try{
			DataEntity paymentPlan = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			//Recupero el monto propuesto del Plan de pagos del Refinanciamiento
			BigDecimal changedAmountReBigDecimal = paymentPlan.get(PaymentPlanHeader.APPROVEDAMOUNT);
			 BigDecimal suma1 =VW_ORIAHEADER86_BLI.sumRefinancing2(entities, args, super.getServiceIntegration());
			 //Comparo si el monto propuesto es menor igual a la suma de las operaciones
			 if (changedAmountReBigDecimal.floatValue() <= suma1.floatValue()) {
					MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_AMUNLLPTS_86896", MessageLevel.ERROR, true));
				}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_APROVED, e, args, LOGGER);
		}
		
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida IChangedEvent -> ChangeVA_VWPAYMENLA2606_AOUN554_MONTO_PROPUESTO_APPROVED_AMOUNT");
	}

}
