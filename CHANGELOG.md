cloudstack_wrapper CHANGELOG
============================

This file is used to list changes made in each version of the cloudstack_wrapper cookbook.
0.4.9
-----
- pdion - log4j for 4.10 updated for the community one. now use filebeat anyway.

0.4.8
-----
- pdion - on/off service via attribute for centos7 slave

0.4.7
-----
- pdion - recipe for 4.10 on centos7 slave

0.4.6
-----
- pdion - add support to 4.4

0.4.5
-----
- pdion - new recipe to create passive centos7 second node

0.4.4
-----
- pdion - support for centos7

0.4.2
-----
- pdion - change log rotate down to 3 days

0.4.1
-----
- ccontini - Switch filebeat lab URL back to loglab.cloudops.net

0.4.0
-----
- ccontini - Ship logs via filebeat
           - add remote syslog endpoint for root. Add files for supporting 4.10.
- erouleau - Remove SYSLOG targets from log4j
           - add a cronjob to cleanup cloudstack old logs

0.3.3
-----
- pdion - remove global settings change that cause error.

0.3.2
-----
- ccontini - Limit the Queue Size

0.3.1
-----
- ccontini - Add 172.31/16 range to lab machines

0.3.0
-----
- ccontini - Change rsyslog template to forward to lab or prod depending on the IP

0.2.8
-----
- ccontini - remove expunge delay in all_in_one recipe

0.2.7
-----
- ccontini - Handle vhost definition as an environment attribute.

0.2.6
-----
- ccontini - Add eventlog config.

0.2.5
-----
- ccontini - Forward cloudstack messages using SimpleForward.

0.2.4
-----
- ccontini - add a cloudstack specific rsyslog config.

0.2.3
-----
- ccontini - add log4j recipe for ACS4.7.x

0.2.1
-----
- pdion891 - Add Berkshelf support.
           - fix selinux for database server.
           - add customized log4j-cloud.xml for ACS 4.7.x
0.2.0
-----
- pdion891 - update use of mysql cookbook to suport version 6.

0.1.3
-----
- pdion891 - upgrade license date
           - update README

0.1.2
-----
- pdion891 - rename ``hypervisor_tpl`` by ``systemvm``

0.1.1
-----
- pdion891 - add admin_apikey and admin_secretkey to cloudstack_global_setting resources

0.1.0
-----
- pdion891 - Initial release of cloudstack_wrapper
