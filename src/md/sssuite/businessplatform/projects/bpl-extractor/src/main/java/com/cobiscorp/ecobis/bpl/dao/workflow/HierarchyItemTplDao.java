package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItemTpl;

public interface HierarchyItemTplDao {

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	List<HierarchyItemTpl> findByHierarchyTypeTpl(Integer idHierarchyTypeTpl);

	HierarchyItemTpl insert(HierarchyItemTpl hierarchyItemTpl);

	HierarchyItemTpl findByHierarchyTypeTplAndHierarchyItemTpl(String nameHierarchyTypeTpl, String nameHierarchyItemTpl);

}
