
/**
 * Archivo: DeviceRegistration.java
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
//include imports with key: DeviceRegistration.imports


public class DeviceRegistrationSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.bsl.IDeviceRegistration {
	private static ILogger logger = LogFactory.getLogger(DeviceRegistrationSERVImpl.class);
  private static final ILogger LOGGER = LogFactory.getLogger(DeviceRegistrationSERVImpl.class);


	//include body with key: DeviceRegistration.body
	





	
	public 	 com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceStatus  getStatus (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.GetStatusRequest aStatusRequest
		){

		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.getStatus
		      DeviceIdentification deviceIdentification = aStatusRequest.getDeviceIdentification();
      Request aRequest = new Request();
      Map aSpRequest = new HashMap();
      aRequest.setInfo(new HashMap());
      aRequest.getInfo().put("aParameter", aSpRequest);
      aSpRequest.put("deviceId", deviceIdentification.getDeviceId());
      aSpRequest.put("login", deviceIdentification.getLogin());
      aSpRequest.put("firstTime", deviceIdentification.getFirstTime());
      aSpRequest.put("operation", "M");
      
      SpSpDeviceUtil.executeSpDevice(aRequest, getSpOrchestrator());

      List<List<Map<String, Object>>> deviceStatusResults = 
          (List<List<Map<String, Object>>>)aRequest.getInfo().get("aResultSpDevice");
      if(deviceStatusResults.isEmpty() && deviceStatusResults.get(0).isEmpty()) {
        return null;
      }
      
      Map deviceStatusRow = deviceStatusResults.get(0).get(0);
      String deviceStatusStr = (String)deviceStatusRow.get("de_status");
      if(LOGGER.isDebugEnabled()) {
        LOGGER.logDebug("customerDetailsRow:" + deviceStatusRow);

      }

      DeviceStatus deviceStatus = new DeviceStatus();
      com.cobiscorp.ecobis.cobiscloudsecurity.util.DeviceStatus statusEnum 
        = com.cobiscorp.ecobis.cobiscloudsecurity.util.DeviceStatusUtil.getDeviceStatus(deviceStatusStr);
      
      deviceStatus.setProceedToCompleteRegistration(statusEnum.isProceedToCompleteRegistration());
      deviceStatus.setProceedToClearData(statusEnum.isProceedToClearData());
      deviceStatus.setLock(statusEnum.isLock());
      deviceStatus.setStatus(statusEnum.getStatus());


      if(aStatusRequest.getReturnName()) {
        Map officerNameRow = deviceStatusResults.get(1).get(0);
        deviceStatus.setOfficerName((String)officerNameRow.get("fu_nombre"));
      }

      return deviceStatus;

		
	}


	
	public 	 Boolean  isRegistered (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification
		){

		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.isRegistered
		
  return false;
		
	}


	
	public 	 Boolean  register (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationForService aDeviceRegistrationForService
		){

		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.register
		  Request aRequest = new Request();
  Map aSpRequest = new HashMap();
  aRequest.setInfo(new HashMap());
  aRequest.getInfo().put("aParameter", aSpRequest);
  aSpRequest.put("deviceId", aDeviceRegistrationForService.getDeviceIdentification().getDeviceId());
  aSpRequest.put("login", aDeviceRegistrationForService.getDeviceIdentification().getLogin());
  aSpRequest.put("operation", "R");
  aSpRequest.put("alias", aDeviceRegistrationForService.getDeviceRegistrationData().getAlias());
  
  SpSpDeviceUtil.executeSpDevice(aRequest, getSpOrchestrator());
  
  Integer statusCode = (Integer)aRequest.getInfo().get("statusCode");
  return (statusCode == 0);  
		
	}


	
	public 	 Boolean  reportAsLost (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification
		){

		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.reportAsLost
		  Request aRequest = new Request();
  Map aSpRequest = new HashMap();
  aRequest.setInfo(new HashMap());
  aRequest.getInfo().put("aParameter", aSpRequest);
  aSpRequest.put("deviceId", aDeviceIdentification.getDeviceId());
  aSpRequest.put("status", "L");
  aSpRequest.put("operation", "L");
  SpSpDeviceUtil.executeSpDevice(aRequest, getSpOrchestrator());
  Integer statusCode = (Integer)aRequest.getInfo().get("statusCode");
  return (statusCode == 0);  

		
	}


	
	public 	 Boolean  unlock (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification
		){

Boolean wResponse = null;

 		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.unlock
		
		return wResponse;
		//wResponse.setStatusCode(0);
				
	}


	
	public 	 Boolean  unsuscribe (
		com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification
		){

		//to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationImpl.unsuscribe
		  Request aRequest = new Request();
  Map aSpRequest = new HashMap();
  aRequest.setInfo(new HashMap());
  aRequest.getInfo().put("aParameter", aSpRequest);
  aSpRequest.put("deviceId", aDeviceIdentification.getDeviceId());
  aSpRequest.put("status", "U");
  aSpRequest.put("operation", "L");
  SpSpDeviceUtil.executeSpDevice(aRequest, getSpOrchestrator());
  Integer statusCode = (Integer)aRequest.getInfo().get("statusCode");
  return (statusCode == 0);  
		
	}


	

	
}