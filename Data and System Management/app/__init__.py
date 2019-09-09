from flask import Flask
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from config import Config


bootstrap = Bootstrap()
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    Config.init_app(app)

    bootstrap.init_app(app)
    db.init_app(app)

    with app.app_context():
        db.create_all()
        db.session.commit()


    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app



