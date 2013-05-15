{% for site, args in pillar["files"].iteritems() %}

{{ args['group'] }}-group:
  group.present:
    - name: {{ args['group'] }}

{{ args['user'] }}-user:
  user.present:
  - name: {{ args['user'] }}
  - fullname: {{ args['user'] }} user
  - shell: /bin/bash
  - home: /home/{{ args['user'] }}
  - groups:
    - {{ args['group'] }}
  - require:
    - group: {{ args['group'] }}-group

log-dirs:
  file:
    - names: 
      - /home/{{ args['user'] }}/log
      - /home/{{ args['user'] }}/log/nginx
      - /home/{{ args['user'] }}/log/uwsgi
    - directory
    - mode: 770
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

site-dir:
  file:
    - name: /home/{{ args['user'] }}/site
    - directory
    - mode: 740
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

run-dir:
  file:
    - name: /home/{{ args['user'] }}/run
    - directory
    - mode: 770
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

{% endfor %}
