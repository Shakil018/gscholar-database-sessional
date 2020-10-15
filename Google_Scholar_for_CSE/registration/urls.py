from django.urls import path

from registration import views

app_name = 'registration'

urlpatterns = [
    path('', views.register_step1, name="register_step1"),
    path('register2/', views.register_step2, name='register_step2'),
    path('register3/', views.register_step3, name='register_step3'),

]
