package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.data.models.Attachment;
import com.cobis.gestionasesores.data.models.TraceReport;

import java.io.File;
import java.io.FileInputStream;

import de.idyl.winzipaes.AesZipFileEncrypter;
import de.idyl.winzipaes.impl.AESEncrypter;
import de.idyl.winzipaes.impl.AESEncrypterBC;

/**
 * Created by mnaunay on 19/08/2017.
 */

public final class TraceOperation {
    public String zipFiles(String password) {
        String zipName = "";
        try {
            zipName = LibCoreIO.getCacheDirectory() + File.separator + String.format("Log_%s%s", System.currentTimeMillis(), Constants.LOG_TRACE_EXTENSION);
            File filesListInDir = new File(LibCoreIO.getLogDirectory());
            AESEncrypter aesEncrypter = new AESEncrypterBC();
            aesEncrypter.init(password, 0);
            AesZipFileEncrypter ze = new AesZipFileEncrypter(zipName, aesEncrypter);

            for (File file : filesListInDir.listFiles()) {
                if (file.getName().endsWith(".log")) {
                    ze.add(file.getName(), new FileInputStream(file.getAbsolutePath()), password);
                }
            }
            ze.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return zipName;
    }

    public boolean send(TraceReport traceReport, String attachFile) {
        boolean response = true;
        Attachment attachment = new Attachment(attachFile);
        String content = (String) traceReport.getData().get(TraceReport.TraceData.COMMENT);
        MailSender mailer = new MailSender(traceReport.getAccount(),
                traceReport.getAccountPassword(),
                traceReport.getFrom(),
                traceReport.getTo(),
                traceReport.getSubject(),
                "",
                content,
                attachment);
        mailer.setBccList(traceReport.getBcc());
        try {
            mailer.send();
            Log.i("Send programmatically success");
        } catch (Exception ex) {
            Log.e("SendCommentaryUserCase::send: ", ex);
            response = false;
        }
        return response;
    }
}
