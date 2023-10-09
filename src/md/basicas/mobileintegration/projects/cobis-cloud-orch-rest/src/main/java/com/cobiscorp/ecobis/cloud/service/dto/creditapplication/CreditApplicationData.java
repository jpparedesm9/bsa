package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

/**
 * Created by ntrujillo on 18/07/2017.
 */
public class CreditApplicationData {

    int applicationCode;
    int groupCycle;
    float interestRate;
    long applicationDate;
   
    
    public int getApplicationCode() {
        return applicationCode;
    }

    public void setApplicationCode(int applicationCode) {
        this.applicationCode = applicationCode;
    }

	public int getGroupCycle() {
		return groupCycle;
	}

	public void setGroupCycle(int groupCycle) {
		this.groupCycle = groupCycle;
	}

	public float getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(float interestRate) {
		this.interestRate = interestRate;
	}

	public long getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(long applicationDate) {
		this.applicationDate = applicationDate;
	}
}
