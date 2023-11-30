from django.shortcuts import render
from rest_framework import generics
from .models import Food, Category, Restaurant
from .serializers import FoodSerializer, CategorySerializer, RestaurantSerializer

#List of views to be read from 

class FoodListView(generics.ListAPIView):
    queryset=Food.objects.all()
    serializer_class=FoodSerializer
    
class CategoryListView(generics.ListAPIView):
    queryset=Category.objects.all()
    serializer_class = CategorySerializer
    
class RestaurantListView(generics.ListAPIView):
    queryset=Restaurant.objects.all()
    serializer_class=RestaurantSerializer

