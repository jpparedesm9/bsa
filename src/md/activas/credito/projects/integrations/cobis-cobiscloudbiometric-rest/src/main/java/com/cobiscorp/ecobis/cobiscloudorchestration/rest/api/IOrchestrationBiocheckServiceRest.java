package com.cobiscorp.ecobis.cobiscloudorchestration.rest.api;

import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto.Biocheck;

public interface IOrchestrationBiocheckServiceRest {

	
	/**
	 * Guarda la informacion de biocheck
	 * */
	 Response save(int customerId,Biocheck data);
	 
	 /**
	  * Consulta la informacion de Biocheck
	  * */
	 Response query(int customerId);
	 
	 /**
	  * Interpreta respuestas de Biocheck
	  * */
	 Response error(int customerId, String errorCode, int tramite);
}
