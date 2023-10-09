package com.cobiscorp.ecobis.bpl.service.cobis.impl;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Catalog;
import com.cobiscorp.ecobis.bpl.cobis.engine.model.CobisTable;
import com.cobiscorp.ecobis.bpl.dao.cobis.CatalogDao;
import com.cobiscorp.ecobis.bpl.dao.cobis.CobisTableDao;
import com.cobiscorp.ecobis.bpl.service.cobis.CatalogService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;

public class CatalogServiceImpl implements CatalogService {

	private CatalogDao catalogDao;
	private CobisTableDao cobisTableDao;

	public CatalogDao getCatalogDao() {
		return catalogDao;
	}

	public void setCatalogDao(CatalogDao catalogDao) {
		this.catalogDao = catalogDao;
	}

	public CobisTableDao getCobisTableDao() {
		return cobisTableDao;
	}

	public void setCobisTableDao(CobisTableDao cobisTableDao) {
		this.cobisTableDao = cobisTableDao;
	}

	public Catalog findCatalogByObservation(String observacionId) throws Exception {
		return catalogDao.findCatalogByObservation(observacionId);
	}

	public Catalog saveCatalog(Catalog catalog) throws Exception {
		CobisTable table = cobisTableDao.findCobisTableByTableName("wf_observacion");
		catalog.setTable(table);
		return catalogDao.saveCatalog(catalog);
	}

	public Catalog findAndSave(Catalog catalog) throws Exception {
		Catalog searchCatalog = hmCatalog.get(catalog.getCodigo());
		if (searchCatalog == null) {
			searchCatalog = findCatalogByObservation(catalog.getCodigo());
			if (searchCatalog == null) {
				catalog = saveCatalog(catalog);
				hmCatalog.put(catalog.getCodigo(), catalog);
				return catalog;
			} else {
				hmCatalog.put(searchCatalog.getCodigo(), searchCatalog);
				return searchCatalog;
			}

		}

		return searchCatalog;
	}

}
