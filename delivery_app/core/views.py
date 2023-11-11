from django.shortcuts import render
from django.http.response import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
@csrf_exempt
def aPage(request):
    user:User=User.objects.get(pk=1)##primary key is 1
    username = request.POST.get("username")
    email = request.POST.get("email")
    print(email)
    print(username)
    return JsonResponse({"UserName": username, 
                         "email": email})#return username and email in json format