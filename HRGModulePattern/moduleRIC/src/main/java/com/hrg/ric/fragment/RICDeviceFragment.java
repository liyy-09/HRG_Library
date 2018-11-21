package com.hrg.ric.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hrg.common.base.BaseFragment;
import com.hrg.ric.R;

public class RICDeviceFragment extends BaseFragment {

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment GirlsFragment.
     */
    public static RICDeviceFragment newInstance() {
        return new RICDeviceFragment();
    }


    public RICDeviceFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.ric_fragment_ricdevice, container, false);
    }


}
