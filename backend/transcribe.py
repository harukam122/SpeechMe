import argparse
import os
import utils
from find_similarities import find_similarities
import json
import re
import string

def GetScore(start_word, filepath, api_key):

    # Create header with authorization along with content-type
    header = {
        'authorization': api_key,
        'content-type': 'application/json'
    }

    # Uploading to AssemblyAI
    upload_url = utils.upload_file(filepath, header)

    # Request a transcription
    transcript_response = utils.request_transcript(upload_url, header)

    # Create a polling endpoint that will let us check when the transcription is complete
    polling_endpoint = utils.make_polling_endpoint(transcript_response)

    # Wait until the transcription is complete
    utils.wait_for_completion(polling_endpoint, header)

    # Request the paragraphs of the transcript
    paragraphs = utils.get_paragraphs(polling_endpoint, header)
    string = paragraphs[0]['text']
    text = string[:-1]

    return find_similarities(start_word, text)

def GetFirstWord():
    #TODO

    return