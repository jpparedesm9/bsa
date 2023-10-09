package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;

public interface HierarchyItemDao {

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	List<HierarchyItem> findByHierarchyItemStep(Integer idStep);

}
