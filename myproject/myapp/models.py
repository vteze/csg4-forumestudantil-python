from django.db import models

class aaaa(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()

    def __str__(self):
        return self.title

    class Meta:
        app_label = 'myapp'  # Specify the app_label here

class Posts(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    user_id = models.IntegerField()

class Comments(models.Model):
    content = models.TextField()
    user_id = models.IntegerField()
    post_id = models.ForeignKey(Posts, on_delete=models.CASCADE)
    response_to = models.ForeignKey(Comments, on_delete=models.CASCADE)
    created_at = models.DateField(false, true)

class Interactions(models.Model):
    positive = models.BooleanField()
    user_id = models.IntegerField()
    post_id = models.ForeignKey(Posts, on_delete=models.CASCADE)
    comment_id = models.ForeignKey(Comments, on_delete=models.CASCADE)
    created_at = models.DateField(false, true)
