from rest_framework import serializers
from .models import Post, Posts, Comments, Interactions


class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ("title", "content", "user_id", "created_at")


class PostsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Posts
        fields = ("title", "content", "user_id", "created_at")


class CommentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comments
        fields = ("content", "user_id", "post_id", "response_to", "created_at")


class InteractionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Interactions
        fields = ("positive", "user_id", "post_id", "comment_id", "created_at")
