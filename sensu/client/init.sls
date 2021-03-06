include:
  - sensu

# Sensu Client Service

sensu-client:
  service.running:
    - enable: True
    - require:
      - pkg: sensu
    - watch:
      - file: /etc/sensu/conf.d/client.json


# Sensu Client config

/etc/sensu/conf.d/client.json:
  file.managed:
    - source: salt://sensu/client/etc/sensu/conf.d/client.json
    - template: jinja

/etc/sensu/config.json:
  file.managed:
    - source: salt://sensu/client/etc/sensu/config.json
    - template: jinja
