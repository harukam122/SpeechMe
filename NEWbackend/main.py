from transcribe import GetScore
import os

def main():
    filepath = 'dog.mp3'
    os.system("export AAI_API_KEY=b8c4374e49ae4dc2b75626b5b9052d0f")
    score = GetScore("dogs", filepath, 'b8c4374e49ae4dc2b75626b5b9052d0f')
    print("score = " + str(int(100 *score)))
    return int(100 * score)

if __name__ == '__main__':
    main()