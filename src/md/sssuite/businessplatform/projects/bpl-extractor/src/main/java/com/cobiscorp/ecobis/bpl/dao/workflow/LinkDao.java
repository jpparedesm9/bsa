package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;

public interface LinkDao {

	/**
	 * Recupera los links por idProcess y version
	 * 
	 * @return
	 */
	List<Link> findLinkByProcessVersion(Integer idProcess, Short version);

	Link save(Link link) throws Exception;

}
