package com.cobis.gestionasesores.presentation.people;

import android.support.annotation.DrawableRes;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PeopleAdapter extends RecyclerView.Adapter<PeopleAdapter.ViewHolder> {
    private List<Person> mData;
    private OnItemClickListener mListener;

    public PeopleAdapter(List<Person> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_person, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void replace(List<Person> people) {
        mData.clear();
        mData.addAll(people);
        notifyDataSetChanged();
    }

    public void clear() {
        mData.clear();
        notifyDataSetChanged();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.image_type)
        ImageView mTypeImageView;
        @BindView(R.id.text_title)
        TextView mTextTitle;
        @BindView(R.id.text_document)
        TextView mTextDocument;
        @BindView(R.id.text_action)
        TextView mActionTextView;
        @BindView(R.id.img_sync_status)
        ImageView mSyncStatusImg;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Person person, final OnItemClickListener listener) {
            mTypeImageView.setImageResource(getImageTypeResource(person.getType(), person.isValidated()));
            mTextTitle.setText(person.getName());
            mTextDocument.setText(person.getDocument());
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(person);
                }
            });

            int imgSyncStatus = ResourcesUtil.getSyncStatusResource(person.getStatus());
            if (imgSyncStatus > 0) {
                mSyncStatusImg.setVisibility(View.VISIBLE);
                mSyncStatusImg.setImageResource(imgSyncStatus);
            } else {
                mSyncStatusImg.setVisibility(View.INVISIBLE);
            }

            if(person.getAction() != null){
                mActionTextView.setText(person.getAction().getFullDescription());
                mActionTextView.setVisibility(View.VISIBLE);
            }else{
                mActionTextView.setVisibility(View.GONE);
            }
        }

        @DrawableRes
        private int getImageTypeResource(@PersonType int type, boolean isValidated) {
            switch (type) {
                case PersonType.CUSTOMER:
                    return R.drawable.ic_customer;
                case PersonType.PROSPECT:
                    if(isValidated){
                        return R.drawable.ic_prospect_validated;
                    }else {
                        return R.drawable.ic_prospect;
                    }
                default:
                    throw new RuntimeException("Person type is not supported!!");
            }
        }
    }

    public interface OnItemClickListener {
        void onItemClick(Person item);
    }
}
