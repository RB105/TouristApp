plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "mobile.touristapp.com"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "mobile.touristapp.com"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = 9
        versionName = "0.0.9"
    }

    signingConfigs {
        getByName("debug") {
            // debug signing is auto, but you can override if needed
        }
        create("release") {
            keyAlias = "android"
            keyPassword = "12345678"
            storeFile = file("../release.jks")
            storePassword = "12345678"
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    //noinspection GradleDependency
    implementation("com.google.firebase:firebase-installations-interop:17.1.1")
    implementation("com.google.firebase:firebase-common-ktx:21.0.0")
    implementation("com.google.android.datatransport:transport-api:3.1.0")
    implementation("com.google.android.datatransport:transport-runtime:3.1.9")
    implementation("io.appmetrica.analytics:analytics:7.8.0")
    implementation("com.google.firebase:firebase-datatransport:18.2.0")
    implementation("com.google.firebase:firebase-installations:18.0.0")
    implementation("com.google.firebase:firebase-messaging:24.1.2")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}