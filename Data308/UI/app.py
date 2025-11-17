from flask import Flask
from flask_mysqldb import MySQL
from views.views import views, init_mysql 
from dotenv import load_dotenv
import os

app = Flask(__name__)

load_dotenv()

MYSQL_HOST = os.getenv('MYSQL_HOST')
MYSQL_USER = os.getenv('MYSQL_USER')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
MYSQL_DB = os.getenv('MYSQL_DB')
SECRET_KEY = os.getenv('SECRET_KEY')

app.config['MYSQL_HOST'] = MYSQL_HOST
app.config['MYSQL_USER'] = MYSQL_USER
app.config['MYSQL_PASSWORD'] = MYSQL_PASSWORD
app.config['MYSQL_DB'] = MYSQL_DB
app.config['SECRET_KEY'] = SECRET_KEY

mysql = MySQL() # create mysql
mysql.init_app(app) # init w app
init_mysql(mysql) # inject into views
app.register_blueprint(views) # register routes

if __name__ == '__main__':
    app.run(debug=True) 