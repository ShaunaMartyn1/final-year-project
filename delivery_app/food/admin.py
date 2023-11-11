from django.contrib import admin

from .models import Category, Restaurant, Food

admin.site.register(Category)
admin.site.register(Restaurant)
admin.site.register(Food)
