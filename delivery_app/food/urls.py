from django.urls import path, include
from .views import (FoodListView, CategoryListView, RestaurantListView, SearchResult)

#Links to show data as Json - http://127.0.0.1:8000/food/restaurantlist
urlpatterns = [
    path('foodlist', FoodListView.as_view(),),
    path('categorylist', CategoryListView.as_view(),),
    path('restaurantlist', RestaurantListView.as_view(),),
    path('<search>', SearchResult.as_view(),),#check this
    
]