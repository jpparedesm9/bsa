package com.cobis.gestionasesores.data.source.remote;

import android.support.annotation.Nullable;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRemote;
import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRequest;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.CustomerBusinessRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerDataRequest;
import com.cobis.gestionasesores.data.models.requests.CustomerReferencesRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerDataRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkRemote;
import com.cobis.gestionasesores.data.models.requests.PaymentCapacityRequest;
import com.cobis.gestionasesores.data.models.requests.ProspectRequest;
import com.cobis.gestionasesores.data.models.requests.ReferenceRequest;
import com.cobis.gestionasesores.data.models.responses.CustomerDataResponse;
import com.cobis.gestionasesores.data.models.responses.CustomerWorkResponse;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.PartnerDataResponse;
import com.cobis.gestionasesores.data.models.responses.PartnerWorkResponse;
import com.cobis.gestionasesores.data.models.responses.PaymentCapacityResponse;
import com.cobis.gestionasesores.data.models.responses.ProspectResponse;
import com.cobis.gestionasesores.data.models.responses.ReferenceResponse;
import com.cobis.gestionasesores.data.models.responses.SaveCustomerAddressResponse;
import com.cobis.gestionasesores.data.models.responses.SaveCustomerDataResponse;
import com.cobis.gestionasesores.data.models.responses.SaveProspectResponse;
import com.cobis.gestionasesores.data.models.responses.ServiceResponse;
import com.cobis.gestionasesores.utils.GsonHelper;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import org.json.JSONObject;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import okhttp3.Response;

/**
 * Created by bqtdesa02 on 7/10/2017.
 */

public class PersonService extends ServiceBase {
    private static final String RESOURCE = "resources/cobis-cloud/mobile/";
    private static final String METHOD_PROSPECT = "prospect";
    private static final String METHOD_CUSTOMER = "client";
    private static final String METHOD_ADDRESS = "address";
    private static final String METHOD_WORK = "business";
    private static final String METHOD_PARTNER = "spouse";
    private static final String METHOD_REFERENCE = "reference";
    private static final String METHOD_PAYMENT_CAPACITY = "paymentCapacity";
    private static final String METHOD_COMPLEMENTARY = "complementaryData";

    private static final String PARAM_EMAIL = "emailAddressId";
    private static final String PARAM_PHONE = "phoneId";
    private static final String PARAM_WORK_PHONE = "workphoneId";
    private static final String PARAM_CELLPHONE = "cellphoneId";

    public PersonService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    /**************************************PROSPECT DATA ******************************************/

