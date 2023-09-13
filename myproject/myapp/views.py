from rest_framework import generics
from .models import Post
from .serializers import PostSerializer

class PostsDestaqueView(generics.ListAPIView):
    queryset = Post.objects.all()  # You can customize this queryset as needed
    serializer_class = PostSerializer