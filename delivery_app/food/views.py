from django.shortcuts import render
from django.db.models import Q
from rest_framework import generics
from .models import Food, Category, Restaurant
from .serializers import FoodSerializer, CategorySerializer, RestaurantSerializer

#List of views to be read from 

class SearchResult(generics.ListAPIView):
    queryset=Food.objects.all()
    serializer_class=FoodSerializer
    def get(self, request, *args, **kwargs):
        print(kwargs['search'])
        
        SearchResult.queryset=Food.objects.filter(Q(name__icontains=kwargs['search']) |
                                                  Q(category__name__icontains=kwargs['search']) |
                                                  Q(restaurant__name__icontains=kwargs['search']) 
                                                )
                                                  
        return self.list(request, *args, **kwargs)

class FoodListView(generics.ListAPIView):
    queryset=Food.objects.all()
    serializer_class=FoodSerializer
    
class CategoryListView(generics.ListAPIView):
    queryset=Category.objects.all()
    serializer_class = CategorySerializer
    
class RestaurantListView(generics.ListAPIView):
    queryset=Restaurant.objects.all()
    serializer_class=RestaurantSerializer

