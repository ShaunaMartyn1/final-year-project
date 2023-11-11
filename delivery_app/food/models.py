from django.db import models

class Category(models.Model):#subject
    name = models.CharField(max_length=255)  
    
    def __str__(self):
        return self.name
    
class Restaurant(models.Model):#author
    name = models.CharField(max_length=500)
    
    def __str__(self):
        return self.name
    
class Food(models.Model):
    name = models.CharField(max_length=500)
    price=models.IntegerField()
    discount=models.IntegerField()
    image=models.ImageField(null=True)
    preview=models.FileField(null=True)
    category = models.ForeignKey(Category, on_delete=models.PROTECT, null=True)#if deleted(subject)
    restaurant = models.ForeignKey(Restaurant, on_delete=models.PROTECT, null=True)#author
    
    def __str__(self):
        return self.name
    

    
