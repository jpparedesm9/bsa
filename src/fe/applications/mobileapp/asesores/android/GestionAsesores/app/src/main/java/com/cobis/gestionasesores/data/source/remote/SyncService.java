package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.responses.CustomerResponse;
import com.cobis.gestionasesores.data.models.responses.GroupCreditResponse;
import com.cobis.gestionasesores.data.models.responses.GroupResponse;
import com.cobis.gestionasesores.data.models.responses.IndividualCreditResponse;
import com.cobis.gestionasesores.data.models.responses.SolidarityPaymentResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationGroupResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationIndividualResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import okhttp3.Response;

public class SyncService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis-cloud/mobile/synchronize/getEntitiesData/";
    private static final String METHOD_SOLIDARY_PAYMENT = "pagoSolidario";
    private static final String METHOD_GROUP_VERIFICATION = "verificacionGrupal";
    private static final String METHOD_INDIVIDUAL_VERIFICATION = "verificacion";
    private static final String METHOD_GROUP_CREDIT = "creditoGrupal";
    private static final String METHOD_INDIVIDUAL_APP = "creditoIndividual";
    private static final String METHOD_GROUP = "grupo";
    private static final String METHOD_CUSTOMER = "cliente";

    private static final String PARAM_PAGE = "page";
    private static final String PARAM_ROWS_PER_PAGE = "per_page";
    private static final int ITEMS_COUNT_PER_PAGE = 10;


    public SyncService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    public SolidarityPaymentResponse getSolidarityPayment(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_SOLIDARY_PAYMENT, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), SolidarityPaymentResponse.class);
    }

    public VerificationGroupResponse getGroupVerification(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_GROUP_VERIFICATION, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), VerificationGroupResponse.class);
    }

    public VerificationIndividualResponse getIndividualVerification(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_INDIVIDUAL_VERIFICATION, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), VerificationIndividualResponse.class);
    }

    public IndividualCreditResponse getIndividualCreditApp(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_INDIVIDUAL_APP, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), IndividualCreditResponse.class);
    }

    public GroupCreditResponse getGroupCredit(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_GROUP_CREDIT, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), GroupCreditResponse.class);
    }

    public GroupResponse getGroup(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_GROUP, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), GroupResponse.class);
    }

    public CustomerResponse getCustomer(int syncId, int page) throws IOException {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put(PARAM_PAGE, page);
        parameters.put(PARAM_ROWS_PER_PAGE, ITEMS_COUNT_PER_PAGE);
        Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(syncId)}, parameters);
        return GsonHelper.getGson().fromJson(response.body().string(), CustomerResponse.class);
    }

    public static int getNumberOfPages(int totalItemsCount) {
        return (int) Math.ceil((float) totalItemsCount / (float) ITEMS_COUNT_PER_PAGE);
    }
}