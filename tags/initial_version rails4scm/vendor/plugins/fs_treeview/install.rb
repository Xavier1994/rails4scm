
##
## Copy over asset files (javascript/css/images) from the plugin directory to public/
##
require 'fileutils'

def copy_files(source_path, destination_path, directory)
  source, destination = File.join(directory, source_path), File.join(RAILS_ROOT, destination_path)
  FileUtils.mkdir(destination) unless File.exist?(destination)
  FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
end

Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do

  directory = File.dirname(__FILE__)
  copy_files("/public", "/public", directory)

end
