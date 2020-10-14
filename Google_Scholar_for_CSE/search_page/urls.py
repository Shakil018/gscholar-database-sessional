from django.urls import path

from search_page import views

app_name = 'search_page'

urlpatterns = [
    path('', views.list_jobs, name='index'),
    path('search_result/', views.search_result, name='search_result'),
]
