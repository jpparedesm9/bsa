package com.cobiscorp.cobis.busin.customevents.change;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.CategoryReadjustment;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeItem extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeItem.class);

	public ChangeItem(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand method ChangeItem class");
		}

		ItemsManagement itemsManagement = new ItemsManagement(getServiceIntegration());
		ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();
		try {
			DataEntity category = entities.getEntity(Category.ENTITY_NAME);
			DataEntity categoryReadjustment = entities.getEntity(CategoryReadjustment.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)" + paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));
			loanItemsRequest.setBank(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED) == null ? null : String.valueOf(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)));// banco-rot_operacion
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("category.get(Category.CURRENCY)" + category.get(Category.CURRENCY));
			loanItemsRequest.setCurrency(category.get(Category.CURRENCY).intValue());// moneda-rot_moneda
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("category.get(Category.PRODUCTTYPE) " + category.get(Category.PRODUCTTYPE));
			loanItemsRequest.setOperationType(category.get(Category.PRODUCTTYPE) == null ? null : category.get(Category.PRODUCTTYPE).trim()); // toperacion
			loanItemsRequest.setType("V");// tipo
			loanItemsRequest.setFineItem("N");// rubros multa
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("category.get(Category.CONCEPT)" + category.get(Category.CONCEPT));
			loanItemsRequest.setConcept(category.get(Category.CONCEPT));// rubro
																		// o
																		// concepto-rot_concepto
			ReadLoanItemsResponse[] itemResponse = itemsManagement.readItem(entities, args, loanItemsRequest);			
			if (itemResponse != null) {
				LOGGER.logDebug("itemResponse size:" + itemResponse.length);
				category.set(Category.CONCEPTTYPE, itemResponse[0].getItemType() == null ? null :itemResponse[0].getItemType()); // rot_tipo_rubro
				category.set(Category.METHODOFPAYMENT, itemResponse[0].getMethodOfPayment()); // rot_fpago
				category.set(Category.PRIORITY, itemResponse[0].getPriority()); // rot_prioridad
				category.set(Category.PAYMENTARREARS, itemResponse[0].getPayArrears()); // rot_paga_mora
				category.set(Category.PROVISIONED, itemResponse[0].getProvisioned()); // rot_provisiona
				category.set(Category.ITEMTYPE, itemResponse[0].getItemType());
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("itemResponse[0].getItemType()------>" + category.get(Category.ITEMTYPE));
					LOGGER.logDebug("itemResponse[0].getReference()" + itemResponse[0].getReference());
				}	
				category.set(Category.REFERENCE, itemResponse[0].getReference()); // rot_referencial
				category.set(Category.REFERENCEDESCRIPTION, itemResponse[0].getReferenceDescription());
				category.set(Category.READJUSTMENTSIGN, itemResponse[0].getReadjustmentSign()); // rot_signo_reajuste
				category.set(Category.READJUSTMENTFACTOR, itemResponse[0].getReadjustmentFactor());// rot_factor_reajuste
				category.set(Category.READJUSTMENT, itemResponse[0].getReadjustmentReferential());// rot_referecial_reajuste
				category.set(Category.PERCENTAGE, 0.0);
				category.set(Category.CONCEPTASOC, itemResponse[0].getConceptAsoc()); // rot_concepto_asociado
				category.set(Category.MAXIMUN, itemResponse[0].getMaxValue());
				category.set(Category.MINIMUM, itemResponse[0].getMinValue());
				category.set(Category.SIGN, itemResponse[0].getSign());
				category.set(Category.SPREAD, itemResponse[0].getFactor());
				category.set(Category.VALUE, itemResponse[0].getValue());
				category.set(Category.REFERENCEAMOUNT, itemResponse[0].getReferenceAmount());
				category.set(Category.AMOUNTOAPPLY,itemResponse[0].getReference()); // itemResponse[0].getAmounToApply());
				if (LOGGER.isDebugEnabled())
					LOGGER.logInfo("itemResponse[0].getMaximunRate() ====> " + itemResponse[0].getMaximunRate());
				category.set(Category.MAXRATE, itemResponse[0].getMaximunRate());
				category.set(Category.DIFFER, itemResponse[0].getDefer()); // rot_diferir
				category.set(Category.PAYMENTARREARS, itemResponse[0].getPayArrears());
				category.set(Category.CALCULATEDBASE, itemResponse[0].getCalculatedBase());
				category.set(Category.CONCEPTTYPEDESCRIPTION, itemResponse[0].getConceptTypeDescription());
				category.set(Category.PAYMENTFORMDESCRIPTION, itemResponse[0].getPaymentFormDescription());
				
				//Reajuste
				categoryReadjustment.set(CategoryReadjustment.CONCEPT,category.get(Category.CONCEPT));
				categoryReadjustment.set(CategoryReadjustment.AMOUNTTOAPPLY, itemResponse[0].getReadjustmentAmountToApply());
				categoryReadjustment.set(CategoryReadjustment.REFERENCE,itemResponse[0].getReadjustmentReferential());
				categoryReadjustment.set(CategoryReadjustment.REFERENCEDESCRIPTION, itemResponse[0].getReadjustmentReferentialDesc());
				categoryReadjustment.set(CategoryReadjustment.REFERENCEAMOUNT, itemResponse[0].getReadjustmentReferentialValue());
				categoryReadjustment.set(CategoryReadjustment.SIGN, itemResponse[0].getReadjustmentSign()==null ?null:String.valueOf(itemResponse[0].getReadjustmentSign()));
				categoryReadjustment.set(CategoryReadjustment.SPREAD, itemResponse[0].getReadjustmentFactor());
				categoryReadjustment.set(CategoryReadjustment.VALUE, itemResponse[0].getReadjustmentValue());
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("CategoryReadjustment.get(CategoryReadjustment.VALUE)" + categoryReadjustment.get(CategoryReadjustment.VALUE));
				categoryReadjustment.set(CategoryReadjustment.MAXIMUN, itemResponse[0].getReadjustmentMaxValue());
				categoryReadjustment.set(CategoryReadjustment.MINIMUM, itemResponse[0].getReadjustmentMinValue());

			} else {
				args.setSuccess(false);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_ITEM, e, args, LOGGER);
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish executeCommand method in ChangeItem class");
			}
		}

	}// Fin evento change
}

