/**
 * Archivo: public class Header 
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



public class Header {

  private String contractAmount;

  private String contractType;

  private String countryKey;

  private String language;

  private String operatorReferenceNumber;

  private String outputType;

  private String password;

  private String queryType;

  private String requiredProduct;

  private String unitCurrencyKey;

  private String userKey;

  private String version;

  public Header() {
    //Empty contructor in order to build basic DTO
  }

  public Header(Map objectMap) {
    
    String wContractAmount = (String)objectMap.get("contractAmount");
    setContractAmount(wContractAmount);

    String wContractType = (String)objectMap.get("contractType");
    setContractType(wContractType);

    String wCountryKey = (String)objectMap.get("countryKey");
    setCountryKey(wCountryKey);

    String wLanguage = (String)objectMap.get("language");
    setLanguage(wLanguage);

    String wOperatorReferenceNumber = (String)objectMap.get("operatorReferenceNumber");
    setOperatorReferenceNumber(wOperatorReferenceNumber);

    String wOutputType = (String)objectMap.get("outputType");
    setOutputType(wOutputType);

    String wPassword = (String)objectMap.get("password");
    setPassword(wPassword);

    String wQueryType = (String)objectMap.get("queryType");
    setQueryType(wQueryType);

    String wRequiredProduct = (String)objectMap.get("requiredProduct");
    setRequiredProduct(wRequiredProduct);

    String wUnitCurrencyKey = (String)objectMap.get("unitCurrencyKey");
    setUnitCurrencyKey(wUnitCurrencyKey);

    String wUserKey = (String)objectMap.get("userKey");
    setUserKey(wUserKey);

    String wVersion = (String)objectMap.get("version");
    setVersion(wVersion);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wContractAmount = getContractAmount();
    objectMap.put("contractAmount", wContractAmount);

    String wContractType = getContractType();
    objectMap.put("contractType", wContractType);

    String wCountryKey = getCountryKey();
    objectMap.put("countryKey", wCountryKey);

    String wLanguage = getLanguage();
    objectMap.put("language", wLanguage);

    String wOperatorReferenceNumber = getOperatorReferenceNumber();
    objectMap.put("operatorReferenceNumber", wOperatorReferenceNumber);

    String wOutputType = getOutputType();
    objectMap.put("outputType", wOutputType);

    String wPassword = getPassword();
    objectMap.put("password", wPassword);

    String wQueryType = getQueryType();
    objectMap.put("queryType", wQueryType);

    String wRequiredProduct = getRequiredProduct();
    objectMap.put("requiredProduct", wRequiredProduct);

    String wUnitCurrencyKey = getUnitCurrencyKey();
    objectMap.put("unitCurrencyKey", wUnitCurrencyKey);

    String wUserKey = getUserKey();
    objectMap.put("userKey", wUserKey);

    String wVersion = getVersion();
    objectMap.put("version", wVersion);
    return objectMap;
  }
  
	/** 
	* returns  contractAmount
	*/	
	public String getContractAmount() {
    	return this.contractAmount;
    }

	/** 
	* returns  contractType
	*/	
	public String getContractType() {
    	return this.contractType;
    }

	/** 
	* returns  countryKey
	*/	
	public String getCountryKey() {
    	return this.countryKey;
    }

	/** 
	* returns  language
	*/	
	public String getLanguage() {
    	return this.language;
    }

	/** 
	* returns  operatorReferenceNumber
	*/	
	public String getOperatorReferenceNumber() {
    	return this.operatorReferenceNumber;
    }

	/** 
	* returns  outputType
	*/	
	public String getOutputType() {
    	return this.outputType;
    }

	/** 
	* returns  password
	*/	
	public String getPassword() {
    	return this.password;
    }

	/** 
	* returns  queryType
	*/	
	public String getQueryType() {
    	return this.queryType;
    }

	/** 
	* returns  requiredProduct
	*/	
	public String getRequiredProduct() {
    	return this.requiredProduct;
    }

	/** 
	* returns  unitCurrencyKey
	*/	
	public String getUnitCurrencyKey() {
    	return this.unitCurrencyKey;
    }

	/** 
	* returns  userKey
	*/	
	public String getUserKey() {
    	return this.userKey;
    }

	/** 
	* returns  version
	*/	
	public String getVersion() {
    	return this.version;
    }

    public void setContractAmount( String aContractAmount) {
    	this.contractAmount = aContractAmount;
    }

    public void setContractType( String aContractType) {
    	this.contractType = aContractType;
    }

    public void setCountryKey( String aCountryKey) {
    	this.countryKey = aCountryKey;
    }

    public void setLanguage( String aLanguage) {
    	this.language = aLanguage;
    }

    public void setOperatorReferenceNumber( String aOperatorReferenceNumber) {
    	this.operatorReferenceNumber = aOperatorReferenceNumber;
    }

    public void setOutputType( String aOutputType) {
    	this.outputType = aOutputType;
    }

    public void setPassword( String aPassword) {
    	this.password = aPassword;
    }

    public void setQueryType( String aQueryType) {
    	this.queryType = aQueryType;
    }

    public void setRequiredProduct( String aRequiredProduct) {
    	this.requiredProduct = aRequiredProduct;
    }

    public void setUnitCurrencyKey( String aUnitCurrencyKey) {
    	this.unitCurrencyKey = aUnitCurrencyKey;
    }

    public void setUserKey( String aUserKey) {
    	this.userKey = aUserKey;
    }

    public void setVersion( String aVersion) {
    	this.version = aVersion;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
