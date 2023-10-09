package com.cobis.gestionasesores.presentation.member.moreinformation;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.widgets.GaugeView;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 9/29/2017.
 */

public class MemberInformationFragment extends Fragment implements MemberInformationContract.View {

    private MemberInformationContract.Presenter mPresenter;

    @BindView(R.id.input_rfc)
    TextInputEditText mRfcEditText;
    @BindView(R.id.input_cycle_in_group)
    TextInputEditText mCycleInGroupEditText;
    @BindView(R.id.input_client_number)
    TextInputEditText mClientNumberEditText;
    @BindView(R.id.gauge_risk_level)
    GaugeView mRiskLevelGauge;

    public static MemberInformationFragment newInstance() {
        Bundle args = new Bundle();
        MemberInformationFragment fragment = new MemberInformationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_member_information, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mPresenter.start();
    }

    @Override
    public void setPresenter(MemberInformationContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showMemberInformation(Member member) {
        mRfcEditText.setText(member.getRfc());
        mCycleInGroupEditText.setText(String.valueOf(member.getCycleInGroup()));
        mClientNumberEditText.setText(member.getCustomerNumber());
    }

    @Override
    public void drawRiskLevel(String riskLevel) {
        mRiskLevelGauge.setItemTarget(ResourcesUtil.getGaugeItemFromRiskLevel(riskLevel));
        mRiskLevelGauge.setCaption(getString(ResourcesUtil.getRiskLevelStringResource(riskLevel)));
        mRiskLevelGauge.postDelayed(new Runnable() {
            @Override
            public void run() {
                mRiskLevelGauge.play();
            }
        }, Constants.RISK_LEVEL_ANIMATION_DELAY);
    }
}
