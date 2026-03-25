import os
import json


def main():
    job_name = 'utangONE_Android_release_candidate'
    host_ip = '10.10.160.13'
    host_port = '8080'
    command = 'curl -v http://{0}:{1}/job/{2}//lastSuccessfulBuild/api/json'.format(host_ip, host_port, job_name)
    result = os.popen(command).read()
    sub_string = "* Connection #0 to host {0} left intact".format(host_ip)
    result_string_fixed = result.replace(sub_string, '')
    result_json = json.loads(result_string_fixed)
    last_successful_build_version = result_json['description']

    # last_built_revision = result_json['actions'][2]['lastBuiltRevision']
    # last_built_revision_name = last_built_revision['branch'][0]['name']
    # builds_by_branch_name = result_json['actions'][2]['buildsByBranchName']
    # _last_successful_build = builds_by_branch_name[last_built_revision_name]
    # last_successful_build_number = _last_successful_build['buildNumber']

    print(last_successful_build_version)
    return last_successful_build_version


main()
