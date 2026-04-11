package mobile.touristapp.com

import io.flutter.embedding.android.FlutterActivity
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val channel = "TouristChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
//            if (call.method == "getKey") {
//                val arguments = call.arguments as? Map<*, *>
//                val key = arguments?.get("key") as? String
//                val string = getStringForKey(key)
//                result.success(string)
//            }

            if (call.method == "getVersionName") {
                try {
                    val packageInfo = packageManager.getPackageInfo(packageName, 0)
                    val versionName = packageInfo.versionName
                    result.success(versionName)
                } catch (_: PackageManager.NameNotFoundException) {
                    result.error("UNAVAILABLE", "Version not available", null)
                }
            }
            if (call.method == "getVersionCode") {
                try {
                    val packageInfo = packageManager.getPackageInfo(packageName, 0)
                    val versionCode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        packageInfo.longVersionCode
                    } else {
                        @Suppress("DEPRECATION")
                        packageInfo.versionCode.toLong()
                    }
                    result.success(versionCode)
                } catch (_: PackageManager.NameNotFoundException) {
                    result.error("UNAVAILABLE", "Version code not available", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

//    private fun getStringForKey(key: String?): String {
//        return when (key) {
//            "P_KEY" -> BuildConfig.LOCAL_URL
//            "BASE_URL" -> BuildConfig.BASE_URL
//            "LOCAL_URL" -> BuildConfig.LOCAL_URL
//            else -> "Other"
//        }
//    }
}
