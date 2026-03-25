import sys
import os
import threading

import python_lib.last_successful_build_number
import time

remote_pwd = 'XXXXX'


# uptime_less = '14:12  up  2:28, 3 users, load averages: 1.65 1.72 1.77'
# uptime_more = '14:12  up 3 days, 22:25, 7 users, load averages: 1.89 2.04 2.11'
#
# if 'days' in result:
#     uptime_days = int(result.split(' days')[0])
#     if uptime_days > 2:
#         print "[UPTIME] Rebooting: System uptime more than 3 days."
#         os.popen('echo {pwd} | sudo -S shutdown -r +1'.format(pwd=remote_pwd))
#         return
# print "[UPTIME] System uptime less than 3 days. No need to reboot."

def get_dev_folder(user):
    return 'Development' if user == 'qaautomation'
    return 'development'


class JenkinsRunner:

    def __init__(self):
        self._name = "Jenkins Run Configurator"
        self._author = "Neil Norton"
        self._created = "2022/03/07"
        self.__doc__ = "Python utility for automating Jenkins test pipeline run executions"

        self.VIRTUAL_DEVICE_NAME = 'Pixel120'
        self.VIRTUAL_DEVICE_OS_VERSION = '12.0'

        self.USER = os.getlogin()
        self.DEV_PATH = get_dev_folder(self.USER)
        self.USER_DIR = '/Users/' + self.USER
        self.BASH_PROFILE = self.USER_DIR + '/.bash_profile'
        self.system_uptime = None

        self.SERVER_IP = '0.0.0.0'
        self.SERVER_PORT = '4724'
        self.BUILD_NUMBER = python_lib.last_successful_build_number.main()
        self.JENK_IP = '10.10.160.13'
        self.JENK_DIR = '/var/lib/jenkins/jobs'
        self.JENK_ANDROID_BUILD_PATH = '/utangONE_Android_release_candidate'
        self.JENK_ARCHIVE_PKG_PATH = '/archive/AS1/build/outputs/apk/QA/debug'
        self.JENK_BUILD_BASE = '/builds/' + str(self.BUILD_NUMBER)
        self.JENK_PKG = '/AS1-*-QA-debug.apk'
        self.LOCAL_PKG = 'AS1-QA-debug.apk'
        self.LOCAL_PKG_DIR = '/Users/' + self.USER + '/' + self.DEV_PATH + '/builds/as1/android/'
        self.LOCAL_PKG_PATH = self.LOCAL_PKG_DIR + self.LOCAL_PKG

        self.cmd_cpy_jenkins_pkg = 'scp -r jenkins@' + self.JENK_IP + ':' + self.JENK_DIR + self.JENK_ANDROID_BUILD_PATH + self.JENK_BUILD_BASE + self.JENK_ARCHIVE_PKG_PATH + self.JENK_PKG + ' ' + self.LOCAL_PKG_PATH
        self.cmd_kill_emulator = 'adb devices | grep emulator | cut -f1 | while read line; do adb -s $line emu kill; done'
        self.cmd_kill_appium = 'killall node'
        self.cmd_check_emulator = 'adb devices | grep emulators'
        self.cmd_check_appium = 'ps | grep "node /usr/local/bin/appium"'
        self.cmd_system_restart = 'echo XXXXX | sudo shutdown -r +1'

        self._thread_device = threading.Thread(target=device_thread, args=(0,))
        self._thread_server = threading.Thread(target=server_thread, args=(0,))

    def kill_appium_server(self):
        while True:
            print "[APPIUM] Checking for running appium servers"
            server = os.popen(self.cmd_check_appium).read()
            if server != "":
                print "[APPIUM] Killing appium servers..."
                os.popen(self.cmd_kill_appium)
            else:
                return

    def kill_emulators(self):
        while True:
            print "[EMU] Checking for running emulators."
            emulators = os.popen(self.cmd_check_emulator).read()
            if emulators != "":
                print "[EMU] Killing emulator processes..."
                os.popen(self.cmd_kill_emulator).read()
            else:
                print "[EMU] Emulator check: Success"
                return

    def change_directory(self, path):
        print "[DIR] Changing directory to: %s" % path
        os.chdir(path)

    def check_last_system_reboot(self):
        print "[UPTIME] Checking system uptime."
        result = os.popen('uptime').read()
        if isinstance(result, str):
            self.system_uptime = result.split(' up ')[1].split(',')[0]
            print "[UPTIME] System has been running: {0}".format(result)

    def cleanup_pkg_directory(self):
        print "[PKG] Checking if local dir exists."
        if os.path.exists(self.LOCAL_PKG_DIR):
            print "[PKG] Cleanup: Removing existing APK from folder."
            os.remove(self.LOCAL_PKG_PATH)
        else:
            print "[PKG] Creating PKG directory."
            os.makedirs(self.LOCAL_PKG_DIR)

    def copy_jenkins_pkg_to_local(self):
        print "[PKG] Copying Jenkins Build Package to local drive."
        result = os.popen(self.cmd_cpy_jenkins_pkg).read()
        if result == '':
            assert(os.path.exists(self.LOCAL_PKG_PATH))
            print "[PKG] Success: Jenkins Build Package has been copied to local drive."

    def load_bash_profile(self):
        print "[BASH] Loading ./bash_profile"
        os.popen('source ' + self.BASH_PROFILE)

    def launch_appium_server(self):
        print "[APPIUM] Launching server: %s" % self.
        os.popen

    def launch_emulator(self):
        print "[EMULATOR] Launching emulator: @%s" % self.AVD_NAME
        os.popen('emulator @%s' % self.AVD_NAME)



def main():
    jrun = JenkinsRunner()
    jrun.load_bash_profile()
    jrun.cleanup_pkg_directory()
    jrun.check_last_system_reboot()
    jrun.kill_emulators()
    jrun.kill_appium_server()
    # jrun.copy_jenkins_pkg_to_local()
    jrun.start

    # Steps:
    # 1. Check last system reboot (if >72h, reboot system)
    # 2. Check, kill, and verify no running Emulator & Appium Server processes.
    # 3. Get last RC build number.
    # 4. Copy the latest RC APK from Jenkins to local machine.
    # 5. Load .bash_profile
    # 6. Instantiate emulator, and verify running.
    # 7. Configure Emulator for test run (uninstall existing APK, install test APK).
    # 8. Configure Appium Server for test run.
    # 9. Execute cucumber test run.
    # 10. Save test build info.
    # 11. Run testrail script to report results.


main()
