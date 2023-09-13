from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()

    def __str__(self):
        return self.title

    class Meta:
        app_label = 'myapp'  # Specify the app_label here
