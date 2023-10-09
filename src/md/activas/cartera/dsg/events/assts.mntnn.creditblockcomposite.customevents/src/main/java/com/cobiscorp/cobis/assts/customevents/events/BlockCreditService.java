package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Block;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.BlockCreditRequest;
import cobiscorp.ecobis.individualloan.dto.BlockCreditResponse;

public class BlockCreditService extends BaseEvent{
	
	private static final ILogger logger = LogFactory
			.getLogger(BlockCreditService.class);
	
	public BlockCreditService(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
    protected void getBlocks(DynamicRequest entities,ICommonEventArgs args) {
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa a getBlocks>>");
		}
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity block = entities.getEntity(Block.ENTITY_NAME);
		
		String loanBankId = loan.get(Loan.LOANBANKID);
		Integer customerId = loan.get(Loan.CLIENTID);
			
		ServiceResponse serviceResponse = this.executeBlockService(loanBankId, customerId, null, Parameter.OPERATIONC);
						
		if (serviceResponse.isResult()) {	
				
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("serviceResponseTO.isSuccess()>>>"+serviceResponseTO.isSuccess());
				}
				
				BlockCreditResponse[] blockCreditResponseList = (BlockCreditResponse[]) serviceResponseTO
						.getValue("returnBlockCreditResponse");
				
				BlockCreditResponse blockCreditResponse = blockCreditResponseList[0];
				
				DataEntity blockDetail = new DataEntity();
					
				block.set(Block.CUSTOMERID, blockCreditResponse.getCustomerId());
					
				block.set(Block.CUSTOMERNAME, blockCreditResponse.getCustomerName());
				block.set(Block.DISBURSEMENTDATE, GeneralFunction.convertCalendarToDate(blockCreditResponse.getDisbursementDate()));
				block.set(Block.EXPIRATIONDATE, GeneralFunction.convertCalendarToDate(blockCreditResponse.getExpirationDate()));
				block.set(Block.REGISTERCODE, blockCreditResponse.getRegistrationCode());
				block.set(Block.QUOTA, blockCreditResponse.getQuota());
				block.set(Block.AVAILABLE, blockCreditResponse.getAvailable());
				block.set(Block.BLOCKED, blockCreditResponse.getBlocked());
				block.set(Block.USER, blockCreditResponse.getUser());
				block.set(Block.DATELASTUPDATE, GeneralFunction.convertCalendarToDate(blockCreditResponse.getDateLastUpdate()));
				block.set(Block.ENABLEDAUT, blockCreditResponse.getViewAuth());
					
			}
		}else {
			block.set(Block.ACTIVE, "N");
			((ICommonEventArgs) args).getMessageManager().showErrorMsg(GeneralFunction.getSpsMessages(serviceResponse.getMessages()));
		}
		
	}
	
	protected ServiceResponse executeBlockService(String loanBankId, Integer customerId, String blocked, String operation) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("BlockCreditService executeBlockService >>>");
		}
		
		BlockCreditRequest blockCreditRequest = new BlockCreditRequest();
		blockCreditRequest.setBankId(loanBankId);
		blockCreditRequest.setOperation(Parameter.OPERATIONC);
		blockCreditRequest.setCustomerId(customerId);
		blockCreditRequest.setBlocked(blocked);
		blockCreditRequest.setOperation(operation);
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		serviceRequestTO.addValue("inBlockCreditRequest", blockCreditRequest);
		
		serviceResponse = this.execute(logger, "IndividualLoan.BlockManagement.BlockCredit", serviceRequestTO);
				
		return serviceResponse;
	}
	
	protected ServiceResponse authorizeBlocking(String loanBankId) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("BlockCreditService authorizeBlocking >>>");
		}
		
		BlockCreditRequest blockCreditRequest = new BlockCreditRequest();
		blockCreditRequest.setBankId(loanBankId);
		blockCreditRequest.setOperation("A");
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		serviceRequestTO.addValue("inBlockCreditRequest", blockCreditRequest);
		
		serviceResponse = this.execute(logger, "IndividualLoan.BlockManagement.BlockCredit", serviceRequestTO);
				
		return serviceResponse;
	}

}
