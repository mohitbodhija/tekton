***Settings*** 
Library           Collections
Library           OperatingSystem  
Library           BuiltIn
Library           String
Library           json
Library           RequestsLibrary 
Library           Collections
Library           yaml  
Variables          ProductionDefectsData.yaml



*** Variables ***

${expected_status}    200
@{keys}
&{DATA}
${execute_endpoint}    All
${environment}         Staging
${base_url}         https://qahub-stg.phenompro.com/drf
&{auth_body}        username=srikanth.bongoni@phenompeple.com   email=srikanth.bongoni@phenompeple.com     useremail=srikanth.bongoni@phenompeple.com    password=2222    password2=2222    first_name=""    last_name=""    qahub_user=""     access_roles=""
${bearer_token}

*** Test cases ***  

Test Case 1
    Log to Console   Mohit Bodhija......!!

ProductionDefectsData
    
    [Documentation]            Executing API ProductionDefectsData
    [Tags]                     API,GET

    Execution OF Endpoint     ${ProductionDefectsData}

fetch_repeatability_data
    
    [Documentation]            Executing API fetch_repeatability_data
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_repeatability_data}

fetch_tickets_created_vs_analysis
    
    [Documentation]            Executing API fetch_tickets_created_vs_analysis
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_tickets_created_vs_analysis}

ViolationData
    
    [Documentation]            Executing API ViolationData
    [Tags]                     API,GET

    Execution OF Endpoint     ${ViolationData}

pxm_data
    
    [Documentation]            Executing API pxm_data
    [Tags]                     API,GET

    Execution OF Endpoint     ${pxm_data}

fetch_tickets_created_vs_analysis_pxm
    
    [Documentation]            Executing API fetch_tickets_created_vs_analysis_pxm
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_tickets_created_vs_analysis_pxm}

weekly_metrics_pxm
    
    [Documentation]            Executing API weekly_metrics_pxm
    [Tags]                     API,GET

    Execution OF Endpoint     ${weekly_metrics_pxm}

get_week_date_ranges
    
    [Documentation]            Executing API get_week_date_ranges
    [Tags]                     API,GET

    Execution OF Endpoint     ${get_week_date_ranges}

get_user_details
    
    [Documentation]            Executing API get_user_details
    [Tags]                     API,GET

    Execution OF Endpoint     ${get_user_details}

defect_leakage
    
    [Documentation]            Executing API defect_leakage
    [Tags]                     API,GET

    Execution OF Endpoint     ${defect_leakage}

test_execution
    
    [Documentation]            Executing API test_execution
    [Tags]                     API,GET

    Execution OF Endpoint     ${test_execution}

wb_report
    
    [Documentation]            Executing API wb_report
    [Tags]                     API,GET

    Execution OF Endpoint     ${wb_report}

fetch_phem_sprints
    
    [Documentation]            Executing API fetch_phem_sprints
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_phem_sprints}

get_kpi_values
    
    [Documentation]            Executing API get_kpi_values
    [Tags]                     API,GET

    Execution OF Endpoint     ${get_kpi_values}

activity_log
    
    [Documentation]            Executing API activity_log
    [Tags]                     API,GET

    Execution OF Endpoint     ${activity_log}

delete_notification
    
    [Documentation]            Executing API delete_notification
    [Tags]                     API,GET

    Execution OF Endpoint     ${delete_notification}
    
mark_all_as_read
    
    [Documentation]            Executing API mark_all_as_read
    [Tags]                     API,GET

    Execution OF Endpoint     ${mark_all_as_read}
    
get_tenant_data
    
    [Documentation]            Executing API get_tenant_data
    [Tags]                     API,GET

    Execution OF Endpoint     ${get_tenant_data}
    
zbb
    
    [Documentation]            Executing API zbb
    [Tags]                     API,GET

    Execution OF Endpoint     ${zbb}

Test Case 1
    Log to Console   Hello  Bodhija......!!

get_passed_data_for_curve
    
    [Documentation]            Executing API get_passed_data_for_curve
    [Tags]                     API,GET

    Execution OF Endpoint     ${get_passed_data_for_curve}

fetch_sup_component_options
    
    [Documentation]            Executing API fetch_sup_component_options
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_sup_component_options}


fetch_security_scan_lst
    
    [Documentation]            Executing API fetch_security_scan_lst
    [Tags]                     API,GET

    Execution OF Endpoint     ${fetch_security_scan_lst}

refresh_materialized_views
    
    [Documentation]            Executing API refresh_materialized_views
    [Tags]                     API,GET

    Execution OF Endpoint     ${refresh_materialized_views}

