import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("app")

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationId = "com.q.shopzy.dev"
            resValue(type = "string", name = "app_name", value = "Shopzy Dev")
        }
        create("staging") {
            dimension = "app"
            applicationId = "com.q.shopzy.staging"
            resValue(type = "string", name = "app_name", value = "Shopzy Staging")
        }
        create("prod") {
            dimension = "app"
            applicationId = "com.q.shopzy"
            resValue(type = "string", name = "app_name", value = "Shopzy")
        }
    }
}