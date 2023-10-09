package com.cobiscorp.cobis.busin.view.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataTypeOperationResponseList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.VariableData;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_OFICANSSEW2603_POCT250  extends BaseEvent implements IChangedEvent{
	private static final ILogger LOGGER = LogFactory
			.getLogger(ChangeVA_OFICANSSEW2603_POCT250.class);

	public ChangeVA_OFICANSSEW2603_POCT250(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		try{
			String taskId = arg1.getParameters().getTaskId();
			//T_FLCRE_17_CAAIL82(officialactivityallocation) || T_FLCRE_35_AITIV39(legalanalysisactivity)
			if(taskId.equals("T_FLCRE_17_CAAIL82") || taskId.equals("T_FLCRE_35_AITIV39")){
				this.changedTypeOperationCommon(entities, arg1);
			}else if (taskId.equals("T_FLCRE_04_INLYS21")){ //applicationanalysis
				this.changedTypeOperation(entities, arg1);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CHANGE_LEGAL_250, e, arg1, LOGGER);
		}
		

	}//Fin evento change

	private void changedTypeOperationCommon(DynamicRequest entities, IChangedEventArgs arg1){
		DataEntity officerAnalysis = entities
				.getEntity(OfficerAnalysis.ENTITY_NAME);

		DataEntity originalHeader = entities
				.getEntity(OriginalHeader.ENTITY_NAME);


		if(officerAnalysis.get(OfficerAnalysis.PRODUCTTYPE)!=null){

			DataEntityList variableDataEntity = new DataEntityList();


			DataTypeOperationRequest dataTypeOperation = new DataTypeOperationRequest();
			DataTypeOperationResponseList dataTypeOperationResponseList = new DataTypeOperationResponseList();
			//CommonParams commonParams= new CommonParams(); 
			//TypeOperationInformation typeOperationInformation = new TypeOperationInformation(); 
			//TypeOperationResponse TypeOperationResponse = new TypeOperationResponse();


			dataTypeOperation.setOperationType(officerAnalysis.get(OfficerAnalysis.PRODUCTTYPE));
			dataTypeOperation.setCobisProductMnemonic("CEX");


			ServiceRequestTO serviceRequestVariableDataTO = null;
			ServiceResponse serviceVariableDataResponse = null;
			serviceRequestVariableDataTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseVariableDataTO = null;

			//serviceRequestVariableDataTO.getData().put(InitDataOfficial.INDATATYPEOPERATION, dataTypeOperation);
			serviceRequestVariableDataTO.getData().put(RequestName.INDATATYPEOPERATION,
					dataTypeOperation);
			//serviceRequestVariableDataTO.getData().put(InitDataOfficial.OUTDATATYPEOPERATION,	dataTypeOperationResponseList);
			serviceRequestVariableDataTO.getData().put(ReturnName.OUTDATATYPEOPERATION,
					dataTypeOperationResponseList);
			LOGGER.logInfo("Antes del servicio SERVICESEARCHTYPEOPERATION");
			/*serviceVariableDataResponse = execute(getServiceIntegration(),
					logger, InitDataOfficial.SERVICESEARCHTYPEOPERATION,
					serviceRequestVariableDataTO);*/			
			serviceVariableDataResponse = execute(getServiceIntegration(),
					LOGGER, ServiceId.SERVICESEARCHTYPEOPERATION,
					serviceRequestVariableDataTO);
			if (serviceVariableDataResponse.isResult()) {
				serviceResponseVariableDataTO = (ServiceResponseTO) serviceVariableDataResponse
						.getData();

				/*DataTypeOperationResponse[] typeOperationDatas = (DataTypeOperationResponse[]) serviceResponseVariableDataTO
						.getValue(InitDataOfficial.RETURNTYPEOPERATIONDATA);*/
				DataTypeOperationResponse[] typeOperationDatas = (DataTypeOperationResponse[]) serviceResponseVariableDataTO
						.getValue(ReturnName.RETURNTYPEOPERATIONDATA);
				LOGGER.logInfo("despues del servicio SERVICESEARCHTYPEOPERATION");
				for (DataTypeOperationResponse typeOperationData : typeOperationDatas) {
					DataEntity eVariableData = new DataEntity();
					eVariableData.set(VariableData.VALUE, typeOperationData.getValueData());  
					eVariableData.set(VariableData.TYPE, typeOperationData.getDataType().toString());
					eVariableData.set(VariableData.MANDATORY, typeOperationData.getMandatory().toString());
					eVariableData.set(VariableData.FIELD, typeOperationData.getDataDescription());
					//eVariableData.set(VariableData.IDFIELD, typeOperationData.getDataCode());
					variableDataEntity.add(eVariableData);

				}
				entities.setEntityList(VariableData.ENTITY_NAME,variableDataEntity);
			} 

		}
	}
	
	private void changedTypeOperation(DynamicRequest entities, IChangedEventArgs arg1){
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso - changed - applicationanalysis.ChangeVA_OFICANSSEW2603_POCT250");

		DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		int codigoTramite = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		if (officerAnalysis.get(OfficerAnalysis.PRODUCTTYPE) != null) {
			OperationManagement operationMngt = new OperationManagement(super.getServiceIntegration());
			String operationType = officerAnalysis.get(OfficerAnalysis.PRODUCTTYPE);
			DataEntityList variableDataEntity = operationMngt.searchTypeOperationAndValueMapping(operationType, "CEX", codigoTramite, entities, arg1, new BehaviorOption(false, false));
			if (variableDataEntity != null)
				entities.setEntityList(VariableData.ENTITY_NAME, variableDataEntity);
		}

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida - changed - applicationanalysis.ChangeVA_OFICANSSEW2603_POCT250");
	}
}
