
/**
 * Archivo: WebTerminalValidation.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.math.BigDecimal;
import java.sql.Types;
import java.util.ResourceBundle;
import java.util.Locale;
import com.cobiscorp.cobisv.commons.catalog.CobisCatalogRB;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICOBISSequentialService;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.ecobis.cobisv.dal.api.dao.IDAO1;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;

import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationData;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationForService;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationRequest;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceStatus;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.GetStatusRequest;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.MacsToValidate;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.Request;
//include imports with key: WebTerminalValidation.imports


public class WebTerminalValidationSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.bsl.IWebTerminalValidation {
	private static ILogger logger = LogFactory.getLogger(WebTerminalValidationSERVImpl.class);
  private static final ILogger LOGGER = LogFactory.getLogger(WebTerminalValidationSERVImpl.class);


	//include body with key: WebTerminalValidation.body
	





	
	public 	 Boolean  validateTerminal (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.MacsToValidate aMacsToValidate
		){

		//to include in code order use key: cobisclouddevicemanagement.WebTerminalValidationImpl.validateTerminal
			Request aRequest = new Request();
  Map aSpRequest = new HashMap();
  aRequest.setInfo(new HashMap());
  aRequest.getInfo().put("aParameter", aSpRequest);
  aSpRequest.put("mac", aMacsToValidate.getMac());
  aSpRequest.put("mac1", aMacsToValidate.getMac1());
	aSpRequest.put("mac2", aMacsToValidate.getMac2());
  String operationInSpToFindMacs = "Q";
  aSpRequest.put("operacion", operationInSpToFindMacs);
      
  SpWebTerminalStatusUtil.executeWebTerminalStatus(aRequest, getSpOrchestrator());

   List<List<Map<String, Object>>> webTerminalStatusResults = 
          (List<List<Map<String, Object>>>)aRequest.getInfo().get("aResultWebTerminalStatus");
  if(webTerminalStatusResults.isEmpty() && webTerminalStatusResults.get(0).isEmpty()) {
  	throw new com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException("sp sp_terminal con opcion Q debe devolver un valor");
  }
      
  Map webTerminalStatusRow = webTerminalStatusResults.get(0).get(0);
  Integer timesFound = (Integer)webTerminalStatusRow.get("times_found");
  if(LOGGER.isDebugEnabled()) {
  	LOGGER.logDebug("webTerminalStatusRow:" + webTerminalStatusRow);
  }
	if (timesFound > 0) {
		return true;
	} else {
		return false;
	}

		
	}


	

	
}
