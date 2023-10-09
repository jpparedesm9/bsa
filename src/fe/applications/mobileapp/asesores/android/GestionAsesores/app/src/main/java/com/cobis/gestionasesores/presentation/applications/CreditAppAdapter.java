package com.cobis.gestionasesores.presentation.applications;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Adapter to handler credit applications
 * Created by mnaunay on 23/06/2017.
 */

public class CreditAppAdapter extends RecyclerView.Adapter<CreditAppAdapter.ViewHolder>{
    private List<CreditApp> mData;
    private OnItemClickListener mListener;

    public CreditAppAdapter(List<CreditApp> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }

    public void updateAll(List<CreditApp> creditApps){
        mData.clear();
        mData.addAll(creditApps);
        notifyDataSetChanged();
    }

    public void clear(){
        mData.clear();
        notifyDataSetChanged();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_credit_apps,parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position),mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.image_type)
        ImageView mTypeImageView;
        @BindView(R.id.text_title)
        TextView mTitleTextView;
        @BindView(R.id.text_total)
        TextView mTotalTextView;
        @BindView(R.id.text_action)
        TextView mActionTextView;
        @BindView(R.id.img_sync_status)
        ImageView mSyncStatusImg;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }

        public void bind(final CreditApp creditApp, final OnItemClickListener listener){
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(creditApp);
                }
            });
            mTitleTextView.setText(creditApp.getApplicantName());
            mTotalTextView.setText(CurrencyTextFormatter.formatText(creditApp.getAmount(), BankAdvisorApp.getInstance().getConfig().getLocale()));
            int imageType = getImageTypeResource(creditApp.getType());
            if(imageType>0){
                mTypeImageView.setImageResource(imageType);
                mTypeImageView.setVisibility(View.VISIBLE);
            }else{
                mTypeImageView.setVisibility(View.INVISIBLE);
            }

            int imgSyncStatus = ResourcesUtil.getSyncStatusResource(creditApp.getStatus());
            if (imgSyncStatus > 0) {
                mSyncStatusImg.setImageResource(imgSyncStatus);
                mSyncStatusImg.setVisibility(View.VISIBLE);
            } else {
                mSyncStatusImg.setVisibility(View.INVISIBLE);
            }

            if(creditApp.getAction() != null){
                mActionTextView.setText(creditApp.getAction().getFullDescription());
                mActionTextView.setVisibility(View.VISIBLE);
            }else{
                mActionTextView.setVisibility(View.GONE);
            }
        }

        private int getImageTypeResource(@CreditAppType String type){
            switch (type){
                case CreditAppType.GROUP:
                    return R.drawable.ic_group;
                case CreditAppType.INDIVIDUAL:
                   return R.drawable.ic_customer;
                default:
                    Log.e("Credit App Type is not supported!!!");
                  return -1;
            }
        }
    }

    public interface OnItemClickListener {
        void onItemClick(CreditApp item);
    }
}