testrunwidget
    
    [Documentation]            Executing API testrunwidget
    [Tags]                     API,GET

    Execution OF Endpoint     ${testrunwidget}


*** Keywords ***

Execution OF Endpoint

    [Documentation]            Segregation of Params from Each Payload
    [Arguments]                ${key}       

    ${method}          Get From Dictionary      ${key}        method
    ${endpoint}        Get From Dictionary      ${key}       end_point
    ${payload}    Set Variable    ${key}[payload]
    ${payload_type}    Type Of Object    ${payload}
  
    FOR    ${each_payload}    IN    @{payload}
        ${expected_data}   Set Variable             ${each_payload}[expected_data]
        Remove From Dictionary            ${each_payload}       expected_data
        ${payload_keys}    Get Dictionary Keys      ${each_payload}    
        ${parameters}        Set Variable
        FOR  ${each_key}  IN  @{payload_keys}
            ${key_value}    Get From Dictionary   ${each_payload}    ${each_key}
            ${parameters}      Catenate    ${parameters}${each_key}=${key_value}&
        END
        Passing Params To Endpoint    ${parameters}  ${expected_data}  ${environment}   ${method}  ${endpoint}
    END


Passing Params To Endpoint
    
    [Documentation]       Calls Either the "API Post Method" or "API Get Method" Based on Payload Provided Method Value 
    
    [Arguments]         ${params}   ${expected_data}    ${environment}    ${method}    ${end_point}
    
    ${env_base_url}    Get Url For Environment     ${environment}
    ${bool_exp}=    Run Keyword If  "${method}".lower()=="Post".lower()    API Post Method     ${env_base_url}     ${end_point}     ${params}    ${expected_status}
                ...     ELSE     API Get Method     ${env_base_url}     ${end_point}     ${params}    ${expected_status}    ${expected_data} 

API Post Method
    [Documentation]  Executes the End point if Method is Post and Return Response by Validating Response Status
    [Arguments]            ${base_url}     ${end_point}     ${params}    ${expected_status}
    
    Access Token
    ${Access Token}    Set Variable    Bearer ${bearer_token}
    ${headers}       Create Dictionary       Content-Type=application/json       Authorization=${Access Token}
    Create Session    api_post_method        ${base_url}        verify=True 
    ${final_url}      Catenate	 SEPARATOR=${base_url}    ${end_point}    
    ${res}        POST On Session      api_post_method     ${final_url}     headers=${headers}      params=${params}    expected_status=${expected_status}     

API Get Method
    
    [Documentation]        Executes the End point if Method is GET and Return Response by Validating Response Status
    [Arguments]            ${base_url}     ${end_point}     ${params}    ${expected_status}    ${expected_data}
   
    Access Token
    ${Access Token}    Set Variable    Bearer ${bearer_token}
    ${headers}       Create Dictionary       Content-Type=application/json       Authorization=${Access Token}
    Create Session    api_get_method        ${base_url}            verify=True      
    ${final_url}      Catenate	 SEPARATOR=${base_url}    ${end_point} 
    ${res}        GET On Session      api_get_method      ${final_url}    headers=${headers}      params=${params}    expected_status=${expected_status}       


Access Token
    [Documentation]        Returns Bearer Token for Provided Base URL
    
    Create Session    get_api_res       url=${base_url}      verify=True
    ${resp}     POST On Session     get_api_res      url=${base_url}/register_user/        data=&{auth_body}     
    Status Should Be      200            ${resp}
    ${bearer_token}    Get From Dictionary      ${resp.json()}        access
    Set Global Variable    ${bearer_token}
    

Get Url For Environment
    [Documentation]            Selects the Base Url according to the given Environment
    [Arguments]                ${environemnt}

    ${env_base_url}  Set Variable    ${Empty}
    IF    "${environemnt}" == "Staging"
        ${env_base_url}=    Set Variable  https://qahub-stg.phenompro.com/drf
    ELSE IF   "${environemnt}" == "Production"
        Fail    msg=Selected Production Environemnt !!!!.....
    ELSE IF    "${environemnt}" == "Dev"
         ${env_base_url}    Set Variable  https://qahub-dev.phenompro.com/
    ELSE
        Fail    msg=No Environment is Select !!!!.....Please Select Environement
    END
    Return From Keyword     ${env_base_url}

Type Of Object
    [Documentation]        Evaluates and returns what is type of Object 
    [Arguments]            ${object}
    TRY
        ${type_res}     Evaluate    type(${object}) 
        ${type_response}     Convert To String        ${type_res}
    EXCEPT
            ${type_response}    Set Variable    none
    END
        
    Return From Keyword        ${type_response}
    