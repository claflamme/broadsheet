requireDir = require 'require-dir'

services = requireDir App.Config.paths.services

for i, service of services
  services[i] = new service()

module.exports = services
