require 'puppet/resource_api/simple_provider'

# Implementation for the hue_light type using the Resource API.
class Puppet::Provider::HueLight::HueLight < Puppet::ResourceApi::SimpleProvider
  def get(context)
    lights = context.transport.hue_get(context, 'lights')

    return [] if lights.nil?

    lights.collect { |name, content|
      {
        name: name,
        ensure: 'present',
        on: content['state']['on'],
        hue: content['state']['hue'],
        sat: content['state']['sat'],
        bri: content['state']['bri'],
      }
    }
  end

  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    context.device.hue_put("lights/#{name}/state", should)
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
  end
end
