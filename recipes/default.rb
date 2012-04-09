#
# Cookbook Name:: ElasticSearch
# Recipe:: default
# Copyright 2012, Michael S. Klishin & Travis CI development team
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe "java"

require "tmpdir"

tmp = Dir.tmpdir
case node[:platform]
when "debian", "ubuntu"
  v = node.elasticsearch.version
  ["elasticsearch-#{v}.deb"].each do |deb|
    path = File.join(tmp, deb)

    remote_file(path) do
      source "https://github.com/downloads/elasticsearch/elasticsearch/#{deb}"

      not_if "which elasticsearch"
    end

    file(path) do
      action :nothing
    end

    package(deb) do
      action   :install
      source   path
      provider Chef::Provider::Package::Dpkg

      notifies :delete, resources(:file => path)

      not_if "which elasticsearch"
    end
  end # each

  service "elasticsearch" do
    supports :restart => true, :status => true

    action [:enable, :start]
  end
end
