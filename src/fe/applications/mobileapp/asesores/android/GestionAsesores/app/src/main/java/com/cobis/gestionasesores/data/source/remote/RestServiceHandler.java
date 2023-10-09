package com.cobis.gestionasesores.data.source.remote;

import android.net.Uri;
import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;

import org.json.JSONException;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Created by bqtdesa02 on 7/10/2017.
 * Base class used to implement web service consumption
 */

public abstract class RestServiceHandler {
    private static final int PEAK_BYTE_COUNT = 4096;
    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private static final MediaType URL_ENCODED = MediaType.parse("application/x-www-form-urlencoded; charset=utf-8");
    private static final MediaType MEDIA_TYPE_JPG = MediaType.parse("image/jpeg");

    private String mUrl;

    public RestServiceHandler(@NonNull String url) {
        mUrl = url;
    }

    protected Response get(String[] methodPath, Map<String, Object> parameters) throws IOException {
        Request request = new Request.Builder()
                .url(buildUrl(mUrl, methodPath, parameters))
                .get()
                .build();
        printRequestLogs(request.method(), request.url().toString(), parameters, null);
        return doRequest(request);
    }

    protected Response put(String methodPath, @NonNull String jsonParameters) throws IOException, JSONException {
        return put(new String[]{methodPath}, jsonParameters);
    }

    protected Response put(String[] methodPath, @NonNull String jsonParameters) throws IOException, JSONException {
        Request request = new Request.Builder()
                .url(buildUrl(mUrl, methodPath, null))
                .put(RequestBody.create(JSON, jsonParameters))
                .build();
        printRequestLogs(request.method(), request.url().toString(), null, jsonParameters);
        return doRequest(request);
    }

    protected Response post(String methodPath, @NonNull String jsonParameters) throws IOException, JSONException {
        return post(new String[]{methodPath}, jsonParameters);
    }

    protected Response post(String[] methodPath, @NonNull String jsonParameters) throws IOException {
        Request request = new Request.Builder()
                .url(buildUrl(mUrl, methodPath, null))
                .post(RequestBody.create(JSON, jsonParameters))
                .build();
        printRequestLogs(request.method(), request.url().toString(), null, jsonParameters);
        return doRequest(request);
    }

    protected Response postUrlEncoded(String[] methodPath, @NonNull Map<String, Object> parameters) throws IOException {

        StringBuilder bodyBuilder = new StringBuilder();

        int i = 0;
        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            bodyBuilder.append(entry.getKey());
            bodyBuilder.append("=");
            bodyBuilder.append(entry.getValue());
            if (i < parameters.size() - 1) {
                bodyBuilder.append("&");
            }
            i++;
        }

        Request request = new Request.Builder()
                .url(buildUrl(mUrl, methodPath, null))
                .post(RequestBody.create(URL_ENCODED, bodyBuilder.toString()))
                .build();
        printRequestLogs(request.method(), request.url().toString(), parameters, null);
        return doRequest(request);
    }

    protected Response postMultipart(String methodPath, String imageName, String filePath, Map<String, Object> parameters) throws IOException {
        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder.setType(MultipartBody.FORM);
        builder.addFormDataPart("filename", imageName, RequestBody.create(MEDIA_TYPE_JPG, new File(filePath)));

        Request request = new Request.Builder()
                .url(buildUrl(mUrl, new String[]{methodPath}, parameters))
                .post(builder.build())
                .build();
        printRequestLogs(request.method(), request.url().toString(), parameters, null);
        return doRequest(request);
    }

    protected Response delete(String[] methodPath) throws IOException {
        Request request = new Request.Builder()
                .url(buildUrl(mUrl, methodPath, null))
                .delete()
                .build();
        printRequestLogs(request.method(), request.url().toString(), null, null);
        return doRequest(request);
    }

    private void printRequestLogs(String method, String url, Map<String, Object> parameters, String jsonParameters) {
        Log.d("Request -> Method: " + method);
        Log.d("Request -> Url: " + url);
        if (parameters != null && !parameters.isEmpty()) {
            Log.d("Request -> Parameters: " + getBodyLog(parameters));
        }
        if (jsonParameters != null && !jsonParameters.isEmpty()) {
            Log.d("Request -> Json Parameters: " + jsonParameters);
        }
    }

    private Response doRequest(Request request) throws IOException {
        Response response = getOkHttpClient().newCall(request).execute();
        Headers headers = response.request().headers();
        if (headers != null && headers.size() > 0) {
            Log.d("Request -> Headers: " + headers.toString());
        }
        if (request.body() != null && request.body().contentLength() > 0) {
            Log.d("Request -> ContentType: " + request.body().contentType().toString());
        }
        Log.d("Request time: " + (response.receivedResponseAtMillis() - response.sentRequestAtMillis()));
        Log.d("Response -> Code: " + response.code());
        Log.d("Response -> Message: " + response.message());
        Log.d("Response -> Content Length: " + response.body().contentLength());
        Log.d("Response -> Body: " + response.peekBody(PEAK_BYTE_COUNT).string());

        return response;
    }

    private String getBodyLog(Map<String, Object> parameters) {
        if (parameters == null) return "";
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("\n");
        for (String key : parameters.keySet()) {
            Object value = parameters.get(key);
            stringBuilder.append(key)
                    .append(":")
                    .append(value == null ? "" : String.valueOf(value))
                    .append("\n");
        }
        return stringBuilder.toString();
    }

    private String buildUrl(String url, @NonNull String[] methodPaths, Map<String, Object> parameters) {
        Uri urlUri = Uri.parse(url);
        Uri.Builder uriBuilder = urlUri.buildUpon();

        for (String methodPath : methodPaths) {
            uriBuilder.appendPath(methodPath);
        }

        if (parameters != null) {
            for (String key : parameters.keySet()) {
                Object value = parameters.get(key);
                uriBuilder.appendQueryParameter(key, value == null ? "" : String.valueOf(value));
            }
        }
        return uriBuilder.build().toString();
    }

    protected abstract OkHttpClient getOkHttpClient();

}
