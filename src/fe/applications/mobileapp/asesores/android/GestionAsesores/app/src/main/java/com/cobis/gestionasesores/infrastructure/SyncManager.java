package com.cobis.gestionasesores.infrastructure;

import android.app.IntentService;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.SyncItemStatus;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.repositories.SyncRepository;
import com.cobis.gestionasesores.data.repositories.TaskRepository;
import com.cobis.gestionasesores.domain.businesslogic.SynchronizationOperation;

import java.io.Serializable;
import java.util.List;
import java.util.Locale;

public final class SyncManager {
    private static final long INTERVAL = 1000 * 60;
    private static Boolean isRunning = Boolean.FALSE;
    private static long sLastSyncSuccess = 0;

    /**
     * Intent action for sync status
     * <p>Constant value: com.cobis.gestionasesores.sync.actions.STATUS</p>
     */
    public static final String ACTION_SYNC_STATUS = "com.cobis.gestionasesores.sync.actions.STATUS";
    /**
     * Intent action for sync download
     * <p>Constant value: com.cobis.gestionasesores.sync.actions.DOWNLOAD</p>
     */
    public static final String ACTION_SYNC_DOWN = "com.cobis.gestionasesores.sync.actions.DOWNLOAD";
    /**
     * Intent action for sync upload
     * <p>Constant value: com.cobis.gestionasesores.sync.actions.UPLOAD</p>
     */
    public static final String ACTION_SYNC_UP = "com.cobis.gestionasesores.sync.actions.UPLOAD";
    /**
     * Extra for sync status
     * <p>Constant value: com.cobis.gestionasesores.sync.extras.STATUS</p>
     */
    public static final String EXTRA_STATUS = "com.cobis.gestionasesores.sync.extras.STATUS";
    /**
     * Extra data for sync status
     * <p>Constant value: com.cobis.gestionasesores.sync.extras.STATUS</p>
     */
    public static final String EXTRA_DATA = "com.cobis.gestionasesores.sync.extras.DATA";

    /**
     * Sync started
     * <p>Constant Value: 0</p>
     */
    public static final int SYNC_STARTED = 0;
    /**
     * Sync completed
     * <p>Constant Value: 1</p>
     */
    public static final int SYNC_COMPLETED = 1;
    /**
     * Sync is running
     * <p>Constant Value: 2</p>
     */
    public static final int SYNC_IS_RUNNING = 2;
    /**
     * Sync progress update
     * <p>Constant Value: 3</p>
     */
    public static final int SYNC_PROGRESS_UPDATE = 3;
    /**
     * Sync is not required
     * <p>Constant Value: 4</p>
     */
    public static final int SYNC_NOT_REQUIRED = 4;
    /**
     * Generic sync error
     * <p>Constant Value: 5</p>
     */
    public static final int SYNC_GENERIC_ERROR = 5;
    /**
     * Connection error during sync
     * <p>Constant Value: 6</p>
     */
    public static final int SYNC_CONNECTION_ERROR = 6;
    /**
     * Invalid user id for sync
     * <p>Constant Value: 7</p>
     */
    public static final int SYNC_INVALID_USER = 7;

    /**
     * Error in download item
     */
    public static final int SYNC_ITEM_ERROR = 8;
    /**
     * Default constructor
     */
    private SyncManager() {
    }

    /**
     * Start download synchronization items
     */
    public static void syncDown() {
        synchronized (isRunning) {
            if (!isRunning) {
                if (SessionManager.getInstance().isSessionActive()) {
                    Intent intent = new Intent(LibCore.getApplicationContext(), SyncIntentService.class);
                    intent.setAction(ACTION_SYNC_DOWN);
                    intent.putExtra(SyncIntentService.EXTRA_USERNAME, SessionManager.getInstance().getSession().getUserName());
                    LibCore.getApplicationContext().startService(intent);
                    sendStatus(SYNC_STARTED);
                } else {
                    Log.w("Session is down!");
                    sendStatus(SYNC_INVALID_USER);
                }
            } else {
                sendStatus(SYNC_IS_RUNNING);
            }
        }
    }

    /**
     * Start upload synchronization items
     */
    public static void syncUp(int[] items) {
        synchronized (isRunning) {
            if (!isRunning) {
                Intent intent = new Intent(LibCore.getApplicationContext(), SyncIntentService.class);
                intent.setAction(ACTION_SYNC_UP);
                intent.putExtra(SyncIntentService.EXTRA_ITEMS, items);
                LibCore.getApplicationContext().startService(intent);
                sendStatus(SYNC_STARTED);
            } else {
                sendStatus(SYNC_IS_RUNNING);
            }
        }
    }

    /**
     * Try to start synchronization process only if is possible
     */
    public static void trySync() {
        if (System.currentTimeMillis() - sLastSyncSuccess > INTERVAL) {
            syncDown();
        }
    }

