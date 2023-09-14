from rest_framework import generics
from .models import Post
from .serializers import PostSerializer
from django.shortcuts import render

def mainPage(request):
    return render(request, 'myapp/mainPage.html')

def postsDestaque(request):
    return render(request, 'myapp/postsDestaque.html')

def discussoesAlunos(request):
    return render(request, 'myapp/discussoesAlunos.html')