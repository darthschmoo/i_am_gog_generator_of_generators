require 'rubygems'
require 'ruby-debug'
require 'optparse'
class GeneratorGenerator < Rails::Generator::NamedBase
  # you can make variables available to the templates like so:
  #
  # attr_reader :var
  #
  # then set @var in initialize or manifest.  Or just pass in @vars
  # as part of the :assigns hash when running m.template
  attr_reader :opts, :license, :migration, :named
  LICENSES = %w(MIT BSD GPL2 GPL3)

  def initialize runtime_args, runtime_options = {}
    super
    # do stuff here
    @opts = parse(ARGV)
    @license = @opts[:license] || "MIT"

    @migration = @opts[:migration] == "true" || (singular_name =~ /migration$/) ? true : false
    @named = self.class.to_s == "NamedGeneratorGenerator" || @opts[:named] == "true"
  end

  def manifest
    record do |m|
      require 'rubygems'
      require 'ruby-debug'
      @singular_name = singular_name

      @generator_dir = @opts[:dir] || File.join("vendor", "generators", @singular_name)
      @template_dir = File.join( @generator_dir, "templates")

      m.directory @generator_dir
      m.directory @template_dir

      m.template( "generator.rb", File.join( @generator_dir, "#{@singular_name}_generator.rb" ) )
      m.file( "#{@license}-LICENSE", File.join( @generator_dir, "#{@license}-LICENSE" ) ) if LICENSES.include?( @license )

      m.template( "migration.rb", File.join( @template_dir, "migration.rb")) if @migration
    end
  end

  protected
  # displays when generator is run with no arguments
  def banner
    <<-EOS
Usage #{$0} GeneratorName [license=#{LICENSES.join('|')}] [migration=true] [dir=/dir/to/install] [named=true]

Optional arguments:

  named :      When =true, generates a NamedBase generator.

  license :    The license to install in the generator.

  migration :  When =true (or when the generator name ends in
               'migration') adds extra code to the generator.

  dir :        Directory to install into.  vendor/generator/generator_name
               is the default.

EOS
  end

  def parse(args)
    opts = {}

    args.each{ |arg|
      k, v = arg.split('=')
      opts[k.to_sym] = v
    }

    opts
  end
end
