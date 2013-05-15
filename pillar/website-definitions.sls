
### ONE site per USER

websites:
  cbu:
    user: cbu
    group: cbu
    site_identifier: cbu3
    server_name: localhost
    
    # TODO SSL
    
    git_key: None
    git_repo: git://github.com/lucasvickers/lv-test
    git_revision: master
    uwsgi_module: changebyus
    uwsgi_callable: app

    # path from root of github
    requirements_file: requirements.txt
