require_relative '../../common/helpers/tr_helper'

testRailCaseId = ARGV[0]
testRailCaseRunId = ARGV[1]
testRailCaseName = ARGV[2]
testRailCaseResult = ARGV[3]
tr_ui_update_test_result(testRailCaseId,testRailCaseRunId,testRailCaseName,testRailCaseResult)






