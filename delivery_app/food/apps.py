from django.apps import AppConfig


class FoodConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "food"

####### new all above is working 

###BELOW NOT WORKING - SWAGGER API DOCUMENT

"""from fastapi import FastAPI
import httpx

app = FastAPI()

@app.get("/food/foodlist", response_model=dict)
async def read_food_list():
    
    Retrieve a list of food items from an external API.

    Returns:
        dict: API data.
   
    api_url = "http://127.0.0.1:8000/food/foodlist"  #API endpoint URL

    async with httpx.AsyncClient() as client:
        response = await client.get(api_url)

        if response.status_code == 200:
            api_data = response.json()
            return {"data": api_data}
        else:
            return {"error": f"Failed to fetch data. Status code: {response.status_code}"}

# To generate Swagger documentation, you can run the FastAPI application
if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)
"""

