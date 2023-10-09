package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.SynItemStateRequest;
import com.cobis.gestionasesores.data.models.requests.SyncItemRequest;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.SyncItemResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONException;

import java.io.IOException;

import okhttp3.Response;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncItemService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis-cloud/mobile/synchronize";
    private static final String METHOD_GET_DATA = "getDataToSynchronize";
    private static final String METHOD_UPDATE_STATE = "updateDataToSynchronize";

    public SyncItemService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint()+RESOURCE);
    }

    public SyncItemResponse getSyncItems(SyncItemRequest request) throws Exception {
        Response response = put(METHOD_GET_DATA, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(response.body().string(),SyncItemResponse.class);
    }

    public GenericResponse updateStatus(SynItemStateRequest request) throws IOException, JSONException {
        Response response = put(METHOD_UPDATE_STATE, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(response.body().string(),GenericResponse.class);
    }
}