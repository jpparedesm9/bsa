package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.GroupRequest;
import com.cobis.gestionasesores.data.models.requests.MemberInfo;
import com.cobis.gestionasesores.data.models.requests.MemberRequest;
import com.cobis.gestionasesores.data.models.responses.GroupRemote;
import com.cobis.gestionasesores.data.models.responses.MemberResponse;
import com.cobis.gestionasesores.data.models.responses.SaveGroupResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import org.json.JSONObject;

import okhttp3.Response;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class GroupService extends ServiceBase {

    private static final String RESOURCE = "resources/cobis-cloud/mobile/";
    private static final String METHOD_GROUP = "group";
    private static final String METHOD_MEMBER = "member";

    private static final String PARAM_DATA = "data";
    private static final String PARAM_MEMBER = "member";
    private static final String PARAM_RELATIONS = "relations";
    private static final String PARAM_GROUP = "group";

    public GroupService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    //*******************************************GROUP********************************************/

    public GroupRemote getGroup(int groupId) throws Exception {
        Response response = get(new String[]{METHOD_GROUP, String.valueOf(groupId)}, null);
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString(PARAM_DATA), GroupRemote.class);
    }

    public SaveGroupResponse createGroup(GroupRequest request) throws Exception {
        Response response = post(METHOD_GROUP, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject(PARAM_DATA).optString(PARAM_GROUP), SaveGroupResponse.class);
    }

    public SaveGroupResponse updateGroup(GroupRequest request) throws Exception {
        Response response = put(METHOD_GROUP, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject(PARAM_DATA).optString(PARAM_GROUP), SaveGroupResponse.class);
    }

    //*******************************************MEMBERS********************************************/

    public MemberInfo getMember(int groupId, int memberId) throws Exception {
        Response response = get(new String[]{METHOD_GROUP, String.valueOf(groupId), METHOD_MEMBER, String.valueOf(memberId)}, null);
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject(PARAM_DATA).optString(PARAM_MEMBER), MemberInfo.class);
    }

    public MemberResponse createMember(int groupId, MemberRequest request) throws Exception {
        Response response = post(new String[]{METHOD_GROUP, String.valueOf(groupId), METHOD_MEMBER}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject(PARAM_DATA).optString(PARAM_MEMBER), MemberResponse.class);
    }

    public MemberResponse updateMember(int groupId, MemberRequest request) throws Exception {
        Response response = put(new String[]{METHOD_GROUP, String.valueOf(groupId), METHOD_MEMBER}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject(PARAM_DATA).optString(PARAM_MEMBER), MemberResponse.class);
    }

    public MemberResponse deleteMember(int groupId, int memberId) throws Exception {
        Response response = delete(new String[]{METHOD_GROUP, String.valueOf(groupId), METHOD_MEMBER, String.valueOf(memberId)});
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString(PARAM_DATA), MemberResponse.class);
    }
}
