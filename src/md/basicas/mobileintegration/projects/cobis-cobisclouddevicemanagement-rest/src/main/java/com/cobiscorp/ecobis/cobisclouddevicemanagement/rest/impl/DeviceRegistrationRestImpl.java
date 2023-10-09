/**
 * Archivo: DeviceRegistrationRestImpl.java
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

package com.cobiscorp.ecobis.cobisclouddevicemanagement.rest.impl;
 
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Context;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;


import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;

import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationData;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationForService;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationRequest;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceStatus;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.GetStatusRequest;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.MacsToValidate;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.Request;

//incluir en code order con la clave:cobisclouddevicemanagement.DeviceRegistrationRestImpl.imports
import java.util.Date;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import com.cobiscorp.cobis.cts.webtoken.impl.WebTokenFactory;


@Path("/cobis-cloud/mobile/deviceregistration")
@Component
@org.apache.felix.scr.annotations.Service({ com.cobiscorp.ecobis.cobisclouddevicemanagement.rest.api.IDeviceRegistrationRest.class })
public class DeviceRegistrationRestImpl extends ServiceBase  
	implements com.cobiscorp.ecobis.cobisclouddevicemanagement.rest.api.IDeviceRegistrationRest{
 
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory
			.getLogger(DeviceRegistrationRestImpl.class);

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}




  @Path("/register")
  @Produces(MediaType.APPLICATION_JSON)
  @Consumes(MediaType.APPLICATION_JSON)
  @PUT
  @Override
  public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  register (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationRequest aDeviceRegistrationRequest,
  @Context HttpServletRequest httpRequest){
		logger.logDebug(".......---------DeviceRegistrationSERVImpl.register");
    //to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationRestImpl.register
      String authorization = httpRequest.getHeader("Authorization");
  
  IWebTokenService webTokenService = WebTokenFactory.getService(IWebTokenService.MOBILE_OFFICIAL_CHANNEL);
  String token = webTokenService.extractTokenFromBearerToken(authorization);
  Map<String, Object> claims = webTokenService.getProperties(token);

  logger.logDebug(".......---------claims" + claims);
  DeviceRegistrationForService deviceRegistrationForService = new DeviceRegistrationForService();
  DeviceIdentification deviceIdentification = new DeviceIdentification();
  deviceIdentification.setDeviceId((String)claims.get("deviceId"));
  deviceIdentification.setLogin((String)claims.get("user"));
  deviceRegistrationForService.setDeviceIdentification(deviceIdentification);
  deviceRegistrationForService.setDeviceRegistrationData(aDeviceRegistrationRequest.getDeviceRegistrationData());
  return this.execute(serviceIntegration, logger, "DeviceRegistrationSERVImpl.register",new Object[] {
  deviceRegistrationForService 
  });

	}

  @Path("/reportAsLost")
  @Produces(MediaType.APPLICATION_JSON)
  @Consumes(MediaType.APPLICATION_JSON)
  @PUT
  @Override
  public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  reportAsLost (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest){
		logger.logDebug(".......---------DeviceRegistrationSERVImpl.reportAsLost");
    //to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationRestImpl.reportAsLost
    //deprecated: incluir en code order con la clave:DeviceRegistrationRestImpl.reportAsLost 
       
    return this.execute(serviceIntegration, logger, "DeviceRegistrationSERVImpl.reportAsLost",new Object[] {
    aDeviceIdentification 
    });
	}

  @Path("/unsuscribe")
  @Produces(MediaType.APPLICATION_JSON)
  @Consumes(MediaType.APPLICATION_JSON)
  @PUT
  @Override
  public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  unsuscribe (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest){
		logger.logDebug(".......---------DeviceRegistrationSERVImpl.unsuscribe");
    //to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationRestImpl.unsuscribe
    //deprecated: incluir en code order con la clave:DeviceRegistrationRestImpl.unsuscribe 
       
    return this.execute(serviceIntegration, logger, "DeviceRegistrationSERVImpl.unsuscribe",new Object[] {
    aDeviceIdentification 
    });
	}

  @Path("/tmpClear")
  @Produces(MediaType.APPLICATION_JSON)
  @Consumes(MediaType.APPLICATION_JSON)
  @PUT
  @Override
  public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  tmpClear (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest){
		logger.logDebug(".......---------DeviceRegistrationSERVImpl.tmpClear");
    //to include in code order use key: cobisclouddevicemanagement.DeviceRegistrationRestImpl.tmpClear
    //deprecated: incluir en code order con la clave:DeviceRegistrationRestImpl.tmpClear 
       
    return this.execute(serviceIntegration, logger, "DeviceRegistrationSERVImpl.tmpClear",new Object[] {
    aDeviceIdentification 
    });
	}
	//for the body include in code order with the key: cobisclouddevicemanagement.DeviceRegistration.body


}