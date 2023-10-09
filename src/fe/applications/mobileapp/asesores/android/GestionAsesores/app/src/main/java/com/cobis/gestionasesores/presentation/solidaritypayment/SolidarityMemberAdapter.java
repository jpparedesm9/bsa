package com.cobis.gestionasesores.presentation.solidaritypayment;

import android.support.v4.content.ContextCompat;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 8/21/2017.
 */

public class SolidarityMemberAdapter extends RecyclerView.Adapter<SolidarityMemberAdapter.SolidarityMemberViewHolder> {

    private List<SolidarityMember> mItems;
    private SolidarityMemberListener mListener;

    public SolidarityMemberAdapter(SolidarityMemberListener listener) {
        mItems = new ArrayList<>();
        mListener = listener;
    }

    @Override
    public SolidarityMemberViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_solidarity_member, parent, false);
        return new SolidarityMemberViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final SolidarityMemberViewHolder holder, int position) {
        holder.bindSolidarityMember(mItems.get(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(mListener != null) {
                    mListener.onClickSolidarityMember(mItems.get(holder.getAdapterPosition()));
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public void setSolidarityMembers(List<SolidarityMember> solidarityMembers) {
        mItems.clear();
        mItems.addAll(solidarityMembers);
        notifyDataSetChanged();
    }

    public void updateSolidarityMember(SolidarityMember member) {
        for (int i = 0; i < mItems.size(); i++) {
            if (mItems.get(i).getId() == member.getId()) {
                mItems.set(i, member);
                notifyItemChanged(i);
                return;
            }
        }
    }

    public List<SolidarityMember> getSolidarityMembers() {
        return mItems;
    }

    public void disable() {
        mListener = null;
    }

    public static class SolidarityMemberViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.text_member_name)
        TextView mNameText;
        @BindView(R.id.text_payment_amount)
        TextView mPaymentAmount;
        @BindView(R.id.text_owed_amount)
        TextView mOwedAmount;

        public SolidarityMemberViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bindSolidarityMember(SolidarityMember member) {
            mNameText.setText(member.getName());
            mPaymentAmount.setText(CurrencyTextFormatter.formatText(member.getPaymentAmount(), BankAdvisorApp.getInstance().getConfig().getLocale()));
            mOwedAmount.setText(CurrencyTextFormatter.formatText(member.getOwedAmount(), BankAdvisorApp.getInstance().getConfig().getLocale()));
            int color = member.getOwedAmount() == 0 ? android.R.color.tertiary_text_dark : R.color.md_red_500;
            mOwedAmount.setTextColor(ContextCompat.getColor(mOwedAmount.getContext(), color));
        }
    }

    public interface SolidarityMemberListener {
        void onClickSolidarityMember(SolidarityMember member);
    }
}
