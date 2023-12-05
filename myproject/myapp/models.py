from django.db import models
from db_connection import db

discussions_collection = db["discussion"]


class Meta:
    app_label = "myapp"


class Post(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    user_id = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)


class Posts(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    user_id = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)


class Comments(models.Model):
    content = models.TextField()
    user_id = models.IntegerField()
    post_id = models.ForeignKey(Posts, on_delete=models.CASCADE)
    response_to = models.ForeignKey("self", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)


class Interactions(models.Model):
    positive = models.BooleanField()
    user_id = models.IntegerField()
    post_id = models.ForeignKey(Posts, on_delete=models.CASCADE)
    comment_id = models.ForeignKey(Comments, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
