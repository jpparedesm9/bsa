package com.cobiscorp.ecobis.fpm.service.utils;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;

import cobiscorp.ecobis.htm.api.dto.ProcessDTO;

import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.Item;

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
	
	/**
	 * Find a item in a list
	 * @param items
	 * @param id
	 * @return
	 */
	public static Item getItemFromList(List<Item> items, final long id) {
		return (Item) CollectionUtils.find(items, new Predicate() {
			public boolean evaluate(Object item) {
				return ((Item) item).getId() == id;
			}
		});
	}
	
	/**
	 * Find a process in the given list by its id
	 * @param items
	 * @param id
	 * @return
	 */
	public static ProcessDTO getFromProcessList(List<ProcessDTO> processes, final String id) {
		return (ProcessDTO) CollectionUtils.find(processes, new Predicate() {
			public boolean evaluate(Object item) {
				return ((ProcessDTO) item).getProcessId().equals(id);
			}
		});
	}
	
	/**
	 * Find a field value in the given list by its value
	 * @param values
	 * @param id
	 * @return
	 */
	public static FieldValue getFieldValueList(List<FieldValue> values, final String value) {
		return (FieldValue) CollectionUtils.find(values, new Predicate() {
			public boolean evaluate(Object item) {
				return ((FieldValue) item).getValue().equals(value);
			}
		});
	}
}
