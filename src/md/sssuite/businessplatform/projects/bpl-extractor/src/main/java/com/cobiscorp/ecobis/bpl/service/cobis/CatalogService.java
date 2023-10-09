package com.cobiscorp.ecobis.bpl.service.cobis;

import java.util.HashMap;
import java.util.LinkedHashMap;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Catalog;

public interface CatalogService {
	static HashMap<String, Catalog> hmCatalog = new LinkedHashMap<String, Catalog>();

	Catalog findCatalogByObservation(String observacionId) throws Exception;

	Catalog saveCatalog(Catalog catalog) throws Exception;

	Catalog findAndSave(Catalog catalog) throws Exception;
}
