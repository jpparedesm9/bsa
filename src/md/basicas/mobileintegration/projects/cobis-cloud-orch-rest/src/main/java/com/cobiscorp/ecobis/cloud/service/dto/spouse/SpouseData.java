package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataRequest;
import java.util.Calendar;

public class SpouseData {

    private Spouse spouse;
    private SpouseAdditionalInfo additional;
    private String economicActivity;

    public SpouseData() {
    }

    public SpouseData(Spouse spouse, SpouseAdditionalInfo spouseAdditionalInfo) {
        this.spouse = spouse;
        this.additional = spouseAdditionalInfo;
    }

    public Spouse getSpouse() {
        return spouse;
    }

    public void setSpouse(Spouse spouse) {
        this.spouse = spouse;
    }

    public SpouseAdditionalInfo getAdditional() {
        return additional;
    }

    public void setAdditional(SpouseAdditionalInfo additional) {
        this.additional = additional;
    }

    public String getEconomicActivity() {
	return economicActivity;
    }

    public void setEconomicActivity(String economicActivity) {
	this.economicActivity = economicActivity;
    }

    public EconomicActivityDataRequest getEconomicActivityRequest(int customerId, int economicActivityId) {
	EconomicActivityDataRequest request = new EconomicActivityDataRequest();
	request.setEconomicActivity(economicActivity);
	request.setSequential(economicActivityId);
	request.setCustomer(customerId);
	request.setSector("III");
	request.setSubSector("U");
	request.setSubActivity(" ");
	request.setIncomeSource(" ");
	request.setPrincipal("N");
	request.setAttentionDays(" ");
	request.setAttentionSchedule(" ");
	request.setStartDate(Calendar.getInstance());
	request.setEnvironment(" ");
	request.setAuthorized("S");
	request.setAffiliate("S");
	request.setAffiliationPlace(" ");
	request.setNumberEmployees(1);
	request.setDescription("S");
	request.setCaedec(" ");
	request.setPropertyType("N/A");
	request.setActivitySchedule(" ");
	request.setActivityStatus("V");
	request.setVerified(" ");
	request.setVerificationDate(Calendar.getInstance());
	request.setVerificationSource(" ");
	return request;
    }
}
