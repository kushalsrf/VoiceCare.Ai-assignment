from fastapi import APIRouter

router = APIRouter()

@router.get("/users")
async def list_users():
    return {
        "users": [],
        "message": "User service reachable"
    }
