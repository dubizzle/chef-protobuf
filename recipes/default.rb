#
# Cookbook Name:: protobuf
# Recipe:: default
#
# Copyright 2010, GeneralSensing LTD
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential'

unless File.exists?("/usr/local/bin/protoc")
  remote_file "/tmp/protobuf-#{node[:protobuf][:version]}.tar.bz2" do
    source "http://protobuf.googlecode.com/files/protobuf-#{node[:protobuf][:version]}.tar.bz2"
    mode "0644"
    checksum "db0fbdc58be22a676335a37787178a4dfddf93c6"
  end

  execute "unbzip-protobuf" do
    command "tar -jxf /tmp/protobuf-#{node[:protobuf][:version]}.tar.bz2"
    creates "/tmp/protobuf-#{node[:protobuf][:version]}/README.txt"
    cwd "/tmp"
    action :run
  end

  execute "make-install-protobuf" do
    command "./configure && make && make check && make install"
    cwd "/tmp/protobuf-#{node[:protobuf][:version]}"
    action :run
  end
end
