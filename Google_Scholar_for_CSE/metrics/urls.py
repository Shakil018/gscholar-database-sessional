from django.urls import path

from metrics import views

app_name = 'metrics'

urlpatterns = [
    path('', views.index, name="index"),

]
