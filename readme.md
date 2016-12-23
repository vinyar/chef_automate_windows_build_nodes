initial process that kicks off the whole thing


The high level goal is to be able to bootstrap windows build nodes with the least gymnastics.

Right now we are building it to run from the delivery server.

Delivery server has delivery.pem & chef-server url
We can render knife.rb and gain ability to bootstrap nodes.

From here, we simply have to convert the existing automations & rip out the bits baked into the AMIs.


#Pre-bootstrap steps:

https://gist.github.com/irvingpop/7c46c11a7292c66db22422d59f3e5429

then current recipe.

then https://github.com/chef-cft/emea-sa/blob/master/cookbooks/delivery_build_wrapper/recipes/windows_overrides.rb
then 