    @Nullable
    public ProspectResponse getProspectData(int prospectId) {
        try {
            Response response = get(new String[]{METHOD_PROSPECT, String.valueOf(prospectId)}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), ProspectResponse.class);
        } catch (Exception ex) {
            Log.e("PersonService:getProspectData Error! ", ex);
            return null;
        }
    }

    public SaveProspectResponse createProspectData(ProspectRequest prospectRequest) throws Exception {
        Response response = post(METHOD_PROSPECT, GsonHelper.getGson().toJson(prospectRequest));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveProspectResponse.class);
    }

    public SaveProspectResponse updateProspectData(ProspectRequest prospectRequest) throws Exception {
        Response response = put(METHOD_PROSPECT, GsonHelper.getGson().toJson(prospectRequest));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveProspectResponse.class);
    }

    /**************************************CUSTOMER DATA*******************************************/

    public CustomerDataResponse getCustomerData(int customerId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId)}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), CustomerDataResponse.class);
        } catch (Exception ex) {
            Log.e("PersonService:getCustomerData Error! ", ex);
            return null;
        }
    }

    public SaveCustomerDataResponse createCustomerData(CustomerDataRequest request) throws Exception {
        Response response = post(METHOD_CUSTOMER, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveCustomerDataResponse.class);
    }

    public SaveCustomerDataResponse updateCustomerData(CustomerDataRequest request) throws Exception {
        Response response = put(METHOD_CUSTOMER, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveCustomerDataResponse.class);
    }

    /**************************************CUSTOMER ADDRESS****************************************/

    public CustomerAddressRequest getCustomerAddress(int customerId, int addressId, int emailAddressId, int phoneId, int cellphoneId) throws Exception {
        try {
            Map<String, Object> parameters = new HashMap<>();
            parameters.put(PARAM_EMAIL, emailAddressId);
            parameters.put(PARAM_PHONE, phoneId);
            parameters.put(PARAM_CELLPHONE, cellphoneId);
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_ADDRESS, String.valueOf(addressId)}, parameters);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), CustomerAddressRequest.class);
        } catch (Exception ex) {
            Log.e("PersonService:buildCustomerAddress Error! ", ex);
            return null;
        }
    }

    public SaveCustomerAddressResponse createCustomerAddress(int customerId, CustomerAddressRequest request) throws Exception {
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_ADDRESS}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveCustomerAddressResponse.class);
    }

    public SaveCustomerAddressResponse updateCustomerAddress(int customerId, CustomerAddressRequest request) throws Exception {
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_ADDRESS}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), SaveCustomerAddressResponse.class);
    }

    /**************************************CUSTOMER WORK*******************************************/

    public CustomerBusinessRemote getCustomerWork(int customerId, int workId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_WORK, String.valueOf(workId)}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), CustomerBusinessRemote.class);
        } catch (Exception ex) {
            Log.e("PersonService:getCustomerWork Error! ", ex);
            return null;
        }
    }

    public ServiceResponse<CustomerWorkResponse> createCustomerWork(int customerId, CustomerBusinessRemote request) throws Exception {
        GsonBuilder gsonRequest = new GsonBuilder();
        gsonRequest.setExclusionStrategies(new ExcludeNumberOFResidents());
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_WORK}, gsonRequest.create().toJson(request));
        Type type = new TypeToken<ServiceResponse<CustomerWorkResponse>>() {
        }.getType();
        return GsonHelper.getGson().fromJson(response.body().string(), type);
    }

    public ServiceResponse<CustomerWorkResponse> updateCustomerWork(int customerId, CustomerBusinessRemote request) throws Exception {
        GsonBuilder gsonRequest = new GsonBuilder();
        gsonRequest.setExclusionStrategies(new ExcludeNumberOFResidents());
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_WORK}, gsonRequest.create().toJson(request));
        Type type = new TypeToken<ServiceResponse<CustomerWorkResponse>>() {
        }.getType();
        return GsonHelper.getGson().fromJson(response.body().string(), type);
    }

    /**************************************PARTNER DATA********************************************/

    public PartnerDataRemote getPartnerData(int customerId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), PartnerDataRemote.class);
        } catch (Exception ex) {
            Log.e("PersonService:buildComplementaryData Error! ", ex);
            return null;
        }
    }

    public PartnerDataResponse createPartnerData(int customerId, PartnerDataRemote request) throws Exception {
        GsonBuilder gsonHelper = new GsonBuilder();
        gsonHelper.setExclusionStrategies(new ExcludeCustomerId());
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER}, gsonHelper.create().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), PartnerDataResponse.class);
    }

    public PartnerDataResponse updatePartnerData(int customerId, PartnerDataRemote request) throws Exception {
        GsonBuilder gsonHelper = new GsonBuilder();
        gsonHelper.setExclusionStrategies(new ExcludeCustomerId());
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER}, gsonHelper.create().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), PartnerDataResponse.class);
    }

    /**************************************PARTNER WORK********************************************/

    public PartnerWorkRemote getPartnerWork(int customerId, int addressId, int workPhoneId, int cellphoneId) throws Exception {
        try {
            Map<String, Object> parameters = new HashMap<>();
            parameters.put(PARAM_WORK_PHONE, workPhoneId);
            parameters.put(PARAM_CELLPHONE, cellphoneId);
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER, METHOD_ADDRESS, String.valueOf(addressId)}, parameters);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), PartnerWorkRemote.class);
        } catch (Exception ex) {
            Log.e("PersonService:getPartnerWork Error! ", ex);
            return null;
        }
    }

    public PartnerWorkResponse createPartnerWork(int customerId, PartnerWorkRemote request) throws Exception {
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER, METHOD_ADDRESS}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), PartnerWorkResponse.class);
    }

    public PartnerWorkResponse updatePartnerWork(int customerId, PartnerWorkRemote request) throws Exception {
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PARTNER, METHOD_ADDRESS}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), PartnerWorkResponse.class);
    }

    /**************************************REFERENCES**********************************************/

    public List<CustomerReferencesRemote.ReferenceInfo> getCustomerReferences(int customerId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_REFERENCE}, null);
            Type type = new TypeToken<List<CustomerReferencesRemote.ReferenceInfo>>() {
            }.getType();
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), type);
        } catch (Exception ex) {
            Log.e("PersonService:getCustomerReferences Error! ", ex);
            return null;
        }
    }

    public CustomerReferencesRemote.ReferenceInfo getReference(int customerId, int referenceId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_REFERENCE, String.valueOf(referenceId)}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), CustomerReferencesRemote.ReferenceInfo.class);
        } catch (Exception ex) {
            Log.e("PersonService:getReference Error! ", ex);
            return null;
        }
    }

    public ReferenceResponse createReference(int customerId, ReferenceRequest request) throws Exception {
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_REFERENCE}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject("data").optString("reference"), ReferenceResponse.class);
    }

    public ReferenceResponse updateReference(int customerId, ReferenceRequest request) throws Exception {
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_REFERENCE}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject("data").optString("reference"), ReferenceResponse.class);
    }

    /**************************************SOLIDARITY_PAYMENT CAPACITY****************************************/

    public PaymentCapacityResponse getPaymentCapacity(int customerId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PAYMENT_CAPACITY}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), PaymentCapacityResponse.class);
        } catch (Exception ex) {
            Log.e("PersonService:getPaymentCapacity Error! ", ex);
            return null;
        }
    }

    public GenericResponse createPaymentCapacity(int customerId, PaymentCapacityRequest request) throws Exception {
        Response response = post(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PAYMENT_CAPACITY}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), GenericResponse.class);
    }

    public GenericResponse updatePaymentCapacity(int customerId, PaymentCapacityRequest request) throws Exception {
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_PAYMENT_CAPACITY}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).optString("data"), GenericResponse.class);
    }

    /************************************** COMPLEMENTARY DATA ****************************************/

    public ComplementaryDataRemote getComplementaryData(int customerId) throws Exception {
        try {
            Response response = get(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_COMPLEMENTARY}, null);
            return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getString("data"), ComplementaryDataRemote.class);
        } catch (Exception ex) {
            Log.e("PersonService:getComplementaryData Error! ", ex);
            return null;
        }
    }
    public GenericResponse updateComplementaryData(int customerId, ComplementaryDataRequest request) throws Exception {
        Response response = put(new String[]{METHOD_CUSTOMER, String.valueOf(customerId), METHOD_COMPLEMENTARY}, GsonHelper.getGson().toJson(request));
        return GsonHelper.getGson().fromJson(new JSONObject(response.body().string()).getJSONObject("data").optString("complementary"), GenericResponse.class);
    }

    private static class ExcludeNumberOFResidents implements ExclusionStrategy {

        @Override
        public boolean shouldSkipField(FieldAttributes f) {
            return f.getName().equals("numberOfResidents");
        }

        @Override
        public boolean shouldSkipClass(Class<?> clazz) {
            return false;
        }
    }

    private static class ExcludeCustomerId implements ExclusionStrategy {

        @Override
        public boolean shouldSkipField(FieldAttributes f) {
            return f.getName().equals("customerId");
        }

        @Override
        public boolean shouldSkipClass(Class<?> clazz) {
            return false;
        }
    }
}
