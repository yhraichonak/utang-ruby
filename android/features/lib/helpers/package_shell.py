import os
import sys
import time

PKG_SP = 'pkg_sp'
REG_CODE = 'reg_code'

home = os.path.expanduser('~')
os.chdir(home)

# To run this script inside ruby, assign the output of `python package_shell.py <params>` to a variable
# Current <params> are:
#   'reg_code'        -> Returns device Registration Code if it exists, nil if not.0
#   'shared_prefs'    -> Returns the whole AS1 package shared_prefs.xml

# Example usage:
# result = `python package_shell.py reg_code`


class PackageShell:
    def __init__(self):
        self.name = 'ADB Package Shell'
        self.arg1 = sys.argv[1]
        self.adb_shell = 'adb shell'
        self.run_as = 'run-as'
        self.package = 'com.utang.one.qa'
        self.cat = 'cat'
        self.file_path = 'shared_prefs/com.utang.one.qa_preferences.xml'
        self.grep = '| grep REGISTRATION_CODE'
        self.reg_code_cmd = '{0} {1} {2} {3} {4} {5}'.format(
            self.adb_shell,
            self.run_as,
            self.package,
            self.cat,
            self.file_path,
            self.grep
        )
        self.shared_prefs_cmd = '{0} {1} {2} {3} {4}'.format(
            self.adb_shell,
            self.run_as,
            self.package,
            self.cat,
            self.file_path
        )
        self.data = []
        self.result = str
        self.device_registration_code = str
        self.pkg_shared_prefs = str

    def _shell_call(self, cmd):
        self.result = os.popen(cmd).read()


    def _process_result(self, res_type):
        if res_type == REG_CODE:
            try:
                self.device_registration_code = self.result.split('">')[1].split("</s")[0]
            except IndexError:
                self.device_registration_code = None
            # print("PACKAGE DeviceRegistrationCode: {0}".format(self.device_registration_code))
        elif res_type == PKG_SP:
            self.pkg_shared_prefs = self.result
            # print("PACKAGE SharedPrefs: \n{0}".format(self.pkg_shared_prefs))
        else:
            raise AttributeError

    def _empty_result_file(self, filename):
        with open(filename, 'w') as f:
            f.write('')
            f.close()

    def get_shared_prefs(self):
        self._shell_call(self.shared_prefs_cmd)
        self._process_result(res_type=PKG_SP)
        return self.pkg_shared_prefs

    def get_device_registration_code(self):
        self._shell_call(self.reg_code_cmd)
        self._process_result(res_type=REG_CODE)
        return self.device_registration_code

    def register_device_with_site_id(self, site_id):
        reg_code = self.device_registration_code
        cmd = 'curl -vs -k -i --user astglobal:Gl0b@lS3rv\!c3s -H \"Content-Type:application/json\" -H \"User-Agent:iOS\" -X POST -d \'{\"registrationCode\":\"{reg_code}\",\"siteId\":\"{site_id}\"}\' https://10.10.160.230/GS/api/DeviceSite?registrationCode={reg_code} 2> output.txt'.format(reg_code, site_id, reg_code)
        self.result = self._shell_call(cmd)
        return self.result


def get_registration_code():
    shell = PackageShell()

    if shell.arg1 in ['reg', 'code', 'reg_code']:
        result = shell.get_device_registration_code()
    elif shell.arg1 in ['share', 'pref', 'shared_prefs']:
        result = shell.get_shared_prefs()
    else:
        result = "ERROR: Expected an argument to run PackageShell. (ex. 'reg_code', or 'shared_prefs')"

    current_path = os.path.dirname(__file__)
    filename = os.path.join(current_path, 'python_lib', 'result.txt')
    shell._empty_result_file(filename)
    time.sleep(0.5)

    with open(filename, 'w') as f:
        f.write(str(result))
        f.close()

    print >> sys.stdout, result


def device_site_registration(site_id):
    shell = PackageShell()
    get_registration_code()
    result = shell.register_device_with_site_id(site_id)
    print result



def main():
    site_ids = ['1763', '4186', '2419', '4103' '4103', '4104', '4121', '4645']
    get_registration_code()
    # for site_id in site_ids:
    #     device_site_registration(site_id)


main()
