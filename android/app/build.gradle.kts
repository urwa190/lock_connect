// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // Activates the Google Services we linked in the project-level file
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.lock_connect" // Must match your google-services.json
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.lock_connect"
        minSdk = flutter.minSdkVersion // Increased for modern media plugins
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }
}

//dependencies {
//
//    // Firebase Bill of Materials ensures all versions work together
//    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
//
//    // Core Firebase features for Auth and Database
//    implementation("com.google.firebase:firebase-analytics")
//    implementation("com.google.firebase:firebase-auth-ktx")
//    implementation("com.google.firebase:firebase-firestore-ktx")
//}


dependencies {
    // Firebase Bill of Materials ensures all versions work together
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))

    // Core Firebase features (No -ktx suffix needed)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")      // Removed -ktx
    implementation("com.google.firebase:firebase-firestore") // Removed -ktx
}
