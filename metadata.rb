name 'vsts_agent_macos'
maintainer 'Eric Hanko'
maintainer_email 'eric.hanko1@gmail.com'
license 'MIT'
description 'A dedicated cookbook for configuring an Azure DevOps build or release agent on macOS.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 14.0' if respond_to?(:chef_version)
version '2.1.2'

supports 'mac_os_x'

source_url 'https://github.com/americanhanko/vsts-agent-macos-cookbook'
issues_url 'https://github.com/americanhanko/vsts-agent-macos-cookbook/issues'

depends 'chef-vault', '~> 3.1.1'
depends 'homebrew', '~> 5.0.0'
depends 'tar', '~> 2.1.0'
