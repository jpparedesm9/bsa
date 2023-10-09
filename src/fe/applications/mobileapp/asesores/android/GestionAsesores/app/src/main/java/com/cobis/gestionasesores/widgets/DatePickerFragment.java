package com.cobis.gestionasesores.widgets;

import android.app.DatePickerDialog;
import android.app.Dialog;
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

public class DatePickerFragment extends DialogFragment {
    private static final String ARG_INIT_DATE = "arg_init_date";
    private static final String ARG_MAX_DATE = "arg_max_date";

    private DatePickerDialog.OnDateSetListener mOnDateSetListener;
    private Long mInitDate;
    private Long mMaxDate;

    public static DatePickerFragment newInstance(Long initDate, Long maxDate) {
        Bundle args = new Bundle();
        if(initDate != null) {
            args.putLong(ARG_INIT_DATE, initDate);
        }
        if(maxDate != null){
            args.putLong(ARG_MAX_DATE,maxDate);
        }
        DatePickerFragment fragment = new DatePickerFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if(getArguments().containsKey(ARG_INIT_DATE)) {
            mInitDate = getArguments().getLong(ARG_INIT_DATE);
        }

        if(getArguments().containsKey(ARG_MAX_DATE)) {
            mMaxDate = getArguments().getLong(ARG_MAX_DATE);
        }

    }

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        final Calendar calendar = Calendar.getInstance();
        if(mInitDate != null){
            calendar.setTime(new Date(mInitDate));
        }
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        // Create a new instance of DatePickerDialog and return it
        DatePickerDialog datePickerDialog = new DatePickerDialog(getActivity(), R.style.AlertDialogTheme,mOnDateSetListener, year, month, day);
        if(mMaxDate!= null) {
            datePickerDialog.getDatePicker().setMaxDate(mMaxDate-1000);
        }
        return datePickerDialog;
    }

    public void setOnDateSetListener(DatePickerDialog.OnDateSetListener onDateSetListener) {
        mOnDateSetListener = onDateSetListener;
    }
}
