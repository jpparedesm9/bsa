package com.cobis.cloud.lcr.b2b.service;

import javax.ws.rs.core.Response;

public interface CatalogService {
	Response getCatalog(String catalogName);
}
