package com.cobiscorp.ecobis.commons.dal;

import java.util.List;

import com.cobiscorp.ecobis.commons.dal.entities.Catalog;

public interface CatalogDAO {

	/**
	 * This method is used to get catalogs by table name.
	 * @param name, It's the table name.
	 * @return The name of a defined catalog.
	 */
	public abstract List<Catalog> getCatalogsByName(String name);
	
	/**
	 * This method is used to obtain the description of any catalog.
	 * @param name, It's the table name.
	 * @param code, It's the code to find.
	 * @return Catalog description.
	 */
	public abstract String getValueCatalog(String name, String code);
}
