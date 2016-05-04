require 'json';

Facter.add('mongodb_is_master') do
  setcode do
    if Facter::Core::Execution.which('mongod') 
      if File.file?('/root/.mongorc.js')
        mongo_output = Facter::Core::Execution.exec('mongo --quiet --eval "load(\'/root/.mongorc.js\'); printjson(db.isMaster())"')
      else
        mongo_output = Facter::Core::Execution.exec('mongo --quiet --eval "printjson(db.isMaster())"')
      end
      JSON.parse(mongo_output.gsub(/ISODate\((.+?)\)/, '\1 '))['ismaster'] ||= false
    else 
      'not_installed'
    end
  end
end
