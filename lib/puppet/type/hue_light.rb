require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'hue_light',
  docs: <<-EOS,
      This type provides Puppet with the capabilities to manage ...
    EOS
  features: ['remote_resource'],
  attributes: {
    ensure: {
      type:    'Enum[present, absent]',
      desc:    'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name: {
      type:      'String',
      desc:      'The name of the resource you want to manage.',
      behaviour: :namevar,
    },
    on: {
      type:      'Optional[Boolean]',
      desc:      'Whether the lamp is on or off.',
    },
    hue: {
      type:      'Optional[Integer]',
      desc:      'Colour of the light (hue and saturation).'
    },
    sat: {
      type:      'Optional[Integer]',
      desc:      'Saturation of the light colour',
    },
    bri: {
      type:      'Optional[Integer[1,254]]',
      desc:      <<DESC,
  This is the brightness of a light from its minimum brightness 1 to its maximum brightness 254
DESC
    },
  },
)
