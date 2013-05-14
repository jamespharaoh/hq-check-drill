# HQ check drill

https://github.com/jamespharaoh/hq-check-drill

This is an icinga/nagios plugin which changes state predictably at given times.
It is intended to create regular drills, which can be used to test that the
monitoring and notifications are working correctly.

## Installation

For most use cases, simply install the ruby gem:

	gem install hq-check-drill

You can also install the gem as part of a bundle and run it using the "bundle
exec" command.

	mkdir my-bundle
	cd my-bundle
	echo 'source "https://rubygems.org"' >> Gemfile
	echo 'gem "hq-check-drill"' >> Gemfile
	bundle install --path gems

If you want to develop the script, clone the repository from github and use
bundler to satisfy dependencies:

	git clone git://github.com/jamespharaoh/hq-check-drill.git
	cd hq-check-drill
	bundle install --path gems

## Usage

If the gem is installed correctly, you should be able to run the command with
the following name:

	hq-check-drill (options...)

If it was installed via bundler, then you will want to use bundler to invoke the
command correctly:

	bundle exec hq-check-drill (options...)

You will also need to provide various options for the script to work correctly.

### General options

	--config PATH

Use the `--config` option to specify the path to the configuration file, which
is described below.

## Configuration

The configuration file controls the behaviour of the script, defining the times
at which it will return a critical status and the message it should display.

Here is an example:

	<hq-check-drill-config>
		<drill level="critical" message="this is a drill">
			<match template="%A" regex="Monday"/>
			<match template="%H" regex="09"/>
		</drill>
	</hq-check-drill-config>

In this example, we have a single drill, which will be activated weekly on a
Monday from 9am to 10am.

You can add as many matches as you want, and match against anything which can be
created by ruby's strftime function:

http://www.ruby-doc.org/core-2.0/Time.html#method-i-strftime

You can also add as many drills as you want.
