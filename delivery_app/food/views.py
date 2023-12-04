"""from django.shortcuts import render
from django.db.models import Q
from rest_framework import generics
from .models import Food, Category, Restaurant
from .serializers import FoodSerializer, CategorySerializer, RestaurantSerializer
from django.urls import path, include

#List of views to be read from 

#search for a keyword 
class SearchResult(generics.ListAPIView):
    queryset=Food.objects.all()
    serializer_class=FoodSerializer
    
    def get(self, request, *args, **kwargs):
        print(kwargs['search'])
        
        SearchResult.queryset=Food.objects.filter(
            Q(name__icontains=kwargs['search']) |
            Q(category__name__icontains=kwargs['search']) |
            Q(restaurant__name__icontains=kwargs['search']) 
        )
                                                  
        return self.list(request, *args, **kwargs)
    
    #Search for a category
    class FoodByCategory(generics.ListAPIView):
         queryset=Food.objects.all()
    serializer_class=FoodSerializer
    def get(self, request, *args, **kwargs):
        #print(kwargs['category'])
        
        FoodByCategory.queryset= Food.objects.filter(_category__name__contains=kwargs['category'])                                           
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
    """
from django.shortcuts import render
from django.db.models import Q
from rest_framework import generics
from .models import Food, Category, Restaurant
from .serializers import FoodSerializer, CategorySerializer, RestaurantSerializer
from django.urls import path, include

# List of views to be read from

# Search for a keyword
class SearchResult(generics.ListAPIView):
    queryset = Food.objects.all()
    serializer_class = FoodSerializer

    def get(self, request, *args, **kwargs):
        print(kwargs['search'])

        SearchResult.queryset = Food.objects.filter(
            Q(name__icontains=kwargs['search']) |
            Q(category__name__icontains=kwargs['search']) |
            Q(restaurant__name__icontains=kwargs['search'])
        )

        return self.list(request, *args, **kwargs)


# Search for a category
class FoodByCategory(generics.ListAPIView):
    queryset = Food.objects.all()
    serializer_class = FoodSerializer

    def get(self, request, *args, **kwargs):
        # print(kwargs['category'])

        FoodByCategory.queryset = Food.objects.filter(category__name__contains=kwargs['category'])
        return self.list(request, *args, **kwargs)

class FoodListView(generics.ListAPIView):
    queryset = Food.objects.all()
    serializer_class = FoodSerializer

class CategoryListView(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class RestaurantListView(generics.ListAPIView):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer

# Links to show data as JSON - http://127.0.0.1:8000/food/restaurantlist
urlpatterns = [
    path('foodlist', FoodListView.as_view()),
    path('categorylist', CategoryListView.as_view()),
    path('restaurantlist', RestaurantListView.as_view()),
    path('search/<search>', SearchResult.as_view()),
    path('category/<category>', FoodByCategory.as_view()),
]


