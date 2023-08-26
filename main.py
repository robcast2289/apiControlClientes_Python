from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import routers

app = FastAPI()
app.include_router(routers.UserRouter.router)

origins = [
    "http://localhost",
    "http://localhost:8888",
    "http://localhost:8080",
    "http://localhost:4200",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def index():
    return "Api funcionando"
