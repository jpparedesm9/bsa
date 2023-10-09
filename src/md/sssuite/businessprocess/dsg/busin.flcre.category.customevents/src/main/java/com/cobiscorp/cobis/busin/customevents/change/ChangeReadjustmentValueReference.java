package com.cobiscorp.cobis.busin.customevents.change;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.CategoryReadjustment;
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

public class ChangeReadjustmentValueReference extends BaseEvent implements
		IChangedEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(ChangeReadjustmentValueReference.class);

	public ChangeReadjustmentValueReference(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		// String taskId = arg1.getParameters().getTaskId();
		try{
			DataEntity category = entities.getEntity(Category.ENTITY_NAME);
			DataEntity categoryReadjustment = entities
					.getEntity(CategoryReadjustment.ENTITY_NAME);

			// DataEntity originalHeader =
			// entities.getEntity(OriginalHeader.ENTITY_NAME);
			ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();

			loanItemsRequest.setType(categoryReadjustment
					.get(CategoryReadjustment.AMOUNTTOAPPLY));// Valor Referencial
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
					LOGGER.logInfo("Response: ...................Descripción de Referencia.........................................."
							+ itemResponse.getReferenceDescription());

				categoryReadjustment.set(CategoryReadjustment.REFERENCEDESCRIPTION,
						itemResponse.getReferenceDescription());
				categoryReadjustment.set(CategoryReadjustment.REFERENCEAMOUNT,
						itemResponse.getValue());
				categoryReadjustment.set(CategoryReadjustment.SPREAD,
						itemResponse.getFactor());
				categoryReadjustment.set(CategoryReadjustment.SIGN,
						itemResponse.getSign());
				categoryReadjustment.set(CategoryReadjustment.MINIMUM,
						itemResponse.getMinValue());
				categoryReadjustment.set(CategoryReadjustment.MAXIMUN,
						itemResponse.getMaxValue());
				categoryReadjustment.set(CategoryReadjustment.VALUE,
						itemResponse.getMaxValue());
				// category.set(Category.CONCEPTTYPE,
				// itemResponse.getConceptType());//para saber si es valor o factor

			} else {
				MessageManagement.show(serviceResponseItem, arg1,
						new BehaviorOption(true));
				categoryReadjustment.set(CategoryReadjustment.REFERENCEDESCRIPTION,
						null);
				categoryReadjustment
						.set(CategoryReadjustment.REFERENCEAMOUNT, null);
				categoryReadjustment.set(CategoryReadjustment.SPREAD, null);
				categoryReadjustment.set(CategoryReadjustment.SIGN, null);
				categoryReadjustment.set(CategoryReadjustment.MINIMUM, null);
				categoryReadjustment.set(CategoryReadjustment.MAXIMUN, null);
				categoryReadjustment.set(CategoryReadjustment.VALUE, null);
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_READJUSTMENT, e, arg1, LOGGER);
		} 
		
		
		

	}// Fin evento change

}
