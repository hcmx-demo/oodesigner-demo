namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.129
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_aos_application:
        x: 989
        'y': 270
        navigate:
          532eb05f-fe6e-ca00-00c4-0d36d2de45b3:
            targetId: af6d6c62-dece-797d-3cc8-c266c048c84d
            port: SUCCESS
      install_postgres:
        x: 425
        'y': 259
      install_java:
        x: 583
        'y': 259
      install_tomcat:
        x: 780
        'y': 257
    results:
      SUCCESS:
        af6d6c62-dece-797d-3cc8-c266c048c84d:
          x: 1192
          'y': 275
