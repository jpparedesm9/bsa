package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.responses.ParameterResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import java.io.IOException;

import okhttp3.Response;

public class ParameterService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis-cloud/mobile/";
    private static final String METHOD_PARAMETERS = "parameters";

    public ParameterService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    public ParameterResponse getParameters() throws IOException {
        Response response = get(new String[]{METHOD_PARAMETERS}, null);
        return GsonHelper.getGson().fromJson(response.body().string(), ParameterResponse.class);
    }
}