# SpeechMe!

An app for those who want to check their pronounciation of English words...


## Inputs
 blah blha
 

## Usage:

If your AssemblyAI API key is stored as an environment variable called `AAI_API_KEY` file, then you can omit the optional `--api_key` argument.

```console
$ python transcribe.py audio_file [--local] [--api_key=<YOUR-API-KEY>"]
```

Example for hosted file:

```console
$ python transcribe.py https://github.com/AssemblyAI-Examples/assemblyai-and-python-in-5-minutes/raw/main/audio.mp3 --api_key=<YOUR-API-KEY>
```

Example for local file:

```console
$ python transcribe.py audio.mp3 --local --api_key=<YOUR-API-KEY>
```
