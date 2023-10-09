package com.cobiscorp.ecobis.cloud.service.dto.client;

public class ComplementaryData {
	
    private Complementary complementary;

    public ComplementaryData() {
    }      
    
	public ComplementaryData(Complementary complementary) {
		super();
		this.complementary = complementary;
	}


	public Complementary getComplementary() {
		return complementary;
	}

	public void setComplementary(Complementary complementary) {
		this.complementary = complementary;
	}

}
