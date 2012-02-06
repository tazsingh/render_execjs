RenderExecJS.configure do
#  Add your RenderExecJS configuration here

#  Execute JS within environment from Sprockets
#  compile_with :sprockets_require_tag

#  Execute JS within environment from File
#  compile_with File.read("")

#  Execute JS within environment from String
#  compile_with <<-JS
#    // do stuff
#  JS
end

#  Alternate setter syntax
#  RenderExecJS.compile_with # value
#  or
#  RenderExecJS.compile_with = # value

#  Alternate getter syntax
#  RenderExecJS.compile_with # => value