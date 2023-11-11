from django.urls import path, include

from .views import FoodListView

urlpatterns = [
    path('foodlist', FoodListView.as_view(),),
]