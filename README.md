# SpeechMe 💬

An accessible, easy-to-use iOS app providing an alternative to expensive speech therapy.
[**Watch Our Demo**](https://www.youtube.com/watch?v=oIBHy5szaJU&t=1s)

<div align="center">
  <img src="https://user-images.githubusercontent.com/90530370/196085531-49d9fb96-15b7-4a7a-a97b-289296f537de.png" width="200">
  <img src="https://user-images.githubusercontent.com/90530370/196085530-8bd853e4-58a9-4a35-a759-5b363e5d4f8a.png" width="200">
  <img src="https://user-images.githubusercontent.com/90530370/196085532-8bf8a735-5a36-450d-881f-e48040a33e2e.png" width="200">
  <img src="https://user-images.githubusercontent.com/90530370/196085533-424125b9-7020-438a-b4ab-322f423dea1a.png" width="200">
</div>

## Inspiration ✨

Nearly 10% of all children experience speech-related disorders. But speech therapy can cost more than $31,000 each year. What if there was a simple, accessible, and affordable alternative to practicing speech/pronunciation?

## What it does 💡

SpeechMe provides an intuitive way to practice speech without spending $100 ~ $150 each year on speech therapists. It is an iOS app that allows the user to input a word to practice along with a recording of their pronunciation using our user-friendly interface, then gives feedback on the input audio using our backend algorithm.

## How we built it 🛠

Our program architecture consists of three main components:

1. Swift Frontend
2. Python Backend API
3. Python Backend Analyzer

The usual flow of a use case is as follows:

The Swift frontend prompts the user for an input word that the user wants to practice, then allows them to record an audio file. The frontend takes these inputs and sends them to our backend API in a POST request as multi-part form data. 

Our Flask API receives this data and sends the audio file to AssemblyAI’s audio-to-text API. Once it receives the text version of the input audio, our backend analyzer takes in the two strings (user input word and text-converted version of the input audio) and runs the Jaro-Winkler algorithm. This algorithm returns a similarity score between 0 and 1, which we scale into an integer from 0 ~ 100 to be then returned to the frontend.

Lastly, the frontend takes the return value from the POST request and displays it to the user as the score.

## Challenges we ran into 🙌🏻

Throughout this hackathon, we ran into numerous challenges. With all of us being first-time hackers and not having taken any web-dev courses, our frontend team had never touched iOS development before, and our backend team had no experience in APIs at all. Nevertheless, we decided to take on the challenge!

One of our largest challenges was figuring out how to combine the SwiftUI frontend and the Python backend. Especially with the data transfer our program required from the frontend to the backend, then back to the frontend, we figured we needed to build our own API. Even so, we struggled even more with constructing POST requests to our API. Initially, we attempted to encode the audio file into a string and send JSON data with the input text and the input audio (as a binary string). However, the encoded audio file turned out to be too long, so we had to try to use multi-part form data instead. There was no easy way, however, to construct our data in the correct format for multi-part form data, and unfortunately, we were not able to successfully implement this POST request. Nevertheless, assuming successful integration, our program works as one would expect, and we were able to reach a point much further than we had imagined!

## Accomplishments that we're proud of 💪🏻

We are very proud of our beautiful and clean user interface. It is both intuitive and simple to use, so it can be used both by children and adults. Especially given that this was our frontend team’s first time ever touching iOS development and SwiftUI, we are very proud of what we’ve accomplished! 

We are also proud of creating our very own API for the first time, integrated smoothly with an external API (by AssemblyAI) and a backend that perfectly runs our algorithm on the string returned from the AssemblyAI API. The moment 200 OK showed on our screen was definitely one of our most memorable moments of this hackathon.

## What we learned 🤓

We learned the most we could have ever learned in the span of two days. First, we learned how to use Swift, build an API, use an external API, and the integration process of frontend and backend. On the other hand, we also learned that when we aim high for a project, we must also be ready to pivot or take a slightly different approach at any point throughout the development process. We remained stuck on trying to get our ideal architecture to work, and it perhaps would have helped to think of other ways to make our product come alive.

## What's next for SpeechMe 💭

Our possible future plans are as follows!

1. **Successful backend/frontend integration**: We would love to see our app successfully working with our backend! It would be cool to finally figure out how to organize multi-part form data to send as a POST request.
2. **Personalization**: We would love to implement user personalization! We can have a login feature that saves starred words so that users can go back to saved words later on to practice them more.
3. **Text to Speech**: A text-to-speech feature that plays back what the word should sound like would be a great addition, too.
