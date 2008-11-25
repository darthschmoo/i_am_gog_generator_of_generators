class <%= class_name %>Generator < Rails::Generator::<%= "Named" if named %>Base
  # you can make variables available to the templates like so:
  #
  # attr_reader :var
  #
  # then set @var in initialize or manifest.  Or just pass in @var
  # as part of the :assigns hash when running m.template

  def initialize runtime_args, runtime_options = {}
    super
    # do stuff here
  end

  def manifest
    record do |m|
      # Sample actions:
      #
      # create a directory
      # m.directory("app/views/#{singular_name}/")
      #
      # copy a file from templates folder
      # m.file("stuff.css", "public/stylesheets/#{singular_name}/stuff.css")
      #
      # evaluate
      # m.template( "scaffold_show.rb", "app/views/target/show.html.erb,
      #             :assigns => { :named => @named, :model_name => @model_name } )
      #
      # create a migration
      # m.migration("totally_screw_up_database.rb", migration_directory)
      <% if migration %>
      m.migration( "create_#{singular_name}.rb", migration_directory)
      <% end %>
    end

    case action
    when "generate"
      puts "Thank you for using this generator.  Good fortune be with you."
    when "destroy"
      puts "Please fill out a brief survey explaining why you are dissatisfied with this generator"
    end
  end

  protected
  # displays when generator is run with no arguments
  def banner
    "Usage #{$0} <%= singular_name %> somethingelse whoknowswhat"
  end
end


