package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationPersonResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class NaturalProspectRelationManager extends BaseEvent {

	public NaturalProspectRelationManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void createProspectRelation(RelationRequest relationRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.RELATION_REQUEST, relationRequest, ServiceId.INSERT_NATURAL_PROSPECT_RELATION, arg1);
	}

	public RelationResponse[] searchRelation(RelationRequest relationRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		RelationResponse[] relations = callService.callServiceWithReturnArray(RequestName.RELATION_REQUEST, relationRequest, ServiceId.SEARCH_RELATION, ReturnName.RELATION_DATA,
				arg1);
		return relations == null ? new RelationResponse[0] : relations;
	}

	public RelationPersonResponse[] searchRelationByPerson(RelationRequest relationRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		RelationPersonResponse[] relations = callService.callServiceWithReturnArray(RequestName.RELATION_REQUEST, relationRequest, ServiceId.SEARCH_RELATION_BY_PERSON,
				ReturnName.RELATION_PERSON_RESPONSE, arg1);
		return relations == null ? new RelationPersonResponse[0] : relations;
	}

	public void deleteProspectRelation(RelationRequest relationRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.RELATION_REQUEST, relationRequest, ServiceId.DELETE_RELATION_BY_PERSON, arg1);
	}
}
