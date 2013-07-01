include:
  - graphite.graphite-web

httpd:
  pkg:
    - installed
    {% if grains['os'] == 'RedHat' or grains['os'] == 'Fedora' or grains['os'] == 'CentOS'%}
    - name: httpd
    {% elif grains['os'] == 'Debian' or grains['os'] == 'Ubuntu'%}
    - name: apache2
    {% elif grains['os'] == 'Gentoo' or grains['os'] == 'Arch' or grains['os'] == 'FreeBSD' %}
    - name: apache
    {% endif %}
  service:
    - running
    {% if grains['os'] == 'Debian' or grains['os'] == 'Ubuntu' or grains['os'] == 'Gentoo' %}
    - name: apache2
    {% endif %}
    - enable: True
    - require:
      - pkg: httpd
    - watch:
      - file: graphite-vhost
      - file: graphite-wsgi
      - file: graphite-local-settings
      - file: graphite-storage-directory

date > /tmp/started_apache:
  cmd.wait:
    - stateful: false
    - watch:
      - service: httpd
