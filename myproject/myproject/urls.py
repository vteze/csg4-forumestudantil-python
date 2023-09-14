from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    # Include your app's URLs here
    path('admin/', admin.site.urls),
    path('api/', include('myapp.urls')),
    path('', include('myapp.urls')),
]
