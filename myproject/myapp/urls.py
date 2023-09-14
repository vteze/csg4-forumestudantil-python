from django.urls import path
from . import views

urlpatterns = [
    path('', views.mainPage, name='mainPage'),
    path('postsDestaque/', views.postsDestaque, name='postsDestaque'),
    path('discussoesAlunos/', views.discussoesAlunos, name='discussoesAlunos'),
]
