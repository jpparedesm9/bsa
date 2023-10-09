package com.cobiscorp.cobis.loans.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.events.CreateGroup;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.OfficerManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataGroupComposite extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(CreateGroup.class);

	public InitDataGroupComposite(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		LOGGER.logDebug("-----> InitDataGroupComposite - cambios en catch");
		try {
			DataEntity groupEntity = entities.getEntity(Group.ENTITY_NAME);
			LOGGER.logDebug("-----> usuario " + groupEntity.get(Group.USERNAME));

			OfficerManagement officeMngt = new OfficerManagement(getServiceIntegration());
			OfficerResponse officeResponseDTO;
			officeResponseDTO = officeMngt.getOfficerByLogin(groupEntity.get(Group.USERNAME), args);
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "ESTVIG", "CLI", args, new BehaviorOption(false, false));
			String paramStateVig = "V";	

			if (officeResponseDTO != null && officeResponseDTO.getOfficerId() != null) {
				groupEntity.set(Group.USERNAME, officeResponseDTO.getOfficerName());
				groupEntity.set(Group.OFFICER, officeResponseDTO.getOfficerId());
				entities.setEntity(Group.ENTITY_NAME, groupEntity);
			}

			if (parameterDto != null) {
				if (parameterDto.getParameterValue() != null) {
					paramStateVig = parameterDto.getParameterValue().trim();
				}
			}			
			groupEntity.set(Group.STATE, paramStateVig);
			
		} catch (Exception e) {
			
			ExceptionUtils.showError(ExceptionMessage.Clients.INIT_DATA_GROUP_COMPOSITE, e, args, LOGGER);
		}
	}
}
