from django.urls import path
from . import views

urlpatterns = [
    path('postsDestaque/', views.postsDestaque, name='postsDestaque'),
    path('', views.mainPage, name='mainPage'),
]
