package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface LinkService {

	/**
	 * Recupera los links por idProcess y version
	 * 
	 * @return
	 */
	List<Link> findLinkByProcessVersion(Integer idProcess, Short version);

	void saveLink(Process process, ProcessVersion processVersion, ProcessVersion searchedProcessVersion, DriverManagerDataSource dataSource)
			throws Exception;

	Link saveLink(Link link) throws Exception;
}
