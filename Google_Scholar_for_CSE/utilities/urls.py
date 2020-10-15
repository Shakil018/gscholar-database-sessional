from django.urls import path

from utilities import views

app_name = 'utilities'

urlpatterns = [
    path('', views.index, name='index'),
]
