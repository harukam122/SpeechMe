import requests


URL = "http://127.0.0.1:5000/audio"
TEST_AUDIO_FILE_PATH = "dog.mp3"

if __name__ == "__main__":
    audio_file = open(TEST_AUDIO_FILE_PATH, "rb")
    values= {"file": (TEST_AUDIO_FILE_PATH, audio_file, )}
    response = requests.post(URL, files=values)
