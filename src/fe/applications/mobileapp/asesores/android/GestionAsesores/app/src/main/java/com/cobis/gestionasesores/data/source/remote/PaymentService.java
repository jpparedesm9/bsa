package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.PaymentRequest;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONException;

import java.io.IOException;

import okhttp3.Response;

/**
 * Created by mnaunay on 21/08/2017.
 */

public class PaymentService extends  ServiceBase{
    private static final String RESOURCE = "resources/cobis-cloud/mobile/";
    private static final String METHOD_SOLIDARITY = "solidarityPayment";

    public PaymentService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint()+RESOURCE);
    }

    public GenericResponse payment(PaymentRequest request) throws IOException, JSONException {
        Response response =  post(METHOD_SOLIDARITY, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(response.body().string(),GenericResponse.class);
    }
}