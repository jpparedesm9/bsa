package com.cobis.gestionasesores.widgets;

import android.app.Dialog;
import android.app.TimePickerDialog;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;

import com.cobis.gestionasesores.R;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by bqtdesa02 on 6/7/2017.
 */

public class TimePickerFragment extends DialogFragment {
    private static final String ARG_INIT_TIME = "arg_init_time";


    private TimePickerDialog.OnTimeSetListener mOnTimeSetListener;
    private Long mInitTime;

    public static TimePickerFragment newInstance(Long intiTime) {
        Bundle args = new Bundle();
        if(intiTime != null) {
            args.putLong(ARG_INIT_TIME, intiTime);
        }
        TimePickerFragment fragment = new TimePickerFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mInitTime = getArguments().getLong(ARG_INIT_TIME);
    }

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        final Calendar calendar = Calendar.getInstance();
        if(mInitTime != null){
            calendar.setTime(new Date(mInitTime));
        }
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);
        return new TimePickerDialog(getActivity(), R.style.AlertDialogTheme,mOnTimeSetListener, hour, minute,true);
    }

    public void setOnTimeSetListener(TimePickerDialog.OnTimeSetListener onDateSetListener) {
        mOnTimeSetListener = onDateSetListener;
    }
}
