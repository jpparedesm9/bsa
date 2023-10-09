package com.cobis.gestionasesores.presentation.person;

import android.content.res.Resources;
import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bayteq.libcore.LibCore;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Person sections adapter
 * Created by mnaunay on 05/06/2017.
 */
public class PersonSectionAdapter extends RecyclerView.Adapter<PersonSectionAdapter.ViewHolder> {
    private List<Section> mData;
    private OnItemClickListener mListener;

    public PersonSectionAdapter(List<Section> data, OnItemClickListener lister) {
        mData = data;
        mListener = lister;
    }

    public void replaceAll(List<Section> sections) {
        mData = sections;
        sort();
        notifyDataSetChanged();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_customer_section, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), mListener);
        boolean enable = shouldEnableSection(position);
        holder.itemView.setEnabled(enable);
        holder.itemView.setAlpha(enable ? 1f : 0.5f);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public AddressData getCustomerAddressData() {
        for (Section section : mData) {
            if (SectionCode.CUSTOMER_ADDRESS.equals(section.getCode())) {
                CustomerAddress customerAddress = ((CustomerAddress) section.getSectionData());
                if (customerAddress != null) {
                    return customerAddress.getAddressData();
                }
            }
        }
        return null;
    }

    @Nullable
    public Section getSection(@SectionCode String code) {
        for (Section section : mData) {
            if (code.equals(section.getCode())) {
                return section;
            }
        }
        return null;
    }

    public void updateSection(Section updateSection) {
        for (int i = 0; i < mData.size(); i++) {
            if (mData.get(i).getCode().equals(updateSection.getCode())) {
                mData.set(i, updateSection);
                notifyItemChanged(i);
                return;
            }
        }
    }

    public List<Section> getSections() {
        return mData;
    }

    private synchronized void sort() {
        Collections.sort(mData, new Comparator<Section>() {
            @Override
            public int compare(Section o1, Section o2) {
                int order1 = getSectionOrder(o1.getCode());
                int order2 = getSectionOrder(o2.getCode());
                if (order1 == order2) {
                    return 0;
                } else if (order1 > order2) {
                    return 1;
                } else {
                    return -1;
                }
            }
        });
    }

    private static int getSectionOrder(@SectionCode String sectionCode) {
        switch (sectionCode) {
            case SectionCode.CUSTOMER_DATA:
                return 0;
            case SectionCode.CUSTOMER_ADDRESS:
                return 1;
            case SectionCode.CUSTOMER_BUSINESS:
                return 2;
            case SectionCode.PARTNER_DATA:
                return 3;
            case SectionCode.PARTNER_WORK:
                return 4;
            case SectionCode.CUSTOMER_REFERENCES:
                return 5;
            case SectionCode.CUSTOMER_PAYMENTS:
                return 6;
            case SectionCode.CUSTOMER_DOCUMENTS:
                return 7;
            case SectionCode.COMPLEMENTARY_DATA:
                return 8;
            default:
                return -1;
        }
    }

    private boolean shouldEnableSection(int position) {
        boolean enable = true;

        Section section = mData.get(position);
        if (section.getParentCode() != null) {
            Section parentSection = Person.getSection(section.getParentCode(), mData);
            enable = parentSection != null && parentSection.getSectionData() != null;
        }
        return enable;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.image_status)
        ImageView mImageStatus;
        @BindView(R.id.text_name)
        TextView mTextName;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Section section, final OnItemClickListener listener) {
            mTextName.setText(getCodeName(section.getCode()));
            int statusImg =  ResourcesUtil.getSyncStatusResource(section.getStatus());
            mImageStatus.setImageResource(statusImg);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(section);
                }
            });
        }


        public String getCodeName(@SectionCode String code) {
            String resourceName = "section_" + code.toLowerCase();
            Resources res = LibCore.getApplicationContext().getResources();
            String packageName = LibCore.getApplicationContext().getPackageName();
            int resId = res.getIdentifier(resourceName, "string", packageName);
            if (resId > 0) {
                return LibCore.getApplicationContext().getString(resId);
            } else {
                return "";
            }
        }
    }

    public interface OnItemClickListener {
        void onItemClick(Section item);
    }
}
