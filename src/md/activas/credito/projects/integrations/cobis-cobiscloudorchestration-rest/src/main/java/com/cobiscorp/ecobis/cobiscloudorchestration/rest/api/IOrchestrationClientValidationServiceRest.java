package com.cobiscorp.ecobis.cobiscloudorchestration.rest.api;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

public interface IOrchestrationClientValidationServiceRest{
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validate (
  com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest
  );
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateBuroClientGroup (
  com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest
  );
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateBuroClientGroupRule (
  com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aBuroClientRequest
  );
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateBuroClientIndividualRule (
  com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aValidationProspectServiceRequest
  );

    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateBuro (
            com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest, @Context HttpServletRequest httpRequest
    );

    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateSantander (
            com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest
    );
    
    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  validateSantanderWithoutValidation (
            com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest
    );

	com.cobiscorp.cobis.web.services.commons.model.ServiceResponse clientEvaluation(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest, @Context HttpServletRequest httpRequest);
}
