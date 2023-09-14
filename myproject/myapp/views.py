from rest_framework import generics
from .models import Post
from .serializers import PostSerializer
from django.shortcuts import render

class PostsDestaqueView(generics.ListAPIView):
    queryset = Post.objects.all()  # You can customize this queryset as needed
    serializer_class = PostSerializer

def posts_destaque(request):
    return render(request, 'myapp/postsDestaque.html')
