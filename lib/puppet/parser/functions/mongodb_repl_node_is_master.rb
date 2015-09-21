module Puppet::Parser::Functions
  newfunction(:mongodb_repl_node_is_master, :type => :rvalue, :doc => <<-EOS
    Returns whether the replication node is a master or not.
    EOS
  ) do |args|
    args = Array.new
    args << "/usr/bin/mongo"
    args << '--quiet'
    args << ['--host','127.0.0.1']
    args << ['--eval',"load('/root/.mongorc.js'); printjson(db.isMaster().ismaster)"]
    
    return `/usr/bin/mongo --host 127.0.0.1 --eval load('/root/.mongorc.js'); printjson(db.isMaster().ismaster)`
  end
end
