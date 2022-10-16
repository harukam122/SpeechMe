
from flask import Flask, jsonify, request
from transcribe import GetScore
import os
import base64

app = Flask(__name__)

# @app.route('/text', methods=['POST'])
# def text():
#     text = request.text["text"]

@app.route('/audio', methods=['POST'])
def audio():

    request.files["audio"].save("recording.wav")
    
    # wav_file = open("temp.wav", "wb")
    # decode_string = base64.b64decode(audio_file)
    # wav_file.write(decode_string)

    score = int(100*GetScore(request.form["text"], "recording.wav", 'b8c4374e49ae4dc2b75626b5b9052d0f'))

    os.system('rm recording.wav')

    data = {"score" : score}
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=False)