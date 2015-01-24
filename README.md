cloudstack_wrapper Cookbook
===========================

[Chef](http://www.chef.io/) wrapper cookbook to install [Apache Cloudstack](http://cloudstack.apache.org)
using [cloudstack cookbook](https://github.com/cloudops/cookbook_cloudstack). Installation examples and provide installation order of various CloudStack components.

In this wrapper example, if you want to install a CloudStack management server
with all dependencies such as installing MySQL server, system VM template for
XenServer, use ``cloudstack_wrapper::all_in_one`` recipe.


Requirements
------------

#### cookbooks
- `cloudstack` - cloudstack cookbook provide libraries to install and configure CloudStack.
- `mysql` - mysql cookbook is used to install MySQL server required by CloudStack.
- `nfs` - nfs cookbook used for secondary storage and to import systemvm-templates.


Usage
-----

#### cloudstack_wrapper::all_in_one

Configure a CloudStack Management server which will contain:
- local MySQL server
- initialize CloudStack database
- setup nfs share: ``/data/secondary`` for the secondary storage
- Download XenServer SystemVM template.
- Download vhd-util script.
- start cloudstack-management
- install and start cloudstack-usage
- Generate API keys for "admin"

Just include `cloudstack_wrapper::all_in_one` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cloudstack_wrapper::all_in_one]"
  ]
}
```

#### cloudstack_wrapper::dev_all_in_one

Same as `all_in_one` but set the Global Setting ``system.vm.use.local.storage``
to use Local Storage for System VMs.


#### cloudstack_wrapper::management_server

- Install cloudstack-management
- Initialise cloudstack database on remote MySQL server.
- Download system vm template using remote NFS share.
- Start cloudstack-management
- Generage API keys for "admin".


#### cloudstack_wrapper::mgt_remotenfs

Use Remote NFS share for Secondary Storage. Management server and cloudstack_usage
locally.


#### cloudstack_wrapper::mgt_db_remotenfs

Install management server, cloudstack_usage, and MySQL server and use remote NFS
shares.


#### cloudstack_wrapper::database_server

Install MySQL server with tuning required by CloudStack.


#### cloudstack_wrapper::nfsshares

Configure NFS server to export Primary and Secondary Storages shares.


Contributing
------------

Fork it and customize it for your needs.
Fill [Github issues](https://github.com/cloudops/cookbook_cloudstack_wrapper/issues)
if you get into problems.


License and Authors
-------------------
- Author:: Pierre-Luc Dion (<pdion@cloudops.com>)

```text
Copyright:: Copyright (c) 2015 CloudOps.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