    public static void sendStatus(int status, Serializable data) {
        Intent syncComplete = new Intent(ACTION_SYNC_STATUS);
        syncComplete.putExtra(EXTRA_STATUS, status);
        syncComplete.putExtra(EXTRA_DATA, data);
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).sendBroadcast(syncComplete);
    }

    public static void sendStatus(int status) {
        sendStatus(status, null);
    }

    public static Boolean isRunning() {
        return isRunning;
    }

    public static String getErrorString(int code) {
        switch (code) {
            case SYNC_NOT_REQUIRED:
                return "Sync is not required";
            case SYNC_COMPLETED:
                return "Sync completed";
            case SYNC_GENERIC_ERROR:
                return "Sync error";
            case SYNC_CONNECTION_ERROR:
                return "No internet access";
            case SYNC_INVALID_USER:
                return "Invalid user";
            default:
                return "Unknown";
        }
    }

    public static class SyncIntentService extends IntentService {
        public static final String EXTRA_USERNAME = "com.cobis.gestionasesores.sync.extra.USERNAME";
        public static final String EXTRA_ITEMS = "com.cobis.gestionasesores.sync.extra.ITEMS";

        public SyncIntentService() {
            super("SyncIntentService");
        }

        @Override
        protected void onHandleIntent(Intent intent) {
            isRunning = Boolean.TRUE;
            if(intent != null && intent.getAction() != null) {
                SyncHandler handler = null;
                switch (intent.getAction()) {
                    case ACTION_SYNC_DOWN:
                        handler = new SyncHandler(intent.getAction(), intent.getStringExtra(EXTRA_USERNAME));
                        break;
                    case ACTION_SYNC_UP:
                        handler = new SyncHandler(intent.getAction(), intent.getIntArrayExtra(EXTRA_ITEMS));
                        break;
                }
                sendStatus(handler.start());
            }
            isRunning = Boolean.FALSE;
        }
    }

    static class SyncHandler {
        private int[] items;
        private String username;
        private String action;

        SyncHandler(String action, String username) {
            this.action = action;
            this.username = username;
        }

        SyncHandler(String action, int[] items) {
            this.action = action;
            this.items = items;
        }

        synchronized int start() {
            long starTime = System.currentTimeMillis();
            int result = -1;
            try {
                //0.- Check network access
                if (NetworkUtils.isOnline()) {
                    switch (action) {
                        case ACTION_SYNC_DOWN:
                            Log.d("============INIT DB SYNC============");
                            if (StringUtils.isNotEmpty(username)) {
                                //1.- Gets Sync Items from remote and save local
                                SyncRepository.getInstance().downloadSyncItems(username);
                                //2-- Download sync items data
                                int errorId = downloadSyncItems();
                                if(errorId <= 0) {
                                    //3. Send result OK
                                    sLastSyncSuccess = System.currentTimeMillis();
                                    SessionManager.getInstance().saveLastSyncDown();
                                    result = SYNC_COMPLETED;
                                }else {
                                    sendStatus(SYNC_ITEM_ERROR, errorId);
                                }
                            } else {
                                result = SYNC_INVALID_USER;
                            }
                            Log.d(String.format(Locale.getDefault(), "============END DB SYNC IN (%d ms)============", (System.currentTimeMillis() - starTime)));
                            break;
                        case ACTION_SYNC_UP:
                            new SynchronizationOperation().uploadItems(items);
                            SessionManager.getInstance().saveLastSyncUp();
                            result = SYNC_COMPLETED;
                            break;
                    }
                } else {
                    result = SYNC_CONNECTION_ERROR;
                }
            } catch (Exception ex) {
                Log.e("SyncManager::start: ", ex);
                result = SYNC_GENERIC_ERROR;
            }
            Log.d("Result: " + getErrorString(result));
            return result;
        }

        private int downloadSyncItems() {
            List<SyncItem> syncItems = SyncRepository.getInstance().getSyncItemsByStatus(SyncItemStatus.DOWNLOADED);
            int errorId = 0;
            for (SyncItem item : syncItems) {
                boolean isSuccess;
                long startItem = System.currentTimeMillis();
                switch (item.getType()) {
                    case SyncItemType.COBIS_INDIVIDUAL_CREDIT:
                        isSuccess = SyncRepository.getInstance().doIndividualCreditAppSync(item);
                        break;
                    case SyncItemType.COBIS_PAYMENTS:
                        isSuccess = TaskRepository.getInstance().doSolidarityDataSync(item);
                        break;
                    case SyncItemType.COBIS_INDIVIDUAL_VERIFICATION:
                        isSuccess = TaskRepository.getInstance().doIndividualVerificationSync(item);
                        break;
                    case SyncItemType.COBIS_GROUP_VERIFICATION:
                        isSuccess = TaskRepository.getInstance().doGroupVerificationSync(item);
                        break;
                    case SyncItemType.COBIS_GROUP_CREDIT:
                        isSuccess = SyncRepository.getInstance().doGroupCreditSync(item);
                        break;
                    case SyncItemType.COBIS_GROUP:
                        isSuccess = SyncRepository.getInstance().doGroupSync(item);
                        break;
                    case SyncItemType.COBIS_CUSTOMER:
                        isSuccess = SyncRepository.getInstance().doCustomerSync(item);
                        break;
                    default:
                        isSuccess = false;
                        Log.w("Sync Item Type not implemented: " + item.getType());
                        break;
                }
                Log.d("Time for item " + item.getType() + ": " + (System.currentTimeMillis() - startItem));
                if(!isSuccess){
                    errorId = item.getServerId();
                    break;
                }
            }
            return errorId;
        }
    }
}