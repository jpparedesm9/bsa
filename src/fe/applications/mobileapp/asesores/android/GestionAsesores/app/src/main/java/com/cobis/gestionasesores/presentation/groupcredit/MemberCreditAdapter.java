package com.cobis.gestionasesores.presentation.groupcredit;

import android.content.Context;
import android.graphics.Color;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.TextView;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 6/26/2017.
 */

public class MemberCreditAdapter extends RecyclerView.Adapter<MemberCreditAdapter.MemberCreditViewHolder> {
    private List<MemberCreditApp> mItems;
    private Context mContext;
    private MemberCreditListener mListener;
    private boolean isReadOnly;

    public MemberCreditAdapter(Context context, MemberCreditListener listener) {
        mItems = new ArrayList<>();
        mContext = context;
        mListener = listener;
    }

    @Override
    public MemberCreditViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(mContext).inflate(R.layout.row_member_credit, parent, false);
        return new MemberCreditViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final MemberCreditViewHolder holder, int position) {
        holder.bindMemberCredit(mItems.get(position),isReadOnly);
        if(!isReadOnly) {
            holder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mListener.onClick(mItems.get(holder.getAdapterPosition()));
                }
            });
            holder.partOfCycleCheckBox.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    boolean isChecked = holder.partOfCycleCheckBox.isChecked();
                    mItems.get(holder.getAdapterPosition()).setPartOfCycle(isChecked);
                    mListener.onChangeCheck(mItems.get(holder.getAdapterPosition()));
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public void setMemberCredits(List<MemberCreditApp> memberCredits) {
        mItems.clear();
        mItems.addAll(memberCredits);
        notifyDataSetChanged();
    }

    public List<MemberCreditApp> getMemberCredits() {
        return mItems;
    }

    public void updateMemberCredit(MemberCreditApp memberCreditApp) {
        for (int i = 0; i < mItems.size(); i++) {
            if (mItems.get(i).getCustomerServerId() == memberCreditApp.getCustomerServerId()) {
                mItems.set(i, memberCreditApp);
                notifyItemChanged(i);
                return;
            }
        }
    }

    public int getCheckedCount() {
        int count = 0;
        for (MemberCreditApp memberCreditApp : mItems) {
            if (memberCreditApp.isPartOfCycle()) {
                count++;
            }
        }

        return count;
    }

    public void setReadOnly(boolean readOnly) {
        isReadOnly = readOnly;
        notifyDataSetChanged();
    }

    public static class MemberCreditViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.checkbox_name)
        CheckBox partOfCycleCheckBox;
        @BindView(R.id.text_credit_amount)
        TextView creditAmountText;
        @BindView(R.id.text_name)
        TextView nameText;

        public MemberCreditViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bindMemberCredit(MemberCreditApp memberCreditApp, boolean isReadOnly) {
            nameText.setText(memberCreditApp.getCustomerName());
            double amount = memberCreditApp.getRequestAmount();
            if (amount <= 0) {
                creditAmountText.setTextColor(Color.RED);
            } else {
                creditAmountText.setTextColor(Color.BLACK);
            }
            creditAmountText.setText(CurrencyTextFormatter.formatText(amount, BankAdvisorApp.getInstance().getConfig().getLocale()));
            partOfCycleCheckBox.setChecked(memberCreditApp.isPartOfCycle());
            partOfCycleCheckBox.setEnabled(!isReadOnly);
        }
    }

    public interface MemberCreditListener {
        void onClick(MemberCreditApp memberCreditApp);

        void onChangeCheck(MemberCreditApp memberCreditApp);
    }
}
