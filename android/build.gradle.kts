////// Project-level build.gradle (often named build.gradle or build.gradle.kts)
////
////// 1. ADD THE PLUGINS BLOCK HERE:
////plugins {
////    // This line registers the Google Services plugin,
////    // making it available for modules to use later.
//////    id("com.android.application") version "8.1.0" apply false // Example Android plugin
////    id("com.android.application") version "8.9.1" apply false
////
////    id("com.google.gms.google-services") version "4.4.4" apply false // <--- ADD IT HERE
////}
////
////// 2. YOUR EXISTING REPOSITORIES BLOCK GOES NEXT:
////allprojects {
////    repositories {
////        google()
////        mavenCentral()
////        maven {
////            url = uri("https://maven.aliyun.com/repository/google")
////        }
////    }
////}
////
////val newBuildDir: Directory =
////    rootProject.layout.buildDirectory
////        .dir("../../build")
////        .get()
////rootProject.layout.buildDirectory.value(newBuildDir)
////
////subprojects {
////    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
////    project.layout.buildDirectory.value(newSubprojectBuildDir)
////}
////subprojects {
////    project.evaluationDependsOn(":app")
////}
////
////tasks.register<Delete>("clean") {
////    delete(rootProject.layout.buildDirectory)
////}
//
//
//plugins {
//    // Android Gradle Plugin
//    id("com.android.application") version "8.9.1" apply false
//    // Google Services plugin (single version here)
//    id("com.google.gms.google-services") version "4.4.4" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//        maven { url = uri("https://maven.aliyun.com/repository/google") }
//    }
//}
//
//val newBuildDir: Directory =
//    rootProject.layout.buildDirectory
//        .dir("../../build")
//        .get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}

plugins {
    id("com.android.application") version "8.9.1" apply false
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://maven.aliyun.com/repository/google") }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}