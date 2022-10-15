from django.shortcuts import render
from django.http import HttpResponse
from os import path

# Create your views here.
def index(request):
    return render(request, 'index.html')

def find_simiarlies(request):
    return HttpResponse(0.0)

def transcribe(request): 
    return HttpResponse("word")