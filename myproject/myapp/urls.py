from django.urls import path
from . import views

urlpatterns = [
    path('postsDestaque/', views.posts_destaque, name='postsDestaque'),
]
