/**
 * Archivo: public class DeviceRegistrationForService 
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
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification;


public class DeviceRegistrationForService  extends DeviceRegistrationRequest {

  private DeviceIdentification deviceIdentification;

  public DeviceRegistrationForService() {
    //Empty contructor in order to build basic DTO
  }

  public DeviceRegistrationForService(Map objectMap) {
     super(objectMap); 
    Map wDeviceIdentificationMap = (Map)objectMap.get("deviceIdentification");
    if(wDeviceIdentificationMap != null) {
      DeviceIdentification wDeviceIdentification = new DeviceIdentification(wDeviceIdentificationMap);
      setDeviceIdentification(wDeviceIdentification);
    }
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
     Map objectMapSupper = super.toMap(); objectMap.putAll(objectMapSupper); 
    if (getDeviceIdentification() != null) {
      objectMap.put("deviceIdentification", getDeviceIdentification().toMap());
    }
    return objectMap;
  }
  
	/** 
	* returns  deviceIdentification
	*/	
	public DeviceIdentification getDeviceIdentification() {
    	return this.deviceIdentification;
    }

    public void setDeviceIdentification( DeviceIdentification aDeviceIdentification) {
    	this.deviceIdentification = aDeviceIdentification;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
