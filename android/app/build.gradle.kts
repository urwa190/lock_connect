//"plugins {
//id("com.android.application")
//id("kotlin-android")
//// The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//id("dev.flutter.flutter-gradle-plugin")
//
//// 1. ADD THE GOOGLE SERVICES PLUGIN HERE (from Firebase suggestion):
//id("com.google.gms.google-services") // <--- ADD THIS LINE
//}
//
//
//android {
//namespace = "com.example.lock_connect"
//compileSdk = flutter.compileSdkVersion
//ndkVersion = flutter.ndkVersion
//
//compileOptions {
//sourceCompatibility = JavaVersion.VERSION_11
//targetCompatibility = JavaVersion.VERSION_11
//}
//
//kotlinOptions {
//jvmTarget = JavaVersion.VERSION_11.toString()
//}
//
//defaultConfig {
//// TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//applicationId = "com.example.lock_connect"
//// You can update the following values to match your application needs.
//// For more information, see: https://flutter.dev/to/review-gradle-config.
//minSdk = flutter.minSdkVersion
//targetSdk = flutter.targetSdkVersion
//versionCode = flutter.versionCode
//versionName = flutter.versionName
//}
//
//buildTypes {
//release {
//// TODO: Add your own signing config for the release build.
//// Signing with the debug keys for now, so `flutter run --release` works.
//signingConfig = signingConfigs.getByName("debug")
//}
//}
//}
//
//flutter {
//source = "../.."
//}
//
//// 2. ADD THE DEPENDENCIES BLOCK HERE (from Firebase suggestion):
//dependencies {
//// Import the Firebase BoM
//implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
//
//// Add the dependencies for Firebase products you want to use
//// For your authentication service, you will need firebase-auth and firebase-firestore
//implementation("com.google.firebase:firebase-analytics") // Analytics is a good default
//
//// CORE SERVICES: SWITCHED TO MAIN MODULES (no -ktx)
//implementation("com.google.firebase:firebase-auth")      // <--- CORRECTED
//implementation("com.google.firebase:firebase-firestore")
//// Add any other Firebase products your team needs here
//}"

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.lock_connect"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.lock_connect"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}