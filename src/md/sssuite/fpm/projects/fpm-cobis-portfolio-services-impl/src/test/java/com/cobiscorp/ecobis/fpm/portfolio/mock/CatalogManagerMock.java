package com.cobiscorp.ecobis.fpm.portfolio.mock;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;

public class CatalogManagerMock implements ICatalogManager {

	@Override
	public List<Catalog> getCatalogsByName(String name) {
		// TODO Auto-generated method stub
		return new ArrayList<Catalog>();
	}

	@Override
	public Catalog getCatalog(String name, String code) {
		// TODO Auto-generated method stub
		return new Catalog("", "");
	}

	@Override
	public void createCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void disableCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Catalog> getAllCurrencies() {
		// TODO Auto-generated method stub
		return new ArrayList<Catalog>();
	}

	@Override
	public void enableCatalog(String name, Catalog catalog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Catalog getCatalogRegardlessState(String name, String code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean verifyCatalog(String name) {
		// TODO Auto-generated method stub
		return null;
	}

}
