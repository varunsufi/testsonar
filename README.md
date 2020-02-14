# common-services-skeleton
A skeleton service to use for pipeline development and validation

## Application 

### Build
```
mvn clean install
```

### Start application on command line
```
java -jar target/se-atg-skeleton-0.0.1-SNAPSHOT.jar  [-DSPRING_CLOUD_VAULT_ENABLED=false]
```

### Endpoints
```
// Health endpoint
http//localhost:8080/admin/health

// General metrics
http//localhost:8080/metrics

// Ping pong
http//localhost:8080/ping

// Hello world
http//localhost:8080/hello

// Secret endpoint, never call this....
http//localhost:8080/common-services
```

### CI/CD
Pipelines for this application are being migrated from GoCD to Drone. This version will move the PR-pipeline from GoCD to Drone.

##### Local development
When running Dependency-check locally you can use the profile **local-dev** as follows to escape Drone-specific properties:  
 `mvn clean -Plocal-dev org.owasp:dependency-check-maven:5.2.2:aggregate -DfailBuildOnAnyVulnerability=true -DsuppressionFiles=suppressions.xml --gs settings.xml`  
 

###### GoCD pipelines
This application is deployed in Openshift for ci -> production environments and using the GoCD Templates for Springboot Services. These pipelines in GoCD are found [here](https://go.hh.atg.se/go/pipelines#!/skeleton) Documentation can be found at [Developer Handbook](https://developer.atg.se/continuous_delivery/gocd.html)

###### Drone pipeline
Pipeline is generated from Starlark scripting in **.drone.star**, entirely. All parameters and values necessary for the pipeline should be handled in that file and the yaml generated from `drone starlark convert --stdout > .drone.yml`. When committing the changes, commit both the **.drone.star** and  **.drone.yml**

