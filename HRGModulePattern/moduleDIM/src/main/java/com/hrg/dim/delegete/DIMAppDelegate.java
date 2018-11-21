package com.hrg.dim.delegete;

import android.support.annotation.Keep;

import com.hrg.common.base.IApplicationDelegate;
import com.hrg.common.base.ViewManager;
import com.hrg.dim.fragment.DIMListFragment;

/**
 * <p>类说明</p>
 *
 * @name DIMAppDelegate
 */
@Keep
public class DIMAppDelegate implements IApplicationDelegate {
    @Override
    public void onCreate() {
        //主动添加
        ViewManager.getInstance().addFragment(0, DIMListFragment.newInstance());
    }

    @Override
    public void onTerminate() {

    }

    @Override
    public void onLowMemory() {

    }

    @Override
    public void onTrimMemory(int level) {

    }
}
