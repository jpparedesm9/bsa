
/**
 * Archivo: ServiceBase.java
 * Fecha..:
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.impl;

import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisCatalog;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICOBISSequentialService;

import javax.transaction.TransactionManager;

import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public abstract class ServiceBase {

    protected TransactionManager txMgr;

    protected ISPOrchestrator spOrchestrator;
    protected static final String FILTER_FIELD = "SPExecutorServiceFactoryFilter";
    protected static final String TRANSACTIONAL_FILTER_VALUE = "(service.impl=transactional)";

    //Define las constantes a ser utilizadas
    protected static final String PARAM = "aParameter";
    protected static final String PARAM_CRUD = "aParameterCrud";
    protected static final String PARAM_PAGINACION = "aParameterPaginacion";
    protected static final String PARAM_MAYOR = "aParameterMayor";
    protected static final String PARAM_MAYOR_IGUAL = "aParameterMayorIgual";
    protected static final String PARAM_MENOR = "aParameterMenor";
    protected static final String PARAM_MENOR_IGUAL = "aParameterMenorIgual";
    protected static final String PARAM_NOT_IN = "aParameterNotIn";
    protected static final String PARAM_ORDER_BY = "aParameterOrderBy";

    protected static final Integer SUCESSFULL = 0;
    protected static final Integer FAIL = 1;

    protected ICOBISSequentialService ctsSequentialService;
    protected ICobisParameter cobisParameter;
    protected ICobisCatalog cobisCatalog;
    protected ICacheManager cacheManager;

    public ISPOrchestrator getSpOrchestrator() {
        return spOrchestrator;
    }

    public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
        this.spOrchestrator = spOrchestrator;
    }

    public TransactionManager getTxMgr() {
        return txMgr;
    }

    public void setTxMgr(TransactionManager txMgr) {
        this.txMgr = txMgr;
    }

    public ICOBISSequentialService getCtsSequentialService() {
        return ctsSequentialService;
    }

    public void setCtsSequentialService(ICOBISSequentialService aCtsSequentialService) {
        this.ctsSequentialService = aCtsSequentialService;
    }

    public ICobisParameter getCobisParameter() {
        return cobisParameter;
    }

    public void setCobisParameter(ICobisParameter aCobisParameter) {
        this.cobisParameter = aCobisParameter;
    }

    public ICobisCatalog getCobisCatalog() {
        return cobisCatalog;
    }

    public void setCobisCatalog(ICobisCatalog aCobisCatalog) {
        this.cobisCatalog = aCobisCatalog;
    }

    public void setCacheManager(ICacheManager aCacheManager) {
        this.cacheManager = aCacheManager;
    }

    public ICacheManager getCacheManager() {
        return this.cacheManager;
    }

}
