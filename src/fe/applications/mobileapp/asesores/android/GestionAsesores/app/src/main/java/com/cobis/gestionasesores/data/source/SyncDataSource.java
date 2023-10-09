package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.models.responses.ParameterResponse;

import java.util.List;

/**
 * Created by mnaunay on 15/08/2017.
 */
public interface SyncDataSource {
    boolean saveSyncItem(SyncItem item);
    List<SyncItem> downloadSyncItems(String userName) throws Exception;
    boolean doIndividualCreditAppSync(SyncItem item);
    boolean doGroupCreditSync(SyncItem item);
    boolean doGroupSync(SyncItem item);
    boolean doCustomerSync(SyncItem item);
    ParameterResponse getParametersApp();
}
