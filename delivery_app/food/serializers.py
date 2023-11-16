from rest_framework import serializers
from .models import Food
import base64


class FoodSerializer(serializers.ModelSerializer):
    restaurant=serializers.StringRelatedField()#return restaurant name as a string and not a number in Json
    category=serializers.StringRelatedField()#return category name as a string and not a number in Json
    image_memory = serializers.SerializerMethodField("get_image_memory")
    price_with_discount = serializers.SerializerMethodField("get_price_with_discount")

    
    class Meta:
        model=Food
        fields=('id', 'name', 'price', 'discount', 'restaurant', 'category', 'image', 'preview', 'image_memory',
                'price_with_discount')
        
    def get_image_memory(request, food:Food):#send image of food item
        with open(food.image.name, 'rb') as loadedfile:   
            return base64.b64encode(loadedfile.read())
        return
    def get_price_with_discount(request, food:Food):
        return food.price - (food.discount/100) * food.price 
    
    