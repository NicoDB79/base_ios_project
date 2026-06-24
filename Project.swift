import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "base_project",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableSynthesizedResourceAccessors: true
    ),
    settings: Constants.projectConfigurationSettings,
    targets: [
        AppTarget.target1.projectTarget,
        AppTarget.target2.projectTarget,
        .target(
            name: "Target1Previews",
            destinations: .iOS,
            product: .app,
            bundleId: "com.company.Target1Previews",
            deploymentTargets: .iOS(Constants.deploymentTarget),
            infoPlist: .default,
            sources: .sourceFilesList(
                globs: [
                    .glob("Target1Previews/**"),
                    .glob("Target1/Sources/UIComponents/**"),
                    .glob("Sources/**/*View.swift"),
                    .glob("Sources/**/*Models.swift"),
                    .glob("Sources/**/*Modifiers.swift"),
                    .glob("Sources/**/*Style.swift"),
                    .glob("Sources/**/*Storyboarded.swift"),
                    .glob("Sources/**/UIMockData.swift"),
                    .glob("Sources/**/Popup/**"),
                    .glob("Sources/**/Scanner/**"),
                    .glob("Sources/**/String*.swift"),
                    .glob("Sources/**/Utils/*Extension.swift", excluding: "Sources/**/Utils/ModelString+Extension.swift"),
                    .glob("Resources/Generated/**", excluding: "Resources/Generated/Animation.swift"),
                ]
            ),
            resources: [Constants.commonResources, "Target1/Resources/**"],
            dependencies: Constants.dependencies,
            settings: .settings(
                base: Constants.target1PreviewsSettings,
                configurations: [
                    .debug(name: AppEnvironmentConfig.stagingDebug.name),
                    .release(name: AppEnvironmentConfig.stagingRelease.name),
                    .debug(name: AppEnvironmentConfig.productionDebug.name),
                    .release(name: AppEnvironmentConfig.productionRelease.name)
                ]
            ),
        ),
        .target(
            name: "Target1Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.company.Target1Tests",
            deploymentTargets: .iOS(Constants.deploymentTarget),
            infoPlist: .default,
            sources: ["Target1Tests/**"],
            resources: [],
            buildableFolders: [],
            dependencies: [.target(name: "Target1")],
            settings: .settings(
                base: Constants.target1TestSettings,
                configurations: [
                    .debug(name: AppEnvironmentConfig.stagingDebug.name),
                    .release(name: AppEnvironmentConfig.stagingRelease.name),
                    .debug(name: AppEnvironmentConfig.productionDebug.name),
                    .release(name: AppEnvironmentConfig.productionRelease.name)
                ]
            )
        ),
    ],
    schemes: [AppScheme.target1Staging.scheme, AppScheme.target1Production.scheme,
             AppScheme.target2Staging.scheme, AppScheme.target2Production.scheme]
)

