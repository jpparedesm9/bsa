package com.cobis.gestionasesores.data.source.remote;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.utils.DateUtils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import okhttp3.Response;
import okio.BufferedSink;
import okio.Okio;

public class DocumentService extends ServiceBase {
    private static final String RESOURCE = "cobis/web/customer/";

    private static final String METHOD_UPLOAD = "UploadFileServlet";
    private static final String METHOD_DOWNLOAD = "GetFileServlet";

    public DocumentService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint() + RESOURCE);
    }

    public boolean upload(int customerId, Document document) throws IOException {
        Map<String, Object> params = new HashMap<>();
        params.put("transactionType", 1);
        params.put("capturedDocumentType", document.getType());
        params.put("customerId", customerId);
        params.put("captureDate", DateUtils.formatDateForService(document.getCaptureDate()));
        Response response = postMultipart(METHOD_UPLOAD, String.format("%s.jpeg", document.getType()), document.getImage(), params);
        return response.code() == 200 && response.message().equals("OK");
    }

    public String download(int customerId, String type, String extension, String resultPath) throws IOException {
        Map<String, Object> params = new HashMap<>();
        params.put("fileName", String.format("%1$s.%2$s", type, extension));
        params.put("customerId", customerId);
        Response response = postUrlEncoded(new String[]{METHOD_DOWNLOAD}, params);
        BufferedSink sink = null;
        if (response.code() == 200) {
            try {
                final File downloadedFile = new File(resultPath);
                sink = Okio.buffer(Okio.sink(downloadedFile));
                sink.writeAll(response.body().source());
            } finally {
                if (sink != null) {
                    sink.close();
                }
            }
        }
        return resultPath;
    }
}
