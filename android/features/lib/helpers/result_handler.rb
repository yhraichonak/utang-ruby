class ResultHandler

  # Pass in a block of tests that should execute and process failures, if the occur.

  def yield_results(assertion_type, hash={})
    begin
      yield
    rescue => error
      puts "\n\e[31m%s assertions failed!\e[0m" % assertion_type
      pp hash if hash != {}
      raise error
    end
  end

end

class ResultProcess

  def initialize
    $PASSED_TRACK_PATH = "#{$WORKING_DIR}/result_passed.txt"
    $FAILED_TRACK_PATH = "#{$WORKING_DIR}/result_failed.txt"
    $RUNS_TRACK_PATH = "#{$WORKING_DIR}/result_runs.txt"
    $CRASH_TRACK_PATH = "#{$WORKING_DIR}/result_crashes.txt"
    $ERROR_TRACK_PATH = "#{$WORKING_DIR}/result_errors.txt"
    $RESULTS_PATH = "#{$WORKING_DIR}/results.txt"
    $VERSION_PATH = "#{$WORKING_DIR}/result_version.txt"

    paths_zero = [$PASSED_TRACK_PATH, $FAILED_TRACK_PATH, $RUNS_TRACK_PATH,
                  $CRASH_TRACK_PATH, $ERROR_TRACK_PATH]
    paths_none = [$RESULTS_PATH, $VERSION_PATH]

    paths_zero.each { |p0| Common.validate_file(p0, data=0) }
    paths_none.each { |pn| Common.validate_file(pn) }
  end

  def create_json
    result = {} #{"Run":0, "Pass":0, "Fail":0, "Crashes":0, "Errors":0}
    result_string = "Latest test job results...\n\n"

    rn = File.open("#{$RUNS_TRACK_PATH}", "r")
    result["S"] = rn.read.to_i
    result_string += "[S] Scenarios: %s \n" % result["S"]
    rn.close

    ps = File.open($PASSED_TRACK_PATH, "r")
    result["P"] = ps.read.to_i
    result_string += "[P] Passed: %s \n" % result["P"]
    ps.close

    fa = File.open($FAILED_TRACK_PATH, "r")
    result["F"] = fa.read.to_i
    result_string += "[F] Failed: %s \n" % result["F"]
    fa.close

    cr = File.open($CRASH_TRACK_PATH, "r")
    result["C"] = cr.read.to_i
    result_string += "[C] Crashed: %s \n" % result["C"]
    cr.close

    er = File.open($ERROR_TRACK_PATH, "r")
    result["E"] = er.read.to_i
    result_string += "[E] Errors: %s \n" % result["E"]
    er.close


    # Write OUT to Files
    re = File.open($RESULTS_PATH, "w+")
    re.write(result_string)
    re.close

    rv = File.open($VERSION_PATH, "w+")
    result_version = " S#{result["S"]} P#{result["P"]} F#{result["F"]} C#{result["C"]} E#{result["E"]}"
    rv.write(result_version)
    rv.close

    puts "[JENKINS] Push JSON: %s" % result
  end
end