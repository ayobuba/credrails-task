from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
app.config.from_object("config.Config")
db = SQLAlchemy(app)

migrate = Migrate(app, db)


class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    author = db.Column(db.String(80), nullable=False)

    def __repr__(self):
        return '<Book %r>' % self.title


# with app.app_context():
#     db.create_all()


@app.route('/books', methods=['POST'])
def add_book():
    data = request.get_json()
    new_book = Book(title=data['title'], author=data['author'])
    db.session.add(new_book)
    db.session.commit()
    return jsonify({'message': 'Book added successfully'}), 201


@app.route('/books', methods=['GET'])
def get_books():
    books = Book.query.all()
    return jsonify({'books': [{'id': book.id, 'title': book.title, 'author': book.author} for book in books]}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
