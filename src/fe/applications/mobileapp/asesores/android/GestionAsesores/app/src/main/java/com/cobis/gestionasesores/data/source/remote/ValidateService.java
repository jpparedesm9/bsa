package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.ValidatePersonRequest;
import com.cobis.gestionasesores.data.models.responses.BuroResponse;
import com.cobis.gestionasesores.data.models.responses.CustomerCoreInfo;
import com.cobis.gestionasesores.data.models.responses.ValidateResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONObject;

import okhttp3.Response;

/**
 * TODO: MNA --> This service have to merge with PersonService when Cobis normalize the EndPoint for all services
 * Created by mnaunay on 14/07/2017.
 */
public class ValidateService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis/web/OrchestrationClientValidationServiceRest";
    private static final String METHOD_VALIDATE_SANTANDER = "validateSantander";
    private static final String METHOD_VALIDATE_BURO = "validateBuro";

    public ValidateService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    public ValidateResponse isValidProspect(ValidatePersonRequest request) throws Exception {
        Response response = put(METHOD_VALIDATE_BURO, GsonHelper.getGson().toJson(request));
        if (response.code() != 200) {
            throw new RuntimeException("ValidateService::isValidPerson: Error in service invocation with code: " + response.code());
        }

        String data = response.body().string();
        ValidateResponse result = GsonHelper.getGson().fromJson(data, ValidateResponse.class);
        if (result.isResult()) {
            result.setBuroResponse(GsonHelper.getGson().fromJson(new JSONObject(data).getJSONObject("data").getString("buroResponse"), BuroResponse.class));
        }
        return result;
    }

    public ValidateResponse getCustomerInfo(ValidatePersonRequest request) throws Exception {
        Response response = put(METHOD_VALIDATE_SANTANDER, GsonHelper.getGson().toJson(request));
        if (response.code() != 200) {
            throw new RuntimeException("ValidateService::isValidPerson: Error in service invocation with code: " + response.code());
        }

        String data = response.body().string();
        ValidateResponse result = GsonHelper.getGson().fromJson(data, ValidateResponse.class);
        if (result.isResult()) {
            result.setCustomerCoreInfo(GsonHelper.getGson().fromJson(new JSONObject(data).getJSONObject("data").getString("customerCoreInfo"), CustomerCoreInfo.class));
        }
        return result;
    }
}
