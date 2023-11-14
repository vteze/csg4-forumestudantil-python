from rest_framework import viewsets
from .models import Post
from .serializers import PostSerializer
from django.shortcuts import render
from drf_yasg.utils import swagger_auto_schema
from rest_framework.decorators import api_view


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
