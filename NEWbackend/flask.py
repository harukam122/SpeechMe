from requests import request
from sptotxt.flask import Flask
from transcribe import GetScore
import os


app = Flask(__name__)

@app.route('/text', methods=['POST'])
def text():
    text = request.text["text"]



@app.route('/audio', methods=['POST'])
def audio():
    audio_file = request.files["file"]
    file_name = "recording.wav"
    audio_file.save(file_name)

    score = GetScore("some word", audio_file, 'b8c4374e49ae4dc2b75626b5b9052d0f')

    os.remove(file_name)

    data = {""}