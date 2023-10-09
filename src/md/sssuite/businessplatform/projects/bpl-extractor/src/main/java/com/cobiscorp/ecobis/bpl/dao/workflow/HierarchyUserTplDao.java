package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyUserTpl;

public interface HierarchyUserTplDao {

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	List<HierarchyUserTpl> findByHierarchyItemTpl(Integer idHierarchyItemTpl);

	HierarchyUserTpl insert(HierarchyUserTpl hierarchyUserTpl);

	HierarchyUserTpl update(HierarchyUserTpl hierarchyUserTpl);

}
