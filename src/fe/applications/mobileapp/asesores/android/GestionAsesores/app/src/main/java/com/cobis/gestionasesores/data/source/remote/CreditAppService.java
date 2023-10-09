package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.GroupCreditInfo;
import com.cobis.gestionasesores.data.models.requests.IndividualRequest;
import com.cobis.gestionasesores.data.models.requests.ValidGroupRemote;
import com.cobis.gestionasesores.data.models.responses.CreditResponse;
import com.cobis.gestionasesores.data.models.responses.ValidGroupResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONObject;

import java.util.List;

import okhttp3.Response;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class CreditAppService extends ServiceBase {
    //Group
    private static final String RESOURCE = "resources/cobis-cloud/mobile/creditapplication/";

    //Individual
    private static final String METHOD_INDIVIDUAL = "individual";

    private static final String METHOD_VALIDATE_GROUPS = "validateGroups";
    private static final String METHOD_GET_GROUP_CREDIT = "readCreditApplication";

    public CreditAppService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    public GroupCreditInfo getGroupCreditApp(int applicationId) throws Exception {
        Response response = get(new String[]{String.valueOf(applicationId), METHOD_GET_GROUP_CREDIT}, null);
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), GroupCreditInfo.class);
    }

    public CreditResponse saveGroupCreditApp(GroupCreditInfo request) throws Exception {
        Response response = post("", GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), CreditResponse.class);
    }

    public CreditResponse updateGroupCreditApp(int applicationId, GroupCreditInfo request) throws Exception {
        Response response = put(new String[]{"", String.valueOf(applicationId)}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), CreditResponse.class);
    }

    public ValidGroupResponse getValidGroups(List<ValidGroupRemote> request) throws Exception {
        Response response = post(METHOD_VALIDATE_GROUPS, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(response.body().string(), ValidGroupResponse.class);
    }

    //Individual Responses. Group Model and Individual are identical
    public CreditResponse saveIndividualCreditApp(IndividualRequest request) throws Exception {
        Response response = post(METHOD_INDIVIDUAL, GsonHelper.getGson().toJson(request));
        String body = response.body().string();
        return GsonHelper.getGson().fromJson(new JSONObject(body).optString("data"), CreditResponse.class);

    }

    public CreditResponse updateIndividualCreditApp(int applicationId, IndividualRequest request) throws Exception {
        Response response = put(new String[]{METHOD_INDIVIDUAL, String.valueOf(applicationId)}, GsonHelper.getGson().toJson(request));
        String body = response.body().string();
        return GsonHelper.getGson().fromJson(new JSONObject(body).optString("data"), CreditResponse.class);

    }
}
