# TDP Livy Notes

The version `0.8.0-incubating-TDP-0.1.0-SNAPSHOT` of Apache Livy is based on the `master` branch of the [Apache repository](https://github.com/apache/incubator-livy/tree/master).

The main purpose of this custom release is the support of Spark 3.2 that is used in TDP.

## Build container

The Docker image from [Dockerfile](Dockerfile) is the recommended environment to build Livy.

### Prerequisites

The image is based on `tdp-builder` from the official TDP repository. See the doc [Build the image](https://github.com/TOSIT-IO/TDP/tree/main/build-env#build-the-image).

### Entering the build environment

Run `./bin/start-build-env.sh` to build the `tdp-builder-livy` image and create a container that has access to your environment (`~/.m2` cache, TDP repos):

```sh
cd incubator-livy/tdp
TDP_HOME=/path/to/tdp ./bin/start-build-env.sh
```

For more info, see [Start the container](https://github.com/TOSIT-IO/TDP/tree/main/build-env#start-the-container).

## Making a release

```bash
cd incubator-livy
mvn clean package -DskipTests
```

The command generates a `.zip` file of the release at `./assembly/target/apache-livy-0.8.0-incubating-TDP-0.1.0-SNAPSHOT-bin.zip`.

## Testing

```bash
mvn test --fail-never
```

### Generating HTML test reports

```bash
mvn surefire-report:report-only
```

## Test notes

See [test-notes](./test-notes.md)
