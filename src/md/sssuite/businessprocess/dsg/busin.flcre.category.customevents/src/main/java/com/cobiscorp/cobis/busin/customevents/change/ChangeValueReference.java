package com.cobiscorp.cobis.busin.customevents.change;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeValueReference extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(ChangeValueReference.class);

	public ChangeValueReference(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		// String taskId = arg1.getParameters().getTaskId();
		try{
			DataEntity category = entities.getEntity(Category.ENTITY_NAME);
			// DataEntity originalHeader =
			// entities.getEntity(OriginalHeader.ENTITY_NAME);
			ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();

			loanItemsRequest.setType(category.get(Category.AMOUNTOAPPLY));// Valor
																			// Referencial
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("2...................TIPO VALOR REFERENCIAL....................."
						+ loanItemsRequest.getType());

			loanItemsRequest.setCodeSector(category.get(Category.SECTOR)); // Sector
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("3...................CODIGO SECTOR.........................................."
						+ loanItemsRequest.getCodeSector());

			loanItemsRequest.setCodeSegment(category.get(Category.SEGMENT)); // Segmento
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("4...................CODIGO SEGMENTO.........................................."
						+ loanItemsRequest.getCodeSegment());

			loanItemsRequest.setBank(category.get(Category.BANK));// i_banco
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("5...................OP BANCO.........................................."
						+ loanItemsRequest.getBank());

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue("inReadLoanItemsRequest", loanItemsRequest);

			ServiceResponse serviceResponseItem = execute(getServiceIntegration(),
					LOGGER, "Loan.SearchLoanItems.GetLoanItemsAllDetails",
					serviceRequestTO);

			if (serviceResponseItem.isResult()) {
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponseItem
						.getData();
				ReadLoanItemsResponse itemResponse = (ReadLoanItemsResponse) serviceItemsResponseTO
						.getValue("returnReadLoanItemsResponse");
				if (LOGGER.isDebugEnabled())
					LOGGER.logInfo("Response: Referencia ====> "
							+ itemResponse.getReference() + " - "
							+ itemResponse.getReferenceDescription());

				category.set(Category.REFERENCEDESCRIPTION,
						itemResponse.getReferenceDescription());
				category.set(Category.REFERENCEAMOUNT, itemResponse.getValue());
				category.set(Category.SPREAD, itemResponse.getFactor());
				category.set(Category.SIGN, itemResponse.getSign());
				category.set(Category.MINIMUM, itemResponse.getMinValue());
				category.set(Category.MAXIMUN, itemResponse.getMaxValue());
				category.set(Category.VALUE, itemResponse.getMaxValue());
				category.set(Category.MAXRATE, itemResponse.getMaximunRate());
				if (LOGGER.isDebugEnabled())
					LOGGER.logInfo("Response: MaxRate ====> "
							+ itemResponse.getMaximunRate());

				// category.set(Category.CONCEPTTYPE,
				// itemResponse.getConceptType());//para saber si es valor o factor

			} else {
				MessageManagement.show(serviceResponseItem, arg1,
						new BehaviorOption(true));
				category.set(Category.REFERENCEDESCRIPTION, null);
				category.set(Category.REFERENCEAMOUNT, null);
				category.set(Category.SPREAD, null);
				category.set(Category.SIGN, null);
				category.set(Category.MINIMUM, null);
				category.set(Category.MAXIMUN, null);
				category.set(Category.VALUE, null);
				category.set(Category.MAXRATE, null);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_REFERENCE, e, arg1, LOGGER);
		} 
		
		

	}// Fin evento change

}
