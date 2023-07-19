# Configurando o Ambiente Virtual

1. sudo pip3 install virtualenv
2. mkdir firstproject
3. cd firstproject/

##### Lembrando que devemos instalar o Gunicorn dentro do Ambiente Virtual! Ou seja, se foi instalado globalmente o Gunicorn, devemos desinstalar ele e instalar novamente.

4. sudo pip3 uninstall gunicorn

##### O comando acima é para certificar que esteja desinstalado globalmente, se ocorre um erro escrito "Cannot uninstall requirement gunicorn, not installed" significa que não há um gunicorn instalado globalmente, poderemos prosseguir.

# Construíndo ambiente virtual

1. virtualenv fristprojectenv
2. source firstprojectenv/bin/activate
3. pip3 install gunicon flask
4. nano firstproject.py

Código:

```
from flask import Flask
application = Flask(__name__)
@application.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"

if __name__ == "__main__":
    application.run(host='0.0.0.0')
```

5. Testar projeto: python firstproject.py, verificar no localhost:5000, caso esteja tudo ok, ctrl+c para parar a execução.
6. nano wsgi.py

Código:

```
from firstproject import application

if __name__ == "__main__":
  application.run()
```

7. gunicorn --bind 0.0.0.0:8000 wsgi

##### Entrar com localhost:8000  : Agora está rodando sem o Flask

Comando para fechar aplicação do ambiente virtual: deactivate

# Criando serviço Linux

1. sudo nano /etc/systemd/system/firstproject.service

Código:

```
[Unit]
Description=Gunicorn instance to serve firstproject
After=network.target

[Service]
User=adminuser
Group=adminuser
WorkingDirectory=/home/adminuser/Documents/python/firstproject
Environment="PATH=/home/adminuser/Documents/python/firstproject/firstprojectenv/bin"
ExecStart=/home/adminuser/Documents/python/firstproject/firstprojectenv/bin/gunicorn --workers 3 --bind unix:firstproject.sock -m 007 wsgi

[Install]
WantedBy=multi-user.target
```
2. sudo systemctl start firstproject
3. sudo systemctl enable firstproject

##### Após o enable, foi criado o firstproject.sock

4. sudo nano /etc/nginx/nginx.conf

Descer até a instrução server, alterar as linhas para similar ao que está abaixo:

```
server_name firstproject  www.firstproject;

#logs
access_log /var/log/nginx/firstproject.access.log;
error_log /var/log/nginx/firstproject.error.log;

location / {
  proxy_pass http://unix:/home/adminuser/Documents/python/firstproject/firstproject.sock;
}
```
5. sudo service nginx restart
6. sudo vim /etc/hosts
7. Vericar o IP do seu computador, usando comando ifconfig
8. Adicionar o ip da sua máquina no host da sua máquina na linha após os localhosts, por exemplo:
```
10.0.2.15 firstproject
```
Lembrando que, o IP da sua máquina será diferente, deve adicionar o que estiver na sua máquina!

9. curl firstproject // Será testado se seu projeto está configurado corretamente, após isso pode acessar o seu projeto pelo navegador, digitando http://firstproject

