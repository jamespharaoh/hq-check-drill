require "hq/tools/check-script"
require "hq/tools/getopt"

require "xml"

module HQ
module CheckDrill

class Script < Tools::CheckScript

	def initialize
		super
		@name = "Drill"
	end

	def process_args

		@opts, @args =
			Tools::Getopt.process args, [

				{ :name => :config,
					:required => true },

			]

		@args.empty? \
			or raise "Extra args on command line"

	end

	def prepare

		config_doc =
			XML::Document.file @opts[:config]

		@config_elem =
			config_doc.root

		@drill_elems =
			config_doc.find("drill").to_a

	end

	def perform_checks

		now = Time.now

		@drill_elems.each do
			|drill_elem|

			next unless drill_elem.find("match").all? {
				|match_elem|

				current = now.strftime match_elem["template"]
				regex = Regexp.new match_elem["regex"]

				current =~ regex

			}

			critical drill_elem["message"]

			return

		end

		message "no drills just now"

	end

end

end
end
