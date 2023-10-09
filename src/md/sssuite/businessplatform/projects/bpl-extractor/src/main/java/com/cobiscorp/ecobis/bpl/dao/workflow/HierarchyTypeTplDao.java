package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;

public interface HierarchyTypeTplDao {

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	HierarchyTypeTpl findById(Integer idHierarchyTypeTpl);
	
	HierarchyTypeTpl findByName(String name);

	HierarchyTypeTpl insert(HierarchyTypeTpl hierarchyItemTpl);

	HierarchyTypeTpl update(HierarchyTypeTpl hierarchyItemTpl);

}
