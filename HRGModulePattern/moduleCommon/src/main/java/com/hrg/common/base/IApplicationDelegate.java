package com.hrg.common.base;

import android.support.annotation.Keep;

/**
 * <p>类说明</p>
 *
 * @author liyy 2018/11/21
 * @name ApplicationDelegate
 */
@Keep
public interface IApplicationDelegate {

    void onCreate();

    void onTerminate();

    void onLowMemory();

    void onTrimMemory(int level);
}
