package com.cobiscorp.cobis.busin.customevents.events;

//import org.apache.log4j.Category;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;

import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.CategoryReadjustment;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandCreateItem extends BaseEvent implements
		IExecuteCommand {

	private static final ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandCreateItem.class);

	public ExecuteCommandCreateItem(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Inicio ejecucion Save Items");

		try {
			ItemsManagement itemsManagement = new ItemsManagement(
					getServiceIntegration());
			DataEntity category = entities.getEntity(Category.ENTITY_NAME);
			DataEntity categoryReadjusment = entities
					.getEntity(CategoryReadjustment.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			char itemType = '\0';
		
			ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();
			LOGGER.logDebug("paymentPlanHeader: " + paymentPlanHeader);
			LOGGER.logDebug("paymentPlanHeader: "
					+ paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));
			loanItemsRequest.setBank(paymentPlanHeader
					.get(PaymentPlanHeader.IDREQUESTED) == null ? null : String
					.valueOf(paymentPlanHeader
							.get(PaymentPlanHeader.IDREQUESTED)));// banco-rot_operacion

			loanItemsRequest.setConcept(category.get(Category.CONCEPT));// codigo_rubro

			loanItemsRequest.setPriority(category.get(Category.PRIORITY));// prioridad

			LOGGER.logDebug("category.get(Category.PROVISIONED)"
					+ category.get(Category.PROVISIONED));
			loanItemsRequest.setProvisioned(category.get(Category.PROVISIONED));// provisiona

			if (category.get(Category.SIGN) != null
					&& !"".equals(category.get(Category.SIGN).trim())
					&& category.get(Category.SIGN).trim().length() > 0) {
				loanItemsRequest.setSign(category.get(Category.SIGN).trim()
						.charAt(0)); // signo
			} else {
				loanItemsRequest.setSign('\0');
			}
			LOGGER.logDebug("category.get(Category.CONCEPTTYPE)"
					+ category.get(Category.CONCEPTTYPE));

			// Max value
			loanItemsRequest.setMaxValue(category.get(Category.MAXIMUN));
			// MIn value
			loanItemsRequest.setMinValue(category.get(Category.MINIMUM));
			// tipo de operaion o tipo de producto
			loanItemsRequest.setOperationType(category
					.get(Category.PRODUCTTYPE));
			// CPN. Campo no usado
			/*
			 * if(financiado!=null){
			 * loanItemsRequest.setFunded(financiado.charAt(0));// financiado
			 * }else{ loanItemsRequest.setFunded("".charAt(0)); }
			 */
			// FACTOR
			loanItemsRequest.setFactor(category.get(Category.SPREAD));
			// FORMA DE PAGO
			if (category.get(Category.METHODOFPAYMENT) != null
					&& !"".equals(category.get(Category.METHODOFPAYMENT).trim())
					&& category.get(Category.METHODOFPAYMENT).trim().length() > 0) {
				loanItemsRequest.setMethodPayment(category.get(
						Category.METHODOFPAYMENT).charAt(0));
			} else {
				loanItemsRequest.setMethodPayment('\0');
			}
			LOGGER.logDebug("category.get(Category.ISNEW)"
					+ category.get(Category.ISNEW));
			if (category.get(Category.ISNEW)) {
				LOGGER.logDebug("category.get(Category.REFERENCE)"
						+ category.get(Category.REFERENCE));
				LOGGER.logDebug("category.get(Category.ITEMTYPE) "
						+ category.get(Category.ITEMTYPE));
				if (category.get(Category.ITEMTYPE) != null
						&& !"".equals(category.get(Category.ITEMTYPE).trim())
						&& category.get(Category.ITEMTYPE).trim().length() > 0) {
					itemType = category.get(Category.ITEMTYPE).trim().charAt(0); // signo
				} else {
					itemType = '\0';
				}

				loanItemsRequest.setReferential(category
						.get(Category.REFERENCE));
			} else {
				if (category.get(Category.CONCEPTTYPE) != null) {
					itemType = category.get(Category.CONCEPTTYPE).charAt(0); // signo
				} else {
					itemType = '\0';
				}

				LOGGER.logDebug("category.get(Category.AMOUNTOAPPLY)"
						+ category.get(Category.AMOUNTOAPPLY));
				loanItemsRequest.setReferential(category
						.get(Category.AMOUNTOAPPLY));
			}

			LOGGER.logDebug("category.get(Category.VALUE)"
					+ category.get(Category.VALUE));
			LOGGER.logDebug("itemType" + itemType);
			loanItemsRequest.setItemType(itemType);
			if ('I' == itemType || 'M' == itemType || 'O' == itemType
					|| 'B' == itemType) {
				// valor es la suma de la tasa
				LOGGER.logDebug("----------> 1");
				loanItemsRequest.setPercentage(category.get(Category.VALUE));
			} else {
				// valor es la suma de la tasa
				LOGGER.logDebug("----------> 2");
				loanItemsRequest.setValue(category.get(Category.VALUE));
			}
			loanItemsRequest.setPaymentArrears(category
					.get(Category.PAYMENTARREARS) == null ? '\0' : category
					.get(Category.PAYMENTARREARS));
			loanItemsRequest.setCalculatedBase(category
					.get(Category.CALCULATEDBASE));
			// loanItemsRequest.setIsHeritage(category.get(Category.ISHERITAGE));

			// Reajuste
			LOGGER.logDebug("categoryReadjusment.get(CategoryReadjustment.SIGN)"
					+ categoryReadjusment.get(CategoryReadjustment.SIGN));
			loanItemsRequest.setReadjustmentSign(categoryReadjusment
					.get(CategoryReadjustment.SIGN) == null
					|| "".equals(categoryReadjusment
							.get(CategoryReadjustment.SIGN)) ? '\0'
					: categoryReadjusment.get(CategoryReadjustment.SIGN).trim()
							.charAt(0));
			LOGGER.logDebug("categoryReadjusment.get(CategoryReadjustment.SPREAD)"
					+ categoryReadjusment.get(CategoryReadjustment.SPREAD));
			loanItemsRequest.setReadjustmentFactor(categoryReadjusment
					.get(CategoryReadjustment.SPREAD));
			LOGGER.logDebug("categoryReadjusment.get(CategoryReadjustment.AMOUNTTOAPPLY)"
					+ categoryReadjusment
							.get(CategoryReadjustment.AMOUNTTOAPPLY));
			loanItemsRequest.setReadjustmentReferential(categoryReadjusment
					.get(CategoryReadjustment.AMOUNTTOAPPLY));

			itemsManagement.saveUpdateItem(loanItemsRequest,
					arg1, category.get(Category.ISNEW)
							.booleanValue());
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CREATE_ITEM, e, arg1, LOGGER);
		}

	}
}
