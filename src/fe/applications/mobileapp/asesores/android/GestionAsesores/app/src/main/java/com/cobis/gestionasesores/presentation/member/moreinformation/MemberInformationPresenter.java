package com.cobis.gestionasesores.presentation.member.moreinformation;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.Member;

/**
 * Created by bqtdesa02 on 9/29/2017.
 */

public class MemberInformationPresenter implements MemberInformationContract.Presenter {

    private MemberInformationContract.View mView;
    private Member mMember;

    public MemberInformationPresenter(MemberInformationContract.View view, Member member) {
        mView = view;
        mMember = member;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.showMemberInformation(mMember);
        if(StringUtils.isNotEmpty(mMember.getRiskLevel())){
            mView.drawRiskLevel(mMember.getRiskLevel());
        }
    }
}
