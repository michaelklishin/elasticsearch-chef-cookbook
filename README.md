# ElasticSeach Chef Cookbook

This is an OpsCode Chef cookbook for ElasticSearch.

It uses officially released Debian packages, provides Upstart service script but has no
way to tweak ElasticSearch configuration parameters using Chef node attributes. The reason for
that is it was created for CI and development environments. Attributes will be used in the future,
doing so for single-server installations won't be difficult.


## ElasticSearch Version

This cookbook currently provides ElasticSearch 0.19.x but can be used
to install other versions by overriding data bag attributes.

## Supported OS Distributions

Ubuntu 11.04, 11.10.


## Recipes

Main recipe is `elasticsearch::default`.


## Attributes

All the attributes below are namespaced under `node[:elasticsearch]`. The only attribute provided
right now, `:version`, is accessible via `node[:elasticsearch][:version]`.

This cookbook is very bare bones and targets development and CI environments, there are no other
attributes at the moment.


## Dependencies

OpenJDK 6 or Sun JDK 6.


## Copyright & License

Michael S. Klishin, Travis CI Development Team, 2012.

Released under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html).
