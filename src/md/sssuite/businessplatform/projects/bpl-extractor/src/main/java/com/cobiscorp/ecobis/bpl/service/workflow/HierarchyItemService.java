package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;

public interface HierarchyItemService {

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	List<HierarchyItem> findByHierarchyItemStep(Integer idStep);

}
