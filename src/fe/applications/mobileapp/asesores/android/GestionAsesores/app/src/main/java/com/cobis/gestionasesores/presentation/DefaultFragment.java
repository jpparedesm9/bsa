package com.cobis.gestionasesores.presentation;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.R;

public class DefaultFragment extends Fragment {

    public static DefaultFragment newInstance() {
        Bundle args = new Bundle();
        DefaultFragment fragment = new DefaultFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_default, container, false);
    }
}
