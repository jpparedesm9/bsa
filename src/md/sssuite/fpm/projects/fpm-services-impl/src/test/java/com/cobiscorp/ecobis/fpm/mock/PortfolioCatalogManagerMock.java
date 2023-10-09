package com.cobiscorp.ecobis.fpm.mock;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;

public class PortfolioCatalogManagerMock implements IPortfolioCatalogManager {

	
	public List<Catalog> findAllSubsidiaries() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllTransactionType() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllStatus() {
		return new ArrayList<Catalog>();
	}

	
	public String findStatusByCode(int code) {
		return "";
	}

	
	public List<Catalog> findAllConcepts() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllProfiles() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllEconomicDestinations() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllPurposes() {
		return new ArrayList<Catalog>();
	}

	
	public List<Catalog> findAllEconomicActivities() {
		// TODO Auto-generated method stub
		return new ArrayList<Catalog>();
	}

}
