/**
 * Archivo: public class SantanderRequest 
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

package com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.SearchCustomerInfo;


public class SantanderRequest {

  private Integer customerId;

  private SearchCustomerInfo searchCustomerInfo;

  public SantanderRequest() {
    //Empty contructor in order to build basic DTO
  }

  public SantanderRequest(Map objectMap) {
    
    Integer wCustomerId = (Integer)objectMap.get("customerId");
    setCustomerId(wCustomerId);

    SearchCustomerInfo wSearchCustomerInfo = (SearchCustomerInfo)objectMap.get("searchCustomerInfo");
    setSearchCustomerInfo(wSearchCustomerInfo);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    Integer wCustomerId = getCustomerId();
    objectMap.put("customerId", wCustomerId);

    SearchCustomerInfo wSearchCustomerInfo = getSearchCustomerInfo();
    objectMap.put("searchCustomerInfo", wSearchCustomerInfo);
    return objectMap;
  }
  
	/** 
	* returns  customerId
	*/	
	public Integer getCustomerId() {
    	return this.customerId;
    }

	/** 
	* returns  searchCustomerInfo
	*/	
	public SearchCustomerInfo getSearchCustomerInfo() {
    	return this.searchCustomerInfo;
    }

    public void setCustomerId( Integer aCustomerId) {
    	this.customerId = aCustomerId;
    }

    public void setSearchCustomerInfo( SearchCustomerInfo aSearchCustomerInfo) {
    	this.searchCustomerInfo = aSearchCustomerInfo;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
