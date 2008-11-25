# Note:  to generate a named generator, create a symlink from
# your_generator_directory/generator to your_generator_directory/named_generator.
require File.join( File.dirname(__FILE__), 'generator_generator')
class NamedGeneratorGenerator < GeneratorGenerator
end
