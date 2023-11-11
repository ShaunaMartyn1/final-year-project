from typing import Any
from django.contrib.auth.base_user import AbstractBaseUser
from django.db import models
from django.contrib.auth.models import User, AbstractUser
from django.http.request import HttpRequest #default user from models.py 



class User(AbstractUser):
    email=models.EmailField(unique=True)#an email address can only be registered once
    

"""from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend

class EmailBackend(ModelBackend):
    def authenticate(self, request, username = None, password= None , **kwargs):
        UserModel =get_user_model()
    
    try: 
        user = UserModel.objects.get(username=username)#if it exists return username
    except UserModel.DoesNotExist:
        try:
            user = UserModel.objects.get(email = username)
        except UserModel.DoesNotExist:
            UserModel().set_password(password)
        else:
            if user.check_password(password) and self.user_can_authenticate(user):
             return user
    else:
        if user.check_password(password) and self.user_can_authenticate(user):
            return user
        """
###NEW CHANGED CODE - PREVIOUS CODE ABOVE HAS ERRORS      
from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend

class EmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        UserModel = get_user_model()
        
        try: 
            user = UserModel.objects.get(username=username) # try to find user by username (email)
        except UserModel.DoesNotExist:
            try:
                user = UserModel.objects.get(email=username) # try to find user by email
            except UserModel.DoesNotExist:
                user = None # user not found, set user to None

        if user and user.check_password(password) and self.user_can_authenticate(user):
            return user # user found and password is correct, return user

        return None # authentication failed, return None

            
    
    
    
    