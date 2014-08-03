cloudstack_wrapper Cookbook
===========================

Chef wrapper cookbook to install Apache CloudStack using cookbook cloudstack. Installation examples and provide installation order of various CloudStack components.


Requirements
------------

#### cookbooks
- `cloudstack` - cloudstack cookbook provide libraries to install and configure CloudStack.
- `mysql` - mysql cookbook is used to install MySQL server required by CloudStack.
- `nfs` - nfs cookbook used for secondary storage and to import systemvm-templates.


Usage
-----
#### cloudstack_wrapper::add_in_one

Configure a CloudStack Management server with a local MySQL database and /data/secondary as secondary storage which will contain SystemVM template for XenServer.

Just include `cloudstack_wrapper::all_in_one` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cloudstack_wrapper::all_in_one]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
- Author:: Pierre-Luc Dion (<pdion@cloudops.com>)

```text
Copyright:: Copyright (c) 2014 CloudOps.com

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
