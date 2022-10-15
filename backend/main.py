from transcribe import GetScore
import os

def main():
    filepath = 'backend/dog.mp3'
    os.system("export AAI_API_KEY=b8c4374e49ae4dc2b75626b5b9052d0f")
    print(GetScore("dogs", filepath, 'b8c4374e49ae4dc2b75626b5b9052d0f'))
    return

if __name__ == '__main__':
    main()