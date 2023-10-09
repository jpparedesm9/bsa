package com.cobis.tuiiob2c.infraestructure;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by bqtdesa02 on 10/17/2017.
 */

public class InactivityManager {

    private static InactivityManager INSTANCE;


    private Timer mInactivityTimer = null;

    private InactivityListener mListener;
    private boolean mIsComplete;

    public static InactivityManager getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new InactivityManager();
        }
        return INSTANCE;
    }

    private InactivityManager() {

    }

    public void start() {
        stop();
        long timeout = SessionManager.getInstance().getInactivityTimeout();
        mInactivityTimer = new Timer(true);
        mInactivityTimer.schedule(new TimerTask() {
            @Override
            public void run() {
                mIsComplete = true;
                if(mListener != null) {
                    mListener.onInactive();
                    mIsComplete = false;
                }
            }
        }, secondsToMillis(timeout));
    }

    public void stop() {
        if (mInactivityTimer != null) {
            mInactivityTimer.cancel();
            mInactivityTimer = null;
        }
    }

    public void reset(){
        stop();
        mIsComplete = false;
        mListener = null;
        INSTANCE = null;
    }

    public boolean isInactive() {
        boolean value = mIsComplete;
        mIsComplete = false;
        return value;
    }

    private long secondsToMillis(long seconds){
        return seconds * 1000;
    }

    public void register(InactivityListener listener){
        mListener = listener;
    }

    public void unregister(){
        mListener = null;
    }

    public interface InactivityListener{
        void onInactive();
    }
}
