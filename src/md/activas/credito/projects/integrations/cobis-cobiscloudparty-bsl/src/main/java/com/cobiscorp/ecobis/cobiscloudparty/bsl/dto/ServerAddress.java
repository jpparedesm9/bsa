/**
 * Archivo: public class ServerAddress 
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

package com.cobiscorp.ecobis.cobiscloudparty.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;



public class ServerAddress {

  private String ip;

  private String port;

  public ServerAddress() {
    //Empty contructor in order to build basic DTO
  }

  public ServerAddress(Map objectMap) {
    
    String wIp = (String)objectMap.get("ip");
    setIp(wIp);

    String wPort = (String)objectMap.get("port");
    setPort(wPort);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wIp = getIp();
    objectMap.put("ip", wIp);

    String wPort = getPort();
    objectMap.put("port", wPort);
    return objectMap;
  }
  
	/** 
	* returns  ip
	*/	
	public String getIp() {
    	return this.ip;
    }

	/** 
	* returns  port
	*/	
	public String getPort() {
    	return this.port;
    }

    public void setIp( String aIp) {
    	this.ip = aIp;
    }

    public void setPort( String aPort) {
    	this.port = aPort;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
