package com.cobis.gestionasesores.presentation.groupverification;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 8/16/2017.
 */

public class MemberVerificationAdapter extends RecyclerView.Adapter<MemberVerificationAdapter.MemberVerificationViewHolder> {

    private List<MemberVerification> mItems;
    private MemberVerificationListener mListener;

    public MemberVerificationAdapter(MemberVerificationListener listener) {
        mListener = listener;
        mItems = new ArrayList<>();
    }

    @Override
    public MemberVerificationViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_verification_member, parent, false);
        return new MemberVerificationViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final MemberVerificationViewHolder holder, int position) {
        holder.bindVerificationMember(mItems.get(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mListener.onClickMemberVerification(mItems.get(holder.getAdapterPosition()));
            }
        });
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public void setVerificationMembers(List<MemberVerification> newMembers) {
        mItems.clear();
        mItems.addAll(newMembers);
        notifyDataSetChanged();
    }

    public static class MemberVerificationViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.img_sync_status)
        ImageView mStatusImage;
        @BindView(R.id.text_name)
        TextView mNameText;
        @BindView(R.id.text_score)
        TextView mScoreText;
        @BindView(R.id.text_category)
        TextView mCategoryText;

        public MemberVerificationViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bindVerificationMember(MemberVerification member) {
            mNameText.setText(member.getName());
            mStatusImage.setImageResource(ResourcesUtil.getSyncStatusResource(member.getStatus()));
            //CHECK politics to show score
            if (member.getStatus() != SyncStatus.DRAFT) {
                NumberFormat nf = new DecimalFormat("##.###");
                mScoreText.setText(mScoreText.getContext().getString(R.string.group_verification_member_score_format, nf.format(member.getScore())));
            } else {
                mScoreText.setText("");
            }
            mCategoryText.setVisibility(member.isGroup() ? View.GONE : View.VISIBLE);
            mCategoryText.setText(member.isAval() ? R.string.member_verification_guarantor : R.string.member_verification_debtor);

        }
    }

    public interface MemberVerificationListener {
        void onClickMemberVerification(MemberVerification member);
    }
}
