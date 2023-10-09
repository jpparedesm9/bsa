package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.Map;

import com.cobiscorp.cobis.clcol.model.CollectiveAdvisor;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.ProcessAsesorManager;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ProccessAsesorEntity extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(ProccessAsesorEntity.class);
	private ICTSServiceIntegration serviceIntegration;

	public ProccessAsesorEntity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		
		LOGGER.logDebug("Start executeCommand in ProcessAsesorEntities");
		Map<String, Object> filter = args.getParameters().getCustomParameters();
		DataEntityList asesorEntities = arg0.getEntityList(CollectiveAdvisor.ENTITY_NAME);
		Integer position = filter.get("position") == null ? null : Integer.parseInt(String.valueOf(filter.get("position")));
		if (position != null) {

			AdvisorExternalRequest asesorExterno=new AdvisorExternalRequest();

			DataEntity entity = asesorEntities.get(position);
			asesorExterno.setIdSecuencial(position);
			asesorExterno.setCollective(entity.get(CollectiveAdvisor.COLLECTIVE));
			asesorExterno.setCustomerName(entity.get(CollectiveAdvisor.CUSTOMERNAME));
			asesorExterno.setCustomerId(Integer.valueOf(entity.get(CollectiveAdvisor.CUSTOMERID)));
			asesorExterno.setCustomerAddress(entity.get(CollectiveAdvisor.CUSTOMERADDRESS));
			asesorExterno.setCustomerCell(entity.get(CollectiveAdvisor.CUSTOMERCELL));
			asesorExterno.setEmail(entity.get(CollectiveAdvisor.CUSTOMERMAIL));
			asesorExterno.setAsesorExterno(entity.get(CollectiveAdvisor.EXTERNALADVISOR));
			ProcessAsesorManager processAsesorManager = new ProcessAsesorManager(serviceIntegration);
			Map<String, Object> outputs = processAsesorManager.processAsesorEntity(asesorExterno, args);
			LOGGER.logDebug("antes de Ingresar a los mensaje");
			if (outputs != null && outputs.size() > 0) {
				LOGGER.logDebug("Ingresa a los mensaje");
				
				LOGGER.logDebug("mensaje"+String.valueOf(outputs.get("@o_msg")));
				entity.set(CollectiveAdvisor.OBSERVATIONS, outputs.get("@o_msg") == null ? null : String.valueOf(outputs.get("@o_msg")));
				asesorEntities.set(position, entity);
				arg0.setEntityList(CollectiveAdvisor.ENTITY_NAME, asesorEntities);
			}
			
		}
		else {
			args.getMessageManager().showErrorMsg("Error al procesar los datos de la grilla.");
		}
		
	}

}
