from django.shortcuts import render

# Create your views here.

def register_step1(request):
    return render(request, 'registration/register_step1.html', {})

def register_step2(request):
    return render(request, 'registration/register_step2.html', {})


def register_step3(request):
    return render(request, 'registration/register_step3.html', {})
