from django.urls import path

from advanced_search import views

app_name = 'advanced_search'

urlpatterns = [
    path('', views.index, name="index"),

]
