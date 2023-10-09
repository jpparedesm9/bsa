package com.cobiscorp.ecobis.bpl.service.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;

public interface LinkRolService {

	// void saveLinkRole(Process process, ProcessVersion processVersion, DriverManagerDataSource dataSource) throws Exception;

	LinkRole saveLinkRole(LinkRole linkRole) throws Exception;
}
