package com.cobis.gestionasesores.domain.businesslogic;

import android.os.SystemClock;
import android.support.annotation.RawRes;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.io.FileUtils;
import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.VersionConcept;
import com.cobis.gestionasesores.data.models.responses.ParameterResponse;
import com.cobis.gestionasesores.data.repositories.SyncRepository;
import com.cobis.gestionasesores.data.repositories.VersionRepository;
import com.cobis.gestionasesores.data.source.local.PersistenceCatalog;
import com.cobis.gestionasesores.data.source.local.PersistencePostalCode;
import com.cobis.gestionasesores.utils.Util;

import java.io.File;

/**
 * Created by Miguel on 18/06/2017.
 */

public class InitManager {
    @RawRes
    private int mCatalogsResource;
    @RawRes
    private int mPostalCodeResource;

    public InitManager(int catalogsResource, int postalCodeResource) {
        this.mCatalogsResource = catalogsResource;
        this.mPostalCodeResource = postalCodeResource;
    }

    public boolean checkCatalogsUpdate() {
        boolean updated = false;
        if (needCatalogUpdate()) {
            if (initCatalogs(mCatalogsResource)) {
                VersionRepository.getInstance().updateVersion(VersionConcept.CATALOGS,  BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.VERSION_CATALOGS));
                updated = true;
            } else {
                Log.e("Error initialized catalogs");
            }
        } else {
            updated = true;
        }
        return updated;
    }

    public boolean checkPostalCodesUpdate() {
        boolean updated = false;
        if (needPostalCodeUpdate()) {
            if (initPostalCode(mPostalCodeResource)) {
                VersionRepository.getInstance().updateVersion(VersionConcept.POSTAL_CODES, BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.VERSION_POSTAL_CODES));
                updated = true;
            } else {
                Log.e("Error initialized postal codes");
            }
        } else {
            updated = true;
        }
        return updated;
    }

    public static boolean needPostalCodeUpdate() {
        int newVersion = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.VERSION_POSTAL_CODES);
        int dbVersion = VersionRepository.getInstance().getVersion(VersionConcept.POSTAL_CODES);
        Log.d("Postal Codes: local version: " + dbVersion + " new version: " + newVersion);
        return newVersion > dbVersion;
    }

    public static boolean needCatalogUpdate() {
        int newVersion = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.VERSION_CATALOGS);
        int dbVersion = VersionRepository.getInstance().getVersion(VersionConcept.CATALOGS);
        Log.d("Catalogs: local version: " + dbVersion + " newVersion: " + newVersion);
        return newVersion > dbVersion;
    }

    private boolean initCatalogs(@RawRes int catalogs) {
        long startTime = SystemClock.currentThreadTimeMillis();
        PersistenceCatalog persistence = null;
        boolean result = false;
        try {
            //1. read raw sql
            persistence = new PersistenceCatalog();
            persistence.beginTransaction();
            persistence.deleteRows();
            String[] data = StringUtils.readRawTextFile(catalogs).split(";");
            for (String sql : data) {
                if (sql.trim().length() > 0) {
                    persistence.execute(sql);
                }
            }
            persistence.commitTransaction();
            result = true;
            Log.d("Catalogs rows : " + persistence.count() + " in " + (SystemClock.currentThreadTimeMillis() - startTime) + "ms");

        } catch (Exception ex) {
            Log.e("Catalog error block: ", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    private boolean initPostalCode(@RawRes int postalCodeZip) {
        long startTime = SystemClock.currentThreadTimeMillis();
        boolean result = false;
        String tmpPath = LibCoreIO.getAppDirectory() + "/tmp";
        PersistencePostalCode persistence = null;
        try {
            FileUtils.createDirectory(tmpPath);
            File dir = new File(tmpPath);
            Util.unzip(LibCore.getApplicationContext().getResources().openRawResource(postalCodeZip), dir);
            if (!FileUtils.isDirectoryEmpty(tmpPath)) {
                persistence = new PersistencePostalCode();
                persistence.beginTransaction();
                persistence.recreate();

                File[] files = dir.listFiles();
                for (int i = 0; i < files.length; ++i) {
                    String[] data = new String(FileUtils.read(files[i].getAbsolutePath()), "UTF-8").split(";");
                    for (String sql : data) {
                        if (sql.trim().length() > 0) {
                            persistence.execute(sql);
                        }
                    }
                }

                persistence.commitTransaction();
                result = true;
            } else {
                Log.w("Postal code zip is empty!!");
            }
            Log.d("Postal Count : " + persistence.count() + " in " + (SystemClock.currentThreadTimeMillis() - startTime) + "ms");
        } catch (Exception ex) {
            Log.e("Postal Code Error block: ", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
            FileUtils.deleteDirectory(tmpPath);
        }
        return result;
    }

    public ParameterResponse getParametersApp() {
        return SyncRepository.getInstance().getParametersApp();
    }
}
