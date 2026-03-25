# utang ATC E2E Test Automation Framework

Here pre-setup steps could be found: [ATC Automation requirements](https://utang.atlassian.net/wiki/spaces/TT/pages/3318808604/ATC+AT+environment+management#presetup). See section *Environment preparation for local test run*


## ATC E2E test execution

   Rake build tool is used as a wrapper for test automation run (see Rakefile in the project root). Following rake tasks are defined in ATC test automation
      
<u>NOTE</u>: execute the commands below from root project dir

    - `acms_at` - Cucumber CLI-wrapper task for running ATC E2E tests
    - `acms_at_full` - includes `acms_at` plus pre-step `reset` (to cleanup ad prepare directories) + post-step `allure-generate` to generate Allure report
    - `acms_at_parallel` - task for running tests in parallel TBD
    - `acms_at_parallel_full` - includes `reset`+`acms_at_parallel` +`allure-generate`
    - `acms_at_parallel` - service task for loading ATC flight data from aggregated flight plan ACMS/testdata/FlightPlanAT_Aggregated.json. 

   Additional parameters that can be added as environment variables  to Rake

| Parameter                   |              Default value              | Description                                                                                           |
|:----------------------------|:---------------------------------------:|:------------------------------------------------------------------------------------------------------|
| ACMS_HOST_URL               | https://mt004acmsvm.utang_devops.com | Environment under the test (SUT)                                                                      |
| COMMON_ALERT_GENERATOR_URL  |      [props.COMMON_SERVER_IP]:8765      | URL of alert-generation API pointing to SUT                                                           |
| COMMON_SERVER_IP            |               10.106.5.74               | IP-address of SUT                                                                                     |
| BROWSER                     |                 chrome                  | Test in browser (chrome/edge)                                                                         |
| FEATURES_PATH               |                  acms/                  | Relative path to cucumber features fodler/files to execute (could be multiple space separated values) | 
| TAGS                        |                                         | List of tags to be included in test run (for ex `--tags @tag1  --tags "@tag2 or @tag3"`)              | 
| SCENARIO_NAME               |                                         | Rgexp for the name of the scenario to be executed (for ex `.*(Live Monitor).*`)                       |
| DRY_RUN                     |                  false                  | Run tests in dry run mode (without actual execution)                                                  |
| RETRIES                     |                    2                    | Number of retries to be done for failed tests                                                         |


`Execution samples:`

| Description                                     | `   Command                                                                                                                                                                                                                                                  |
|:------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Regular ATC E2E test automation run             | ```>rake acms_at_full ACMS_HOST_URL=https://mt011acmsvm.utang_devops.com BROWSER=chrome COMMON_ALERT_GENERATOR_URL=10.106.5.77:8765 COMMON_SERVER_IP=10.106.5.77 DRY_RUN=false FEATURES_PATH=acms/features HEADLESS=false RETRIES=0 'TAGS=--tags @run'``` |
| Dry run of ATC E2E automation (integrity check) | ```>rake acms_at_full DRY_RUN=true FEATURES_PATH=ACMS/features ```                                                                                                                                                                                           |
| ATC E2E API tests execution                     | ```>rake acms_at_full DRY_RUN=false FEATURES_PATH=ACMS/features/ RETRIES=0 'TAGS=--tags @atc_api'```                                                                                                                                                         |
| ATC E2E environment setup                       | ```>rake acms_at_setup DRY_RUN=false FEATURES_PATH=ACMS/features/ RETRIES=0```                                                                                                                                                                               |

3. **Parallel execution (TODO)**
    Not yet used due to performance issues in ATC E2E

4. **Reporting**

   Allure reports - available when executed from rake (using tasks with suffix `_full` or by direct execution of `allure_generate` task). Open index.html file from `docs/allure-reports` in browser with enabled CORS
        * For raw allure results (not Allure report)  - install allure cli and execute `allure generate docs/allure`

