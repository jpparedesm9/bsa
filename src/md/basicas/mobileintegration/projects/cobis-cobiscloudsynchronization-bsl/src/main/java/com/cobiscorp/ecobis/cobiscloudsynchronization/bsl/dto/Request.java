/**
 * Archivo: public class Request 
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

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;



public class Request {

  private java.util.Map channelInfo;

  private java.util.Map info;

  private java.util.Map partyInfo;

  private java.util.Map productInfo;

  private java.util.Map transactionInfo;

  public Request() {
    //Empty contructor in order to build basic DTO
  }

  public Request(Map objectMap) {
    
    java.util.Map wChannelInfo = (java.util.Map)objectMap.get("channelInfo");
    setChannelInfo(wChannelInfo);

    java.util.Map wInfo = (java.util.Map)objectMap.get("info");
    setInfo(wInfo);

    java.util.Map wPartyInfo = (java.util.Map)objectMap.get("partyInfo");
    setPartyInfo(wPartyInfo);

    java.util.Map wProductInfo = (java.util.Map)objectMap.get("productInfo");
    setProductInfo(wProductInfo);

    java.util.Map wTransactionInfo = (java.util.Map)objectMap.get("transactionInfo");
    setTransactionInfo(wTransactionInfo);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    java.util.Map wChannelInfo = getChannelInfo();
    objectMap.put("channelInfo", wChannelInfo);

    java.util.Map wInfo = getInfo();
    objectMap.put("info", wInfo);

    java.util.Map wPartyInfo = getPartyInfo();
    objectMap.put("partyInfo", wPartyInfo);

    java.util.Map wProductInfo = getProductInfo();
    objectMap.put("productInfo", wProductInfo);

    java.util.Map wTransactionInfo = getTransactionInfo();
    objectMap.put("transactionInfo", wTransactionInfo);
    return objectMap;
  }
  
	/** 
	* returns  channelInfo
	*/	
	public java.util.Map getChannelInfo() {
    	return this.channelInfo;
    }

	/** 
	* returns  info
	*/	
	public java.util.Map getInfo() {
    	return this.info;
    }

	/** 
	* returns  partyInfo
	*/	
	public java.util.Map getPartyInfo() {
    	return this.partyInfo;
    }

	/** 
	* returns  productInfo
	*/	
	public java.util.Map getProductInfo() {
    	return this.productInfo;
    }

	/** 
	* returns  transactionInfo
	*/	
	public java.util.Map getTransactionInfo() {
    	return this.transactionInfo;
    }

    public void setChannelInfo( java.util.Map aChannelInfo) {
    	this.channelInfo = aChannelInfo;
    }

    public void setInfo( java.util.Map aInfo) {
    	this.info = aInfo;
    }

    public void setPartyInfo( java.util.Map aPartyInfo) {
    	this.partyInfo = aPartyInfo;
    }

    public void setProductInfo( java.util.Map aProductInfo) {
    	this.productInfo = aProductInfo;
    }

    public void setTransactionInfo( java.util.Map aTransactionInfo) {
    	this.transactionInfo = aTransactionInfo;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
