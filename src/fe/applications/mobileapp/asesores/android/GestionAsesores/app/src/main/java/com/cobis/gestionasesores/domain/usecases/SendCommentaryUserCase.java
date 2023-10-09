package com.cobis.gestionasesores.domain.usecases;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.Html;

import com.bayteq.libcore.io.FileUtils;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.TraceReport;
import com.cobis.gestionasesores.domain.businesslogic.TraceOperation;

import java.io.File;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

import static com.bayteq.libcore.LibCore.getApplicationContext;

/**
 * Created by JosueOrtiz on 14/08/2017.
 */

public class SendCommentaryUserCase extends UseCase<TraceReport, Boolean> {
    private final Context mContext;

    public SendCommentaryUserCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mContext = getApplicationContext();
    }

    @Override
    protected Observable<Boolean> createObservableUseCase(final TraceReport parameter) {
        return Observable.fromCallable(new Callable<Boolean>() {
            @Override
            public Boolean call() throws Exception {
                boolean response = true;
                TraceOperation traceOperation = new TraceOperation();
                String file = traceOperation.zipFiles(mContext.getResources().getString(R.string.comments_file_password));
                if (StringUtils.isNotEmpty(file)) {
                    if (traceOperation.send(parameter, file)) {
                        FileUtils.delete(file);
                    } else {
                        sendIntent(parameter, file);
                    }
                } else {
                    response = false;
                }
                return response;
            }
        });
    }

    private void sendIntent(TraceReport traceReport, String attachFile) {
        Intent intent = new Intent(Intent.ACTION_SEND, Uri.parse("mailto:"));
        intent.setType("text/html; charset=utf-8");
        intent.putExtra(Intent.EXTRA_EMAIL, traceReport.getTo());
        intent.putExtra(Intent.EXTRA_SUBJECT, traceReport.getSubject());
        intent.putExtra(Intent.EXTRA_BCC, traceReport.getBcc());
        intent.putExtra(Intent.EXTRA_TEXT, Html.fromHtml((String) traceReport.getData().get(TraceReport.TraceData.COMMENT)));
        intent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(new File(attachFile)));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        try {
            mContext.startActivity(Intent.createChooser(intent, mContext.getString(R.string.comments_send_comments)));
        } catch (Exception ex) {
            Log.e("SendCommentaryUserCase::sendIntent: ", ex);
        }
    }
}