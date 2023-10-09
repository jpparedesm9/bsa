package com.cobiscorp.ecobis.fpm.mock;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;

public class CatalogManagerMock implements ICatalogManager {

	
	public List<Catalog> getCatalogsByName(String name) {
		// TODO Auto-generated method stub
		return new ArrayList<Catalog>();
	}

	
	public Catalog getCatalog(String name, String code) {
		// TODO Auto-generated method stub
		return new Catalog("", "");
	}

	
	public void createCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	
	public void deleteCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	
	public void disableCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	
	public List<Catalog> getAllCurrencies() {
		// TODO Auto-generated method stub
		return new ArrayList<Catalog>();
	}

	
	public void enableCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	
	public Catalog getCatalogRegardlessState(String name, String code) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public Boolean verifyCatalog(String name) {
		// TODO Auto-generated method stub
		return null;
	}

}
