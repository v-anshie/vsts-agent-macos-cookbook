Azure DevOps Build and Release Agent Cookbook for macOS
=======================================================

![](https://office.visualstudio.com/_apis/public/build/definitions/59d72877-1cea-4eb6-9d06-66716573631a/2373/badge)

[Visual Studio Team Services is now Azure DevOps Services](https://docs.microsoft.com/en-us/azure/devops/user-guide/what-happened-vsts?view=vsts)
We're working on the best way to rename the cookbook and recipes while maintaining backwards compatibility.

Recipes
-------

### Bootstrap

Usage: `vsts_agent_macos::bootstrap`

Add the node to the agent pool or deployment group.

### Teardown

Usage: `vsts_agent_macos::teardown`

Remove an existing agent from the build pool or deployment group.

Attributes
----------

### Agent Name

The name of the agent.

**Default value:** `node['hostname']`

```ruby
default['vsts_agent']['agent_name']
```

### Agent Version

The version of the agent to install.

**Default value:** `'2.144.0'`

```ruby
default['vsts_agent']['version']
```

### Agent Pool

The name of the agent pool you wish to add the agent to.

**Default value:** `American Hanko's Agents`

```ruby
default['vsts_agent']['agent_pool']
```

### Organization Name

The name of your Azure DevOps organization. (i.e. 'americanhanko' in `https://dev.azure.com/americanhanko`)

**Default value:** `americanhanko`

```ruby
default['vsts_agent']['account']
```

### Admin User

The username of an adminstrator on the macOS system.

**Default value:** `'vagrant'`

```ruby
default['vsts_agent']['admin_user']
```

### Agent Home Directory

The location that contains all builds, source, release, etc.

**Default value:** `'/Users/#{node['vsts_agent']['admin_user']}/vsts-agent'`

```ruby
default['vsts_agent']['agent_home']
```

### Additional Environment Variables

An optional hash may be set to pass environment variables to the agent. The agent
will then be configured with these environment variables which it will then
report back to the servers.

**Default value:** `{}`

```ruby
default['vsts_agent']['additional_environment']
```

Deployment Group
----------------

This cookbook supports adding agents to Azure DevOps deployment groups. To use this feature, simply
set the `default['vsts_agent']['deployment_group']` attribute. In addition, make sure you have
the appropriate values set for the following attributes shown below. By default, we assume that
if the `default['vsts_agent']['deployment_group']` attribute is `nil`, we are bootstrapping
a build agent and _not_ a deployment agent. This means if you set this attribute, it will
override the default functionality. You may optionally specifiy deployment group tags using
`default['vsts_agent']['deployment_group_tags']`.

```ruby
default['vsts_agent']['deployment_group'] = nil
default['vsts_agent']['project'] = nil
default['vsts_agent']['work'] = nil
default['vsts_agent']['deployment_group_tags'] = nil
```

Authentication
--------------

This cookbook uses a [personal access token](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=vsts)
to authenticate to your organization on the Azure DevOps servers. The cookbook allows access to the token via either an attribute, within a data bag or using a chef vault item.

### Plaintext Attribute

Example:

```ruby
default['vsts_agent']['pat'] = '0fbdebc988934add98179ddaae019a01711'
```

### Data Bag or Chef Vault Item

Name your vault or bag and corresponding item whatever you like and
make sure to set the corresponding attributes to reference it
accordingly:

Example:

```ruby
default['vsts_agent']['data_bag'] = 'tea_bag'
default['vsts_agent']['data_bag_item'] = 'green_tea'
```

However, it **must** contain a `personal_access_token` key with
the token itself as the value. The token must have rights to read and modify
build agents. The permissions are selected at the time of the PAT creation, which
you can read more about [here](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=vsts).

Example:

```json
{
  "id": "vsts_build_agent",
  "personal_access_token": "iu8tfaxxrhce7yeu434yo9zfjtxif3jygzk24wegi855er2moobs"
}
```
