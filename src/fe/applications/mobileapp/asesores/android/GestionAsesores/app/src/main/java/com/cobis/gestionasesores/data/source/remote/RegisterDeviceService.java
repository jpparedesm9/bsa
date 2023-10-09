package com.cobis.gestionasesores.data.source.remote;


import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.RegisterDeviceRequest;
import com.cobis.gestionasesores.data.models.responses.RegisterDeviceResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import okhttp3.Response;

/**
 * Created by jescudero on 8/19/2017.
 */

public class RegisterDeviceService extends ServiceBase {

    private static final String RESOURCE = "resources/cobis-cloud/mobile/deviceregistration";
    private static final String METHOD_LINK_USER = "register";

    public RegisterDeviceResponse linkUser(RegisterDeviceRequest request) throws Exception{
        Response response = put(METHOD_LINK_USER, GsonHelper.getGson().toJson(request));
        if (response.code() != 200) {
            throw new RuntimeException("AuthService::login: Error in service invocation with code: " + response.code());
        }
        String body = response.body().string();
        return GsonHelper.getGson().fromJson(body, RegisterDeviceResponse.class);
    }

    public RegisterDeviceService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint()+RESOURCE);
    }

}
