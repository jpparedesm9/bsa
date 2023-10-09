/**
 * Archivo: public class UpdateCustomerInfoRequest 
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



public class UpdateCustomerInfoRequest {

  private String bank;

  private String bankAccount;

  private Integer customerId;

  private String indRiskScore;

  private String riskScore;

  private String status;
  
  private Integer listBlackCustomer;

  public UpdateCustomerInfoRequest() {
    //Empty contructor in order to build basic DTO
  }

  public UpdateCustomerInfoRequest(Map objectMap) {
    
    String wBank = (String)objectMap.get("bank");
    setBank(wBank);

    String wBankAccount = (String)objectMap.get("bankAccount");
    setBankAccount(wBankAccount);

    Integer wCustomerId = (Integer)objectMap.get("customerId");
    setCustomerId(wCustomerId);

    String wIndRiskScore = (String)objectMap.get("indRiskScore");
    setIndRiskScore(wIndRiskScore);

    String wRiskScore = (String)objectMap.get("riskScore");
    setRiskScore(wRiskScore);

    String wStatus = (String)objectMap.get("status");
    setStatus(wStatus);
    Integer wListBlackCustomer = (Integer)objectMap.get("listBlackCustomer");
    setListBlackCustomer(wListBlackCustomer);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wBank = getBank();
    objectMap.put("bank", wBank);

    String wBankAccount = getBankAccount();
    objectMap.put("bankAccount", wBankAccount);

    Integer wCustomerId = getCustomerId();
    objectMap.put("customerId", wCustomerId);

    String wIndRiskScore = getIndRiskScore();
    objectMap.put("indRiskScore", wIndRiskScore);

    String wRiskScore = getRiskScore();
    objectMap.put("riskScore", wRiskScore);

    String wStatus = getStatus();
    objectMap.put("status", wStatus);
    
    Integer wListBlackCustomer = getListBlackCustomer();
    objectMap.put("listBlackCustomer", wListBlackCustomer);
    
    return objectMap;
  }
  
	/** 
	* returns  bank
	*/	
	public String getBank() {
    	return this.bank;
    }

	/** 
	* returns  bankAccount
	*/	
	public String getBankAccount() {
    	return this.bankAccount;
    }

	/** 
	* returns  customerId
	*/	
	public Integer getCustomerId() {
    	return this.customerId;
    }

	/** 
	* returns  indRiskScore
	*/	
	public String getIndRiskScore() {
    	return this.indRiskScore;
    }

	/** 
	* returns  riskScore
	*/	
	public String getRiskScore() {
    	return this.riskScore;
    }

	/** 
	* returns  status
	*/	
	public String getStatus() {
    	return this.status;
    }

    public void setBank( String aBank) {
    	this.bank = aBank;
    }

    public void setBankAccount( String aBankAccount) {
    	this.bankAccount = aBankAccount;
    }

    public void setCustomerId( Integer aCustomerId) {
    	this.customerId = aCustomerId;
    }

    public void setIndRiskScore( String aIndRiskScore) {
    	this.indRiskScore = aIndRiskScore;
    }

    public void setRiskScore( String aRiskScore) {
    	this.riskScore = aRiskScore;
    }

    public void setStatus( String aStatus) {
    	this.status = aStatus;
    }
    
  public Integer getListBlackCustomer() {
		return listBlackCustomer;
	}

	public void setListBlackCustomer(Integer listBlackCustomer) {
		this.listBlackCustomer = listBlackCustomer;
	}

@Override
  public String toString() {
		return toMap().toString();
  }
}
