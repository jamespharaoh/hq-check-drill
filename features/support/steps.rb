require "tempfile"

require "hq/check-drill/script"

When /^I execute$/ do
	|cmd_str|

	stdout_temp = Tempfile.new "cuke-stdout-"
	stderr_temp = Tempfile.new "cuke-stderr-"

	system "(#{cmd_str}) >#{stdout_temp.path} 2>#{stderr_temp.path}"

	@command_status = $?.exitstatus

	@command_stdout = File.read(stdout_temp.path)
	@command_stderr = File.read(stderr_temp.path)

	stdout_temp.unlink
	stderr_temp.unlink

end

When /^I invoke check\-drill (.*?)$/ do
	|args_str|

	@script = HQ::CheckDrill::Script.new

	@script.args = Shellwords.split args_str
	@script.stdout = StringIO.new
	@script.stderr = StringIO.new

	@script.main

	@command_status = @script.status
	@command_stdout = @script.stdout.string
	@command_stderr = @script.stderr.string

end

Then /^the exit status should be (\d+)$/ do
	|status_str|

	status = status_str.to_i

	@command_status.should == status

end

Then /^the stdout should be:$/ do
	|message|

	@command_stdout.strip.should == message.strip

end
