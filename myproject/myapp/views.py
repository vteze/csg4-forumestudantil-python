from rest_framework import generics
from .models import Post
from .serializers import PostSerializer
from django.shortcuts import render

def postsDestaque(request):
    return render(request, 'myapp/postsDestaque.html')

def mainPage(request):
    return render(request, 'myapp/mainPage.html')
