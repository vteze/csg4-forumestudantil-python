from django.urls import path
from .views import PostsDestaqueView

urlpatterns = [
    path('postsDestaque/', PostsDestaqueView.as_view(), name='postsDestaque'),
]
