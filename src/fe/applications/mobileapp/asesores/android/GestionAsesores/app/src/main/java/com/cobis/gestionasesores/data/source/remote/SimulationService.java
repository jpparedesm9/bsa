package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.SimulateRequest;
import com.cobis.gestionasesores.data.models.responses.SimulationResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONObject;

import okhttp3.Response;

/**
 * Created by JosueOrtiz on 09/08/2017.
 */

public class SimulationService extends ServiceBase {

    private static final String RESOURCE = "resources/cobis-cloud/mobile/loan/";
    private static final String METHOD_SIMULATE = "simulation";

    public  SimulationService(){
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE );
    }

    public SimulationResponse simulate(SimulateRequest request) throws Exception {
        Response response = post(METHOD_SIMULATE, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optJSONObject("data").optString("simulation"),SimulationResponse.class);
    }
}
