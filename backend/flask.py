from requests import request
from flask import Flask, jsonoify
from transcribe import GetScore
import os
import base64

app = Flask(__name__)

@app.route('/text', methods=['POST'])
def text():
    text = request.text["text"]



@app.route('/audio', methods=['POST'])
def audio():
    audio_file = request.files["file"]
    file_name = "recording.wav"
    wav_file = open("temp.wav", "wb")
    decode_string = base64.b64decode(audio_file)
    wav_file.write(decode_string)
    audio_file.save(file_name)

    score = GetScore("some word", audio_file, 'b8c4374e49ae4dc2b75626b5b9052d0f')

    os.remove(file_name)

    data = {"score" : score}
    return jsonoify(data)

if __name__ == "__main__":
    app.run(debug=False)