/**
 * Archivo: public class DeviceIdentification 
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



public class DeviceIdentification {

  private String deviceId;

  private String login;
  
  private Integer firstTime;

  public DeviceIdentification() {
    //Empty contructor in order to build basic DTO
  }

  public DeviceIdentification(Map objectMap) {
    
    String wDeviceId = (String)objectMap.get("deviceId");
    setDeviceId(wDeviceId);

    String wLogin = (String)objectMap.get("login");
    setLogin(wLogin);
    
    Integer wFirstTime =(Integer)objectMap.get("firstTime");
    setFirstTime(wFirstTime);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wDeviceId = getDeviceId();
    objectMap.put("deviceId", wDeviceId);

    String wLogin = getLogin();
    objectMap.put("login", wLogin);
        
    Integer wFirstTime = getFirstTime();
    objectMap.put("firstTime", wFirstTime);		
    return objectMap;
  }
  
	/** 
	* returns  deviceId
	*/	
	public String getDeviceId() {
    	return this.deviceId;
    }

	/** 
	* returns  login
	*/	
	public String getLogin() {
    	return this.login;
    }

    public void setDeviceId( String aDeviceId) {
    	this.deviceId = aDeviceId;
    }

    public void setLogin( String aLogin) {
    	this.login = aLogin;
    }
    


  public Integer getFirstTime() {
		return firstTime;
	}

	public void setFirstTime(Integer firstTime) {
		this.firstTime = firstTime;
	}

@Override
  public String toString() {
		return toMap().toString();
  }
}
