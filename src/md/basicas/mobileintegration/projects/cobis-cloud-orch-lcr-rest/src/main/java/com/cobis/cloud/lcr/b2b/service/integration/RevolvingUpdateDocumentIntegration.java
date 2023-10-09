package com.cobis.cloud.lcr.b2b.service.integration;

import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.Requirement;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;

import com.cobis.cloud.lcr.b2b.service.common.RestServiceBase;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;

public class RevolvingUpdateDocumentIntegration extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(RevolvingUpdateDocumentIntegration.class);
	private final String className = "[RevolvingUpdateDocumentIntegration] ";

	public RevolvingUpdateDocumentIntegration(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	public void updateSaveDocument(int instanceActivity, int code, String name, String typeDocument, String category) {

		logger.logDebug("Se ingresa al metodo " + className + " de la clase updateSaveDocument");

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		String observation = "OK"; // La observacion que se va a guardar en la tabla al subir el documento
		int excepcionable = 0; // Se ingresa por default el valor 0
		String dateEntry; // La fecha que ingresa al sp es un string.
		String nameDocument; // Variable para el nombre completo del documento

		// obentencion de nombre

		nameDocument = String.valueOf(instanceActivity) + "_" + category + "_" + name + '.' + typeDocument;
		logger.logDebug("nombre a ingresar: " + nameDocument);
		// obtencion de la fehca y hora del sistema

		Date sistDate = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/YYYY HH:mm:ss");
		dateEntry = formatter.format(sistDate);
		logger.logDebug("Fecha a ingresar: " + dateEntry);

		TaskDTO taskDto = new TaskDTO();
		Requirement requierement = new Requirement();

		taskDto.setTaskInstanceIdentifier(String.valueOf(instanceActivity));
		requierement.setId(String.valueOf(code));
		requierement.setNameDocument(nameDocument);
		requierement.setObservation(observation);
		requierement.setDateRegister(dateEntry);
		requierement.setExceptionRequirement(excepcionable);
		serviceRequestTO.addValue("inTaskDTO", taskDto);
		serviceRequestTO.addValue("inRequirement", requierement);

		try {
			logger.logDebug("ANTES DE LLAMAR AL SERVICIO");
			serviceRequestTO.setServiceId("HTM.API.HumanTask.UpdateRequirementByProcess");
			serviceResponse = execute("HTM.API.HumanTask.UpdateRequirementByProcess", serviceRequestTO);
			logger.logDebug("DESPUES DE LLAMAR AL SERVICIO");

		} catch (IntegrationException e) {
			logger.logError("Error al guardar la informacion", e);

		}

	}

}
