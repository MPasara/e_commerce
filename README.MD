# Shopzy

## Environments
This project has three environments:
- dev
- staging
- prod

To create a new version to each of the environments, a tag on git on desired branch and commit needs to be created starting with the name of desired environment (`development_\*`, `staging_\*` or `production_\*`).

## Run instructions
You need to have latest Flutter stable version installed locally to be able to run the project. There are predefined VSCode and Android Studio config files to easily choose from and run desired environment (dev, staging and prod).
To run the project from command line you can do it this way depending on the desired environment:
```
flutter run --flavor <dev/staging/prod> -t lib/main/main_<dev/staging/prod>.dart
```
To see additional config for each environment you can check `lib/main/app_environment.dart` file.

## Changelog generator

These steps are necessary after cloning git repository to have changelog
generator executed automatically each time you commit something to your
repository. For more info check changelog_generator/README.md file.

Run the following commands to install Jinja2 package necessary for generating
changelog file and setup post-commit hook so changelog generator can be executed
on each commit.

```
pip3 install Jinja2
mkdir -p .git/hooks/ && cp changelog_generator/post-commit .git/hooks/
```
