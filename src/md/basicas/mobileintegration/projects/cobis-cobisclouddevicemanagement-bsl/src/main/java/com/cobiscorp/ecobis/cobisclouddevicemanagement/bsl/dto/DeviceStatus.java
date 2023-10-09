/**
 * Archivo: public class DeviceStatus 
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



public class DeviceStatus {

  private Boolean lock;

  private String officerName;

  private Boolean proceedToClearData;

  private Boolean proceedToCompleteRegistration;

  private String status;

  public DeviceStatus() {
    //Empty contructor in order to build basic DTO
  }

  public DeviceStatus(Map objectMap) {
    
    Boolean wLock = (Boolean)objectMap.get("lock");
    setLock(wLock);

    String wOfficerName = (String)objectMap.get("officerName");
    setOfficerName(wOfficerName);

    Boolean wProceedToClearData = (Boolean)objectMap.get("proceedToClearData");
    setProceedToClearData(wProceedToClearData);

    Boolean wProceedToCompleteRegistration = (Boolean)objectMap.get("proceedToCompleteRegistration");
    setProceedToCompleteRegistration(wProceedToCompleteRegistration);

    String wStatus = (String)objectMap.get("status");
    setStatus(wStatus);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    Boolean wLock = getLock();
    objectMap.put("lock", wLock);

    String wOfficerName = getOfficerName();
    objectMap.put("officerName", wOfficerName);

    Boolean wProceedToClearData = getProceedToClearData();
    objectMap.put("proceedToClearData", wProceedToClearData);

    Boolean wProceedToCompleteRegistration = getProceedToCompleteRegistration();
    objectMap.put("proceedToCompleteRegistration", wProceedToCompleteRegistration);

    String wStatus = getStatus();
    objectMap.put("status", wStatus);
    return objectMap;
  }
  
	/** 
	* returns  lock
	*/	
	public Boolean getLock() {
    	return this.lock;
    }

	/** 
	* returns  officerName
	*/	
	public String getOfficerName() {
    	return this.officerName;
    }

	/** 
	* returns  proceedToClearData
	*/	
	public Boolean getProceedToClearData() {
    	return this.proceedToClearData;
    }

	/** 
	* returns  proceedToCompleteRegistration
	*/	
	public Boolean getProceedToCompleteRegistration() {
    	return this.proceedToCompleteRegistration;
    }

	/** 
	* returns  status
	*/	
	public String getStatus() {
    	return this.status;
    }

    public void setLock( Boolean aLock) {
    	this.lock = aLock;
    }

    public void setOfficerName( String aOfficerName) {
    	this.officerName = aOfficerName;
    }

    public void setProceedToClearData( Boolean aProceedToClearData) {
    	this.proceedToClearData = aProceedToClearData;
    }

    public void setProceedToCompleteRegistration( Boolean aProceedToCompleteRegistration) {
    	this.proceedToCompleteRegistration = aProceedToCompleteRegistration;
    }

    public void setStatus( String aStatus) {
    	this.status = aStatus;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
