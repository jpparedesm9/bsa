/**
 * Archivo: public class DeviceRegistrationRequest 
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

package com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationData;


public class DeviceRegistrationRequest {

  private DeviceRegistrationData deviceRegistrationData;

  private Boolean online;

  public DeviceRegistrationRequest() {
    //Empty contructor in order to build basic DTO
  }

  public DeviceRegistrationRequest(Map objectMap) {
    
    Map wDeviceRegistrationDataMap = (Map)objectMap.get("deviceRegistrationData");
    if(wDeviceRegistrationDataMap != null) {
      DeviceRegistrationData wDeviceRegistrationData = new DeviceRegistrationData(wDeviceRegistrationDataMap);
      setDeviceRegistrationData(wDeviceRegistrationData);
    }

    Boolean wOnline = (Boolean)objectMap.get("online");
    setOnline(wOnline);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    if (getDeviceRegistrationData() != null) {
      objectMap.put("deviceRegistrationData", getDeviceRegistrationData().toMap());
    }

    Boolean wOnline = getOnline();
    objectMap.put("online", wOnline);
    return objectMap;
  }
  
	/** 
	* returns  deviceRegistrationData
	*/	
	public DeviceRegistrationData getDeviceRegistrationData() {
    	return this.deviceRegistrationData;
    }

	/** 
	* returns  online
	*/	
	public Boolean getOnline() {
    	return this.online;
    }

    public void setDeviceRegistrationData( DeviceRegistrationData aDeviceRegistrationData) {
    	this.deviceRegistrationData = aDeviceRegistrationData;
    }

    public void setOnline( Boolean aOnline) {
    	this.online = aOnline;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
