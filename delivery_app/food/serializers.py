from rest_framework import serializers
from .models import Food


class FoodSerializer(serializers.ModelSerializer):
    restaurant=serializers.StringRelatedField()#return restaurant name as a string and not a number in Json
    category=serializers.StringRelatedField()#return category name as a string and not a number in Json
    class Meta:
        model=Food
        fields=('id', 'name', 'price', 'discount', 'restaurant', 'category', 'image', 'preview')