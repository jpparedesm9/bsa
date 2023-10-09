package com.cobis.tuiiob2c.presentation.solicitationAproved;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.mainActivity.MainActivity;

import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class AprovedFragment extends Fragment {

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.button_acept)
    Button mAcpetButton;
    @BindView(R.id.exitImageButton)
    ImageButton mCloseImageButton;

    public static AprovedFragment newInstance() {
        Bundle args = new Bundle();
        AprovedFragment fragment = new AprovedFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_aproved, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mAcpetButton.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), MainActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent);
            Objects.requireNonNull(getActivity()).finish();
        });

        mCloseImageButton.setOnClickListener(v -> {
            Intent intent = new Intent(getContext(), MainActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent);
            Objects.requireNonNull(getActivity()).finish();
        });

    }
}
