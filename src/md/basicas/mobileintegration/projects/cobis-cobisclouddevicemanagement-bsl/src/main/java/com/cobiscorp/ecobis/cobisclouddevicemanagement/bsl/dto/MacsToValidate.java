/**
 * Archivo: public class MacsToValidate 
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



public class MacsToValidate {

  private String mac;

  private String mac1;

  private String mac2;

  public MacsToValidate() {
    //Empty contructor in order to build basic DTO
  }

  public MacsToValidate(Map objectMap) {
    
    String wMac = (String)objectMap.get("mac");
    setMac(wMac);

    String wMac1 = (String)objectMap.get("mac1");
    setMac1(wMac1);

    String wMac2 = (String)objectMap.get("mac2");
    setMac2(wMac2);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wMac = getMac();
    objectMap.put("mac", wMac);

    String wMac1 = getMac1();
    objectMap.put("mac1", wMac1);

    String wMac2 = getMac2();
    objectMap.put("mac2", wMac2);
    return objectMap;
  }
  
	/** 
	* returns  mac
	*/	
	public String getMac() {
    	return this.mac;
    }

	/** 
	* returns  mac1
	*/	
	public String getMac1() {
    	return this.mac1;
    }

	/** 
	* returns  mac2
	*/	
	public String getMac2() {
    	return this.mac2;
    }

    public void setMac( String aMac) {
    	this.mac = aMac;
    }

    public void setMac1( String aMac1) {
    	this.mac1 = aMac1;
    }

    public void setMac2( String aMac2) {
    	this.mac2 = aMac2;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
