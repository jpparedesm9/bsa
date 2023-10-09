package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;

import com.cobiscorp.ecobis.fpm.bo.Catalog;

public class CatalogUtils {

	/**
	 * Find a catalog from a list given the code
	 * @param catalogs
	 * @param code
	 * @return
	 */
	public static Catalog getFromCatalogList(List<Catalog> catalogs, final String code) {
		return (Catalog) CollectionUtils.find(catalogs, new Predicate() {
			public boolean evaluate(Object catalog) {
				return ((Catalog) catalog).getCode().equals(code);
			}
		});
	}
}
