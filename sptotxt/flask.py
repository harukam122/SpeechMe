from requests import request
from sptotxt.flask import Flask
from main import main


app = Flask(__name__)

@app.route('/audio', methods=['POST'])
def post():
    audio_file = request.files["file"]
    file_name = "recording.wav"
    audio_file.save(file_name)

    

