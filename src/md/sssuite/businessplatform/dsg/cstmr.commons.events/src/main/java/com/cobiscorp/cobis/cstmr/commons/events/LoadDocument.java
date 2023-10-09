package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.DocumentTypeRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.DocumentTypeResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.customer.commons.prospect.services.DocumentManager;

public class LoadDocument {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadDocument.class);

	public List<ItemDTO> loadDocumentCatalogByPersonType(char personType, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		List<ItemDTO> items = new ArrayList<ItemDTO>();
		try {

			DocumentTypeRequest documentTypeRequest = new DocumentTypeRequest();
			documentTypeRequest.setOperation(Parameter.OPERATION_HELP);
			documentTypeRequest.setPersonType(personType);
			DocumentManager documentManager = new DocumentManager(serviceIntegration);
			DocumentTypeResponse[] documentTypeList = documentManager.searchDocumentTypes(documentTypeRequest, arg1);
			for (DocumentTypeResponse item : documentTypeList) {
				LOGGER.logDebug("-->3");
				ItemDTO itemDTO = new ItemDTO();
				LOGGER.logDebug("item [id:" + item.getIdType() + ", value: " + item.getIdTypeDescription() + "]");
				itemDTO.setCode(item.getIdType());
				itemDTO.setValue(item.getIdTypeDescription());
				items.add(itemDTO);
			}
			arg1.setSuccess(true);
		} catch (BusinessException bex) {
			LOGGER.logDebug("Error en la Clase LoadDocument "+ bex);
			arg1.setSuccess(false);
			arg1.getMessageManager().showErrorMsg("Error en la Clase LoadDocument"+bex.getMessage());
			
		} catch (Exception ex) {
			LOGGER.logDebug("Error en la Clase LoadDocument "+ ex);
			arg1.setSuccess(false);
			arg1.getMessageManager().showErrorMsg("Error en la Clase LoadDocument"+ex.getMessage());
		}
		return items;

	}
}
