from rest_framework import viewsets
from .models import Post, discussions_collection
from .serializers import PostSerializer
from django.shortcuts import render
from drf_yasg.utils import swagger_auto_schema
from rest_framework.decorators import api_view
from django.http import HttpResponse


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class PostsViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class CommentsViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class InteractionsViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


@api_view(["GET"])
def mainPage(request):
    return render(request, "myapp/mainPage.html")


@api_view(["GET"])
def postsDestaque(request):
    return render(request, "myapp/postsDestaque.html")


@api_view(["GET"])
def discussoesAlunos(request):
    return render(request, "myapp/discussoesAlunos.html")


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")


def add_discussion(request):
    content = request.POST.get("content")
    discussions_collection.insert_one({"content": content})
    return HttpResponse("Discussion " + f"{content} added successfully")


def get_discussions(request):
    discussions = discussions_collection.find()
    return render(discussions)
