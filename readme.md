## What?
The high level goal is to be able to bootstrap windows build nodes with the least amount of gymnastics.
This work has already been done by a few individuals and clients, but it has not been captured in one place.. until now. Also, some of the work is overly complex, and needs to be simplified to be usefull for general consumption.å


## Assumptions
* Windows build node will be kicked off from Delivery server.
* Windows build node has winrm enabled/configured (example: https://gist.github.com/vinyar/6735863)
* Windows build node has 5986 enabled for secure transmission (wip)


## Why not a workstation node?
Delivery server has delivery.pem, builder keys, & chef-server url
To bootstrap a node, user provides Node address, and username/password.
From here, we can render knife.rb and gain ability to bootstrap nodes (via delivery.pem)
With winrm we can send keys directly to the windows node w/o data_bags or messing with private keys


From here, we simply have to convert the existing automations & rip out the bits baked into the AMIs, and ask their respective creators for input and assistance.


## Pre-bootstrap steps:
Happens on the delivery node locally (temporary until windows nodes are officially supported)

https://github.com/irvingpop/windows_automate_build_node
Early work: https://gist.github.com/irvingpop/7c46c11a7292c66db22422d59f3e5429

Render the secrets over to windows node:
https://github.com/chef-cft/chef_automate_windows_build_nodes/blob/master/notes_2.txt#L67-L81


## Then windows box gets bootstrapped with combination of
default.rb & https://github.com/irvingpop/windows_automate_build_node


then we continue hacking...

finish Simons script here:
https://github.com/chef-cft/emea-sa/blob/master/cookbooks/delivery_build_wrapper/recipes/windows_overrides.rb
then 

check the doc: 
https://docs.google.com/document/d/1jdklBA-gtNWysjGbC8tcuPfpENGVxP8bUl-fVnSCEx0/edit#

then check the linux side for any hidden gems
https://github.com/chef/delivery/blob/716e770cb010031d7000199f6cd34b004b97c4c3/omnibus/files/ctl-commands/build-node/installer.rb#L104


