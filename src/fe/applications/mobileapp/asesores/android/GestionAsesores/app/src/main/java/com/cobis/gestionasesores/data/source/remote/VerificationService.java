package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.VerificationRequest;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.Response;

/**
 * Created by mnaunay on 18/08/2017.
 */
public class VerificationService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis-cloud/mobile/";
    private static final String METHOD_VERIFICATION = "verification";
    private static final String METHOD_COMPLETE = "complete";

    public VerificationService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint()+RESOURCE);
    }

    public VerificationResponse saveVerification(int processInstance, VerificationRequest request) throws IOException, JSONException {
        Response response = put(new String[]{METHOD_VERIFICATION,String.valueOf(processInstance)}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject("data").optString("verification"),VerificationResponse.class);
    }

    public GenericResponse complete(int processInstance) throws IOException {
        Response response = post(new String[]{METHOD_VERIFICATION,String.valueOf(processInstance),METHOD_COMPLETE}, "");
        return GsonHelper.getGson().fromJson(response.body().string(),GenericResponse.class);
    }
}